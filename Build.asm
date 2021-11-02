
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
  .include "SRC/ActionStruct.asm"
  .include "SRC/Code83Temp.asm"
  .include "SRC/CharacterData.asm"
  .include "SRC/ItemData.asm"
  .include "SRC/DeploymentSlots.asm"

  .include "EVENTS/Chapter1.event"
  .include "EVENTS/Chapter2.event"
  .include "EVENTS/Chapter2x.event"
  .include "EVENTS/Chapter3.event"
  .include "Events/Chapter4.event"
  .include "Events/Chapter4x.event"
  .include "Events/Chapter5.event"
  .include "Events/Chapter6.event"

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

  * := $018E98
  .logical mapped($018E98)

    startData

      .dsection DeploymentSlotTableSection

    endData

  .endlogical

  * := $01CE64
  .logical mapped($01CE64)

    startCode

      .dsection ActionStructSingleSection

    endCode

  .endlogical

  * := $01CFED
  .logical mapped($01CFED)

    startCode

      .dsection ActionStructGetBaseStatsSection
      .dsection ActionStructClearActionStructSection
      .dsection ActionStructCopyStartingStatsSection
      .dsection ActionStructTrySetUnitCoordinatesSection

    endCode

  .endlogical

  * := $01D4E5
  .logical mapped($01D4E5)

    startCode

      .dsection ActionStructRoundSection

    endCode

  .endlogical

  * := $01DA13
  .logical mapped($01DA13)

    startCode

      .dsection ActionStructUnknown83DA13Section
      .dsection ActionStructWriteLevelUpActionStructSection
      .dsection ActionStructTryUpdateRoundCaptureFlagSection
      .dsection ActionStructWeaponTriangleSection
      .dsection ActionStructAdjustVantageRoundOrderSection
      .dsection ActionStructUnknown83DC31Section
      .dsection ActionStructLevelUpSection
      .dsection ActionStructCalculateWeaponTriangleBonusSection
      .dsection ActionStructWeaponEffectSection
      .dsection ActionStructRollGainsSection
      .dsection ActionStructCalculateHitAvoidBonusSection
      .dsection ActionStructHalveStatsSection
      .dsection ActionStructZeroCombatStatsSection
      .dsection ActionStructSetGainedWEXPSection
      .dsection ActionStructEXPSection
      .dsection ActionStructGetSupportBonusSection
      .dsection ActionStructUnknownSetCallbackSection
      .dsection ActionStructGetItemBonusesSection
      .dsection ActionStructWinsLossesSection
      .dsection ActionStructGetCombatStatTotalSection
      .dsection ActionStructGetStatTotalDifferenceTierSection

    endCode

  .endlogical

  * := $01E879
  .logical mapped($01E879)

    startCode

      .dsection ActionStructTryGetGainedWeaponRankSection

    endCode

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

    .fill mapped($018000) + $8000 - *, $FF

  .endlogical

  * := $040054
  .logical mapped($040054)

    startData

      .dsection ScrollGrowthModifiersSection
      .dsection SupportDataSection

    endData

  .endlogical

  * := $066435
  .logical mapped($066435)

    startEvents

      .dsection Chapter3EventsSection

    endEvents

  .endlogical

  * := $0B805A
  .logical mapped($0B805A)

    startEvents

      .dsection Chapter2xEventsSection

    endEvents

  .endlogical

  * := $0C81B4
  .logical mapped($0C81B4)

    startEvents

      .dsection Chapter2EventsSection
      .dsection Chapter4EventsSection
      .dsection Chapter5EventsSection
      .dsection Chapter6EventsSection

    endEvents

  .endlogical

  * := $180000
  .logical mapped($180000)

    startData

      .dsection ItemBonusesSection

    endData

  .endlogical

  * := $18E22A
  .logical mapped($18E22A)

    startData

      .dsection Chapter6DataSection
      .dsection Chapter5DataSection
      .dsection Chapter4xDataSection
      .dsection Chapter4DataSection
      .dsection Chapter3DataSection
      .dsection Chapter2xDataSection
      .dsection Chapter2DataSection
      .dsection Chapter1DataSection

    endData

  .endlogical

  * := $33E010
  .logical mapped($33E010)

    startEvents

      .dsection Chapter1WorldMapEventsSection
      .dsection Chapter2WorldMapEventsSection
      .dsection Chapter3WorldMapEventsSection
      .dsection Chapter4WorldMapEventsSection

    endEvents

  .endlogical

  * := $3E8000
  .logical mapped($3E8000)

    startEvents

      .dsection Chapter1EventsSection
      .dsection Chapter4xEventsSection

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
