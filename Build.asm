
.cpu "65816"

; Temporarily use vanilla definitions

  USE_FE5_DEFINITIONS := true

.include "../VoltEdge/VoltEdge.h"
.include "DisassemblyHelpers.h"

; Until everything is disassembled,
; pre-fill the ROM.

  .include "SRC/BaseROM.asm"

; Sources

  .include "SRC/Dialogue.asm"

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
  .include "SRC/ActionStructStaff.asm"
  .include "SRC/Code83Temp.asm"
  .include "SRC/CharacterData.asm"
  .include "SRC/ItemData.asm"
  .include "SRC/DeploymentSlots.asm"
  .include "SRC/ClassData.asm"

  .include "SRC/ChapterTitles.asm"

  .include "EVENTS/Chapter1.event"
  .include "EVENTS/Chapter2.event"
  .include "EVENTS/Chapter2x.event"
  .include "EVENTS/Chapter3.event"
  .include "EVENTS/Chapter4.event"
  .include "EVENTS/Chapter4x.event"
  .include "EVENTS/Chapter5.event"
  .include "EVENTS/Chapter6.event"
  .include "EVENTS/Chapter7.event"
  .include "EVENTS/Chapter8.event"
  .include "EVENTS/Chapter8x.event"

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

  * := $001753
  .logical mapped($001753)

    startFreespace

      .fill mapped($001B00) - *, $FF

    endFreespace

  .endlogical

  * := $005D77
  .logical mapped($005D77)

    startFreespace

      .fill mapped($005E00) - *, $FF

    endFreespace

  .endlogical

  * := $006B28
  .logical mapped($006B28)

    startFreespace

      .fill mapped($007FB0) - *, $FF

    endFreespace

  .endlogical

  * := $007FE0
  .logical mapped($007FE0)

    startData

      .dsection VectorTableSection

    endData $810000

  .endlogical

  * := $008B13
  .logical mapped($008B13)

    startFreespace

      .fill mapped($00A800) - *, $FF

    endFreespace

  .endlogical

  * := $00FF9D
  .logical mapped($00FF9D)

    startFreespace

      .fill mapped($008000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $01482F
  .logical mapped($01482F)

    startText

      .dsection Chapter1WMDialogueSection

    endText

  .endlogical

  * := $016556
  .logical mapped($016556)

    startFreespace

      .fill mapped($010000) + $8000 - *, $FF

    endFreespace

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
      .dsection ActionStructUnknown83CEAESection
      .dsection ActionStructCombatStructsSection
      .dsection ActionStructGetBaseStatsSection
      .dsection ActionStructClearActionStructSection
      .dsection ActionStructCopyStartingStatsSection
      .dsection ActionStructTrySetUnitCoordinatesSection
      .dsection ActionStructWeaponInfoSection
      .dsection ActionStructAdjustNihilSkillsSection
      .dsection ActionStructGetTerrainBonusesAndDistanceSection
      .dsection ActionStructGetCoreStatsSection
      .dsection ActionStructRoundSection
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
      .dsection ActionStructMarkSelectableTargetSection
      .dsection ActionStructGetDanceEXPSection
      .dsection ActionStructTryGetGainedWeaponRankSection
      .dsection ActionStructDanceSection
      .dsection ActionStructClearOpponentWeaponIfUsingLongRangeSection
      .dsection ActionStructGetTerrainTileSection
      .dsection ActionStructStaffSection
      .dsection HealingStaffTargetEffectSection
      .dsection FortifyTargetEffectSection
      .dsection SilenceStaffTargetEffectSection
      .dsection BerserkStaffTargetEffectSection
      .dsection SleepStaffTargetEffectSection
      .dsection StatusStaffCallbackSection
      .dsection RestoreTargetEffectSection
      .dsection WarpTargetEffectSection
      .dsection RewarpTargetEffectSection
      .dsection BarrierTargetEffectSection
      .dsection RescueStaffTargetEffectSection
      .dsection TorchStaffTargetEffectSection
      .dsection HammerneTargetEffectSection
      .dsection ThiefStaffTargetEffectSection
      .dsection ActionStructStaffGetEXPByCostSection
      .dsection ActionStructSetGainedEXPSection
      .dsection ActionStructGetStaffInfoSection
      .dsection ReturnStaffTargetEffectSection
      .dsection ActionStructStaffGetClosestTileSection
      .dsection ActionStructStaffRollHitSection
      .dsection ActionStructStaffRollDoublingSection
      .dsection ActionStructStaffTryGetClosestTileSection
      .dsection ActionStructStaffGetPowerSection
      .dsection UnlockTargetEffectSection
      .dsection WatchTargetEffectSection
      .dsection KiaTargetEffectSection
      .dsection ActionStructStaffGetGainedWEXPSection

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

    startFreespace

      .fill mapped($018000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $027C7B
  .logical mapped($027C7B)

    startFreespace

      .fill mapped($020000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $02FFE1
  .logical mapped($02FFE1)

    startFreespace

      .fill mapped($028000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $030000
  .logical mapped($030000)

    startData

      .dsection ClassDataSection

    endData

  .endlogical

  * := $0310BC
  .logical mapped($0310BC)

    startData

      .dsection MovementTypeSection
      .dsection TerrainBonusSection

    endData

  .endlogical

  * := $0366AD
  .logical mapped($0366AD)

    startFreespace

      .fill mapped($030000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $03FFA5
  .logical mapped($03FFA5)

    startFreespace

      .fill mapped($038000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $040054
  .logical mapped($040054)

    startData

      .dsection ScrollGrowthModifiersSection
      .dsection SupportDataSection

    endData

  .endlogical

  * := $047103
  .logical mapped($047103)

    startFreespace

      .fill mapped($040000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $04FA7C
  .logical mapped($04FA7C)

    startFreespace

      .fill mapped($048000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0568E2
  .logical mapped($0568E2)

    startFreespace

      .fill mapped($050000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $05FBDF
  .logical mapped($05FBDF)

    startFreespace

      .fill mapped($058000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $066435
  .logical mapped($066435)

    startEvents

      .dsection Chapter3EventsSection

    endEvents

  .endlogical

  * := $067FF3
  .logical mapped($067FF3)

    startFreespace

      .fill mapped($060000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $076FDE
  .logical mapped($076FDE)

    startFreespace

      .fill mapped($070000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $07F2D7
  .logical mapped($07F2D7)

    startFreespace

      .fill mapped($078000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0871F3
  .logical mapped($0871F3)

    startFreespace

      .fill mapped($080000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $097D45
  .logical mapped($097D45)

    startFreespace

      .fill mapped($090000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $09ECEF
  .logical mapped($09ECEF)

    startFreespace

      .fill mapped($098000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0A7DEA
  .logical mapped($0A7DEA)

    startFreespace

      .fill mapped($0A0000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0AA493
  .logical mapped($0AA493)

    startText

      .dsection Chapter1DialogueSection

    endText

  .endlogical

  * := $0AFD4C
  .logical mapped($0AFD4C)

    startFreespace

      .fill mapped($0A8000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0B7711
  .logical mapped($0B7711)

    startFreespace

      .fill mapped($0B0000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0B805A
  .logical mapped($0B805A)

    startEvents

      .dsection Chapter2xEventsSection
      .dsection Chapter8xEventsSection

    endEvents

  .endlogical

  * := $0BFB88
  .logical mapped($0BFB88)

    startFreespace

      .fill mapped($0B8000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0C6C60
  .logical mapped($0C6C60)

    startFreespace

      .fill mapped($0C0000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0C81B4
  .logical mapped($0C81B4)

    startEvents

      .dsection Chapter2EventsSection
      .dsection Chapter4EventsSection
      .dsection Chapter5EventsSection
      .dsection Chapter6EventsSection
      .dsection Chapter7EventsSection
      .dsection Chapter8EventsSection

    endEvents

  .endlogical

  * = $0D37EF
  .logical mapped($0D37EF)

    startText

      .dsection ChapterTitleSection

    endText

  .endlogical

  * := $0D7E28
  .logical mapped($0D7E28)

    startFreespace

      .fill mapped($0D0000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0DFE95
  .logical mapped($0DFE95)

    startFreespace

      .fill mapped($0D8000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0E7F71
  .logical mapped($0E7F71)

    startFreespace

      .fill mapped($0E0000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0EFEF0
  .logical mapped($0EFEF0)

    startFreespace

      .fill mapped($0E8000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0F0786
  .logical mapped($0F0786)

    startFreespace

      .fill mapped($0F1000) - *, $FF

    endFreespace

  .endlogical

  * := $0F73B2
  .logical mapped($0F73B2)

    startFreespace

      .fill mapped($0F0000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0FF4C4
  .logical mapped($0FF4C4)

    startFreespace

      .fill mapped($0F8000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $180000
  .logical mapped($180000)

    startData

      .dsection ItemBonusesSection

    endData

  .endlogical

  * := $18D851
  .logical mapped($18D851)

    startData

      .dsection Chapter8xDataSection
      .dsection Chapter8DataSection
      .dsection Chapter7DataSection
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
      .dsection Chapter7WorldMapEventsSection
      .dsection Chapter8WorldMapEventsSection

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
  TextSize := TextEnds - TextStarts + ...
  FreespaceSize := FreespaceEnds - FreespaceStarts + ...

  DisassemblySize := DataSize + CodeSize + GraphicsSize + EventsSize + TextSize + FreespaceSize

  .warn "Total Disassembled: ", SizeFormatter(DisassemblySize)
  .warn "Data: ", SizeFormatter(DataSize)
  .warn "Code: ", SizeFormatter(CodeSize)
  .warn "Graphics: ", SizeFormatter(GraphicsSize)
  .warn "Events: ", SizeFormatter(EventsSize)
  .warn "Text: ", SizeFormatter(TextSize)
  .warn "Freespace: ", SizeFormatter(FreespaceSize)
