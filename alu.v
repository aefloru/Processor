module alu(

input clk, 
input signed [31:0] readdata1, //RD1
input signed [31:0] readdata2,

input [1:0] alusrc,
//input [6:0] op_code,

input [3:0]  operation_code,
output reg signed  [31:0] result, //need to be bigger??

input [31:0] immediate,

input [1:0] jalrsignal,

output reg [2:0] zero_flag
//output reg [18:0] value

//address? 

);



reg [31:0] value;
initial value = 0;


reg signed [11:0] imm;
initial imm = 0;


always @(*) begin


		if (alusrc == 2'b00) begin
		
			value = readdata2;
		
		end else if (alusrc == 2'b01) begin
		
			if (immediate[6:0] == 7'b0100011) begin //SW
		
				imm = {immediate[31:25], immediate[11:7]};
				value = imm;				

			end else begin //LW or ADDI
						
			
					if (immediate[14:12] == 3'b001) begin

						imm = immediate[24:20]; //slli
						value = imm;
					
					end else begin
			
						imm = immediate[31:20];
						value = imm;	
		
					end		
					
		end 		
		
		end else begin
	
			value = 0;	

		end
		
		if (operation_code == 4'b0010) begin	//ADD	
		
			result = readdata1 + value;			
			
		end 

		else if (operation_code == 4'b0110) begin //SUB
			
			result = readdata1 - value;
			
		end 
		
		else if (operation_code == 4'b1010) begin //MUL

			result = readdata1 * value; 


		end 
		
		else if (operation_code == 4'b0000) begin //AND 

			result = readdata1 & value; 
	

		end 
		
		else if (operation_code == 4'b0001) begin //OR

			
			result = readdata1 | value; 

		end else if (operation_code == 4'b1101) begin
		
			result = readdata1 << value;
		
		
		end
		

	
		else begin
		
			result = 0; 
		
		
		end
	
	

		
	
	



end 




endmodule 