// Alan Li
// 01/30/2022
// EE 371
// Lab #2

// DE1_Soc takes 4 1-bit KEY and 10 1-bit SWITCH as inputs and return outputs on the 7-bit HEX display. This serves as top-level module.
module DE1_SoC(HEX5, HEX4, HEX2, HEX0, SW, KEY);
	input logic [3:0] KEY;
	input logic [9:0] SW;
	output logic [6:0] HEX5, HEX4, HEX2, HEX0;
	logic [3:0] dataOut;
	
	// ram inAndOut take SW[8:4], SW[3:0], SW[9] and KEY[0] as parameter addr, dataIn, wr_enable, clk and returns dataOut
	ram inAndOut(.addr(SW[8:4]), .dataIn(SW[3:0]), .wr_enable(SW[9]), .clk(KEY[0]), .dataOut(dataOut));
	// display HEXdisplay takes SW[8], KEY[0], SW[3:0], dataOut, SW[7:4] as parameter SW[8] clk, dataIn, dataOut and address
	// and return data on the corresponding HEX display
	display HEXdisplay(.SW8(SW[8]), .clk(KEY0), .dataIn(SW[3:0]), .dataOut(dataOut), .address(SW[7:4]), .HEX5(HEX5), .HEX4(HEX4), .HEX2(HEX2), .HEX0(HEX0));
endmodule 

// DE1_SoC_testbench tests all expected behavior that will encounter
module DE1_SoC_testbench();
	logic [3:0] KEY;
	logic [9:0] SW;
	logic [6:0] HEX5, HEX4, HEX2, HEX0;
	logic clk;
	
	//set up the clock
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		
	end
	
	DE1_SoC dut (.HEX5, .HEX4, .HEX2, .HEX0, .SW, .KEY);
	
	// The testbench will test the two most important circumstances, one being the wr_enable is on but clk input is off, another being wr_enable is off
	//but clk input is on
	initial begin
		SW[8:4] <= 5'b00001; SW[3:0] <= 4'b0001; SW[9] <= 1; KEY[0] <= 1; repeat(3)@(posedge clk); 
		SW[8:4] <= 5'b00101; SW[3:0] <= 4'b1001; SW[9] <= 0; KEY[0] <= 1; repeat(3)@(posedge clk); 
		SW[8:4] <= 5'b01001; SW[3:0] <= 4'b0001; SW[9] <= 1; KEY[0] <= 0; repeat(3)@(posedge clk); 
		SW[8:4] <= 5'b01101; SW[3:0] <= 4'b1001; SW[9] <= 1; KEY[0] <= 1; repeat(3)@(posedge clk); 
		$stop;
	end
endmodule
	
