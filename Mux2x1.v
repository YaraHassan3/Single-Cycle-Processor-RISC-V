module Mux2x1 #(parameter width = 'd32)
(
  	 	input  [width-1:0]  Data1, Data2, 
	   input               sel,
     output [width-1:0]  out );

//selction for ALUSrc, PCSrc 
//Data1 --> RD2 , Data2 --> ImmExt this case when ALUSrc is a selction for Mux
//Data1 --> PC + 4 , Data2 --> PCTarget this case when PCSrc is a selction for Mux

assign out = (sel==1)? Data2 : Data1;

endmodule
