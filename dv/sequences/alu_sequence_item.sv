class alu_sequence_item extends uvm_sequence_item;
    rand logic ALU_en;
    rand logic signed [0:4] A;
    rand logic signed [0:4] B;
    rand logic a_en;
    rand logic [0:2] a_op;
    rand logic b_en;
    rand logic [0:1] b_op;
    logic C_en;
    logic signed [0:5] C;
    constraint c_ALU_en {ALU_en == 1;}
    constraint A_range {
        A dist {
            -15         :/ 2,
            [-14 : -1]  :/ 7,
            0           :/ 2,
            [1 : 14]    :/ 7,
            15          :/ 2
        };
    }
    constraint B_range {
        B dist {
            -15         :/ 2,
            [-14 : -1]  :/ 7,
            0           :/ 2,
            [1 : 14]    :/ 7,
            15          :/ 2
        };
    }
    constraint invalid_operation {
        soft !(
        (a_en == 0 && b_en == 0) || 
        (a_en == 1 && b_en == 0 && a_op == 7) || 
        (a_en == 0 && b_en == 1 && b_op == 3)
        );
    }
    `uvm_object_utils_begin(alu_sequence_item)
        `uvm_field_int(ALU_en, UVM_DEFAULT)
        `uvm_field_int(A, UVM_DEFAULT)
        `uvm_field_int(B, UVM_DEFAULT)
        `uvm_field_int(a_en, UVM_DEFAULT)
        `uvm_field_int(a_op, UVM_DEFAULT)
        `uvm_field_int(b_en, UVM_DEFAULT)
        `uvm_field_int(b_op, UVM_DEFAULT)
        `uvm_field_int(C_en, UVM_DEFAULT)
        `uvm_field_int(C, UVM_DEFAULT)
    `uvm_object_utils_end
    function new(string name = "alu_sequence_item");
        super.new(name);
    endfunction
endclass
