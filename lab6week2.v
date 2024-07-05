module lab6week2(

input CLOCK_50,


output wire [31:0] instruction,
output wire [7:0] pc_in,


output  wire [1:0] branch,
output  wire  memread, 
//output  wire [1:0] memreg,
//output  wire [1:0] aluop1,
//output  wire [1:0] aluop0,
//output  wire  memwrite,
//output  wire [1:0] alusrc,
//output  wire  regwrite, 
//output  wire [1:0] jalsignal, 
//output  wire [1:0] jalrsignal, 

//output wire [2:0] zero_flag,

//output wire [31:0] RD2,

//output wire signed [31:0] result,
output wire [3:0] operation_code,
output wire [31:0] return,
//output wire [18:0] value,

output wire clok,
output wire [31:0] instruction_out,
//output wire [7:0] pc_out,
output wire [1:0] jalsignal_out,
output wire [1:0] jalrsignal_out,
output wire [1:0] jalsignal,
output wire [1:0] jalrsignal,
output wire [1:0] branch_out,
output wire [10:0] clock_cycles,
output wire [31:0] RD2
//output wire [25:0] q


);

//initial op_code = 0;
//initial branch = 0;
//initial memread = 0;
//initial memreg = 0;
//initial aluop = 0;
//initial memwrite = 0;
//initial alusrc = 0;
//initial regwrite = 0; 

wire [31:0] RD1;
//wire [31:0] RD2;
wire [7:0] pc_out;
wire signed [31:0] result;

wire [6:0] op_code;

wire [1:0] alusrc;
wire  regwrite; 
//wire [1:0] jalsignal;
//wire [1:0] jalrsignal; 
wire [1:0] memreg;
wire [1:0] aluop1;   
wire [1:0] aluop0;
wire  memwrite;

wire [31:0] RD1_out;
wire [31:0] RD2_out;
//wire [31:0] instruction_out;
//wire [7:0] pc_out;

//wire [3:0] instr30_14_12_out;
//wire [4:0] instr11_7_out;

reg [4:0] A1;
reg [4:0] A2;
reg [4:0] A3;
reg [4:0] WD3;


wire [6:0] op_code_out; 
//wire [1:0] branch_out;
wire  memread_out;
wire [1:0] memreg_out;
wire [1:0] aluop1_out;
wire [1:0] aluop0_out;
wire  memwrite_out;
wire [1:0] alusrc_out;
wire [1:0] regwrite_out;
//wire [1:0] jalsignal_out;
//wire [1:0] jalrsignal_out;

initial A1 = 0;
initial A2 = 0;
initial A3 = 0;
initial WD3 = 0;

mypll1 mypll1(

	.refclk(CLOCK_50),
	.rst(0),
	.outclk_0(clok)
	
);

idexpipeline idexpipeline(

	.clk(clok),
	.pc_in(pc_in),
	.pc_out(pc_out),
	.RD1(RD1),
	.RD2(RD2),
	.instruction_in(instruction),
	.RD1_out(RD1_out),
	.RD2_out(RD2_out),
	.instruction_out(instruction_out),
	.op_code(op_code), 
	.branch(branch), 
	.memread(memread),
	.memreg(memreg),
	.aluop1(aluop1),
	.aluop0(aluop0),
	.memwrite(memwrite),
	.alusrc(alusrc),
	.regwrite(regwrite),
	.jalsignal(jalsignal),
	.jalrsignal(jalrsignal),
	
	.op_code_out(op_code_out), 
	.branch_out(branch_out),
	.memread_out(memread_out),
	.memreg_out(memreg_out),
	.aluop1_out(aluop1_out),
	.aluop0_out(aluop0_out),
	
	.memwrite_out(memwrite_out),
	.alusrc_out(alusrc_out),
	.regwrite_out(regwrite_out),
	.jalsignal_out(jalsignal_out),
	.jalrsignal_out(jalrsignal_out)

);


oc oc(

	.clk(clok),
	.instruction(instruction),
	.pc_in(pc_in),
	.branch(branch),
	.jalsignal(jalsignal),
	.jalrsignal(jalrsignal),
	.clock_cycles(clock_cycles),
	.readdata2(RD2),
	.readdata1(RD1)

);


manualrom manualrom(

	.pc(pc_in),
	.instruction(instruction)

); 


control control(

	.op_code(instruction[6:0]),
	.branch(branch),
   .memread(memread),
   .memreg(memreg),
   .aluop1(aluop1),
	.aluop0(aluop0),
   .memwrite(memwrite),
	.alusrc(alusrc),
	.regwrite(regwrite),
	.jalsignal(jalsignal),
	.jalrsignal(jalrsignal)

); 


alucontrol alucontrol(

	.aluop1(aluop1_out),
	.aluop0(aluop0_out),
	.instruction(instruction_out),	
	.jalrsignal(jalrsignal_out), 
	.operation_code(operation_code)

);


alu alu(

	.clk(clok),
	.readdata1(RD1_out),
	.readdata2(RD2_out),
	.alusrc(alusrc_out),
	//.op_code(op_code),
	.operation_code(operation_code),
	.result(result),
	//.immediate(instruction[31:0]),
	.immediate(instruction_out[31:0]),
	.jalrsignal(jalrsignal_out)

);


datamemory datamemory(

	.clk(clok),
	.memwrite(memwrite_out),
	.memtoreg(memreg_out),
	.memread(memread_out),
	.address(instruction_out[11:7]),
	.result(result),
	//.readdata2(RD2),
	.readdata2(RD2_out),
	.jalsignal(jalsignal_out), 
	.jalrsignal(jalrsignal_out),
	.pc(pc_out), 
	.return(return)


); 

registerfile registerfile(

	.clk(clok),
	.A1(instruction[19:15]),
	.A2(instruction[24:20]),
	.A3(instruction_out[11:7]),
	.WD3(return), //the value to write into reg, 32 bits?
	.WE3(regwrite_out), //write-enable
	.RD1(RD1),
	.RD2(RD2) //output

); 



endmodule




