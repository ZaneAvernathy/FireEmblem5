
include Tools.mak

BUILD_SCRIPT := Build.asm

ROM_SOURCE := FE5.sfc
ROM_TARGET := FE5_Disassembly.sfc

SYM_TARGET := $(ROM_TARGET:.sfc=.cpu.sym)

ASFLAGS := -f -i $(BUILD_SCRIPT) -o $(ROM_TARGET)
ASFLAGS += --vice-labels -l $(SYM_TARGET)
ASFLAGS += -Wall -Wno-portable -Wno-shadow

DEPS := $(shell $(scan_includes) $(BUILD_SCRIPT))

CLEAN_FILES := 

all: $(ROM_TARGET) checksum compare symbols

$(ROM_TARGET) $(SYM_TARGET): $(DEPS) $(BUILD_SCRIPT) $(MAKEFILE_LIST)
	@$(64tass) $(ASFLAGS)

checksum: $(ROM_TARGET)
	@$(update_checksum) $(ROM_TARGET)

compare: $(ROM_TARGET)
	@$(compare) $(ROM_SOURCE) $(ROM_TARGET)

symbols: $(SYM_TARGET)
	@$(fix_sym) $(SYM_TARGET)

# Clean targets

ifeq ($(MAKECMDGOALS),clean)
  CLEAN_FILES += $(ROM_TARGET)
  CLEAN_FILES += $(SYM_TARGET)
  CLEAN_FILES += $(wildcard *.png)
  CLEAN_FILES += $(wildcard *.srm)
  CLEAN_FILES += $(wildcard *.bst)
endif

.PHONY: clean

clean:
	@$(RM) $(CLEAN_FILES)
