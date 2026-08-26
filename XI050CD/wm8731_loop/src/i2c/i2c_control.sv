// I2C读写控制模块
//260826    v1.0.0   初始版本（从Cyclone wm8731_loop移植至Xilinx XI050CD）
//260826    v1.1.0   按代码风格重构：typedef enum状态机/logic/同步复位

module i2c_control (
    input               i_clk,          //系统时钟
    input               i_rst_n,        //复位，低有效

    input               i_wrreg_req,    //写寄存器请求
    input               i_rdreg_req,    //读寄存器请求
    input  [15:0]       i_addr,         //寄存器地址
    input               i_addr_mode,    //地址模式
    input  [7:0]        i_wrdata,       //写数据
    output logic [7:0]  o_rddata,       //读数据
    input  [7:0]        i_device_id,    //器件地址
    output logic        o_rw_done,      //读写完成
    output logic        o_ack,          //应答状态

    output logic        o_i2c_sclk,     //I2C时钟
    inout               io_i2c_sdat     //I2C数据
);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////                 内部信号                /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
logic [5:0]  cmd;         //I2C位操作命令
logic [7:0]  tx_data;     //发送数据
logic        trans_done;  //传输完成
logic        ack_o;       //从机应答
logic        go;          //启动传输
logic [15:0] reg_addr;    //寄存器地址（按模式交换字节）
logic [7:0]  rx_data;     //接收数据

localparam WR   = 6'b000001; //写请求
localparam STA  = 6'b000010; //起始位请求
localparam RD   = 6'b000100; //读请求
localparam STO  = 6'b001000; //停止位请求
localparam ACK  = 6'b010000; //应答位请求
localparam NACK = 6'b100000; //无应答请求

typedef enum logic [2:0] {
    IDLE,
    WR_REG,
    WAIT_WR_DONE,
    WR_REG_DONE,
    RD_REG,
    WAIT_RD_DONE,
    RD_REG_DONE
} state_i2c_ctrl_t;
state_i2c_ctrl_t state;

logic [7:0] cnt;

assign reg_addr = i_addr_mode ? i_addr : {i_addr[7:0], i_addr[15:8]};

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////              i2c_bit_shift例化         /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
i2c_bit_shift i2c_bit_shift_m0(
    .i_clk         (i_clk        ),
    .i_rst_n       (i_rst_n      ),
    .i_cmd         (cmd          ),
    .i_go          (go           ),
    .o_rx_data     (rx_data      ),
    .i_tx_data     (tx_data      ),
    .o_trans_done  (trans_done   ),
    .o_ack         (ack_o        ),
    .o_i2c_sclk    (o_i2c_sclk   ),
    .io_i2c_sdat   (io_i2c_sdat  )
);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////              I2C控制状态机             /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
always@(posedge i_clk)begin
    if(!i_rst_n)begin
        cmd       <= 6'd0;
        tx_data   <= 8'd0;
        go        <= 1'b0;
        o_rddata  <= 8'd0;
        state     <= IDLE;
        o_ack     <= 1'b0;
    end else begin
        case(state)
            IDLE:begin
                cnt       <= 8'd0;
                o_ack     <= 1'b0;
                o_rw_done <= 1'b0;
                if(i_wrreg_req)
                    state <= WR_REG;
                else if(i_rdreg_req)
                    state <= RD_REG;
                else
                    state <= IDLE;
            end

            WR_REG:begin
                state <= WAIT_WR_DONE;
                case(cnt)
                    0:write_byte(WR | STA, i_device_id);
                    1:write_byte(WR, reg_addr[15:8]);
                    2:write_byte(WR, reg_addr[7:0]);
                    3:write_byte(WR | STO, i_wrdata);
                    default:;
                endcase
            end

            WAIT_WR_DONE:begin
                go <= 1'b0;
                if(trans_done)begin
                    o_ack <= o_ack | ack_o;
                    case(cnt)
                        0:begin
                            cnt   <= 8'd1;
                            state <= WR_REG;
                        end
                        1:begin
                            state <= WR_REG;
                            if(i_addr_mode)
                                cnt <= 8'd2;
                            else
                                cnt <= 8'd3;
                        end
                        2:begin
                            cnt   <= 8'd3;
                            state <= WR_REG;
                        end
                        3:state <= WR_REG_DONE;
                        default:state <= IDLE;
                    endcase
                end
            end

            WR_REG_DONE:begin
                o_rw_done <= 1'b1;
                state     <= IDLE;
            end

            RD_REG:begin
                state <= WAIT_RD_DONE;
                case(cnt)
                    0:write_byte(WR | STA, i_device_id);
                    1:begin
                        if(i_addr_mode)
                            write_byte(WR, reg_addr[15:8]);
                        else
                            write_byte(WR | STO, reg_addr[15:8]);
                    end
                    2:write_byte(WR | STO, reg_addr[7:0]);
                    3:write_byte(WR | STA, i_device_id | 8'd1);
                    4:read_byte(RD | ACK | STO);
                    default:;
                endcase
            end

            WAIT_RD_DONE:begin
                go <= 1'b0;
                if(trans_done)begin
                    if(cnt <= 8'd3)
                        o_ack <= o_ack | ack_o;
                    case(cnt)
                        0:begin
                            cnt   <= 8'd1;
                            state <= RD_REG;
                        end
                        1:begin
                            state <= RD_REG;
                            if(i_addr_mode)
                                cnt <= 8'd2;
                            else
                                cnt <= 8'd3;
                        end
                        2:begin
                            cnt   <= 8'd3;
                            state <= RD_REG;
                        end
                        3:begin
                            cnt   <= 8'd4;
                            state <= RD_REG;
                        end
                        4:state <= RD_REG_DONE;
                        default:state <= IDLE;
                    endcase
                end
            end

            RD_REG_DONE:begin
                o_rw_done <= 1'b1;
                o_rddata  <= rx_data;
                state     <= IDLE;
            end

            default:begin
                state <= IDLE;
            end
        endcase
    end
end

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////                  任务定义                /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
task read_byte;
    input [5:0] ctrl_cmd;
    begin
        cmd <= ctrl_cmd;
        go  <= 1'b1;
    end
endtask

task write_byte;
    input [5:0] ctrl_cmd;
    input [7:0] wr_byte_data;
    begin
        cmd     <= ctrl_cmd;
        tx_data <= wr_byte_data;
        go      <= 1'b1;
    end
endtask

endmodule
