`include "define.v"

module rom(
    input wire ce_i,
    input wire[`InstAddrBus] inst_addr_i,

    output reg[`InstBus] inst_o
);

    reg[`InstBus] inst_mem[0:`InstMemNum-1];   

    // .initial begin
    //     $readmemh("inst_rom.data", inst_mem);
    // end

    always@(*) begin
        if (ce_i == `ChipDisable) begin
            inst_o <= `ZeroInst;
        end else begin
            inst_o <= inst_mem[inst_addr_i[`InstMemNumLog2+1:2]];
        end
    end
endmodule
