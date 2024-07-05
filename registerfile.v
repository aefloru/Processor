module registerfile(

input clk,
input wire [4:0] A1, 
input wire [4:0] A2, 
input wire [4:0] A3,
input wire [31:0] WD3,

//input wire [31:0] return, //from RAM


input WE3,
output reg [31:0] RD1, 
output reg [31:0] RD2

);


reg [31:0] register [31:0];


initial RD1 = 0;
initial RD2 = 0;
integer i;
initial i = 0;

 
//reg signed [31:0] reginput;
//initial reginput = 0; 


initial begin 

	for (i = 0; i <32 ; i = i+1) begin	
		register[i] = 32'b00000000000000000000000000000000; 
	end 	
	
end

initial register[2'b10] = 8'hff;


always @(posedge clk) begin


	if(WE3 == 2'b01)begin
	
	if (A3 == 0) begin
	
		register[A3] = 0;
		
	end else begin 
	
		register[A3] = WD3;			
		
	end
	
	end 
	


end 


always @* begin
	
//	RD1 = register[A1];
//	RD2 = register[A2]; 	
	
			if (A1 == A3 & WE3 == 2'b01) begin
		
				RD1 = WD3;
			
			end else begin
			
				RD1 = register[A1];									
			
			end			
			
			if (A2 == A3 & WE3 == 2'b01) begin
			
				RD2 = WD3;
	
			end else begin

				RD2 = register[A2]; 	
			
			end	
		

end 





endmodule