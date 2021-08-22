
# Folders

export TOOLS    = TOOLS
export EXTTOOLS = ../FE5Tools
export TABLES   = TABLES
export GRAPHICS = GRAPHICS

# Cross-platform helpers

ifeq ($(shell python -c "import sys; print(int(sys.version_info[0] > 2))"), 1)
  export PYTHON3 := python
else
  export PYTHON3 := python3
endif

ifeq ($(OS), Windows_NT)
  export EXE  := .exe
else
  export EXE  :=
endif

# Tools

export 64tass          := $(TOOLS)/64tass$(EXE)
export scan_includes   := $(PYTHON3) $(EXTTOOLS)/scan_includes.py
export c2a             := $(PYTHON3) $(EXTTOOLS)/c2a.py
export update_checksum := $(PYTHON3) $(EXTTOOLS)/checksum.py
export fix_sym         := $(PYTHON3) $(EXTTOOLS)/fix_sym.py
export compare         := $(PYTHON3) $(EXTTOOLS)/compare.py

# Misc. tool recipes

# Tables
%.csv.asm: %.csv
	@$(c2a) $< $@
