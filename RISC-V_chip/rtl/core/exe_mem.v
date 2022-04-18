`include "define.v"

module exe_mem(
    input wire rst_i,
    input wire clk_i,

    input wire[`InstAddrBus] pc_i,
    input wire[`RegDataBus] w_data_i,
    input wire Branch_i,
    input wire MemRead_i,
    input wire MemtoReg_i,
    input wire MemWrite_i,
    input wire RegWrite_i,
    input wire[`RegAddrBus] rd_i,
    //---------output---------
    output reg[`InstAddrBus] pc_o,
    output reg[`RegDataBus] w_data_o,
    output reg Branch_o,
    output reg MemRead_o,
    output reg MemtoReg_o,
    output reg MemWrite_o,
    output reg RegWrite_o,
    output reg[`RegAddrBus] rd_o
);

    always @(posedge clk_i) begin
        if (rst_i == `RstEnable) begin
            pc_o <= `ZeroInstAddr;
            w_data_o <= `RegZeroData;
            Branch_o <= `ZeroSignal;
            MemRead_o <= `ZeroSignal;
            MemtoReg_o <= `ZeroSignal;
            MemWrite_o <= `ZeroSignal;
            RegWrite_o <= `ZeroSignal;
            rd_o <= `RegZeroAddr;
        end else begin
            pc_o <= pc_i;
            w_data_o <= w_data_i;
            Branch_o <= Branch_i;
            MemRead_o <= MemRead_i;
            MemtoReg_o <= MemtoReg_i;
            MemWrite_o <= MemWrite_i;
            RegWrite_o <= RegWrite_i;
            rd_o <= rd_i;
        end
    end
endmodule