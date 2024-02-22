module imem(
	input [63:0] a,
	output [63:0] inst
    );


	reg [63:0] instructions [63:0];   
//array of size 32 containing 64 bit integers

	initial begin 
		$readmemb("./bin.mem", instructions, 0, 63);
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
