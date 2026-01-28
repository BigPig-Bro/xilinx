module top#(
    parameter MEM_BA_WIDTH            = 2   ,       
    parameter MEM_ROW_WIDTH           = 11  ,       
    parameter MEM_COL_WIDTH           = 8   ,       
    parameter MEM_DATA_WIDTH          = 32                
)(
    input                                   i_clk_25m,
    input                                   i_rst_n,

    output                                  o_led,

    //板载恒定
	// output                                  o_sdram_cke,     //sdram clock enable
	// output                                  o_sdram_cs_n,    //sdram chip select
	// output  [(MEM_DATA_WIDTH / 8) - 1 : 0]  o_sdram_dqm,     //sdram data enable 
    output                                  o_sdram_clk,     //sdram clock
	output                                  o_sdram_we_n,    //sdram write enable
	output                                  o_sdram_cas_n,   //sdram column address strobe
	output                                  o_sdram_ras_n,   //sdram row address strobe
	output  [MEM_BA_WIDTH - 1 : 0]          o_sdram_ba,      //sdram bank address
	output  [10:0]                          o_sdram_addr,    //sdram address
	inout   [MEM_DATA_WIDTH - 1 : 0]        io_sdram_dq       //sdram data
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
/**************************    Led Out         **********************************/
/********************************************************************************/   
logic data_error;
assign o_led = data_error;//0亮 正常，1灭 出错

/********************************************************************************/
/**************************    User Code       **********************************/
/********************************************************************************/  

sdram_test_top #(
    .ADDR_WIDTH          (ADDR_WIDTH          ),
    .MEM_DATA_WIDTH      (MEM_DATA_WIDTH      ),
    .BUSRT_WIDTH         (BUSRT_WIDTH         )
)sdram_test_top_m0(
    .i_sys_clk                  (sdram_clk_100m         ),
    .i_sys_rst                  (sys_rst                ),

    .o_wr_error                 (data_error             ),

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

//sdram controller	
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
    
endmodule