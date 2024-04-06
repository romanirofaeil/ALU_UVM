class alu_SUB_sequence extends alu_sequence;
    `uvm_object_utils(alu_SUB_sequence)
    function new(string name = "alu_SUB_sequence");
        super.new(name);
    endfunction
    virtual function bit get_randomize(alu_sequence_item alu_seq_item);
        return (alu_seq_item.randomize() with {a_en == 1 && b_en == 0 && a_op == 1;});
    endfunction
endclass
