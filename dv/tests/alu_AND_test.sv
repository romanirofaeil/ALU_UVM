class alu_AND_test extends alu_test;
    `uvm_component_utils(alu_AND_test)
    function new(string name = "alu_AND_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        alu_sequence::type_id::set_type_override(alu_AND_sequence::get_type());
        super.build_phase(phase);
    endfunction
endclass
