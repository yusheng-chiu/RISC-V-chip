`include "define.v"

module bcu (
    input wire rst_i,
    input wire[`RegDataBus] op1_i,
    input wire[`RegDataBus] op2_i,
    input wire[`ALUOpBus] aluop_i,

    output reg branch_enable_o
);

always @(*) begin
    if (rst_i == `RstEnable) begin
        branch_enable_o <= `ZeroSignal;
    end else begin
        // $display("aluop_i: ", aluop_i);
        case (aluop_i)
            `BEQ_alu:begin
                if (op1_i == op2_i)begin
                    branch_enable_o <= `OneSignal;
                end else begin
                    branch_enable_o <= `ZeroSignal;
                end
            end
            `BNE_alu:begin
                if (op1_i != op2_i)begin
                    branch_enable_o <= `OneSignal;
                end else begin
                    branch_enable_o <= `ZeroSignal;
                end
            end
            `BLT_alu:begin
                if ($signed(op1_i) < $signed(op2_i))begin
                    branch_enable_o <= `OneSignal;
                end else begin
                    branch_enable_o <= `ZeroSignal;
                end
            end
            `BGE_alu:begin
                if ($signed(op1_i) >= $signed(op2_i))begin
                    branch_enable_o <= `OneSignal;
                end else begin
                    branch_enable_o <= `ZeroSignal;
                end
            end
            `BLTU_alu:begin
                if (op1_i < op2_i)begin
                    branch_enable_o <= `OneSignal;
                end else begin
                    branch_enable_o <= `ZeroSignal;
                end
            end
            `BGEU_alu:begin
                if (op1_i >= op2_i)begin
                    branch_enable_o <= `OneSignal;
                end else begin
                    branch_enable_o <= `ZeroSignal;
                end
            end
            default:begin
                branch_enable_o <= `ZeroSignal;
            end
        endcase
    end
end
endmodule