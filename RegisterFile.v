module RegisterFile #(parameter Address_Width = 'd5, Register_Width = 'd32,Register_Depth = 'd32) 
(
    input         [Address_Width-1:0]        A1,
    input         [Address_Width-1:0]        A2,
    input         [Address_Width-1:0]        A3,
    input                                    CLK,RST,
    input                                    WE3,
    input         [Register_Width-1:0]  WD3,
    output reg    [Register_Width-1:0]  RD1,
    output reg    [Register_Width-1:0]  RD2 );

reg [Register_Width-1:0]  Reg_File [0:Register_Depth-1];
integer i;

always @(*) begin
    RD1 = Reg_File[A1];
end

always @(*) begin
    RD2 = Reg_File[A2];
end


always @(posedge CLK or negedge RST) 
begin
    if(!RST) begin
      for (i =0; i<Register_Depth; i = i+1 ) begin
        Reg_File[i] <= 'b0;
        
      end
    end
    else if (WE3) begin
      Reg_File[A3] <= WD3;
    end   
end
    
endmodule