class alu_ERROR_test extends alu_test;
    `uvm_component_utils(alu_ERROR_test)
    function new(string name = "alu_ERROR_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        alu_sequence::type_id::set_type_override(alu_ERROR_sequence::get_type());
        super.build_phase(phase);
    endfunction
endclass
