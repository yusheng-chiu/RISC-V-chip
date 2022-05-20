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
`define ZeroInstAddr 6'b0
`define RegZeroData 32'b0   //for zero data
`define RegZeroAddr 5'b0

`define ForwardingExe 2'b01
`define ForwardingMem 2'b10
`define NoForward 2'b00

//bus
`define InstAddrBus 7:0     //ROM 64個指令 6 + 2(byte alignment)
`define InstBus 31:0
`define OpcodeBus 6:0
`define Funct3Bus 2:0
`define Funct7Bus 6:0
`define ALUOpBus 3:0        //4 bits
`define ALUControlBus 3:0
`define RegAddrBus 4:0
`define RegDataBus 31:0


`define RegNum 32
`define InstMemNum 64
`define InstMemNumLog2 6
`define ZeroReg 5'b0

//ALU Op  skip ALU control
`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define SUB 4'b0011
`define XOR 4'b0100
`define SLT 4'b0101
`define SLTU 4'b0110
`define SLL 4'b0111
`define SRL 4'b1000
`define SRAL 4'b1001
`define NOP 4'b1111

//type
`define R_type 7'b0110011
`define I_type 7'b0010011
`define S_type 7'b0100011
`define B_type 7'b1100011
// `define U-type 
// `define J-type


//Inst Set funct3
`define ADDI 3'b000
`define SLTI 3'b010
`define SLTIU 3'b011
`define XORI 3'b100
`define ORI 3'b110
`define ANDI 3'b111
`define SLLI 3'b001
`define SRLI 3'b101