import sys
import filecmp
import subprocess
import sys
import os


rtl_dir = sys.argv[1]
print(rtl_dir)

tb_file = r'/tb/rv32ima_soc_tb.v'

    # iverilog
iverilog_cmd = ['iverilog']
    
    
iverilog_cmd += ['-o', r'out.vvp']
    # include (defines.v) path
iverilog_cmd += ['-I', rtl_dir + r'/rtl/core']
    # define document
iverilog_cmd += ['-D', r'OUTPUT="signature.output"']
    # testbench file
iverilog_cmd.append(rtl_dir + tb_file)
    # ../rtl/core
iverilog_cmd.append(rtl_dir + r'/rtl/core/defines.v')
iverilog_cmd.append(rtl_dir + r'/rtl/core/pc.v')
iverilog_cmd.append(rtl_dir + r'/rtl/core/if_id.v')
iverilog_cmd.append(rtl_dir + r'/rtl/core/id.v')
iverilog_cmd.append(rtl_dir + r'/rtl/core/regfile.v')
iverilog_cmd.append(rtl_dir + r'/rtl/core/control.v')
iverilog_cmd.append(rtl_dir + r'/rtl/core/id_exe.v')
iverilog_cmd.append(rtl_dir + r'/rtl/core/exe.v')
iverilog_cmd.append(rtl_dir + r'/rtl/core/exe_mem.v')
iverilog_cmd.append(rtl_dir + r'/rtl/core/mem.v')
iverilog_cmd.append(rtl_dir + r'/rtl/core/mem_wb.v')
iverilog_cmd.append(rtl_dir + r'/rtl/core/wb.v')
iverilog_cmd.append(rtl_dir + r'/rtl/core/rv32IMACore.v')

print(iverilog_cmd)