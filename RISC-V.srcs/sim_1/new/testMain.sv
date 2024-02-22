module testMain();

        reg clk;
        reg reset;
        reg [63:0] counter = 0;
        reg [63:0] activeKeyStroke;

        reg [63:0] keystrokes [63:0];

        main main1(clk, reset, activeKeyStroke);

        initial begin
                $readmemh("keystrokes.mem", keystrokes);
                reset = 1; #50;
                reset = 0; #50;
        end

        always begin
                activeKeyStroke <= keystrokes[counter/10];
                // /10 gives enough time for cpu to process keyboard input
                clk = 0; #50;
                clk = 1; #50;

                counter = counter+1;
        end

endmodule
