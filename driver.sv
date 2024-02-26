module testMain();

        reg clk;
        reg reset;
        reg [63:0] counter = 0;
        reg [63:0] activeKeyStroke;
	reg [63:0] wordToRead = 64'h201;

        reg [63:0] keystrokes [63:0];
	
	wire [63:0] readWord;

        main main1(clk, reset, activeKeyStroke, wordToRead, readWord);

        initial begin
                $readmemh("keystrokes.mem", keystrokes, 0, 63);
                reset = 1; #50;
                reset = 0; #50;
		
		//$dumpfile("dump.vcd");
		//$dumpvars(0, main1);
        end

        always begin
                activeKeyStroke <= keystrokes[counter/10];
                // /10 gives enough time for cpu to process keyboard input
                clk = 0; #50;
                clk = 1; #50;

                counter = counter+1;

		if(counter >= 16'h200) begin
			$write("%0c", readWord); #10;
			wordToRead = wordToRead + 1; #10;
			if (wordToRead == 64'h0000_0000_0000_0003) begin 
				$finish;
			end
		end
        end
endmodule
