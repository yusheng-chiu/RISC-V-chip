`include "define.v"

module hazard_detection_unit (
      input wire rst_i,
      input wire branch_enable_i,

      output reg flush_enable_o
);

always @(*) begin
    if (rst_i == `RstEnable) begin
        flush_enable_o <= `ZeroSignal;
    end else if (branch_enable_i == `OneSignal) begin
        flush_enable_o <= `OneSignal;
    end else begin
        flush_enable_o <= `ZeroSignal;
    end
end
endmodule