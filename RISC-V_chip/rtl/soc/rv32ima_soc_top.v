`include "define.v"

module rv32ima_soc_top(
    input wire rst_i,
    input wire clk_i
);
    wire[`InstAddrBus] rom_addr_rom;
    wire rom_ce_rom;
    wire[`InstBus] rom_data_rom;

    rv32IMACore rv32IMACore_0(
        .rst_i(rst_i),
        .clk_i(clk_i),
        .rom_data_i(rom_data_rom),

        .rom_addr_o(rom_addr_rom),
        .rom_ce_o(rom_ce_rom)
    );

    rom rom_0(
        .ce_i(rom_ce_rom),
        .inst_addr_i(rom_addr_rom),

        .inst_o(rom_data_rom)
    );
endmodule