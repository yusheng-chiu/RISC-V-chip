`include "define.v"

module id_exe (
    input wire rst_i,
    input wire clk_i,

    // from register file
    input wire[`RegDataBus] reg_data_1_i,
    input wire[`RegDataBus] reg_data_2_i,
    //from id
    input wire[`RegAddrBus] reg_addr_1_i,
    input wire[`RegAddrBus] reg_addr_2_i,

    //signal from control unit
    input wire Branch_i, 
    input wire MemRead_i, //Mem LW
    input wire MemtoReg_i, //WB
    input wire[`ALUOpBus] ALUOp_i,
    input wire MemWrite_i, //Mem SW
    input wire ALUSrc_i, //EXE
    input wire RegWrite_i, //WB
    //to ID/EXE
    input wire[`RegDataBus] R_imm_i, // imm
    input wire[`RegAddrBus] reg_dest_i, // rd
    input wire[`InstAddrBus] pc_i, //for branch connected by inst_addr_i;
    input wire[`RegDataBus] S_imm_i,
    input wire[`RegDataBus] B_imm_i,
    //---------output---------
    output reg[`RegDataBus] reg_data_1_o,
    output reg[`RegDataBus] reg_data_2_o,
    output reg[`RegAddrBus] reg_addr_1_o,
    output reg[`RegAddrBus] reg_addr_2_o,

    output reg Branch_o, 
    output reg MemRead_o, //Mem LW
    output reg MemtoReg_o, //WB
    output reg[`ALUOpBus] ALUOp_o,
    output reg MemWrite_o, //Mem SW
    output reg ALUSrc_o, //EXE
    output reg RegWrite_o, //WB
    //to ID/EXE
    output reg[`RegDataBus] R_imm_o, // imm
    output reg[`RegAddrBus] reg_dest_o, // rd
    output reg[`InstAddrBus] pc_o, //for branch
    output reg[`RegDataBus] S_imm_o,
    output reg[`RegDataBus] B_imm_o
);

    always @(posedge clk_i) begin
        if(rst_i == `RstEnable) begin
            reg_data_1_o <= `RegZeroData;
            reg_data_2_o <= `RegZeroData;
            reg_addr_1_o <= `RegZeroAddr;
            reg_addr_2_o <= `RegZeroAddr;

            Branch_o <= `ZeroSignal;
            MemRead_o <= `ZeroSignal; //Mem LW
            MemtoReg_o <= `ZeroSignal; //WB
            ALUOp_o <= `ZeroALUOp;
            MemWrite_o <= `ZeroSignal;//Mem SW
            ALUSrc_o <= `ZeroSignal;//EXE
            RegWrite_o <= `ZeroSignal;//WB
            R_imm_o <= `RegZeroData;
            reg_dest_o <= `RegZeroAddr;
            pc_o <= `ZeroInstAddr;
            S_imm_o <= `RegZeroData;
            B_imm_o <= `RegZeroData;
        end else begin
            reg_data_1_o <= reg_data_1_i;
            reg_data_2_o <= reg_data_2_i;
            reg_addr_1_o <= reg_addr_1_i;
            reg_addr_2_o <= reg_addr_2_i;

            Branch_o <= Branch_i;
            MemRead_o <= MemRead_i; //Mem LW
            MemtoReg_o <= MemtoReg_i; //WB
            ALUOp_o <= ALUOp_i;
            MemWrite_o <= MemWrite_i;//Mem SW
            ALUSrc_o <= ALUSrc_i;//EXE
            RegWrite_o <= RegWrite_i;//WB
            R_imm_o <= R_imm_i;
            reg_dest_o <= reg_dest_i;
            pc_o <= pc_i;
            S_imm_o <= S_imm_i;
            B_imm_o <= B_imm_i;
        end
    end
endmodule