
# ROM Stuff

ROM_SOURCE := FE5.sfc
ROM_TARGET := FE5_Disassembly.sfc

SYM_TARGET := $(patsubst %.sfc,%.cpu.sym,$(ROM_TARGET))

# Folders

GFX             := "$(CURDIR)/GFX"
TOOLS           := "$(CURDIR)/TOOLS"

# Tools

SF              := "$(TOOLS)/superfamiconv"
64tass          := "$(TOOLS)/64tass"
scan_includes   := "$(TOOLS)/scan_includes.py"
compare         := "$(TOOLS)/compare.py"
c2a             := "$(TOOLS)/c2a.py"
update_checksum := "$(TOOLS)/update_checksum.py"
fix_sym         := "$(TOOLS)/fix_sym.py"

DEPS := $(shell python3 $(scan_includes) Build.asm)

ASFLAGS := -f -i Build.asm -o $(ROM_TARGET) --vice-labels -l $(SYM_TARGET)

# Build Targets

all: $(ROM_TARGET) checksum compare symbols

$(ROM_TARGET): $(DEPS) Build.asm Makefile
	$(64tass) $(ASFLAGS)

checksum: $(ROM_TARGET)
	@python3 $(update_checksum) $(ROM_TARGET)

compare: $(ROM_TARGET)
	@python3 $(compare) $(ROM_SOURCE) $(ROM_TARGET)

symbols: $(SYM_TARGET)
	@python3 $(fix_sym) $(SYM_TARGET)

# Going to avoid cleaning most things until
# they're able to be generated automatically

.PHONY: clean veryclean
clean:
	$(RM) $(ROM_TARGET)
	$(RM) *.sym
	$(RM) *.png
	$(RM) *.srm
	$(RM) *.bst
	$(RM) *.casm

veryclean: clean
	$(RM) $(ROM_SOURCE)

# Table rules

%.casm: %.csv
	@python3 $(c2a) $< $@

# Image rules

%.4bpp: %.png
	$(SF) -v -i $< -t $@ -B 4 -R
