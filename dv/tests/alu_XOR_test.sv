`ifndef alu_XOR_test
`define alu_XOR_test
class alu_XOR_test extends alu_test;
    `uvm_component_utils(alu_XOR_test)
    function new(string name = "alu_XOR_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        alu_sequence::type_id::set_type_override(alu_XOR_sequence::get_type());
        super.build_phase(phase);
    endfunction
endclass
`endif
