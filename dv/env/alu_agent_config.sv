`ifndef alu_agent_config
`define alu_agent_config
class alu_agent_config extends uvm_object;
    `uvm_object_utils(alu_agent_config)
    virtual alu_interface alu_vif;
    uvm_active_passive_enum active = UVM_ACTIVE;
    function new(string name = "alu_agent_config");
        super.new(name);
    endfunction
endclass
`endif
