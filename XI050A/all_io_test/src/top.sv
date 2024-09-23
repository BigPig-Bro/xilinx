module top(
    input               clk_25M,

    output   [146:0]   uart_tx
);

logic [3:0][7:0] char_pin[147] = {
    "  R2","  P6",
    "  R6","  T1",
    "  T3","  T4",
           "  U2",
    "  U3","  V2",
    "  V3","  W1",
    "  Y1"," AA1",
    " AB1","  W2",
    "  Y2"," AB2",
    " AA3"," AB3",
    "  Y3","  W4",
    " AA4","  Y4",
    " AB5"," AA5",
    "  Y6"," AB6",
    " AA6","  Y7",
    " AB7"," AA8",
    " AB8","  Y8",
    "  W7","  Y9",
    "  V8","  W9",
    "  V9","  R14",
    " P14","  W17",
    " Y18"," AA18",
    " W19"," AB18",
    " Y19"," AA19",
    " V18","  V19",
    "AB20"," AA20",
    "AA21"," AB21",
    " Y21"," AB22",
    " W20","  Y22",
    " W21","  W22",
    " V20","  V22",
    " U21","  U20",
    " T20","  P19",
    " P20","  M18",
    " L19","  K19",
    " K16","  H18",
    " H19","  B17",
    " V17","  P17",
    " U17","  T18",
    " R17","  U18",
    " R18","  N18",
    " R19","  N19",
    " N15","  M16",
    " M15","  L15",
    " L16","  K14",
    " N22","  J14",
    " J15","  J19",
    " H13","  H14",
    " H17","  H15",
    " G18","  G17",
    " G16","  F16",
    " F15","  E17",
    " E16","  D16",
    " D15","  C18", 
    " C17","  B20",
    "  P5","   T6",
    "  U7","   U6",
    "  U5","   V5",
    "  U1","   H3",
    "  J1","   K1",
    "  L1","   M1",
    "  J2","   K2",
    "  K3","   G3",
    "  J4","   G4",
    "  F4","   L4",
    "  R3","   M3",
    "  V4","   R4",
    "  T5","   J5",
    "  J6","   W5",
    "  L5","   L6",
    "  W6","   V7",
    " N13","  N14",
    " P15","  P16",
    " R16","  N17"
};

genvar i;
generate
for(i=0;i<148;i=i+1)
    begin:uart_top
        uart_top #(
            .CLK_FRE    (25),
            .UART_RATE  (115200),
            .SEND_FRE   (1)
        ) uart_top_m0(
        .clk        (clk_25M            ),
        .io_data    (char_pin[i]        ),
        .uart_tx    (uart_tx[i]         ));
    end
endgenerate


endmodule