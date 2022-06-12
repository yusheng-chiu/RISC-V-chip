`include "define.v"

module exe(
    input rst_i,
    //from ID/EXE
    input wire[`RegDataBus] reg_data_1_i,
    input wire[`RegDataBus] reg_data_2_i,
    input wire[`RegAddrBus] shamt_exe_i,

    //for forwarding
    input wire[1:0] forwarding_rs1_i,
    input wire[1:0] forwarding_rs2_i,
    input wire[`RegDataBus] exe_mem_data_i,
    input wire[`RegDataBus] mem_wb_data_i,
    //------------------------
    input wire[`ALUOpBus] ALUOp_i,
    input wire ALUSrc_i, //EXE
    input wire[`InstAddrBus] pc_i, //for branch
    input wire[`RegDataBus] R_imm_i, //imm
    input wire[`RegDataBus] S_imm_i,
    input wire[`RegDataBus] B_imm_i,
    input wire[`InstAddrBus] branch_addr_i,
    input wire[`InstAddrBus] jump_addr_i,
    input wire jump_enable_i_exe,
    //---------output---------
    output reg[`InstAddrBus] pc_o,
    output reg[`RegDataBus] w_data_o,
    output reg[`InstAddrBus] branch_addr_o,
    output reg[`InstAddrBus] jump_addr_o,
    output wire branch_enable_o_exe,
    output reg jump_enable_o_exe
);

    reg[`RegDataBus] op1;
    reg[`RegDataBus] op2;

    reg op1_ge_op2_signed;

    // assign reg_data1_w = reg_data_1_i;
    // assign reg_data2_w = reg_data_2_i;  

    always@(*) begin        //pass the signals to the next stage.
        if (rst_i == `RstEnable) begin
            pc_o <= `CpuResetAddr;
            branch_addr_o <= `ZeroInstAddr;
            jump_addr_o <= `ZeroInstAddr;
            jump_enable_o_exe <= `ZeroInstAddr;
        end else begin
            pc_o <= pc_i;
            branch_addr_o <= branch_addr_i;
            jump_enable_o_exe <= jump_enable_i_exe;
            if (jump_addr_i == `ZeroInstAddr) begin
                jump_addr_o <= op1 + R_imm_i;
            end else begin
                jump_addr_o <= jump_addr_i;
            end
        end
    end

    always @(*) begin
        if (ALUSrc_i == `Imm) begin     //先判斷是不是immediate value接著再判斷有沒有forwarding
            op2 <= R_imm_i;
        end else begin
            case(forwarding_rs2_i)
                2'b00: op2 <= reg_data_2_i;
                2'b01: op2 <= exe_mem_data_i;
                2'b10: op2 <= mem_wb_data_i;
                default: op2 <= `RegZeroData;
            endcase
        end
    end
    
    //因為要經過一個clock cycle算出來的值才會寫入EXE/MEM pipe register所以我覺得這樣寫是可以的，應該不會發生執行順序的問題

    always @(*) begin
        case(forwarding_rs1_i)
            2'b00: op1 <= reg_data_1_i;
            2'b01: op1 <= exe_mem_data_i;
            2'b10: op1 <= mem_wb_data_i;
            default: op1 <= `RegZeroData;
        endcase
    end
    
    always @(*) begin   //ALU operation
        if (rst_i == `RstEnable) begin
            w_data_o <= `RegZeroData;
        end else begin
            case(ALUOp_i)   //Only focus on operation
                    `OR_alu:begin
                        w_data_o <= op1 | op2;
                    end
                    `AND_alu:begin
                        w_data_o <= op1 & op2;
                    end
                    `ADD_alu:begin
                        w_data_o <= op1 + op2;
                    end
                    `SUB_alu:begin
                        w_data_o <= op1 - op2;
                    end
                    `SLT_alu:begin
                        op1_ge_op2_signed <= ($signed(op1) >= $signed(op2));
                        w_data_o <= {32{(~op1_ge_op2_signed)}} & 32'h1;
                    end
                    `SLTU_alu:begin
                        op1_ge_op2_signed <= (op1 >= op2);
                        w_data_o <= {32{(~op1_ge_op2_signed)}} & 32'h1;
                    end
                    `XOR_alu:begin
                        w_data_o <= op1 ^ op2;
                    end
                    `SLL_alu:begin
                        w_data_o <= op1 << shamt_exe_i;
                    end
                    `SRL_alu:begin
                        w_data_o <= op1 >> shamt_exe_i;
                    end
                    `SRAL_alu:begin
                        w_data_o <= op1 >>> shamt_exe_i;
                    end
                    `JAL_alu:begin
                        w_data_o <= pc_o;
                    end
                    default:begin
                        w_data_o <= `RegZeroData;
                    end
            endcase
        end
    end

    bcu bcu0(
        .rst_i(rst_i),
        .op1_i(op1),
        .op2_i(op2),
        .aluop_i(ALUOp_i),

        .branch_enable_o(branch_enable_o_exe)
    );
endmodule