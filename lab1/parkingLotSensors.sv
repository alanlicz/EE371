// Alan Li
// 01/15/2022
// EE 371
// Lab #1

// parkingLotSensors takes in 1-bit A, B and clk as inputs and return 1-bit enter and exit as outputs.

module parkingLotSensors(clk, reset, A, B, enter, exit);
	input logic A, B, clk, reset;
	output logic enter, exit;
	
	// States
	enum {unblocked, beginIn, blockIn, almostIn, beginOut, blockOut, almostOut} ps, ns;

	// The parking lot sensor can have six cases as list below. beginIn, blockin and almostIn are pairs with almostOut, blockOut and beginOut. 
	// Assume the entrance is north-south direction. If car is entering from North, it will trigger sensor A first. 
	// If car is exiting from South it will trigger sensor B first.
	// For example, beginIn and almost out both indicate that only sensorA is blocked, they only differences is that beginIn means the car is going in the south direction and almostOut is car going north.
	// This "case pair" is designed to tackle car changing direction issue.
	always_comb
		begin
			enter = 0;
			exit = 0;
			
			case(ps)	
				
				unblocked: 				
					if (A & ~B)				ns = beginIn;      // car begin to enter
					else if (~A & B)  	ns = beginOut;		 // car begin to exit 
					// else if (~A & ~B)		ns = unblocked; // impossible
					else 						ns = unblocked;	 // nothing happens
					
				beginIn:
					if (A & B)				ns = blockIn;		 // car is halfway entering
					else if (~A & ~B) 	ns = unblocked;	 // car just enters then back up
					// else if (A & ~B) 		ns = beginIn;   // impossible
					else 						ns = beginIn;		 // car does not move 
					
				blockIn:
					if (~A & B) 			ns = almostIn;		 // car almost enters (trigger both sensors)
					else if (A & ~B)		ns = beginIn;		 // car backs up
					// else if (A & B)		ns = blockIn;	 // impossible
					else 						ns = blockIn;      // car does not move
				
				almostIn:
					if (~A & ~B) 
						begin
												ns = unblocked;	 // car enters
												enter = 1;
												exit = 0;
						end
					else if (A % B) 		ns = blockIn;		 // car backs up
					// else if (~A & B)		ns = almostIn;  // impossible
					else 						ns = almostIn;  	 // car does not move
					
				beginOut:
					if (A & B)			   ns = blockOut;	 	 // car is halfway exiting
					else if (~A & ~B)		ns = unblocked;	 // car backs up	
					// else if (~A & B)		ns = beginOut;  // impossible
					else 						ns = beginOut;		 // car does not move
					
				blockOut:
					if (A & ~B)				ns = almostOut; 	 // car almost exits (trigger both sensors)
					else if (~A & B)		ns = beginOut;		 // car backs up
					// else if (A & B)		ns = blockOut;	 // impossible
					else 						ns = blockOut;		 // car does not move
				
				almostOut:
					if (~A & ~B)									 // car exits
						begin
							ns = unblocked;
							enter = 0;
							exit = 1;
						end
					else if (A & B)		ns = blockOut; 	 // car backs up
					// else if (A & ~B)  	ns = almostOut; // impossible
					else 						ns = almostOut;	 // car does not move
					
				/*
				default: 
					begin
						enter = 0;
						exit = 0;
					end
				*/
			endcase	
		end
		
	
	// if reset, the parking lot sensor goes to unblocked case
	always_ff @(posedge clk)
		begin
			if (reset)
				ps <= unblocked;
			else ps <= ns;
		end
endmodule	

// parkingLotSensor_testbench tests all expected behavior that the parking lot occupancy counter system in the lab may encounter
module parkingLotSensor_testbench();
	logic clk, reset, A, B, enter, exit;
	
	parkingLotSensors dut (.clk(clk), .reset(reset), .A(A), .B(B), .enter(enter), .exit(exit));
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// I have already simulate the case where car enters and exits without changing directions in DE1_SoC
	// For this testbench I will simulate the case where the car changes direction multiple times
	initial begin
		reset <= 1;				@(posedge clk);
		reset <= 0;   			@(posedge clk);
		{A, B} <= 2'b00;		@(posedge clk);
		{A, B} <= 2'b10;		@(posedge clk);
		{A, B} <= 2'b11;		@(posedge clk);
		{A, B} <= 2'b01;		@(posedge clk);
		{A, B} <= 2'b11;		@(posedge clk);
		{A, B} <= 2'b10;		@(posedge clk);
		{A, B} <= 2'b11;		@(posedge clk);
		{A, B} <= 2'b01;		@(posedge clk);
		{A, B} <= 2'b00;		@(posedge clk); // simulation for car enters
		
		{A, B} <= 2'b00;		@(posedge clk);
		{A, B} <= 2'b01;		@(posedge clk);
		{A, B} <= 2'b11;		@(posedge clk);
		{A, B} <= 2'b10;		@(posedge clk);
		{A, B} <= 2'b11;		@(posedge clk);
		{A, B} <= 2'b01;		@(posedge clk);
		{A, B} <= 2'b11;		@(posedge clk);
		{A, B} <= 2'b10;		@(posedge clk);
		{A, B} <= 2'b00;		@(posedge clk); // simulation for car exits
		$stop;
	end
endmodule
		
	

