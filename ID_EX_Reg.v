`timescale 1ns / 1ps

module ID_EX_Reg(
    input clk,
    input reset,
	 input [7:0] PC_ID,
    input RegWrite_ID,
    input [3:0] ALU_Operation_ID,
    input [7:0] Read_Data_ID,
    input [7:0] Imm_Data_ID,
	 input [7:0] Sht_Data_ID,
    input [2:0] Write_Reg_ID,
	 input [1:0] opcode,
	 output reg [7:0] PC_EX,
    output reg RegWrite_EX,
    output reg [3:0] ALU_Operation_EX,
    output reg [7:0] Read_Data_EX,
    output reg [7:0] Imm_Data_EX,
	 output reg [7:0] Sht_Data_EX,
    output reg [2:0] Write_Reg_EX,
	 output reg [1:0] opcode_EX
    );

	always @(posedge clk, negedge reset) begin
		if (reset == 1'b0) begin
			RegWrite_EX = 1'b0;
			ALU_Operation_EX = 4'b0000;
			Read_Data_EX = 8'b0;
			Imm_Data_EX = 8'b0;
			Sht_Data_EX = 8'b0;
			Write_Reg_EX = 3'b0;
			opcode_EX = 2'b0;
			PC_EX = 8'b0;
		end
		
		else begin
			RegWrite_EX = RegWrite_ID;
			ALU_Operation_EX = ALU_Operation_ID;
			Read_Data_EX = Read_Data_ID;
			Imm_Data_EX = Imm_Data_ID;
			Sht_Data_EX = Sht_Data_ID;
			Write_Reg_EX = Write_Reg_ID;
			opcode_EX = opcode;
			PC_EX = PC_ID;
		end

	end

endmodule
