module datamemory(

input clk,
input  memwrite,
input [1:0] memtoreg,
input  memread,
input [4:0] address,
input [31:0] result,
input [31:0] readdata2,
input [1:0] jalsignal, 
input [1:0] jalrsignal, 


input signed [7:0] pc,
output reg [31:0] return


);


initial return = 0;

reg [31:0] q;
initial q = 0;

reg [9:0] resultshift;
initial resultshift = 0;


myram3 myram3(.clock(~clk), .address(resultshift), .q(q), .data(readdata2), .wren(memwrite), .rden(memread));  //rden read enable
//reverse the clock
 

always @(*) begin

	resultshift = result[9:0] >> 2;

	//MUX
	
		
	if (memtoreg == 2'b01) begin
	
		return = q;
		
	end else begin
	
		if (jalsignal == 2'b01 | jalrsignal == 2'b01 ) begin
	
		return = pc + 1; 
		
		end else begin
	
		return = result;

		end 
		
	end
	
	
	end


endmodule 