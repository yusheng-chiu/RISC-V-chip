`include "define.v"

module exe(
    input rst_i,
    //from ID/EXE
    input wire[`RegDataBus] reg_data_1_i,
    input wire[`RegDataBus] reg_data_2_i,

    // input wire Branch_i, 
    // input wire MemRead_i, //Mem LW
    // input wire MemtoReg_i, //WB
    input wire[`ALUOpBus] ALUOp_i,
    // input wire MemWrite_i, //Mem SW
    input wire ALUSrc_i, //EXE
    // input wire RegWrite_i, //WB
    
    // input wire[`RegAddrBus] reg_dest_i, //rd
    input wire[`InstAddrBus] pc_i, //for branch
    input wire[`RegDataBus] R_imm_i, //imm
    input wire[`RegDataBus] S_imm_i,
    input wire[`RegDataBus] B_imm_i,
    //---------output---------
    output reg[`InstAddrBus] pc_o,
    output reg[`RegDataBus] w_data_o
    // output reg Branch_o,
    // output reg MemRead_o,
    // output reg MemtoReg_o,
    // output reg MemWrite_o,
    // output reg RegWrite_o,
    // output reg[`RegAddrBus] rd_o
);

    wire[`RegDataBus] op1;
    wire[`RegDataBus] op2;

    always@(*) begin        //pass the signals to the next stage.
        if (rst_i == `RstEnable) begin
            pc_o <= `CpuResetAddr;
            // Branch_o <= `ZeroSignal;
            // MemRead_o <= `ZeroSignal;
            // MemtoReg_o <= `ZeroSignal;
            // MemWrite_o <= `ZeroSignal;
            // RegWrite_o <= `ZeroSignal;
            // rd_o <= `RegZeroAddr;
        end else begin
            pc_o <= pc_i;
            // Branch_o <= Branch_i;
            // MemRead_o <= MemRead_i;
            // MemtoReg_o <= MemtoReg_i;
            // MemWrite_o <= MemWrite_i;
            // RegWrite_o <= RegWrite_i;
            // rd_o <= reg_dest_i;
        end
    end
    //可能有問題
    // if (ALUSrc_i == `Imm) begin     //assign the values of op1 and op2
    //     op2 = R_imm_i;
    // end else begin
    //     op2 = reg_data_2_i;
    // end
    assign op1 = reg_data_1_i;
    assign op2 = reg_data_2_i;

    always @(*) begin   //ALU operation
        if (rst_i == `RstEnable) begin
            w_data_o <= `RegZeroData;
        end else begin
            case(ALUOp_i)
                    `OR:begin
                        if (ALUSrc_i == `Imm) begin
                            w_data_o <= op1 | R_imm_i;
                        end else begin
                            w_data_o <= op1 | op2;
                        end
                    end
                    `AND:begin
                        w_data_o <= op1 & op2;
                    end
                    `ADD:begin
                        w_data_o <= op1 + op2;
                    end
                    `SUB:begin
                        w_data_o <= op1 - op2;
                    end
            endcase
        end
    end
endmodule