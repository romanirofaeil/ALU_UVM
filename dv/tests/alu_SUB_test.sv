class alu_SUB_test extends alu_test;
    `uvm_component_utils(alu_SUB_test)
    function new(string name = "alu_SUB_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        alu_sequence::type_id::set_type_override(alu_SUB_sequence::get_type());
        super.build_phase(phase);
    endfunction
endclass
