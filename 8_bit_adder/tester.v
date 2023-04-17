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
	#0	ENB	=	0;
	#0	MODO	=	2'b00;
	#0	A	=	8'b0;
	#0	B	=	8'b0;
	#0	RCI	=	2'b00;
	#5	ENB	=	1;
	#25	MODO	=	2'b10; // Resta
	#0	A	=	8'b01100100;
	#0	B	=	8'b01100000;
	#25	MODO	=	2'b01; // Suma
	#0	A	=	8'b00001000;
	#0	B	=	8'b00010000;
	#25	MODO	=	2'b00; // Mantener
	#0	A	=	8'b00001001;
	#0	B	=	8'b00000111;
	#25	MODO	=	2'b11; // Reset
	#0	A	=	8'b00110010;
	#0	B	=	8'b00011010;
	#25	$finish;
end


endmodule
