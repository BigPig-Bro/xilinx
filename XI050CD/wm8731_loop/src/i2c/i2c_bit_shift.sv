// I2C位操作模块（SCL 400kHz）
//260826    v1.0.0   初始版本（从Cyclone wm8731_loop移植至Xilinx XI050CD，SYS_CLOCK改为25MHz）
//260826    v1.1.0   按代码风格重构：typedef enum状态机/logic/同步复位

module i2c_bit_shift #(
    parameter SYS_CLOCK = 25_000_000, //系统时钟 25MHz
    parameter SCL_CLOCK = 40_000      //I2C时钟 400kHz
)(
    input               i_clk,          //系统时钟
    input               i_rst_n,        //复位，低有效

    input  [5:0]        i_cmd,          //控制命令
    input               i_go,           //启动传输
    output logic [7:0]  o_rx_data,      //接收数据
    input  [7:0]        i_tx_data,      //发送数据
    output logic        o_trans_done,   //传输完成
    output logic        o_ack,          //应答状态

    output logic        o_i2c_sclk,     //I2C时钟
    inout               io_i2c_sdat     //I2C数据
);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////                 内部信号                /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
localparam SCL_CNT_M = SYS_CLOCK/SCL_CLOCK/4 - 1;

logic        sdat_out;   //I2C数据输出寄存器
logic        sdat_oe;    //I2C数据输出使能
logic [19:0] div_cnt;    //分频计数
logic        en_div_cnt; //分频计数使能
logic        sclk_plus;  //分频周期脉冲

localparam WR   = 6'b000001; //写请求
localparam STA  = 6'b000010; //起始位请求
localparam RD   = 6'b000100; //读请求
localparam STO  = 6'b001000; //停止位请求
localparam ACK  = 6'b010000; //应答位请求
localparam NACK = 6'b100000; //无应答请求

typedef enum logic [2:0] {
    IDLE,
    GEN_STA,
    WR_DATA,
    RD_DATA,
    CHECK_ACK,
    GEN_ACK,
    GEN_STO
} state_i2c_t;
state_i2c_t state;

logic [4:0] cnt;

assign io_i2c_sdat = sdat_oe ? sdat_out : 1'bz;
assign sclk_plus   = (div_cnt == SCL_CNT_M);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////             I2C时钟分频               /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
always@(posedge i_clk)begin
    if(!i_rst_n)begin
        div_cnt <= 'd0;
    end else if(en_div_cnt)begin
        if(div_cnt < SCL_CNT_M)
            div_cnt <= div_cnt + 1'b1;
        else
            div_cnt <= 'd0;
    end else begin
        div_cnt <= 'd0;
    end
end

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////              I2C状态机                /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
always@(posedge i_clk)begin
    if(!i_rst_n)begin
        o_rx_data    <= 'd0;
        sdat_oe      <= 1'b0;
        en_div_cnt   <= 1'b0;
        sdat_out     <= 1'b1;
        o_trans_done <= 1'b0;
        o_ack        <= 1'b0;
        state        <= IDLE;
        cnt          <= 'd0;
    end else begin
        case(state)
            IDLE:begin
                o_trans_done <= 1'b0;
                sdat_oe      <= 1'b1;
                if(i_go)begin
                    en_div_cnt <= 1'b1;
                    if(i_cmd & STA)
                        state <= GEN_STA;
                    else if(i_cmd & WR)
                        state <= WR_DATA;
                    else if(i_cmd & RD)
                        state <= RD_DATA;
                    else
                        state <= IDLE;
                end else begin
                    en_div_cnt <= 1'b0;
                    state      <= IDLE;
                end
            end

            GEN_STA:begin
                if(sclk_plus)begin
                    if(cnt == 3'd3)
                        cnt <= 'd0;
                    else
                        cnt <= cnt + 1'b1;
                    case(cnt)
                        0:begin
                            sdat_out <= 1'b1;
                            sdat_oe  <= 1'b1;
                        end
                        1:begin
                            o_i2c_sclk <= 1'b1;
                        end
                        2:begin
                            sdat_out   <= 1'b0;
                            o_i2c_sclk <= 1'b1;
                        end
                        3:begin
                            o_i2c_sclk <= 1'b0;
                        end
                        default:begin
                            sdat_out   <= 1'b1;
                            o_i2c_sclk <= 1'b1;
                        end
                    endcase
                    if(cnt == 3'd3)begin
                        if(i_cmd & WR)
                            state <= WR_DATA;
                        else if(i_cmd & RD)
                            state <= RD_DATA;
                    end
                end
            end

            WR_DATA:begin
                if(sclk_plus)begin
                    if(cnt == 5'd31)
                        cnt <= 'd0;
                    else
                        cnt <= cnt + 1'b1;
                    case(cnt)
                        0,4,8,12,16,20,24,28:begin
                            sdat_out <= i_tx_data[7-cnt[4:2]];
                            sdat_oe  <= 1'b1;
                        end
                        1,5,9,13,17,21,25,29:begin
                            o_i2c_sclk <= 1'b1;
                        end
                        2,6,10,14,18,22,26,30:begin
                            o_i2c_sclk <= 1'b1;
                        end
                        3,7,11,15,19,23,27,31:begin
                            o_i2c_sclk <= 1'b0;
                        end
                        default:begin
                            sdat_out   <= 1'b1;
                            o_i2c_sclk <= 1'b1;
                        end
                    endcase
                    if(cnt == 5'd31)
                        state <= CHECK_ACK;
                end
            end

            RD_DATA:begin
                if(sclk_plus)begin
                    if(cnt == 5'd31)
                        cnt <= 'd0;
                    else
                        cnt <= cnt + 1'b1;
                    case(cnt)
                        0,4,8,12,16,20,24,28:begin
                            sdat_oe    <= 1'b0;
                            o_i2c_sclk <= 1'b0;
                        end
                        1,5,9,13,17,21,25,29:begin
                            o_i2c_sclk <= 1'b1;
                        end
                        2,6,10,14,18,22,26,30:begin
                            o_i2c_sclk <= 1'b1;
                            o_rx_data  <= {o_rx_data[6:0], io_i2c_sdat};
                        end
                        3,7,11,15,19,23,27,31:begin
                            o_i2c_sclk <= 1'b0;
                        end
                        default:begin
                            sdat_out   <= 1'b1;
                            o_i2c_sclk <= 1'b1;
                        end
                    endcase
                    if(cnt == 5'd31)
                        state <= GEN_ACK;
                end
            end

            CHECK_ACK:begin
                if(sclk_plus)begin
                    if(cnt == 3'd3)
                        cnt <= 'd0;
                    else
                        cnt <= cnt + 1'b1;
                    case(cnt)
                        0:begin
                            sdat_oe    <= 1'b0;
                            o_i2c_sclk <= 1'b0;
                        end
                        1:begin
                            o_i2c_sclk <= 1'b1;
                        end
                        2:begin
                            o_ack      <= io_i2c_sdat;
                            o_i2c_sclk <= 1'b1;
                        end
                        3:begin
                            o_i2c_sclk <= 1'b0;
                        end
                        default:begin
                            sdat_out   <= 1'b1;
                            o_i2c_sclk <= 1'b1;
                        end
                    endcase
                    if(cnt == 3'd3)begin
                        if(i_cmd & STO)
                            state <= GEN_STO;
                        else begin
                            state        <= IDLE;
                            o_trans_done <= 1'b1;
                        end
                    end
                end
            end

            GEN_ACK:begin
                if(sclk_plus)begin
                    if(cnt == 3'd3)
                        cnt <= 'd0;
                    else
                        cnt <= cnt + 1'b1;
                    case(cnt)
                        0:begin
                            sdat_oe    <= 1'b1;
                            o_i2c_sclk <= 1'b0;
                            if(i_cmd & ACK)
                                sdat_out <= 1'b0;
                            else if(i_cmd & NACK)
                                sdat_out <= 1'b1;
                        end
                        1:begin
                            o_i2c_sclk <= 1'b1;
                        end
                        2:begin
                            o_i2c_sclk <= 1'b1;
                        end
                        3:begin
                            o_i2c_sclk <= 1'b0;
                        end
                        default:begin
                            sdat_out   <= 1'b1;
                            o_i2c_sclk <= 1'b1;
                        end
                    endcase
                    if(cnt == 3'd3)begin
                        if(i_cmd & STO)
                            state <= GEN_STO;
                        else begin
                            state        <= IDLE;
                            o_trans_done <= 1'b1;
                        end
                    end
                end
            end

            GEN_STO:begin
                if(sclk_plus)begin
                    if(cnt == 3'd3)
                        cnt <= 'd0;
                    else
                        cnt <= cnt + 1'b1;
                    case(cnt)
                        0:begin
                            sdat_out <= 1'b0;
                            sdat_oe  <= 1'b1;
                        end
                        1:begin
                            o_i2c_sclk <= 1'b1;
                        end
                        2:begin
                            sdat_out   <= 1'b1;
                            o_i2c_sclk <= 1'b1;
                        end
                        3:begin
                            o_i2c_sclk <= 1'b1;
                        end
                        default:begin
                            sdat_out   <= 1'b1;
                            o_i2c_sclk <= 1'b1;
                        end
                    endcase
                    if(cnt == 3'd3)begin
                        o_trans_done <= 1'b1;
                        state        <= IDLE;
                    end
                end
            end

            default:begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
