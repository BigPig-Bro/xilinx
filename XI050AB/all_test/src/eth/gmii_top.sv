// GMII TOP — RGMII桥接 + RX帧解码 + TX帧发送
// V1.0.0
//
module gmii_top #(
    parameter [ 4:0] P_IDELAY_TAPS    = 5'd12,
    parameter [ 1:0] P_RGMII_MODE     = 2'd1, // 0:10M SDR, 1:100M SDR, 2:1G DDR
    parameter        P_IDELAY_CTRL_EN = 1'b1  // 1:例化IDELAYCTRL 0:共用同bank已有IDELAYCTRL
    ) (
    input                               i_rst_n,
    // RGMII 引脚
    input                               i_rgmii_rxc,
    input                       [ 3:0]  i_rgmii_rxd,
    input                               i_rgmii_rxctl,
    output                      [ 3:0]  o_rgmii_txd,
    output                              o_rgmii_txctl,
    output                              o_rgmii_txc,

    output                              o_usr_clk,
    // 外部200MHz参考时钟
    input                               i_clk_200m,
    input                               i_pll_locked,
    // RX 帧流输出
    output      logic           [ 7:0]  o_rx_data,
    output      logic                   o_rx_valid,
    output      logic                   o_rx_last,
    // TX 帧流输入
    input                       [ 7:0]  i_tx_data,
    input                               i_tx_wr,
    input                               i_tx_last,
    output      logic                   o_tx_busy
    );
/////////////////////////////////////////////////////////////////////////////////////////
////////////////////                 内部信号                /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
logic [7:0]                     gmii_rx_data;
logic                           gmii_rx_dv;
logic [7:0]                     gmii_tx_data;
logic                           gmii_tx_en;

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////          GMII ↔ RGMII 桥接            /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
gmii2rgmii #(
    .P_IDELAY_TAPS              (P_IDELAY_TAPS              ),
    .P_RGMII_MODE               (P_RGMII_MODE               ),
    .P_IDELAY_CTRL_EN           (P_IDELAY_CTRL_EN           )
) gmii2rgmii_m0 (
    .i_rst_n                    (i_rst_n                    ),
    // ---- RGMII 引脚 ----
    .i_rgmii_rxc                (i_rgmii_rxc                ),
    .i_rgmii_rxd                (i_rgmii_rxd                ),
    .i_rgmii_rxctl              (i_rgmii_rxctl              ),
    .o_rgmii_txd                (o_rgmii_txd                ),
    .o_rgmii_txctl              (o_rgmii_txctl              ),
    .o_rgmii_txc                (o_rgmii_txc                ),

    .o_usr_clk                  (o_usr_clk                  ),
    .i_clk_200m                 (i_clk_200m                 ),
    .i_pll_locked               (i_pll_locked               ),
    // ---- GMII RX ----
    .o_rx_data                  (gmii_rx_data               ),
    .o_rx_dv                    (gmii_rx_dv                 ),
    .o_rx_er                    (                           ),
    // ---- GMII TX ----
    .i_tx_data                  (gmii_tx_data               ),
    .i_tx_en                    (gmii_tx_en                 ),
    .i_tx_er                    (1'b0                       )
);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////             GMII RX 帧解码             /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
gmii_rx gmii_rx_m0 (
    .i_sys_clk                  (o_usr_clk                  ),
    .i_rst_n                    (i_rst_n                    ),
    // ---- GMII 输入 ----
    .i_rx_data                  (gmii_rx_data               ),
    .i_rx_dv                    (gmii_rx_dv                 ),
    // ---- 帧流输出 ----
    .o_rx_data                  (o_rx_data                  ),
    .o_rx_valid                 (o_rx_valid                 ),
    .o_rx_last                  (o_rx_last                  )
);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////             GMII TX 发送(+FCS)         /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
gmii_tx gmii_tx_m0 (
    .i_sys_clk                  (o_usr_clk                  ),
    .i_rst_n                    (i_rst_n                    ),
    // ---- 帧流输入 ----
    .i_tx_data                  (i_tx_data                  ),
    .i_tx_wr                    (i_tx_wr                    ),
    .i_tx_last                  (i_tx_last                  ),
    .o_tx_busy                  (o_tx_busy                  ),
    // ---- GMII 输出 ----
    .o_tx_data                  (gmii_tx_data               ),
    .o_tx_en                    (gmii_tx_en                 )
);

endmodule
