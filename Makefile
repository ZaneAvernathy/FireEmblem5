
# ROM Stuff

ROM_SOURCE := FE5.sfc
ROM_TARGET := FE5_Disassembly.sfc

SYM_TARGET := $(patsubst %.sfc,%.cpu.sym,$(ROM_TARGET))

# Folders

GFX             := $(realpath .)/GFX
TOOLS           := $(realpath .)/TOOLS
TABLES          := $(realpath .)/TABLES

# Ensure that we're using the right version of python
# credit to Stan

ifeq ($(shell python -c 'import sys; print(int(sys.version_info[0] > 2))'),1)
  PYTHON3 := python
else
  PYTHON3 := python3
endif

# Ensure the right file extensions on Windows
ifeq ($(OS),Windows_NT)
  EXE := .exe
else
  EXE :=
endif

# Tools

SF              := $(TOOLS)/superfamiconv$(EXE)
64tass          := $(TOOLS)/64tass$(EXE)
scan_includes   := $(PYTHON3) $(TOOLS)/scan_includes.py
compare         := $(PYTHON3) $(TOOLS)/compare.py
c2a             := $(PYTHON3) $(TOOLS)/c2a.py
update_checksum := $(PYTHON3) $(TOOLS)/update_checksum.py
fix_sym         := $(PYTHON3) $(TOOLS)/fix_sym.py

DEPS := $(shell $(scan_includes) Build.asm)

ASFLAGS := -f -i Build.asm -o $(ROM_TARGET) --vice-labels -l $(SYM_TARGET)

# Build Targets

all: $(ROM_TARGET) checksum compare symbols

$(ROM_TARGET): $(DEPS) Build.asm Makefile
	@$(64tass) $(ASFLAGS)

checksum: $(ROM_TARGET)
	@$(update_checksum) $(ROM_TARGET)

compare: $(ROM_TARGET)
	@$(compare) $(ROM_SOURCE) $(ROM_TARGET)

symbols: $(SYM_TARGET)
	@$(fix_sym) $(SYM_TARGET)

# Going to avoid cleaning most things until
# they're able to be generated automatically

.PHONY: clean veryclean
clean:
	$(RM) $(ROM_TARGET)
	$(RM) *.sym
	$(RM) *.png
	$(RM) *.srm
	$(RM) *.bst
	$(RM) $(TABLES)/*.casm

veryclean: clean
	$(RM) $(ROM_SOURCE)

# Table rules

%.casm: %.csv
	$(c2a) $< $@

# Image rules

%.4bpp: %.png
	$(SF) -v -i $< -t $@ -B 4 -R
