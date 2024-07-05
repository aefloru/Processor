module oc (
input clk,
input [31:0] instruction,
output reg [7:0] pc_in,
//input [7:0] pc_out,

input [1:0] branch,
//input [2:0] zero_flag,
input [1:0] jalsignal,
input [1:0] jalrsignal,

output reg [10:0] clock_cycles,

input signed [31:0] readdata2,
input signed [31:0] readdata1

); 

initial pc_in = -1;
initial clock_cycles = 0;

//reg [1:0] add_offset;
//initial add_offset = 0;


reg zeroflag;
initial zeroflag = 0; 

//reg signed [31:0] result;
//initial result = 0;


//offset = {instruction[12], instruction[10:0]}


always @ (posedge clk) begin
		

			if ((readdata1 - readdata2) == 0) begin //beq			
				
				if (instruction[14:12] == 3'b000) begin
			
					zeroflag = 1;
				
				end else if (instruction[14:12] == 3'b001) begin
			
					zeroflag = 0; //0
				
				end else begin
				
					zeroflag = 0;  //0
						 
				end 
							
			
			end else begin //bne
			
			
				if (instruction[14:12] == 3'b000) begin
			
					zeroflag = 0;
					
				end else if (instruction[14:12] == 3'b001) begin
				
					zeroflag = 1;
				
				end else begin
				
					zeroflag = 0; 
						
				end 			
							
			end


	if (instruction != 7'b1111111) begin 
	
		clock_cycles <= clock_cycles + 1;
		
	
		if (branch == 1 & zeroflag == 1) begin //branch
	
			pc_in <= pc_in + ({instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0} >>> 2);

	
		end else begin
		
				if (jalsignal == 2'b01) begin 
				
					pc_in <= pc_in + ({instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0} >>> 2);// 3'b100); //>>> 2;

				
				end else begin
					
		            if (jalrsignal == 2'b01) begin
						
							//pc_in <= value; //pc + value/ 3'b100; 
							
							pc_in <= readdata1 + instruction[31:20];

						
						end else begin
	
							pc_in <= pc_in + 1;

	
						end
		
				end
		
		end 		
		
		
		end


end 


endmodule


