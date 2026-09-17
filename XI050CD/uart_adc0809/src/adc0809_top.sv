// ADC0809 八通道数据采集驱动
//260917    v1.0.0   初始版本

module adc0809_top #(
    parameter P_CLK_FRE = 25_000_000,   //系统时钟频率 Hz
    parameter P_ADC_FRE = 50_000        //ADC0809采样帧频率 Hz
)(
    input                   i_sys_clk,      //系统时钟
    input                   i_rst_n,        //系统复位

    input                   i_adc_start,    //启动采集
    output                  o_adc_done,     //采集完成
    output logic [7:0][7:0] o_adc_data,     //8通道采集数据

    //ADC0809硬件接口
    output logic [2:0]      o_adc_addr,     //通道地址
    input      [7:0]        i_adc_db,       //转换数据
    output                  o_adc_oe,       //输出使能
    output logic            o_adc_clk,      //ADC时钟
    output logic            o_adc_st,       //启动转换
    input                   i_adc_eoc,      //转换结束
    output                  o_adc_ale       //地址锁存
);

localparam P_ADC_CLK_FRE = 640_000; //ADC0809时钟频率 Hz

localparam P_ADC_CLK_CNT   = (P_CLK_FRE / P_ADC_CLK_FRE / 2) - 1; //ADC时钟半周期分频计数
localparam P_EOC_TIMEOUT   = (P_CLK_FRE / 100_000) - 1;           //等待EOC最大10us
localparam P_READ_DLY_CNT  = (P_CLK_FRE * 2 / P_ADC_CLK_FRE) - 1; //读取数据前等待2个ADC时钟
localparam P_ADC_DELAY_CNT = (P_CLK_FRE / P_ADC_FRE) - 1;         //采样帧间隔计数

typedef enum logic [2:0] {
    ADC_START,
    ADC_ST,
    ADC_WAIT_EOC_L,
    ADC_WAIT_EOC_H,
    ADC_READ_DATA,
    ADC_NEXT_ADDR,
    ADC_DELAY
} STATE_ADC;
STATE_ADC state;

logic [ 9:0] clk_cnt;   //ADC时钟分频计数
logic [23:0] wait_cnt;  //采样帧间隔计数
logic [15:0] clk_delay; //状态内延时计数

assign o_adc_done = (state == ADC_START);
assign o_adc_oe   = (state == ADC_READ_DATA);
assign o_adc_ale  = o_adc_st;

/********************************************************************************/
/**************************    ADC0809时钟分频    *******************************/
/********************************************************************************/
always@(posedge i_sys_clk)begin
    if(!i_rst_n)begin
        o_adc_clk <= 1'b0;
        clk_cnt   <= 'd0;
    end else if(clk_cnt >= P_ADC_CLK_CNT)begin
        o_adc_clk <= ~o_adc_clk;
        clk_cnt   <= 'd0;
    end else begin
        clk_cnt   <= clk_cnt + 1'b1;
    end
end

/********************************************************************************/
/**************************    ADC0809采集状态机   ******************************/
/********************************************************************************/
always@(posedge i_sys_clk)begin
    if(!i_rst_n)begin
        o_adc_addr <= 'd0;
        o_adc_st   <= 1'b0;
        wait_cnt   <= 'd0;
        clk_delay  <= 'd0;

        state      <= ADC_START;
    end else begin
        case(state)
            ADC_START:begin
                wait_cnt <= wait_cnt + 1'b1;

                if(i_adc_start && !o_adc_clk && clk_cnt == 'd1)begin
                    o_adc_st <= 1'b1;

                    state    <= ADC_ST;
                end
            end

            ADC_ST:begin //ST脉宽100~200ns，需被ADC时钟采到，故等待一个周期
                wait_cnt <= wait_cnt + 1'b1;

                if(o_adc_clk && clk_cnt == 'd1)begin
                    o_adc_st <= 1'b0;

                    state    <= ADC_WAIT_EOC_L;
                end else begin
                    clk_delay <= clk_delay + 1'b1;
                end
            end

            ADC_WAIT_EOC_L:begin
                wait_cnt <= wait_cnt + 1'b1;

                if(!i_adc_eoc)begin
                    clk_delay <= 'd0;

                    state     <= ADC_WAIT_EOC_H;
                end else if(clk_delay >= P_EOC_TIMEOUT)begin //EOC最多等待10us
                    clk_delay <= 'd0;

                    state     <= ADC_DELAY;
                end else begin
                    clk_delay <= clk_delay + 1'b1;
                end
            end

            ADC_WAIT_EOC_H:begin
                wait_cnt <= wait_cnt + 1'b1;

                if(i_adc_eoc)begin
                    state <= ADC_READ_DATA;
                end
            end

            ADC_READ_DATA:begin //等待2个ADC时钟后读取数据
                wait_cnt <= wait_cnt + 1'b1;

                o_adc_data[o_adc_addr] <= i_adc_db;

                if(clk_delay >= P_READ_DLY_CNT)begin
                    clk_delay  <= 'd0;
                    o_adc_addr <= o_adc_addr + 1'b1;

                    state      <= ADC_NEXT_ADDR;
                end else begin
                    clk_delay  <= clk_delay + 1'b1;
                end
            end

            ADC_NEXT_ADDR:begin
                wait_cnt <= wait_cnt + 1'b1;

                if(o_adc_addr == 'd0)begin //8个通道采集完成
                    state <= ADC_DELAY;
                end else begin
                    state <= ADC_START;
                end
            end

            ADC_DELAY:begin
                if(wait_cnt >= P_ADC_DELAY_CNT)begin
                    wait_cnt <= 'd0;

                    state    <= ADC_START;
                end else begin
                    wait_cnt <= wait_cnt + 1'b1;
                end
            end

            default:begin
                state <= ADC_DELAY;
            end
        endcase
    end
end

endmodule
