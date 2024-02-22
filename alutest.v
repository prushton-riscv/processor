`timescale 1ns / 1ps
//DO NOT EDIT
module testAlu();

	reg sysclk = 0;
	reg clk;
	
//Define inputs
    reg [6:0] F;
    reg [7:0] B;
    reg [7:0] A;

//Define outputs
    wire [7:0] Y;

//Define expected outputs
    reg [7:0] Y_expected;

	//import module
    alu alu1(A, B, F, Y);
//Define Test Vector Variable
	//  element size        num of elements
    reg [30:0] testVectors [13:0];
	//vectornum is a the current vector (an array variable)
	reg [31:0] vectornum, errors;   
	always begin
		sysclk = ~sysclk; #50;
	end

	initial begin
//Define Test Vectors
        testVectors[0] <= 31'b00000011_00000101_0000000_00000001;
        testVectors[1] <= 31'b00000011_00000101_0000010_00000111;
        testVectors[2] <= 31'b00000011_00000101_0000100_00000110;
        testVectors[3] <= 31'b00000011_00001010_0000110_00001101;
        testVectors[4] <= 31'b00000011_00001010_0001000_00000000;
        testVectors[5] <= 31'b00000011_00001010_0001010_00000001;
        testVectors[6] <= 31'b00000011_00001010_0001100_00000000;
        testVectors[7] <= 31'b00001010_00001010_0001100_00000001;
        testVectors[8] <= 31'b00000001_11111110_0001110_00000000;
        testVectors[9] <= 31'b00001010_00001010_0010000_01100100;
        testVectors[10] <= 31'b00001010_00001010_0010010_00000000;
        testVectors[11] <= 31'b00000001_00000010_0010100_00000100;
        testVectors[12] <= 31'b00000100_00000010_0010110_00000001;

		vectornum <= 32'h00000000;
		errors <= 32'h00000000;
	end

	always @(posedge sysclk) begin
		#20
//Set Inputs/Outputs
        Y_expected = testVectors[vectornum][7:0];
        F = testVectors[vectornum][14:8];
        B = testVectors[vectornum][22:15];
        A = testVectors[vectornum][30:23];

		//tick the clock attached to the module
		clk = 0; #20;
		clk = 1; #20;

//Check if Passed
		if(
            Y != Y_expected
        ) begin
			$display( "Error in vector %d", vectornum);
            $display( "Inputs   : A   = %b , B   = %b , F   = %b ", A, B, F);
            $display( "Outputs  : Y   = %b ", Y);
            $display( "Expected : Y_e = %b ", Y_expected);
			errors = errors + 1;
		end

		vectornum = vectornum + 1;
//Check if Complete
		if( vectornum === 4'b1110) begin
			$display("%d tests completed with %d errors", vectornum, errors);
			$stop;
		end
	end

endmodule
