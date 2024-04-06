class alu_sequence_config extends uvm_object;
    `uvm_object_utils(alu_sequence_config)
    rand int num_of_seq_items;
    constraint c_num_of_seq_items {soft num_of_seq_items inside {[1 : 50]};}
    function new(string name="alu_sequence_config");
        super.new(name);
    endfunction
endclass
