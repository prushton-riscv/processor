`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2024 08:48:15 PM
// Design Name: 
// Module Name: registerfile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module registerfile(
	input WE3,

	input [9:0] a1,
	input [9:0] a2,
	input [9:0] a3,

	input [63:0] wd3,

	output [63:0] rd1,
	output [63:0] rd2
    );

	reg [63:0] data [63:0];

	integer i;
	initial begin
		for (i = 0; i < 64; i = i + 1) begin
			data[i] <= 64'b0;
		end
	end

	always @(*)
		if (WE3)
			data[a3] <= wd3;
	
	assign rd1 = data[a1];
	assign rd2 = data[a2];

endmodule
