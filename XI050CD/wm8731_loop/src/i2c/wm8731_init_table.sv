// WM8731 I2C初始化寄存器查找表
//260826    v1.0.0   初始版本（从Cyclone wm8731_loop移植至Xilinx XI050CD）
//260826    v1.1.0   按代码风格重构：logic/端口命名规范化

module wm8731_init_table #(
    parameter DATA_WIDTH = 16, //数据位宽
    parameter ADDR_WIDTH = 8   //地址位宽
)(
    input  [ADDR_WIDTH-1:0] i_addr,     //查找表地址
    input                   i_clk,      //时钟
    output logic [DATA_WIDTH-1:0] o_q,  //查找表输出
    output logic [7:0] o_dev_id,        //WM8731器件地址
    output logic [7:0] o_lut_size       //初始化数据总数
);

logic [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

assign o_dev_id  = 8'h34; //WM8731 I2C器件地址
assign o_lut_size = 8'd10; //WM8731 寄存器初始化数量

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////            初始化配置数据              /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
initial begin
    rom[0] = 16'h001A; //SET_LIN_L
    rom[1] = 16'h021A; //SET_LIN_R
    rom[2] = 16'h047B; //SET_HEAD_L
    rom[3] = 16'h067B; //SET_HEAD_R
    rom[4] = 16'h08F8; //A_PATH_CTRL
    rom[5] = 16'h0A06; //D_PATH_CTRL
    rom[6] = 16'h0C00; //POWER_ON
    rom[7] = 16'h0E01; //SET_FORMAT
    rom[8] = 16'h1002; //SAMPLE_CTRL
    rom[9] = 16'h1201; //SET_ACTIVE
end

always@(posedge i_clk)begin
    o_q <= rom[i_addr];
end

endmodule
