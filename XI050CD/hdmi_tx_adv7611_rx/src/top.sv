module top#(
    parameter MEM_BA_WIDTH            = 2   ,       
    parameter MEM_ROW_WIDTH           = 11  ,       
    parameter MEM_COL_WIDTH           = 8   ,       
    parameter MEM_DATA_WIDTH          = 32                
)(
    input               i_clk_25m,

    input       [3:0]   i_key,
    output      [3:0]   o_led,

	output              o_adv7611_rst_n,
	inout               io_adv7611_scl,
	inout               io_adv7611_sda,
    input               i_adv7611_hs,
    input               i_adv7611_vs,
    input               i_adv7611_de,
    input               i_adv7611_pclk,
    input  [23:0]       i_adv7611_data,

    output              o_hdmi_clk_p,
    output              o_hdmi_clk_n,
    output      [2:0]   o_hdmi_d_p,
    output      [2:0]   o_hdmi_d_n
);
logic video_clk;
ila_7611 ila_7611_m0(
	.clk 		(video_clk       	),
	.probe0 	(i_adv7611_hs		),
	.probe1 	(i_adv7611_vs		),
	.probe2 	(i_adv7611_de		),
	.probe3 	(i_adv7611_data 	)
);

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 		        CLK & KEY	            /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
logic [3:0] key_rst;
logic       sys_rst;
key_sync #(
    .CLK_FRE     (25                      ),
    .KEY_IN_MODE (0                       ),
    .KEY_OUT_MODE(1                       )
)key_sync_m0(
    .i_sys_clk      (i_clk_25m             ),
    .i_key_async    (i_key[0]              ),
    .o_key_sync     (key_rst[0]            )
);

key_sync #(
    .CLK_FRE     (25                      ),
    .KEY_IN_MODE (0                       ),
    .KEY_OUT_MODE(1                       )
)key_sync_m1(
    .i_sys_clk      (i_clk_25m             ),
    .i_key_async    (i_key[1]              ),
    .o_key_sync     (key_rst[1]            )
);

key_sync #(
	.CLK_FRE     (25                      ),
	.KEY_IN_MODE (0                       ),
	.KEY_OUT_MODE(1                       )
)key_sync_m2(	
	.i_sys_clk      (i_clk_25m             ),
	.i_key_async    (i_key[2]              ),
	.o_key_sync     (key_rst[2]            )
);

key_sync #(
	.CLK_FRE     (25                      ),
	.KEY_IN_MODE (0                       ),
	.KEY_OUT_MODE(1                       )
)key_sync_m3(
	.i_sys_clk      (i_clk_25m             ),
	.i_key_async    (i_key[3]              ),
	.o_key_sync     (key_rst[3]            )
);

assign sys_rst = | key_rst;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 		        测试按键LED	            /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
assign   o_led[0] = cfg_error; //1不亮 正常不亮
assign   o_led[1] = cfg_done;  //1不亮 正常亮
assign   o_led[2] = vs_cnt[4]; //1不亮 正常闪烁
assign   o_led[3] = sys_rst;   //1不亮 按键按下不亮 松开亮


/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			    测试HDMI	            /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

hdmi_colorbar_top hdmi_colorbar_top_m0(
	.sys_clk			(i_clk_25m	    ),
	.sys_rst_n			(1'b1  			),
	.o_video_clk        (video_clk      ),
	.tmds_clk_p			(o_hdmi_clk_p	),
	.tmds_clk_n			(o_hdmi_clk_n	),
	.tmds_oen			(				),
	.tmds_data_p		(o_hdmi_d_p		),
	.tmds_data_n		(o_hdmi_d_n		)
);

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			    测试ADV7611    	        /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////   ADV7611 IIC初始化     ////////
assign o_adv7611_rst_n = ~sys_rst;

logic [ 9:0]   adv7611_lut_index;
logic [31:0]   adv7611_lut_data;
  i2c_config i2c_config_m0(
    .rst_n              (~sys_rst                   ),
    .clk                (i_clk_25m                  ),     
    .clk_div_cnt        (16'd250                    ),
    .i2c_addr_2byte     (1'b0                       ),
    .lut_index          (adv7611_lut_index          ),
    .lut_dev_addr       (adv7611_lut_data[31:24]    ),
    .lut_reg_addr       (adv7611_lut_data[23:8]     ),
    .lut_reg_data       (adv7611_lut_data[7:0]      ),
    .error              (cfg_error                  ),
    .done               (cfg_done                   ),
    .i2c_scl            (io_adv7611_scl             ),
    .i2c_sda            (io_adv7611_sda             )
  );

lut_adv7611 lut_adv7611_m0(
  .lut_index          (adv7611_lut_index          ),
  .lut_data           (adv7611_lut_data           )
); 

logic [4:0] vs_cnt;
logic       i_adv7611_vs_d0;
always@(posedge i_adv7611_pclk)begin
	i_adv7611_vs_d0 <= i_adv7611_vs;

	if(i_adv7611_vs_d0 == 1'b0 && i_adv7611_vs == 1'b1)begin
		vs_cnt <= vs_cnt + 1'b1;
	end
end

endmodule 