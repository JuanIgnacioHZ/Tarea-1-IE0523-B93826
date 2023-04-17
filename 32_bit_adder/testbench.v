`include "adder.v"
`include "tester.v"

// Adder testbench
module adder_tb;
// First, the working variable for parameter N is declared
// this tells how many 4 bit adders are generated
parameter N = 8;
// reg elsewhere and this file only connects them
wire CLK, ENB;			// Inputs
wire [1:0] MODO;
wire RCI;	
wire [N-1:0] [3:0] A;
wire [N-1:0] [3:0] B;
wire RCO;		// Outputs
wire [N-1:0] [3:0] Q;

// Monitoring code
initial begin
	$dumpfile("adder_output.vcd");
	$dumpvars(-1);
	$monitor($time,,
		"CLK = %b    ENB = %b    MODO = %b    A = %b    B = %b    RCI = %b",  CLK, ENB, MODO, A, B, RCI,,
		"	Q = %b    RCO = %b",  Q, RCO);
end


// Instance creation for DUT and tester modules
adder4bn #(.N(N))
	A0 (
	.CLK (CLK),
	.ENB (ENB),
	.MODO (MODO),
	.A (A),
	.B (B),
	.RCI (RCI),
	.Q (Q),
	.RCO (RCO)
);

tester #(.N(N))
	P0 (
	.CLK (CLK),
	.ENB (ENB),
	.MODO (MODO),
	.A (A),
	.B (B),
	.RCI (RCI),
	.Q (Q),
	.RCO (RCO)
);

endmodule
