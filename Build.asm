
.cpu "65816"

; Temporarily use vanilla definitions

  USE_FE5_DEFINITIONS := true

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
  .include "SRC/Code83Temp.asm"

  .include "EVENTS/Chapter1.event"
  .include "EVENTS/Chapter2.event"

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

  .endlogical

  * := $007FE0
  .logical mapped($007FE0)

    startData

      .dsection VectorTableSection

    endData $810000

  .endlogical

  * := $01FB4D
  .logical mapped($01FB4D)

    startCode

      .dsection ResetCapturedPlayerUnitsSection
      .dsection FreeNonplayerDeploymentSlotsSection
      .dsection SetNewGameOptionsSection
      .dsection UnknownResetPlayerUnitVisibilitySection
      .dsection SetChapterTurncountSection
      .dsection ClearUnitArraysSection
      .dsection ClearLossesWinsTurncountsSection

    endCode

  .endlogical

  .fill ($020000 - *), $FF

  * := $0C81B4
  .logical mapped($0C81B4)

    startEvents

      .dsection Chapter2EventsSection

    endEvents

  .endlogical

  * := $18F91C
  .logical mapped($18F91C)

    startData

      .dsection Chapter2DataSection

    endData

  .endlogical

  * := $18FB37
  .logical mapped($18FB37)

    startData

      .dsection Chapter1DataSection

    endData

  .endlogical

  * := $3E8000
  .logical mapped($3E8000)

    startEvents

      .dsection Chapter1EventsSection

    endEvents

  .endlogical

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
