SHELL  := /bin/bash
VLOG 	= vlog -timescale=1ns/1ns -sv
VSIM 	= vsim tb_top -do "toggle disable -r /tb_top/alu_dut/rst_n; coverage save coverage_db/$(TEST)_$(SEED).ucdb -onexit; add wave -r /tb_top/*; run -all; quit" -c -coverage -voptargs=+acc -debugDB
VCOVER 	= vcover report -cvg -details -nocompactcrossbins -testdetails -codeAll -assert -directive -html -testattr
TESTS 	= $(shell ls ../tests/*_test.sv)
TEST 	= alu_test
SEEDS 	= 5
SEED 	= 1
all: compile simulate coverage
compile:
	@echo " => Compiling the RTL and DV files."; \
	$(VLOG) -cover sbceft -f rtl_compile_list.f > rtl_compile.log; \
	$(VLOG) -f dv_compile_list.f > dv_compile.log; \
	echo " => Compilation completed, Please chech the compile.log file for more details.";
available_tests:
	@echo " => Available Tests:"; \
	number=1; \
	for test in $(TESTS); do \
		test_name=$$(basename $$test .sv); \
		echo -e '\t'$$number'\t\b\b\b\b\b'- $$test_name; \
		number=$$((number + 1)); \
	done;
run: available_tests
	@read -p " => Enter the number of the test to run: " index; \
	TEST=$$(echo $(TESTS) | awk -v idx=$$index '{print $$idx}'); \
	TEST=$$(basename $$TEST .sv); \
	SEED=$$RANDOM; \
	echo " => Running the test: $$TEST with seed: $$SEED."; \
	make simulate TEST=$$TEST SEED=$$SEED > /dev/null; \
	echo " => Simulation completed, Please chech the simulation_logs/$$TEST"_$$SEED"_simulation.log file for more details."; \
	echo " => Generating coverage report."; \
	make coverage TEST=$$TEST SEED=$$SEED > /dev/null; \
	echo " => Coverage report Generated, Please chech the coverage_logs/$$TEST"_$$SEED"_coverage.log file for more details and coverage_reports/$$TEST"_$$SEED"_coverage_report for the report.";
simulate:
	@echo " => Running the test: $(TEST) with seed: $(SEED)."; \
	$(VSIM) +UVM_TESTNAME=$(TEST) -sv_seed $(SEED) > simulation_logs/$(TEST)_$(SEED)_simulation.log; \
	echo " => Simulation completed, Please chech the simulation_logs/$(TEST)_$(SEED)_simulation.log file for more details.";
waveform:
	@vsim -view vsim.wlf -do "add wave -r /tb_top/alu_intf/*";
coverage:
	@echo " => Generating coverage report."; \
	$(VCOVER) coverage_db/$(TEST)_$(SEED).ucdb -output coverage_reports/$(TEST)_$(SEED)_coverage_report > coverage_logs/$(TEST)_$(SEED)_coverage.log; \
	echo " => Coverage report Generated, Please chech the coverage_logs/$(TEST)_$(SEED)_coverage.log file for more details and coverage_reports/$(TEST)_$(SEED)_coverage_report for the report.";
merge_coverage:
	@echo " => Merging all the coverage reports and Generating merged coverage report."; \
	vcover merge -testassociated coverage_db/*.ucdb -out coverage_db/merged_coverage.ucdb > merge.log; \
	$(VCOVER) -testhitdataAll coverage_db/merged_coverage.ucdb -output coverage_reports/merged_coverage_report > coverage_logs/merged_coverage.log; \
	echo " => Merged coverage report Generated, Please chech the coverage_logs/merged_coverage.log file for more details and coverage_reports/merged_coverage_report for the report.";
regression:
	@echo " => Cleaning the simulation directory."; \
	make clean > /dev/null; \
	echo " => Simulation directory cleaned."; \
	echo " => Compiling the RTL and DV files."; \
	make compile > /dev/null; \
	echo " => Compilation completed, Please chech the compile.log file for more details."; \
	start_time=$$(date +%s); \
	total_steps=$$(($(SEEDS) * $(words $(TESTS)))); \
	bar_length=50; \
	step=0; \
	echo " => Running the regression with $(SEEDS) seed(s) for each test."; \
	for test in $(TESTS); do \
		TEST=$$(basename $$test .sv); \
		for n in {1..$(SEEDS)}; do \
			progress=$$((step * 100 / total_steps)); \
			filled_length=$$((progress * bar_length / 100)); \
			bar=""; \
			for ((i=0; i<filled_length; i++)); do \
				bar+="#"; \
			done; \
			for ((j=filled_length; j<bar_length; j++)); do \
				bar+="-"; \
			done; \
			current_time=$$(date +%s); \
			elapsed_time=$$((current_time - start_time)); \
			elapsed_formatted=$$(date -u -d @$$elapsed_time +%H:%M:%S); \
			echo -ne " => Running.. [$$bar] $$progress% completed. [$${elapsed_formatted}s]\r"; \
			SEED=$$RANDOM; \
			make simulate TEST=$$TEST SEED=$$SEED > /dev/null; \
			make coverage TEST=$$TEST SEED=$$SEED > /dev/null; \
			step=$$((step + 1)); \
		done; \
	done; \
	end_time=$$(date +%s); \
	total_time=$$((end_time - start_time)); \
	total_time_formatted=$$(date -u -d @$$total_time +%H:%M:%S); \
	echo " => Running.. [##################################################] 100% completed. [$${total_time_formatted}s]"; \
	echo " => Merging all the coverage reports and Generating merged coverage report."; \
	make merge_coverage > /dev/null; \
	echo " => Merged coverage report Generated, Please chech the coverage_logs/merged_coverage.log file for more details and coverage_reports/merged_coverage_report for the report."; \
	echo " => Regression completed.";
clean:
	@echo " => Cleaning the simulation directory."; \
	rm -rf work transcript modelsim.ini *.wlf *.dbg *.log .* coverage_reports/* coverage_reports/.* coverage_db/* coverage_db/.* coverage_logs/* simulation_logs/* > /dev/null; \
	echo " => Simulation directory cleaned.";
help:
	@echo -e "Usage\t\t: make [all|compile|available_tests|run|simulate|waveform|coverage|merge_coverage|regression|clean|help]."; \
	echo -e "all\t\t: Compile, Simulate and Generate Coverage."; \
	echo -e "\t\t  To run a Specific test with a Specific seed, type make TEST=<test_name> SEED=<integer>, By Default TEST = alu_test and SEED = 1."; \
	echo -e "compile\t\t: Compile the RTL and DV files."; \
	echo -e "available_tests\t: List all the available tests in the tests directory."; \
	echo -e "run\t\t: Choose the number of the test from the list of all the available tests to run with a Random seed."; \
	echo -e "simulate\t: Simulate the test."; \
	echo -e "\t\t  To simulate a Specific test with a Specific seed, type make simulate TEST=<test_name> SEED=<integer>, By Default TEST = alu_test and SEED = 1."; \
	echo -e "waveform\t: Open the waveform in Questa to start debugging."; \
	echo -e "coverage\t: Generate coverage report."; \
	echo -e "merge_coverage\t: Merge all the coverage reports and Generate merged coverage report."; \
	echo -e "regression\t: Run all the tests in the tests directory with different seeds for each test and Generate merged coverage report."; \
	echo -e "\t\t  To run the regression with different number of seeds for each test, type make regression SEEDS=<number_of_seeds>, By Default SEEDS = 5."; \
	echo -e "clean\t\t: Clean the simulation directory."; \
	echo -e "help\t\t: Display the help message.";
.PHONY: all compile available_tests run simulate waveform coverage merge_coverage regression clean help
