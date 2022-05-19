`include "rtl/core/define.v"
module multiplier(
    input wire rst_i,
    input wire clk_i,

    input wire[31:0] multiplicand,
    input wire[31:0] multiplier,

    output reg[63:0] product
);
    integer i;
    initial begin
        i = 0;
    end

    always @(negedge rst_i) begin
        product[31:0] <= multiplier;
        i = 0;
    end

    always @(posedge clk_i) begin
        if (rst_i == 1'b1) begin
            product <= 64'b0;
        end else begin
            if (i < 32) begin
                if (product[0]) begin
                    product[63:32] = product[63:32] + multiplicand;
                end else begin 
                end
                product <= product >> 1;
                i = i + 1;
            end else begin
            end
        end
    end
endmodule


