module  hdmi_top(
    input               i_sys_clk,
    input               i_sys_rst_n,

    output              o_read_rst,
    output              o_read_clk,
    output [ 1:0]       o_data_req,
    input  [ 1:0][15:0] i_data_16,
    
    output              o_tmds_clk_p,    
    output              o_tmds_clk_n,
    output [ 2:0]       o_tmds_data_p,   
    output [ 2:0]       o_tmds_data_n
);

//wire define
wire          pixel_clk;
wire          pixel_clk_5x;
wire          clk_locked;

wire          video_hs;
wire          video_vs;
wire          video_de;
wire  [23:0]  video_rgb;

//*****************************************************
//**                    main code
//*****************************************************
hdmi_pll  hdmi_pll_m0(
    .clk_in1        (i_sys_clk      ),
    .clk_out1       (pixel_clk      ),        
    .clk_out2       (pixel_clk_5x   ),     
    
    .reset          (~i_sys_rst_n   ), 
    .locked         (clk_locked     )
);

video_driver  u_video_driver(
    .i_sys_clk      (pixel_clk      ),
    .i_sys_rst_n    (i_sys_rst_n    ),

    .o_read_rst     (o_read_rst     ),
    .o_read_clk     (o_read_clk     ),
    .o_data_req	    (o_data_req     ),
    .i_data_16      (i_data_16      ),

    .o_video_hs     (video_hs       ),
    .o_video_vs     (video_vs       ),
    .o_video_de     (video_de       ),
    .o_video_rgb    (video_rgb      ),

    .o_pixel_xpos   (               ),
    .o_pixel_ypos   (               )
);

dvi_transmitter_top u_rgb2dvi_0(
    .pclk           (pixel_clk                  ),
    .pclk_x5        (pixel_clk_5x               ),
    .reset_n        (i_sys_rst_n & clk_locked   ),
                
    .video_din      (video_rgb                  ),
    .video_hsync    (video_hs                   ), 
    .video_vsync    (video_vs                   ),
    .video_de       (video_de                   ),
                
    .tmds_clk_p     (o_tmds_clk_p               ),
    .tmds_clk_n     (o_tmds_clk_n               ),
    .tmds_data_p    (o_tmds_data_p              ),
    .tmds_data_n    (o_tmds_data_n              ), 
    .tmds_oen       (                           )                        
    );

endmodule 