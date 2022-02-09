// Alan Li
// 01/30/2022
// EE 371
// Lab #2

//writePointer takes in 1 bit clk, reset, read as input and return 4 bit writePointer as output

module writePointer(write, reset, writePointer);
	input logic write;
	input logic reset; //reset
	output logic [3:0] writePointer;
	
	// When write signal is given, writePointer move to the next address, if write signal is given and writePointer reach the end of FIFO it will return to 0
	// reset signal will set writePointer to address 0
	always @(posedge write) begin
		if (reset) 
			writePointer <= 4'b0000;
		else if (write & (writePointer == 4'b1111))
			writePointer <= 4'b0000;
		else if (write)
			writePointer <= writePointer + 1;
		else writePointer <= writePointer;
		
	end
endmodule

// writePointer_testbench tests all expected behavior that will encounter
`timescale 1 ps / 1 ps
module writePointer_testbench();
	logic clk;
	logic reset; 
	logic [3:0] writePointer;
	
	
	parameter CLOCK_PERIOD=100;  
	initial begin   
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
	end 

	writePointer dut (.write(clk), .reset, .writePointer); 
	
	initial begin
		reset <= 1; 									@(posedge clk);
		reset <= 0; 									@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
		$stop;
	end
endmodule


	