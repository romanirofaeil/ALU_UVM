`ifndef alu_B_PLUS_2_sequence
`define alu_B_PLUS_2_sequence
class alu_B_PLUS_2_sequence extends alu_sequence;
    `uvm_object_utils(alu_B_PLUS_2_sequence)
    function new(string name = "alu_B_PLUS_2_sequence");
        super.new(name);
    endfunction
    virtual function bit get_randomize(alu_sequence_item alu_seq_item);
        return (alu_seq_item.randomize() with {a_en == 1 && b_en == 1 && b_op == 3;});
    endfunction
endclass
`endif
