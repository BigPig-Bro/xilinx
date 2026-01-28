module sdram_test_top#(
    parameter ADDR_WIDTH        = 24,
    parameter MEM_DATA_WIDTH    = 16,
    parameter BUSRT_WIDTH       = 6
)(
    input                                   i_sys_clk,
    input                                   i_sys_rst,

    output logic                            o_wr_error,
    
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

localparam BURST_SIZE            = 128 ;            //burst size full page
localparam ADDR_WR_MAX           = BURST_SIZE * 4; //测试地址最大值，16次突发


typedef enum logic [3:0] {IDLE, WRITE, WRITE_DONE, READ, READ_DONE } STATE_MAIN_t;
STATE_MAIN_t state_main;

logic [MEM_DATA_WIDTH * 8 - 1 : 0] write_check, read_check; 
logic [ADDR_WIDTH - 1 : 0] write_addr, read_addr;

//写状态机
always@(posedge i_sys_clk)begin
    if(i_sys_rst)begin
        write_check     <= 'd1;
        write_addr      <= 'd0;
        read_addr       <= 'd0;

        o_wr_burst_addr   <= 'd0;
        o_wr_burst_len    <= 'd0;
        o_wr_burst_req    <= 1'b0;
        o_wr_burst_data   <= 'd1;

        state_main <= IDLE;
    end else begin
        case(state_main)
            IDLE: begin
                write_addr      <= 'd0;
                read_addr       <= 'd0;
                write_check     <= 'd1;

                o_wr_burst_addr   <= write_addr;
                state_main <= WRITE;
            end

            WRITE: begin 
                if(i_wr_burst_data_req) begin
                    o_wr_burst_len    <= BURST_SIZE; //BL8
                    o_wr_burst_data   <= write_check;

                    write_check     <= write_check + 'd1;
                end

                if (i_wr_burst_finish)begin
                    o_wr_burst_addr   <= o_wr_burst_addr  + BURST_SIZE;
                end 

                if((o_wr_burst_addr >= ADDR_WR_MAX - BURST_SIZE) && i_wr_burst_finish) begin
                    o_wr_burst_req    <= 1'b0;
                    state_main     <= WRITE_DONE;
                end else begin
                    o_wr_burst_req    <= 1'b1;
                end
            end

            WRITE_DONE: begin
                o_rd_burst_addr    <= 'd0;
                o_rd_burst_len    <= BURST_SIZE; 
                state_main      <= READ;
            end

            READ:begin
                if (i_rd_burst_finish)begin
                    o_rd_burst_addr      <= o_rd_burst_addr + BURST_SIZE; 
                end 

                if((o_rd_burst_addr >= ADDR_WR_MAX - BURST_SIZE) && i_rd_burst_finish) begin
                    o_rd_burst_req    <= 1'b0;
                    state_main     <= READ_DONE;
                end else begin
                    o_rd_burst_req    <= 1'b1;
                end
            end

            READ_DONE: begin
                state_main      <= IDLE;
            end

            default: state_main <= IDLE;
        endcase
    end
end

//读校验
always@(posedge i_sys_clk)begin
    if(i_sys_rst)begin
        o_wr_error <= 1'b0;
        read_check <= 'd1;
    end else begin
        if(state_main == IDLE) begin
            read_check <= 'd1;
            o_wr_error <= 1'b0;
        end else if(i_rd_burst_data_valid) begin
            if(i_rd_burst_data != read_check) begin
                o_wr_error <= 1'b1;
            end
            read_check <= read_check + 'd1;
        end
    end
end

ila_0 ila_0_m0(
    .clk           (i_sys_clk                ),
    .probe0        (state_main               ),
    .probe1        (o_rd_burst_req           ),
    .probe2        (o_rd_burst_len           ),
    .probe3        (o_rd_burst_addr          ),
    .probe4        (i_rd_burst_data_valid    ),
    .probe5        (i_rd_burst_data          ),
    .probe6        (i_rd_burst_finish        ),
    .probe7        (o_wr_burst_req           ),
    .probe8        (o_wr_burst_len           ),
    .probe9        (o_wr_burst_addr          ),
    .probe10       (i_wr_burst_data_req      ),
    .probe11       (o_wr_burst_data          ),
    .probe12       (i_wr_burst_finish        ),
    .probe13       (write_check              ), 
    .probe14       (read_check               ),
    .probe15       (o_wr_error               )
);

endmodule