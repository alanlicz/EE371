module hexDisplay(ramData, writeData, ramAddress, writeAddress, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input logic [3:0] ramData;
	input logic [3:0] writeData;
	input logic [4:0] ramAddress;
	input logic [4:0] writeAddress;
	output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0; 
	
	
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
	
	always_comb begin
		HEX5 = blk;
		HEX4 = blk;
		HEX3 = blk;
		HEX2 = blk; 
		HEX1 = blk;
		HEX0 = blk; 
		case(ramData)
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
		
		case(writeData)
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
		
		case(ramAddress[3:0])
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
		if (ramAddress[4] == 1'b1) 
				HEX3 = one;
		else 
				HEX3 = blk;
				
		case(writeAddress[3:0])
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
		if (writeAddress[4] == 1'b1) 
				HEX5 = one;
		else 
				HEX5 = blk;
	end
endmodule

`timescale 1 ps / 1 ps
module hexDisplay_testbench();
	logic [3:0] ramData;
	logic [4:0] ramAddress;
	logic [3:0]	writeData;
	logic [4:0] writeAddress;
	logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0; 
	logic clk;
	
	hexDisplay dut (.ramData, .ramAddress, .writeData, .writeAddress, .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD) clk <= ~clk;
	end
	
	initial begin
		ramData <= 4'b0001; writeData <= 4'b0011; ramAddress<= 5'b10010; writeAddress <= 5'b10001; @(posedge clk);
		ramData <= 4'b1001; writeData <= 4'b0111; ramAddress<= 5'b01010; writeAddress <= 5'b00101; @(posedge clk);
		ramData <= 4'b1101; writeData <= 4'b0001; ramAddress<= 5'b00110; writeAddress <= 5'b11001; @(posedge clk);
		ramData <= 4'b0111; writeData <= 4'b1001; ramAddress<= 5'b00011; writeAddress <= 5'b01101; @(posedge clk);
		$stop;
	end
endmodule

	
