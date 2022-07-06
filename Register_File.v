`timescale 1ns / 1ps

module Register_File(
    input [7:0] Instr_Code_ID,
	 input [2:0] Write_Reg_Num,
    input [7:0] Write_Data,
    output reg [7:0] Read_Data,
	 output reg [7:0] Imm_Data,
	 output reg [7:0] Sht_Data,
	 output reg [1:0] opcode,
    input RegWrite,
    input Reset
    );
	
	reg [7:0] RegMemory [7:0];

	integer i=0;
	
	always @(Reset) begin
		if (Reset)
			//$readmemh("Register_Memory.mem",RegMemory);
			begin
				for(i=0;i<8;i=i+1)
					RegMemory[i]=i;
			end
		end
	//end

	always @(Instr_Code_ID) begin
		Read_Data = RegMemory[Instr_Code_ID[5:3]];
		Imm_Data = {{5{Instr_Code_ID[2]}},Instr_Code_ID[2:0]};
		Sht_Data = {{2{Instr_Code_ID[2]}},Instr_Code_ID[5:0]};
		opcode = Instr_Code_ID[7:6];
	end

	always @(*) begin
		if (RegWrite) begin
			RegMemory[Write_Reg_Num] = Write_Data;
		end
	end

endmodule
