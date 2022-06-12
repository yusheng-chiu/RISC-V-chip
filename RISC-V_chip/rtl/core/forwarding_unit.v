`include "define.v"
module forwarding_unit(
    input rst_i,
    input wire[`RegAddrBus] id_exe_rs1_i,
    input wire[`RegAddrBus] id_exe_rs2_i,
    input wire[`RegAddrBus] exe_mem_rd_i,
    input wire[`RegAddrBus] mem_wb_rd_i,

    output reg[1:0] forwarding_rs1_o,
    output reg[1:0] forwarding_rs2_o
);

always @(*) begin
    if (rst_i == `RstEnable) begin
        forwarding_rs1_o <= `NoForward;
        forwarding_rs2_o <= `NoForward;
    end else if((id_exe_rs1_i == `RegZeroAddr) || (id_exe_rs2_i == `RegZeroAddr))begin
            forwarding_rs1_o <= `NoForward;
            forwarding_rs2_o <= `NoForward;
        end else begin
            case (id_exe_rs1_i)   //Using case statement will be implemented by an n-1 multiplexer.
                exe_mem_rd_i: forwarding_rs1_o <= `ForwardingExe;
                mem_wb_rd_i: forwarding_rs1_o <= `ForwardingMem; 
                default: forwarding_rs1_o <= `NoForward;
            endcase
            // if (id_exe_rs1_i == exe_mem_rd_i) begin
            //     forwarding_rs1_o <= `ForwardingExe;
            // end else if (id_exe_rs1_i == mem_wb_rd_i) begin
            //     forwarding_rs1_o <= `ForwardingMem; 
            // end else begin
            //     forwarding_rs1_o <= `NoForward;
            // end

            // if (id_exe_rs2_i == exe_mem_rd_i) begin
            //     forwarding_rs2_o <= `ForwardingExe;
            // end else if (id_exe_rs2_i == mem_wb_rd_i) begin
            //     forwarding_rs2_o <= `ForwardingMem; 
            // end else begin
            //     forwarding_rs2_o <= `NoForward;
            // end
            case (id_exe_rs2_i)
                exe_mem_rd_i: forwarding_rs2_o <= `ForwardingExe;
                mem_wb_rd_i: forwarding_rs2_o <= `ForwardingMem; 
                default: forwarding_rs2_o <= `NoForward;
            endcase
        end 
end
endmodule