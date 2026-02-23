# RISC-V

Main branch for my RISC-V implementations, currently focused on RV32IM single-cycle.

## Repository files

- `Makefile`: top-level build/run helper.
- `EE20B012_BTP_Thesis.pdf`: project/BTP report.
- `README.md`: project documentation.
- `RV32IM_single_cycle codes/`: organized single-cycle project (RTL + testbench + memory init files).

## RV32IM Single-Cycle Project Structure

```text
RV32IM_single_cycle codes/
|-- rtl/
|   |-- core/
|   |   |-- rv32im.v
|   |-- ifu/
|   |   |-- InstructionMemry_withWrite.v
|   |-- id/
|   |   |-- ControlUnit.v
|   |   |-- GPRs.v
|   |   |-- ImmGen.v
|   |-- ex/
|   |   |-- alu_rv32im.v
|   |   |-- aluUnit.v
|   |   |-- branchSignal.v
|   |   |-- branchType.v
|   |   |-- rsltMux.v
|   |-- mext/
|   |   |-- MExtension.v
|   |   |-- mul.v
|   |   |-- Div.v
|   |   |-- Array_MUL_USign.v
|   |-- mem/
|   |   |-- dataMemory.v
|   |-- pc/
|   |   |-- pcCntr.v
|   |-- mem_init/
|       |-- program.mem
|       |-- data.mem
|       |-- regs.mem
|       |-- division.mem
|       |-- division_im.mem
|       |-- Mextension.mem
|-- testbench/
|   |-- tb_rv32im.v
|   |-- tb_aluUnit.v
|   |-- tb_brchType.v
|   |-- tb_ControlUnit.v
|   |-- tb_dataMemory.v
|   |-- tb_Datapath_with_Uart.v
|   |-- tb_dataPath.v
|   |-- tb_GPRs.v
|   |-- tb_ImmGen.v
|   |-- tb_pccntr.v
|   |-- tb_rsltMux.v
```

## File-by-File Description

### Top-level core

- `rtl/core/rv32im.v`: top module of the RV32IM single-cycle CPU; instantiates IFU, control, register file, ALU/M-extension path, data memory, PC control, and write-back mux.

### IFU (Instruction Fetch Unit)

- `rtl/ifu/InstructionMemry_withWrite.v`: instruction memory with read path and optional byte-write support.

### ID (Instruction Decode)

- `rtl/id/ControlUnit.v`: instruction decode + control signal generation for RV32I and RV32M operations.
- `rtl/id/GPRs.v`: 32x32 register file with read/write ports and initialization from `rtl/mem_init/regs.mem`.
- `rtl/id/ImmGen.v`: immediate generator for I/S/B/U/J formats.

### EX (Execute)

- `rtl/ex/aluUnit.v`: base RV32I ALU operations and compare flags.
- `rtl/ex/alu_rv32im.v`: wrapper selecting between RV32I ALU result and M-extension result.
- `rtl/ex/branchType.v`: decodes branch control condition from opcode/funct fields.
- `rtl/ex/branchSignal.v`: evaluates branch decision using compare flags.
- `rtl/ex/rsltMux.v`: write-back result mux (ALU/load/PC+4/AUIPC/LUI).

### M Extension

- `rtl/mext/MExtension.v`: RV32M block combining multiplier and divider outputs.
- `rtl/mext/mul.v`: signed/unsigned multiply logic.
- `rtl/mext/Div.v`: divide/remainder logic.
- `rtl/mext/Array_MUL_USign.v`: unsigned array multiplier used by `mul.v`.

### MEM Stage

- `rtl/mem/dataMemory.v`: load/store data memory with byte/halfword/word and signed/unsigned load handling.

### PC Logic

- `rtl/pc/pcCntr.v`: program counter update logic for sequential, branch, JAL, and JALR flows.

### Memory Initialization Files

- `rtl/mem_init/program.mem`: instruction/program image.
- `rtl/mem_init/data.mem`: initial data memory image.
- `rtl/mem_init/regs.mem`: initial register file image.
- `rtl/mem_init/division.mem`: division-related program/data image.
- `rtl/mem_init/division_im.mem`: instruction memory image used by current IFU setup.
- `rtl/mem_init/Mextension.mem`: M-extension related memory image.

### Testbenches

- `testbench/tb_rv32im.v`: top-level RV32IM integration testbench.
- `testbench/tb_aluUnit.v`: ALU unit testbench.
- `testbench/tb_brchType.v`: branch type decode testbench.
- `testbench/tb_ControlUnit.v`: control unit testbench.
- `testbench/tb_dataMemory.v`: data memory testbench.
- `testbench/tb_Datapath_with_Uart.v`: datapath/UART-oriented testbench.
- `testbench/tb_dataPath.v`: datapath testbench variant.
- `testbench/tb_GPRs.v`: register file testbench.
- `testbench/tb_ImmGen.v`: immediate generator testbench.
- `testbench/tb_pccntr.v`: program counter control testbench.
- `testbench/tb_rsltMux.v`: write-back mux testbench.

## Build/Run Commands

From repository root:

```bash
make help
```

For this current folder name (with spaces), use quotes:

```bash
make run-single SINGLE_DIR="RV32IM_single_cycle codes/rtl" TB=tb_rv32im
```

If needed:

```bash
make run-single SINGLE_DIR="RV32IM_single_cycle codes/rtl" TB=tb_rv32im SIM=iverilog VVP=vvp
```

## Report Image Extraction

```bash
make extract-report-images
```

Extracts images from `EE20B012_BTP_Thesis.pdf` into `assets/report_images/`.
