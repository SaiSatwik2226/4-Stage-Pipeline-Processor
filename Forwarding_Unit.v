`timescale 1ns / 1ps
module Forwarding_Unit(
	input FU_Control,
	input [7:0] Result_WB,
	input [7:0] Read_Data_EX,
	output [7:0] A
    );
	
	assign A = (FU_Control)?Result_WB:Read_Data_EX;
	
endmodule
