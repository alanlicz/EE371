// Alan Li
// 02/25/2022
// EE 371
// Lab #4

// DE1_SoC takes 3-bit KEY and 10-bit SW as input and return 7-bit HEX and 10-bit LEDR as output. 
// The system searches through an array to locate an 8-bit value A specified via switches SW7−0.
// SW[9] drive input start, KEY0 is the reset key
// This serves as top-level module for the bitCounter system 
module DE1_SoC (SW, KEY, HEX1, HEX0, LEDR, CLOCK_50);
	input logic [9:0] SW;
	input logic [3:0] KEY;
	input logic CLOCK_50;
	output logic [9:0] LEDR;
	output logic [6:0] HEX1, HEX0;
	logic [4:0] out;
	logic found;
	
	// bs takes KEY[0], CLOCK_50, SW[9], SW[7:0] as input parameter reset, clk, s, in and return LEDR[9], [8] and out repectively
	binary_search bs (.reset(KEY[0]), .clk(CLOCK_50), .s(SW[9]), .in(SW[7:0]), .found(LEDR[9]), .na(LEDR[8]), .out);
	// s1 takes quotient of value as input and return HEX1 on display
	seg7 s1 (.val(out / 10), .leds(HEX1));
	// s2 takes remainder of value as input and return HEX0 on display
	seg7 s2 (.val(out % 10), .leds(HEX0));
endmodule

// Tests the previous module
`timescale 1 ps / 1 ps
module DE1_SoC_testbench ();
	logic [9:0] SW, LEDR;
	logic [6:0] HEX1, HEX0;
	logic [3:0] KEY;
	logic clk;
	
	DE1_SoC ds (.SW, .KEY, .HEX1, .HEX0, .LEDR, .CLOCK_50(clk));
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		KEY[0] <= 0; SW[9] <= 0; SW[7:0] <= 8'b00000011; @(posedge clk);
		KEY[0] <= 1; SW[9] <= 1;								 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
		KEY[0] <= 0; SW[9] <= 0; SW[7:0] <= 8'b01100011; @(posedge clk);
		KEY[0] <= 1; SW[9] <= 1;								 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
		KEY[0] <= 0; SW[9] <= 0; SW[7:0] <= 8'b00000000; @(posedge clk);
		KEY[0] <= 1; SW[9] <= 1;								 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
																		 @(posedge clk);
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
