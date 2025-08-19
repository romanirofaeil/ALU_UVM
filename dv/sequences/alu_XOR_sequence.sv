`ifndef alu_XOR_sequence
`define alu_XOR_sequence
class alu_XOR_sequence extends alu_sequence;
    `uvm_object_utils(alu_XOR_sequence)
    function new(string name = "alu_XOR_sequence");
        super.new(name);
    endfunction
    virtual function bit get_randomize(alu_sequence_item alu_seq_item);
        return (alu_seq_item.randomize() with {(a_en == 1 && b_en == 0 && a_op == 2) || (a_en == 1 && b_en == 1 && b_op == 0);});
    endfunction
endclass
`endif
