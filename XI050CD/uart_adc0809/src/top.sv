// ADC0809 八通道采集串口发送顶层
//260917    v1.0.0   初始版本

module top (
    input               i_clk_25m,      //系统时钟 25MHz
    input               i_rst_n,        //系统复位，低有效

    output              o_uart_tx,      //串口发送

    //ADC0809硬件接口，接H1排针
    output      [2:0]   o_adc0809_addr, //通道地址
    input       [7:0]   i_adc0809_db,   //转换数据
    output              o_adc0809_oe,   //输出使能
    output              o_adc0809_clk,  //ADC时钟
    output              o_adc0809_st,   //启动转换
    input               i_adc0809_eoc,  //转换结束
    output              o_adc0809_ale   //地址锁存
);

localparam P_CLK_FRE   = 25_000_000; //系统时钟频率 Hz
localparam P_UART_RATE = 115200;     //串口波特率

logic            rst_n_sys;     //boot_rst输出的系统复位
logic [7:0][7:0] adc0809_data;  //8通道ADC数据

/********************************************************************************/
/**************************    boot_rst上电复位    ******************************/
/********************************************************************************/
boot_rst boot_rst_m0(
    .i_clk              (i_clk_25m          ),
    .i_rst_n            (i_rst_n            ),
    .o_rst_n            (rst_n_sys          )
);

/********************************************************************************/
/**************************    ADC0809采集驱动     ******************************/
/********************************************************************************/
adc0809_top #(
    .P_CLK_FRE          (P_CLK_FRE          ),
    .P_ADC_FRE          (50_000             ) //ADC0809采样帧频率 Hz
)adc0809_top_m0(
    .i_sys_clk          (i_clk_25m          ),
    .i_rst_n            (rst_n_sys          ),

    .i_adc_start        (1'b1               ), //一直采集
    .o_adc_done         (                   ),
    .o_adc_data         (adc0809_data       ),

    .o_adc_addr         (o_adc0809_addr     ),
    .i_adc_db           (i_adc0809_db       ),
    .o_adc_oe           (o_adc0809_oe       ),
    .o_adc_clk          (o_adc0809_clk      ),
    .o_adc_st           (o_adc0809_st       ),
    .i_adc_eoc          (i_adc0809_eoc      ),
    .o_adc_ale          (o_adc0809_ale      )
);

/********************************************************************************/
/**************************    串口定时发送        ******************************/
/********************************************************************************/
uart_top #(
    .P_CLK_FRE          (P_CLK_FRE          ),
    .P_UART_RATE        (P_UART_RATE        ),
    .P_SEND_FRE         (2                  ) //串口发送频率 Hz
)uart_top_m0(
    .i_sys_clk          (i_clk_25m          ),
    .i_rst_n            (rst_n_sys          ),

    .i_adc_data         (adc0809_data       ),

    .o_uart_tx          (o_uart_tx          )
);

endmodule
