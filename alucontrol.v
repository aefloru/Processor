module alucontrol(

input [1:0] aluop1,
input [1:0] aluop0,
input [31:0] instruction,
input [1:0] jalrsignal,
output reg [3:0] operation_code

);


reg [1:0] aluop;
reg [6:0] funct7;
reg [2:0] funct3;


always @(*) begin

aluop = aluop1 + aluop0;


		//added conditional for jalsignal 	
//		if(jalrsignal == 2'b01) begin
		
//				operation_code = 4'b0010;
		
//		end else begin
		
			if (aluop == 2'b00) begin 
		
			if (instruction[14:12] == 3'b001) begin //slli
			
				operation_code = 4'b1101;
			
			end else begin //load or store (add) or addi
			
				operation_code = 4'b0010;
			
			end
	

		 end else if (aluop[0] == 1) begin // beq, bne (sub)

			operation_code = 4'b0110;

		 end else if (aluop[1] == 1) begin
			
			
				if (instruction[31:25] == 7'b0000000) begin 
				
					if (instruction[14:12] == 3'b000) begin
				
					operation_code = 4'b0010; //ADD
					
					end else if (instruction[14:12] == 3'b111) begin 
					
					operation_code = 4'b0000; //AND
					
					end else if (instruction[14:12] == 3'b110) begin
					
					operation_code = 4'b0001; //OR
					
					end 															

					
				end else if (instruction[31:25] == 7'b0100000) begin //SUB
					
						operation_code = 4'b0110;
					
				end else if (instruction[31:25] == 7'b0000001) begin  //MUL 

						operation_code = 4'b1010;

				end
				
				end 
				
		
//		end 


end


endmodule 

