module top#(
 parameter CLK_FRE = 25,
 parameter UART_RATE = 115200,
 parameter TEST_NUM = 249

)(
    input                   sys_clk,

    output   [TEST_NUM-1:0]  uart_tx
);


logic [3:0][7:0] char_pin[TEST_NUM] = {
"P20 ",
"P22 ",
"R22 ",
"P21 ",
"R21 ",
"U22 ",
"V22 ",
"T21 ",
"U21 ",
"P19 ",
"R19 ",
"T19 ",
"T20 ",
"W21 ",
"W22 ",
"AA20",
"AA21",
"Y21 ",
"Y22 ",
"AB21",
"AB22",
"U20 ",
"V20 ",
"W19 ",
"W20 ",
"Y18 ",
"Y19 ",
"V18 ",
"V19 ",
"AA19",
"AB20",
"V17 ",
"W17 ",
"AA18",
"AB18",
"U17 ",
"U18 ",
"P14 ",
"R14 ",
"R18 ",
"T18 ",
"N17 ",
"P17 ",
"P15 ",
"R16 ",
"N13 ",
"N14 ",
"P16 ",
"R17 ",
"N15 ",
"J16 ",
"H13 ",
"G13 ",
"G15 ",
"G16 ",
"J14 ",
"H14 ",
"G17 ",
"G18 ",
"J15 ",
"H15 ",
"H17 ",
"H18 ",
"J22 ",
"H22 ",
"H20 ",
"G20 ",
"K21 ",
"K22 ",
"M21 ",
"L21 ",
"J20 ",
"J21 ",
"J19 ",
"H19 ",
"K18 ",
"K19 ",
"L19 ",
"L20 ",
"N22 ",
"M22 ",
"M18 ",
"L18 ",
"N18 ",
"N19 ",
"N20 ",
"M20 ",
"K13 ",
"K14 ",
"M13 ",
"L13 ",
"K17 ",
"J17 ",
"L14 ",
"L15 ",
"L16 ",
"K16 ",
"M15 ",
"M16 ",
"M17 ",
"F15 ",
"F13 ",
"F14 ",
"F16 ",
"E17 ",
"C14 ",
"C15 ",
"E13 ",
"E14 ",
"E16 ",
"D16 ",
"D14 ",
"D15 ",
"B15 ",
"B16 ",
"C13 ",
"B13 ",
"A15 ",
"A16 ",
"A13 ",
"A14 ",
"B17 ",
"B18 ",
"D17 ",
"C17 ",
"C18 ",
"C19 ",
"E19 ",
"D19 ",
"F18 ",
"E18 ",
"B20 ",
"A20 ",
"A18 ",
"A19 ",
"F19 ",
"F20 ",
"D20 ",
"C20 ",
"C22 ",
"B22 ",
"B21 ",
"A21 ",
"E22 ",
"D22 ",
"E21 ",
"D21 ",
"G21 ",
"G22 ",
"F21 ",
"T3  ",
"T1  ",
"U1  ",
"U2  ",
"V2  ",
"R3  ",
"R2  ",
"W2  ",
"Y2  ",
"W1  ",
"Y1  ",
"U3  ",
"V3  ",
"AA1 ",
"AB1 ",
"AB3 ",
"AB2 ",
"Y3  ",
"AA3 ",
"AA5 ",
"AB5 ",
"Y4  ",
"AA4 ",
"V4  ",
"W4  ",
"R4  ",
"T4  ",
"T5  ",
"U5  ",
"W6  ",
"W5  ",
"U6  ",
"V5  ",
"R6  ",
"T6  ",
"Y6  ",
"AA6 ",
"V7  ",
"W7  ",
"AB7 ",
"AB6 ",
"V9  ",
"V8  ",
"AA8 ",
"AB8 ",
"Y8  ",
"Y7  ",
"W9  ",
"Y9  ",
"U7  ",
"F4  ",
"B1  ",
"A1  ",
"C2  ",
"B2  ",
"E1  ",
"D1  ",
"E2  ",
"D2  ",
"G1  ",
"F1  ",
"F3  ",
"E3  ",
"K1  ",
"J1  ",
"H2  ",
"G2  ",
"K2  ",
"J2  ",
"J5  ",
"H5  ",
"H3  ",
"G3  ",
"H4  ",
"G4  ",
"J4  ",
"L3  ",
"K3  ",
"M1  ",
"L1  ",
"M3  ",
"M2  ",
"K6  ",
"J6  ",
"L5  ",
"L4  ",
"N4  ",
"N3  ",
"R1  ",
"P1  ",
"P5  ",
"P4  ",
"P2  ",
"N2  ",
"M6  ",
"M5  ",
"P6  ",
"N5  ",
"L6  "
};

genvar i;
generate
for(i=0;i<=TEST_NUM-1;i=i+1)
    begin:uart_top
        uart_top #(
            .CLK_FRE    (CLK_FRE    ),
            .UART_RATE  (UART_RATE  ),
            .SEND_FRE   (1)
        ) uart_top_m0(
        .clk        (sys_clk            ),
        .io_data    (char_pin[i]        ),
        .uart_tx    (uart_tx[i]         ));
    end
endgenerate

endmodule
/**************************************************************************/
module uart_top #(
	parameter CLK_FRE 		= 25,
	parameter UART_RATE 	= 115200,
	parameter SEND_FRE 		= 1
	)(
	input 		clk,    // 
	
	input [31:0] io_data, //�?要发送的IO编号

	output		uart_tx
);

enum {SEND,WAIT}STATE_LOOP;
reg [1:0] state;

reg  [31:0] wait_cnt;
reg  [ 7:0] send_cnt;
reg  [ 7:0] send_data;
reg  	    send_en;


//发�?�寄存器
parameter 	ENG_NUM  = 4;//非中文字符数
parameter 	DATA_NUM = ENG_NUM + 1; 
wire [ DATA_NUM * 8 - 1:0] char_data = {io_data,"\n"};
	
//仲裁机制
always@(posedge clk)
	case(state)
		SEND:begin // 主动发�??
			if(send_cnt == DATA_NUM + 1)begin 
				send_en 	<= 'b0;
				send_cnt 	<=  0;
				state 		<= WAIT;
			end
			else if(!send_busy)begin
				send_en 	<= 'b1;
				send_data 	<= char_data[ (DATA_NUM - 1 - send_cnt) * 8 +: 8];
				send_cnt 	<= send_cnt + 1;
			end
		end

		WAIT:// 回环测试发�??
			if(wait_cnt == CLK_FRE * 1000_000 / SEND_FRE)begin 
				wait_cnt <= 0;
				state <= SEND;
			end
			else begin
				wait_cnt <= wait_cnt + 1;
			end
	endcase

//发�?�模�?
uart_tx #(
	.CLK_FRE 	(CLK_FRE 	),
	.UART_RATE 	(UART_RATE 	)
	)uart_tx_m0(
	.clk 		(clk 		),

	.send_en 	(send_en 	),
	.send_busy 	(send_busy 	),
	.send_data 	(send_data 	),

	.tx_pin 	(uart_tx 	)
	);

endmodule

/**************************************************************************/
// 数据位 8 停止位 1 无奇偶校验
module uart_tx#(
	parameter CLK_FRE 	= 50,
	parameter UART_RATE = 115200
	) (
	input 				clk,    // 
	
	input 				send_en ,	
	output 	 			send_busy ,	
	input 		[ 7:0] 	send_data ,	

	output reg 			tx_pin = 1
);
parameter  RATE_CNT = (CLK_FRE * 1000_000 / UART_RATE) - 1;
reg [25:0] clk_cnt;

enum {WAIT,START,SEND,STOP}STATE_TX;
reg [1:0] state;

assign send_busy = state != WAIT;

reg [ 7:0] send_data_r;
reg [ 2:0] send_cnt;

always@(posedge clk)
	case(state)
		WAIT:
			if(send_en)begin 
				send_data_r <= send_data;
				send_cnt <= 'd0;

				state <= START;
			end

		START:begin 
			tx_pin <= 0;

			if(clk_cnt == RATE_CNT)begin 
				clk_cnt <= 0;
				state <= SEND;
			end
			else
				clk_cnt <= clk_cnt + 1;
		end

		SEND:begin 
			tx_pin <= send_data_r[send_cnt];

			if(clk_cnt == RATE_CNT)begin 
				clk_cnt <= 0;
				send_cnt <= send_cnt + 1;
				state <= (send_cnt == 7 )?STOP : SEND ;
			end
			else
				clk_cnt <= clk_cnt + 1;
		end

		STOP:begin 
			tx_pin <= 1;

			if(clk_cnt == RATE_CNT)begin 
				clk_cnt <= 0;
				state <= WAIT;
			end
			else
				clk_cnt <= clk_cnt + 1;
		end
	endcase
endmodule