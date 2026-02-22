module sdram_ctrl_top#(
    parameter ADDR_WIDTH        = 24,
    parameter MEM_DATA_WIDTH    = 16,
    parameter BUSRT_WIDTH       = 6
)(
    input                                   i_sys_clk,
    input                                   i_sys_rst,

    input        [1:0]                      i_cam_pclk,     
    input        [1:0]                      i_cam_data_rst,
    input        [1:0]                      i_cam_data_valid,
    input        [1:0][31:0]                i_cam_data_32,
           
    input                                   i_read_rst, 
    input                                   i_read_clk,               
    input        [1:0]                      i_data_req,               
    output logic [1:0][15:0]                o_data_16,                   
    
    //sdram user interface
    output logic                            o_rd_burst_req,                        // to external memory controller,send out a burst read request
	output logic [BUSRT_WIDTH - 1:0]        o_rd_burst_len,                        // to external memory controller,data length of the burst read request, not bytes
	output logic [ADDR_WIDTH - 1:0]         o_rd_burst_addr,                       // to external memory controller,base address of the burst read request 
	input                                   i_rd_burst_data_valid,                 // from external memory controller,read data valid 
	input        [MEM_DATA_WIDTH - 1:0]     i_rd_burst_data,                       // from external memory controller,read request data
	input                                   i_rd_burst_finish,                     // from external memory controller,burst read finish

    output logic                            o_wr_burst_req,                        // to external memory controller,send out a burst write request
	output logic [BUSRT_WIDTH - 1:0]        o_wr_burst_len,                        // to external memory controller,data length of the burst write request, not bytes
	output logic [ADDR_WIDTH - 1:0]         o_wr_burst_addr,                       // to external memory controller,base address of the burst write request 
	input                                   i_wr_burst_data_req,                   // from external memory controller,write data request ,before data 1 clock
	output logic [MEM_DATA_WIDTH - 1:0]     o_wr_burst_data,                       // to external memory controller,write data
	input                                   i_wr_burst_finish                      // from external memory controller,burst write finish
);

localparam ADDR_WR_MAX           = 640 * 480 / 2;    //每个像素2字节，640*480分辨率的图像占用的内存地址空间为640*480*2字节，因此地址最大值为640*480/2
localparam BURST_SIZE            = 128 ;            //burst size full page


/********************************************************************************/
/*********************   WR   FIFO             **********************************/
/********************************************************************************/  
logic [1:0][31:0] write_fifo_data;
logic [1:0][11:0] write_fifo_cnt;
logic [1:0]       write_fifo_req;
write_fifo write_fifo_m0(
    .rst            (i_cam_data_rst[0]      ),
    .wr_clk         (i_cam_pclk[0]          ),
    .din            (i_cam_data_32[0]       ),
    .wr_en          (i_cam_data_valid[0]    ),

    .rd_clk         (i_sys_clk              ),
    .dout           (write_fifo_data[0]     ),
    .rd_en          (write_fifo_req[0]      ),

    .wr_rst_busy    (                       ),
    .rd_rst_busy    (                       ),
    .rd_data_count  (write_fifo_cnt[0]      )     
);

write_fifo write_fifo_m1(
    .rst            (i_cam_data_rst[1]      ),  
    .wr_clk         (i_cam_pclk[1]          ),
    .din            (i_cam_data_32[1]       ),
    .wr_en          (i_cam_data_valid[1]    ),

    .rd_clk         (i_sys_clk              ),
    .dout           (write_fifo_data[1]     ),
    .rd_en          (write_fifo_req[1]      ),

    .wr_rst_busy    (                       ),
    .rd_rst_busy    (                       ),
    .rd_data_count  (write_fifo_cnt[1]      )     
);

logic [1:0]       read_fifo_valid;
logic [1:0][11:0] read_fifo_cnt;
read_fifo read_fifo_m0(
    .rst            (i_sys_rst             ),
    .wr_clk         (i_sys_clk              ),
    .din            (i_rd_burst_data        ),
    .wr_en          (read_fifo_valid[0]     ),

    .rd_clk         (i_read_clk             ),
    .dout           (o_data_16[0]           ),
    .rd_en          (i_data_req[0]          ),

    .full           (                       ),
    .empty          (                       ),
    .wr_data_count  (read_fifo_cnt[0]       )     
);

read_fifo read_fifo_m1(
    .rst            (i_sys_rst             ),
    .wr_clk         (i_sys_clk              ),
    .din            (i_rd_burst_data        ),
    .wr_en          (read_fifo_valid[1]     ),

    .rd_clk         (i_read_clk             ),
    .dout           (o_data_16[1]           ),
    .rd_en          (i_data_req[1]          ),

    .full           (                       ),
    .empty          (                       ),
    .wr_data_count  (read_fifo_cnt[1]       )     
);

/********************************************************************************/
/*********************   STATE CODE            **********************************/
/********************************************************************************/  
typedef enum logic [3:0] {IDLE, WRITE, READ } STATE_MAIN_t;
STATE_MAIN_t state_main;

logic [1:0][ADDR_WIDTH - 1 : 0] write_addr, read_addr;
logic [1:0]                     addr_sel;
logic [2:0]                     read_cnt;

assign o_wr_burst_len = BURST_SIZE;
assign o_rd_burst_len = BURST_SIZE;
assign write_fifo_req[0] = addr_sel[0] & i_wr_burst_data_req;
assign write_fifo_req[1] = addr_sel[1] & i_wr_burst_data_req;
assign read_fifo_valid[0] = addr_sel[0] & i_rd_burst_data_valid;
assign read_fifo_valid[1] = addr_sel[1] & i_rd_burst_data_valid;
assign o_wr_burst_data = addr_sel[0] ? write_fifo_data[0] : write_fifo_data[1];

always@(posedge i_sys_clk)begin
    if(i_sys_rst)begin
        read_cnt <= 'd0;
        o_wr_burst_req    <= 'b0;
        o_wr_burst_addr   <= 'd0;
        o_rd_burst_req    <= 'b0;
        o_rd_burst_addr   <= 'd0;

        state_main <= IDLE;
    end else begin
        case(state_main)
            IDLE: begin
                if((write_fifo_cnt[0] >= BURST_SIZE) && (write_addr[0] < ADDR_WR_MAX))begin
                    addr_sel          <= 2'b01;
                    o_wr_burst_req    <= 1'b1;
                    o_wr_burst_addr   <= write_addr[0];
                    state_main <= WRITE;
                end else if((write_fifo_cnt[1] >= BURST_SIZE) && (write_addr[1] < (ADDR_WR_MAX * 2))) begin
                    addr_sel          <= 2'b10;
                    o_wr_burst_req    <= 1'b1;
                    o_wr_burst_addr   <= write_addr[1];
                    state_main <= WRITE;
                end else if((read_fifo_cnt[0] <= 640) && (read_addr[0] < ADDR_WR_MAX)) begin
                    addr_sel          <= 2'b01;
                    o_rd_burst_req    <= 1'b1;
                    o_rd_burst_addr   <= read_addr[0];
                    state_main     <= READ;
                end else if((read_fifo_cnt[1] <= 640) && (read_addr[1] < (ADDR_WR_MAX * 2))) begin
                    addr_sel          <= 2'b10;
                    o_rd_burst_req    <= 1'b1;
                    o_rd_burst_addr   <= read_addr[1];
                    state_main     <= READ;
                end else begin
                    read_cnt          <= 'd0;
                    addr_sel          <= 2'b00;
                    o_wr_burst_req    <= 1'b0;
                    o_rd_burst_req    <= 1'b0;
                end
            end

            WRITE: begin 
                if (i_wr_burst_finish)begin
                    o_wr_burst_req    <= 1'b0;
                    state_main     <= IDLE;
                end 
            end

            READ:begin//每次连续读取，填满2行（640x2刚好为5次突发
                o_rd_burst_addr   <= addr_sel[0] ? read_addr[0] : read_addr[1];

                if (i_rd_burst_finish)begin
                    read_cnt            <= (read_cnt == 3'd4)?  'd0 : read_cnt + 1; //每次burst read完成，read_cnt加1，读满5次（即读满一个帧数据）后，read_cnt重置为0
                    o_rd_burst_req      <= (read_cnt == 3'd4)? 1'b0 : o_rd_burst_req ;
                    state_main          <= (read_cnt == 3'd4)? IDLE : state_main     ;
                end 
            end

            default: state_main <= IDLE;
        endcase
    end
end

//写地址更新逻辑：每次写完一个burst size的数据，就更新一次地址；摄像头vs下降沿时地址重置
logic [1:0] write_fifo_req_d ;
always@(posedge i_sys_clk)begin
    write_fifo_req_d[0] <= write_fifo_req[0];

    if(i_sys_rst || i_cam_data_rst[0] )begin 
        write_addr[0]      <= 'd0;
    end else if(write_fifo_req_d[0] && !write_fifo_req[0]) begin //每次写完一个burst size的数据，就更新一次地址
        write_addr[0]      <= write_addr[0] + BURST_SIZE;
    end

    write_fifo_req_d[1] <= write_fifo_req[1];
    if(i_sys_rst || i_cam_data_rst[1])begin
        write_addr[1]      <= ADDR_WR_MAX;
    end else if(write_fifo_req_d[1] && !write_fifo_req[1]) begin //每次写完一个burst size的数据，就更新一次地址
        write_addr[1]      <= write_addr[1] + BURST_SIZE;
    end
end

//读地址更新逻辑：每次读完一个burst size的数据，就更新一次地址；视频vs下降沿时地址重置
logic [1:0] read_fifo_valid_d, read_fifo_valid_n;
logic i_read_rst_d0;
always@(posedge i_sys_clk)begin
    i_read_rst_d0 <= i_read_rst;
    read_fifo_valid_d[0] <= read_fifo_valid[0];
    read_fifo_valid_n[0] <= read_fifo_valid_d[0] & !read_fifo_valid[0];

    read_fifo_valid_d[1] <= read_fifo_valid[1];
    read_fifo_valid_n[1] <= read_fifo_valid_d[1] & !read_fifo_valid[1];

    if(i_sys_rst || i_read_rst_d0)begin
        read_addr[0]      <= 'd0;
        read_addr[1]      <= ADDR_WR_MAX;
    end else if(read_fifo_valid_n[0]) begin //每次读完一个burst size的数据，就更新一次地址
        read_addr[0]      <= read_addr[0] + BURST_SIZE;
    end else if(read_fifo_valid_n[1]) begin //每次读完一个burst size的数据，就更新一次地址
        read_addr[1]      <= read_addr[1] + BURST_SIZE;
    end
end

/********************************************************************************/
/*********************    Test Code            **********************************/
/********************************************************************************/  
// ila_sdram ila_sdram_m0(
//     .clk            (i_sys_clk              ),
//     .probe0         (i_cam_data_rst[0]      ),
//     .probe1         (i_cam_data_valid[0]    ),  
//     .probe2         (i_cam_data_32[0]       ),
//     .probe3         (write_fifo_cnt[0]      ),
//     .probe4         (write_fifo_req[0]      ),
//     .probe5         (write_fifo_data[0]     ),
//     .probe6         (state_main                 ),
//     .probe7         (o_wr_burst_req             ),
//     .probe8         (o_wr_burst_addr            ),
//     .probe9         (i_wr_burst_data_req        ),
//     .probe10        (o_wr_burst_data            ),
//     .probe11        (i_wr_burst_finish          ),
//     .probe12        (o_rd_burst_req             ),
//     .probe13        (o_rd_burst_addr            ),
//     .probe14        (i_rd_burst_data_valid      ),
//     .probe15        (i_rd_burst_data            ),
//     .probe16        (i_rd_burst_finish          ),
//     .probe17        (write_addr[0]              ),
//     .probe18        (read_addr[0]               )
// );

// logic [ADDR_WIDTH - 1 : 0] write_cnt;
// always@(posedge i_cam_pclk[0])
//     if (i_cam_data_rst[0]) 
//         write_cnt <= 'd0;
//     else if (i_cam_data_valid[0]) 
//         write_cnt <= write_cnt + 1;

// logic write_err;
// logic [ADDR_WIDTH - 1 : 0] write_cnt_d0, write_cnt_d1;
// always@(posedge i_sys_clk)begin
//     write_cnt_d0 <= write_cnt;
//     write_cnt_d1 <= write_cnt_d0;

//     if (i_cam_data_rst[0]) 
//         write_err <= 1'b0;
//     else if ((write_addr[0] > write_cnt_d1) &&  (write_addr[0] > write_cnt_d0))
//         write_err <= 1'b1;
// end

// ila_read ila_read_m0(
//     .clk            (i_sys_clk              ),
//     .probe0         (state_main             ),
//     //读通道
//     .probe1         (i_read_rst             ),
//     .probe2         (read_addr[0]           ),
//     .probe3         (o_rd_burst_addr        ),
//     .probe4         (o_rd_burst_req         ),
//     .probe5         (i_rd_burst_data_valid  ),
//     .probe6         (read_fifo_valid[0]     ),
//     .probe7         (i_rd_burst_finish      ),
//     .probe8         (i_data_req[0]          ),
//     .probe9         (read_fifo_cnt[0]       ),
//     //写通道
//     .probe10        (i_cam_data_rst[0]      ),
//     .probe11        (i_cam_data_valid[0]    ),
//     .probe12        (write_addr[0]          ),
//     .probe13        (o_wr_burst_addr        ),
//     .probe14        (o_wr_burst_req         ),
//     .probe15        (i_wr_burst_data_req    ),
//     .probe16        (write_fifo_req[0]      ),
//     .probe17        (write_fifo_cnt[0]      ),
//     .probe18        (write_cnt_d1           ),

//     .probe19        (addr_sel               ),
//     .probe20        (write_err              )
// );
endmodule