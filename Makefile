# Top-level Makefile for RV32IM project variants.
# Works with Icarus Verilog by default and supports report image extraction.

SHELL := /bin/sh

# Toolchain configuration (override from CLI when needed)
SIM ?= iverilog
VVP ?= vvp

# Project layout (override if your directories differ)
SINGLE_DIR ?= single_cycle
PIPE_DIR ?= pipeline
BUILD_DIR ?= build

# Testbench/module selection
TB ?= tb_top
TOP ?= top

# Report/image extraction
REPORT_PDF ?= EE20B012_BTP_Thesis.pdf
REPORT_IMG_DIR ?= assets/report_images

# Source file globs
SINGLE_SRCS := $(wildcard $(SINGLE_DIR)/*.v) $(wildcard $(SINGLE_DIR)/**/*.v)
PIPE_SRCS := $(wildcard $(PIPE_DIR)/*.v) $(wildcard $(PIPE_DIR)/**/*.v)

.PHONY: help check-tools prepare \
        run-single run-pipe \
        test-single test-pipe \
        extract-report-images clean clean-images

help:
	@echo "RISC-V Root Makefile"
	@echo ""
	@echo "Targets:"
	@echo "  make run-single                Compile and run single-cycle simulation"
	@echo "  make run-pipe                  Compile and run pipelined simulation"
	@echo "  make test-single TB=<tb_name>  Run single-cycle testbench"
	@echo "  make test-pipe TB=<tb_name>    Run pipeline testbench"
	@echo "  make extract-report-images     Extract report images from PDF"
	@echo "  make clean                     Remove build artifacts"
	@echo "  make clean-images              Remove extracted report images"
	@echo ""
	@echo "Common overrides:"
	@echo "  SIM=iverilog VVP=vvp SINGLE_DIR=single_cycle PIPE_DIR=pipeline TB=tb_top TOP=top"

check-tools:
	@command -v $(SIM) >/dev/null 2>&1 || { echo "Error: '$(SIM)' not found."; exit 1; }
	@command -v $(VVP) >/dev/null 2>&1 || { echo "Error: '$(VVP)' not found."; exit 1; }

prepare:
	@mkdir -p $(BUILD_DIR)

run-single: check-tools prepare
	@test -n "$(SINGLE_SRCS)" || { echo "Error: no Verilog files found under '$(SINGLE_DIR)'."; exit 1; }
	@echo "[single] compiling..."
	@$(SIM) -g2012 -o $(BUILD_DIR)/single.out -s $(TB) $(SINGLE_SRCS)
	@echo "[single] running..."
	@$(VVP) $(BUILD_DIR)/single.out

run-pipe: check-tools prepare
	@test -n "$(PIPE_SRCS)" || { echo "Error: no Verilog files found under '$(PIPE_DIR)'."; exit 1; }
	@echo "[pipe] compiling..."
	@$(SIM) -g2012 -o $(BUILD_DIR)/pipe.out -s $(TB) $(PIPE_SRCS)
	@echo "[pipe] running..."
	@$(VVP) $(BUILD_DIR)/pipe.out

test-single: run-single

test-pipe: run-pipe

extract-report-images:
	@test -f "$(REPORT_PDF)" || { echo "Error: report PDF not found at '$(REPORT_PDF)'."; exit 1; }
	@mkdir -p "$(REPORT_IMG_DIR)"
	@if command -v pdfimages >/dev/null 2>&1; then \
		echo "[report] extracting with pdfimages..."; \
		pdfimages -all "$(REPORT_PDF)" "$(REPORT_IMG_DIR)/img"; \
	elif command -v mutool >/dev/null 2>&1; then \
		echo "[report] extracting with mutool..."; \
		mutool extract -o "$(REPORT_IMG_DIR)" "$(REPORT_PDF)"; \
	else \
		echo "Error: no image extraction tool found."; \
		echo "Install poppler (pdfimages) or mupdf-tools (mutool)."; \
		exit 1; \
	fi
	@echo "[report] done. Images are in '$(REPORT_IMG_DIR)'."

clean:
	@rm -rf "$(BUILD_DIR)"
	@echo "Removed build artifacts."

clean-images:
	@rm -rf "$(REPORT_IMG_DIR)"
	@echo "Removed report images."
