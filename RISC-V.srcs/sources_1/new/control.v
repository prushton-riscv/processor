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
		//R TYPE
		12'h000: control <= 16'b0000_1000_0000_0110; //add
		12'h001: control <= 16'b0000_1000_0010_0110; //sub
		12'h002: control <= 16'b0000_1000_0001_0000; //mul
		12'h003: control <= 16'b0000_1000_0000_0000; //and
		12'h004: control <= 16'b0000_1000_0000_0010; //or
		12'h005: control <= 16'b0000_1000_0000_0100; //xor
		12'h006: control <= 16'b0000_1000_0000_1000; //slt
		12'h007: control <= 16'b0000_1000_0000_1010; //sgt
		12'h008: control <= 16'b0000_1000_0000_1100; //seq
		12'h009: control <= 16'b0000_1000_0000_1110; //addc
		12'h00A: control <= 16'b0000_1000_0001_0010; //mulc
		12'h00B: control <= 16'b0000_1000_0001_0100; //lshift
		12'h00C: control <= 16'b0000_1000_0001_0110; //rshift
		//D E F are reserved for "later"
		
		//I TYPE
		12'h100: control <= 16'b0000_1010_0000_0110; //addi
		12'h101: control <= 16'b0000_1010_0010_0110; //subi
		12'h102: control <= 16'b0000_1010_0001_0000; //muli
		12'h103: control <= 16'b0000_1010_0000_0000; //andi
		12'h104: control <= 16'b0000_1010_0000_0010; //ori
		12'h105: control <= 16'b0000_1010_0000_0100; //xori
		12'h106: control <= 16'b0000_1010_0000_1000; //slti
		12'h107: control <= 16'b0000_1010_0000_1010; //sgti
		12'h108: control <= 16'b0000_1010_0000_1100; //seqi
		12'h109: control <= 16'b0000_1010_0000_1110; //addci
		12'h10A: control <= 16'b0000_1010_0001_0010; //mulci
		12'h10B: control <= 16'b0000_1010_0001_0100; //lshifti
		12'h10C: control <= 16'b0000_1010_0001_0110; //rshifti
		//D E F are reserved to be used soon(tm)

		//S TYPE
		12'h200: control <= 16'b0000_0110_0000_0110; //sw
		12'h201: control <= 16'b1000_0000_0000_0110; //sImem
		
		//L TYPE
		12'h300: control <= 16'b0110_1010_0000_0110; //lw

		//jump
		12'h420: control <= 16'b0101_0000_0000_0000; //jtl
		12'h421: control <= 16'b0101_0000_0000_1100; //beq
		12'h422: control <= 16'b0101_0000_0000_1000; //blt
		12'h423: control <= 16'b0101_0000_0000_1010; //bgt
	endcase
    end

    assign ALUOp = control[7:0];
    
    assign ALUSrcA = control[8];
    assign ALUSrcB = control[9];
    assign MemWrite = control[10];
    assign RegWrite = control[11];
    
    assign PCSrc = control[12];
    assign WDSrc = control[13];
    assign IMMSrc = control[14];
    assign IMemWrite = control[15];

endmodule
