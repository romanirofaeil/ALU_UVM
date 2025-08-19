`ifndef alu_environment_package
`define alu_environment_package
package alu_environment_package;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "alu_sequence_item.sv"
    `include "alu_sequencer.sv"
    `include "alu_agent_config.sv"
    `include "alu_driver.sv"
    `include "alu_monitor.sv"
    `include "alu_agent.sv"
    `include "alu_scoreboard.sv"
    `include "alu_functional_coverage.sv"
    `include "alu_environment.sv"
endpackage
`endif
