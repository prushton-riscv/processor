`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2024 04:29:56 PM
// Design Name: 
// Module Name: main
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


module main(
	input clk
     );
	wire [63:0] WriteDataSource;
	wire [31:0] PC;
	wire [63:0] Instruction;

	imem imem1(PC, Instruction);
	
	wire [7:0] ALUOp;
	wire ALUSrcAControl, ALUSrcBControl, MemWriteControl, RegWriteControl, PCSrcControl, WDSrcControl, IMMSrcControl, IMemWriteControl;

	control control1(Instruction[11:0], ALUOp, ALUSrcAControl, ALUSrcBControl, MemWriteControl, RegWriteControl, PCSrcControl, WDSrcControl, IMMSrcControl, IMemWriteControl);
	
	wire [63:0] rd1, rd2;

	registerfile registerfile1(RegWriteControl, Instruction[31:22], Instruction[41:32], Instruction[21:12], WriteDataSource, rd1, rd2);

endmodule
