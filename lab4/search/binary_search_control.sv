// Alan Li
// 02/25/2022
// EE 371
// Lab #4

// binary_search_control takes in reset, s, clk,8-bit q and in as input and return 5-bit address and z as output
module binary_search_control #(parameter data_width = 8, addr_width = 5) (reset, s, clk, q, in, addr, z);
	input logic s, clk, reset;
	input logic [data_width - 1:0] q, in;
	output logic [addr_width - 1:0] addr;
	output logic z;
	logic [addr_width - 1:0] start, end_point, new_start, new_end, new_addr;
	logic [data_width - 1:0] data;

	// S1: initial state, only load registers
	// S2: read data from ram and compare with input data
	// S3: update search address
	// S4: finish searching
	// control circuit
	enum {S1, S2, S3, S4} ps, ns;
	
	
	always_comb begin
		case (ps)
			S1: if (s) ns = S2; 
				 else ns = S1;
			S2: if (q == data || start == end_point) ns = S4; 
				 else ns = S3;  
			S3: ns = S2;  
			S4: if (s) ns = S4;
				 else ns = S1; 
		endcase
	end
	
	// implement the ASMD chart for binary searching
	always_comb begin
		z = (q == data);  
		case (ps)
			S1: begin  
					new_start = 0;
					new_end = 31;
					new_addr = 15; // the address that's in the middle of the array
				 end
			S2: begin 
					new_start = start;
					new_end = end_point;
					new_addr = addr;
				 end
			S3: begin
						if (z) begin  
							new_start = start;
							new_end = end_point;
							new_addr = addr;
						end
						else if (q > data) begin  //scan thru the smaller part
							new_end = addr - 1;
							new_start = start;
							new_addr = (start + addr - 1) / 2;
						end
						else begin  //scan thru the larger part
							new_end = end_point;
							new_start = addr + 1;
							new_addr = (end_point + addr + 1) / 2;
						end
					end
			S4: begin  // stays at the current address
					new_start = start;
					new_end = end_point;
					new_addr = addr;
				 end
		endcase
	end
	
	// when reset, system go back to initial state, otherwise load the registers and scan the array for the target data
	always_ff@(posedge clk) begin
		if (~reset) 
			ps <= S1;
		else
			ps <= ns;
	end
	
	always_ff@(posedge clk) begin
		if (~reset) begin  
			start <= 0;
			end_point <= 31;
			addr <= 15;
		end
		else begin  
			start <= new_start;
			end_point <= new_end;
			addr <= new_addr;
		end
		if (ps == S1)  
			data <= in;
	end
endmodule
