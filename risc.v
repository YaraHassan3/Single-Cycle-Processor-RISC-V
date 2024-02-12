module risc(
    input CLK,
    input RST ); 

wire    [31:0]    SrcA;
wire    [31:0]    ImmExt;
wire    [31:0]    SrcB;
wire    [31:0]    RD2;
wire    [31:0]    PC;
wire    [31:0]    PCNext;
wire    [31:0]    Instruction;
wire    [31:0]    ALUResult;
wire    [31:0]    ReadData;
wire    [31:0]    WD3;
wire    [31:0]    PCTarget;
wire    [31:0]    PCPlus4;
wire              ALUSrc;
wire              PCSrc;
wire              WE3;
wire              MemWrite;
wire              Zero_Flag;
wire    [1:0]     ImmSrc;
wire              Sign;
wire    [1:0]     ResultSrc;
wire    [2:0]     ALUControl;

Program_Counter                 ProgrammCounterTopModule
(.PC_next                      (PCNext),
 .CLK                          (CLK),
 .RST                          (RST),
 .PC                           (PC)
);

InstructionMemory               InstructionMemoryTopModule
(.A_Instr                      (PC),
 .Instr                        (Instruction)
);


Adder                         Adder_1
(
	.A                           (PC),
	.B       	 	 	               (ImmExt),
	.C                           (PCTarget)
);

Adder                         Adder_2
(
	.A                           (PC),
	.B                           (32'd4),
	.C                           (PCPlus4)
);

RegisterFile                    RegFileTop
(.A1                           (Instruction[19:15]),
 .A2                           (Instruction[24:20]),
 .A3                           (Instruction[11:7]),
 .CLK                          (CLK),
 .RST                          (RST),
 .WE3                          (WE3),
 .WD3                          (WD3),
 .RD1                          (SrcA),
 .RD2                          (RD2)
);

Mux2x1                          MUX_of_AluSRC
(.sel                          (ALUSrc),
 .Data1                        (RD2),
 .Data2                        (ImmExt),
 .out                          (SrcB)
);

Mux2x1                          MUX_of_PcSRC
(.sel                          (PCSrc),
 .Data1                        (PCPlus4),
 .Data2                        (PCTarget),
 .out                          (PCNext)
);

SignModule                      SignExtendTopModule
(.instr                        (Instruction[31:7]),
 .ImmSrc                       (ImmSrc),
 .ImmExtended                  (ImmExt)
);

Mux3x1                          MUX_three_options_TopModule
(.sel                          (ResultSrc),
 .Data1                        (ALUResult),
 .Data2                        (ReadData),
 .Data3                        (PCPlus4),
 .out                          (WD3)
);

DataMemory                      DataMemoryTopModule
(.A                            (ALUResult),
 .CLK                          (CLK),
 .RST                          (RST),
 .WE                           (MemWrite),
 .WD                           (RD2),
 .RD                           (ReadData)
);

ALU                             ALUTopModule
(.A                            (SrcA),
 .B                            (SrcB),
 .ALUcontrol                   (ALUControl),
 .result                       (ALUResult),
 .zero_flag                    (Zero_Flag),
 .sign_flag                    (Sign)
);

ControlUnit                    ControlUnitTopModule
(.function3                    (Instruction[14:12]),
 .function7                    (Instruction[30]),
 .zero                         (Zero_Flag),
 .OPCode                       (Instruction[6:0]),
 .Imm_Src                      (ImmSrc),
 .Mem_Write                    (MemWrite),
 .ALU_Src                      (ALUSrc),
 .Result_Src                   (ResultSrc),
 .Reg_Write                    (WE3),
 .PCsrc                        (PCSrc),
 .ALU_control                  (ALUControl),
 .sign                         (Sign)
);
endmodule