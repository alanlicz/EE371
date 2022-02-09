// Alan Li
// 01/30/2022
// EE 371
// Lab #2

//readPointer takes in 1 bit clk, reset, read as input and return 4 bit readPointer as output

module readPointer(read, reset, readPointer);
	input logic read;
	input logic reset; //reset
	output logic [3:0] readPointer;
	
	// When read signal is given, readPointer move to the next address, if read signal is given and readPointer reach the end of FIFO it will return to 0
	// reset signal will set readPointer to address 0
	always @(posedge read) begin
		if (reset) 
			readPointer <= 4'b0000;
		else if (read & (readPointer == 4'b1111))
			readPointer <= 4'b0000;
		else if (read)
			readPointer <= readPointer + 1;
		
	end
endmodule

// readPointer_testbench tests all expected behavior that will encounter
`timescale 1 ps / 1 ps
module readPointer_testbench();
	logic clk;
	logic reset; 
	logic [3:0] readPointer;
	
	parameter CLOCK_PERIOD=100;  
	initial begin   
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
	end 

	readPointer dut (.read(clk), .reset, .readPointer); 
	
	initial begin
		reset <= 1; 									@(posedge clk);
		reset <= 0; 									@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
															@(posedge clk);
		reset <= 1;										@(posedge clk);
															@(posedge clk);
		$stop;
	end
endmodule


	