// WM8731 I2C初始化控制模块
//260826    v1.0.0   初始版本（从Cyclone wm8731_loop移植至Xilinx XI050CD）
//260826    v1.1.0   按代码风格重构：typedef enum状态机/logic/同步复位

module i2c_init_dev (
    input               i_clk,          //系统时钟
    input               i_rst_n,        //复位，低有效

    output logic        o_init_done,    //初始化完成
    output logic        o_i2c_sclk,     //I2C时钟
    inout               io_i2c_sdat     //I2C数据
);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////                 内部信号                /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
logic [15:0] addr;       //寄存器地址
logic        wrreg_req;  //写寄存器请求
logic [7:0]  wrdata;     //写数据
logic        rw_done;    //读写完成
logic        ack;        //应答状态

logic [1:0]  cnt_go;     //启动计数
logic        go;         //启动初始化
logic [7:0]  lut_size;   //初始化表数据总数
logic [7:0]  cnt;        //传输次数计数
logic [15:0] lut;        //初始化表数据
logic [7:0]  dev_id;     //器件地址

typedef enum logic [1:0] {
    IDLE,
    WR_REQ,
    WAIT_DONE
} state_init_t;
state_init_t state;

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////              启动计数                 /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
always@(posedge i_clk)begin
    if(!i_rst_n)begin
        cnt_go <= 'd0;
    end else if(cnt_go == 2'd3)begin
        cnt_go <= cnt_go;
    end else begin
        cnt_go <= cnt_go + 1'b1;
    end
end

assign go = (cnt_go == 2'd2);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////             传输计数                  /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
always@(posedge i_clk)begin
    if(!i_rst_n)begin
        cnt <= 8'd0;
    end else if(go)begin
        cnt <= 8'd0;
    end else if(cnt < lut_size)begin
        if(rw_done && (!ack))
            cnt <= cnt + 1'b1;
        else
            cnt <= cnt;
    end else begin
        cnt <= 8'd0;
    end
end

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////             初始化完成                /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
always@(posedge i_clk)begin
    if(!i_rst_n)begin
        o_init_done <= 1'b0;
    end else if(go)begin
        o_init_done <= 1'b0;
    end else if(cnt == lut_size)begin
        o_init_done <= 1'b1;
    end
end

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////             初始化状态机              /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
always@(posedge i_clk)begin
    if(!i_rst_n)begin
        state     <= IDLE;
        wrreg_req <= 1'b0;
    end else if(cnt < lut_size)begin
        case(state)
            IDLE:begin
                if(go)
                    state <= WR_REQ;
                else
                    state <= IDLE;
            end

            WR_REQ:begin
                wrreg_req <= 1'b1;
                state     <= WAIT_DONE;
            end

            WAIT_DONE:begin
                wrreg_req <= 1'b0;
                if(rw_done)
                    state <= WR_REQ;
                else
                    state <= WAIT_DONE;
            end

            default:begin
                state <= IDLE;
            end
        endcase
    end else begin
        state <= IDLE;
    end
end

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////            wm8731_init_table例化       /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
wm8731_init_table wm8731_init_table_m0(
    .i_addr     (cnt     ),
    .i_clk      (i_clk   ),
    .o_q        (lut     ),
    .o_dev_id   (dev_id  ),
    .o_lut_size (lut_size)
);

assign addr   = lut[15:8];
assign wrdata = lut[7:0];

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////              i2c_control例化           /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
i2c_control i2c_control_m0(
    .i_clk        (i_clk       ),
    .i_rst_n      (i_rst_n     ),
    .i_wrreg_req  (wrreg_req   ),
    .i_rdreg_req  (1'b0        ),
    .i_addr       (addr        ),
    .i_addr_mode  (1'b0        ),
    .i_wrdata     (wrdata      ),
    .o_rddata     (            ),
    .i_device_id  (dev_id      ),
    .o_rw_done    (rw_done     ),
    .o_ack        (ack         ),
    .o_i2c_sclk   (o_i2c_sclk  ),
    .io_i2c_sdat  (io_i2c_sdat )
);

endmodule
