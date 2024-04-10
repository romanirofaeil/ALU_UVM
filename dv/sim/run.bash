#! /bin/bash

vcs -sverilog -ntb_opts uvm-1.2 ./alu_design.sv ./alu_testbench.sv
./simv +UVM_TIMEOUT=5000000 +UVM_TESTNAME=alu_test +UVM_VERBOSITY=UVM_LOW
urg -lca -dir simv.vdb -report full_report -format text
cd full_report
cat *.txt
