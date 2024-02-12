module MainDecoder(
    input [6:0] OP, 
    output reg  Branch, MemWrite, ALUSrc, RegWrite,jump,
    output reg [1:0] ResultSrc,ImmSrc,ALU_OP); 
  
  always @(*) 
    begin 
      case (OP) 
          7'b000_0011: //Load Instruction(lw), op-code=3 
            begin
              RegWrite=1;
              ImmSrc=2'b00;
              ALUSrc=1; 
              MemWrite=0;
              ResultSrc=2'b01;
              Branch=0; 
              ALU_OP=2'b00;
              jump=0;
            end
          
          7'b010_0011: //store Instruction(sw), op-code=35
            begin 
              RegWrite=0;
              ImmSrc=2'b01;
              ALUSrc=1;
              MemWrite=1;
              Branch=0; 
              ALU_OP=2'b00;
              jump=0;
            end
            
          7'b011_0011: //R-Type Instruction, op-code=51 
            begin
              RegWrite=1;
              ALUSrc=0;
              MemWrite=0;
              ResultSrc=2'b00;
              Branch=0;
              ALU_OP=2'b10;
              jump=0;
            end
            
          7'b110_0011: //Branch Equal Instruction(beq), op-code=99
            begin
              RegWrite=0;
              ImmSrc=2'b10;
              ALUSrc=0;
              MemWrite=0;
              Branch=1;
              ALU_OP=2'b01;
              jump=0;
            end
            
          7'b001_0011:      //addi instruction, op-code=19
            begin
              RegWrite=1;
              ImmSrc=2'b00;
              ALUSrc=1;
              MemWrite=0;
              ResultSrc=2'b00;
              Branch=0;
              ALU_OP=2'b10;
              jump=0;
            end
            
          7'b110_1111:      //jal instruction(jump and link), op-code=111 
            begin
              RegWrite=1;
              ImmSrc=2'b11;
              MemWrite=0;
              ResultSrc=2'b10;
              Branch=0;
              jump=1;
            end 
            
          default:
          begin 
            RegWrite=0;
            ImmSrc=2'b00;
            ALUSrc=0;
            MemWrite=0;
            ResultSrc=2'b00;
            Branch=0;
            ALU_OP=2'b00;  
            jump=0;
      end
    endcase
  end
endmodule