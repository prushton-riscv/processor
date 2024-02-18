module dmem(
	input clk,

	input [63:0] wd0,
	input [63:0] wd1,
	
	input we0,
	input we1,

	input [63:0] a0,
	input [63:0] a1,
	input [63:0] a2,

	output [63:0] rd0,
	output [63:0] rd1,
	output [63:0] rd2
    );


	reg [63:0] data [63:0];   

	always @(posedge clk) begin
		if(we0) begin
			data[a0] <= wd0;		
		end
		if(we1) begin
			data[a1] <= wd1;
		end
	end


//array of size 32 containing 64 bit integers
	
	assign rd0 = data[a0];
	assign rd1 = data[a1];
	assign rd2 = data[a2];
endmodule
