typedef class alu_sequencer;
class alu_sequence extends uvm_sequence#(alu_sequence_item);
    `uvm_object_utils(alu_sequence)
    `uvm_declare_p_sequencer(alu_sequencer)
    uvm_phase phase;
    alu_sequence_config alu_seq_cfg;
    function new(string name = "alu_sequence");
        super.new(name);
    endfunction
    virtual function bit get_randomize(alu_sequence_item alu_seq_item);
        return (alu_seq_item.randomize());
    endfunction
    virtual task pre_body();
        if(!uvm_config_db#(alu_sequence_config)::get(m_sequencer, "", "alu_sequence_config", alu_seq_cfg))
            `uvm_fatal(get_type_name(), "Unable to get alu_seq_cfg")
        phase = get_starting_phase();
        if(phase != null)
            phase.raise_objection(this);
    endtask
    virtual task body();
        alu_sequence_item alu_seq_item;
        `uvm_info(get_type_name(), $sformatf("number of created sequences = %0d", alu_seq_cfg.num_of_seq_items), UVM_NONE)
        repeat(alu_seq_cfg.num_of_seq_items) begin
            alu_seq_item = alu_sequence_item::type_id::create("alu_seq_item");
            `uvm_info(get_type_name(), "creating sequence item: ", UVM_HIGH)
            start_item(alu_seq_item);
            if(!get_randomize(alu_seq_item))
                `uvm_fatal(get_type_name(), "Randomization failed")
            finish_item(alu_seq_item);
        end
    endtask
    virtual task post_body();
        if(phase != null)
            phase.drop_objection(this);
    endtask
endclass
