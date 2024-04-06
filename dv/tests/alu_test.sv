class alu_test extends uvm_test;
    `uvm_component_utils(alu_test)
    alu_environment alu_env;
    alu_sequence_config alu_seq_cfg;
    alu_sequence alu_seq;
    function new(string name = "alu_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void end_of_elaboration_phase(uvm_phase phase);
endclass

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    alu_env = alu_environment::type_id::create("alu_env", this);
    alu_seq_cfg = alu_sequence_config::type_id::create("alu_seq_cfg");
    alu_seq = alu_sequence::type_id::create("alu_seq");
    alu_seq_cfg.randomize() with {num_of_seq_items == 300;}; //? 300 for one spec and 8500 for all specs to reach 100% coverage
    uvm_config_db#(alu_sequence_config)::set(this, "alu_env.alu_agnt.alu_seqr", "alu_sequence_config", alu_seq_cfg);
    uvm_config_db#(uvm_object_wrapper)::set(this,"alu_env.alu_agnt.alu_seqr.run_phase", "default_sequence", alu_sequence::get_type());
endfunction
virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
endfunction
