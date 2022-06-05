`include "define.v"

module rv32IMACore(
    input wire rst_i,
    input wire clk_i,
    input wire[`RegDataBus] rom_data_i,

    output wire[`InstAddrBus] rom_addr_o,
    output wire rom_ce_o
);
    //if to id
    wire[`InstAddrBus] pc_if;
    // wire rom_ce;
    // wire[`InstBus] inst_if;
    //ID----------------
    wire[`InstAddrBus] pc_id;
    wire[`InstBus] inst_id;
    //to register file
    wire[`RegAddrBus] rs1_id;
    wire[`RegAddrBus] rs2_id;
    wire reg_read1_e_id;
    wire reg_read2_e_id;
    //from control unit
    wire Branch_id;
    wire MemRead_id;
    wire MemtoReg_id;
    wire[`ALUOpBus] ALUOp_id;
    wire MemWrite_id;
    wire ALUSrc_id;
    wire RegWrite_id;
    //from ID
    wire[`RegAddrBus] shamt_id;
    wire[`RegDataBus] R_imm_o_id;
    wire[`RegAddrBus] reg_dest_o_id;
    wire[`RegDataBus] S_imm_o_id;
    wire[`RegDataBus] B_imm_o_id;
    wire[`RegDataBus] reg_data_1_id;
    wire[`RegDataBus] reg_data_2_id;
    //EXE----------------------
    wire[`InstAddrBus] pc_exe;
    //from control unit
    wire[`RegAddrBus] rs1_exe;
    wire[`RegAddrBus] rs2_exe;
    wire[`RegAddrBus] shamt_exe;
    wire Branch_exe;
    wire MemRead_exe;
    wire MemtoReg_exe;
    wire[`ALUOpBus] ALUOp_exe;
    wire MemWrite_exe;
    wire ALUSrc_exe;
    wire RegWrite_exe;
    //from ID
    wire[`RegDataBus] R_imm_o_exe;
    wire[`RegAddrBus] reg_dest_o_exe;
    wire[`RegDataBus] S_imm_o_exe;
    wire[`RegDataBus] B_imm_o_exe;
    //from register file
    wire[`RegDataBus] reg_data_1_exe;
    wire[`RegDataBus] reg_data_2_exe;

    wire[`RegDataBus] w_data_exe;
    wire[`InstAddrBus] pc_exe_mem;

    //MEM
    wire[`InstAddrBus] pc_mem;
    wire[`RegDataBus] w_data_mem;
    wire Branch_mem;
    wire MemRead_mem;
    wire MemtoReg_mem;
    wire MemWrite_mem;
    wire RegWrite_mem;
    wire[`RegAddrBus] rd_mem;

    wire[`RegDataBus] mem_data_o_mem;

    //MEM/WB
    wire[`RegDataBus] reg_data_o_wb;
    wire[`RegDataBus] mem_data_o_wb;
    wire MemtoReg_o_wb;
    wire RegWrite_o_wb;
    wire[`RegAddrBus] rd_o_wb;
    //WB
    wire[`RegDataBus] w_data_o_wb;

    pc pc_0(
        .rst_i(rst_i),
        .clk_i(clk_i),

        .pc_o(pc_if),   //output
        .ce_o(rom_ce_o)
    );
    assign rom_addr_o = pc_if;

    // rom rom_0(
    //     .inst_addr_i(pc_if),
    //     .ce_i(rom_ce),

    //     .inst(inst_if)  //output
    // );

    if_id if_id_0(
        .rst_i(rst_i),
        .clk_i(clk_i),
        .inst_i(rom_data_i),
        .inst_addr_i(pc_if),

        .inst_o(inst_id),   //output
        .inst_addr_o(pc_id)     //output
    );

    id id_0(
        .rst_i(rst_i),
        .inst_addr_i(pc_id),
        .inst_i(inst_id),
        //output to register file
        .rs1_o(rs1_id),             
        .rs2_o(rs2_id),
        .shamt_o(shamt_id),
        .reg_read1_e_o(reg_read1_e_id),
        .reg_read2_e_o(reg_read2_e_id),
        //output to id/exe
        .Branch_o(Branch_id),      
        .MemRead_o(MemRead_id),
        .MemtoReg_o(MemtoReg_id),
        .ALUOp_o(ALUOp_id),
        .MemWrite_o(MemWrite_id),
        .ALUSrc_o(ALUSrc_id),
        .RegWrite_o(RegWrite_id),

        .R_imm_o(R_imm_o_id),
        .reg_dest_o(reg_dest_o_id),
        .pc_o(pc_id),
        .S_imm_o(S_imm_o_id),
        .B_imm_o(B_imm_o_id)
    );

    register_file register_file_0(
        .rst_i(rst_i),
        .clk_i(clk_i),
        //input from WB
        .w_addr_i(rd_o_wb),
        .w_data_i(w_data_o_wb),
        .wb_RegWrite_i(RegWrite_o_wb),
        //input from ID
        .reg_read1_e_i(reg_read1_e_id),
        .reg_read2_e_i(reg_read2_e_id),
        .reg_addr_1_i(rs1_id),
        .reg_addr_2_i(rs2_id),
        //output to id/exe
        .reg_data_1_o(reg_data_1_id),   
        .reg_data_2_o(reg_data_2_id)
    );

    id_exe id_exe_0(
        .rst_i(rst_i),
        .clk_i(clk_i),
        //input----------
        .reg_data_1_i(reg_data_1_id),
        .reg_data_2_i(reg_data_2_id),
        .reg_addr_1_i(rs1_id),
        .reg_addr_2_i(rs2_id),
        .shamt_i(shamt_id),

        .Branch_i(Branch_id), 
        .MemRead_i(MemRead_id), //Mem LW
        .MemtoReg_i(MemtoReg_id), //WB
        .ALUOp_i(ALUOp_id),
        .MemWrite_i(MemWrite_id), //Mem SW
        .ALUSrc_i(ALUSrc_id), //EXE
        .RegWrite_i(RegWrite_id),
        .R_imm_i(R_imm_o_id), // imm
        .reg_dest_i(reg_dest_o_id), // rd
        .pc_i(pc_id), //for branch connected by inst_addr_i;
        .S_imm_i(S_imm_o_id),
        .B_imm_i(B_imm_o_id),
        //output---------
        .reg_data_1_o(reg_data_1_exe),
        .reg_data_2_o(reg_data_2_exe),
        .reg_addr_1_o(rs1_exe),
        .reg_addr_2_o(rs2_exe),
        .shamt_o(shamt_exe),

        .Branch_o(Branch_exe), 
        .MemRead_o(MemRead_exe), //Mem LW
        .MemtoReg_o(MemtoReg_exe), //WB
        .ALUOp_o(ALUOp_exe),
        .MemWrite_o(MemWrite_exe), //Mem SW
        .ALUSrc_o(ALUSrc_exe), //EXE
        .RegWrite_o(RegWrite_exe),
        .R_imm_o(R_imm_o_exe), // imm
        .reg_dest_o(reg_dest_o_exe), // rd
        .pc_o(pc_exe), //for branch connected by inst_addr_i;
        .S_imm_o(S_imm_o_exe),
        .B_imm_o(B_imm_o_exe)
    );

    wire[1:0] forwarding_rs1;
    wire[1:0] forwarding_rs2;

    forwarding_unit forwarding_unit_0(
        .rst_i(rst_i),
        .id_exe_rs1_i(rs1_exe),
        .id_exe_rs2_i(rs2_exe),
        .exe_mem_rd_i(rd_mem),
        .mem_wb_rd_i(rd_o_wb),

        .forwarding_rs1_o(forwarding_rs1),
        .forwarding_rs2_o(forwarding_rs2)
    );

    exe exe_0(
        .rst_i(rst_i),
        .reg_data_1_i(reg_data_1_exe),
        .reg_data_2_i(reg_data_2_exe),
        .shamt_exe_i(shamt_exe),

        .forwarding_rs1_i(forwarding_rs1),
        .forwarding_rs2_i(forwarding_rs2),
        .exe_mem_data_i(w_data_mem),
        .mem_wb_data_i(w_data_o_wb),

        .ALUOp_i(ALUOp_exe),
        .ALUSrc_i(ALUSrc_exe), //EXE
    
        .pc_i(pc_exe), //for branch
        .R_imm_i(R_imm_o_exe), //imm
        .S_imm_i(S_imm_o_exe),
        .B_imm_i(B_imm_o_exe),
        //output------------
        .pc_o(pc_exe_mem),
        .w_data_o(w_data_exe)
    );

    exe_mem exe_mem_0(
        .rst_i(rst_i),
        .clk_i(clk_i),

        .pc_i(pc_exe_mem),
        .w_data_i(w_data_exe),
        .Branch_i(Branch_exe),
        .MemRead_i(MemRead_exe),
        .MemtoReg_i(MemtoReg_exe),
        .MemWrite_i(MemWrite_exe),
        .RegWrite_i(RegWrite_exe),
        .rd_i(reg_dest_o_exe),
        //output-----------
        .pc_o(pc_mem),
        .w_data_o(w_data_mem),
        .Branch_o(Branch_mem),
        .MemRead_o(MemRead_mem),
        .MemtoReg_o(MemtoReg_mem),
        .MemWrite_o(MemWrite_mem),
        .RegWrite_o(RegWrite_mem),
        .rd_o(rd_mem)
    );

    mem mem_0(
        .rst_i(rst_i),

        .w_data_i(w_data_mem),      //SW or LW or WB
        .Branch_i(Branch_mem),
        .MemRead_i(MemRead_mem),
        .MemWrite_i(MemWrite_mem),

        .mem_data_o(mem_data_o_mem)
    );

    mem_wb mem_wb_0(
        .rst_i(rst_i),
        .clk_i(clk_i),

        .reg_data_i(w_data_mem),
        .mem_data_i(mem_data_o_mem),
        .MemtoReg_i(MemtoReg_mem),
        .RegWrite_i(RegWrite_mem),
        .rd_i(rd_mem),

        .reg_data_o(reg_data_o_wb),
        .mem_data_o(mem_data_o_wb),
        .MemtoReg_o(MemtoReg_o_wb),
        .RegWrite_o(RegWrite_o_wb),
        .rd_o(rd_o_wb)
    );

    wb wb_0(
        .rst_i(rst_i),

        .MemtoReg_i(MemtoReg_o_wb), 
        .reg_data_i(reg_data_o_wb), 
        .mem_data_i(mem_data_o_wb),
        //output
        .w_data_o(w_data_o_wb)
    );
endmodule