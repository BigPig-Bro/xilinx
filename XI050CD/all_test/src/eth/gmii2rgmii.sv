// RGMII ↔ GMII 桥接 — 10/100M SDR + 1G DDR 双模式
//260814 V1.0.0 初始版本 仅支持rgmii 1G
//260819 V1.1.0 修改支持rgmii 10/100M
//260819 V1.2.0 合并SDR/DDR双模式，P_RGMII_MODE参数选择
module gmii2rgmii #(
    parameter [ 4:0] P_IDELAY_TAPS = 5'd12,
    parameter [ 1:0] P_RGMII_MODE  = 2'd1  // 0:10M SDR, 1:100M SDR, 2:1G DDR
    ) (
    input                               i_rst_n,
    // RGMII 引脚侧
    input                               i_rgmii_rxc,
    input                       [ 3:0]  i_rgmii_rxd,
    input                               i_rgmii_rxctl,
    output      logic           [ 3:0]  o_rgmii_txd,
    output      logic                   o_rgmii_txctl,
    output                              o_rgmii_txc,

    output                              o_usr_clk,
    // 外部200MHz参考时钟（供IDELAYCTRL，替代原内部PLL）
    input                               i_clk_200m,
    input                               i_pll_locked,
    // GMII RX (字节流输出)
    output      logic           [ 7:0]  o_rx_data,
    output      logic                   o_rx_dv,
    output      logic                   o_rx_er,
    // GMII TX (字节流输入)
    input                       [ 7:0]  i_tx_data,
    input                               i_tx_en,
    input                               i_tx_er
    );

genvar gi;

generate
    /////////////////////////////////////////////////////////////////////////////
    // 1G DDR 模式：RXC=125MHz，IDELAYCTRL + IDELAYE2 + IDDR + ODDR
    /////////////////////////////////////////////////////////////////////////////
    if (P_RGMII_MODE == 2'd2) begin : gen_rgmii_1g
        logic                           clk_200m, pll_locked;
        logic [3:0]                     rxd_rise, rxd_fall;
        logic                           rxctl_rise, rxctl_fall;

        assign                          o_usr_clk = i_rgmii_rxc;

        ////////////////////////////////////////////////////////////////
        // rx_dly_pll (125M→200MHz)
        ////////////////////////////////////////////////////////////////
        assign                          clk_200m = i_clk_200m;
        assign                          pll_locked = i_pll_locked;

        ////////////////////////////////////////////////////////////////
        // IDELAYCTRL
        ////////////////////////////////////////////////////////////////
        IDELAYCTRL idelay_ctrl (
            .REFCLK                     (clk_200m                   ),
            .RST                        (~pll_locked                ),
            .RDY                        (                           )
        );

        ////////////////////////////////////////////////////////////////
        // IDELAYE2 + IDDR RXD[3:0]
        ////////////////////////////////////////////////////////////////
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
                .C                      (o_usr_clk       ),
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
                .C                      (o_usr_clk       ),
                .CE                     (1'b1            ),
                .D                      (rxd_delayed     ),
                .R                      (1'b0            ),
                .S                      (1'b0            )
            );
        end

        ////////////////////////////////////////////////////////////////
        // IDELAYE2 + IDDR RXCTL
        ////////////////////////////////////////////////////////////////
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
            .C                      (o_usr_clk       ),
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
            .C                      (o_usr_clk       ),
            .CE                     (1'b1            ),
            .D                      (rxctl_delayed   ),
            .R                      (1'b0            ),
            .S                      (1'b0            )
        );

        // GMII RX 字节拼接
        assign o_rx_data = {rxd_fall, rxd_rise};
        assign o_rx_dv   = rxctl_rise;
        assign o_rx_er   = rxctl_rise ^ rxctl_fall;

        ////////////////////////////////////////////////////////////////
        // ODDR TXD[3:0] + TXCTL + TXC
        ////////////////////////////////////////////////////////////////
        for (gi = 0; gi < 4; gi++) begin : gen_txd
            ODDR #(
                .DDR_CLK_EDGE           ("SAME_EDGE"    ),
                .INIT                   (1'b0            ),
                .SRTYPE                 ("ASYNC"        )
            ) oddr_txd (
                .Q                      (o_rgmii_txd[gi] ),
                .C                      (o_usr_clk       ),
                .CE                     (1'b1            ),
                .D1                     (i_tx_data[gi]   ),
                .D2                     (i_tx_data[gi+4] ),
                .R                      (1'b0            ),
                .S                      (1'b0            )
            );
        end

        // TXCTL ODDR
        ODDR #(
            .DDR_CLK_EDGE           ("SAME_EDGE"      ),
            .INIT                   (1'b0             ),
            .SRTYPE                 ("ASYNC"          )
        ) oddr_txctl (
            .Q                      (o_rgmii_txctl     ),
            .C                      (o_usr_clk         ),
            .CE                     (1'b1              ),
            .D1                     (i_tx_en           ),
            .D2                     (i_tx_en ^ i_tx_er ),
            .R                      (1'b0              ),
            .S                      (1'b0              )
        );

        // TXC ODDR (125MHz clock out)
        ODDR #(
            .DDR_CLK_EDGE           ("SAME_EDGE"    ),
            .INIT                   (1'b0            ),
            .SRTYPE                 ("ASYNC"        )
        ) oddr_txc (
            .Q                      (o_rgmii_txc     ),
            .C                      (o_usr_clk       ),
            .CE                     (1'b1            ),
            .D1                     (1'b1            ),
            .D2                     (1'b0            ),
            .R                      (1'b0            ),
            .S                      (1'b0            )
        );
    end else begin : gen_rgmii_10_100
        /////////////////////////////////////////////////////////////////////////////
        // 10/100M SDR 模式：RXC=25MHz(100M)/2.5MHz(10M)，RXC 2分频作为 o_usr_clk
        /////////////////////////////////////////////////////////////////////////////
        logic                           usr_clk_div, usr_clk_bufg;
        logic [3:0]                     rxd_q;
        logic                           rxctl_q;
        logic [3:0]                     rxd_lo;
        logic                           rxctl_lo;
        logic                           rx_phase;
        logic                           rxctl_sdr_prev;
        logic [7:0]                     rx_data_rxc;
        logic                           rx_dv_rxc;
        logic                           rx_er_rxc;
        logic [7:0]                     tx_data_usr;
        logic                           tx_en_usr, tx_er_usr;
        logic [7:0]                     tx_data_q;
        logic                           tx_en_q, tx_er_q;

        ////////////////////////////////////////////////////////////////
        // 用户时钟：RXC 2分频 (12.5M/1.25M)
        ////////////////////////////////////////////////////////////////
        always_ff @(posedge i_rgmii_rxc) begin
            if (!i_rst_n)
                usr_clk_div <= 1'b0;
            else
                usr_clk_div <= ~usr_clk_div;
        end

        BUFG bufg_usr_clk (
            .I                          (usr_clk_div                ),
            .O                          (usr_clk_bufg               )
        );

        assign                          o_usr_clk = usr_clk_bufg;

        ////////////////////////////////////////////////////////////////
        // RX SDR 4bit → GMII 8bit 字节拼接
        ////////////////////////////////////////////////////////////////
        // RGMII RX 输入先在 RXC 域打一拍，再做半字节拼接；RX_DV 上升沿强制对齐到低半字节，
        // 之后两个半字节拼成一个 8bit 字节输出到 o_usr_clk(RXC/2) 域。
        always_ff @(posedge i_rgmii_rxc) begin
            if (!i_rst_n) begin
                rxd_q   <= 4'd0;
                rxctl_q <= 1'b0;
            end else begin
                rxd_q   <= i_rgmii_rxd;
                rxctl_q <= i_rgmii_rxctl;
            end
        end

        always_ff @(posedge i_rgmii_rxc) begin
            if (!i_rst_n) begin
                rx_phase        <= 1'b0;
                rxd_lo          <= 4'd0;
                rxctl_lo        <= 1'b0;
                rxctl_sdr_prev  <= 1'b0;
                rx_data_rxc     <= 8'h00;
                rx_dv_rxc       <= 1'b0;
                rx_er_rxc       <= 1'b0;
            end else begin
                rxctl_sdr_prev  <= rxctl_q;

                if (rxctl_q && !rxctl_sdr_prev) begin
                    // RX_DV 上升沿：本拍是字节的低半字节
                    rx_phase    <= 1'b1;
                    rxd_lo      <= rxd_q;
                    rxctl_lo    <= rxctl_q;
                end else if (!rx_phase) begin
                    // 低半字节
                    rx_phase    <= 1'b1;
                    rxd_lo      <= rxd_q;
                    rxctl_lo    <= rxctl_q;
                end else begin
                    // 高半字节：拼成一个字节
                    rx_phase    <= 1'b0;
                    rx_data_rxc <= {rxd_q, rxd_lo};
                    rx_dv_rxc   <= rxctl_q && rxctl_lo;
                    rx_er_rxc   <= 1'b0; // SDR 模式无独立 RX_ER
                end
            end
        end

        // RX 输出在 o_usr_clk 域重采样（打拍）
        always_ff @(posedge usr_clk_bufg) begin
            if (!i_rst_n) begin
                o_rx_data   <= 8'h00;
                o_rx_dv     <= 1'b0;
                o_rx_er     <= 1'b0;
            end else begin
                o_rx_data   <= rx_data_rxc;
                o_rx_dv     <= rx_dv_rxc;
                o_rx_er     <= rx_er_rxc;
            end
        end

        ////////////////////////////////////////////////////////////////
        // TX GMII 8bit → RGMII 4bit SDR 串行化
        ////////////////////////////////////////////////////////////////
        // 先在 o_usr_clk 域对 GMII TX 输入重采样，避免在 RXC 边沿直接采到正在变化的用户数据；
        // 再在 RXC 域按 SDR 串行化：低半字节 → 高半字节。TXC 直接使用 RXC。
        always_ff @(posedge usr_clk_bufg) begin
            if (!i_rst_n) begin
                tx_data_usr <= 8'h00;
                tx_en_usr   <= 1'b0;
                tx_er_usr   <= 1'b0;
            end else begin
                tx_data_usr <= i_tx_data;
                tx_en_usr   <= i_tx_en;
                tx_er_usr   <= i_tx_er;
            end
        end

        always_ff @(posedge i_rgmii_rxc) begin
            if (!i_rst_n) begin
                o_rgmii_txd     <= 4'd0;
                o_rgmii_txctl   <= 1'b0;
                tx_data_q       <= 8'h00;
                tx_en_q         <= 1'b0;
                tx_er_q         <= 1'b0;
            end else begin
                if (!usr_clk_div) begin
                    // 低半字节（o_usr_clk 上升沿对应的 RXC 上升沿）
                    o_rgmii_txd   <= tx_data_q[3:0];
                    o_rgmii_txctl <= tx_en_q;
                end else begin
                    // 高半字节（o_usr_clk 下降沿对应的 RXC 上升沿），并锁存 o_usr_clk 域打拍后的下一字节
                    o_rgmii_txd   <= tx_data_q[7:4];
                    o_rgmii_txctl <= tx_en_q ^ tx_er_q;
                    tx_data_q     <= tx_data_usr;
                    tx_en_q       <= tx_en_usr;
                    tx_er_q       <= tx_er_usr;
                end
            end
        end

        // TXC：SDR 模式直接使用 RXC 作为输出时钟（不使用 ODDR）
        assign o_rgmii_txc = i_rgmii_rxc;
    end
endgenerate

endmodule
