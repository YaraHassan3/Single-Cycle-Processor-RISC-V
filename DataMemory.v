module DataMemory #(parameter  Data_Memory_Width = 'd32,Data_Memory_Depth = 'd100) (
    input     [Data_Memory_Width-1:0]   A,
    input                               CLK,RST,
    input                               WE,
    input     [Data_Memory_Width-1:0]   WD,
    output reg   [Data_Memory_Width-1:0]   RD
);

integer i;

reg [Data_Memory_Width-1:0]  Data_Memory  [0:Data_Memory_Depth-1];

always @(*) begin
    RD = Data_Memory[A];
end

  
always @(posedge CLK or negedge RST) begin
    if(!RST) begin 
        for (i =0; i<Data_Memory_Depth; i = i+1 ) begin
        Data_Memory [i] <= 'b0;
      end
       
    end
    else if (WE=='b1) begin
        Data_Memory[A] <= WD;
    end
   
end
endmodule