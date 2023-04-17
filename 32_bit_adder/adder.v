// Behavioural description of 4 bit adder
module adder4b (
		CLK,	// Clock signal
		ENB,	// Enable signal
		MODO,	// Mode select
		A,	// A input number
		B,	// B input number
		RCI,	// Ripple counter input
		Q,	// Output number output
		RCO);	// Ripple counter output

// Input declaration
input CLK, ENB, RCI;
input [1:0] MODO;
input [3:0] A, B;

// Output declaration
output [3:0] Q;
output RCO;

// Role declaration of input and outputs
wire CLK, ENB, RCI;
wire [1:0] MODO;
wire [3:0] A, B;

reg [3:0] Q;
reg RCO;

// Concurrent detection of positive edge of clock and enable signal
always @ (posedge CLK && ENB == 1)
begin
	// Actions selected in mode signal take place
	// The ripple counter input is taken into account here and
	// the RCO is assigned as the MSB of the computed vector for
	// each operation
	// The substraction mode assumes that the data it gets comes
	// in two's complement form
	case (MODO)
		2'b00 : {RCO, Q} <= {RCO, Q};
		2'b01 : {RCO, Q} <= A + B + RCI;
		2'b10 : {RCO, Q} <= A - B + RCI;
		2'b11 : {RCO, Q} <= 5'b00000;
		default {RCO, Q} <= 5'b00000;
	endcase
end

// Behavior when enable is 0
always @ (ENB == 0)
begin
	// The first condition only applies when starting
	// circuit for the first time, it sets the output
	// ports to 0 so that they're not undefined.
	// The second one happens when enable is set to 0
	// after having produced an output before, and
	// only keeps the output ports on hold
	if (Q === 4'bx) begin
		Q = 4'b0;
		RCO = 0;
	end else begin
		Q = Q;
		RCO = RCO;
	end
end
endmodule

// Module for 4*n bit adder, it parametrizes adder4n
module adder4bn
		#(parameter N=1)		// Placeholder value, the working one is declared in the testbench file
		(
		input	CLK, ENB,		// CLK, ENB and MODO signals are shared
		input	[1:0] MODO,		// throughout all 4 bit adders.
		input	RCI, 
		input	[N-1:0] [3:0] A, B,	// These two dimensional arrays allow
		output	[N-1:0] [3:0] Q,	// to input and output several 4 bit
		output	RCO			// lenght signals to the module
		);
	// With the inputs and outputs declared, only two internal
	// arrays remains to be created, these will allow to link
	// the ripple counters leaving only two of them available to
	// be used
	wire iRC [N:0];		// Internal ripple counter array, the lenght is
				// greater than the rest of variables because
				// it allows the later loop to assign all the
				// ripple counter links autimatically, all with
				// one vector for correlation.
	assign iRC[0] = RCI;	// RCI is assinged as input to the first bit of iRC
	assign RCO = iRC[N];	// The last bit of iRC is assigned as output RCO

	genvar i;		// Temporary module instance index


	// Module generation
	generate
	// The actual loop goes from zero to N-1
	for (i = 0; i < N; i = i + 1) 
	begin
		// The module instancing goes as follows
		adder4b A0 (CLK, ENB, MODO, A[i], B[i], iRC[i], Q[i], iRC[i+1]);
	end
	endgenerate
endmodule
