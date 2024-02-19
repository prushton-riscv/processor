module dmem(
	input clk,
	
	input [63:0] a1,
	input we1,
	input [63:0] wd1,
	output [63:0] rd1,

	input [63:0] a2,
	input we2,
	input [63:0] wd2,
	output [63:0] rd2,

	input [63:0] a3,
	output [63:0] rd3
    );


	reg [1024:0] data [63:0];   

	always @(posedge clk) begin
		if(we1) begin
			data[a1] <= wd1;		
		end
		if(we2) begin
			data[a2] <= wd2;
		end
	end


//array of size 32 containing 64 bit integers
	
	assign rd1 = data[a1];
	assign rd2 = data[a2];
	assign rd3 = data[a3];
endmodule
