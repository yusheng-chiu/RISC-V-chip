`include "define.v"
`timescale 1ns/1ps

module rv32ima_soc_top_tb();
    reg CLOCK_50;
    reg rst;

    initial begin
        CLOCK_50 = 1'b0;
        forever #10 CLOCK_50 = ~CLOCK_50;
    end

    initial begin
        $readmemb("inst_rom3.data", rv32ima_soc_top_0.rom_0.inst_mem);
    end

    initial begin
        $dumpfile("rv32ima_soc_top_tb.vcd");
        $dumpvars(0, rv32ima_soc_top_tb);
        rst = `RstEnable;
        #195 rst = `RstDisable;
        #950 rst = `RstEnable;
        #1000 $stop;
    end

    rv32ima_soc_top rv32ima_soc_top_0(
        .rst_i(rst),
        .clk_i(CLOCK_50)
    );
endmodule