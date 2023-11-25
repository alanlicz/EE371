// Alan Li
// 01/30/2022
// EE 371
// Lab #2

// hexDisplay takes 8 bit ramData, writeData and return 7-bit HEX5, HEX4, HEX1, HEX0

module hexDisplay(ramData, writeData, HEX5, HEX4, HEX1, HEX0);
	input logic [7:0] ramData;
	input logic [7:0] writeData;
	output logic [6:0] HEX5, HEX4, HEX1, HEX0; 
	
	// This multiple assignment is to define how hex display will display numbers as well as characters
	//										6543210
	parameter [6:0]	zero = 	7'b1000000,	
							one =  	7'b1111001,
							two =  	7'b0100100,
							three = 	7'b0110000,
							four =	7'b0011001,
							five =	7'b0010010,
							six = 	7'b0000010,
							seven =	7'b1111000,
							eight = 	7'b0000000,
							nine = 	7'b0011000,
							A = 		7'b0001000,
							B = 		7'b0000011,
							C = 		7'b1000110,
							D = 		7'b0100001,
							E = 		7'b0000110,
							F = 		7'b0001110,
							blk = 	7'b1111111;
	// Display the data in hexdecimal format on the corresponding HEX display, specifically HEX4 and 5 is for data input from user input, 
	//HEX0 and 1 is the data output from ram
	always_comb begin
		HEX5 = blk;
		HEX4 = blk;
		HEX1 = blk;
		HEX0 = blk; 
		case(ramData[3:0])
			4'b0000: HEX0 = zero;
			4'b0001:	HEX0 = one;
			4'b0010:	HEX0 = two;
			4'b0011: HEX0 = three;
			4'b0100: HEX0 = four;
			4'b0101:	HEX0 = five;
			4'b0110: HEX0 = six;
			4'b0111: HEX0 = seven;
			4'b1000:	HEX0 = eight;
			4'b1001: HEX0 = nine;
			4'b1010: HEX0 = A;
			4'b1011: HEX0 = B;
			4'b1100: HEX0 = C;
			4'b1101: HEX0 = D;
			4'b1110: HEX0 = E;
			4'b1111: HEX0 = F;
		endcase
		
		case(ramData[7:4])
			4'b0000: HEX1 = zero;
			4'b0001:	HEX1 = one;
			4'b0010:	HEX1 = two;
			4'b0011: HEX1 = three;
			4'b0100: HEX1 = four;
			4'b0101:	HEX1 = five;
			4'b0110: HEX1 = six;
			4'b0111: HEX1 = seven;
			4'b1000:	HEX1 = eight;
			4'b1001: HEX1 = nine;
			4'b1010: HEX1 = A;
			4'b1011: HEX1 = B;
			4'b1100: HEX1 = C;
			4'b1101: HEX1 = D;
			4'b1110: HEX1 = E;
			4'b1111: HEX1 = F;
		endcase
		
		
		case(writeData[3:0])
			4'b0000: HEX4 = zero;
			4'b0001:	HEX4 = one;
			4'b0010:	HEX4 = two;
			4'b0011: HEX4 = three;
			4'b0100: HEX4 = four;
			4'b0101:	HEX4 = five;
			4'b0110: HEX4 = six;
			4'b0111: HEX4 = seven;
			4'b1000:	HEX4 = eight;
			4'b1001: HEX4 = nine;
			4'b1010: HEX4 = A;
			4'b1011: HEX4 = B;
			4'b1100: HEX4 = C;
			4'b1101: HEX4 = D;
			4'b1110: HEX4 = E;
			4'b1111: HEX4 = F;
		endcase
		
		case(writeData[7:4])
			4'b0000: HEX5 = zero;
			4'b0001:	HEX5 = one;
			4'b0010:	HEX5 = two;
			4'b0011: HEX5 = three;
			4'b0100: HEX5 = four;
			4'b0101:	HEX5 = five;
			4'b0110: HEX5 = six;
			4'b0111: HEX5 = seven;
			4'b1000:	HEX5 = eight;
			4'b1001: HEX5 = nine;
			4'b1010: HEX5 = A;
			4'b1011: HEX5 = B;
			4'b1100: HEX5 = C;
			4'b1101: HEX5 = D;
			4'b1110: HEX5 = E;
			4'b1111: HEX5 = F;
		endcase
		
	end
endmodule

// hexDisplay_testbench tests all expected behavior that will encounter
`timescale 1 ps / 1 ps
module hexDisplay_testbench();
	logic [7:0] ramData;
	logic [7:0]	writeData;
	logic [6:0] HEX5, HEX4, HEX1, HEX0; 
	logic clk;
	
	hexDisplay dut (.ramData, .writeData, .HEX5, .HEX4, .HEX1, .HEX0);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD) clk <= ~clk;
	end
	
	initial begin
		ramData <= 8'b00110101; writeData <= 8'b00100111; @(posedge clk);
		ramData <= 8'b10111001; writeData <= 8'b01110010; @(posedge clk);
		ramData <= 8'b11011001; writeData <= 8'b00010001; @(posedge clk);
		ramData <= 8'b01000111; writeData <= 8'b10110101; @(posedge clk);
		$stop;
	end
endmodule

	
