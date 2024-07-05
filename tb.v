`timescale 10 ns/ 1 ns

module tb();
// constants                                           
// general purpose registers
//reg CLOCK_50;
reg clk;
wire [31:0] instruction;
wire [7:0] pc;
wire  halt;
wire [6:0] op_code;
wire [1:0] branch;
wire  memread; 
wire [1:0] memreg;
wire [1:0] aluop1;
wire [1:0] aluop0;
wire  memwrite;
wire [1:0] alusrc;
wire  regwrite; 
wire [1:0] jalsignal; 
wire [1:0] jalrsignal; 

wire [2:0] zero_flag;

wire [31:0] RD1;
wire [31:0] RD2;

wire [31:0] result;
wire [3:0] operation_code;
wire [31:0] return;


// assign statements (if any)                          
lab6week2 lab(
// port map - connection between master ports and signals/registers   
	clk,
	instruction,
	pc,
	halt,
	op_code,
	branch,
	memread,
	memreg,
	aluop1,
	aluop0,
	memwrite,
	alusrc,
	regwrite,
	jalsignal,
	jalrsignal,
	zero_flag,
	RD1,
	RD2,
	result,
	operation_code,
	return
	
);


always @*
	#1 clk <= ~clk;
	
initial
begin

$monitor("time = %d | clk = %d | pc = %d | operation_code = %b | RD1 = %b | RD2 = %b|  result = %b | return = %b| instruction = %b |halt = %d ", $realtime, clk, pc, operation_code, RD1, RD2, result, return, instruction, halt);

clk = 0;

#50 $finish;

end 


endmodule