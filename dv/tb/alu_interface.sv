`ifndef alu_interface
`define alu_interface
interface alu_interface(input logic clk, rst_n);
    logic ALU_en;
    logic signed [0:4] A;
    logic signed [0:4] B;
    logic a_en;
    logic [0:2] a_op;
    logic b_en;
    logic [0:1] b_op;
    logic C_en;
    logic signed [0:5] C;
    property ALU_Enable;
        @(posedge clk)
            !ALU_en |-> !C_en and !C;
    endproperty
    check_ALU_Enable : assert property(ALU_Enable);
    cover_ALU_Enable : cover property(ALU_Enable);
    property reset;
        @(posedge rst_n)
            !rst_n |-> !C_en && !C;
    endproperty
    check_reset : assert property(reset);
    cover_reset : cover property(reset);
endinterface
`endif
