// Alan Li
// 01/30/2022
// EE 371
// Lab #2

// DE1_SoC takes in 10 bit sw, 4 bit key, CLOCK_50 as input and return 10 bit LEDR and 4 7 bit HEX display as output

module DE1_SoC(SW, LEDR, KEY, CLOCK_50, HEX0, HEX1, HEX4, HEX5);
	input logic [9:0] SW;
	input logic [3:0] KEY;
	input logic CLOCK_50;
	output logic [9:0] LEDR;
	output logic [6:0] HEX0, HEX1, HEX4, HEX5;
	
	logic [7:0] outputBus;
	logic [3:0] readAddr;
	logic [3:0] writeAddr;
	logic write, read, reset;
	
	assign write = ~KEY[2];
	assign read = ~KEY[1];
	assign reset = ~KEY[0];
	
	// FIFO buffer takes CLOCK_50, reset, read, write, SW[7:0] as input parameter clk, reset, read, write, inputBus
	// and return LEDR[9],[8] and outputBus respectively
	FIFO FIFObuffer(.clk(CLOCK_50), .reset(reset), .read(read), .write(write), .inputBus(SW[7:0]), .empty(LEDR[9]), .full(LEDR[8]), .outputBus(outputBus[7:0]));
	
	// hexDisplay display takes outputBus[7:0], writeData(SW[7:0]), HEX5,4,1,0 as input parameter to ramData, writeData, HEX5,4,1,0
	hexDisplay display(.ramData(outputBus[7:0]), .writeData(SW[7:0]), .HEX5(HEX5), .HEX4(HEX4), .HEX1(HEX1), .HEX0(HEX0));
	
endmodule

// DE1_SoC_testbench tests all expected behavior that will encounter
`timescale 1 ps / 1 ps
module DE1_SoC_testbench();
	logic [9:0] SW;
	logic [3:0] KEY;
	logic clk, write, read, reset;
	logic [9:0] LEDR;
	logic [6:0] HEX0, HEX1, HEX4, HEX5;
	
	
	DE1_SoC dut (.SW, .LEDR, .KEY, .CLOCK_50(clk), .HEX0, .HEX1, .HEX4, .HEX5);
	
	assign write = ~KEY[2];
	assign read = ~KEY[1];
	assign reset = ~KEY[0];
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		
	end
	
	initial begin
		SW[7:0] <= 8'b10101111; KEY[1] <= 1; KEY[2] <= 1; KEY[0] <= 0; @(posedge clk);
		SW[7:0] <= 8'b00101011; KEY[1] <= 0; KEY[2] <= 1; KEY[0] <= 0; @(posedge clk);
		SW[7:0] <= 8'b00101001; KEY[1] <= 1; KEY[2] <= 1; KEY[0] <= 0; @(posedge clk);
		
		SW[7:0] <= 8'b01101111; KEY[1] <= 1; KEY[2] <= 1; KEY[0] <= 0; @(posedge clk);
		SW[7:0] <= 8'b01101111; KEY[1] <= 1; KEY[2] <= 0; KEY[0] <= 0; @(posedge clk);
		SW[7:0] <= 8'b01101111; KEY[1] <= 1; KEY[2] <= 1; KEY[0] <= 0; @(posedge clk);
		
		SW[7:0] <= 8'b10101111; KEY[1] <= 0; KEY[2] <= 0; KEY[0] <= 1; @(posedge clk);
		SW[7:0] <= 8'b00101011; KEY[1] <= 1; KEY[2] <= 1; KEY[0] <= 1; @(posedge clk);
		SW[7:0] <= 8'b00101001; KEY[1] <= 1; KEY[2] <= 0; KEY[0] <= 1; @(posedge clk);
		SW[7:0] <= 8'b01101111; KEY[1] <= 0; KEY[2] <= 0; KEY[0] <= 1; @(posedge clk);
		SW[7:0] <= 8'b01101111; KEY[1] <= 1; KEY[2] <= 0; KEY[0] <= 1; @(posedge clk);
		SW[7:0] <= 8'b01101111; KEY[1] <= 0; KEY[2] <= 0; KEY[0] <= 1; @(posedge clk);
		$stop;
	end
endmodule