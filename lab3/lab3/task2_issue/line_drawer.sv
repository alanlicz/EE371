module line_drawer(
	input logic clk, reset,
	
	// x and y coordinates for the start and end points of the line
	input logic [9:0] x0, x1, 
	input logic [8:0] y0, y1,

	//outputs cooresponding to the coordinate pair (x, y)
	output logic [9:0] x,
	output logic [8:0] y,
	output logic done
	);
	
	/*
	 * You'll need to create some registers to keep track of things
	 * such as error and direction
	 * Example: */
	logic signed [11:0] error;
	logic signed [23:0] e2;
	
	logic signed [10:0] deltaX;
	logic [10:0] xPointer;
	logic signed [9:0] deltaY;
	logic [9:0] yPointer;
	
	logic [1:0] sx, sy;

	always_comb begin
		// absolute value for deltaX and deltaY
		if (x1 > x0) deltaX = (x1 - x0);
		else deltaX = -(x1 - x0);
		
		if (y1 > y0) deltaY = -(y1 - y0);
		else deltaY = (y1 - y0);
		
		if (x0 < x1) sx = 1;
		else sx = -1;
		
		if (y0 < y1) sy = 1;
		else sy = -1;
		
		done = ((xPointer == x1) && (yPointer == y1));
		
		e2 = 2 * error;
	end

	always_ff @(posedge clk) begin
		if (reset) begin
			error <= deltaX + deltaY;
			xPointer <= x0;
			yPointer <= y0;
		end
		else if (~((xPointer == x1) & (yPointer == y1))) begin			
			if (e2 >= deltaY) begin
				error <= error + deltaY;
				xPointer <= xPointer + sx;
			end
			
			if (e2 <= deltaX) begin
				error <= error + deltaX;
				yPointer <= yPointer + sy;
			end
			
			// both condition is true
			if ((e2 >= deltaY) && (e2 <= deltaX)) begin
				error <= error + deltaX + deltaY;
				yPointer <= yPointer + sy;
				xPointer <= xPointer + sx;
			end			
		end

	end
	
	assign x = xPointer;
	assign y = yPointer;

endmodule

//1,1 12,5 works
//100,100 150,300 works
//2,2 2,100 works
module line_drawer_testbench();
	logic clk, reset;
	logic [9:0] x0, x1; 
	logic [8:0] y0, y1;
	logic [9:0] x;
	logic [8:0] y;
	logic done;
	
	parameter CLOCK_PERIOD=100;  
	initial begin   
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end 
	
	line_drawer dut(.clk, .reset, .x0, .x1, .y0, .y1, .x, .y, .done);
	
	initial begin	
		reset <= 1; x0 <= 1; y0 <= 1; x1 <= 12; y1 <= 5; @(posedge clk);
		reset <= 0; @(posedge clk);
		repeat(500) @(posedge clk);
		
		$stop;
	end
endmodule