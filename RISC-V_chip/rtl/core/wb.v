`include "define.v"
module wb(
    input wire rst_i,
    input wire MemtoReg_i,
    // input wire RegWrite_i,
    input wire[`RegDataBus] reg_data_i,
    input wire[`RegDataBus] mem_data_i,
    //---------output---------
    // output reg RegWrite_o,
    output reg[`RegDataBus] w_data_o
);
    always @(*) begin
        if (rst_i == `RstEnable) begin
            // RegWrite_o <= `ZeroSignal;
            w_data_o <= `RegZeroData;
        end else begin
            if (MemtoReg_i == `OneSignal) begin
                w_data_o <= mem_data_i;
            end else begin
                w_data_o <= reg_data_i;
            end
            // RegWrite_o <= RegWrite_i;
        end
    end
endmodule