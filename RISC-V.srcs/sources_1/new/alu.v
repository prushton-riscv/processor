//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2021 08:14:19 PM
// Design Name: 
// Module Name: alu
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


module alu(
	input [63:0] a,
	input [63:0] b,
	input [6:0] f,
	output [63:0] y,
	output zero
	);
    
	wire [63:0] aa, bb;
	wire [63:0] _and, _or, _xor, _sum, _slt, _sgt, _seq, _mul, _lshift, _rshift;
	wire [64:0] _carry, true_sum;
	wire [127:0] _mul_carry;

	reg [63:0] _y;

	assign aa = f[6] ? ~a : a;
	assign bb = f[5] ? ~b : b;
	
	assign _and = aa & bb;
	assign _or = aa | bb;
	assign _xor = aa ^ bb;

	assign true_sum = aa+bb+ (f[6] | f[5]);

	assign _sum = true_sum[63:0];
	assign _carry = true_sum[64];
	assign _slt = _sum[63] >> 63;

	and_64_bit and_64_bit1(~_xor, _seq);

	assign _sgt = ~(_seq & _slt) >> 63;

	assign _mul = aa * bb;
	assign _mul_carry = aa*bb;
	
	assign _lshift = aa << bb;
	assign _rshift = aa >> bb;

	always @(*) begin
		case (f[4:1]) 
			4'h0: _y <= _and;
			4'h1: _y <= _or;
			4'h2: _y <= _xor;
			4'h3: _y <= _sum;
			4'h4: _y <= 64'h0 | _slt;
			4'h5: _y <= 64'h0 | _sgt;
			4'h6: _y <= 64'h0 | _seq;
			4'h7: _y <= _carry[64];
			4'h8: _y <= _mul;
			4'h9: _y <= _mul_carry[127:64];
			4'hA: _y <= _lshift;
			4'hB: _y <= _rshift;
			4'hC: _y <= 64'h0000_0000;
			4'hD: _y <= 64'h0000_0000;
			4'hE: _y <= 64'h0000_0000;
			4'hF: _y <= 64'h0000_0000;
		endcase
	end

	assign y = f[0] ? ~_y : _y;
	assign zero = ( y == 64'b0 );
endmodule

module and_64_bit(
	input [63:0] A,
	output [63:0] y
	);
	
	assign y = 64'h0 | A[0] & A[1] & A[2] & A[3] & A[4] & A[5] & A[6] & A[7] & A[8] & A[9] & A[10] & A[11] & A[12] & A[13] & A[14] & A[15] & A[16] & A[17] & A[18] & A[19] & A[20] & A[21] & A[22] & A[23] & A[24] & A[25] & A[26] & A[27] & A[28] & A[29] & A[30] & A[31] & A[32] & A[33] & A[34] & A[35] & A[36] & A[37] & A[38] & A[39] & A[40] & A[41] & A[42] & A[43] & A[44] & A[45] & A[46] & A[47] & A[48] & A[49] & A[50] & A[51] & A[52] & A[53] & A[54] & A[55] & A[56] & A[57] & A[58] & A[59] & A[60] & A[61] & A[62] & A[63];

endmodule


module alu_old(
    input [31:0] a,
    input [31:0] b,
    input [2:0] f,
    output [31:0] y,
    output zero
    );
    
    wire [31:0] BB, b2, AddOut, And_res, Or_res, slt_res;
    
    assign BB = ~b; 
    assign b2 = f[2] ? BB : b;
    
    assign AddOut = a + b2 + f[2];  //twos compliment
    assign And_res = a & b2;
    assign Or_res = a | b2;
    assign slt_res = AddOut[31] ? 32'b1 : 32'b0;
    
    assign y = ( f[1:0] == 2'b00) ? And_res : 
                     ( f[1:0] == 2'b01) ? Or_res :
                     ( f[1:0] == 2'b10) ? AddOut : slt_res;
    /*always @(*)
        case( Op[1:0] )
            2'b00: Result <= And_res;
            2'b01: Result <= Or_res;
            2'b10: Result <= AddOut;
            2'b11: Result <= slt_res;  
        endcase
    */
    
    assign zero = (y == 32'b0);
endmodule
