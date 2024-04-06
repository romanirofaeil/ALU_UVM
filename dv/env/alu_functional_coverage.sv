class alu_functional_coverage extends uvm_subscriber#(alu_sequence_item);
    `uvm_component_utils(alu_functional_coverage)
    alu_sequence_item alu_seq_item;
    covergroup in_cvgr;
        A : coverpoint alu_seq_item.A{
            illegal_bins A_out_of_range = {-16}; //! not allowed input where it's out of range as specified in the spec sheet.
            bins A_min = {-15};
            bins A_lower_mid = {[-14 : -1]};
            bins A_mid = {0};
            bins A_upper_mid = {[1 : 14]};
            bins A_max = {15};
        }
        B : coverpoint alu_seq_item.B{
            illegal_bins B_out_of_range = {-16}; //! not allowed input where it's out of range as specified in the spec sheet.
            bins B_min = {-15};
            bins B_lower_mid = {[-14 : -1]};
            bins B_mid = {0};
            bins B_upper_mid = {[1 : 14]};
            bins B_max = {15};
        }
        Operands : cross A, B;
        a_en : coverpoint alu_seq_item.a_en{
            bins low = {0};
            bins high = {1};
        }
        a_op : coverpoint alu_seq_item.a_op{
            bins a_op_0 = {0};
            bins a_op_1 = {1};
            bins a_op_2 = {2};
            bins a_op_3 = {3};
            bins a_op_4 = {4};
            bins a_op_5 = {5};
            bins a_op_6 = {6};
            bins a_op_7 = {7};
        }
        b_en : coverpoint alu_seq_item.b_en{
            bins low = {0};
            bins high = {1};
        }
        b_op : coverpoint alu_seq_item.b_op{
            bins b_op_0 = {0};
            bins b_op_1 = {1};
            bins b_op_2 = {2};
            bins b_op_3 = {3};
        }
        Operation : cross a_en, a_op, b_en, b_op{
            bins ADD = (binsof(a_en.high) && binsof(b_en.low) && binsof(a_op.a_op_0)) || (binsof(a_en.low) && binsof(b_en.high) && (binsof(b_op.b_op_1) || binsof(b_op.b_op_2)));
            bins SUB = binsof(a_en.high) && binsof(b_en.low) && binsof(a_op.a_op_1);
            bins XOR = (binsof(a_en.high) && binsof(b_en.low) && binsof(a_op.a_op_2)) || (binsof(a_en.high) && binsof(b_en.high) && binsof(b_op.b_op_0));
            bins AND = binsof(a_en.high) && binsof(b_en.low) && (binsof(a_op.a_op_3) || binsof(a_op.a_op_4));
            bins OR = binsof(a_en.high) && binsof(b_en.low) && binsof(a_op.a_op_5);
            bins XNOR = (binsof(a_en.high) && binsof(b_en.low) && binsof(a_op.a_op_6)) || (binsof(a_en.high) && binsof(b_en.high) && binsof(b_op.b_op_1));
            bins NAND = binsof(a_en.low) && binsof(b_en.high) && binsof(b_op.b_op_0);
            bins A_MINUS_1 = binsof(a_en.high) && binsof(b_en.high) && binsof(b_op.b_op_2);
            bins B_PLUS_2 = binsof(a_en.high) && binsof(b_en.high) && binsof(b_op.b_op_3);
            ignore_bins NULL = (binsof(a_en.low) && binsof(b_en.low)) || (binsof(a_en.high) && binsof(b_en.low) && binsof(a_op.a_op_7)) || (binsof(a_en.low) && binsof(b_en.high) && binsof(b_op.b_op_3)); //! not allowed selection where the system not permitted to take this value as specified in the spec sheet.
        }
        Specs : cross Operands, Operation;
    endgroup
    covergroup out_cvgr;
        C : coverpoint alu_seq_item.C{
            illegal_bins C_out_of_range = {-32}; //! not allowed output where it's out of range as specified in the spec sheet.
            ignore_bins C_min = {-31}; //? not possible where there is no operation will make the output reach its minimum value.
            bins C_lower_mid = {[-30 : -1]};
            bins C_mid = {0};
            bins C_upper_mid = {[1 : 30]};
            ignore_bins C_max = {31}; //? not possible where there is no operation will make the output reach its maximum value.
        }
    endgroup
    function new(string name = "alu_functional_coverage", uvm_component parent = null);
        super.new(name, parent);
        in_cvgr = new();
        out_cvgr = new();
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    virtual function void write(T t);
        $cast(alu_seq_item, t);
        in_cvgr.sample();
        out_cvgr.sample();
    endfunction
endclass
