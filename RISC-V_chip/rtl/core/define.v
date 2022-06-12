`define CpuResetAddr 6'b0

`define RstEnable 1'b0      //for enable signal
`define RstDisable 1'b1
`define ChipDisable 1'b0
`define ChipEnable 1'b1
`define WriteEnable 1'b1
`define ReadEnable 1'b1
`define ReadDisable 1'b0
`define ZeroSignal 1'b0     //for control signal
`define OneSignal 1'b1
`define Imm 1'b1            //for ALUSrc
`define Rs2 1'b0
`define ZeroALUOp 4'b0
`define ZeroInst 32'b0      //for zero instruction
`define ZeroInstAddr 32'b0
`define RegZeroData 32'b0   //for zero data
`define RegZeroAddr 5'b0

`define ForwardingExe 2'b01
`define ForwardingMem 2'b10
`define NoForward 2'b00

//bus
`define InstAddrBus 31:0     //ROM 2^30個指令 30 + 2(byte alignment) 4GB
`define InstBus 31:0
`define OpcodeBus 6:0
`define Funct3Bus 2:0
`define Funct7Bus 6:0
`define ALUOpBus 4:0        //5 bits
`define ALUControlBus 3:0
`define RegAddrBus 4:0
`define RegDataBus 31:0


`define RegNum 32
`define InstMemNum 1024
`define InstMemNumLog2 10
`define ZeroReg 5'b0

//ALU Op  skip ALU control
`define AND_alu 5'b00000
`define OR_alu 5'b00001
`define ADD_alu 5'b00010
`define SUB_alu 5'b00011
`define XOR_alu 5'b00100
`define SLT_alu 5'b00101
`define SLTU_alu 5'b00110
`define SLL_alu 5'b00111
`define SRL_alu 5'b01000
`define SRAL_alu 5'b01001
`define BEQ_alu 5'b01010
`define BNE_alu 5'b01011
`define BLT_alu 5'b01100
`define BGE_alu 5'b01101
`define BLTU_alu 5'b01110
`define BGEU_alu 5'b01111
`define JAL_alu 5'b10000
`define NOP_alu 5'b11111


//type
`define R_type 7'b0110011
`define I_type 7'b0010011
`define S_type 7'b0100011
`define B_type 7'b1100011
// `define U-type
`define J-type 
`define Inst_JAL 7'b1101111
`define Inst_JALR 7'b1100111


//Inst Set funct3
`define ADDI 3'b000
`define SLTI 3'b010
`define SLTIU 3'b011
`define XORI 3'b100
`define ORI 3'b110
`define ANDI 3'b111
`define SLLI 3'b001
`define SRLI 3'b101

`define BEQ 3'b000
`define BNE 3'b001
`define BLT 3'b100
`define BGE 3'b101
`define BLTU 3'b110
`define BGEU 3'b111
