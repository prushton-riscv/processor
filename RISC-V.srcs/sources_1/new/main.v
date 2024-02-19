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
	input clk,
	input reset
     );


	reg [63:0] PC;
	wire [63:0] PCNext;
	wire [63:0] Instruction;
	wire [63:0] PCPlusOne = PC + 1;
	

	always @(posedge clk) begin
		PC = PCNext; 
	end

	always @(posedge reset) begin
		PC = 0;
	end

	//Instruction Mem
	imem imem1(PC, Instruction);

	//Control Unit
	wire [7:0] ALUOp;
	wire ALUSrcAControl, ALUSrcBControl, MemWriteControl, RegWriteControl, PCSrcControl, WDSrcControl, IMMSrcControl, IMemWriteControl;

	control control1(Instruction[11:0], ALUOp, ALUSrcAControl, ALUSrcBControl, MemWriteControl, RegWriteControl, PCSrcControl, WDSrcControl, IMMSrcControl, IMemWriteControl);
	
	//Register File
	wire [63:0] WriteDataSource;
	wire [63:0] RegRead1, RegRead2;
	wire [9:0] A1, A2, A3;
	assign A1 = Instruction[31:22];
	assign A2 = Instruction[41:32];
	assign A3 = Instruction[21:12];

	registerfile registerfile1(RegWriteControl, A1, A2, A3, WriteDataSource, RegRead1, RegRead2);
	
	//Immediate
	wire [63:0] Immediate;

	wire [21:0] ImmediateSmall = Instruction[63:42];
	wire [31:0] ImmediateBig = Instruction[63:32];

	wire [63:0] ExtendedImmediateSmall = ImmediateSmall[21] ? 64'b1 & ImmediateSmall : 64'b0 | ImmediateSmall;
	wire [63:0] ExtendedImmediateBig = ImmediateBig[31] ? 64'b1 & ImmediateBig : 64'b0 | ImmediateBig;
	
	assign Immediate = IMMSrcControl ? ImmediateSmall : ImmediateBig;

	
	/*always begin 
		if (IMMSrcControl) begin
			Immediate <=  { {33{Instruction[63]}}, Instruction[62:32] };
		end else begin
			Immediate <=  { {43{Instruction[63]}}, Instruction[62:42] };
		end
	end*/

	//ALU Sources
	wire [63:0] ALUSrcA, ALUSrcB;
	mux2 ALUSrcAMux(RegRead1, PC, ALUSrcAControl, ALUSrcA);
	mux2 ALUSrcBMux(RegRead2, Immediate, ALUSrcBControl, ALUSrcB);

	//ALU
	wire [63:0] ALUOut;
	wire zero;
	wire [6:0] SizedALUOp = ALUOp[6:0];
	alu alu1(ALUSrcA, ALUSrcB, SizedALUOp, ALUOut, zero);
	
	
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

	mux2 pcNextMux(PCPlusOne, Immediate, PCAndZero, PCNext);

	//smem smem1(clk, PCNext, PC);

endmodule
