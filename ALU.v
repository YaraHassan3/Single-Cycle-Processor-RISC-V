module ALU #(parameter width = 32) 
      ( input  [width-1:0] A,B, 
        output reg [width-1:0] result,
        output reg zero_flag, sign_flag,
        input [2:0] ALUcontrol );
    
    always @(*)
      begin 
        case (ALUcontrol)
        3'b000: result = A + B;
        3'b001: result = A - B;
        3'b011: result = A & B;
        3'b010: result = A | B;
        3'b101: if (A < B) begin result = 32'd1 ; end  else begin result = 32'd0; end
        default: result = 32'd0;
       endcase 

  zero_flag = (result == 32'b0) ? 1 : 0;
  sign_flag = result[width-1];

  end
endmodule
