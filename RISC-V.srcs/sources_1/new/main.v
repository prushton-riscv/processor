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
	wire [63:0] PC = 0;
	wire [63:0] PCNext;
	wire [63:0] Instruction;

	wire [63:0] PCPlusOne = PC + 1;
	
	//Instruction Mem
	imem imem1(PC, Instruction);

	//Control Unit
	wire [7:0] ALUOp;
	wire ALUSrcAControl, ALUSrcBControl, MemWriteControl, RegWriteControl, PCSrcControl, WDSrcControl, IMMSrcControl, IMemWriteControl;

	control control1(Instruction[11:0], ALUOp, ALUSrcAControl, ALUSrcBControl, MemWriteControl, RegWriteControl, PCSrcControl, WDSrcControl, IMMSrcControl, IMemWriteControl);
	
	//Register File
	wire [63:0] WriteDataSource;
	wire [63:0] RegRead1, RegRead2;
	registerfile registerfile1(RegWriteControl, Instruction[31:22], Instruction[41:32], Instruction[21:12], WriteDataSource, RegRead1, RegRead2);
	
	//Immediate
	reg [63:0] Immediate;
	
	always @(*) begin 
		if (IMMSrcControl) begin
			Immediate <=  { {33{Instruction[63]}}, Instruction[62:32] };
		end else begin
			Immediate <=  { {43{Instruction[63]}}, Instruction[62:42] };
		end
	end

	//ALU Sources
	wire [63:0] ALUSrcA, ALUSrcB;
	mux2 ALUSrcAMux(RegRead1, PC, ALUSrcAControl, ALUSrcA);
	mux2 ALUSrcBMux(RegRead2, Immediate, ALUSrcBControl, ALUSrcB);

	//ALU
	wire [63:0] ALUOut;
	wire zero;
	alu ALU1(ALUSrcA, ALUSrcB, ALUOp[6:0], ALUOut, zero);
	
	
	//Data memory
	wire [63:0] empty, empty3, empty4, empty5, empty6;
	wire empty2;
	wire [63:0] MemRead;
	
	dmem dmem1(clk,
		ALUOut, MemWriteControl, RegRead2, MemRead, 
		empty, empty2, empty3, empty4, 
		empty5, empty6);

	//Writeback
	mux2 wdsourcemux(ALUOut, MemRead, WDSrcControl, WriteDataSource);

	//PC Next //at the end
	wire notzero = ~zero;
	wire PCAndZero = PCSrcControl & notzero;

	mux pcNextMux(PCPlusOne, Immediate, PCAndZero, PCNext);

	smem smem1(clk, PCNext, PC);

endmodule
