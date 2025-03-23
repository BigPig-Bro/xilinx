module top(
    input               i_clk,

    input       [3:0]   i_key,
    output      [3:0]   o_led,

    input               i_uart_rx,
    output              o_uart_tx,

    //TF卡槽（SDIO，这里仅测试SPI模式）
	output              sd_ncs,    //chip select (SPI mode) SDIO D3
    output              sd_mosi,   //controller data output SDIO CMD
    output              sd_dclk,   //clock                  SDIO CLK
    input               sd_miso,   //controller data input  SDIO D0

    output              o_hdmi_clk_p,
    output              o_hdmi_clk_n,
    output      [2:0]   o_hdmi_d_p,
    output      [2:0]   o_hdmi_d_n,

    output      [33:0]  exter_io1,exter_io2
);
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			    测试时钟输入 	         /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// 降低到hz，生成分频信号1hz A
logic [24:0] cnt;
always@(posedge i_clk)
    cnt <= cnt + 1;

logic clk_A ;
assign clk_A = cnt[24];

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 		        测试按键LED	            /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//现象：按键按下，对应的LED快闪，否则 23闪烁 01如果TF卡初始化成功，闪烁，未成功常亮

assign   o_led[0] = ~i_key[0] ? cnt[20]: sd_init_done? cnt[24] : cnt[23];
assign   o_led[1] = ~i_key[1] ? cnt[20] : sd_init_done? cnt[24] : cnt[23];
assign   o_led[2] = ~i_key[2] ? cnt[20] :                      	cnt[24];
assign   o_led[3] = ~i_key[3] ? cnt[20] :                      	cnt[24];


/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 		        测试TF卡读写	         /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//现象：TF卡初始化成功后，给出信号sd_init_done
logic tf_clk;
tf_pll tf_pll_m0(
.clk_in1(i_clk),
.clk_out1(tf_clk)
);

logic sd_init_done;
sd_card_top  sd_card_top_m0(
	.clk                       (tf_clk                      ),
	.rst                       (~i_key[0]                  ),

	.SD_nCS                    (sd_ncs                     ),
	.SD_DCLK                   (sd_dclk                    ),
	.SD_MOSI                   (sd_mosi                    ),
	.SD_MISO                   (sd_miso                    ),

	.sd_init_done              (sd_init_done               ),
	.sd_sec_read               (                           ),
	.sd_sec_read_addr          (                           ),
	.sd_sec_read_data          (                           ),
	.sd_sec_read_data_valid    (                           ),
	.sd_sec_read_end           (                           ),
	.sd_sec_write              (                           ),
	.sd_sec_write_addr         (                           ),
	.sd_sec_write_data         (                           ),
	.sd_sec_write_data_req     (                           ),
	.sd_sec_write_end          (                           )
);

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			    测试FLASH 	            /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//测试固化代码是否成功

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			    测试UART	            /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//回环测试
assign o_uart_tx = i_uart_rx;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			    测试外部IO	            /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
assign exter_io1[0] = clk_A ;
assign exter_io1[1] = ~clk_A ;
assign exter_io1[2] = clk_A ;
assign exter_io1[3] = ~clk_A ;
assign exter_io1[4] = clk_A ;
assign exter_io1[5] = ~clk_A ;
assign exter_io1[6] = clk_A ;
assign exter_io1[7] = ~clk_A ;
assign exter_io1[8] = clk_A ;
assign exter_io1[9] = ~clk_A ;
assign exter_io1[10] = clk_A ;
assign exter_io1[11] = ~clk_A ;
assign exter_io1[12] = clk_A ;
assign exter_io1[13] = ~clk_A ;
assign exter_io1[14] = clk_A ;
assign exter_io1[15] = ~clk_A ;
assign exter_io1[16] = clk_A ;
assign exter_io1[17] = ~clk_A ;
assign exter_io1[18] = clk_A ;
assign exter_io1[19] = ~clk_A ;
assign exter_io1[20] = clk_A ;
assign exter_io1[21] = ~clk_A ;
assign exter_io1[22] = clk_A ;
assign exter_io1[23] = ~clk_A ;
assign exter_io1[24] = clk_A ;
assign exter_io1[25] = ~clk_A ;
assign exter_io1[26] = clk_A ;
assign exter_io1[27] = ~clk_A ;
assign exter_io1[28] = clk_A ;
assign exter_io1[29] = ~clk_A ;
assign exter_io1[30] = clk_A ;
assign exter_io1[31] = ~clk_A ;
assign exter_io1[32] = clk_A ;
assign exter_io1[33] = ~clk_A ;

assign exter_io2[0] = clk_A ;
assign exter_io2[1] = ~clk_A ;
assign exter_io2[2] = clk_A ;
assign exter_io2[3] = ~clk_A ;
assign exter_io2[4] = clk_A ;
assign exter_io2[5] = ~clk_A ;
assign exter_io2[6] = clk_A ;
assign exter_io2[7] = ~clk_A ;
assign exter_io2[8] = clk_A ;
assign exter_io2[9] = ~clk_A ;
assign exter_io2[10] = clk_A ;
assign exter_io2[11] = ~clk_A ;
assign exter_io2[12] = clk_A ;
assign exter_io2[13] = ~clk_A ;
assign exter_io2[14] = clk_A ;
assign exter_io2[15] = ~clk_A ;
assign exter_io2[16] = clk_A ;
assign exter_io2[17] = ~clk_A ;
assign exter_io2[18] = clk_A ;
assign exter_io2[19] = ~clk_A ;
assign exter_io2[20] = clk_A ;
assign exter_io2[21] = ~clk_A ;
assign exter_io2[22] = clk_A ;
assign exter_io2[23] = ~clk_A ;
assign exter_io2[24] = clk_A ;
assign exter_io2[25] = ~clk_A ;
assign exter_io2[26] = clk_A ;
assign exter_io2[27] = ~clk_A ;
assign exter_io2[28] = clk_A ;
assign exter_io2[29] = ~clk_A ;
assign exter_io2[30] = clk_A ;
assign exter_io2[31] = ~clk_A ;
assign exter_io2[32] = clk_A ;
assign exter_io2[33] = ~clk_A ;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			    测试HDMI	            /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

hdmi_colorbar_top hdmi_colorbar_top_m0(
	.sys_clk			(i_clk	 		),
	.sys_rst_n			(1'b1  			),
	.tmds_clk_p			(o_hdmi_clk_p	),
	.tmds_clk_n			(o_hdmi_clk_n	),
	.tmds_oen			(				),
	.tmds_data_p		(o_hdmi_d_p		),
	.tmds_data_n		(o_hdmi_d_n		)
);


endmodule 