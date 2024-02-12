module Mux3x1 #(parameter width = 'd32)
(
  	 	input  [width-1:0]  Data1, Data2,Data3,
	   input  [1:0]        sel,
     output reg [width-1:0] out );


always @(*) 
begin
  case (sel)                       //Selction is ResultSrc
            2'b00:   out = Data1;  //ALUResult
            2'b01:   out = Data2;  //ReadData
            2'b10:   out = Data3;  //Pc + 4 
            default: out = 32'b0;
        endcase
end
endmodule