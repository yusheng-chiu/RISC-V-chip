`include "rtl/core/define.v"
`timescale 1ns/1ps

module multiplier_tb ();
    reg rst_i_tb;
    reg CLOCK_50;
    reg [31:0] multiplicand_tb;
    reg [31:0] multiplier_tb;
    
    wire [63:0] product_tb;

    initial begin
        CLOCK_50 = 1'b0;
        forever #10 CLOCK_50 = ~CLOCK_50;
    end

    initial begin
        $dumpfile("multiplier.vcd");
        $dumpvars(0, multiplier_tb);
        multiplicand_tb = 32'b1001;
        multiplier_tb = 32'b0011;
        rst_i_tb = 1'b1;
        #40 rst_i_tb = 1'b0;
        $display("multiplier: %b", multiplier_0.multiplier);
        $display("multiplicand: %b", multiplier_0.multiplicand);
        #680 $display("product_result: %b\n", product_tb);
        multiplicand_tb = 32'b00011011;
        multiplier_tb = 32'b01011011;
        rst_i_tb = 1'b1;
        #40 rst_i_tb = 1'b0;
        $display("multiplier: %b", multiplier_0.multiplier);
        $display("multiplicand: %b", multiplier_0.multiplicand);
        #680 $display("product_result-2: %b\n", product_tb);
        #40 rst_i_tb = 1'b1;

        #2000 $finish;
    end

    multiplier multiplier_0(
        .rst_i(rst_i_tb),
        .clk_i(CLOCK_50),

        .multiplicand(multiplicand_tb),
        .multiplier(multiplier_tb),

        .product(product_tb)
    );
endmodule