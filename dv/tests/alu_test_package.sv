`ifndef alu_test_package
`define alu_test_package
package alu_test_package;
    import uvm_pkg::*;
    import alu_environment_package::*;
    import alu_sequence_package::*;
    `include "uvm_macros.svh"
    `include "alu_test.sv"
    `include "alu_ADD_test.sv"
    `include "alu_SUB_test.sv"
    `include "alu_XOR_test.sv"
    `include "alu_AND_test.sv"
    `include "alu_OR_test.sv"
    `include "alu_XNOR_test.sv"
    `include "alu_NAND_test.sv"
    `include "alu_A_MINUS_1_test.sv"
    `include "alu_B_PLUS_2_test.sv"
    `include "alu_ERROR_test.sv"
endpackage
`endif
