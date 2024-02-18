module imem(
	input [63:0] a,
	output [63:0] inst
    );


	reg [63:0] instructions [63:0];   
//array of size 32 containing 64 bit integers

	always @(*) begin 
		instructions[0] <= 64'b0000000000000000000000000000010000000000000001100000000100000000;
		instructions[1] <= 64'b0000000000000000000000000000010000000000000001100001000100000000;
		instructions[2] <= 64'b0000000000000000000000000000000100011000000001100000000100000001;
		instructions[3] <= 64'b0000000000000000000000000110000100011000110001100011000000000000;
		instructions[4] <= 64'b0000000000000000000000000000011000000000000001100000000100100001;
		instructions[5] <= 64'b0000000000000000000000000000001000000000000000000000000100100001;
		instructions[6] <= 64'b0000000000000000000000000000000100000000000001000000000100000000;
	end


	assign inst = instructions[a];
    
endmodule

module imem_mut(
	input [31:0] a2,
	input [63:0] wd2,
	input we,
	
	input [31:0] a,
	output [63:0] inst
    );


	reg [63:0] instructions [63:0];   
//array of size 64 containing 64 bit integers


    always @(posedge we) begin
        instructions[a2] <= wd2;
    end

	assign inst = instructions[a];
    
endmodule
