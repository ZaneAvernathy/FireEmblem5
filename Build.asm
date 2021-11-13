
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

  * := $007FE0
  .logical mapped($007FE0)

    startData

      .dsection VectorTableSection

    endData $810000

  .endlogical

  * := $01482F
  .logical mapped($01482F)

    startText

      .dsection Chapter1WMDialogueSection

    endText

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

    .fill mapped($018000) + $8000 - *, $FF

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

  * := $0AA493
  .logical mapped($0AA493)

    startText

      .dsection Chapter1DialogueSection

    endText

  .endlogical

  * := $0B805A
  .logical mapped($0B805A)

    startEvents

      .dsection Chapter2xEventsSection
      .dsection Chapter8xEventsSection

    endEvents

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

  DisassemblySize := DataSize + CodeSize + GraphicsSize + EventsSize + TextSize

  .warn "Total Disassembled: ", SizeFormatter(DisassemblySize)
  .warn "Data: ", SizeFormatter(DataSize)
  .warn "Code: ", SizeFormatter(CodeSize)
  .warn "Graphics: ", SizeFormatter(GraphicsSize)
  .warn "Events: ", SizeFormatter(EventsSize)
  .warn "Text: ", SizeFormatter(TextSize)
