class alu_monitor extends uvm_monitor;
    `uvm_component_utils(alu_monitor)
    virtual alu_interface alu_vif;
    uvm_analysis_port #(alu_sequence_item) in_mon_analysis_port;
    uvm_analysis_port #(alu_sequence_item) out_mon_analysis_port;
    alu_sequence_item alu_seq_items[$];
    function new(string name = "alu_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
    extern virtual task input_monitoring();
    extern virtual task output_monitoring();
endclass

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    in_mon_analysis_port = new("in_mon_analysis_port", this);
    out_mon_analysis_port = new("out_mon_analysis_port", this);
endfunction
virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fork
        input_monitoring();
        output_monitoring();
    join
endtask
virtual task input_monitoring();
    alu_sequence_item alu_seq_item;
    forever begin
        @(posedge alu_vif.clk)
            if(alu_vif.ALU_en) begin
                alu_seq_item = alu_sequence_item::type_id::create("alu_seq_item");
                alu_seq_item.ALU_en = alu_vif.ALU_en;
                alu_seq_item.A = alu_vif.A;
                alu_seq_item.B = alu_vif.B;
                alu_seq_item.a_en = alu_vif.a_en;
                alu_seq_item.a_op = alu_vif.a_op;
                alu_seq_item.b_en = alu_vif.b_en;
                alu_seq_item.b_op = alu_vif.b_op;
                in_mon_analysis_port.write(alu_seq_item);
                alu_seq_items.push_back(alu_seq_item);
            end
    end
endtask
virtual task output_monitoring();
    alu_sequence_item alu_seq_item;
    forever begin
        @(posedge alu_vif.clk)
            if(alu_vif.C_en) begin
                if(alu_seq_items.size() == 0)
                    `uvm_fatal(get_type_name(), "Received Output Item Without Sending Any Input Items!")
                alu_seq_item = alu_seq_items.pop_front();
                alu_seq_item.C_en = alu_vif.C_en;
                alu_seq_item.C = alu_vif.C;
                out_mon_analysis_port.write(alu_seq_item);
            end
    end
endtask
