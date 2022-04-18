module register_file(
    input wire rst_i,
    input wire clk_i,

    // for write back
    input wire[`RegAddrBus] w_addr_i,
    input wire[`RegDataBus] w_data_i,
    input wire wb_RegWrite_i, //RegWrite

    // the address of target registers
    input wire reg_read1_e_i,
    input wire reg_read2_e_i,
    input wire[`RegAddrBus] reg_addr_1_i,
    input wire[`RegAddrBus] reg_addr_2_i,
    //---------output---------
    output reg[`RegDataBus] reg_data_1_o,
    output reg[`RegDataBus] reg_data_2_o
);
    reg[`RegDataBus] regs[`RegNum-1:0];

    integer i;
    initial begin
        for (i = 0; i < `RegNum; i = i+1)
            regs[i] <= 0;
    end

    //for write back stage
    always @(posedge clk_i) begin //Wanna write to regfile from WB
        if (rst_i == `RstDisable) begin
            if ((wb_RegWrite_i == `WriteEnable) && (w_addr_i != `ZeroReg)) begin
                regs[w_addr_i] <= w_data_i;
            end else begin
                // do nothing when wb_addr_i == 0 or wb_RegWrite_i == False
            end
        end else begin
            // regs[w_addr_i] <= `ZeroInst or do nothing!!
        end
    end

    //for reading register1
    always @(*) begin
        if (reg_addr_1_i == `ZeroReg) begin
            reg_data_1_o <= regs[`ZeroReg];
        end else begin //for ID-WB data hazard
            if ((reg_addr_1_i == w_addr_i) && (wb_RegWrite_i == `WriteEnable) && (reg_read1_e_i == `ReadEnable)) begin
                reg_data_1_o <= w_data_i;
            end else begin
                reg_data_1_o <= regs[reg_addr_1_i];
            end
        end
    end
    //for reading register2
    always @(*) begin
        if (reg_addr_2_i == `ZeroReg) begin
            reg_data_2_o <= regs[`ZeroReg];
        end else begin //for ID-WB data hazard
            if ((reg_addr_2_i == w_addr_i) && (wb_RegWrite_i == `WriteEnable) && (reg_read2_e_i == `ReadEnable)) begin
                reg_data_2_o <= w_data_i;
            end else begin
                reg_data_2_o <= regs[reg_addr_2_i];
            end
        end
    end
endmodule