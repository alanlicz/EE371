// Alan Li
// 01/30/2022
// EE 371
// Lab #2

//Display takes in 1-bit SW8, clk, 4-bit dataIn, dataOut and address as input and return 7-bit HEX5, HEX4, HEX2 and HEX0

module display(SW8, clk, dataIn, dataOut, address, HEX5, HEX4, HEX2, HEX0);
	input logic SW8, clk;
	input logic [3:0] dataIn;
	input logic [3:0] dataOut;
	input logic [3:0] address;
	output logic [6:0] HEX5, HEX4, HEX2, HEX0;
	
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
	

	// Display the data in hexdecimal format on the corresponding HEX display, specifically HEX2 is for data input from user input, HEX0 is the data output from ram
	// HEX4 and 5 display the address that user requested to store data
	always_comb begin
		HEX5 = blk; 
		HEX4 = blk; 
		HEX2 = blk; 
		HEX0 = blk; 
		case(dataIn)
			4'b0000: HEX2 = zero;
			4'b0001:	HEX2 = one;
			4'b0010:	HEX2 = two;
			4'b0011: HEX2 = three;
			4'b0100: HEX2 = four;
			4'b0101:	HEX2 = five;
			4'b0110: HEX2 = six;
			4'b0111: HEX2 = seven;
			4'b1000:	HEX2 = eight;
			4'b1001: HEX2 = nine;
			4'b1010: HEX2 = A;
			4'b1011: HEX2 = B;
			4'b1100: HEX2 = C;
			4'b1101: HEX2 = D;
			4'b1110: HEX2 = E;
			4'b1111: HEX2 = F;
		endcase
			
		case(dataOut)
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
		
		case(address)
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
		if (SW8 == 1'b1) 
				HEX5 = one;
		else 
				HEX5 = blk;
	end
endmodule 

// display_testbenchtests all expected behavior that will encounter
module display_testbench();
	logic clk;
	logic SW8;
	logic [3:0] dataIn;
	logic [3:0] dataOut;
	logic [3:0] address;
	logic [6:0] HEX5, HEX4, HEX2, HEX0;
	
	display dut (.clk(clk), .SW8(SW8), .dataIn(dataIn), .dataOut(dataOut), .address(address), .HEX5(HEX5), .HEX4(HEX4), .HEX2(HEX2), .HEX0(HEX0));
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
																									@(posedge clk);
		SW8 <= 0; 																				@(posedge clk);
																									@(posedge clk);
		SW8 <= 1; dataIn <= 4'b0001; dataOut <= 4'b0001; address <= 4'b0001; @(posedge clk);
		SW8 <= 0; dataIn <= 4'b1101; dataOut <= 4'b1001; address <= 4'b0101; @(posedge clk);


		$stop;
	end
endmodule
	
	