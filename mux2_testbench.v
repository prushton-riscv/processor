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
    reg [9:0] testVectors [9:0];
	//vectornum is a the current vector (an array variable)
	reg [31:0] vectornum, errors;   
	always begin
		sysclk = ~sysclk; #50;
	end

	initial begin
//Define Test Vectors
        testVectors[0] <= 10'b0001_0011_0101_0111_1001_1011_1101_1111_000_0001;
        testVectors[1] <= 10'b0001_0011_0101_0111_1001_1011_1101_1111_001_0011;
        testVectors[2] <= 10'b0001_0011_0101_0111_1001_1011_1101_1111_010_0101;
        testVectors[3] <= 10'b0001_0011_0101_0111_1001_1011_1101_1111_011_0111;
        testVectors[4] <= 10'b0001_0011_0101_0111_1001_1011_1101_1111_100_1001;
        testVectors[5] <= 10'b0001_0011_0101_0111_1001_1011_1101_1111_101_1011;
        testVectors[6] <= 10'b0001_0011_0101_0111_1001_1011_1101_1111_110_1101;
        testVectors[7] <= 10'b0001_0011_0101_0111_1001_1011_1101_1111_111_1111;
        testVectors[8] <= ;

		vectornum <= 32'h00000000;
		errors <= 32'h00000000;
	end

	always @(posedge sysclk) begin
		#20
//Set Inputs/Outputs
        Y_expected = testVectors[vectornum][-26:-29];
        ctrl = testVectors[vectornum][-23:-25];
        H = testVectors[vectornum][-19:-22];
        G = testVectors[vectornum][-15:-18];
        F = testVectors[vectornum][-11:-14];
        E = testVectors[vectornum][-7:-10];
        D = testVectors[vectornum][-3:-6];
        C = testVectors[vectornum][1:-2];
        B = testVectors[vectornum][5:2];
        A = testVectors[vectornum][9:6];

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
		if( vectornum === 4'b1010) begin
			$display("%d tests completed with %d errors", vectornum, errors);
			$stop;
		end
	end

endmodule
