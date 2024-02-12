module Program_Counter  #(parameter  PC_width = 'd32) 
  (
    input       [PC_width-1:0] PC_next,
    input                      CLK,
    input                      RST,
    output reg  [PC_width-1:0] PC);

always @(posedge CLK or negedge RST)
begin
    if(!RST) 
        PC <= 'b0; 

    else 
        PC <= PC_next;  
end
endmodule
