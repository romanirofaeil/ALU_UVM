class alu_driver extends uvm_driver #(alu_sequence_item);
    `uvm_component_utils(alu_driver)
    virtual alu_interface alu_vif;
    function new(string name = "alu_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    virtual task run_phase(uvm_phase phase);
        alu_sequence_item req_item;
        super.run_phase(phase);
        forever begin
            `uvm_info(get_type_name(), "Getting next sequence item", UVM_HIGH)
            seq_item_port.get_next_item(req_item);
            `uvm_info(get_type_name(), {"Running sequence: ", req_item.get_name()}, UVM_HIGH)
            drive_item(req_item);
            seq_item_port.item_done();
        end
    endtask
    virtual task drive_item(alu_sequence_item req_item);
        @(posedge alu_vif.clk)
            alu_vif.ALU_en <= req_item.ALU_en;
            alu_vif.A <= req_item.A;
            alu_vif.B <= req_item.B;
            alu_vif.a_en <= req_item.a_en;
            alu_vif.a_op <= req_item.a_op;
            alu_vif.b_en <= req_item.b_en;
            alu_vif.b_op <= req_item.b_op;
        @(posedge alu_vif.clk)
            alu_vif.ALU_en <= 0;
    endtask
endclass
