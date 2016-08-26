#!/bin/bash

set -ex

yosys -ql tracecmp.yslog \
        -p 'read_verilog -formal -norestrict -assume-asserts ../../picorv32.v' \
        -p 'read_verilog -formal tracecmp.v' \
	-p 'prep -top testbench -nordff' \
	-p 'write_smt2 -mem -bv -wires tracecmp.smt2'

yosys-smtbmc -s yices --smtc tracecmp.smtc --dump-vcd tracecmp.vcd tracecmp.smt2

