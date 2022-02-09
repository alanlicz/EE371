module DE1_SoC(CLOCK_50, SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input logic [9:0] SW;
	input logic [3:0] KEY;
	input logic CLOCK_50;
	output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	logic [4:0] counter;
	logic [3:0] readData;
	logic [31:0] div_clk; 
	
	parameter whichClock = 25; // 0.75 Hz clock 
	clock_divider cdiv (.clock(CLOCK_50),  
                       .reset(reset),  
                       .divided_clocks(div_clk)); 
	
	logic clkSelect; 

   assign clkSelect = div_clk[whichClock]; 
		
	counter address(.clk(clkSelect), .KEY(KEY[3:0]), .counter(counter[4:0]));
	ram32x4 ramData(.clock(CLOCK_50), .data(SW[3:0]), .rdaddress(counter[4:0]), .wraddress(SW[8:4]), .wren(KEY[3]), .q(readData[3:0]));
	hexDisplay displayData(.ramData(readData[3:0]), .writeData(SW[3:0]), .ramAddress(counter[4:0]), .writeAddress(SW[8:4]), .HEX5(HEX5), .HEX4(HEX4), .HEX3(HEX3), .HEX2(HEX2), .HEX1(HEX1), .HEX0(HEX0));
	
endmodule

`timescale 1 ps / 1 ps
module DE1_SoC_testbench();
	
	logic [9:0] SW;
	logic [3:0] KEY;
	logic clk;
	logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	
	DE1_SoC dut (.CLOCK_50(clk), .SW, .KEY, .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		
	end
	
	initial begin
		KEY[0] <= 0;	@(posedge clk);
		KEY[0] <= 1;	@(posedge clk);
		KEY[3] <= 1;	SW[8:4] <= 5'b00001;	SW[3:0] <= 4'b0101;	@(posedge clk);
		KEY[3] <= 1;	SW[8:4] <= 5'b00010;	SW[3:0] <= 4'b0011;	@(posedge clk);
		KEY[3] <= 1;	SW[8:4] <= 5'b00011;	SW[3:0] <= 4'b1001;	@(posedge clk);
		KEY[3] <= 1;	SW[8:4] <= 5'b00100;	SW[3:0] <= 4'b1101;	@(posedge clk);
		$stop;
	end
endmodule

		