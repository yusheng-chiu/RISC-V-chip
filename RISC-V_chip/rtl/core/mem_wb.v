`include "define.v"

module mem_wb(
    input wire rst_i,
    input wire clk_i,

    input wire[`RegDataBus] reg_data_i,
    input wire[`RegDataBus] mem_data_i,
    input wire MemtoReg_i,              //pass to wb stage
    input wire RegWrite_i,
    input wire[`RegAddrBus] rd_i,
    //---------output---------
    output reg[`RegDataBus] reg_data_o,
    output reg[`RegDataBus] mem_data_o,
    output reg MemtoReg_o,              //pass to wb stage
    output reg RegWrite_o,
    output reg[`RegAddrBus] rd_o
);
always@(posedge clk_i) begin
    if (rst_i == `RstEnable) begin
        MemtoReg_o <= `ZeroSignal;
        RegWrite_o <= `ZeroSignal;
        rd_o <= `RegZeroAddr;
        reg_data_o <= `RegZeroData;
        mem_data_o <= `RegZeroData;
    end else begin
        MemtoReg_o <= MemtoReg_i;
        RegWrite_o <= RegWrite_i;
        rd_o <= rd_i;
        reg_data_o <= reg_data_i;
        mem_data_o <= mem_data_i;
    end
end 
endmodule