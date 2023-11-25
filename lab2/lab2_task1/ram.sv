// Alan Li
// 01/30/2022
// EE 371
// Lab #2

// ram takes 4-bit add, 5-bit dataIn, wr_enable and clk as inputs and return 5-bit dataOut
// This module store the data from user input and return the data out from ram upon user request
module ram(addr, dataIn, wr_enable, clk, dataOut);
	parameter data_width = 4,
				 addr_width = 5;
	input logic [addr_width-1:0] addr;
	input logic [data_width-1:0] dataIn;
	input logic wr_enable;
	input logic clk;
	output logic [data_width-1:0] dataOut;
	logic [data_width-1:0] ram [2**addr_width-1:0];
	
	// Only when user pressed wr_enable the system will store the data from user input. Otherwise the output will be the default data inside ram.
	always_ff @(posedge clk) begin
		if(wr_enable) begin
			ram[addr] <= dataIn;
		end
		dataOut <= ram[addr];
	end
endmodule

// ram_testbench tests all expected behavior that will encounter
module ram_testbench();
	parameter data_width = 4,
				 addr_width = 5,
				 CLOCK_PERIOD = 100;
				 
	
	logic [addr_width-1:0] addr;
	logic [data_width-1:0] dataIn;
	logic wr_enable;
	logic clk;
	logic [data_width-1:0] dataOut;
	logic [data_width-1:0] ram [2**addr_width-1:0];
	
	ram dut(.addr(addr), .dataIn(dataIn), .wr_enable(wr_enable), .clk(clk), .dataOut(dataOut));
	
	
	initial begin
		clk <= 0;	
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		wr_enable <= 0; addr <= 5'b00000; dataIn <= 4'b0000; 					 @(posedge clk);
		wr_enable <= 1; addr <= 5'b00001; dataIn <= 4'b0001; repeat(5)    @(posedge clk);
		wr_enable <= 1; addr <= 5'b01101; dataIn <= 4'b1010; repeat(5)    @(posedge clk);
		$stop;
	end
endmodule
			
		