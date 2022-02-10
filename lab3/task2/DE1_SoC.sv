module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	assign LEDR = SW;
	
	logic [9:0] x;
	logic [9:0] x0, x1;
	logic [8:0] y;
	logic [8:0] y0, y1;
	logic frame_start;
	logic pixel_color;
	
	// set clock
	logic [31:0] div_clk; 
	parameter whichClock = 15;
	clock_divider cdiv (.clock(CLOCK_50),  
                       .reset(SW[9]),  
                       .divided_clocks(div_clk)); 
	
	logic clkSelect; 
   assign clkSelect = div_clk[whichClock]; 
	//////// DOUBLE_FRAME_BUFFER ////////
	logic dfb_en;
	assign dfb_en = 1'b0;
	/////////////////////////////////////
				
	VGA_framebuffer fb(.clk(CLOCK_50), .rst(1'b0), .x, .y,
				.pixel_color, .pixel_write(1'b1), .dfb_en, .frame_start,
				.VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_HS, .VGA_VS,
				.VGA_BLANK_N, .VGA_SYNC_N);
	
	
	// draw lines between (x0, y0) and (x1, y1)
	line_drawer draw (.clk(clkSelect), .reset(SW[9]),
				.x0, .y0, .x1, .y1, .x, .y, .done);
	
		
	//1,1 12,5 works
	//2,1 13,5 works
	//1,1 5,12 works
	//1,1 17,5 works
	//2,2 2,100 works(vertical)
	//2,2 100,2 works(horizontal)
	//0,0 640,480
	//2,2 24,10 does not work
	//5,5 60,25 does not work
	//10,10 120,50 does not work
	//100,100 150,300 does not work
	//0,0 640,480 does not work(no lines at all)
	//0,0 600,400 does not work
	
	
	// draw an arbitrary line
	assign x0 = 1;
	assign y0 = 1;
	assign x1 = 12;
	assign y1 = 5;
	
	always_comb begin
		if(done)	pixel_color = 1'b1;
		else pixel_color = 1'b0;
	end
endmodule
