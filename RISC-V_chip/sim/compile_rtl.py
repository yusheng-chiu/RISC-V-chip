# -*- coding:utf-8 -*-
import sys
import filecmp
import subprocess
import sys
import os

def main():
    rtl_dir = sys.argv[1]

    tb_file = r'/tb/rv32ima_soc_top_tb.v'

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
    iverilog_cmd.append(rtl_dir + r'/rtl/core/define.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/pc.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/if_id.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/id.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/register_file.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/control.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/forwarding_unit.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/id_exe.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/bcu.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/exe.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/hazard_detection_unit.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/exe_mem.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/mem.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/mem_wb.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/wb.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/rv32IMACore.v')
    # ../rtl/perips
    iverilog_cmd.append(rtl_dir + r'/rtl/perips/rom.v')
    #iverilog_cmd.append(rtl_dir + r'/rtl/perips/ram.v')
    #iverilog_cmd.append(rtl_dir + r'/rtl/perips/timer.v')
    #iverilog_cmd.append(rtl_dir + r'/rtl/perips/gpio.v')
    # ../rtl/soc
    iverilog_cmd.append(rtl_dir + r'/rtl/soc/rv32ima_soc_top.v')

    
    # iverilog compile
    process = subprocess.Popen(iverilog_cmd)
    process.wait(timeout=5)

if __name__ == '__main__':
    sys.exit(main())