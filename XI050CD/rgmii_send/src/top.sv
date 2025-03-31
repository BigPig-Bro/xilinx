module top(
    input           rst_n,

    output [3:0]    rgmii_txd,
    output          rgmii_txc,
    output          rgmii_txctl,
    // input           rgmii_rxctl,
    // input [3:0]     rgmii_rxd,
    input           rgmii_rxc,
    output          rgmii_rst_n
);


wire gmii_tx_clk,gmii_tx_en,gmii_tx_er;
wire [7:0] gmii_txd;
GMII_send GMII_send_m0(
    .rst_n          (rst_n              ),
    .sys_clk        (gmii_tx_clk        ),

    .GMII_RST_N     (rgmii_rst_n        ),//
    .GMII_GTXCLK    (                   ),//由gmii2rgmii模块提供
    .GMII_TXD       (gmii_txd           ),
    .GMII_TXEN      (gmii_tx_en         ),
    .GMII_TXER      (gmii_tx_er         )
);

util_gmii_to_rgmii util_gmii_to_rgmii_m0(
	.reset              (~rst_n             ),    
    
	.rgmii_td           (rgmii_txd          ),
	.rgmii_tx_ctl       (rgmii_txctl        ),
	.rgmii_txc          (rgmii_txc          ),
	.rgmii_rd           (                   ),
	.rgmii_rx_ctl       (                   ),
	.rgmii_rxc          (rgmii_rxc          ),
    
	.gmii_txd           (gmii_txd           ),
	.gmii_tx_en         (gmii_tx_en         ),
	.gmii_tx_er         (gmii_tx_er         ),
	.gmii_tx_clk        (gmii_tx_clk        ),
	.gmii_rxd           (                   ),
	.gmii_rx_dv         (                   ), 
	.gmii_rx_er         (                   ),
	.gmii_rx_clk        (                   )
    );

// ila_0 ila_0_m0(
//     .clk               (rgmii_rxc           ),
//     .probe0            (gmii_tx_state       ),
//     .probe1            (gmii_tx_en          ),
//     .probe2            (gmii_tx_er          ),
//     .probe3            (gmii_txd            )
// //    .probe4            (                    ),
// //    .probe5            (                    )
// );

endmodule