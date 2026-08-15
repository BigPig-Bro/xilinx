// RGMII 千兆以太网核 — V1.0.0
//
module top (
    input                               i_clk_25,
    input                               i_rst_n,
    
    input                               i_rgmii_rxc,
    input                               i_rgmii_rxctl,
    input                       [ 3:0]  i_rgmii_rxd,
    output                              o_rgmii_txc,
    output                              o_rgmii_txctl,
    output                      [ 3:0]  o_rgmii_txd,
    output                              o_rgmii_rst_n,

    output                              o_uart_tx,
    input                               i_uart_rx
);
assign o_rgmii_rst_n = i_rst_n;

localparam [47:0] P_LOCAL_MAC   = 48'h0202_DEAD_BEEF;
localparam [31:0] P_LOCAL_IP    = {8'd192, 8'd168, 8'd1, 8'd210};
// localparam [47:0] P_DST_MAC     = 48'h00e0_4c70_00ab; //TM1703
localparam [47:0] P_DST_MAC     = 48'h10FF_E0F7_CEE0;//Work PC
//localparam [47:0] P_DST_MAC     = 48'h00e0_4c68_0ffa;//Home PC
localparam [31:0] P_DST_IP      = {8'd192, 8'd168, 8'd1, 8'd100};
localparam [15:0] P_DST_PORT    = 16'd8000;
localparam [15:0] P_SRC_PORT    = 16'd8000;
localparam [ 4:0] P_IDELAY_TAPS = 5'd12; //XI050CD-12 
localparam        P_UART_CLK    = 125_000_000;
localparam        P_UART_BAUD   = 115200;

logic       tx_busy;
logic [7:0] usr_rx_data;
logic       usr_rx_valid, usr_rx_last;
logic [7:0] usr_tx_data, usr_in_tx_data;
logic       usr_tx_wr, usr_in_tx_wr;
logic       usr_tx_last, usr_in_tx_last;
logic [7:0] loop_tx_data;
logic       loop_tx_wr, loop_tx_last;
logic       usr_clk;

// === User TX 合并（loop_top 优先于 user_top）===
assign usr_in_tx_data = loop_tx_wr ? loop_tx_data : usr_tx_data;
assign usr_in_tx_wr   = loop_tx_wr | usr_tx_wr;
assign usr_in_tx_last = loop_tx_wr ? loop_tx_last : usr_tx_last;

// === UDP TOP ===
udp_top #(
    .P_LOCAL_MAC  (P_LOCAL_MAC  ),
    .P_LOCAL_IP   (P_LOCAL_IP   ),
    .P_DST_MAC    (P_DST_MAC    ),
    .P_DST_IP     (P_DST_IP     ),
    .P_DST_PORT   (P_DST_PORT   ),
    .P_SRC_PORT   (P_SRC_PORT   ),
    .P_IDELAY_TAPS(P_IDELAY_TAPS)
) udp_top_m0 (
    .i_rst_n       (i_rst_n       ),

    .i_rgmii_rxc   (i_rgmii_rxc   ),
    .i_rgmii_rxd   (i_rgmii_rxd   ),
    .i_rgmii_rxctl (i_rgmii_rxctl ),
    .o_rgmii_txd   (o_rgmii_txd   ),
    .o_rgmii_txctl (o_rgmii_txctl ),
    .o_rgmii_txc   (o_rgmii_txc   ),

    .o_usr_clk     (usr_clk       ),
    .o_usr_rx_data (usr_rx_data   ),
    .o_usr_rx_valid(usr_rx_valid  ),
    .o_usr_rx_last (usr_rx_last   ),
    .i_usr_tx_data (usr_in_tx_data),
    .i_usr_tx_wr   (usr_in_tx_wr  ),
    .i_usr_tx_last (usr_in_tx_last),
    .o_tx_busy     (tx_busy       )
);

// === TEST TOP ===
test_top #(
    .P_LOCAL_MAC(P_LOCAL_MAC),
    .P_LOCAL_IP (P_LOCAL_IP ),
    .P_DST_MAC  (P_DST_MAC  ),
    .P_DST_IP   (P_DST_IP   ),
    .P_DST_PORT (P_DST_PORT ),
    .P_SRC_PORT (P_SRC_PORT ),
    .P_UART_CLK (P_UART_CLK ),
    .P_UART_BAUD(P_UART_BAUD)
) test_top_m0 (
    .i_sys_clk (i_rgmii_rxc ),
    .i_rst_n   (i_rst_n     ),
    .i_tx_busy (tx_busy     ),
    .o_tx_data (usr_tx_data ),
    .o_tx_wr   (usr_tx_wr   ),
    .o_tx_last (usr_tx_last ),
    .i_uart_rx (i_uart_rx   ),
    .o_uart_tx (o_uart_tx   )
);

// === LOOP TOP ===
loop_top loop_top_m0 (
    .i_sys_clk   (i_rgmii_rxc  ),
    .i_rst_n     (i_rst_n      ),
    .i_rx_data   (usr_rx_data  ),
    .i_rx_valid  (usr_rx_valid ),
    .i_rx_last   (usr_rx_last  ),
    .i_local_mac (P_LOCAL_MAC  ),
    .i_local_ip  (P_LOCAL_IP   ),
    .i_tx_busy   (tx_busy      ),
    .o_tx_data   (loop_tx_data ),
    .o_tx_wr     (loop_tx_wr   ),
    .o_tx_last   (loop_tx_last )
);

endmodule
