`uvm_analysis_imp_decl(_in)
`uvm_analysis_imp_decl(_out)
class alu_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(alu_scoreboard)
    uvm_analysis_imp_in #(alu_sequence_item, alu_scoreboard) in_analysis_export;
    uvm_analysis_imp_out #(alu_sequence_item, alu_scoreboard) out_analysis_export;
    alu_sequence_item input_items[$];
    alu_sequence_item expected_output_items[$];
    alu_sequence_item actual_output_items[$];
    alu_sequence_item alu_seq_item;
    int Success;
    int Failures;
    function new(string name = "alu_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void write_in(alu_sequence_item alu_seq_item);
    extern virtual function void write_out(alu_sequence_item alu_seq_item);
    extern virtual function void phase_ready_to_end(uvm_phase phase);
    extern virtual task wait_for_output_items(uvm_phase phase);
    extern virtual function void extract_phase(uvm_phase phase);
    extern virtual function void check_phase(uvm_phase phase);
    extern virtual function void predictor(alu_sequence_item input_items[$], ref alu_sequence_item expected_output_items[$]);
    extern virtual function void report_phase(uvm_phase phase);
endclass

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    in_analysis_export = new("in_analysis_export", this);
    out_analysis_export = new("out_analysis_export", this);
endfunction
virtual function void write_in(alu_sequence_item alu_seq_item);
    `uvm_info(get_type_name(), $sformatf("input item : A = %0d , B = %0d", alu_seq_item.A, alu_seq_item.B), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("Contents: \n%s", alu_seq_item.sprint()), UVM_HIGH)
    input_items.push_back(alu_seq_item);
endfunction
virtual function void write_out(alu_sequence_item alu_seq_item);
    `uvm_info(get_type_name(), $sformatf("output item : C = %0d", alu_seq_item.C), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("Contents: \n%s", alu_seq_item.sprint()), UVM_HIGH);
    actual_output_items.push_back(alu_seq_item);
endfunction
virtual function void phase_ready_to_end(uvm_phase phase);
    if(phase.get_name() == "run") begin
        if(input_items.size() != actual_output_items.size()) begin
            phase.raise_objection(this, "waiting for the rest of output items");
            fork
                begin
                    wait_for_output_items(phase);
                end
                begin
                    #100;
                    `uvm_info(get_type_name(), "TIME OUT!", UVM_NONE)
                    phase.drop_objection(this, "time out");
                end
            join_none
        end
    end
endfunction
virtual task wait_for_output_items(uvm_phase phase);
    wait(input_items.size() == actual_output_items.size());
        phase.drop_objection(this, "got all the output items");
endtask
virtual function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    `uvm_info(get_type_name(), $sformatf("number of inputs = %0d", input_items.size()), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("number of outputs = %0d", actual_output_items.size()), UVM_LOW)
endfunction
virtual function void check_phase(uvm_phase phase);
    super.check_phase(phase);
    predictor(input_items, expected_output_items);
    foreach(actual_output_items[i])
        if(expected_output_items[i].C != actual_output_items[i].C) begin
            `uvm_error(get_type_name(), $sformatf("[%0d]\t-> Output mismatch: expected = %0d, actual = %0d", (i+1), expected_output_items[i].C, actual_output_items[i].C))
            Failures++;
        end
        else begin
            `uvm_info(get_type_name(), $sformatf("[%0d]\t-> Output match: expected = %0d, actual = %0d", (i+1), expected_output_items[i].C, actual_output_items[i].C), UVM_LOW)
            Success++;
        end
endfunction
virtual function void predictor(alu_sequence_item input_items[$], ref alu_sequence_item expected_output_items[$]);
    alu_sequence_item alu_seq_item;
    foreach(input_items[i]) begin
        alu_seq_item = alu_sequence_item::type_id::create("alu_seq_item");
        if(!input_items[i].a_en && !input_items[i].b_en)   
            alu_seq_item.C = 0;
        else if(input_items[i].a_en && !input_items[i].b_en) begin
            case(input_items[i].a_op)
                0 : alu_seq_item.C = input_items[i].A + input_items[i].B;
                1 : alu_seq_item.C = input_items[i].A - input_items[i].B;
                2 : alu_seq_item.C = input_items[i].A ^ input_items[i].B;
                3 : alu_seq_item.C = input_items[i].A & input_items[i].B;
                4 : alu_seq_item.C = input_items[i].A & input_items[i].B;
                5 : alu_seq_item.C = input_items[i].A | input_items[i].B;
                6 : alu_seq_item.C = input_items[i].A ^~ input_items[i].B;
                7 : alu_seq_item.C = 0;
            endcase
        end
        else if(!input_items[i].a_en && input_items[i].b_en) begin
            case(input_items[i].b_op)
                0 : alu_seq_item.C = ~(input_items[i].A & input_items[i].B);
                1 : alu_seq_item.C = input_items[i].A + input_items[i].B;
                2 : alu_seq_item.C = input_items[i].A + input_items[i].B;
                3 : alu_seq_item.C = 0;
            endcase
        end
        else begin
            case(input_items[i].b_op)
                0 : alu_seq_item.C = input_items[i].A ^ input_items[i].B;
                1 : alu_seq_item.C = input_items[i].A ^~ input_items[i].B;
                2 : alu_seq_item.C = input_items[i].A - 1;
                3 : alu_seq_item.C = input_items[i].B + 2;
            endcase
        end
        expected_output_items.push_back(alu_seq_item);
    end
endfunction
virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("number of Success = %0d", Success), UVM_NONE)
    `uvm_info(get_type_name(), $sformatf("number of Failures = %0d", Failures), UVM_NONE)
endfunction
