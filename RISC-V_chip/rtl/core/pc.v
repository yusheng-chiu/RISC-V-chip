`include "define.v"

module pc(
    input wire rst_i,
    input wire clk_i,
    //---------output---------
    output reg[`InstAddrBus] pc_o,
    output reg ce_o
);
    reg[`InstAddrBus] pc_next;

always @(posedge clk_i) begin
    if (rst_i == `RstEnable) begin
        ce_o <= `ChipDisable;
    end else begin
        ce_o <= `ChipEnable;
    end
end
//一開始沒有位址在pc裡，所以當chip enable時，要賦值給他
always @(posedge ce_o) begin
    pc_o <= `CpuResetAddr;
end

always @(posedge clk_i) begin
    if (rst_i == `RstEnable) begin
        pc_next <= `CpuResetAddr;
    end else begin
        pc_o <= pc_next;
        pc_next <= pc_next + 4'b0100;
    end
end
endmodule
