module video_driver(
    input           	      i_sys_clk	    ,
    input           	      i_sys_rst_n   ,
		
    output  logic      	      o_video_hs	,  
    output  logic      	      o_video_vs	,  
    output  logic      	      o_video_de	,  
    output  logic     [23:0]  o_video_rgb	,  

    output	logic			  o_read_rst	,
    output	logic			  o_read_clk	,
    output	logic[1:0]		  o_data_req 	,
    input        [1:0][15:0]  i_data_16     ,	    
	
    output  logic	  [10:0]  o_pixel_xpos	,  
    output  logic	  [10:0]  o_pixel_ypos    
);

//parameter define
//1280*720 
parameter  H_SYNC   =  11'd40;  
parameter  H_BACK   =  11'd220; 
parameter  H_DISP   =  11'd1280;
parameter  H_FRONT  =  11'd110; 
parameter  H_TOTAL  =  11'd1650;

parameter  V_SYNC   =  11'd5;   
parameter  V_BACK   =  11'd20;  
parameter  V_DISP   =  11'd720; 
parameter  V_FRONT  =  11'd5;   
parameter  V_TOTAL  =  11'd750; 

//1920*1080
//parameter  H_SYNC   =  12'd44;   
//parameter  H_BACK   =  12'd148;  
//parameter  H_DISP   =  12'd1920; 
//parameter  H_FRONT  =  12'd88;  
//parameter  H_TOTAL  =  12'd2200; 
//
//parameter  V_SYNC   =  12'd5;    
//parameter  V_BACK   =  12'd36;   
//parameter  V_DISP   =  12'd1080; 
//parameter  V_FRONT  =  12'd4;    
//parameter  V_TOTAL  =  12'd1125; 

//reg define
reg  [11:0] cnt_h;
reg  [11:0] cnt_v;
reg       	video_de_d1, video_de_d0;
reg         video_vs_d0;
//*****************************************************
//**                    read code
//*****************************************************
assign o_read_clk = i_sys_clk;
//输出地址重置信号
always @(posedge i_sys_clk) begin
    video_vs_d0 <= o_video_vs;

    if(!i_sys_rst_n)
        o_read_rst <= 1'b1;
    else if(video_vs_d0 & !o_video_vs) //vs下降沿
        o_read_rst <= 1'b1;
    else
        o_read_rst <= 1'b0;
end

//数据请求信号
always @(posedge i_sys_clk) begin
	if(!i_sys_rst_n)
		o_data_req[0] <= 1'b0;
	else if(((cnt_h >= H_SYNC + H_BACK - 2'd3) && (cnt_h < H_SYNC + H_BACK + 640 - 2'd3)) //0-639
                  && ((cnt_v >= V_SYNC + V_BACK) && (cnt_v < V_SYNC + V_BACK + 480)))
		o_data_req[0] <= 1'b1;
	else
		o_data_req[0] <= 1'b0;
end

always @(posedge i_sys_clk) begin
	if(!i_sys_rst_n)
		o_data_req[1] <= 1'b0;
	else if(((cnt_h >= H_SYNC + H_BACK + 640 - 2'd3) && (cnt_h < H_SYNC + H_BACK + H_DISP - 2'd3)) //640-1279
                  && ((cnt_v >= V_SYNC + V_BACK) && (cnt_v < V_SYNC + V_BACK + 480)))
		o_data_req[1] <= 1'b1;
	else
		o_data_req[1] <= 1'b0;
end


//*****************************************************
//**                    output code
//*****************************************************
logic [10:0] pixel_ypos_r, pixel_xpos_r;
always @(posedge i_sys_clk) begin
    o_pixel_xpos <= pixel_xpos_r;
    o_pixel_ypos <= pixel_ypos_r;
    o_video_de  <= video_de_d1;
    o_video_hs  <= ( cnt_h < H_SYNC ) ? 1'b0 : 1'b1; 
    o_video_vs  <= ( cnt_v < V_SYNC ) ? 1'b0 : 1'b1; 

    //BGR565转RGB888
    if (video_de_d1) begin
        if (o_pixel_ypos < 480) begin
            o_video_rgb <= (o_pixel_xpos < 640) ? 
                {i_data_16[0][15:11], 3'b000, i_data_16[0][10:5], 2'b00, i_data_16[0][4:0], 3'b000}:
                {i_data_16[1][15:11], 3'b000, i_data_16[1][10:5], 2'b00, i_data_16[1][4:0], 3'b000};
        end else begin
            if (o_pixel_xpos < 1280 / 4)
                o_video_rgb <= 24'H000000;
            else if (o_pixel_xpos < 1280 / 4 * 2)
                o_video_rgb <= 24'HFF0000;
            else if (o_pixel_xpos < 1280 / 4 * 3)
                o_video_rgb <= 24'H00FF00;
            else
                o_video_rgb <= 24'H0000FF;
        end
    end else begin
        o_video_rgb <= 24'd0;
    end
end

always @(posedge i_sys_clk) begin
	if(!i_sys_rst_n)
		video_de_d1 <= 1'b0;
	else
		video_de_d1 <= video_de_d0;
end

always @(posedge i_sys_clk) begin
	if(!i_sys_rst_n)
		video_de_d0 <= 1'b0;
	else if(((cnt_h >= H_SYNC + H_BACK - 2'd2) && (cnt_h < H_SYNC + H_BACK + H_DISP - 2'd2))
                  && ((cnt_v >= V_SYNC + V_BACK) && (cnt_v < V_SYNC + V_BACK+V_DISP)))
		video_de_d0 <= 1'b1;
	else
		video_de_d0 <= 1'b0;
end

always@ (posedge i_sys_clk) begin
    if(!i_sys_rst_n)
        pixel_xpos_r <= 11'd0;
    else if(video_de_d0)
        pixel_xpos_r <= cnt_h + 2'd2 - H_SYNC - H_BACK ;
    else 
        pixel_xpos_r <= 11'd0;
end
    
always@ (posedge i_sys_clk) begin
    if(!i_sys_rst_n)
        pixel_ypos_r <= 11'd0;
    else if((cnt_v >= (V_SYNC + V_BACK)) && (cnt_v < (V_SYNC + V_BACK + V_DISP)))
        pixel_ypos_r <= cnt_v + 1'b1 - (V_SYNC + V_BACK) ;
    else 
        pixel_ypos_r <= 11'd0;
end

always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n)
        cnt_h <= 11'd0;
    else begin
        if(cnt_h < H_TOTAL - 1'b1)
            cnt_h <= cnt_h + 1'b1;
        else 
            cnt_h <= 11'd0;
    end
end

always @(posedge i_sys_clk) begin
    if (!i_sys_rst_n)
        cnt_v <= 11'd0;
    else if(cnt_h == H_TOTAL - 1'b1) begin
        if(cnt_v < V_TOTAL - 1'b1)
            cnt_v <= cnt_v + 1'b1;
        else 
            cnt_v <= 11'd0;
    end
end

endmodule