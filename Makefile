
SHELL = /bin/sh

.PHONY: all
.SUFFIXES:
.DEFAULTGOAL: all

DEPS :=
ASFLAGS :=

include Tools.mak

# Component Makefiles

include $(DIALOGUE)/Makefile

# Configuration

BASEROM := ../FE5.sfc
BUILD_SCRIPT := Build.asm

ROM_TARGET := $(BIN)/FireEmblem5.sfc
SYM_TARGET := $(ROM_TARGET:.sfc=.cpu.sym)

LOG_TARGET   := Log.txt
ERROR_TARGET := Errors.txt

BUILD_TARGETS := $(ROM_TARGET) $(SYM_TARGET) $(LOG_TARGET) $(ERROR_TARGET)

ASFLAGS += -x -f -C -a
ASFLAGS += -Wall
ASFLAGS += -Wno-portable -Wno-shadow -Wno-deprecated
ASFLAGS += -D BASEROM=\"$(BASEROM)\"
ASFLAGS += -D USE_FE5_DEFINITIONS=true
ASFLAGS += -i "$(VOLTEDGE)/VoltEdge.h" -i "$(BUILD_SCRIPT)"
ASFLAGS += -o "$(ROM_TARGET)"
ASFLAGS += --vice-labels -l "$(SYM_TARGET)"

DEPS += $(shell $(scan_includes) "$(BUILD_SCRIPT)" "$(VOLTEDGE)/VoltEdge.h")

all: $(BUILD_TARGETS) checksum compare symbols

# This mess is to allow the errors to be printed
# unconditionally but the log file can only be processed
# if the build was successful. This keeps track of the exit
# status of the assembly step and saves that for the return value.
$(BUILD_TARGETS): $(BUILD_SCRIPT) $(DEPS) $(MAKEFILE_LIST)
	@($(64tass) $(ASFLAGS) 1>"$(LOG_TARGET)" -E "$(ERROR_TARGET)" && $(regions) "$(LOG_TARGET)") ; \
	declare -i e=$$? ; \
	cat "$(ERROR_TARGET)" >&2 ; \
	exit $$((e))

checksum: $(ROM_TARGET)
	@$(update_checksum) "$<" | tee -a "$(LOG_TARGET)"

compare: $(ROM_TARGET)
	@$(compare) "$(BASEROM)" "$(ROM_TARGET)" | tee -a "$(ERROR_TARGET)"

symbols: $(SYM_TARGET)
	@$(fix_sym) "$<"

$(BIN):
	@mkdir -p $(BIN)

# `clean` to get rid of files in the BIN folder
# `veryclean` to get rid of all generated files

clean:: | $(BIN)
	@$(RM) $(BIN)/*.*

veryclean:: clean
	@$(RM) "$(LOG_TARGET)" "$(ERROR_TARGET)"
