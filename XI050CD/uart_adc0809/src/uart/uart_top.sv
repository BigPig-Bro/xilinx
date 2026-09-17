// ADC0809八通道数据定时串口发送
//260917    v1.0.0   初始版本

module uart_top #(
    parameter P_CLK_FRE   = 25_000_000, //系统时钟频率 Hz
    parameter P_UART_RATE = 115200,     //串口波特率
    parameter P_SEND_FRE  = 2           //串口发送频率 Hz
)(
    input                   i_sys_clk,   //系统时钟
    input                   i_rst_n,     //系统复位

    input      [7:0][7:0]   i_adc_data,  //8通道ADC数据

    output                  o_uart_tx    //串口发送
);

typedef enum logic [1:0] {SEND, WAIT} STATE_LOOP;
STATE_LOOP state;

localparam P_ENG_NUM  = 80;                         //非中文字符数，/N算两个字符
localparam P_CHE_NUM  = 0;                          //中文字符数
localparam P_DATA_NUM = P_CHE_NUM * 3 + P_ENG_NUM;  //中文字符使用UTF8，占用3个字节

//发送内容，ADC数据替换每组"000"的3个字符
logic [P_DATA_NUM * 8 - 1:0] char_data = {"CH0:000   CH1:000   CH2:000   CH3:000   CH4:000   CH5:000   CH6:000   CH7:000  \n"};

logic [31:0] wait_cnt;    //发送间隔计数
logic [ 7:0] send_cnt;    //发送字符计数
logic [ 7:0] send_data;   //待发送字符
logic        send_en;     //发送请求
logic        send_busy;   //发送忙
logic [ 7:0] adc_data_r;  //当前组对应的ADC数据
logic [ 6:0] char_index;  //当前发送字符在字符串中的索引
logic [ 7:0] char_data_r; //当前发送字符

assign char_index = (send_cnt < P_DATA_NUM) ? (P_DATA_NUM - 1 - send_cnt) : 'd0;

/********************************************************************************/
/**************************    当前通道数据锁存    ******************************/
/********************************************************************************/
always@(posedge i_sys_clk)begin
    if(!i_rst_n)begin
        adc_data_r <= 'd0;
    end else begin
        case(send_cnt) //每10个字符对应一个通道，在字符组起始处锁存
            'd0 : adc_data_r <= i_adc_data[0];
            'd10: adc_data_r <= i_adc_data[1];
            'd20: adc_data_r <= i_adc_data[2];
            'd30: adc_data_r <= i_adc_data[3];
            'd40: adc_data_r <= i_adc_data[4];
            'd50: adc_data_r <= i_adc_data[5];
            'd60: adc_data_r <= i_adc_data[6];
            'd70: adc_data_r <= i_adc_data[7];
        endcase
    end
end

/********************************************************************************/
/**************************    发送字符生成        ******************************/
/********************************************************************************/
always@(*)begin
    case(send_cnt % 10)
        'd4:     char_data_r = char_data[char_index * 8 +: 8] + adc_data_r / 100;      //百位
        'd5:     char_data_r = char_data[char_index * 8 +: 8] + adc_data_r / 10 % 10; //十位
        'd6:     char_data_r = char_data[char_index * 8 +: 8] + adc_data_r % 10;      //个位
        default: char_data_r = char_data[char_index * 8 +: 8];
    endcase
end

/********************************************************************************/
/**************************    发送仲裁机制        ******************************/
/********************************************************************************/
always@(posedge i_sys_clk)begin
    if(!i_rst_n)begin
        wait_cnt  <= 'd0;
        send_cnt  <= 'd0;
        send_en   <= 1'b0;
        send_data <= 'd0;

        state     <= WAIT;
    end else begin
        case(state)
            SEND:begin //主动发送
                if(send_cnt >= P_DATA_NUM)begin
                    send_cnt <= 'd0;
                    send_en  <= 1'b0;

                    state    <= WAIT;
                end else if(!send_busy)begin
                    send_en   <= 1'b1;
                    send_data <= char_data_r;
                    send_cnt  <= send_cnt + 1'b1;
                end
            end

            WAIT:begin //等待下一次发送
                if(wait_cnt >= P_CLK_FRE / P_SEND_FRE)begin
                    wait_cnt <= 'd0;

                    state    <= SEND;
                end else begin
                    wait_cnt <= wait_cnt + 1'b1;
                end
            end

            default:begin
                state <= WAIT;
            end
        endcase
    end
end

/********************************************************************************/
/**************************    发送模块例化        ******************************/
/********************************************************************************/
uart_tx #(
    .P_CLK_FRE          (P_CLK_FRE          ),
    .P_UART_RATE        (P_UART_RATE        )
)uart_tx_m0(
    .i_sys_clk          (i_sys_clk          ),
    .i_rst_n            (i_rst_n            ),

    .i_send_en          (send_en            ),
    .o_send_busy        (send_busy          ),
    .i_send_data        (send_data          ),

    .o_tx_pin           (o_uart_tx          )
);

endmodule
