// Alan Li
// 02/25/2022
// EE 371
// Lab #4

// bitCounter takes 8-bit in, 1-bit reset, s, clk as input and return 8 bit count and 1-bit done signal
// This module display the number of 1s counted in the input data on the 7-segment display HEX0, and signal that the 
// algorithm is finished by lighting up LEDR9. 
// The module will not run until a start signal is given

module bitCounter #(parameter width = 8, parameter outWidth = 4)
						  (
						   input logic [width - 1:0] in,  // input value from switches
							input logic reset, start, clk,
							output logic [outWidth - 1:0] count, 
							output logic done
						  );
						  
	logic [width - 1:0] A;  // remaining values to count "1"
	
	// when start signal is triggered, system enter the counting stage, after the counting is finished, 
	// system wait until start signal is off. Then system go back to initial state
	enum {S1, S2, S3} ps, ns;
	
	always_comb begin
		case (ps)
			S1: if (start) ns = S2;  // start
				 else ns = S1;
			S2: if (done) ns = S3;
				 else ns = S2;
			S3: if (start) ns = S3;
				 else ns = S1;  // start set back to 0
		endcase
	end
	
	// In stage 1, initialize all registers
	// In stage 2, starting the counting process
	always_ff@(posedge clk) begin
		if (reset)
			ps <= S1;
		else
			ps <= ns;
		
		case (ps)
			S1: begin
				 A <= in;
				 count <= 0;
				 done <= 0;
				 end
				 
			S2: begin
				 done <= (A == 0);
				 if (A[0] == 1) 
					count <= count + 1;
				 A <= A / 2;  // shift to right by 1 bit
				 end
		endcase
	end
endmodule

// tests the previous module
module bitCounter_testbench ();
	logic [7:0] in;
	logic [3:0] count;
	logic reset, start, clk, done;
	
	bitCounter b (.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; start <= 0; in <= 7'b11010001; @(posedge clk);
		reset <= 0; start <= 1;							@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
		$stop;
	end
endmodule
