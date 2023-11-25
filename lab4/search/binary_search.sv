// Alan Li
// 02/25/2022
// EE 371
// Lab #4

// binary_search takes 8-bit in, 1-bit reset, clk, and s as input and return 5-bit out, 1-bit na and found as output signal.

module binary_search #(parameter data_width = 8, addr_width = 5) (reset, clk, s, in, found, na, out);
	input logic reset, clk, s;
	input logic [data_width - 1:0] in;
	output logic found, na;
	output logic [addr_width - 1:0] out;
	
	// addr is the current address that system is checking, q is the data read from ram, z is the signal for whether the data exist in ram
	logic [addr_width - 1:0] addr;
	logic [data_width - 1:0] q;
	logic z;
	
	// ram32*8 takes addr, clk, 0, 0 as input parameters address, clock, data, wren and q and returns q as output
	ram32x8 r (.address(addr), .clock(clk), .data(0), .wren(0), .q);
	
	// bsc take reset, s, clk, q, in as input paramter and return addr and z.
	binary_search_control bsc (.*);
	
	assign out = addr;
	// assign found signal, na as not found signal
	assign found = z;
	assign na = ~z;
endmodule

// tests the previous module
`timescale 1 ps / 1 ps
module binary_search_testbench ();
	logic reset, clk, s, found, na;
	logic [4:0] out;
	logic [7:0] in;
	
	binary_search bs (.*);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 0; s <= 0; in <= 8'b00000100; 			  @(posedge clk);
		reset <= 1; s <= 1;							repeat(20) @(posedge clk);
															
		/*
		reset <= 0; s <= 0; in <= 8'b01100011; @(posedge clk);
		reset <= 1; s <= 1;							@(posedge clk);
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
		reset <= 0; s <= 0; in <= 8'b11111111; @(posedge clk);
		reset <= 1; s <= 1;							@(posedge clk);
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
		*/
		$stop;
	end
endmodule
