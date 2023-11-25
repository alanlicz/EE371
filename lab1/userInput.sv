// Alan Li
// 01/15/2022
// EE 371
// Lab #1

// userInput take 1-bit D as user input and return Q as output
// This module utilize two DFF to reduce the possibility of metastability by adding latency

module userInput(clk, D, Q);
	input clk, D;
	output logic Q;
	logic temp;
	
	always_ff @(posedge clk) begin
		temp <= D;
		Q <= temp;
	end
	
endmodule