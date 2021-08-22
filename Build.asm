
.cpu "65816"

.include "../VoltEdge/VoltEdge.h"
.include "DisassemblyHelpers.h"

; Until everything is disassembled,
; pre-fill the ROM.

  .include "SRC/BaseROM.asm"

; Sources

  .include "SRC/Break.asm"
  .include "SRC/Vectors.asm"
  .include "SRC/Joypad.asm"
  .include "SRC/PPUBuffers.asm"
  .include "SRC/VBlank.asm"
  .include "SRC/Sprites.asm"
  .include "SRC/DMA.asm"
  .include "SRC/Reset.asm"
  .include "SRC/IRQ.asm"

; Sections

  * := $000000
  .logical mapped($000000)

    startCode

      .dsection BreakpointHandlerSection
      .dsection GetJoypadInputSection
      .dsection DMAPaletteAndOAMBufferSection
      .dsection CopyPPURegisterBufferSection
      .dsection CopyINIDISPBufferSection
      .dsection VBlankHandlerSection
      .dsection IRQHandlerSection
      .dsection IRQDummyRoutineSection
      .dsection EnableVBlankSection
      .dsection DisableVBlankSection
      .dsection HaltUntilVBlankSection
      .dsection EnableForcedBlankSection
      .dsection DisableForcedBlankSection
      .dsection HideSpritesSection
      .dsection ClearSpriteExtBufferSection
      .dsection UnknownDMASection

    endCode

    startData

      .dsection OAMExtBitTableSection
      .dsection OAMExtPointerAndExtBitsTableSection

    endData

    startCode

      .dsection PushToOAMBufferSection
      .dsection SpliceOAMBufferSection
      .dsection InitPPURegistersSection
      .dsection ResetHandlerSection
      .dsection ResetAlreadyInitializedSection
      .dsection MainLoopSection

    endCode

  .here

  * := $007FE0
  .logical mapped($007FE0)

    startData

      .dsection VectorTableSection

    endData $810000

  .here

; Add up disassembly byte counts

  DataSize := DataEnds - DataStarts + ...
  CodeSize := CodeEnds - CodeStarts + ...
  GraphicsSize := GraphicsEnds - GraphicsStarts + ...
  EventsSize := EventsEnds - EventsStarts + ...

  DisassemblySize := DataSize + CodeSize + GraphicsSize + EventsSize

  .warn "Total Disassembled: ", SizeFormatter(DisassemblySize)
  .warn "Data: ", SizeFormatter(DataSize)
  .warn "Code: ", SizeFormatter(CodeSize)
  .warn "Graphics: ", SizeFormatter(GraphicsSize)
  .warn "Events: ", SizeFormatter(EventsSize)
