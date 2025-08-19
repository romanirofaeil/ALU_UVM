`ifndef alu_ADD_test
`define alu_ADD_test
class alu_ADD_test extends alu_test;
    `uvm_component_utils(alu_ADD_test)
    function new(string name = "alu_ADD_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        alu_sequence::type_id::set_type_override(alu_ADD_sequence::get_type());
        super.build_phase(phase);
    endfunction
endclass
`endif
