module testMain();

	reg clk;
	reg reset;
	reg counter = 0;
	reg [63:0] activeKeyStroke;

	reg [63:0] keystrokes [63:0];

	main main1(clk, reset, activeKeyStroke);

	initial begin
		reset = 1; #50;
		reset = 0; #50;
		$readmemb("keystrokes.dat", keystrokes);
	end

	always begin
		activeKeyStroke <= keystrokes[counter];

		clk = 0; #50;
		clk = 1; #50;
		
		counter = counter+1;
	end

endmodule

