`include "alu_interface.sv"
`include "alu_package.sv"
module tb_top;
    import uvm_pkg::*;
    logic clk;
    logic rst_n;
    time period;
    initial begin
        clk = 0;
        rst_n = 0;
        @(posedge clk);
            rst_n = 1;
    end
    initial begin
        period = 10;
    end
    always #(period/2) clk = ~clk;
    alu_interface alu_intf(clk, rst_n);
    alu_design alu_dut(
        .clk(clk),
        .rst_n(rst_n),
        .ALU_en(alu_intf.ALU_en),
        .A(alu_intf.A),
        .B(alu_intf.B),
        .a_en(alu_intf.a_en),
        .a_op(alu_intf.a_op),
        .b_en(alu_intf.b_en),
        .b_op(alu_intf.b_op),
        .C_en(alu_intf.C_en),
        .C(alu_intf.C)
    );
    initial begin
        uvm_config_db#(virtual alu_interface)::set(null, "", "alu_intf", alu_intf);
        run_test();
    end
    initial begin
        $dumpfile("tb_top.vcd");
        $dumpvars();
    end
endmodule
