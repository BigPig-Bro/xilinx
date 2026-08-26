// WM8731 音频DAC/FIFO控制模块
//260826    v1.0.0   初始版本（从Cyclone wm8731_loop移植至Xilinx XI050CD）
//260826    v1.1.0   按代码风格重构：logic/同步复位/snake_case命名

module audio_dac_fifo #(
    parameter REF_CLK     = 18432000, //18.432MHz，实际按12.288MHz使用
    parameter SAMPLE_RATE = 48000,    //采样率 48KHz
    parameter DATA_WIDTH  = 16,       //数据位宽 16bit
    parameter CHANNEL_NUM = 2         //双声道
)(
    //FIFO接口
    input  [DATA_WIDTH-1:0] i_data,   //FIFO写数据
    input                   i_wr,     //FIFO写请求
    input                   i_wr_clk, //FIFO写时钟
    output logic [DATA_WIDTH-1:0] o_data,   //FIFO读数据
    input                   i_rd,     //FIFO读请求
    output logic            o_full,   //FIFO满
    output logic            o_empty,  //FIFO空

    //音频接口
    input                   i_aud_data, //ADC串行数据
    output logic            o_aud_bck,  //音频位时钟
    output logic            o_aud_data, //DAC串行数据
    output logic            o_aud_lrck, //左右声道时钟
    output logic            o_aud_xck,  //音频主时钟

    //控制接口
    input                   i_clk,      //音频时钟 12.288MHz
    output logic            o_wr,       //FIFO读请求输出
    input                   i_rst_n     //复位，低有效
);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////                 内部信号                /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
logic                  m_data_rd;   //FIFO读请求
logic [3:0]            bck_div;     //位时钟分频计数
logic [8:0]            lrck_1x_div; //左右声道时钟1X分频计数
logic [7:0]            lrck_2x_div; //左右声道时钟2X分频计数
logic [3:0]            sel_cnt;     //PISO选择计数
logic [DATA_WIDTH-1:0] data_out;    //DAC输出数据
logic [DATA_WIDTH-1:0] data_out_tmp;//DAC输出数据暂存
logic [DATA_WIDTH-1:0] data_in;     //ADC输入数据
logic [DATA_WIDTH-1:0] data_in_tmp; //ADC输入数据暂存
logic                  lrck_1x;     //左右声道时钟1X
logic                  lrck_2x;     //左右声道时钟2X

assign o_wr       = m_data_rd;
assign o_aud_xck  = ~i_clk;
assign o_data     = data_in;
assign o_aud_lrck = lrck_1x;
assign o_aud_data = data_out[~sel_cnt];

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////              AUD_BCK生成              /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
always@(posedge i_clk)begin
    if(!i_rst_n)begin
        bck_div   <= 'd0;
        o_aud_bck <= 1'b0;
    end else begin
        if(bck_div >= REF_CLK/(SAMPLE_RATE*DATA_WIDTH*CHANNEL_NUM*2) - 1)begin
            bck_div   <= 'd0;
            o_aud_bck <= ~o_aud_bck;
        end else begin
            bck_div <= bck_div + 1'b1;
        end
    end
end

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////             AUD_LRCK生成              /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
always@(posedge i_clk)begin
    if(!i_rst_n)begin
        lrck_1x_div <= 'd0;
        lrck_2x_div <= 'd0;
        lrck_1x     <= 1'b0;
        lrck_2x     <= 1'b0;
    end else begin
        //LRCK 1X
        if(lrck_1x_div >= REF_CLK/(SAMPLE_RATE*2) - 1)begin
            lrck_1x_div <= 'd0;
            lrck_1x     <= ~lrck_1x;
        end else begin
            lrck_1x_div <= lrck_1x_div + 1'b1;
        end

        //读取左声道数据
        if(lrck_1x == 1'b0)
            data_in_tmp[~sel_cnt] <= i_aud_data;

        //LRCK 2X
        if(lrck_2x_div >= REF_CLK/(SAMPLE_RATE*4) - 1)begin
            lrck_2x_div <= 'd0;
            lrck_2x     <= ~lrck_2x;
        end else begin
            lrck_2x_div <= lrck_2x_div + 1'b1;
        end
    end
end

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////             读信号生成                /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
always@(posedge i_clk)begin
    if(!i_rst_n)begin
        m_data_rd <= 1'b0;
    end else begin
        if(lrck_1x_div == REF_CLK/(SAMPLE_RATE*2) - 1)begin
            m_data_rd <= 1'b1;
            data_in   <= data_in_tmp;
        end else begin
            m_data_rd <= 1'b0;
        end
    end
end

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////             数据锁存                  /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
always@(posedge i_clk)begin
    if(!i_rst_n)begin
        data_out_tmp <= 'd0;
    end else begin
        if(lrck_2x_div == REF_CLK/(SAMPLE_RATE*4) - 1)
            data_out_tmp <= data_in;
    end
end

always@(posedge i_clk)begin
    if(!i_rst_n)begin
        data_out <= 'd0;
    end else begin
        if(lrck_2x_div == REF_CLK/(SAMPLE_RATE*4) - 3)
            data_out <= data_out_tmp;
    end
end

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////         16bit PISO MSB First          /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//使用音频位时钟下降沿输出，保证数据在BCK低电平期间稳定
always@(negedge o_aud_bck)begin
    if(!i_rst_n)begin
        sel_cnt <= 'd0;
    end else begin
        sel_cnt <= sel_cnt + 1'b1;
    end
end

endmodule
