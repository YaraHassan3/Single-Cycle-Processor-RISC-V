module InstructionMemory #(parameter Memory_Width = 'd32, Memory_Depth = 'd100) 
(input wire [31:0] A_Instr, output reg [31:0] Instr);

reg [31:0] Instr_Memory [0:Memory_Depth-1];

initial begin
    $readmemh("Fibonacci_Machine_Code.txt", Instr_Memory);
end

  always @(*) 
    begin
    Instr = Instr_Memory[A_Instr>>2];
    end
endmodule

