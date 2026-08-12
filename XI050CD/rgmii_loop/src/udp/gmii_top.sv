// GMII TOP — RGMII桥接 + RX帧解码 + TX帧发送
// V1.0.0
//
module gmii_top #(
    parameter [ 4:0] P_IDELAY_TAPS   = 5'd12
    ) (
    input                               i_sys_clk,
    input                               i_rst_n,
    // RGMII 引脚
    input                       [ 3:0]  i_rgmii_rxd,
    input                               i_rgmii_rxctl,
    output                      [ 3:0]  o_rgmii_txd,
    output                              o_rgmii_txctl,
    output                              o_rgmii_txc,
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
    .P_IDELAY_TAPS              (P_IDELAY_TAPS              )
) gmii2rgmii_m0 (
    .i_sys_clk                  (i_sys_clk                  ),
    .i_rst_n                    (i_rst_n                    ),
    // ---- RGMII 引脚 ----
    .i_rgmii_rxd                (i_rgmii_rxd                ),
    .i_rgmii_rxctl              (i_rgmii_rxctl              ),
    .o_rgmii_txd                (o_rgmii_txd                ),
    .o_rgmii_txctl              (o_rgmii_txctl              ),
    .o_rgmii_txc                (o_rgmii_txc                ),
    // ---- GMII RX ----
    .o_rx_data                  (gmii_rx_data               ),
    .o_rx_dv                    (gmii_rx_dv                 ),
    .o_rx_er                    (                           ),
    // ---- GMII TX ----
    .i_tx_data                  (gmii_tx_data               ),
    .i_tx_en                    (gmii_tx_en                 )
);

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////             GMII RX 帧解码             /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
gmii_rx gmii_rx_m0 (
    .i_sys_clk                  (i_sys_clk                  ),
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
    .i_sys_clk                  (i_sys_clk                  ),
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
