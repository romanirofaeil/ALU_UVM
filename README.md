# ALU Verification Environment

## Overview

This repository contains a comprehensive UVM (Universal Verification Methodology) based verification environment for an Arithmetic Logic Unit (ALU) design. The ALU supports various arithmetic and logical operations with configurable operation modes and provides comprehensive coverage analysis and regression testing capabilities.

## ALU Design Features

The ALU design (`rtl/alu_design.sv`) supports the following operations:

### Input Ports
- **clk**: Clock signal
- **rst_n**: Active-low reset
- **ALU_en**: ALU enable signal
- **A[4:0]**: 5-bit signed input A
- **B[4:0]**: 5-bit signed input B
- **a_en**: Enable signal for A-path operations
- **a_op[2:0]**: 3-bit operation code for A-path
- **b_en**: Enable signal for B-path operations  
- **b_op[1:0]**: 2-bit operation code for B-path

### Output Ports
- **C_en**: Output enable signal
- **C[5:0]**: 6-bit signed result

### Supported Operations

#### A-Path Operations (when a_en = 1, b_en = 0)
- `a_op = 0`: ADD (A + B)
- `a_op = 1`: SUB (A - B)
- `a_op = 2`: XOR (A ^ B)
- `a_op = 3`: AND (A & B)
- `a_op = 4`: AND (A & B)
- `a_op = 5`: OR (A | B)
- `a_op = 6`: XNOR (A ^~ B)

#### B-Path Operations (when a_en = 0, b_en = 1)
- `b_op = 0`: NAND (~(A & B))
- `b_op = 1`: ADD (A + B)
- `b_op = 2`: ADD (A + B)

#### Combined Operations (when a_en = 1, b_en = 1)
- `b_op = 0`: XOR (A ^ B)
- `b_op = 1`: XNOR (A ^~ B)
- `b_op = 2`: A_MINUS_1 (A - 1)
- `b_op = 3`: B_PLUS_2 (B + 2)

## Project Structure

```
alu/
├── rtl/                          # RTL Design Files
│   └── alu_design.sv            # Main ALU design module
├── dv/                          # Design Verification Files
│   ├── env/                     # UVM Environment Components
│   │   ├── alu_agent_config.sv  # Agent configuration
│   │   ├── alu_agent.sv         # UVM agent
│   │   ├── alu_driver.sv        # UVM driver
│   │   ├── alu_monitor.sv       # UVM monitor
│   │   ├── alu_scoreboard.sv    # UVM scoreboard
│   │   ├── alu_sequencer.sv     # UVM sequencer
│   │   ├── alu_environment.sv   # Top-level environment
│   │   └── alu_environment_package.sv
│   ├── sequences/               # UVM Sequences
│   │   ├── alu_sequence_item.sv # Transaction item
│   │   ├── alu_sequence.sv      # Base sequence
│   │   ├── alu_sequence_config.sv
│   │   ├── alu_sequence_package.sv
│   │   └── alu_*_sequence.sv    # Specific operation sequences
│   ├── tests/                   # UVM Test Cases
│   │   ├── alu_test_package.sv  # Test package
│   │   ├── alu_test.sv          # Base test
│   │   └── alu_*_test.sv        # Specific operation tests
│   ├── tb/                      # Testbench Files
│   │   ├── alu_interface.sv     # SystemVerilog interface
│   │   └── alu_testbench.sv     # Top-level testbench
│   └── sim/                     # Simulation Directory
│       ├── Makefile             # Build and simulation automation
│       ├── dv_compile_list.f    # DV file compilation list
│       ├── rtl_compile_list.f   # RTL file compilation list
│       ├── coverage_db/         # Coverage database files
│       ├── coverage_logs/       # Coverage generation logs
│       ├── coverage_reports/    # HTML coverage reports
│       ├── simulation_logs/     # Simulation log files
│       └── work/               # Compilation work directory
└── README.md                    # This file
```

## UVM Verification Environment

The verification environment follows standard UVM methodology with the following components:

### 1. UVM Agent (`alu_agent.sv`)
- Contains driver, monitor, and sequencer
- Configurable as active/passive agent
- Handles stimulus generation and response collection

### 2. UVM Driver (`alu_driver.sv`)
- Drives transactions to the DUT interface
- Implements protocol-specific driving logic

### 3. UVM Monitor (`alu_monitor.sv`)
- Observes DUT interface signals
- Collects input and output transactions
- Provides analysis ports for scoreboard connection

### 4. UVM Sequencer (`alu_sequencer.sv`)
- Manages sequence execution
- Arbitrates between multiple sequences

### 5. UVM Scoreboard (`alu_scoreboard.sv`)
- Implements golden reference model
- Compares DUT outputs with expected results
- Tracks pass/fail statistics

### 6. UVM Environment (`alu_environment.sv`)
- Top-level container for all verification components
- Handles component creation and connection

### 7. Sequence Items (`alu_sequence_item.sv`)
- Transaction-level objects
- Contains randomization constraints
- Supports all ALU input combinations

### 8. Test Cases
Available test cases include:
- `alu_test`: General randomized test
- `alu_ADD_test`: Focused ADD operation testing
- `alu_SUB_test`: Focused SUB operation testing
- `alu_AND_test`: Focused AND operation testing
- `alu_OR_test`: Focused OR operation testing
- `alu_XOR_test`: Focused XOR operation testing
- `alu_NAND_test`: Focused NAND operation testing
- `alu_XNOR_test`: Focused XNOR operation testing
- `alu_A_MINUS_1_test`: Focused A-1 operation testing
- `alu_B_PLUS_2_test`: Focused B+2 operation testing
- `alu_ERROR_test`: Error condition testing

## Makefile Usage

The verification environment includes a comprehensive Makefile located in `dv/sim/` with the following targets:

### Basic Targets

#### `make help`
Displays detailed usage information for all available targets.

#### `make compile` 
Compiles RTL and DV files.
- Compiles RTL files listed in `rtl_compile_list.f`
- Compiles DV files listed in `dv_compile_list.f`
- Generates compilation logs: `rtl_compile.log` and `dv_compile.log`

#### `make available_tests`
Lists all available test cases in the tests directory with numbering.

### Simulation Targets

#### `make simulate`
Runs simulation with default or specified parameters:
```bash
# Default simulation (alu_test with seed 1)
make simulate

# Specific test with specific seed
make simulate TEST=alu_ADD_test SEED=12345
```

#### `make run`
Interactive test selection and execution:
- Displays numbered list of available tests
- Prompts user to select test by number
- Runs selected test with random seed
- Automatically generates coverage report

#### `make all`
Complete workflow: compile, simulate, and generate coverage.
```bash
# Default workflow
make all

# With specific test and seed
make all TEST=alu_XOR_test SEED=54321
```

### Coverage Targets

#### `make coverage`
Generates HTML coverage report for a specific test run:
```bash
make coverage TEST=alu_ADD_test SEED=12345
```
- Creates detailed HTML coverage report
- Saves report in `coverage_reports/` directory
- Generates coverage log in `coverage_logs/` directory

#### `make merge_coverage`
Merges all individual coverage databases and generates consolidated report:
- Combines all `.ucdb` files from `coverage_db/` directory
- Creates merged coverage database
- Generates comprehensive HTML report in `coverage_reports/merged_coverage_report/`

### Regression Testing

#### `make regression`
Runs comprehensive regression with all tests:
```bash
# Default: 5 seeds per test
make regression

# Custom number of seeds per test
make regression SEEDS=10
```

Features:
- Runs all tests with multiple random seeds
- Real-time progress bar with elapsed time
- Automatic coverage report generation
- Comprehensive final merged coverage report

### Debugging

#### `make waveform`
Opens waveform viewer for debugging:
- Launches Questa with saved waveform file
- Automatically adds interface signals to waveform

### Maintenance

#### `make clean`
Cleans simulation directory:
- Removes work directories
- Cleans coverage databases and reports
- Removes log files and temporary files

### Default Parameters
- **TEST**: `alu_test` (default test)
- **SEED**: `1` (default random seed)
- **SEEDS**: `5` (default number of seeds for regression)

### Example Usage Scenarios

```bash
# Quick single test run
make all TEST=alu_AND_test SEED=999

# Interactive test selection
make run

# Full regression testing
make regression SEEDS=20

# Coverage analysis only
make coverage TEST=alu_XOR_test SEED=456

# Merge all coverage reports
make merge_coverage

# Clean and start fresh
make clean && make regression
```

## Getting Started

### Prerequisites

1. **Questa/ModelSim**: Simulation and coverage tool
   - Ensure `vlog`, `vsim`, and `vcover` are in your PATH
   - UVM library should be available

2. **SystemVerilog Support**: Compiler with UVM support

3. **Make**: Build automation tool

### Quick Start

1. **Clone/Navigate to Repository**:
   ```bash
   cd alu/dv/sim
   ```

2. **Compile Design**:
   ```bash
   make compile
   ```

3. **Run a Quick Test**:
   ```bash
   make run
   ```

4. **Run Full Regression**:
   ```bash
   make regression
   ```

5. **View Coverage Report**:
   Open `coverage_reports/merged_coverage_report/index.html` in a web browser

### Coverage Analysis

The environment provides comprehensive coverage analysis:

- **Functional Coverage**: Covers all operation combinations
- **Code Coverage**: Statement, branch, condition, and expression coverage
- **Assertion Coverage**: SVA assertions for interface protocols
- **Cross Coverage**: Operation cross combinations

Coverage reports are generated in HTML format with detailed analysis including:
- Coverage summary by type
- Line-by-line code coverage
- Functional coverage bins
- Cross-coverage matrices
- Test-specific coverage details

### File Lists

#### RTL Compilation (`rtl_compile_list.f`)
```
+incdir+.
+incdir+../../rtl/.

../../rtl/alu_design.sv
```

#### DV Compilation (`dv_compile_list.f`)  
```
+incdir+../env
+incdir+../sequences
+incdir+../tests
+incdir+../tb

../tb/alu_interface.sv
../env/alu_environment_package.sv
../sequences/alu_sequence_package.sv
../tests/alu_test_package.sv
../tb/alu_testbench.sv
```

## Interface Assertions

The ALU interface (`alu_interface.sv`) includes SystemVerilog assertions for:

1. **ALU Enable Check**: Ensures outputs are inactive when ALU is disabled
2. **Reset Behavior**: Verifies proper reset functionality

## Customization

### Adding New Tests

1. Create new test file in `dv/tests/` directory
2. Extend base test class or create specific test
3. Add test to package file
4. Test will be automatically discovered by Makefile

### Adding New Sequences

1. Create sequence file in `dv/sequences/` directory
2. Extend base sequence class
3. Add sequence to package file
4. Use in tests as needed

### Modifying Coverage

Coverage settings can be modified in:
- Makefile compilation flags
- Interface assertions
- Sequence item constraints
- Scoreboard checking

## Troubleshooting

### Common Issues

1. **Compilation Errors**: Check file lists and include paths
2. **Simulation Hangs**: Verify clock generation and reset logic
3. **Coverage Issues**: Ensure coverage compilation flags are set
4. **Path Issues**: Use absolute paths or verify working directory

### Log Files

- **Compilation**: `rtl_compile.log`, `dv_compile.log`
- **Simulation**: `simulation_logs/`
- **Coverage**: `coverage_logs/`

## Contributing

When contributing to this verification environment:

1. Follow UVM best practices
2. Add appropriate coverage for new features
3. Update test cases for new functionality
4. Maintain consistent coding style
5. Update documentation as needed

## License

This verification environment is provided as-is for educational and verification purposes.
