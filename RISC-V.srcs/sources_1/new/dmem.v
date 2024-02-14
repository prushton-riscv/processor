module dmem(
	input clk,

	input [63:0] wd0,
	input [63:0] wd1,
	
	input we0,
	input we1,

	input [31:0] a0,
	input [31:0] a1,
	input [31:0] a2,

	output [63:0] rd0,
	output [63:0] rd1,
	output [63:0] rd2
    );


	reg [31:0] instructions [63:0];   

	always @(posedge clk) begin
		if(we0) begin
			instructions[a0] <= wd0;		
		end
		if(we1) begin
			instructions[a1] <= wd1;
		end
	end


//array of size 32 containing 64 bit integers
	
	assign rd0 = instructions[a0];
	assign rd1 = instructions[a1];
	assign rd2 = instructions[a2];
endmodule