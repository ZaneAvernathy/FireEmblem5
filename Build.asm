
.cpu "65816"

.include "SizeHelpersStart.h"

; Until everything is disassembled,
; pre-fill the ROM.

  .include "SRC/BaseROM.asm"

  ; Grab the base ROM as bytes for shenanigans.
  ROM = binary(BASEROM)

  ; Temporary helper to work with data that crosses
  ; bank boundaries. TODO: add to Volt Edge.

  crossbankRawMissing   := 0
  crossbankRawRemaining := b""

  crossbankRaw .segment Block
    crossbankRawMissing   := $10000 - (* & $FFFF)
    crossbankRawRemaining := \Block[crossbankRawMissing:]
    .text \Block[:crossbankRawMissing]
  .endsegment

  crossbankRawRemainder .segment
    .text crossbankRawRemaining
  .endsegment

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
  .include "SRC/AI.asm"

  .include "SRC/ChapterTitles.asm"
  .include "SRC/WMMarkers.asm"

  .include "SRC/Events.asm"

  .include "SRC/ChapterDialoguePointers.asm"

  .include "SRC/BattleBackgrounds.asm"
  .include "SRC/Portraits.asm"
  .include "SRC/Tilesets.asm"

  .include "SRC/Arena.asm"
  .include "SRC/PickPhaseMusic.asm"

; Sections

  * := $000000
  .logical mapped($000000)

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
    .dsection OAMExtBitTableSection
    .dsection OAMExtPointerAndExtBitsTableSection
    .dsection PushToOAMBufferSection
    .dsection SpliceOAMBufferSection
    .dsection InitPPURegistersSection
    .dsection ResetHandlerSection
    .dsection ResetAlreadyInitializedSection
    .dsection MainLoopSection

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

    .dsection VectorTableSection

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

  * := $0138AF
  .logical mapped($0138AF)

    startDialogue

      .dsection DeathQuoteDialogueSection
      .dsection RetreatQuoteDialogueSection
      .dsection ChapterEndLinoanDeadDialogueSection
      .dsection UnusedBlankWMDialogueSection
      .dsection Chapter01WMDialogueSection
      .dsection Chapter02WMDialogueSection
      .dsection Chapter03WMDialogueSection
      .dsection Chapter04WMDialogueSection
      .dsection Chapter07WMDialogueSection
      .dsection Chapter08WMDialogueSection
      .dsection Chapter09WMDialogueSection
      .dsection Chapter10WMDialogueSection
      .dsection Chapter11WMDialogueSection
      .dsection Chapter12WMDialogueSection
      .dsection Chapter13WMDialogueSection
      .dsection Chapter15WMDialogueSection
      .dsection Chapter16AWMDialogueSection
      .dsection Chapter17AWMDialogueSection
      .dsection Chapter16BWMDialogueSection
      .dsection Chapter17BWMDialogueSection
      .dsection Chapter18WMDialogueSection
      .dsection Chapter19WMDialogueSection
      .dsection Chapter20WMDialogueSection
      .dsection Chapter21WMDialogueSection
      .dsection Chapter22WMDialogueSection
      .dsection Chapter23WMDialogueSection
      .dsection Chapter24WMDialogueSection

    endDialogue

    startData

      .dsection ChapterDialoguePointersSection

    endData

    startFreespace

      .fill mapped($010000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $016556
  .logical mapped($016556)

    startFreespace

      .fill mapped($010000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $018E98
  .logical mapped($018E98)

    .dsection DeploymentSlotTableSection

  .endlogical

  * := $01A5B2
  .logical mapped($01A5B2)

    .dsection PickPhaseMusicSection

  .endlogical

  * := $01CE64
  .logical mapped($01CE64)

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

  .endlogical

  * := $01FB4D
  .logical mapped($01FB4D)

    .dsection ResetCapturedPlayerUnitsSection
    .dsection FreeNonplayerDeploymentSlotsSection
    .dsection SetNewGameOptionsSection
    .dsection UnknownResetPlayerUnitVisibilitySection
    .dsection SetChapterTurncountSection
    .dsection ClearUnitArraysSection
    .dsection ClearLossesWinsTurncountsSection

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

  * := $02EF31
  .logical mapped($02EF31)

    .dsection ArenaClassPoolSection

  .endlogical

  * := $02FFE1
  .logical mapped($02FFE1)

    startFreespace

      .fill mapped($028000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $030000
  .logical mapped($030000)

    .dsection ClassDataSection

  .endlogical

  * := $0310BC
  .logical mapped($0310BC)

    .dsection MovementTypeSection
    .dsection TerrainBonusSection

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

  * := $040000
  .logical mapped($040000)

    .dsection MountDismountTableSection
    .dsection Unknown888038Section
    .dsection ScrollGrowthModifiersSection
    .dsection SupportDataSection
    .dsection TransformingItemSection
    .dsection AutolevelDataSection

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

  * := $06512A
  .logical mapped($06512A)

    .dsection PortraitTableSection

  .endlogical

  * := $066435
  .logical mapped($066435)

    startEventScenes

      .dsection Chapter03EventsSection
      .dsection Chapter09EventsSection

    endEventScenes

  .endlogical

  * := $067FF3
  .logical mapped($067FF3)

    startFreespace

      .fill mapped($060000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $068000
  .logical mapped($068000)

    .dsection AIMainSection
    .dsection AIRecoveryThresholdSection
    .dsection AIReadScriptOpcodeSection
    .dsection AICopyMapsSection
    .dsection AIStaffEffectSection
    .dsection AILootTileEffectSection
    .dsection AIRequestHealingInRecoveryModeSection
    .dsection AITryUseHealingItemSection
    .dsection AIUnknown8D869ASection
    .dsection AIRecoveryModeSection

  .endlogical

  * := $069A4F
  .logical mapped($069A4F)

    .dsection AITryCantoSection
    .dsection AIGetRandomTileInRangeSection
    .dsection AIMovementStarSection
    .dsection AIUnknownGetLowThreatTileInRangeSection
    .dsection AIApproachTileSection
    .dsection AIGetSafestTileNearTargetSection

  .endlogical

  * := $06B88C
  .logical mapped($06B88C)

    .dsection AICheckIfUnitCanOpenChestsSection

  .endlogical

  * := $06BABC
  .logical mapped($06BABC)

    .dsection AICheckIfTileIsLessThreatenedSection

  .endlogical

  * := $06D8A4
  .logical mapped($06D8A4)

    .dsection AIItemUseSection

  .endlogical

  * := $06DCC6
  .logical mapped($06DCC6)

    .dsection AICountTargetsInRangeSection
    .dsection AICheckIfUnitInAreaSection
    .dsection AICheckIfFlagSetSection
    .dsection AIGetCurrentTurnSection
    .dsection AIPatrolSection
    .dsection AIUpdateGroupAISection
    .dsection AIMoveToCoordinatesByChapterSection
    .dsection AIMoveToIsolatedTargetSection
    .dsection AIDanceSection
    .dsection AIGetEffectiveThreatenedTilesSection
    .dsection AIOverwriteStationaryFlagSection
    .dsection AISetUpperActionCapabilityBitfield
    .dsection AICountCharacterInMovementRangeSection
    .dsection AISetAIForUnitInCurrentPhaseSection
    .dsection AICountWeaponsInInventorySection
    .dsection AIGetAICounterSection
    .dsection AIForceHealSection
    .dsection AIIsCharacterInIgnoreTableSection
    .dsection AISetAllegianceToNPCSection
    .dsection AIUnknownSetAISection
    .dsection AICheckIfTerrainAtCoordinatesSection
    .dsection AITryOpenClosestDoorSection
    .dsection AIUnknown8DE468Section
    .dsection AISetBusyStatusSection

    startFreespace

      .fill mapped($068000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $076FDE
  .logical mapped($076FDE)

    startFreespace

      .fill mapped($070000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $078000
  .logical mapped($078000)

    .dsection ActionAIScriptSection
    .dsection MovementAIScriptSection
    .dsection AIRecoveryThresholdTableSection

  .endlogical

  * := $0788F2
  .logical mapped($0788F2)

    .dsection AIChapterCoordinatesSection

  .endlogical

  * := $078B6B
  .logical mapped($078B6B)

    .dsection AIIgnoreTableSection

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

  * := $08CCEA
  .logical mapped($08CCEA)

    .dsection AS_ASMCDrawSpecialMarkerSection
    .dsection AS_ASMCDrawSpecialMarkerDataSection

    startFreespace

      .fill mapped($088000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $090000
  .logical mapped($090000)

    startDialogue

      .dsection Chapter06DialogueSection
      .dsection Chapter12DialogueSection
      .dsection Chapter12xDialogueSection
      .dsection Chapter14DialogueSection
      .dsection Chapter15DialogueSection
      .dsection Chapter20DialogueSection

    endDialogue

  .endlogical

  * := $097D45
  .logical mapped($097D45)

    startFreespace

      .fill mapped($090000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $098000
  .logical mapped($098000)

    startDialogue

      .dsection Chapter03DialogueSection
      .dsection Chapter05DialogueSection
      .dsection Chapter07DialogueSection
      .dsection Chapter08DialogueSection
      .dsection Chapter08xDialogueSection
      .dsection Chapter09DialogueSection

    endDialogue

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

    startDialogue

      .dsection Chapter01DialogueSection
      .dsection Chapter02DialogueSection
      .dsection Chapter02xDialogueSection
      .dsection Chapter04DialogueSection
      .dsection Chapter11DialogueSection
      .dsection Chapter21xDialogueSection

    endDialogue

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

    startEventScenes

      .dsection Chapter02xEventsSection
      .dsection Chapter08xEventsSection

    endEventScenes

  .endlogical

  * := $0BFB88
  .logical mapped($0BFB88)

    startFreespace

      .fill mapped($0B8000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0C0000
  .logical mapped($0C0000)

    startDialogue

      .dsection Chapter04xDialogueSection
      .dsection Chapter11xDialogueSection
      .dsection Chapter16ADialogueSection
      .dsection Chapter17ADialogueSection
      .dsection Chapter23DialogueSection

    endDialogue

  .endlogical

  * := $0C6C60
  .logical mapped($0C6C60)

    startFreespace

      .fill mapped($0C0000) + $8000 - *, $FF

    endFreespace

  .endlogical

  * := $0C81B4
  .logical mapped($0C81B4)

    startEventScenes

      .dsection Chapter02EventsSection
      .dsection Chapter04EventsSection
      .dsection Chapter05EventsSection
      .dsection Chapter06EventsSection
      .dsection Chapter07EventsSection
      .dsection Chapter08EventsSection

    endEventScenes

  .endlogical

  * = $0D37EF
  .logical mapped($0D37EF)

    .dsection ChapterTitleSection

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

  * := $182EBC
  .logical mapped($182EBC)

    startDialogue

      .dsection Chapter19DialogueSection
      .dsection Chapter21DialogueSection
      .dsection Chapter22DialogueSection
      .dsection Chapter24DialogueSection

    endDialogue

  .endlogical

  * := $18D508
  .logical mapped($18D508)

    startEventData

      .dsection Chapter09DataSection
      .dsection Chapter08xDataSection
      .dsection Chapter08DataSection
      .dsection Chapter07DataSection
      .dsection Chapter06DataSection
      .dsection Chapter05DataSection
      .dsection Chapter04xDataSection
      .dsection Chapter04DataSection
      .dsection Chapter03DataSection
      .dsection Chapter02xDataSection
      .dsection Chapter02DataSection
      .dsection Chapter01DataSection

    endEventData

  .endlogical

  * := $1CBFB0
  .logical mapped($1CBFB0)

    startDialogue

      .dsection Chapter13DialogueSection

    endDialogue

  .endlogical

  * := $204AFF
  .logical mapped($204AFF)

    .dsection BattleBackgroundBlock1Section

  .endlogical

  * := $208000
  .logical mapped($208000)

    .dsection BattleBackgroundBlock2Section

  .endlogical

  * := $210000
  .logical mapped($210000)

    .dsection BattleBackgroundBlock3Section

  .endlogical

  * := $218000
  .logical mapped($218000)

    .dsection BattleBackgroundBlock4Section

  .endlogical

  * := $220000
  .logical mapped($220000)

    .dsection BattleBackgroundBlock5Section

  .endlogical

  * := $228000
  .logical mapped($228000)

    .dsection BattleBackgroundBlock6Section

  .endlogical

  * := $230000
  .logical mapped($230000)

    .dsection BattleBackgroundBlock7Section

  .endlogical

  * := $2D3EF8
  .logical mapped($2D3EF8)

    startFreespace

      .fill mapped($2D5000) - *, $FF

    endFreespace

    startDialogue

      .dsection Chapter16BDialogueSection
      .dsection Chapter18DialogueSection

    endDialogue

  .endlogical

  * := $338BDF
  .logical mapped($338BDF)

    startDialogue

      .dsection Chapter10DialogueSection
      .dsection Chapter14xDialogueSection
      .dsection Chapter17BDialogueSection
      .dsection Chapter24xDialogueSection
      .dsection ChapterFinalDialogueSection

    endDialogue

    startEventScenes

      .dsection Chapter01WorldMapEventsSection
      .dsection Chapter02WorldMapEventsSection
      .dsection Chapter03WorldMapEventsSection
      .dsection Chapter04WorldMapEventsSection
      .dsection Chapter07WorldMapEventsSection
      .dsection Chapter08WorldMapEventsSection
      .dsection Chapter09WorldMapEventsSection

    endEventScenes

  .endlogical

  * := $354000
  .logical mapped($354000)

    .dsection PortraitPalettesSection

    ; TODO: put this into its own place

    startPalettes

      aDialogueBoxPalette .text ROM[$355E60:$355E80]

    endPalettes

    .dsection PortraitGraphicsBlock1Section

  .endlogical

  * := $358000
  .logical mapped($358000)

    .dsection PortraitGraphicsBlock2Section

  .endlogical

  * := $360000
  .logical mapped($360000)

    .dsection PortraitGraphicsBlock3Section

  .endlogical

  * := $368000
  .logical mapped($368000)

    .dsection PortraitGraphicsBlock4Section

  .endlogical

  * := $370000
  .logical mapped($370000)

    .dsection PortraitGraphicsBlock5Section

  .endlogical

  * := $378000
  .logical mapped($378000)

    .dsection PortraitGraphicsBlock6Section
    .dsection ChapterTilesetFadePaletteBlock1Section

  .endlogical

  * := $380000
  .logical mapped($380000)

    .dsection ChapterTilesetFadePaletteBlock2Section

  .endlogical

  * := $3E8000
  .logical mapped($3E8000)

    startEventScenes

      .dsection Chapter01EventsSection
      .dsection Chapter04xEventsSection

    endEventScenes

  .endlogical

; Add up disassembly byte counts

.include "SizeHelpersEnd.h"
