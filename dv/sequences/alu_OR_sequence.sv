`ifndef alu_OR_sequence
`define alu_OR_sequence
class alu_OR_sequence extends alu_sequence;
    `uvm_object_utils(alu_OR_sequence)
    function new(string name = "alu_OR_sequence");
        super.new(name);
    endfunction
    virtual function bit get_randomize(alu_sequence_item alu_seq_item);
        return (alu_seq_item.randomize() with {a_en == 1 && b_en == 0 && a_op == 5;});
    endfunction
endclass
`endif
