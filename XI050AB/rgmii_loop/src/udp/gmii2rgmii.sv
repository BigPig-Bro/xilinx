// RGMII ↔ GMII 桥接 — MMCME2 + IDELAYCTRL + IDELAYE2 + IDDR + ODDR
// V1.0.0
//
module gmii2rgmii #(
    parameter [ 4:0] P_IDELAY_TAPS = 5'd12
    ) (
    input                               i_sys_clk,
    input                               i_rst_n,
    // RGMII 引脚侧
    input                       [ 3:0]  i_rgmii_rxd,
    input                               i_rgmii_rxctl,
    output                      [ 3:0]  o_rgmii_txd,
    output                              o_rgmii_txctl,
    output                              o_rgmii_txc,
    // GMII RX (字节流输出)
    output      logic           [ 7:0]  o_rx_data,
    output      logic                   o_rx_dv,
    output      logic                   o_rx_er,
    // GMII TX (字节流输入)
    input                       [ 7:0]  i_tx_data,
    input                               i_tx_en
    );
/////////////////////////////////////////////////////////////////////////////////////////
////////////////////                 内部信号                /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
logic                           clk_200m, pll_locked;
logic [3:0]                     rxd_rise, rxd_fall;
logic                           rxctl_rise, rxctl_fall;

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////          rx_dly_pll (125M→200MHz)     /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
rx_dly_pll rx_dly_pll_m0 (
    .clk_in1                    (i_sys_clk                  ),
    .reset                      (~i_rst_n                   ),
    .clk_out1                   (clk_200m                   ),
    .locked                     (pll_locked                 )
);
/////////////////////////////////////////////////////////////////////////////////////////
////////////////////              IDELAYCTRL              /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
IDELAYCTRL idelay_ctrl (
    .REFCLK                     (clk_200m                   ),
    .RST                        (~pll_locked                ),
    .RDY                        (                           )
);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////         IDELAYE2 + IDDR RXD[3:0]     /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
genvar gi;
generate
    for (gi = 0; gi < 4; gi++) begin : gen_rxd
        logic rxd_delayed;

        IDELAYE2 #(
            .CINVCTRL_SEL           ("FALSE"        ),
            .DELAY_SRC              ("IDATAIN"      ),
            .HIGH_PERFORMANCE_MODE  ("TRUE"         ),
            .IDELAY_TYPE            ("FIXED"        ),
            .IDELAY_VALUE           (P_IDELAY_TAPS   ),
            .PIPE_SEL               ("FALSE"        ),
            .REFCLK_FREQUENCY       (200.0           ),
            .SIGNAL_PATTERN         ("DATA"         )
        ) idelay_rxd (
            .DATAOUT                (rxd_delayed     ),
            .DATAIN                 (1'b0            ),
            .C                      (i_sys_clk       ),
            .CE                     (1'b0            ),
            .INC                    (1'b0            ),
            .IDATAIN                (i_rgmii_rxd[gi] ),
            .CNTVALUEIN             (5'd0            ),
            .CNTVALUEOUT            (                ),
            .LD                     (1'b0            ),
            .LDPIPEEN               (1'b0            ),
            .REGRST                 (1'b0            )
        );

        IDDR #(
            .DDR_CLK_EDGE           ("SAME_EDGE_PIPELINED"),
            .INIT_Q1                (1'b0            ),
            .INIT_Q2                (1'b0            ),
            .SRTYPE                 ("ASYNC"        )
        ) iddr_rxd (
            .Q1                     (rxd_rise[gi]    ),
            .Q2                     (rxd_fall[gi]    ),
            .C                      (i_sys_clk       ),
            .CE                     (1'b1            ),
            .D                      (rxd_delayed     ),
            .R                      (1'b0            ),
            .S                      (1'b0            )
        );
    end
endgenerate

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////        IDELAYE2 + IDDR RXCTL        /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
logic rxctl_delayed;

IDELAYE2 #(
    .CINVCTRL_SEL           ("FALSE"        ),
    .DELAY_SRC              ("IDATAIN"      ),
    .HIGH_PERFORMANCE_MODE  ("TRUE"         ),
    .IDELAY_TYPE            ("FIXED"        ),
    .IDELAY_VALUE           (P_IDELAY_TAPS   ),
    .PIPE_SEL               ("FALSE"        ),
    .REFCLK_FREQUENCY       (200.0           ),
    .SIGNAL_PATTERN         ("DATA"         )
) idelay_rxctl (
    .DATAOUT                (rxctl_delayed   ),
    .DATAIN                 (1'b0            ),
    .C                      (i_sys_clk       ),
    .CE                     (1'b0            ),
    .INC                    (1'b0            ),
    .IDATAIN                (i_rgmii_rxctl   ),
    .CNTVALUEIN             (5'd0            ),
    .CNTVALUEOUT            (                ),
    .LD                     (1'b0            ),
    .LDPIPEEN               (1'b0            ),
    .REGRST                 (1'b0            )
);

IDDR #(
    .DDR_CLK_EDGE           ("SAME_EDGE_PIPELINED"),
    .INIT_Q1                (1'b0            ),
    .INIT_Q2                (1'b0            ),
    .SRTYPE                 ("ASYNC"        )
) iddr_rxctl (
    .Q1                     (rxctl_rise      ),
    .Q2                     (rxctl_fall      ),
    .C                      (i_sys_clk       ),
    .CE                     (1'b1            ),
    .D                      (rxctl_delayed   ),
    .R                      (1'b0            ),
    .S                      (1'b0            )
);

// GMII RX 字节拼接
assign o_rx_data = {rxd_fall, rxd_rise};
assign o_rx_dv   = rxctl_rise;
assign o_rx_er   = rxctl_rise ^ rxctl_fall;

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////           ODDR TXD[3:0] + TXCTL        /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
generate
    for (gi = 0; gi < 4; gi++) begin : gen_txd
        ODDR #(
            .DDR_CLK_EDGE           ("SAME_EDGE"    ),
            .INIT                   (1'b0            ),
            .SRTYPE                 ("ASYNC"        )
        ) oddr_txd (
            .Q                      (o_rgmii_txd[gi] ),
            .C                      (i_sys_clk       ),
            .CE                     (1'b1            ),
            .D1                     (i_tx_data[gi]   ),
            .D2                     (i_tx_data[gi+4] ),
            .R                      (1'b0            ),
            .S                      (1'b0            )
        );
    end
endgenerate

// TXCTL ODDR
ODDR #(
    .DDR_CLK_EDGE           ("SAME_EDGE"    ),
    .INIT                   (1'b0            ),
    .SRTYPE                 ("ASYNC"        )
) oddr_txctl (
    .Q                      (o_rgmii_txctl   ),
    .C                      (i_sys_clk       ),
    .CE                     (1'b1            ),
    .D1                     (i_tx_en         ),
    .D2                     (i_tx_en         ),
    .R                      (1'b0            ),
    .S                      (1'b0            )
);

// TXC ODDR (125MHz clock out)
ODDR #(
    .DDR_CLK_EDGE           ("SAME_EDGE"    ),
    .INIT                   (1'b0            ),
    .SRTYPE                 ("ASYNC"        )
) oddr_txc (
    .Q                      (o_rgmii_txc     ),
    .C                      (i_sys_clk       ),
    .CE                     (1'b1            ),
    .D1                     (1'b1            ),
    .D2                     (1'b0            ),
    .R                      (1'b0            ),
    .S                      (1'b0            )
);

endmodule
