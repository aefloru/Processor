module control(

input [6:0] op_code, 
output reg [1:0] branch,
output reg  memread,
output reg [1:0] memreg,
output reg [1:0] aluop1,
output reg [1:0] aluop0,
output reg  memwrite,
output reg [1:0] alusrc,
output reg [1:0] regwrite,
output reg [1:0] jalsignal,
output reg [1:0] jalrsignal,
input hazard_detected,
input [1:0] zero_flag
);

always @(*) begin

//	if (jalsignal_out  == 1 | jalrsignal_out  == 1 | branch_out & zero_flag == 1) begin
	
//		branch = 2'b00;
//		memread = 2'b00;
//		memreg = 2'b00;
//		aluop1 = 2'b00;
//		aluop0 = 2'b00;
//		memwrite = 2'b00;
//		alusrc = 2'b00;
//		regwrite = 2'b00;
//		jalsignal = 2'b00;
////		jalrsignal = 2'b00;		
	
//	end else begin

	case (op_code) 
	
	7'b0110011: begin  //R-type
	
		branch = 2'b00;
		memread = 2'b00;
		memreg = 2'b00;
		aluop1 = 2'b10;
		aluop0 = 2'b00;
		memwrite = 2'b00;
		alusrc = 2'b00;
		regwrite = 2'b01;
		jalsignal = 2'b00;
		jalrsignal = 2'b00;
	
	
	end 
	
	7'b0010011: begin  //I-type

		branch = 2'b00;
		memread = 2'b00;
		memreg = 2'b00;
		aluop1 = 2'b00;
		aluop0 = 2'b00;
		memwrite = 2'b00;
		alusrc = 2'b01;
		regwrite = 2'b01;
		jalsignal = 2'b00;
		jalrsignal = 2'b00;
	
	end
	
	
	7'b0000011: begin //ld

		branch = 2'b00;
		memread = 2'b01;
		memreg = 2'b01;
		aluop1 = 2'b00;
		aluop0 = 2'b00;
		memwrite = 2'b00;
		alusrc = 2'b01;
		regwrite = 2'b01;	
		jalsignal = 2'b00;
		jalrsignal = 2'b00;
	
	end 
	
	7'b0100011: begin //sd
	
		branch = 2'b00;
		memread = 2'b00;
		memreg = 2'b00; //X
		aluop1 = 2'b00;
		aluop0 = 2'b00;
		memwrite = 2'b01;
		alusrc = 2'b01;
		regwrite = 2'b00;		
		jalsignal = 2'b00;
		jalrsignal = 2'b00;
	
	end 
	
	7'b1100011: begin //beq

		branch = 2'b01;
		memread = 2'b00;
		memreg = 2'b00;  //X
		aluop1 = 2'b00;
		aluop0 = 2'b01;
		memwrite = 2'b00;
		alusrc = 2'b00;
		regwrite = 2'b00;	
		jalsignal = 2'b00;
		jalrsignal = 2'b00;		
	
	end 
	
	7'b1101111: begin //JAL

		branch = 2'b00;
		memread = 2'b00;
		memreg = 2'b00;  //X
		aluop1 = 2'b00;
		aluop0 = 2'b00;
		memwrite = 2'b00;
		alusrc = 2'b00;
		regwrite = 2'b01;	
		jalsignal = 2'b01;
		jalrsignal = 2'b00;
	
	end 
	
	7'b1100111: begin //JALR

		branch = 2'b00;
		memread = 2'b00;
		memreg = 2'b00;  //X
		aluop1 = 2'b00;
		aluop0 = 2'b00;
		memwrite = 2'b00;
		alusrc = 2'b00;
		regwrite = 2'b01;	
		jalsignal = 2'b00;
		jalrsignal = 2'b01;
	
	end
	
	default: 	begin	
	
		branch = 2'b00;
		memread = 2'b00;
		memreg = 2'b00;  //X
		aluop1 = 2'b00;
		aluop0 = 2'b00;
		memwrite = 2'b00;
		alusrc = 2'b00;
		regwrite = 2'b00;	 
		jalsignal = 2'b00;
		jalrsignal = 2'b00;
		
		end
							  
	endcase
	
	
	//end
	
	
	end 


endmodule 