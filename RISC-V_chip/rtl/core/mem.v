`include "define.v"

module mem(
    input wire rst_i,

    // input wire[`InstAddrBus] pc_i,      //branch
    input wire[`RegDataBus] w_data_i,      //SW or LW or WB
    input wire Branch_i,
    input wire MemRead_i,
    input wire MemWrite_i,
    // input wire MemtoReg_i,              //pass to wb stage
    // input wire RegWrite_i,
    // input wire[`RegAddrBus] rd_i,
    //---------output---------
    // output reg[`InstAddrBus] pc_o,
    // output reg[`RegDataBus] reg_data_o,
    output reg[`RegDataBus] mem_data_o
    // output reg MemtoReg_o,              //pass to wb stage
    // output reg RegWrite_o,
    // output reg[`RegAddrBus] rd_o
);

    always @(*) begin
        if (rst_i == `RstEnable) begin
            // pc_o <= `CpuResetAddr;
            // reg_data_o <= `RegZeroData;
            mem_data_o <= `RegZeroData;
            // MemtoReg_o <= `ZeroSignal;           //pass to wb stage
            // RegWrite_o <= `ZeroSignal;
            // rd_o <= `RegZeroAddr;
        end else begin
            // pc_o <= pc_i;
            // reg_data_o <= w_data_i;
            mem_data_o <= `RegZeroData;         //data read from memory
            // MemtoReg_o <= MemtoReg_i;           //pass to wb stage
            // RegWrite_o <= RegWrite_i;;
            // rd_o <= rd_i;
        end
    end
endmodule
