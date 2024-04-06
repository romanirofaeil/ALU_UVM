module alu_design(
    input clk,
    input rst_n,
    input ALU_en,
    input signed [0:4] A,
    input signed [0:4] B,
    input a_en,
    input [0:2] a_op,
    input b_en,
    input [0:1] b_op,
    output reg C_en,
    output reg signed [0:5] C
    );
    reg C_en_tmp;
    reg signed [0:5] C_tmp;
    initial begin
        C_en_tmp = 0;
        C_tmp = 0;
    end
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            C_en_tmp <= 0;
            C_tmp <= 0;
        end
        else begin
            if(ALU_en) begin
                if(!a_en && !b_en) begin
                    C_tmp <= 0;
                    $display("No Operation Is Selected!");
                end
                else if(a_en && !b_en) begin
                    case(a_op)
                        0 : C_tmp <= A + B;
                        1 : C_tmp <= A - B;
                        2 : C_tmp <= A ^ B;
                        3 : C_tmp <= A & B;
                        4 : C_tmp <= A & B;
                        5 : C_tmp <= A | B;
                        6 : C_tmp <= A ^~ B;
                        7: begin C_tmp <= 0; $display("Invalid Operation Number 7!"); end
                    endcase
                end
                else if(!a_en && b_en) begin
                    case(b_op)
                        0 : C_tmp <= ~(A & B);
                        1 : C_tmp <= A + B;
                        2 : C_tmp <= A + B;
                        3: begin C_tmp <= 0; $display("Invalid Operation Number 3!"); end
                    endcase
                end
                else begin
                    case(b_op)
                        0 : C_tmp <= A ^ B;
                        1 : C_tmp <= A ^~ B;
                        2 : C_tmp <= A - 1;
                        3 : C_tmp <= B + 2;
                    endcase
                end
                C_en_tmp <= 1;
            end
            else begin
                C_en_tmp <= 0;
                C_tmp <= 0;
            end
        end
        C_en <= C_en_tmp;
        C <= C_tmp;
    end
endmodule
