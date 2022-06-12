`include "define.v"

module control(
    input rst_i,
    input wire[`OpcodeBus] opcode_i,//from inst[6:0]
    input wire[`Funct3Bus] funct3_i,//from inst[14:12]
    input wire[`Funct7Bus] funct7_i,//R-type
    //---------output---------
    //output reg RegDst, 之後看看有沒有需要因為RISC-V好像都用rd
    output reg Branch_o, 
    output reg MemRead_o, //Mem LW
    output reg MemtoReg_o, //WB
    output reg[`ALUOpBus] ALUOp_o,
    output reg MemWrite_o, //Mem SW
    output reg ALUSrc_o, //EXE
    output reg RegWrite_o, //WB
    output reg reg_read1_e_o, //to regfile!!!
    output reg reg_read2_e_o
);

always @(*) begin
    if (rst_i == `RstEnable) begin
        Branch_o <= `ZeroSignal;
        MemRead_o <= `ZeroSignal;
        MemtoReg_o <= `ZeroSignal;
        MemWrite_o <= `ZeroSignal;
        ALUOp_o <= `NOP_alu;
        reg_read1_e_o <= `ReadDisable;
        reg_read2_e_o <= `ReadDisable;
        ALUSrc_o <= `ZeroSignal;
        RegWrite_o <= `ZeroSignal;
    end else begin
        case (opcode_i)
            `I_type:begin
                case (funct3_i)
                `ORI:begin
                    Branch_o <= `ZeroSignal;
                    MemRead_o <= `ZeroSignal;
                    MemtoReg_o <= `ZeroSignal;
                    MemWrite_o <= `ZeroSignal;
                    ALUOp_o <= `OR_alu;
                    ALUSrc_o <= `Imm;
                    reg_read1_e_o <= `ReadEnable;
                    reg_read2_e_o <= `ReadDisable;
                    RegWrite_o <= `OneSignal;
                end
                `ADDI:begin
                    Branch_o <= `ZeroSignal;
                    MemRead_o <= `ZeroSignal;
                    MemtoReg_o <= `ZeroSignal;
                    MemWrite_o <= `ZeroSignal;
                    ALUOp_o <= `ADD_alu;
                    ALUSrc_o <= `Imm;
                    reg_read1_e_o <= `ReadEnable;
                    reg_read2_e_o <= `ReadDisable;
                    RegWrite_o <= `OneSignal;
                end
                `SLTI:begin
                    Branch_o <= `ZeroSignal;
                    MemRead_o <= `ZeroSignal;
                    MemtoReg_o <= `ZeroSignal;
                    MemWrite_o <= `ZeroSignal;
                    ALUOp_o <= `SLT_alu;
                    ALUSrc_o <= `Imm;
                    reg_read1_e_o <= `ReadEnable;
                    reg_read2_e_o <= `ReadDisable;
                    RegWrite_o <= `OneSignal;
                end
                `SLTIU:begin
                    Branch_o <= `ZeroSignal;
                    MemRead_o <= `ZeroSignal;
                    MemtoReg_o <= `ZeroSignal;
                    MemWrite_o <= `ZeroSignal;
                    ALUOp_o <= `SLTU_alu;
                    ALUSrc_o <= `Imm;
                    reg_read1_e_o <= `ReadEnable;
                    reg_read2_e_o <= `ReadDisable;
                    RegWrite_o <= `OneSignal;
                end
                `XORI:begin
                    Branch_o <= `ZeroSignal;
                    MemRead_o <= `ZeroSignal;
                    MemtoReg_o <= `ZeroSignal;
                    MemWrite_o <= `ZeroSignal;
                    ALUOp_o <= `XOR_alu;
                    ALUSrc_o <= `Imm;
                    reg_read1_e_o <= `ReadEnable;
                    reg_read2_e_o <= `ReadDisable;
                    RegWrite_o <= `OneSignal;
                end
                `ANDI:begin
                    Branch_o <= `ZeroSignal;
                    MemRead_o <= `ZeroSignal;
                    MemtoReg_o <= `ZeroSignal;
                    MemWrite_o <= `ZeroSignal;
                    ALUOp_o <= `AND_alu;
                    ALUSrc_o <= `Imm;
                    reg_read1_e_o <= `ReadEnable;
                    reg_read2_e_o <= `ReadDisable;
                    RegWrite_o <= `OneSignal;
                end
                `SLLI:begin
                    Branch_o <= `ZeroSignal;
                    MemRead_o <= `ZeroSignal;
                    MemtoReg_o <= `ZeroSignal;
                    MemWrite_o <= `ZeroSignal;
                    ALUOp_o <= `SLL_alu;
                    ALUSrc_o <= `Imm;
                    reg_read1_e_o <= `ReadEnable;
                    reg_read2_e_o <= `ReadDisable;
                    RegWrite_o <= `OneSignal;
                end
                `SRLI:begin
                    Branch_o <= `ZeroSignal;
                    MemRead_o <= `ZeroSignal;
                    MemtoReg_o <= `ZeroSignal;
                    MemWrite_o <= `ZeroSignal;
                    ALUSrc_o <= `Imm;
                    reg_read1_e_o <= `ReadEnable;
                    reg_read2_e_o <= `ReadDisable;
                    RegWrite_o <= `OneSignal;
                    if (funct7_i == 7'b0000000) begin
                        ALUOp_o <= `SRL_alu;
                    end else begin
                        ALUOp_o <= `SRAL_alu;
                    end
                end
                default:begin
                end
                endcase
            end 
            `R_type:begin
                case (funct3_i)
                    `ADDI:begin
                        Branch_o <= `ZeroSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `ADD_alu;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadEnable;
                        ALUSrc_o <= !`Imm;
                        RegWrite_o <= `OneSignal;
                        if (funct7_i == 7'b0100000) begin
                            ALUOp_o <= `SUB_alu;
                        end else begin
                        end
                    end
                    `SLLI:begin
                        Branch_o <= `ZeroSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `SLL_alu;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadDisable;
                        ALUSrc_o <= `Imm;
                        RegWrite_o <= `OneSignal;
                    end
                    `SLTI:begin
                        Branch_o <= `ZeroSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `SLT_alu;
                        ALUSrc_o <= !`Imm;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadEnable;
                        RegWrite_o <= `OneSignal;
                    end
                    `SLTIU:begin
                        Branch_o <= `ZeroSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `SLTU_alu;
                        ALUSrc_o <= !`Imm;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadEnable;
                        RegWrite_o <= `OneSignal;
                    end
                    `XORI:begin
                        Branch_o <= `ZeroSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `XOR_alu;
                        ALUSrc_o <= !`Imm;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadEnable;
                        RegWrite_o <= `OneSignal;
                    end
                    `SRLI:begin
                        Branch_o <= `ZeroSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUSrc_o <= `Imm;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadDisable;
                        RegWrite_o <= `OneSignal;
                        if (funct7_i == 7'b0000000) begin
                            ALUOp_o <= `SRL_alu;
                        end else begin
                            ALUOp_o <= `SRAL_alu;
                        end
                    end
                    `ORI:begin
                        Branch_o <= `ZeroSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `OR_alu;
                        ALUSrc_o <= !`Imm;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadEnable;
                        RegWrite_o <= `OneSignal;
                    end
                    `ANDI:begin
                        Branch_o <= `ZeroSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `AND_alu;
                        ALUSrc_o <= !`Imm;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadEnable;
                        RegWrite_o <= `OneSignal;
                    end                    
                    default:begin
                    end
                endcase
            end
            `B_type:begin
                case(funct3_i)
                    `BEQ:begin
                        Branch_o <= `OneSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `BEQ_alu;
                        ALUSrc_o <= !`Imm;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadEnable;
                        RegWrite_o <= `ZeroSignal;
                    end  
                    `BNE:begin
                        Branch_o <= `OneSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `BNE_alu;
                        ALUSrc_o <= !`Imm;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadEnable;
                        RegWrite_o <= `ZeroSignal;
                    end
                    `BLT:begin
                        Branch_o <= `OneSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `BLT_alu;
                        ALUSrc_o <= !`Imm;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadEnable;
                        RegWrite_o <= `ZeroSignal;
                    end
                    `BGE:begin
                        Branch_o <= `OneSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `BGE_alu;
                        ALUSrc_o <= !`Imm;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadEnable;
                        RegWrite_o <= `ZeroSignal;
                    end
                    `BLTU:begin
                        Branch_o <= `OneSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `BLTU_alu;
                        ALUSrc_o <= !`Imm;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadEnable;
                        RegWrite_o <= `ZeroSignal;
                    end
                    `BGEU:begin
                        Branch_o <= `OneSignal;
                        MemRead_o <= `ZeroSignal;
                        MemtoReg_o <= `ZeroSignal;
                        MemWrite_o <= `ZeroSignal;
                        ALUOp_o <= `BGEU_alu;
                        ALUSrc_o <= !`Imm;
                        reg_read1_e_o <= `ReadEnable;
                        reg_read2_e_o <= `ReadEnable;
                        RegWrite_o <= `ZeroSignal;
                    end
                endcase
            end
            `Inst_JAL:begin
                Branch_o <= `ZeroSignal;
                MemRead_o <= `ZeroSignal;
                MemtoReg_o <= `ZeroSignal;
                MemWrite_o <= `ZeroSignal;
                ALUOp_o <= `JAL_alu;
                ALUSrc_o <= !`Imm;
                reg_read1_e_o <= `ReadDisable;
                reg_read2_e_o <= `ReadDisable;
                RegWrite_o <= `OneSignal;
            end
            `Inst_JALR:begin
                Branch_o <= `ZeroSignal;
                MemRead_o <= `ZeroSignal;
                MemtoReg_o <= `ZeroSignal;
                MemWrite_o <= `ZeroSignal;
                ALUOp_o <= `JAL_alu;
                ALUSrc_o <= !`Imm;
                reg_read1_e_o <= `ReadEnable;
                reg_read2_e_o <= `ReadDisable;
                RegWrite_o <= `OneSignal;
            end
            default: begin
                Branch_o <= `ZeroSignal;
                MemRead_o <= `ZeroSignal;
                MemtoReg_o <= `ZeroSignal;
                MemWrite_o <= `ZeroSignal;
                ALUOp_o <= `NOP_alu;
                reg_read1_e_o <= `ReadDisable;
                reg_read2_e_o <= `ReadDisable;
                ALUSrc_o <= `ZeroSignal;
                RegWrite_o <= `ZeroSignal;
            end
        endcase
    end
end
endmodule