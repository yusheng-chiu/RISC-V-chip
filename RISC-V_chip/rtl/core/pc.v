`include "define.v"

module pc(
    input wire rst_i,
    input wire clk_i,
    input wire[`InstAddrBus] branch_addr_i, //from exe.
    input wire branch_enable_i, //from exe or bcu in stage id.
    input wire[`InstAddrBus] jump_addr_i,
    input wire jump_enable_i,
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
        pc_o <= `CpuResetAddr;
    end else begin
        if (branch_enable_i) begin  //branch.
            pc_o <= branch_addr_i;
            pc_next <= branch_addr_i + 4'b0100;
        end else if (jump_enable_i) begin  //jump.
            pc_o <= jump_addr_i;
            pc_next <= jump_addr_i + 4'b0100;
        end else begin
            pc_o <= pc_next;
            pc_next <= pc_next + 4'b0100;
        end
    end
end
endmodule
