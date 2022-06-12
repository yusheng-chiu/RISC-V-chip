`include "define.v"

module if_id (
    input wire rst_i,
    input wire clk_i,
    input wire[`InstBus] inst_i,
    input wire[`InstAddrBus] inst_addr_i,
    input wire flush_enable_i,

    output reg[`InstBus] inst_o,
    output reg[`InstAddrBus] inst_addr_o //pc_o
);

always @(posedge clk_i) begin
    if (rst_i == `RstEnable || flush_enable_i) begin //flush if/id
        inst_o <= `ZeroInst;
        inst_addr_o <= `ZeroInstAddr;
    end else begin
        inst_o <= inst_i;
        inst_addr_o <= inst_addr_i;
    end
end
endmodule