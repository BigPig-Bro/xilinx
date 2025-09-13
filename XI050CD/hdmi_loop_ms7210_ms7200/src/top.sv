module  top(
    input         		sys_clk,   
    input         		sys_rst_n, 

    output     [ 1:0]   led,
//////////////////// 			 解码前输出图像（MS7210）	 /////////////////////////////
    output            	ms7210_rstn_out,     //??????????????
    output            	ms7210_iic_scl,      //I2C???????????
    inout             	ms7210_iic_sda,      //I2C????????????
   
    output              ms7210_clk,    //???????                        
    output            	ms7210_vs,     //????????
    output            	ms7210_hs,     //????????
    output            	ms7210_de,     //???????
    output     [23:0]   ms7210_rgb,     //RGB888???????   

//////////////////// 			 解码后输入图像（MS7200）	 /////////////////////////////
    output            	ms7200_iic_scl,   
    inout             	ms7200_iic_sda,   

    input              ms7200_clk, 
    input              ms7200_vs,  
    input              ms7200_hs,  
    input              ms7200_de,  
    input     [23:0]   ms7200_rgb
//////////////////// 			 解码后输出图像	            /////////////////////////////
);
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			 OUT MS7210 	            /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//wire define
wire          locked;
wire          rst_n;
wire  [12:0]  pixel_xpos_w;
wire  [12:0]  pixel_ypos_w;
wire  [23:0]  pixel_data_w;

assign rst_n =  sys_rst_n & locked;

sys_pll sys_pll_m0(
    .inclk0 (sys_clk        ),
    .locked (locked         ),
    .c0    (ms7210_clk        )
);

wire ms7210_init_over;
ms7210_ctl ms7210_ctl(
    .clk            (sys_clk), 
    .rst_n          (rst_n),  

    .rstn_out       (ms7210_rstn_out),         //?????????????                     
    .init_over      (ms7210_init_over),        //??????????????  
    .iic_scl        (ms7210_iic_scl), 
    .iic_sda        (ms7210_iic_sda)  
);

video_driver  u_driver(
    .pixel_clk      (ms7210_clk ),
    .sys_rst_n      (rst_n ),

    .video_hs       (ms7210_hs ),
    .video_vs       (ms7210_vs ),
    .video_de       (ms7210_de ),
    .video_rgb      (ms7210_rgb ),
	.data_req		(),

    .pixel_xpos     (pixel_xpos_w ),
    .pixel_ypos     (pixel_ypos_w ),
	.pixel_data     (pixel_data_w )
);


video_display  u_display(
    .pixel_clk      (ms7210_clk),
    .sys_rst_n      (rst_n),

    .pixel_xpos     (pixel_xpos_w),
    .pixel_ypos     (pixel_ypos_w),
    .pixel_data     (pixel_data_w)
    );

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			   IN MS7200 	            /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//例化视频芯片控制模块
logic ms7200_init_over;
ms7200_ctl ms7200_ctl(
    .clk            (sys_clk        ), 
    .rst_n          (sys_rst_n      ),  

    .rstn_out       (                      ),                           
    .init_over      (ms7200_init_over      ),     
    .iic_scl        (ms7200_iic_scl        ), 
    .iic_sda        (ms7200_iic_sda        )  
);

//例化完成指示灯闪烁
logic [25:0]  blink_cnt;
always@(posedge sys_clk) blink_cnt <= blink_cnt + 1'b1;
assign led[0] = ms7200_init_over? blink_cnt[25] : 1'b1;
assign led[1] = ms7210_init_over? blink_cnt[25] : 1'b1;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			 OUT VGA	                /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//移相采样
logic ms7200_clk_d;
input_pll u_input_pll(
    .inclk0 (sys_clk), 
    .c0     (ms7200_clk_d)
);

logic [23:0] ms7200_rgb_d0,ms7200_rgb_d1;
logic ms7200_vs_d0,ms7200_vs_d1;
logic ms7200_hs_d0,ms7200_hs_d1;
logic ms7200_de_d0,ms7200_de_d1;
always@(posedge ms7200_clk_d or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        ms7200_rgb_d0 <= 24'h0;
        ms7200_rgb_d1 <= 24'h0;
        ms7200_vs_d0  <= 1'b0;
        ms7200_vs_d1  <= 1'b0;
        ms7200_hs_d0  <= 1'b0;
        ms7200_hs_d1  <= 1'b0;
        ms7200_de_d0  <= 1'b0;
        ms7200_de_d1  <= 1'b0;
    end else begin
        ms7200_rgb_d0 <= ms7200_rgb;
        ms7200_rgb_d1 <= ms7200_rgb_d0;
        ms7200_vs_d0  <= ms7200_vs;
        ms7200_vs_d1  <= ms7200_vs_d0;
        ms7200_hs_d0  <= ms7200_hs;
        ms7200_hs_d1  <= ms7200_hs_d0;
        ms7200_de_d0  <= ms7200_de;
        ms7200_de_d1  <= ms7200_de_d0;
    end
end

ila_0 u_ila(
    .clk        (ms7200_clk_d), 
    .probe0     ( ms7200_vs), 
    .probe1     ( ms7200_hs), 
    .probe2     ( ms7200_de), 
    .probe3     (ms7200_rgb) 
);

endmodule