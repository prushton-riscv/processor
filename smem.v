`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2024 01:04:10 PM
// Design Name: Single Byte Memory (clock circuit)
// Module Name: smem
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


module smem(
    input clk,
    input [63:0] a,
    output reg [63:0] y
    );
    
    always @(posedge clk) begin 
        y <= a;
    end
    
endmodule
