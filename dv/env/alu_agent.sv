class alu_agent extends uvm_agent;
    `uvm_component_utils(alu_agent)
    alu_driver alu_drv;
    alu_monitor alu_mon;
    alu_sequencer alu_seqr;
    alu_agent_config alu_agnt_cfg;
    uvm_analysis_port #(alu_sequence_item) in_agnt_analysis_port;
    uvm_analysis_port #(alu_sequence_item) out_agnt_analysis_port;
    function new(string name = "alu_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(alu_agent_config)::get(this, "", "alu_agent_config", alu_agnt_cfg))
            `uvm_fatal(get_type_name(), "agent config not found")
        if(alu_agnt_cfg.active == UVM_ACTIVE) begin
            alu_seqr = alu_sequencer::type_id::create("alu_seqr", this);
            alu_drv = alu_driver::type_id::create("alu_drv", this);
        end
        alu_mon = alu_monitor::type_id::create("alu_mon", this);
        in_agnt_analysis_port = new("in_agnt_analysis_port", this);
        out_agnt_analysis_port = new("out_agnt_analysis_port", this);
    endfunction
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(alu_agnt_cfg.active == UVM_ACTIVE) begin
            alu_drv.seq_item_port.connect(alu_seqr.seq_item_export);
            alu_drv.alu_vif = alu_agnt_cfg.alu_vif;
        end
        alu_mon.in_mon_analysis_port.connect(this.in_agnt_analysis_port);
        alu_mon.out_mon_analysis_port.connect(this.out_agnt_analysis_port);
        alu_mon.alu_vif = alu_agnt_cfg.alu_vif;
    endfunction
endclass
