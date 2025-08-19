`ifndef alu_sequence_package
`define alu_sequence_package
package alu_sequence_package;
    import uvm_pkg::*;
    import alu_environment_package::*;
    `include "uvm_macros.svh"
    `include "alu_sequence_config.sv"
    `include "alu_sequence.sv"
    `include "alu_ADD_sequence.sv"
    `include "alu_SUB_sequence.sv"
    `include "alu_XOR_sequence.sv"
    `include "alu_AND_sequence.sv"
    `include "alu_OR_sequence.sv"
    `include "alu_XNOR_sequence.sv"
    `include "alu_NAND_sequence.sv"
    `include "alu_A_MINUS_1_sequence.sv"
    `include "alu_B_PLUS_2_sequence.sv"
    `include "alu_ERROR_sequence.sv"
endpackage
`endif
