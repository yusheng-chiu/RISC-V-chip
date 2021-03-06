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
        ALUOp_o <= `NOP;
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
                    ALUOp_o <= `OR;
                    ALUSrc_o <= `Imm;
                    reg_read1_e_o <= `ReadEnable;
                    reg_read2_e_o <= `ReadDisable;
                    RegWrite_o <= `OneSignal;
                end
                endcase
            end 
            default: begin
                Branch_o <= `ZeroSignal;
                MemRead_o <= `ZeroSignal;
                MemtoReg_o <= `ZeroSignal;
                MemWrite_o <= `ZeroSignal;
                ALUOp_o <= `NOP;
                reg_read1_e_o <= `ReadDisable;
                reg_read2_e_o <= `ReadDisable;
                ALUSrc_o <= `ZeroSignal;
                RegWrite_o <= `ZeroSignal;
            end
        endcase
    end
end
endmodule