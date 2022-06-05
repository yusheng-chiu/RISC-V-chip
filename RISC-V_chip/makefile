VERILOG = iverilog
TARGET = rv32ima_soc_top.vcd

$(TARGET) : out.vvp
	vvp out.vvp

out.vvp: test_tb.v test.v
	$(VERILOG) -o test.vvp test_tb.v test.v

clean:
	rm $(TARGET)