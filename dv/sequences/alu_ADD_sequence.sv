class alu_ADD_sequence extends alu_sequence;
    `uvm_object_utils(alu_ADD_sequence)
    function new(string name = "alu_ADD_sequence");
        super.new(name);
    endfunction
    virtual function bit get_randomize(alu_sequence_item alu_seq_item);
        return (alu_seq_item.randomize() with {(a_en == 1 && b_en == 0 && a_op == 0) || (a_en == 0 && b_en == 1 && (b_op == 1 || b_op == 2));});
    endfunction
endclass
