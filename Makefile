#Uncomment this line if you need to generate a vcd waveform of the simulation
SIM_ARGS ?= --vcd=sim.vcd

SIM=ghdl
TOPLEVEL_LANG=vhdl
GPI_IMPL=vhpi
GUI=1
COCOTB_ENABLE_PROFILING=true
SIM_BUILD=.

# Add VHDL source files here
VHDL_SOURCES += $(PWD)/estado_luchador.vhd


# TOPLEVEL entity in Verilog/VHDL
TOPLEVEL = estado_luchador
# MODULE is the name of the python test file
MODULE = game

include $(shell cocotb-config --makefiles)/Makefile.inc
include $(shell cocotb-config --makefiles)/Makefile.sim

# Cannot define target 'clean' here because it's already in the included
# Makefile, but we can define 'realclean'
.PHONY: realclean
realclean:
	make clean
	rm -f $(SIM_BUILD)/*.o
	rm -f $(SIM_BUILD)/vga_driver
	rm -f $(SIM_BUILD)/work-obj??.cf
	rm -rf __pycache__
