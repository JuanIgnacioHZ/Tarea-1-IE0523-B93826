// Actual test code for the adder module
module tester
		#(parameter N=1)	// Placeholder value, the working one is declared in the testbench file
		(
		CLK,	// Clock signal
		ENB,	// Enable signal
		MODO,	// Mode select
		A,	// A input number
		B,	// B input number
		RCI,	// Ripple counter input
		Q,	// Output number output
		RCO);	// Ripple counter output

// For the tester, inputs and outputs are swapped respect to the DUT,
// thus allowing to interact and manipulate the other module
// Input declaration
input [N-1:0] [3:0] Q;
input RCO;

// Output declaration
output CLK, ENB;
output [1:0] MODO;
output RCI;
output [N-1:0] [3:0] A;
output [N-1:0] [3:0] B;

// Wires and regs are inverted as well
reg CLK, ENB;
reg [1:0] MODO;
reg RCI;
reg [N-1:0] [3:0] A;
reg [N-1:0] [3:0] B;

wire [N-1:0] [3:0] Q;
wire RCO;

// Half frequency definition, in terms of time units
parameter h_freq=1;

// CLK signal setup
always begin
	#h_freq CLK = !CLK;
end

// Testing starts after this line
initial begin

	#0	CLK	=	0;
		ENB	=	0;
		MODO	=	2'b00;
		A	=	8'b0;
		B	=	8'b0;
		RCI	=	2'b00;
	#5	ENB	=	1;
		MODO	=	2'b11;
	#10	MODO	=	2'b10; // Resta
		A	=	4'b0110;
		B	=	4'b0010;
	#10	A	=	4'b0101;
		B	=	4'b0101;
	#10	A	=	4'b0010;
		B	=	4'b1000;
	#10	MODO	=	2'b11; // Setea a 0 
	#10	MODO	=	2'b01; // SumaS
		A	=	4'b0110;
		B	=	4'b0101;
	#10	A	=	4'b1000;
		B	=	4'b0100;
	#10	A	=	4'b1111;
		B	=	4'b0001;
	#10	MODO	=	2'b00; // Mantener
		A	=	4'b0101;
		B	=	4'b0010;
	#10	MODO	=	2'b11; // Reset
		A	=	4'b1111;
		B	=	4'b0000;
	#10	RCI	=	1;
	#10	MODO	=	2'b11; // Setea a 0
	#10	MODO	=	2'b10; // Resta
		A	=	4'b0110;
		B	=	4'b0010;
	#10	A	=	4'b0101;
		B	=	4'b0101;
	#10	A	=	4'b0010;
		B	=	4'b1000;
	#10	MODO	=	2'b11; // Setea a 0
	#10	MODO	=	2'b01; // Suma
		A	=	4'b0110;
		B	=	4'b0101;
	#10	A	=	4'b1000;
		B	=	4'b0100;
	#10	A	=	4'b1111;
		B	=	4'b0001;
	#10	MODO	=	2'b00; // Mantener
		A	=	4'b0101;
		B	=	4'b0010;
	#10	MODO	=	2'b01; // Reset
		A	=	4'b1111;
		B	=	4'b0000;
	#10	ENB	=	0;
		RCI	=	0;
	#10	MODO	=	2'b11; // Setea a 0
		MODO	=	2'b10; // Resta
		A	=	4'b0110;
		B	=	4'b0010;
	#10	A	=	4'b0101;
		B	=	4'b0101;
	#10	A	=	4'b0010;
		B	=	4'b1000;
	#10	MODO	=	2'b11; // Setea a 0
	#10	MODO	=	2'b01; // Suma
		A	=	4'b0110;
		B	=	4'b0101;
	#10	A	=	4'b1000;
		B	=	4'b0100;
	#10	A	=	4'b1111;
		B	=	4'b0001;
	#10	MODO	=	2'b00; // Mantener
		A	=	4'b0101;
		B	=	4'b0010;
	#10	MODO	=	2'b11; // Reset
		A	=	4'b1111;
		B	=	4'b0000;
	#10	RCI	=	1;
	#10	MODO	=	2'b11; // Setea a 0
	#10	MODO	=	2'b10; // Resta
		A	=	4'b0110;
		B	=	4'b0010;
	#10	A	=	4'b0101;
		B	=	4'b0101;
	#10	A	=	4'b0010;
		B	=	4'b1000;
	#10	MODO	=	2'b11; // Setea a 0
	#10	MODO	=	2'b01; // Suma
		A	=	4'b0110;
		B	=	4'b0101;
	#10	A	=	4'b1000;
		B	=	4'b0100;
	#10	A	=	4'b1111;
		B	=	4'b0001;
	#10	MODO	=	2'b00; // Mantener
		A	=	4'b0101;
		B	=	4'b0010;
	#10	MODO	=	2'b11; // Reset
		A	=	4'b1111;
		B	=	4'b0000;
	#10	$finish;
end


endmodule
