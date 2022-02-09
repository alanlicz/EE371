module occupancyCounter(CLOCK_50, KEY0, KEYA, KEYB, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	
	input logic CLOCK_50, KEY0, KEYA, KEYB;
	// output logic GPIO0, GPIO1;
	output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0; 
	logic enterIndicator, exitIndicator;
	logic [4:0] countIndicator;
	logic inputA, inputB;
	
	// logic [31:0] clk;
	// parameter whichClock = 20;
	
	// clock_divider cdiv (.clock(CLOCK_50), .divided_clocks(clk));
	
	userInput inA (.clk(CLOCK_50), .D(KEYA), .Q(inputA));
	userInput inB (.clk(CLOCK_50), .D(KEYB), .Q(inputB));
	
	parkingLotSensors myfsm (.clk(CLOCK_50), .reset(KEY0), .A(inputA), .B(inputB), 
													.enter(enterIndicator), .exit(exitIndicator));
	
	counter mycounter (.clk(CLOCK_50), .reset(KEY0), .enter(enterIndicator), .exit(exitIndicator), 
										.cout(countIndicator[4:0]));
	
	hexDisplay mydisplay (.clk(CLOCK_50), .inputCount(countIndicator[4:0]),
								.HEX5(HEX5), .HEX4(HEX4), .HEX3(HEX3), .HEX2(HEX2),
								.HEX1(HEX1), .HEX0(HEX0));
endmodule
								
	//asIndicatorn GPIO0 = ~KEY3;
	//asIndicatorn GPIO1 = ~KEY2;

	
//for testbench verification
//	clock_divider cdiv (.clock(CLOCK_50), .divided_clocks(clk));
//	
//	userInput userInputA (.clk(CLOCK_50), .D(KEY3), .Q(inputA));
//	userInput userInputB (.clk(CLOCK_50), .D(KEY2), .Q(inputB));
//	
//	parkinglotfsm myfsm (.clk(CLOCK_50), .reset(KEY0), .A(inputA), .B(inputB), 
//													.enter(enterIndicator), .exit(exitIndicator));
//	
//	counter mycounter (.clk(CLOCK_50), .reset(KEY0), .inc(enterIndicator), .dec(exitIndicator), 
//										.cout(countIndicator[4:0]));
//	
//	hexdisplay mydisplay (.clk(CLOCK_50), .inputcount(countIndicator[4:0]),
//								.status5(HEX5), .status4(HEX4), .status3(HEX3), .status2(HEX2),
//								.led1(HEX1), .led0(HEX0));
//								
//	asIndicatorn GPIO0 = KEY3;
//	asIndicatorn GPIO1 = KEY2;
	
	

module occupancyCounter_testbench();

	logic clk, reset, A, B;
	logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

	occupancyCounter dut (.CLOCK_50(clk), .KEY0(reset), 
								.KEYA(A), .KEYB(B), 
								.HEX5(HEX5), .HEX4(HEX4), .HEX3(HEX3), .HEX2(HEX2), .HEX1(HEX1), .HEX0(HEX0)); 
	
	//Set up the clock.
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
		
	end

	initial begin
		reset <= 1;			@(posedge clk);	// cycle through car entering
		reset <= 0;			@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		{A,B} <= 2'b00;	@(posedge clk);
		{A,B} <= 2'b10;	@(posedge clk);
		{A,B} <= 2'b11;	@(posedge clk);
		{A,B} <= 2'b01;	@(posedge clk);
		{A,B} <= 2'b00;	@(posedge clk);
		
		{A,B} <= 2'b00;	@(posedge clk);
		{A,B} <= 2'b10;	@(posedge clk);
		{A,B} <= 2'b11;	@(posedge clk);
		{A,B} <= 2'b01;	@(posedge clk);
		{A,B} <= 2'b00;	@(posedge clk);
		
		{A,B} <= 2'b00;	@(posedge clk);
		{A,B} <= 2'b10;	@(posedge clk);
		{A,B} <= 2'b11;	@(posedge clk);
		{A,B} <= 2'b01;	@(posedge clk);
		{A,B} <= 2'b00;	@(posedge clk);
		
		{A,B} <= 2'b00;	@(posedge clk);
		{A,B} <= 2'b10;	@(posedge clk);
		{A,B} <= 2'b11;	@(posedge clk);
		{A,B} <= 2'b01;	@(posedge clk);
		{A,B} <= 2'b00;	@(posedge clk);	// 4 cars entered
		
		{A,B} <= 2'b00;	@(posedge clk);
		{A,B} <= 2'b01;	@(posedge clk);
		{A,B} <= 2'b11;	@(posedge clk);
		{A,B} <= 2'b10;	@(posedge clk);
		{A,B} <= 2'b00;	@(posedge clk);
		
		{A,B} <= 2'b00;	@(posedge clk);
		{A,B} <= 2'b01;	@(posedge clk);
		{A,B} <= 2'b11;	@(posedge clk);
		{A,B} <= 2'b10;	@(posedge clk);
		{A,B} <= 2'b00;	@(posedge clk);
		
		{A,B} <= 2'b00;	@(posedge clk);
		{A,B} <= 2'b01;	@(posedge clk);
		{A,B} <= 2'b11;	@(posedge clk);
		{A,B} <= 2'b10;	@(posedge clk);
		{A,B} <= 2'b00;	@(posedge clk);	// 3 cars exiting
		
		reset <= 1;			@(posedge clk);	// cycle through car exiting
		reset <= 0;			@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		{A,B} <= 2'b00;	@(posedge clk);
		{A,B} <= 2'b01;	@(posedge clk);
		{A,B} <= 2'b11;	@(posedge clk);
		{A,B} <= 2'b10;	@(posedge clk);
		{A,B} <= 2'b00;	@(posedge clk);
								@(posedge clk);
		$stop; 
	end
endmodule
