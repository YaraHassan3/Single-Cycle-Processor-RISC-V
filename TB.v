`timescale 1ns/1ns
module TB();
reg CLK;
reg RST;
always #50 CLK = ~CLK;

risc     TBmodule
  ( .CLK(CLK),
    .RST(RST)
    );


initial begin
  RST = 1'b0;
  CLK = 1'b1;
  #100;

  RST = 1'b1;
  #7000;
end
endmodule