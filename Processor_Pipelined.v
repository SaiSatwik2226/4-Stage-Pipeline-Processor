`timescale 1ns / 1ps
module four_stage_pipelined_processor(
    input clk,
    input reset
    );	 	
	wire reset_IFID,reset_IDEX,reset_EXWB; //Independent Reset signals for pipeline registers which works along with global reset.
	wire [7:0] PC_ID,PC_IF,PC_EX,PC_WB;		//Instruction PC in the current Stage.
	wire [7:0] Instruction_Code_IF, Instruction_Code_ID;
	wire [7:0] Result_EX, Result_WB, Imm_Data_ID, Imm_Data_EX, Sht_Data_ID, Sht_Data_EX, Read_Data_ID, Read_Data_EX;
	wire [7:0] A;
	wire [3:0] ALU_Operation_ID, ALU_Operation_EX;
	wire [2:0] Write_Reg_ID, Write_Reg_EX, Write_Reg_WB;
	wire FU_Control,PC_Select,sht_imm;		//Control Lines
	wire [1:0] opcode, opcode_EX;
	wire RegWrite_ID, RegWrite_EX, RegWrite_WB, Zero;
	
	assign Write_Reg_ID = Instruction_Code_ID[5:3];
	
	//Forwarding unit helps in Detecting the Data Hazard and Forwarding the appropriate data to the EX Stage.
	Forwarding_Unit FU(FU_Control, Result_WB, Read_Data_EX, A);
	
	//Fetches the next intruction as commanded by the instruction cycle.
	Instruction_Fetch IF(clk, reset, PC_Select, Result_EX, Instruction_Code_IF,PC_IF, reset_IFID, reset_IDEX, reset_EXWB);
	
	// IF/ID Pipeline Registers
	IF_ID_Reg IFID(clk, reset_IFID&reset, Instruction_Code_IF, PC_IF, Instruction_Code_ID, PC_ID);
	
	//Generates control signals for ALU, Select lines for various MUXes.
	Control_Unit CU(Instruction_Code_ID[7:6], Write_Reg_EX, Write_Reg_WB, opcode_EX,PC_Select, sht_imm, FU_Control,
						ALU_Operation_ID, RegWrite_ID); 
	
	//Register File Bank R0 to R7.
	Register_File RF(Instruction_Code_ID, Write_Reg_WB, Result_WB, Read_Data_ID, Imm_Data_ID, Sht_Data_ID,opcode, RegWrite_WB, reset);
	
	// ID/EX Pipeline Registers
	ID_EX_Reg IDEX(clk, reset_IDEX&reset, PC_ID, RegWrite_ID, ALU_Operation_ID, Read_Data_ID, Imm_Data_ID, Sht_Data_ID, Write_Reg_ID, 
						opcode, PC_EX, RegWrite_EX, ALU_Operation_EX, Read_Data_EX, Imm_Data_EX, Sht_Data_EX, Write_Reg_EX, opcode_EX);
						
	//ALU
	ALU ALU(A, Imm_Data_EX, Sht_Data_EX, PC_EX, opcode_EX, ALU_Operation_EX, sht_imm, Result_EX, Zero);
	
	// EX/WB Pipeline Registers
	EX_WB_Reg EXWB(clk, reset_EXWB&reset, PC_EX, RegWrite_EX, Result_EX, Write_Reg_EX, PC_WB, RegWrite_WB, Result_WB, Write_Reg_WB);
	
endmodule