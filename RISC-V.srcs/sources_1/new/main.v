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
	wire [31:0] PC;
	wire [63:0] Instruction;

	wire PCPlusOne = PC + 1;
	
	//Instruction Mem
	imem imem1(PC, Instruction);
	//wire ShortImmediate


	//Control Unit
	wire [7:0] ALUOp;
	wire ALUSrcAControl, ALUSrcBControl, MemWriteControl, RegWriteControl, PCSrcControl, WDSrcControl, IMMSrcControl, IMemWriteControl;

	control control1(Instruction[11:0], ALUOp, ALUSrcAControl, ALUSrcBControl, MemWriteControl, RegWriteControl, PCSrcControl, WDSrcControl, IMMSrcControl, IMemWriteControl);
	
	//Register File
	wire [63:0] WriteDataSource;
	wire [63:0] RegRead1, RegRead2;
	registerfile registerfile1(RegWriteControl, Instruction[31:22], Instruction[41:32], Instruction[21:12], WriteDataSource, RegRead1, RegRead2);


	//ALU Sources
	wire [63:0] ALUSrcA, ALUSrcB;
	mux2 ALUSrcAMux(RegRead1, PC, ALUSrcAControl, ALUSrcA);
	mux2 ALUSrcAMux(RegRead2, , ALUSrcBControl, ALUSrcB);



endmodule
