// Alan Li
// 02/25/2022
// EE 371
// Lab #4
 
// DE1_SoC takes 3-bit KEY and 10-bit SW as input and return 7-bit HEX and 10-bit LEDR as output. 
// Switch 9 is used to start counting and when KEY0 is pressed, the system would go back to initial state and count again
// The value of counter will be displayed on HEX display, after the counting is done LEDR[9] will turn on
// This serves as top-level module for the bitCounter system 

module DE1_SoC (SW, KEY, LEDR, HEX0, CLOCK_50);
	input logic [9:0] SW;
	input logic [3:0] KEY;
	input logic CLOCK_50;
	output logic [9:0] LEDR;
	output logic [6:0] HEX0;
	logic [3:0] count;
	
	bitCounter b (.in(SW[7:0]), .reset(~KEY[0]), .start(SW[9]), .clk(CLOCK_50), .count, .done(LEDR[9]));
	seg7 s (.val(count), .leds(HEX0));
endmodule
