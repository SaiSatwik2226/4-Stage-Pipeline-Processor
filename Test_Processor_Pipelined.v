`timescale 1ns / 1ps

module four_stage_pipelined_processor_uut;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	four_stage_pipelined_processor uut (
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
		#1;
		reset = 0;
		#1;
		reset = 1;
	end
      
		
	initial begin
		clk = 0;
		#5;
		repeat(19) begin
			#5;
			clk = ~clk;
		end
		$finish;
	end
      
endmodule

