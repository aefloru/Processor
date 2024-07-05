module idexpipeline(

input clk, 
input [7:0] pc_in, //before incremented

input [31:0] RD1, 
input [31:0] RD2,
input [31:0] instruction_in,

output reg [31:0] RD1_out,
output reg [31:0] RD2_out,
output reg [31:0] instruction_out,


//input [3:0] instr30_14_12_in,
//input [4:0] instr11_7_in,

//output reg [3:0] instr30_14_12_out,
//output reg [4:0] instr11_7_out,
output reg [7:0] pc_out,



input [6:0] op_code, 
input [1:0] branch,
input  memread,
input [1:0] memreg,
input [1:0] aluop1,
input [1:0] aluop0,
input  memwrite,
input [1:0] alusrc,
input [1:0] regwrite,
input [1:0] jalsignal,
input [1:0] jalrsignal,



output reg [6:0] op_code_out, 
output reg [1:0] branch_out,
output reg  memread_out,
output reg [1:0] memreg_out,
output reg [1:0] aluop1_out,
output reg [1:0] aluop0_out,
output reg  memwrite_out,
output reg [1:0] alusrc_out,
output reg [1:0] regwrite_out,
output reg [1:0] jalsignal_out,
output reg [1:0] jalrsignal_out


);


initial RD1_out = 0;
initial RD2_out = 0;
initial instruction_out = 0;


//initial instr30_14_12_out = 0;
//initial instr11_7_out = 0;
initial pc_out = -1;


always @(posedge clk) begin	

	pc_out <= pc_in;
	
	RD1_out <= RD1;
	RD2_out <= RD2;
	instruction_out <= instruction_in;
	//instr30_14_12_out <= instr30_14_12_in;
	//instr11_7_out <= instr11_7_in;
	
	op_code_out <= op_code ;
	branch_out <= branch;
	memread_out <= memread;
	memreg_out <= memreg;
	aluop1_out <= aluop1;
	aluop0_out <= aluop0;
	memwrite_out <= memwrite;
	alusrc_out <= alusrc;
	regwrite_out <= regwrite;
	jalsignal_out <= jalsignal;
	jalrsignal_out <= jalrsignal;
	
	
end 



endmodule