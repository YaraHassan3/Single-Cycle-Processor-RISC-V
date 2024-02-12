module ALU_Decoder( 
      input       [1:0] ALU_Op,
      input             OP5,
      input             funct7,
      input       [2:0] funct3 ,
      output reg  [2:0] ALU_Control  );
      
  always @(*)
    begin
      case(ALU_Op)
        2'b00: ALU_Control= 3'b000;
        2'b01: ALU_Control= 3'b001;
        2'b10: begin 
          case (funct3)
            3'b000: 
            if ({OP5,funct7}== 2'b11)
                ALU_Control= 3'b001;
           else 
                ALU_Control= 3'b000; 
             
          3'b010 : ALU_Control= 3'b101;
          3'b110 : ALU_Control= 3'b010;
          3'b111 : ALU_Control= 3'b011;
          endcase
        end
        default : ALU_Control= 3'b000;
      endcase
end
endmodule