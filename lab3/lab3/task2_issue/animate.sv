module animate(x0, y0, x1, y1, x0_new, y0_new, x1_new, y1_new, color, clk, reset, done);
	input logic [9:0] x0, x1;
	input logic [8:0] y0, y1;
	input logic clk, reset, done;

	output logic [9:0] x0_new, x1_new;
	output logic [8:0] y0_new, y1_new;
	output logic color;
	
	logic [9:0] counter;
	
	always_ff @(posedge clk) begin
		if(reset) begin
			$diaplay("stage1")
			counter <= 0;
			color <= 1'b1;
			x0_new <= x0;
			x1_new <= x1;
			y0_new <= y0;
			y1_new <= y1;
		end 
		else if (done) begin 
			$display("stage2");
			if (counter == 0) begin
				$display("got here1");
				counter <= 1;
				x0_new <= x1;
				x1_new <= x1 + 10;
				y0_new <= y1;
				y1_new <= y1;
				color <= 1'b1;
			end
			
			if (counter == 1) begin
				$display("stage3");
				counter <= 2;
				x0_new <= x0;
				x1_new <= x1;
				y0_new <= y0;
				y1_new <= y1;
				color <= 1'b0;
			end
			
			if (counter == 2) begin
				$display("stage4");
				counter <= 3;
				x0_new <= x1;
				x1_new <= x1 + 10;
				y0_new <= y1;
				y1_new <= y1;
				color <= 1'b0;
			end
		end
	end
	
	
endmodule

module animate_testbench();
	logic [9:0] x0, x1;
	logic [8:0] y0, y1;
	logic clk, reset;
	logic [9:0] x0_new, x1_new;
	logic [8:0] y0_new, y1_new;
	logic color;
	logic done;
	
	parameter CLOCK_PERIOD=100;  
	initial begin   
		clk <= 0;  
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end 
	
	animate dut(.x0, .y0, .x1, .y1, .x0_new, .y0_new, .x1_new, .y1_new, .color, .clk, .reset, .done);
	
	initial begin
		reset <= 1; x0 <= 1; y0 <= 1; x1 <= 12; y1 <= 5; done <= 1; 				@(posedge clk);
		reset <= 0; 												 done <= 1;	repeat(10)	@(posedge clk);
																		
		$stop;
	end
endmodule



