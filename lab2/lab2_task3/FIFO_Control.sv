// Alan Li
// 01/30/2022
// EE 371
// Lab #2

// FIFO_Control takes in 1-bit clk, reset, read, write and return 4 bit readAddr and writeAddr

module FIFO_Control #(
							 parameter depth = 4
							 )(
								input logic clk, reset,
								input logic read, write,
							  output logic wr_en,
							  output logic empty, full,
							  output logic [depth-1:0] readAddr, writeAddr
							  );
	//	writePointer writePointer takes write, clk, reset to parameter write, clk, reset and return writeAddr[3:0] as writePointer					  
	writePointer writePointer(.write(write), .reset(reset), .writePointer(writeAddr[3:0]));
	
	//	readPointer readPointer takes read, clk, reset to parameter read, clk, reset and return readAddr[3:0] as readPointer		
	readPointer readPointer(.read(read), .reset(reset), .readPointer(readAddr[3:0]));
	
	/* 	Define_Variables_Here		*/
	enum {emptyFIFO, normalFIFO, fullFIFO} ps, ns;
	
	/*		Combinational_Logic_Here	*/
	
	// When writePointer reaches readPointer the FIFO is full, when readPointer reaches writePointer the FIFO is empty. Otherwise the FIFO is a normalFIFO.
	always_comb begin
		case(ps)
			emptyFIFO: if (write) ns = normalFIFO;
						  else ns = ps;
								
			normalFIFO: if (write && (writeAddr + 1'b1 == readAddr)) begin
								ns = fullFIFO;
							end
							else if (read && (readAddr + 1'b1 == writeAddr)) begin
								ns = emptyFIFO;
							end
							else ns = ps;
							
			fullFIFO:	if (read) ns = normalFIFO;
						   else ns = ps;							
		endcase
		
	end
	
	// When FIFO is full, the full signal is on. When FIFO is empty, the empty signal is on. When FIFO is not full or empty no signal is on
	// For wr_en signal, it is only on when FIFO not full and write is given.
	always_comb begin

		case(ps)
			emptyFIFO: begin
				empty = 1'b1;
				full = 1'b0;
			end
						  
			normalFIFO: begin
				empty = 1'b0;
				full = 1'b0;
			end
						  
			fullFIFO: begin
				empty = 1'b0;
				full = 1'b1;
			end
		endcase
		if (write && ~full) wr_en = 1'b1;
		else 					  wr_en = 1'b0;
	end

	//When reset, FIFO become a empty FIFO
	/*		Sequential_Logic_Here		*/	
	always_ff @(posedge clk) begin
		if(reset) begin
			ps <= emptyFIFO;				 
		end
		else 
			ps <= ns;
	end
endmodule

// FIFO_Control_testbench tests all expected behavior that will encounter
`timescale 1 ps / 1 ps
module FIFO_Control_testbench();
	logic clk, reset, read, write, wr_en;
	logic empty, full; 
	logic [3:0] readAddr, writeAddr;
	
	FIFO_Control dut(.clk, .reset, .read, .write, .wr_en, .empty, .full, .readAddr, .writeAddr);
	
	parameter CLOCK_PERIOD=100;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin
		reset <= 1;	read <= 0; write <= 0;	@(posedge clk);
		reset <= 1;	read <= 1; write <= 0;	@(posedge clk);
		reset <= 1;	read <= 0; write <= 0;	@(posedge clk);
		reset <= 1;	read <= 0; write <= 0;	@(posedge clk);
		reset <= 1;	read <= 0; write <= 1;	@(posedge clk);
		reset <= 1;	read <= 0; write <= 0;	@(posedge clk);
		reset <= 0;	read <= 0; write <= 0;	@(posedge clk);
		reset <= 0;	read <= 1; write <= 0;	@(posedge clk);
		reset <= 0;	read <= 1; write <= 0;	@(posedge clk);
		reset <= 0;	read <= 0; write <= 1;	@(posedge clk);
		reset <= 0;	read <= 1; write <= 0;	@(posedge clk);
		$stop;
	end
	
endmodule
