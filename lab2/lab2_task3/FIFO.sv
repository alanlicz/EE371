// Alan Li
// 01/30/2022
// EE 371
// Lab #2

// FIFO module takes in 1 bit clk, reset, read, write, 4 bit inputBus as input and return 1 bit empty, full 4 bit outputBus as output

module FIFO #(
				  parameter depth = 4,
				  parameter width = 8
				  )(
					 input logic clk, reset,
					 input logic read, write,
					 input logic [width-1:0] inputBus,
					output logic empty, full,
					output logic [width-1:0] outputBus
				   );
					
	/* 	Define_Variables_Here		*/
	logic [3:0]readPointer;
	logic [3:0]writePointer;
	//logic readData[7:0];
	logic wr_en;
	
	/*			Instantiate_Your_Dual-Port_RAM_Here			*/
	// ram16x8 ramData takes clk, inputBus[7:0], readPointer[3:0], writePointer[3:0], wr_en as parameter to clock, data, rdadress, wraddress, wren.
	// It return outputBus[7:0]
	ram16x8 ramData(.clock(clk), .data(inputBus[width-1:0]), .rdaddress(readPointer[3:0]), .wraddress(writePointer[3:0]), .wren(wr_en), .q(outputBus[width-1:0]));
	
	//FIFO control takes clk, reset, read, write as input and return wr_en, empty, full, readPointer[3:0], writePointer[3:0] as output
	/*			FIFO-Control_Module			*/				
	FIFO_Control #(depth) FC (.clk, .reset, 
									  .read, 
									  .write, 
									  .wr_en(wr_en),
									  .empty,
									  .full,
									  .readAddr(readPointer[3:0]), 
									  .writeAddr(writePointer[3:0])
									 );
	
endmodule 

// FIFO_testbench tests all expected behavior that will encounter
`timescale 1 ps / 1 ps
module FIFO_testbench();
	
	parameter depth = 4, width = 8;
	
	logic clk, reset;
	logic read, write;
	logic [width-1:0] inputBus;
	logic resetState;
	logic empty, full;
	logic [width-1:0] outputBus;
	
	FIFO #(depth, width) dut (.*);
	
	parameter CLK_Period = 100;
	
	initial begin
		clk <= 1'b0;
		forever #(CLK_Period/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 0;																	 @(posedge clk);
		reset <= 1;	read <= 0; write <= 0;	inputBus <= 8'b00001000; @(posedge clk);
		reset <= 1;	read <= 1; write <= 0;	inputBus <= 8'b11001000; @(posedge clk);
		reset <= 1;	read <= 0; write <= 0;	inputBus <= 8'b00001000; @(posedge clk);
		reset <= 1;	read <= 0; write <= 0;	inputBus <= 8'b10110011; @(posedge clk);
		reset <= 1;	read <= 0; write <= 1;	inputBus <= 8'b01101000; @(posedge clk);
		reset <= 1;	read <= 0; write <= 0;	inputBus <= 8'b10001010; @(posedge clk);
		reset <= 0;	read <= 0; write <= 1;	inputBus <= 8'b00001000; @(posedge clk);
		reset <= 0;	read <= 0; write <= 1;	inputBus <= 8'b11001000; @(posedge clk);
		reset <= 0;	read <= 0; write <= 1;	inputBus <= 8'b00001000; @(posedge clk);
		reset <= 0;	read <= 1; write <= 0;	inputBus <= 8'b10110011; @(posedge clk);
		reset <= 0;	read <= 1; write <= 0;	inputBus <= 8'b01101000; @(posedge clk);
		reset <= 0;	read <= 1; write <= 0;	inputBus <= 8'b10001010; @(posedge clk);
		$stop;
	end
	
	
endmodule 