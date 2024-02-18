`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2024 12:09:34 PM
// Design Name: 
// Module Name: mux2
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


module mux(
    input  [63:0] A,
    input  [63:0] B,
    input  [63:0] C,
    input  [63:0] D,
    input  [63:0] E,
    input  [63:0] F,
    input  [63:0] G,
    input  [63:0] H,
    input  [2:0] ctrl,
    output reg [63:0] Y
    );
    
    always @(*) begin
        case (ctrl)
            3'b000: Y <= A;
            3'b001: Y <= B;
            3'b010: Y <= C;
            3'b011: Y <= D;
            3'b100: Y <= E;
            3'b101: Y <= F;
            3'b110: Y <= G;
            3'b111: Y <= H;
        endcase
    end
endmodule


module mux2(
    input  [63:0] A,
    input  [63:0] B,
    input  ctrl,
    output reg [63:0] Y
    );
    
    always @(*) begin
        case (ctrl)
            3'b110: Y <= A;
            3'b111: Y <= B;
        endcase
    end
endmodule
