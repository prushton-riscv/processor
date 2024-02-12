`timescale 1ns / 1ps
//DO NOT EDIT
module testMux();

	reg sysclk = 0;
	reg clk;
	
//Define inputs
    reg [2:0] ctrl;
    reg [3:0] H;
    reg [3:0] G;
    reg [3:0] F;
    reg [3:0] E;
    reg [3:0] D;
    reg [3:0] C;
    reg [3:0] B;
    reg [3:0] A;

//Define outputs
    wire [3:0] Y;

//Define expected outputs
    reg [3:0] Y_expected;

	//import module
    mux mux1(A, B, C, D, E, F, G, H, ctrl, Y);
//Define Test Vector Variable
	//  element size        num of elements
    reg [38:0] testVectors [8:0];
	//vectornum is a the current vector (an array variable)
	reg [31:0] vectornum, errors;   
	always begin
		sysclk = ~sysclk; #50;
	end

	initial begin
//Define Test Vectors
        testVectors[0] <= 39'b0001_0011_0101_0111_1001_1011_1101_1111_000_0001;
        testVectors[1] <= 39'b0001_0011_0101_0111_1001_1011_1101_1111_001_0011;
        testVectors[2] <= 39'b0001_0011_0101_0111_1001_1011_1101_1111_010_0101;
        testVectors[3] <= 39'b0001_0011_0101_0111_1001_1011_1101_1111_011_0111;
        testVectors[4] <= 39'b0001_0011_0101_0111_1001_1011_1101_1111_100_1001;
        testVectors[5] <= 39'b0001_0011_0101_0111_1001_1011_1101_1111_101_1011;
        testVectors[6] <= 39'b0001_0011_0101_0111_1001_1011_1101_1111_110_1101;
        testVectors[7] <= 39'b0001_0011_0101_0111_1001_1011_1101_1111_111_1111;

		vectornum <= 32'h00000000;
		errors <= 32'h00000000;
	end

	always @(posedge sysclk) begin
		#20
//Set Inputs/Outputs
        Y_expected = testVectors[vectornum][3:0];
        ctrl = testVectors[vectornum][6:4];
        H = testVectors[vectornum][10:7];
        G = testVectors[vectornum][14:11];
        F = testVectors[vectornum][18:15];
        E = testVectors[vectornum][22:19];
        D = testVectors[vectornum][26:23];
        C = testVectors[vectornum][30:27];
        B = testVectors[vectornum][34:31];
        A = testVectors[vectornum][38:35];

		//tick the clock attached to the module
		clk = 0; #20;
		clk = 1; #20;

//Check if Passed
		if(
            Y != Y_expected
        ) begin
			$display( "Error in vector %d", vectornum);
            $display( "Inputs   : A   = %b , B   = %b , C   = %b , D   = %b , E   = %b , F   = %b , G   = %b , H   = %b , ctrl   = %b ", A, B, C, D, E, F, G, H, ctrl);
            $display( "Outputs  : Y   = %b ", Y);
            $display( "Expected : Y_e = %b ", Y_expected);
			errors = errors + 1;
		end

		vectornum = vectornum + 1;
//Check if Complete
		if( vectornum === 4'b1001) begin
			$display("%d tests completed with %d errors", vectornum, errors);
			$stop;
		end
	end

endmodule
