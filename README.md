# RISC-V

This is the main branch for my RISC-V RV32IM work.  
It is meant to keep both implementations in one place:
- `single_cycle` design
- `pipeline` design

## What this repository contains

- RTL and testbench code for RV32IM designs
- A top-level `Makefile` to build and run simulations


## Recommended folder structure

```text
RISC-V/
|-- single_cycle/
|   |-- *.v
|-- pipeline/
|   |-- *.v
|-- assets/
|   |-- report_images/
|-- Makefile
|-- README.md
```

## How to use the Makefile

Run from repository root:

```bash
make help
```

Main targets:

```bash
make run-single              # compile + run single-cycle design
make run-pipe                # compile + run pipelined design
make test-single TB=tb_top   # run single-cycle testbench
make test-pipe TB=tb_top     # run pipeline testbench
make extract-report-images   # extract images from report PDF
make clean                   # remove build outputs
make clean-images            # remove extracted report images
```

## Useful overrides

If your directory or testbench names are different, override at run time:

```bash
make run-single SINGLE_DIR=rv32im_single TB=tb_single
make run-pipe PIPE_DIR=rv32im_pipe TB=tb_pipe
```

Tool overrides:

```bash
make run-single SIM=iverilog VVP=vvp
```

## Report image extraction

`make extract-report-images` reads `EE20B012_BTP_Thesis.pdf` and writes images to:

`assets/report_images/`

It uses `pdfimages` (Poppler) if available, otherwise `mutool`.
