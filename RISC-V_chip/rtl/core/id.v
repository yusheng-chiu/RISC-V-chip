`include "define.v"

module id(
    input wire rst_i,   //Inputs of ID stage
    input wire clk_i,
    input wire[`InstAddrBus] inst_addr_i, //pc_i
    input wire[`InstBus] inst_i,
    //---------output---------
    //to register file
    output reg[`RegAddrBus] rs1_o,
    output reg[`RegAddrBus] rs2_o,
    output reg[`RegAddrBus] shamt_o,
    output wire reg_read1_e_o, //to regfile!!!
    output wire reg_read2_e_o,
    //from control unit
    output wire Branch_o, 
    output wire MemRead_o, //Mem LW
    output wire MemtoReg_o, //WB
    output wire[`ALUOpBus] ALUOp_o,
    output wire MemWrite_o, //Mem SW
    output wire ALUSrc_o, //EXE
    output wire RegWrite_o, //WB
    //to ID/EXE
    output reg[`RegDataBus] R_imm_o, // imm
    output reg[`RegAddrBus] reg_dest_o, // rd
    output reg[`InstAddrBus] pc_o, //for branch
    output reg[`RegDataBus] S_imm_o,
    output reg[`RegDataBus] B_imm_o,
    output reg[`RegDataBus] J_imm_o,
    output reg[`InstAddrBus] branch_addr_o,
    output reg[`InstAddrBus] jump_addr_o,
    output reg jump_enable_o
);

// control unit input
wire[`OpcodeBus] opcode = inst_i[6:0];//from inst[6:0]
wire[`Funct3Bus] funct3 = inst_i[14:12];//from inst[14:12]
wire[`Funct7Bus] funct7 = inst_i[31:25];//R-type
// to regfile (rs1 * rs2) and ID/EXE stage (imm, imm_for_s, rd)
wire[4:0] rd = inst_i[11:7];
wire[4:0] rs1 = inst_i[19:15];
wire[4:0] rs2 = inst_i[24:20];
wire[4:0] shamt = inst_i[24:20];
wire[`RegDataBus] imm = {{20{inst_i[31]}}, inst_i[31:20]};
wire[`RegDataBus] imm_for_s = {{20{inst_i[31]}}, {inst_i[30:25]}, {inst_i[11:7]}};
wire[`RegDataBus] imm_b = {{20{inst_i[31]}}, {inst_i[7]}, {inst_i[30:25]}, {inst_i[11:8]}, {1'b0}};
wire[`RegDataBus] imm_jal = {{12{inst_i[31]}}, {inst_i[19:12]}, {inst_i[20]}, {inst_i[30:25]}, {inst_i[24:21]}, {1'b0}};
//{{12{inst_i[31]}}, {inst_i[19:12]}, {inst_i[20]}, {inst_i[30:25]}, {inst_i[24:21]}, {1'b0}}

always @(*) begin
    if (rst_i == `RstEnable) begin
        R_imm_o <= `RegZeroData;
        rs1_o <= `RegZeroAddr;
        rs2_o <= `RegZeroAddr;
        shamt_o <= 5'b00000; //5'b0
        reg_dest_o <= `RegZeroAddr;
        pc_o <= `ZeroInstAddr;
        S_imm_o <= `RegZeroData;
        B_imm_o <= `RegZeroData;
        J_imm_o <= `RegZeroData;
        branch_addr_o <= `ZeroInstAddr;
        jump_addr_o <= `ZeroInstAddr;
        jump_enable_o <= `ZeroInstAddr;
    end else begin
        R_imm_o <= imm;
        rs1_o <= rs1;
        rs2_o <= rs2;
        shamt_o <= shamt;
        reg_dest_o <= rd;
        pc_o <= inst_addr_i;
        S_imm_o <= imm_for_s;
        B_imm_o <= imm_b;
        J_imm_o <= imm_jal;
        branch_addr_o <= inst_addr_i + (imm_b << 2);
        case (opcode)
            `Inst_JAL:begin
                jump_addr_o <= inst_addr_i + imm_jal - 4'b0100;
                jump_enable_o <= `OneSignal;
            end
            `Inst_JALR:begin
                jump_addr_o <= `ZeroInstAddr;
                jump_enable_o <= `OneSignal;
            end
            default:begin
                jump_addr_o <= `ZeroInstAddr;
                jump_enable_o <= `ZeroSignal;
            end
        endcase
    end
end

// always @(posedge clk_i) begin
//     if (rst_i == `RstEnable)begin
//         branch_addr_o <= `ZeroInstAddr;
//     end else begin
//         branch_addr_o <= inst_addr_i + (imm_b << 2);
//     end
// end

control control_0(
    //input signal to control unit
    .rst_i(rst_i),
    .opcode_i(opcode),
    .funct3_i(funct3),
    .funct7_i(funct7),
    //output from control unit
    .Branch_o(Branch_o), 
    .MemRead_o(MemRead_o), //Mem LW
    .MemtoReg_o(MemRead_o), //WB
    .ALUOp_o(ALUOp_o),
    .MemWrite_o(MemWrite_o), //Mem SW
    .ALUSrc_o(ALUSrc_o), //EXE
    .RegWrite_o(RegWrite_o),
    .reg_read1_e_o(reg_read1_e_o),
    .reg_read2_e_o(reg_read2_e_o)
);
endmodule