class alu_environment extends uvm_env;
    `uvm_component_utils(alu_environment)
    alu_agent_config alu_agnt_cfg;
    alu_agent alu_agnt;
    alu_scoreboard alu_scbd;
    alu_functional_coverage alu_func_cov;
    function new(string name = "alu_environment", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
endclass

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    alu_agnt_cfg = alu_agent_config::type_id::create("alu_agnt_cfg");
    alu_agnt = alu_agent::type_id::create("alu_agnt", this);
    alu_scbd = alu_scoreboard::type_id::create("alu_scbd", this);
    alu_func_cov = alu_functional_coverage::type_id::create("alu_func_cov", this);
    if(!uvm_config_db#(virtual alu_interface)::get(null, "", "alu_intf", alu_agnt_cfg.alu_vif))
        `uvm_fatal(get_type_name(), "Did not get the alu_vif")
    alu_agnt_cfg.active = UVM_ACTIVE;
    uvm_config_db#(alu_agent_config)::set(this, "alu_agnt", "alu_agent_config", alu_agnt_cfg);
endfunction
virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    alu_agnt.in_agnt_analysis_port.connect(alu_scbd.in_analysis_export);
    alu_agnt.out_agnt_analysis_port.connect(alu_scbd.out_analysis_export);
    alu_agnt.out_agnt_analysis_port.connect(alu_func_cov.analysis_export);
endfunction