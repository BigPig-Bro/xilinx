// 双路RGMII以太网测试 — 仅保留ARP/ICMP应答，用户收发悬空
//261108    v1.0.0   初始版本
//说明：两个udp_top分别接板载两个RGMII网口，IP分别为192.168.1.101/192.168.1.102
//      ping哪一路有回应即说明网线插在对应网口上

module eth_test (
    input                       i_rst_n,        //系统复位，低有效
    input                       i_clk_200m,     //200MHz参考时钟（外部PLL，供IDELAYCTRL）
    input                       i_pll_locked,   //200MHz PLL锁定

    //以太网口0（XI050AB RJ1，RXC=L3）192.168.1.101
    input                       i_rgmii0_rxc,   //RGMII接收时钟
    input                       i_rgmii0_rxctl, //RGMII接收控制
    input      [ 3:0]           i_rgmii0_rxd,   //RGMII接收数据
    output                      o_rgmii0_txc,   //RGMII发送时钟
    output                      o_rgmii0_txctl, //RGMII发送控制
    output     [ 3:0]           o_rgmii0_txd,   //RGMII发送数据

    //以太网口1（XI050AB RJ2，RXC=H4）192.168.1.102
    input                       i_rgmii1_rxc,   //RGMII接收时钟
    input                       i_rgmii1_rxctl, //RGMII接收控制
    input      [ 3:0]           i_rgmii1_rxd,   //RGMII接收数据
    output                      o_rgmii1_txc,   //RGMII发送时钟
    output                      o_rgmii1_txctl, //RGMII发送控制
    output     [ 3:0]           o_rgmii1_txd    //RGMII发送数据
);

localparam [ 1:0] P_RGMII_MODE  = 2'd2;         //0-10M 1-100M 2-1000M
localparam [ 4:0] P_IDELAY_TAPS = 5'd20;        //XI050AB RX延时

/********************************************************************************/
/**************************    以太网口0 192.168.1.101  *************************/
/********************************************************************************/
udp_top #(
    .P_LOCAL_MAC        (48'h0202_DEAD_BE01                     ),
    .P_LOCAL_IP         ({8'd192, 8'd168, 8'd1, 8'd101}         ),
    .P_LOCAL_PORT       (16'd5000                               ),
    .P_DST_MAC          (48'hFFFF_FFFF_FFFF                     ),
    .P_DST_IP           ({8'd192, 8'd168, 8'd1, 8'd100}         ),
    .P_DST_PORT         (16'd5000                               ),
    .P_IDELAY_TAPS      (P_IDELAY_TAPS                          ),
    .P_RGMII_MODE       (P_RGMII_MODE                           ),
    .P_IDELAY_CTRL_EN   (1'b1                                   ) //本路例化IDELAYCTRL
)udp_top_m0(
    .i_rst_n            (i_rst_n            ),

    .i_rgmii_rxc        (i_rgmii0_rxc       ),
    .i_rgmii_rxd        (i_rgmii0_rxd       ),
    .i_rgmii_rxctl      (i_rgmii0_rxctl     ),
    .o_rgmii_txd        (o_rgmii0_txd       ),
    .o_rgmii_txctl      (o_rgmii0_txctl     ),
    .o_rgmii_txc        (o_rgmii0_txc       ),
    .i_clk_200m         (i_clk_200m         ),
    .i_pll_locked       (i_pll_locked       ),

    .o_usr_clk          (                   ),
    .o_usr_rx_data      (                   ),
    .o_usr_rx_valid     (                   ),
    .o_usr_rx_last      (                   ),
    .i_usr_tx_data      (8'h00              ),
    .i_usr_tx_wr        (1'b0               ),
    .i_usr_tx_last      (1'b0               ),
    .o_tx_busy          (                   )
);

/********************************************************************************/
/**************************    以太网口1 192.168.1.102  *************************/
/********************************************************************************/
udp_top #(
    .P_LOCAL_MAC        (48'h0202_DEAD_BE02                     ),
    .P_LOCAL_IP         ({8'd192, 8'd168, 8'd1, 8'd102}         ),
    .P_LOCAL_PORT       (16'd5000                               ),
    .P_DST_MAC          (48'hFFFF_FFFF_FFFF                     ),
    .P_DST_IP           ({8'd192, 8'd168, 8'd1, 8'd100}         ),
    .P_DST_PORT         (16'd5000                               ),
    .P_IDELAY_TAPS      (P_IDELAY_TAPS                          ),
    .P_RGMII_MODE       (P_RGMII_MODE                           ),
    .P_IDELAY_CTRL_EN   (1'b0                                   ) //共用同bank另一路IDELAYCTRL
)udp_top_m1(
    .i_rst_n            (i_rst_n            ),

    .i_rgmii_rxc        (i_rgmii1_rxc       ),
    .i_rgmii_rxd        (i_rgmii1_rxd       ),
    .i_rgmii_rxctl      (i_rgmii1_rxctl     ),
    .o_rgmii_txd        (o_rgmii1_txd       ),
    .o_rgmii_txctl      (o_rgmii1_txctl     ),
    .o_rgmii_txc        (o_rgmii1_txc       ),
    .i_clk_200m         (i_clk_200m         ),
    .i_pll_locked       (i_pll_locked       ),

    .o_usr_clk          (                   ),
    .o_usr_rx_data      (                   ),
    .o_usr_rx_valid     (                   ),
    .o_usr_rx_last      (                   ),
    .i_usr_tx_data      (8'h00              ),
    .i_usr_tx_wr        (1'b0               ),
    .i_usr_tx_last      (1'b0               ),
    .o_tx_busy          (                   )
);

endmodule
