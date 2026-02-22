module top#(
    parameter MEM_BA_WIDTH            = 2   ,       
    parameter MEM_ROW_WIDTH           = 11  ,       
    parameter MEM_COL_WIDTH           = 8   ,       
    parameter MEM_DATA_WIDTH          = 32                
)(
    input                                   i_clk_25m,
    input                                   i_rst_n,

    //cam
    output logic [ 1:0]                      o_cam_pwdn,
    output logic [ 1:0]                      o_cam_rst_n,
    input        [ 1:0]                      i_cam_pclk,
    input        [ 1:0]                      i_cam_vsync,
    input        [ 1:0]                      i_cam_href,
    input        [ 1:0] [ 7:0]               i_cam_data,
    inout        [ 1:0]                      io_cam_scl,    
    inout        [ 1:0]                      io_cam_sda,

    //hdmi
    output logic                             o_hdmi_clk_p,
    output logic                             o_hdmi_clk_n,
    output logic [ 2:0]                      o_hdmi_d_p,
    output logic [ 2:0]                      o_hdmi_d_n,

    //sdram
    //板载恒定
    // output                                  o_sdram_cke,     //sdram clock enable
    // output                                  o_sdram_cs_n,    //sdram chip select
    // output  [(MEM_DATA_WIDTH / 8) - 1 : 0]  o_sdram_dqm,     //sdram data enable 
    output logic                             o_sdram_clk,     //sdram clock
    output logic                             o_sdram_we_n,    //sdram write enable
    output logic                             o_sdram_cas_n,   //sdram column address strobe
    output logic                             o_sdram_ras_n,   //sdram row address strobe
    output logic [MEM_BA_WIDTH - 1 : 0]      o_sdram_ba,      //sdram bank address
    output logic [10:0]                      o_sdram_addr,    //sdram address
    inout        [MEM_DATA_WIDTH - 1 : 0]    io_sdram_dq       //sdram data
);

localparam ADDR_WIDTH              = MEM_BA_WIDTH + MEM_ROW_WIDTH + MEM_COL_WIDTH;     
localparam BUSRT_WIDTH             = 10  ;  

wire                             wr_burst_data_req;       // from external memory controller,write data request ,before data 1 clock
wire                             wr_burst_finish;         // from external memory controller,burst write finish
wire                             rd_burst_finish;         // from external memory controller,burst read finish
wire                             rd_burst_req;            // to external memory controller,send out a burst read request
wire                             wr_burst_req;            // to external memory controller,send out a burst write request
wire[BUSRT_WIDTH - 1:0]          rd_burst_len;            // to external memory controller,data length of the burst read request, not bytes
wire[BUSRT_WIDTH - 1:0]          wr_burst_len;            // to external memory controller,data length of the burst write request, not bytes
wire[ADDR_WIDTH - 1:0]           rd_burst_addr;           // to external memory controller,base address of the burst read request 
wire[ADDR_WIDTH - 1:0]           wr_burst_addr;           // to external memory controller,base address of the burst write request
wire                             rd_burst_data_valid;     // from external memory controller,read data valid 
wire[MEM_DATA_WIDTH - 1 : 0]     rd_burst_data;           // from external memory controller,read request data
wire[MEM_DATA_WIDTH - 1 : 0]     wr_burst_data;           // to external memory controller,write data

/********************************************************************************/
/*********************   CLK PN <> CLK  && KEY **********************************/
/********************************************************************************/  
logic key_rst, sys_rst;
key_sync #(
    .CLK_FRE     (25                      ),
    .KEY_IN_MODE (0                       ),
    .KEY_OUT_MODE(1                       )
)key_sync_m0(
    .i_sys_clk      (i_clk_25m             ),
    .i_key_async    (i_rst_n               ),
    .o_key_sync     (key_rst               )
);

logic  sdram_clk_100m, sdram_pll_locked;
sdram_pll sdram_pll_m0(
    .clk_in1         (i_clk_25m      ),
    .reset           (key_rst        ),
    .clk_out1        (sdram_clk_100m ),
    .locked          (sdram_pll_locked)
);

assign sys_rst  = key_rst | ~sdram_pll_locked;

/********************************************************************************/
/**************************    User Code       **********************************/
/********************************************************************************/ 
assign o_cam_rst_n[0] = 1'b1;
assign o_cam_rst_n[1] = 1'b1;
assign o_cam_pwdn[0] = 1'b0;
assign o_cam_pwdn[1] = 1'b0;

logic [ 1:0][ 9:0]                      cam_lut_index;
logic [ 1:0][31:0]                      cam_lut_data;

//cam init 初始化
i2c_config i2c_config_m0(
    .rst                        (sys_rst                   ),
    .clk                        (i_clk_25m                 ),
    .clk_div_cnt                (16'd25                    ),
    .i2c_addr_2byte             (1'b1                      ),
    .lut_index                  (cam_lut_index[0]          ),
    .lut_dev_addr               (cam_lut_data[0][31:24]    ),
    .lut_reg_addr               (cam_lut_data[0][23: 8]    ),
    .lut_reg_data               (cam_lut_data[0][ 7: 0]    ),
    .error                      (                          ),
    .done                       (                          ),
    .i2c_scl                    (io_cam_scl[0]             ),
    .i2c_sda                    (io_cam_sda[0]             )
);

lut_ov5640_rgb565_640_480_60 lut_ov5640_m0(
    .lut_index                  (cam_lut_index[0]          ),
    .lut_data                   (cam_lut_data[0]           )
);

i2c_config i2c_config_m1(
    .rst                        (sys_rst                   ),
    .clk                        (i_clk_25m                 ),
    .clk_div_cnt                (16'd25                    ),
    .i2c_addr_2byte             (1'b1                      ),
    .lut_index                  (cam_lut_index[1]          ),
    .lut_dev_addr               (cam_lut_data[1][31:24]    ),
    .lut_reg_addr               (cam_lut_data[1][23: 8]    ),
    .lut_reg_data               (cam_lut_data[1][ 7: 0]    ),
    .error                      (                          ),
    .done                       (                          ),
    .i2c_scl                    (io_cam_scl[1]             ),
    .i2c_sda                    (io_cam_sda[1]             )
);

lut_ov5640_rgb565_640_480_60 lut_ov5640_m1(
    .lut_index                  (cam_lut_index[1]          ),
    .lut_data                   (cam_lut_data[1]           )
);

//cam_data 合成32位方便sdram写入
logic [ 1:0][31:0] cam_data_32;
logic [ 1:0]       cam_data_valid;
logic [ 1:0]       cam_data_rst;
cam_data_combine cam_data_combine_m0(
    .i_cam_pclk                 (i_cam_pclk[0]             ),
    .i_cam_vsync                (i_cam_vsync[0]            ),
    .i_cam_href                 (i_cam_href[0]             ),
    .i_cam_data_8               (i_cam_data[0]             ),

    .o_cam_data_rst             (cam_data_rst[0]           ),
    .o_cam_data_valid           (cam_data_valid[0]         ),
    .o_cam_data_32              (cam_data_32[0]            )
);

cam_data_combine cam_data_combine_m1(
    .i_cam_pclk                 (i_cam_pclk[1]             ),
    .i_cam_vsync                (i_cam_vsync[1]            ),
    .i_cam_href                 (i_cam_href[1]             ),
    .i_cam_data_8               (i_cam_data[1]             ),

    .o_cam_data_rst             (cam_data_rst[1]           ),
    .o_cam_data_valid           (cam_data_valid[1]         ),
    .o_cam_data_32              (cam_data_32[1]            )
);

//sdram 读写控制
logic               cam_read_rst, cam_read_clk;
logic [1:0]         cam_data_req;
logic [1:0][15:0]   cam_data_16;
sdram_ctrl_top #(
    .ADDR_WIDTH          (ADDR_WIDTH          ),
    .MEM_DATA_WIDTH      (MEM_DATA_WIDTH      ),
    .BUSRT_WIDTH         (BUSRT_WIDTH         )
)sdram_ctrl_top_m0(
    .i_sys_clk                  (sdram_clk_100m         ),
    .i_sys_rst                  (1'B0                   ),

    .i_cam_pclk                 (i_cam_pclk             ),
    .i_cam_data_rst             (cam_data_rst           ),
    .i_cam_data_valid           (cam_data_valid         ),
    .i_cam_data_32              (cam_data_32            ),

    .i_read_rst                 (cam_read_rst          ),
    .i_read_clk                 (cam_read_clk          ),
    .i_data_req                 (cam_data_req          ),
    .o_data_16                  (cam_data_16           ),

    .o_rd_burst_req             (rd_burst_req           ),
    .o_rd_burst_len             (rd_burst_len           ),
    .o_rd_burst_addr            (rd_burst_addr          ),
    .i_rd_burst_data_valid      (rd_burst_data_valid    ),
    .i_rd_burst_data            (rd_burst_data          ),
    .i_rd_burst_finish          (rd_burst_finish        ),
    .o_wr_burst_req             (wr_burst_req           ),
    .o_wr_burst_len             (wr_burst_len           ),
    .o_wr_burst_addr            (wr_burst_addr          ),
    .i_wr_burst_data_req        (wr_burst_data_req      ),
    .o_wr_burst_data            (wr_burst_data          ),
    .i_wr_burst_finish          (wr_burst_finish        )
);

//sdram IP
assign o_sdram_clk = ~sdram_clk_100m;
sdram_core #(
    .SDR_BA_WIDTH    (MEM_BA_WIDTH      ),
    .SDR_ROW_WIDTH   (MEM_ROW_WIDTH     ),
    .SDR_COL_WIDTH   (MEM_COL_WIDTH     ),
    .SDR_DQ_WIDTH    (MEM_DATA_WIDTH    ),
    .APP_BURST_WIDTH (BUSRT_WIDTH       )
)sdram_core_m0(
    .clk                        (sdram_clk_100m           ),
    .rst                        (sys_rst                  ),

    .rd_burst_req               (rd_burst_req             ),
    .rd_burst_len               (rd_burst_len             ),
    .rd_burst_addr              (rd_burst_addr            ),
    .rd_burst_data_valid        (rd_burst_data_valid      ),
    .rd_burst_data              (rd_burst_data            ),
    .rd_burst_finish            (rd_burst_finish          ),
    .wr_burst_req               (wr_burst_req             ),
    .wr_burst_len               (wr_burst_len             ),
    .wr_burst_addr              (wr_burst_addr            ),
    .wr_burst_data_req          (wr_burst_data_req        ),
    .wr_burst_data              (wr_burst_data            ),
    .wr_burst_finish            (wr_burst_finish          ),

    .sdram_cke                  (                         ),
    .sdram_cs_n                 (                         ),
    .sdram_ras_n                (o_sdram_ras_n            ),
    .sdram_cas_n                (o_sdram_cas_n            ),
    .sdram_we_n                 (o_sdram_we_n             ),
    .sdram_dqm                  (                         ),
    .sdram_ba                   (o_sdram_ba               ),
    .sdram_addr                 (o_sdram_addr             ),
    .sdram_dq                   (io_sdram_dq              )
);

hdmi_top hdmi_top_m0(
    .i_sys_clk                  (i_clk_25m                ),
    .i_sys_rst_n                (~sys_rst                 ),

    .o_read_rst                 (cam_read_rst            ),
    .o_read_clk                 (cam_read_clk            ),
    .o_data_req                 (cam_data_req            ),
    .i_data_16                  (cam_data_16             ),

    .o_tmds_clk_p               (o_hdmi_clk_p             ),
    .o_tmds_clk_n               (o_hdmi_clk_n             ),
    .o_tmds_data_p              (o_hdmi_d_p               ),
    .o_tmds_data_n              (o_hdmi_d_n               )
);
    
endmodule