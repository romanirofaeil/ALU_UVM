module ALU_tb;
    logic clk;
    logic rst_n;
    logic ALU_en;
    logic signed [0:4] A;
    logic signed [0:4] B;
    logic a_en;
    logic [0:2] a_op;
    logic b_en;
    logic [0:1] b_op;
    logic signed [0:5] C;
    logic C_en;
    alu_design alu(.*);
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    // initial begin
    //     rst_n = 0;
    //     #10 rst_n = 1;
    // end
    initial begin
        rst_n = 0;
        ALU_en = 0;
        A = 0;
        B = 0;
        a_en = 0;
        a_op = 0;
        b_en = 0;
        b_op = 0;
        C = 0;
        C_en = 0;
    end
    initial begin
        // #20;
        #5;
        rst_n = 1;
        ALU_en = 1;
        A = 5;
        B = 3;
        a_en = 0;
        a_op = 0;
        b_en = 1;
        b_op = 1;
        #10;
        A = 6;
        B = 4;
        #10;
        A = 7;
        B = 5;
        #10;
        ALU_en = 0;
        #10;
        ALU_en = 1;
        #10;
        A = 8;
        B = 6;
        #10;
        rst_n = 0;
        #10;
        rst_n = 1;
        #10;
        A = 9;
        B = 7;
        $display("C = %d", C);
        $display("C_en = %d", C_en);
        #100;
        $finish();
    end
    initial begin
        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, ALU_tb);
    end
endmodule
