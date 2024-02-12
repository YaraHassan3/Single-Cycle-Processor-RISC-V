module SignModule #(parameter  width = 'd32) 
( 
    input         [width-1:7]      instr,
    input         [1:0]            ImmSrc,
    output reg    [width-1:0]      ImmExtended);


  always @(*) 
    begin
      case (ImmSrc) 
        2'b00 :   ImmExtended = {{20{instr[31]}}, instr[31:20]};  //I-Type 
        2'b01 :   ImmExtended = {{20{instr[31]}}, instr[31:25], instr[11:7]}; //S-Type
        2'b10 :   ImmExtended = {{19{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; //B-Type
        2'b11 :   ImmExtended = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0}; //J-Typ
        default : ImmExtended = 'b0;
       endcase
    end
endmodule
