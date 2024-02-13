`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2024 04:51:29 PM
// Design Name: 
// Module Name: control
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


module control(
	input [11:0] opcode,
	input [9:0] funct,

	output [7:0] ALUOp,
	output ALUSrcA,
	output ALUSrcB,
	output MemWrite,
	output RegWrite,
	output PCSrc,
	output WDSrc,
	output IMMSrc,
	output IMemWrite
    );

    reg [15:0] control = 16'h0000;
    always @(*) begin
	case(opcode)
    end

endmodule
