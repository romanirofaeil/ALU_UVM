`ifndef alu_ERROR_sequence
`define alu_ERROR_sequence
class alu_ERROR_sequence extends alu_sequence;
    `uvm_object_utils(alu_ERROR_sequence)
    function new(string name = "alu_ERROR_sequence");
        super.new(name);
    endfunction
    virtual function bit get_randomize(alu_sequence_item alu_seq_item);
        return (alu_seq_item.randomize() with {(a_en == 0 && b_en == 0) || (a_en == 1 && b_en == 0 && a_op == 7) || (a_en == 0 && b_en == 1 && b_op == 3);});
    endfunction
endclass
`endif
