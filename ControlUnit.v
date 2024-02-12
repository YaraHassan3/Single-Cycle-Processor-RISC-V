module ControlUnit(
   input zero, function7,sign,
   input [2:0] function3,
   input [6:0] OPCode,
   output Mem_Write, ALU_Src, Reg_Write,
   output reg PCsrc, 
   output [2:0] ALU_control,
   output [1:0] Imm_Src,Result_Src );

wire Branch,Jump,beq,bnq,blt;
wire [1:0] ALUOP;


assign beq = (Branch & zero)| Jump; 
assign bnq = (Branch & zero)| Jump;  
assign blt = (Branch & sign)| Jump;

always @(*) begin
case (function3)
            3'b000:  PCsrc = beq; 
            3'b001:  PCsrc = bnq; 
            3'b100:  PCsrc = blt; 
            default: PCsrc = 1'b0;
        endcase
end
MainDecoder MainDecoderControlUnit (
  .ResultSrc (Result_Src), 
  .Branch    (Branch),
  .MemWrite  (Mem_Write),
  .ALUSrc    (ALU_Src),
  .RegWrite  (Reg_Write),
  .ImmSrc    (Imm_Src),
  .ALU_OP    (ALUOP),
  .OP        (OPCode),
  .jump      (Jump));
  
ALU_Decoder   ALUDecoderControlUnit(
  .ALU_Op     (ALUOP),
  .OP5         (OPCode[5]),
  .funct7      (function7),
  .funct3      (function3),
  .ALU_Control (ALU_control) );
endmodule