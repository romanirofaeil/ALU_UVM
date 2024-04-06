class alu_AND_sequence extends alu_sequence;
    `uvm_object_utils(alu_AND_sequence)
    function new(string name = "alu_AND_sequence");
        super.new(name);
    endfunction
    virtual function bit get_randomize(alu_sequence_item alu_seq_item);
        return (alu_seq_item.randomize() with {a_en == 1 && b_en == 0 && (a_op == 3 || a_op == 4);});
    endfunction
endclass
