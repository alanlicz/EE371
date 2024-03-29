module counter(clk, KEY, counter);
	input logic clk;
	input logic [3:0] KEY;
	logic reset; 
	logic [31:0] div_clk; 
	output logic [4:0] counter;
  
	assign reset = ~KEY[0]; 
	
	always @(posedge clk) begin
		if (reset) 
			counter <= 5'b00000;
		else if (counter == 5'b11111)
			counter <= 5'b00000;
		else 
			counter <= counter + 1;
		
	end
endmodule

`timescale 1 ps / 1 ps
module counter_testbench();
	logic clk;
	logic reset; 
	logic [4:0]counter;
	logic [3:0]KEY;
	
	parameter CLOCK_PERIOD=100;  
	initial begin   
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
	end 

	counter dut (.clk(clk), .KEY, .counter);
	
	initial begin
		KEY[0] <= 1; 							@(posedge clk);
		KEY[0] <= 0; counter = 5'b00000;	@(posedge clk);
													@(posedge clk);
													@(posedge clk);
													@(posedge clk);
													@(posedge clk);
													@(posedge clk);
		KEY[0]<= 1;								@(posedge clk);
													@(posedge clk);
		$stop;
	end
endmodule


	