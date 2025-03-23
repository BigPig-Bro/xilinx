//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved
//----------------------------------------------------------------------------------------
// File name:           video_display
// Last modified Date:  2019/7/1 9:30:00
// Last Version:        V1.1
// Descriptions:        视频显示模块，显示彩条
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2019/7/1 9:30:00
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module  video_display(
    input                pixel_clk,
    input                sys_rst_n,
    
    input        [10:0]  pixel_xpos,  //像素点横坐标
    input        [10:0]  pixel_ypos,  //像素点纵坐标
    output  reg  [23:0]  pixel_data   //像素点数据
);

//parameter define
parameter  H_DISP = 11'd1280;                       //分辨率——行
parameter  V_DISP = 11'd720;                        //分辨率——列
    
//*****************************************************
//**                    main code
//*****************************************************

//根据当前像素点坐标指定当前像素点颜色数据，在屏幕上显示彩条
always @(posedge pixel_clk ) begin
    if (!sys_rst_n)
        pixel_data <= 16'd0;
    else begin
        if((pixel_xpos >= 0) && (pixel_xpos < (H_DISP/24)*1))
            pixel_data <= 24'h800000;  
        else if((pixel_xpos >= (H_DISP/24)*1) && (pixel_xpos < (H_DISP/24)*2))
            pixel_data <= 24'h400000;
        else if((pixel_xpos >= (H_DISP/24)*2) && (pixel_xpos < (H_DISP/24)*3))
            pixel_data <= 24'h200000;
        else if((pixel_xpos >= (H_DISP/24)*3) && (pixel_xpos < (H_DISP/24)*4))
            pixel_data <= 24'h100000;
        else if((pixel_xpos >= (H_DISP/24)*4) && (pixel_xpos < (H_DISP/24)*5))
            pixel_data <= 24'h080000;
        else if((pixel_xpos >= (H_DISP/24)*5) && (pixel_xpos < (H_DISP/24)*6))
            pixel_data <= 24'h040000;
        else if((pixel_xpos >= (H_DISP/24)*6) && (pixel_xpos < (H_DISP/24)*7))
            pixel_data <= 24'h020000;
        else if((pixel_xpos >= (H_DISP/24)*7) && (pixel_xpos < (H_DISP/24)*8))
            pixel_data <= 24'h010000;
        else if((pixel_xpos >= (H_DISP/24)*8) && (pixel_xpos < (H_DISP/24)*9))
            pixel_data <= 24'h008000;
        else if((pixel_xpos >= (H_DISP/24)*9) && (pixel_xpos < (H_DISP/24)*10))
            pixel_data <= 24'h004000;
        else if((pixel_xpos >= (H_DISP/24)*10) && (pixel_xpos < (H_DISP/24)*11))
            pixel_data <= 24'h002000;
        else if((pixel_xpos >= (H_DISP/24)*11) && (pixel_xpos < (H_DISP/24)*12))
            pixel_data <= 24'h001000;
        else if((pixel_xpos >= (H_DISP/24)*12) && (pixel_xpos < (H_DISP/24)*13))
            pixel_data <= 24'h000800;
        else if((pixel_xpos >= (H_DISP/24)*13) && (pixel_xpos < (H_DISP/24)*14))
            pixel_data <= 24'h000400;
        else if((pixel_xpos >= (H_DISP/24)*14) && (pixel_xpos < (H_DISP/24)*15))
            pixel_data <= 24'h000200;
        else if((pixel_xpos >= (H_DISP/24)*15) && (pixel_xpos < (H_DISP/24)*16))
            pixel_data <= 24'h000100;
        else if((pixel_xpos >= (H_DISP/24)*16) && (pixel_xpos < (H_DISP/24)*17))
            pixel_data <= 24'h000080;
        else if((pixel_xpos >= (H_DISP/24)*17) && (pixel_xpos < (H_DISP/24)*18))
            pixel_data <= 24'h000040;
        else if((pixel_xpos >= (H_DISP/24)*18) && (pixel_xpos < (H_DISP/24)*19))
            pixel_data <= 24'h000020;
        else if((pixel_xpos >= (H_DISP/24)*19) && (pixel_xpos < (H_DISP/24)*20))
            pixel_data <= 24'h000010;
        else if((pixel_xpos >= (H_DISP/24)*20) && (pixel_xpos < (H_DISP/24)*21))
            pixel_data <= 24'h000008;
        else if((pixel_xpos >= (H_DISP/24)*21) && (pixel_xpos < (H_DISP/24)*22))
            pixel_data <= 24'h000004;
        else if((pixel_xpos >= (H_DISP/24)*22) && (pixel_xpos < (H_DISP/24)*23))
            pixel_data <= 24'h000002;
        else 
            pixel_data <= 24'h000001;
    end
end

endmodule