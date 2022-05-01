
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_AI :?= false
.if (!GUARD_FE5_AI)
  GUARD_FE5_AI := true

  ; Definitions

  .weak

    rlGetRandomNumber100                          :?= address($80B0E6)
    rlBlockFillWord                               :?= address($80B36C)
    rlSetupMovementDirectionArray                 :?= address($80E451)
    rlUnknown80E551                               :?= address($80E551)
    rlGetMapUnitsInRange                          :?= address($80E5CD)
    rlFillMapByWord                               :?= address($80E849)
    rlGetEffectiveMove                            :?= address($8387D5)
    rlFillMovementRangeMapByClass                 :?= address($838D28)
    rlGetMapTileIndexByCoords                     :?= address($838E76)
    rlGetMapCoordsByTileIndex                     :?= address($838E84)
    rlCopyCharacterDataToBufferByDeploymentNumber :?= address($83901C)
    rlCopyCharacterDataFromBuffer                 :?= address($839041)
    rlCopyExpandedCharacterDataBufferToBuffer     :?= address($83905C)
    rlCopyClassDataToBuffer                       :?= address($8393E0)
    rlCheckItemEquippable                         :?= address($83965E)
    rlRunRoutineForAllUnitsInAllegiance           :?= address($839825)
    rlRunRoutineForAllItemsInInventory            :?= address($83993C)
    rlRunRoutineForTilesIn1Range                  :?= address($839969)
    rlSetAllegianceToNPC                          :?= address($83A349)
    rlCheckIfMovePathIsBlocked                    :?= address($83A6BB)
    rlCopyItemDataToBuffer                        :?= address($83B00D)
    rlCheckIfAllegianceDoesNotMatchPhaseTarget    :?= address($83B34F)
    rlUnknown83CD3E                               :?= address($83CD3E)
    rlActionStructEnemyCombatSelection            :?= address($83CF4A)
    rlActionStructStaff                           :?= address($83E990)
    rlSetBerserkedUnitAIInfo                      :?= address($83F53B)
    rlUpdateItemDurability                        :?= address($83FA1E)
    rlAddBerserkedUnitsToAIList                   :?= address($83FA36)
    rlTestEventFlagSet                            :?= address($8C9BCA)
    rlRunChapterLocationEvents                    :?= address($8C9CBD)

    rsAIInteractionSetup                       :?= address($8D9F28)
    rsAIGetTargetsIn3TileRange                 :?= address($8DA53D)
    rsAIRunRoutineForAllTilesInMovementRange   :?= address($8DA7D5)
    rsAIRunRoutineForAllTilesBeforeAttackRange :?= address($8DA7FB)
    rsAIRunRoutineForAllTilesInAttackRange     :?= address($8DA821)
    rsAICheckIfTerrainIsInList                 :?= address($8DA869)
    rsAIRunRoutineForAllUnitsInAllegiance      :?= address($8DA8F9)
    rsAITryGetUnitEquippedWeaponRange          :?= address($8DAA7A)
    rsAIHandleNoncombatCycleActionAI           :?= address($8DAAC1)
    rlAIFillMovementRangeMapByClass            :?= address($8DABD1)
    rlAIGetTraversableTilesAndFillRangeMap     :?= address($8DAC21)
    rlAIFillRangeMap                           :?= address($8DAC45)
    rsAIFillMovementMapWithAttackRange         :?= address($8DACE1)
    rsAIUnknown8DAD49                          :?= address($8DAD49)
    rlAIAddToCharacterBufferField              :?= address($8DAEAE)
    rsAIGetUnitHPPercentage                    :?= address($8DAEDC)
    rsAIGetPathableTilesAtTile                 :?= address($8DAF65)
    rsAIGetPathableTilesAtTileIgnoreOpponents  :?= address($8DAF8F)
    rlAITryFillThreatenedTileMap               :?= address($8DB0B2)
    rsAIFinishAllyInteraction                  :?= address($8DB312)
    rsAITryMove                                :?= address($8DB33B)
    rsAIGetSelectedUnitInfo                    :?= address($8DB409)
    rsAIRollAISkipChance                       :?= address($8DB6BA)
    rsAICheckStationaryAI                      :?= address($8DB81F)
    rsAITryGetCantoDistance                    :?= address($8DB831)
    rsAITryGetBetterPath                       :?= address($8DB84F)
    rsAICanUnitOpenChests                      :?= address($8DB88C)
    rsAIIsUnitAsleepOrPetrified                :?= address($8DB8F7)
    rsAITryObtainNewWeapon                     :?= address($8DBDB3)
    rsAIGetUnitItemProperties                  :?= address($8DBEBF)
    rsAITryFlee                                :?= address($8DC07E)
    rsAITryGetUsableStaff                      :?= address($8DC7BD)
    rsAIRunRoutineForOpposingAllegiances       :?= address($8DD307)
    rsAITryGetUsableItem                       :?= address($8DD876)
    rsAIActionUseItem                          :?= address($8DDAEB)
    rsAITryGetAdjacentInteractions             :?= address($8DDB1C)

    MovementMax :?= $71 ; TODO: figure out why this is the max

    ; For wAIActionCapabilityBitfield

      AI_ACUnlock    = bits($0001)
      AI_ACCapture   = bits($0002)
      AI_ACWeapon    = bits($0004)
      AI_AC0008      = bits($0008)
      AI_ACPureWater = bits($0010)
      AI_ACLockpick  = bits($0020)
      AI_ACDoorKey   = bits($0040)
      AI_ACChestKey  = bits($0080)

      AI_AC0100      = bits($0100)
      AI_AC0200      = bits($0200)
      AI_AC0400      = bits($0400)
      AI_AC0800      = bits($0800)
      AI_AC1000      = bits($1000)
      AI_AC2000      = bits($2000)
      AI_ACDoorKey2  = bits($4000)
      AI_AC8000      = bits($8000)

      AI_ACNormal = AI_ACUnlock | AI_ACCapture | AI_ACWeapon | AI_AC0008 | AI_ACPureWater | AI_ACLockpick | AI_ACDoorKey | AI_ACChestKey

    ; AI ignored character tables

      LeifAIIgnoreList := [Leif]
      Chapter18NPCAIIgnoreList := [Civilian9, Civilian10, Civilian11, Civilian12, Civilian13, Civilian14, Civilian15, Civilian16]
      Chapter19NPCAIIgnoreList := [Civilian2, Civilian4, Civilian5, Civilian11]
      OlwenAIIgnoreList := [Olwen]
      Chapter3NPCAIIgnoreList := [Romeo, Lucia, Cairpre, Hubert]
      DummyAIIgnoreList := []

      macroAIIgnoreList .macro IgnoreList
        .for _Character in \IgnoreList
          .word _Character
        .endfor
        .word 0
      .endmacro

    ; AI Action decisions

      AI_Action_Move      = $00
      AI_Action_Unknown02 = $02
      AI_Action_Unknown03 = $03
      AI_Action_Unknown06 = $06 ; Canto but path blocked, don't move camera?
      AI_Action_Dance     = $0D

    ; For coordinate tables used by
    ; rsAIASMCMoveToCoordinatesByChapter
    ; and rsAIASMCPatrolUntilAlerted

      Chapter1AISpecialCoordinateList = [(12, 6), (13, 10), (13, 16)]
      DummyAISpecialCoordinateList    = []

      macroAISpecialCoordinates .macro CoordinateList
        .if len(\CoordinateList) > 0
          _CoordsStart := * + (size(addr) * len(\CoordinateList))
          .for _Index in iter.enumerate(\CoordinateList)[:,0]
            .addr _CoordsStart + (size(addr) * _Index)
          .endfor
          .for _Coords in \CoordinateList
            .byte _Coords
          .endfor
        .else
          .word None
        .endif
      .endmacro

    ; For coordinate tables used by
    ; rsAIASMCPatrolUntilAlerted

      Chapter4AIPatrolCoordinateList  := [[(7, 13), (11, 13), (15, 13), (16, 16), (16, 20), (14, 22), (10, 22), (7, 21), (7, 17)]]
      Chapter4AIPatrolCoordinateList ..= [[(7, 22), (11, 22), (15, 22), (16, 19), (16, 15), (14, 13), (10, 13), (7, 14), (7, 18)]]
      Chapter4AIPatrolCoordinateList ..= [[(16, 13), (12, 13), (8, 13), (7, 16), (7, 20), (9, 22), (13, 22), (16, 21), (16, 17)]]
      Chapter4AIPatrolCoordinateList ..= [[(16, 22), (12, 22), (8, 22), (7, 19), (7, 15), (9, 13), (13, 13), (16, 14), (16, 18)]]

      Chapter6AIPatrolCoordinateList  := [[(12, 16), (16, 16)]]
      Chapter6AIPatrolCoordinateList ..= [[(18, 19), (22, 19)]]
      Chapter6AIPatrolCoordinateList ..= [[(12, 22), (16, 22)]]

      Chapter9AIPatrolCoordinateList  := [[(14, 13)]]
      Chapter9AIPatrolCoordinateList ..= [[(16, 13)]]
      Chapter9AIPatrolCoordinateList ..= [[(15, 14)]]
      Chapter9AIPatrolCoordinateList ..= [[(14, 15)]]
      Chapter9AIPatrolCoordinateList ..= [[(16, 15)]]

      macroAIPatrolCoordinates .macro CoordinateList
        _CoordsStart := * + (size(addr) * len(\CoordinateList))
        _Pos := 0
        .for _Table in \CoordinateList
          .addr _CoordsStart + _Pos
          _Pos += ((2 * size(byte)) * len(_Table)) + size(byte)
        .endfor
        .for _Table in \CoordinateList
          .for _Coords in _Table
            .byte _Coords
          .endfor
          .byte None
        .endfor
      .endmacro

    ; aThreatenedTileMap tile map stuff
    ; TODO: move this to its own file.

      Threat_ArmorEffective   = bits($20)
      Threat_FlyingEffective  = bits($40)
      Threat_CavalryEffective = bits($80)

      Threat_AllEffective = Threat_ArmorEffective | Threat_FlyingEffective | Threat_CavalryEffective

      ; Format is (RecoveryThreshold, RecoveredThreshold) where
      ; RecoveryThreshold is the HP percentage units will request healing below and
      ; RecoveredThreshold is the HP percentage units will stop requesting healing
      ; at or above.

      RecoveryThresholdList := [(30, 80), (10, 60), (50, 100), (0, 100), (70, 100)]

      ChestTerrainList := [TerrainIndoorChest, TerrainOutdoorChest]

  .virtual $8D8D50

    rsAI_ACTION_AI_TARGET_Handler ; 8D/8D50

      .fill $8D8D71 - *

      _Continue

  .endvirtual

  .virtual $8D975C

    rsAI_MOVEMENT_AI_MOVE_TO_UNITS_Handler ; 8D/975C

      .fill $8D9773 - *

      _TargetUnit

      .fill $8D97A1 - *

      _TargetTile

  .endvirtual

  .endweak

    ; Freespace inclusions

      .section AIMainSection

        rsAIDoAICycle ; 8D/8000

          .autsiz
          .databank ?

          ; Executes an AI engine cycle.

          ; Tries to loop through all units, determining how
          ; they should act.

          ; The first cycle type is a utility cycle, it handles
          ; checking for the end of units, berserked units,
          ; and advances which unit is being handled.

          ; The second cycle type handles noncombat actions
          ; like trying to be healed, retreating, trading, etc.

          ; The third cycle type handles actions like combat.

          ; The fourth cycle type handles movement.

          ; The fifth cycle type loops back to the first.

          ; The sixth cycle type handles if a unit should canto.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          rep #$30

          lda @l wEventEngineStatus
          bne _End

          lda wAIEngineStatus
          bne _End

          lda wAIEngineCycleType
          beq _End

            dec a
            asl a

            tax
            lda _AIEngineCycleRoutines,x
            sta wR0

            phb
            php

            sep #$20

            lda #`wAIEngineStackPointer
            pha

            rep #$20

            plb

            .databank `wAIEngineStackPointer

            tsc
            sta @l wAIEngineStackPointer

            jmp (wR0)

          _AIEngineCycleRoutines .include "../TABLES/AIEngineCycles.csv.asm" ; 8D/802F

          _End
          rtl

          _EndCycle

          .databank ?

          rep #$30

          lda wAIEngineStackPointer
          tcs

          plp
          plb

          rtl

          .databank 0

        rlAIEngineMainCycle ; 8D/8046

          .al
          .xl
          .autsiz
          .databank `wAIEngineStackPointer

          ; Gets a unit for determining AI actions.

          ; Inputs:
          ; None

          ; Outputs:
          ; wAIEngineCycleType: next AI cycle

          lda #(`aAISelectedUnitInfo)<<8
          sta lR18+size(byte)
          lda #<>aAISelectedUnitInfo
          sta lR18
          lda #size(aAISelectedUnitInfo)
          sta lR19
          lda #0
          jsl rlBlockFillWord

          stz wAIEngineStatus

          ; Keep just the lower bitfield byte?
          ; Has attacks, items.

          lda wAIActionCapabilityBitfield
          and #AI_ACNormal
          sta wAIActionCapabilityBitfield

          ldx aAIMainVariables.wCurrentDeploymentListIndex

          ; Ensure at least one unit before filling the
          ; threatened tile map.

          lda aAIMainVariables.aDeploymentList,x
          and #$00FF
          beq _EndOfUnitList

          jsl rlAITryFillThreatenedTileMap

          _Loop

            ; Try to get the next unit that can act.
            ; If we find a valid unit, we can move on to the next
            ; cycle.

            ldx aAIMainVariables.wCurrentDeploymentListIndex

            lda aAIMainVariables.aDeploymentList,x
            and #$00FF
            beq _EndOfUnitList

            cmp #$00FF
            beq _Special

              sta wAIEngineCycleDeploymentNumber

              sta wR0
              lda #<>aSelectedCharacterBuffer
              sta wR1
              jsl rlCopyCharacterDataToBufferByDeploymentNumber

              lda aSelectedCharacterBuffer.UnitState,b
              bit #(UnitStateDead | UnitStateRescued | UnitStateHidden | UnitStateGrayed)
              bne _Next

              jsr rsAIIsUnitAsleepOrPetrified
              bcs _Next

                lda wAIAllegianceHasBerserkedUnitFlag
                bne _BerserkedUnits

                  jsr rsAIGetUnitItemProperties

                  inc wAIEngineCycleType
                  jmp rsAIDoAICycle._EndCycle

          _Next
          inc aAIMainVariables.wCurrentDeploymentListIndex
          bra _Loop

          _EndOfUnitList

          ; If any units are berserked, re-add them
          ; to the end of the list and try again.

          lda wAIAllegianceHasBerserkedUnitFlag
          bne +

          jsl rlAddBerserkedUnitsToAIList

          lda aAIMainVariables.wCurrentDeploymentListIndex
          beq +

            jsl rlSetBerserkedUnitAIInfo

            lda #AIMainCycle
            sta wAIEngineCycleType
            jmp rsAIDoAICycle._EndCycle

          +
          stz wAIEngineCycleType
          jmp rsAIDoAICycle._EndCycle

          _Special

          ldx aAIMainVariables.wTempDeploymentNumber

          sep #$20

          lda #0
          sta aAIMainVariables.aDeploymentList,x

          rep #$20

          stz aAIMainVariables.wCurrentDeploymentListIndex

          bra _Loop

          _BerserkedUnits

          sep #$20

          lda wAIEngineCycleDeploymentNumber
          sta aAISelectedUnitInfo.bDeploymentNumber

          lda aSelectedCharacterBuffer.X,b
          sta aAISelectedUnitInfo.bStartXCoordinate

          lda aSelectedCharacterBuffer.Y,b
          sta aAISelectedUnitInfo.bStartYCoordinate

          rep #$20

          lda #AIActionCycle
          sta wAIEngineCycleType
          jmp rsAIDoAICycle._EndCycle

          .databank 0

        rlAIEngineNoncombatCycle ; 8D/8106

          .al
          .xl
          .autsiz
          .databank `wAIEngineStackPointer

          ; Mostly recovery mode checks.

          ; Inputs:
          ; None

          ; Outputs:
          ; wAIEngineCycleType: next AI cycle

          stz wAILeastThreatenedTileThreatCount
          stz wAIThreatMask

          jsr rsAIGetSelectedUnitInfo
          jsr rsAICheckStationaryAI

          lda #<>aSelectedCharacterBuffer
          sta wR3
          jsr rsAITryUpdateRecoveryMode
          bcc _NotRecovery

            ; Try to use a healing item. If they
            ; don't have one, try to flee. If they
            ; can't flee, try to select a place to go to
            ; that will heal them. Otherwise, see if
            ; they need a new weapon and try to obtain one.

            jsr rsAITryUseHealingItem
            bcs +

            jsr rsAITryFlee
            bcs +

            jsr rsAITryMovingToHealerOrHealingTile
            bcs +

            jsr rsAITryObtainNewWeapon
            bra +

          _NotRecovery

            ; Try to flee, if they need to. Otherwise,
            ; try to get a new weapon, if they need one.

            jsr rsAITryFlee
            bcs +

            jsr rsAITryObtainNewWeapon

          +

          ; Bits 0-3 of the unit's AI properties
          ; select a percent chance for the unit to have
          ; an AI action. Otherwise, the unit gets skipped.

          jsr rsAIRollAISkipChance
          bcc +

            lda #AINextCycle - 1
            sta wAIEngineCycleType

          +
          inc wAIEngineCycleType

          jmp rsAIDoAICycle._EndCycle

          .databank 0

        rlAIEngineActionCycle ; 8D/8149

          .al
          .xl
          .autsiz
          .databank `wAIEngineStackPointer

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; None

          stz aAIMainVariables.aTemp._Vars[0]
          stz wAIStationaryFlag
          stz wUnknown7E404B
          stz wAICycleScriptCounter

          lda aSelectedCharacterBuffer.UnitState,b
          and #UnitStateGrayed
          bne _SkipUnit

          lda wAIAllegianceHasBerserkedUnitFlag
          bne _BerserkedOrAIOutOfBounds

          _Loop

            lda #<>aActionAIScriptPointerTable
            sta wR3

            lda aSelectedCharacterBuffer.ActionAIOffset,b
            and #$00FF
            sta wR2

            lda aSelectedCharacterBuffer.ActionAI,b
            and #$00FF
            cmp #(size(aActionAIScriptPointerTable) / size(addr))
            bge _BerserkedOrAIOutOfBounds

              ; Fetch an opcode and run its handler.

              jsr rsAIReadScriptOpcode

              inc wAICycleScriptCounter
              stz aAIMainVariables.wScriptContinueFlag

              lda aAIMainVariables.aCurrentScriptCommand.wOpcode
              and #$00FF
              asl a
              tax
              jsr (_aActionAICodeTable,x)

              lda aAIMainVariables.wScriptContinueFlag
              beq _NextCycle

                lda wAICycleScriptCounter
                cmp #50
                blt _Loop

                  bra _NextCycle

          _SkipUnit

          inc aAIMainVariables.wCurrentDeploymentListIndex
          stz wAIEngineCycleType

          _NextCycle
          inc wAIEngineCycleType
          jmp rsAIDoAICycle._EndCycle

          _BerserkedOrAIOutOfBounds

          ; A either contains wAIAllegianceHasBerserkedUnitFlag
          ; or aSelectedCharacterBuffer.ActionAI if >= 26?

          ; Try to use items?

          lda #$00FF
          sta wAILeastThreatenedTileThreatCount
          jsr rsAI_ACTION_AI_TARGET_Handler._Continue
          bra _NextCycle

          _aActionAICodeTable .include "../TABLES/ActionAICodePointers.csv.asm" ; 8D/81B4

          .databank 0

        rlAIEngineMovementCycle ; 8D/81CC

          .al
          .xl
          .autsiz
          .databank `wAIEngineStackPointer

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; None

          stz aAIMainVariables.aTemp._Vars[0]
          stz wAIStationaryFlag
          stz wAICycleScriptCounter

          lda aSelectedCharacterBuffer.UnitState,b
          and #UnitStateGrayed
          bne _SkipUnit

          lda wAIAllegianceHasBerserkedUnitFlag
          bne _BerserkedOrAIOutOfBounds

          _Loop

            inc wAICycleScriptCounter
            stz wAIConsiderRecoveryModeFlag

            lda #<>aMovementAIScriptPointerTable
            sta wR3

            lda aSelectedCharacterBuffer.MovementAIOffset,b
            and #$00FF
            sta wR2

            lda aSelectedCharacterBuffer.MovementAI,b
            and #$00FF
            cmp #(size(aMovementAIScriptPointerTable) / size(addr))
            bge _BerserkedOrAIOutOfBounds

              jsr rsAIReadScriptOpcode

              stz aAIMainVariables.wScriptContinueFlag

              lda aAIMainVariables.aCurrentScriptCommand.wOpcode
              and #$00FF
              asl a
              tax
              jsr (_aMovementAICodeTable,x)

              lda aAIMainVariables.wScriptContinueFlag
              beq _NextCycle

                lda wAICycleScriptCounter
                cmp #50
                blt _Loop

                  bra _NextCycle

          _SkipUnit
          inc aAIMainVariables.wCurrentDeploymentListIndex
          stz wAIEngineCycleType

          _NextCycle
          jsr rsAIFinishAllyInteraction
          inc wAIEngineCycleType
          jmp rsAIDoAICycle._EndCycle

          _BerserkedOrAIOutOfBounds
          jsr rsAI_MOVEMENT_AI_MOVE_TO_UNITS_Handler._TargetUnit
          bra _NextCycle

          _aMovementAICodeTable .include "../TABLES/MovementAICodePointers.csv.asm" ; 8D/8234

          .databank 0

        rlAIEngineNextCycle ; 8D/8258

          .al
          .xl
          .autsiz
          .databank `wAIEngineStackPointer

          inc aAIMainVariables.wCurrentDeploymentListIndex

          lda #AIMainCycle
          sta wAIEngineCycleType

          jmp rsAIDoAICycle._EndCycle

          .databank 0

        rlAIEngineCantoCycle ; 8D/8264

          .al
          .xl
          .autsiz
          .databank `wAIEngineStackPointer

          jsl rlAITryCanto
          bcs _NoCanto

          -
          lda #AIMainCycle
          sta wAIEngineCycleType
          jmp rsAIDoAICycle._EndCycle

          _NoCanto

          lda aSelectedCharacterBuffer.UnitState,b
          ora #UnitStateGrayed
          sta aSelectedCharacterBuffer.UnitState,b

          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataFromBuffer

          inc aAIMainVariables.wCurrentDeploymentListIndex

          lda #4
          sta wUnknown000E27,b

          lda #1
          sta wAIEngineStatus

          bra -

          .databank 0

      .endsection AIMainSection

      .section AIRecoveryThresholdSection

        rsAIGetRecoveryThreshold ; 8D/8296

          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`aAIRecoveryThresholdTable
          pha

          rep #$20

          plb

          .databank `aAIRecoveryThresholdTable

          lda wR2
          and #AI_RecoveryThresholdIndex
          asl a
          tax

          lda aAIRecoveryThresholdTable,x
          and #$00FF
          sta aAIMainVariables.aCurrentScriptCommand.aParameters[1]

          lda aAIRecoveryThresholdTable+size(byte),x
          and #$00FF
          sta aAIMainVariables.aCurrentScriptCommand.aParameters[2]

          ; This is a mistake: the priority gets stored to an
          ; open bus region. Oops.

          lda aSelectedCharacterBuffer.AIProperties,b
          and #AI_PrioritySetting
          sta <>wAIUnitPriority,b

          plp
          plb
          rts

          .databank 0

      .endsection AIRecoveryThresholdSection

      .section AIReadScriptOpcodeSection

        rsAIReadScriptOpcode ; 8D/82C7

          .xl
          .autsiz
          .databank ?

          ; Reads a single AI script command.

          ; Inputs:
          ; A: AI setting index
          ; wR2: current offset into AI script
          ; wR3: short pointer to opcode pointer table
          ;   in bank $8F

          ; Outputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with command

          sta wAITemp7E401B

          phb
          php

          sep #$20

          lda #`aActionAIScriptPointerTable
          pha

          rep #$20

          plb

          .databank `aActionAIScriptPointerTable

          jsr rsAIClearScriptOpcodeParameters

          ; This is used as a mask to determine if
          ; the unit's AI should consider threat when
          ; making decisions. If the unit is flagged as
          ; special, do not consider threat.

          ldx #0

          lda wAITemp7E401B
          bit #AI_ConsiderThreat
          bne +

            dec x

          +
          txa
          sta wAIThreatMask

          ; Fetch a pointer to the AI script, use
          ; the unit's current script offset to fetch a
          ; command.

          lda wAITemp7E401B
          and #narrow(~AI_ConsiderThreat, 1)
          asl a
          tay
          lda (wR3),y

          clc
          adc wR2
          tax

          sep #$20

          lda 0,b,x
          sta aAIMainVariables.aCurrentScriptCommand.wOpcode

          rep #$20

          lda 1,b,x
          sta aAIMainVariables.aCurrentScriptCommand.aParameters[0]

          sep #$20

          .for _Index, _Param in iter.enumerate(aAIMainVariables.aCurrentScriptCommand.aParameters[1:], 3)

            lda _Index,b,x
            sta _Param

          .endfor

          plp
          plb
          rts

          .databank 0

        rsAIClearScriptOpcodeParameters ; 8D/832C

          .al
          .autsiz
          .databank `aActionAIScriptPointerTable

          ; Clears the parameters of
          ; aAIMainVariables.aCurrentScriptCommand

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #0

          .for _Parameter in aAIMainVariables.aCurrentScriptCommand.aParameters

            sta _Parameter

          .endfor

          rts

          .databank 0

      .endsection AIReadScriptOpcodeSection

      .section AICopyMapsSection

        rlAICopyMovementMapToRangeMap ; 8D/8344

          .autsiz
          .databank `aAIMainVariables

          ; Copies the movement map to the range map.

          ; Inputs:
          ; aMovementMap: filled with movement

          ; Outputs:
          ; aRangeMap: filled with movement

          php

          rep #$30

          ldx #0

          lda aMovementMap,x
          sta aRangeMap,x

          ldx wMapTileCount,b

          -
          lda aMovementMap,x
          sta aRangeMap,x

          dec x
          dec x
          bpl -

          plp

          rtl

          .databank 0

        rlAICopyRangeMapToMovementMap ; 8D/835F

          .autsiz
          .databank `aAIMainVariables

          ; Copies the range map to the movement map.

          ; Inputs:
          ; aMovementMap: filled with range

          ; Outputs:
          ; aRangeMap: filled with range

          php

          rep #$30

          ldx #0

          lda aRangeMap,x
          sta aMovementMap,x

          ldx wMapTileCount,b

          -
          lda aRangeMap,x
          sta aMovementMap,x

          dec x
          dec x
          bpl -

          plp

          rtl

          .databank 0

        rlAICombineRangeAndMovementMaps ; 8D/837A

          .autsiz
          .databank `aAIMainVariables

          ; Fills the movement map with a combined map
          ; where tiles in attack range but outside
          ; movement range are -1, and tiles outside both
          ; are MovementMax.

          ; Inputs:
          ; aMovementMap: filled with movement
          ; aRangeMap: filled with range

          ; Outputs:
          ; aMovementMap: filled with combined map

          php

          sep #$20

          ldx wMapTileCount,b

          -
          lda aMovementMap,x
          bpl _Store

          lda aRangeMap,x
          beq +

          lda #MovementMax
          bra _Store

          +
          lda #-1

          _Store
          sta aMovementMap,x

          dec x
          bpl -

          plp
          rtl

          .databank 0

      .endsection AICopyMapsSection

      .section AIStaffEffectSection

        rlAIDoStaffEffect ; 8D/8398

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Handles what happens when an AI-controlled unit
          ; uses a staff.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with caster
          ; aAISelectedUnitInfo: filled with unit info
          ;   .aDecisionParameters[0]: target deployment number
          ;   .aDecisionParameters[1]: offset of staff in inventory
          ;   .aDecisionParameters[2]: X coordinate
          ;   .aDecisionParameters[3]: Y coordinate

          ; Outputs:
          ; None

          lda #<>aSelectedCharacterBuffer
          sta wR0
          lda #<>aActionStructUnit1
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBuffer

          lda aAISelectedUnitInfo.aDecisionParameters[1]
          and #$00FF
          sta wStaffInventoryOffset

          tax
          lda aSelectedCharacterBuffer.Items,b,x

          and #$00FF
          beq +

          sec
          sbc #Heal
          asl a
          tax
          jsr (_StaffEffectPointers,x)

          +
          rtl

          _StaffEffectPointers .binclude "../TABLES/AIStaffEffectPointerTable.csv.asm" ; 8D/83C2

          .databank 0

        rsAIDummyStaffEffect ; 8D/83EC

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with caster
          ; aActionStructUnit1: filled with caster
          ; aAISelectedUnitInfo: filled with unit info
          ;   .aDecisionParameters[0]: target deployment number
          ;   .aDecisionParameters[1]: offset of staff in inventory
          ;   .aDecisionParameters[2]: X coordinate
          ;   .aDecisionParameters[3]: Y coordinate

          ; Outputs:
          ; None

          rts

          .databank 0

        rsAIStatusStaffEffect ; 8D/83ED

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with caster
          ; aActionStructUnit1: filled with caster
          ; aAISelectedUnitInfo: filled with unit info
          ;   .aDecisionParameters[0]: target deployment number
          ;   .aDecisionParameters[1]: offset of staff in inventory
          ;   .aDecisionParameters[2]: X coordinate
          ;   .aDecisionParameters[3]: Y coordinate

          ; Outputs:
          ; None

          lda aAISelectedUnitInfo.aDecisionParameters[0]
          and #$00FF
          sta wR0

          lda #<>aActionStructUnit2
          sta wR1

          jsl rlCopyCharacterDataToBufferByDeploymentNumber
          jsl rlActionStructStaff

          lda #<>aActionStructUnit2
          sta wR1
          jsl rlCopyCharacterDataFromBuffer

          jsl rlUnknown83CD3E

          rts

          .databank 0

        rsAIHealingStaffEffect ; 8D/8410

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with caster
          ; aActionStructUnit1: filled with caster
          ; aAISelectedUnitInfo: filled with unit info
          ;   .aDecisionParameters[0]: target deployment number
          ;   .aDecisionParameters[1]: offset of staff in inventory
          ;   .aDecisionParameters[2]: X coordinate
          ;   .aDecisionParameters[3]: Y coordinate

          ; Outputs:
          ; None

          lda aAISelectedUnitInfo.aDecisionParameters[0]
          and #$00FF
          sta wR0

          lda #<>aActionStructUnit2
          sta wR1
          jsl rlCopyCharacterDataToBufferByDeploymentNumber
          jsl rlActionStructStaff

          lda wStaffHitCounter
          beq +

            lda #<>aActionStructUnit2
            sta wR3
            jsr rsAITryUpdateRecoveryMode

          +
          lda #<>aActionStructUnit2
          sta wR1
          jsl rlCopyCharacterDataFromBuffer

          jsl rlUnknown83CD3E

          rts

          .databank 0

        rsAIWarpStaffEffect ; 8D/8440

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with caster
          ; aActionStructUnit1: filled with caster
          ; aAISelectedUnitInfo: filled with unit info
          ;   .aDecisionParameters[0]: target deployment number
          ;   .aDecisionParameters[1]: offset of staff in inventory
          ;   .aDecisionParameters[2]: X coordinate
          ;   .aDecisionParameters[3]: Y coordinate

          ; Outputs:
          ; None

          lda aAISelectedUnitInfo.aDecisionParameters[0]
          and #$00FF
          sta wR0

          lda #<>aActionStructUnit2
          sta wR1
          jsl rlCopyCharacterDataToBufferByDeploymentNumber

          sep #$20

          lda aAISelectedUnitInfo.aDecisionParameters[2]
          sta wActiveTileUnitParameter1

          lda aAISelectedUnitInfo.aDecisionParameters[3]
          sta wActiveTileUnitParameter2

          rep #$20

          jsl rlActionStructStaff

          lda wStaffHitCounter
          beq +

            ldx #<>aActionStructUnit2
            jsr rsAIAppendDeploymentList

          +
          lda #<>aActionStructUnit2
          sta wR1
          jsl rlCopyCharacterDataFromBuffer
          jsl rlUnknown83CD3E

          rts

          .databank 0

        rsAIRewarpStaffEffect ; 8D/847E

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with caster
          ; aActionStructUnit1: filled with caster
          ; aAISelectedUnitInfo: filled with unit info
          ;   .aDecisionParameters[0]: target deployment number
          ;   .aDecisionParameters[1]: offset of staff in inventory
          ;   .aDecisionParameters[2]: X coordinate
          ;   .aDecisionParameters[3]: Y coordinate

          ; Outputs:
          ; None

          lda #<>aSelectedCharacterBuffer
          sta wR0
          lda #<>aActionStructUnit2
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBuffer

          sep #$20

          lda aAISelectedUnitInfo.aDecisionParameters[2]
          sta wActiveTileUnitParameter1
          sta aAISelectedUnitInfo.bDestinationXCoordinate

          lda aAISelectedUnitInfo.aDecisionParameters[3]
          sta wActiveTileUnitParameter2
          sta aAISelectedUnitInfo.bDestinationYCoordinate

          rep #$20

          jsl rlActionStructStaff

          lda #<>aActionStructUnit2
          sta wR1
          jsl rlCopyCharacterDataFromBuffer
          jsl rlUnknown83CD3E

          rts

          .databank 0

        rsAIFortifyStaffEffect ; 8D/84B4

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with caster
          ; aActionStructUnit1: filled with caster
          ; aAISelectedUnitInfo: filled with unit info
          ;   .aDecisionParameters[0]: target deployment number
          ;   .aDecisionParameters[1]: offset of staff in inventory
          ;   .aDecisionParameters[2]: X coordinate
          ;   .aDecisionParameters[3]: Y coordinate

          ; Outputs:
          ; None

          jsl rlActionStructStaff
          lda wStaffHitCounter
          beq +

            jsr rsAITryUpdateAllRecoveryModeInCurrentAllegiance

          +
          lda #<>aActionStructUnit1
          sta wR1
          jsl rlCopyCharacterDataFromBuffer
          jsl rlUnknown83CD3E
          rts

          .databank 0

        rsAIItemStaffEffect ; 8D/84CE

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with caster
          ; aActionStructUnit1: filled with caster
          ; aAISelectedUnitInfo: filled with unit info
          ;   .aDecisionParameters[0]: target deployment number
          ;   .aDecisionParameters[1]: offset of staff in inventory
          ;   .aDecisionParameters[2]: X coordinate
          ;   .aDecisionParameters[3]: Y coordinate

          ; Outputs:
          ; None

          lda aAISelectedUnitInfo.aDecisionParameters[0]
          and #$00FF
          sta wR0

          lda #<>aActionStructUnit2
          sta wR1

          jsl rlCopyCharacterDataToBufferByDeploymentNumber

          sep #$20

          lda aAISelectedUnitInfo.aDecisionParameters[2]
          sta wActiveTileUnitParameter1

          rep #$20

          jsl rlActionStructStaff

          lda #<>aActionStructUnit2
          sta wR1
          jsl rlCopyCharacterDataFromBuffer
          jsl rlUnknown83CD3E

          rts

          .databank 0

        rsAIUnlockStaffEffect ; 8D/84FB

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with caster
          ; aActionStructUnit1: filled with caster
          ; aAISelectedUnitInfo: filled with unit info
          ;   .aDecisionParameters[0]: target deployment number
          ;   .aDecisionParameters[1]: offset of staff in inventory
          ;   .aDecisionParameters[2]: X coordinate
          ;   .aDecisionParameters[3]: Y coordinate

          ; Outputs:
          ; None

          sep #$20

          lda aAISelectedUnitInfo.aDecisionParameters[2]
          sta wActiveTileUnitParameter1

          lda aAISelectedUnitInfo.aDecisionParameters[3]
          sta wActiveTileUnitParameter2

          rep #$20

          jsl rlActionStructStaff

          lda #<>aActionStructUnit1
          sta wR1
          jsl rlCopyCharacterDataFromBuffer
          jsl rlUnknown83CD3E

          rts

          .databank 0

      .endsection AIStaffEffectSection

      .section AILootTileEffectSection

        rlAILootTileEffect ; 8D/851D

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          ; Handles what happens when an AI-controlled unit
          ; loots a tile.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit
          ; aAISelectedUnitInfo: filled with unit info
          ;   .aDecisionParameters[0]: unknown

          ; Outputs:
          ; None

          lda #-1
          sta wAITemp7E400A

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          jsl rlGetMapTileIndexByCoords

          tax
          lda aTerrainMap,x
          and #$00FF

          cmp #TerrainChurch
          beq _Continue

          cmp #TerrainVillage
          beq _Continue

          cmp #TerrainHouse
          beq _Continue

          cmp #TerrainIndoorChest
          beq _Chest

          cmp #TerrainOutdoorChest
          beq _Chest

          lda #<>rlAILootTileEffectUnknownFilter
          sta lR25
          lda #>`rlAILootTileEffectUnknownFilter
          sta lR25+size(byte)
          jsl rlRunRoutineForTilesIn1Range

          ldx wAITemp7E400A
          bmi _End

          bra _Continue

          _Chest
          jsr rsAICanUnitOpenChests
          bcs _End

          lda aSelectedCharacterBuffer.Items,b,y
          jsl rlCopyItemDataToBuffer
          jsl rlUpdateItemDurability

          _Continue
          txa
          jsl rlGetMapCoordsByTileIndex

          lda wR0
          sta wCursorXCoord,b
          lda wR1
          sta wCursorYCoord,b
          jsl rlRunChapterLocationEvents

          lda aAISelectedUnitInfo.aDecisionParameters[0]
          and #$00FF
          sta wR0

          and #$00FF
          beq _End

          lda aSelectedCharacterBuffer.ActionMisc,b
          and #$00FF
          sta wR1

          and #AI_CoordinateIndex
          lsr a
          lsr a
          lsr a
          inc a
          cmp wR0
          beq +

          asl a
          asl a
          asl a
          ora wR1
          sta wR1

          sep #$20

          lda wR1
          sta aSelectedCharacterBuffer.ActionMisc,b

          rep #$20

          bra _End

          .al
          .autsiz

          ; This is a hack to get the size of this script command.
          ; At least, I think this is the right value for the lda ahead.

          .virtual #1,s

            _Dummy MOVEMENT_AI_MOVE_TO_INTERACTABLE_TERRAIN ?, ?

          .endvirtual

          +
          lda #size(_Dummy)
          sta wR0
          ldx #structCharacterDataRAM.MovementAIOffset
          jsl rlAIAddToCharacterBufferField

          _End
          rtl

          .databank 0

        rlAILootTileEffectUnknownFilter ; 8D/85CE

          .autsiz
          .databank `aTerrainMap

          php

          sep #$20

          lda aTerrainMap,x

          cmp #TerrainBreakableWall
          bne +

          stx wAITemp7E400A

          +
          plp
          rtl

          .databank 0

      .endsection AILootTileEffectSection

      .section AIRequestHealingInRecoveryModeSection

        rsAIRequestHealingInRecoveryMode ; 8D/85DD

          .al
          .autsiz
          .databank `aUnitMap

          ; Sets the unit at a tile to request healing.

          ; Inputs:
          ; X: tile index
          ; aUnitMap: filled with range

          ; Outputs:
          ; None

          lda aUnitMap,x
          and #$00FF
          beq _End

            sta wR0

            lda #<>aTemporaryActionStruct
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aTemporaryActionStruct.ActionMisc,b
            bit #AI_RecoveryFlag
            bne _End

              lda aTemporaryActionStruct.AIProperties,b
              ora #AI_RequestAllyInteraction
              sta aTemporaryActionStruct.AIProperties,b

              lda #<>aTemporaryActionStruct
              sta wR1
              jsl rlCopyCharacterDataFromBuffer

          _End
          rts

          .databank 0

      .endsection AIRequestHealingInRecoveryModeSection

      .section AITryUseHealingItemSection

        rsAITryUseHealingItem ; 8D/860B

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Tries to use a healing item.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; None

          lda #-1
          sta wAITemp7E4038

          lda #<>rlAITryUseHealingItemEffect
          sta lR25
          lda #>`rlAITryUseHealingItemEffect
          sta lR25+size(byte)
          lda #<>aSelectedCharacterBuffer.Items
          jsl rlRunRoutineForAllItemsInInventory

          lda wAITemp7E4038
          bmi +

            jsr rsAITryMoveAfterHealingItem
            sec
            rts

          +
          clc
          rts

          .databank 0

        rlAITryUseHealingItemEffect ; 8D/862E

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; A: item ID
          ; Y: item index in inventory
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; wAITemp7E4038: item index

          jsl rlCopyItemDataToBuffer

          lda aItemDataBuffer.Traits,b
          bit #(TraitWeapon | TraitStaff)
          beq +

            lda #<>aSelectedCharacterBuffer
            sta wR1
            jsl rlCheckItemEquippable
            bcc _End

          +
          lda aItemDataBuffer.UseEffect,b
          and #$00FF

          cmp #$0020 ; TODO: item use effects
          bne _End

            tya
            asl a
            sta wAITemp7E4038

          _End
          rtl

          .databank 0

        rsAITryMoveAfterHealingItem ; 8D/8656

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; None

          lda #0
          sta aAIMainVariables.aTemp._Vars[0]

          jsr rsAITryMove

          lda wAIEngineStatus
          bne +

            stz aAIMainVariables.wScriptContinueFlag
            stz aMovementDirectionArray

            lda #1
            sta wAIEngineStatus

            sep #$20

            lda aSelectedCharacterBuffer.X,b
            sta aAISelectedUnitInfo.bDestinationXCoordinate
            lda aSelectedCharacterBuffer.Y,b
            sta aAISelectedUnitInfo.bDestinationYCoordinate

          +
          sep #$20

          lda #AI_Action_Unknown03
          sta aAISelectedUnitInfo.bActionDecision

          lda wAITemp7E4038
          sta aAISelectedUnitInfo.aDecisionParameters[0]

          rep #$20

          lda aSelectedCharacterBuffer.ActionMisc,b
          and #~AI_RecoveryFlag
          sta aSelectedCharacterBuffer.ActionMisc,b

          stz wRemainingMovement

          rts

          .databank 0

      .endsection AITryUseHealingItemSection

      .section AIUnknown8D869ASection

        rsAIUnknown8D869A ; 8D/869A

          .al
          .autsiz
          .databank `aAIMainVariables

          lda wAIStationaryFlag
          beq _UseMovement

            lda #0
            bra +

          _UseMovement
          lda #<>aSelectedCharacterBuffer
          sta wR14
          jsl rlGetEffectiveMove

          +
          sta wR2

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          sta wR3
          lda #-1
          sta wR4
          lda aSelectedCharacterBuffer.Skills1,b
          sta wR5
          jsl rlFillMovementRangeMapByClass
          jsl rlAICopyMovementMapToRangeMap

          lda #-1
          sta wAITemp7E4010
          sta wAITemp7E400C
          sta aAIMainVariables.wTargetArrayOffset
          sta wAITemp7E4008

          jsr rsAIUnknown8D86F7

          ldx wAITemp7E400C
          bmi +

            jsr rsAIUnknown8D87A6

          +
          stz aAIMainVariables.wTargetArrayOffset
          rts

          .databank 0

        rsAIUnknown8D86F7 ; 8D/86F7

          .al
          .autsiz
          .databank `aAIMainVariables

          lda #(`rsAIUnknown8D86F7Effect)<<8
          sta lR25+size(byte)
          lda #<>rsAIUnknown8D86F7Effect
          sta lR25

          lda wCurrentPhase,b
          jsr rsAIRunRoutineForAllUnitsInAllegiance

          lda wAIEngineCycleDeploymentNumber
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataToBufferByDeploymentNumber

          rts

          .databank 0

        rsAIUnknown8D86F7Effect ; 8D/8716

          .al
          .autsiz
          .databank `aAIMainVariables

          lda aSelectedCharacterBuffer.ActionMisc,b
          bit #AI_RecoveryFlag
          beq _End

          lda aItemDataBuffer.Range,b
          and #$00FF
          beq _End

            pha

            lda #(`aMovementMap)<<8
            sta lR18+size(byte)
            lda #<>aMovementMap
            sta lR18
            lda #$0000
            jsl rlFillMapByWord

            lda aSelectedCharacterBuffer.X,b
            and #$00FF
            sta wR0
            lda aSelectedCharacterBuffer.Y,b
            and #$00FF
            sta wR1

            pla

            ldx #<>aMovementMap
            stx wR3

            jsl rlGetMapUnitsInRange

            lda #(`rsAIUnknown8D86F7Effect2)<<8
            sta lR24+size(byte)
            lda #<>rsAIUnknown8D86F7Effect2
            sta lR24
            jsr rsAIRunRoutineForAllTilesBeforeAttackRange

          _End
          rts

          .databank 0

        rsAIUnknown8D86F7Effect2 ; 8D/8760

          .al
          .autsiz
          .databank `aAIMainVariables

          php

          lda aMovementMap,x
          beq _End

          rep #$20

          lda aThreatenedTileMap,x
          and #$001F
          cmp wAITemp7E4010
          beq +
          bge _End

            sta wAITemp7E4010

          +
          lda aSelectedCharacterBuffer.CurrentHP,b
          and #$00FF
          cmp aAIMainVariables.wTargetArrayOffset
          beq +
          bge _End

            sta aAIMainVariables.wTargetArrayOffset

          +
          lda aRangeMap,x
          and #$00FF
          cmp wAITemp7E4008
          beq +
          bcs _End

            sta wAITemp7E4008

          +
          stx wAITemp7E400C

          lda aSelectedCharacterBuffer.DeploymentNumber,b
          and #$00FF
          sta wAITemp7E400A

          _End
          plp
          rts

          .databank 0

        rsAIUnknown8D87A6 ; 8D/87A6

          .al
          .autsiz
          .databank `aAIMainVariables

          lda wAIStationaryFlag
          beq _UseMovement

            lda #0
            bra +

          _UseMovement
            lda #<>aSelectedCharacterBuffer
            sta wR14
            jsl rlGetEffectiveMove

          +
          sta wR2
          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          sta wR3
          lda #$FFFF
          sta wR4
          lda aSelectedCharacterBuffer.Skills1,b
          sta wR5
          jsl rlFillMovementRangeMapByClass

          lda #AI_Action_Unknown02
          and #$00FF
          sta aAISelectedUnitInfo.bActionDecision

          lda wAITemp7E400A
          and #$00FF
          sta aAISelectedUnitInfo.aDecisionParameters[0]

          lda wAITemp7E4021
          sta aAISelectedUnitInfo.aDecisionParameters[1]

          lda wAITemp7E400C
          jsl rlGetMapCoordsByTileIndex

          lda wR0
          sta wAITemp7E4034
          lda wR1
          sta wAITemp7E4036
          jsl rlSetupMovementDirectionArray

          sep #$20

          lda lR24
          sta aAISelectedUnitInfo.bDecisionDistance

          rep #$20

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          jsl rlCheckIfMovePathIsBlocked
          cmp #-1
          beq _PathBlocked

          sep #$20

          lda wAITemp7E4034
          sta aAISelectedUnitInfo.bDestinationXCoordinate

          lda wAITemp7E4036
          sta aAISelectedUnitInfo.bDestinationYCoordinate

          rep #$20

          bra +

          _PathBlocked
          sep #$20

          lda #AI_Action_Unknown06
          sta aAISelectedUnitInfo.bActionDecision

          lda wR0
          sta aAISelectedUnitInfo.bDestinationXCoordinate

          lda wR1
          sta aAISelectedUnitInfo.bDestinationYCoordinate

          rep #$20

          +
          lda #1
          sta wAIEngineStatus

          stz aAIMainVariables.wScriptContinueFlag

          rts

          .databank 0

      .endsection AIUnknown8D869ASection

      .section AIRecoveryModeSection

        rsAITryUpdateRecoveryMode ; 8D/885F

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          ; Updates a unit's recovery mode status and returns
          ; it.

          ; Inputs:
          ; wR3: short pointer to character buffer
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: Minimum HP threshold
          ;   .aParameters[2]: Maximum HP threshold

          ; Outputs:
          ; Carry set if in recovery mode, clear otherwise

          lda wR0
          pha

          ldx wR3

          lda structExpandedCharacterDataRAM.ActionMisc,b,x
          sta wR2

          jsr rsAIGetRecoveryThreshold
          jsr rsAIGetUnitHPPercentage

          lda wR2
          bit #AI_RecoveryFlag
          bne _InRecovery

            ; Check if we need to enter recovery mode.

            lda aAIMainVariables.aCurrentScriptCommand.aParameters[1]
            cmp wR13
            bmi _NotRecovery
            bra _EnterRecovery

          _InRecovery

            ; Already in recovery mode, check if we
            ; need to exit.

            lda wR13
            cmp aAIMainVariables.aCurrentScriptCommand.aParameters[2]
            bmi _Recovery
            bra _ExitRecovery

          _ExitRecovery

            ldx wR3
            lda structExpandedCharacterDataRAM.ActionMisc,b,x
            and #~AI_RecoveryFlag
            sta structExpandedCharacterDataRAM.ActionMisc,b,x

            lda #<>aSelectedCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataFromBuffer

          _NotRecovery

          pla
          sta wR0

          clc
          rts

          _EnterRecovery

            ldx wR3
            lda structExpandedCharacterDataRAM.ActionMisc,b,x
            ora #AI_RecoveryFlag
            sta structExpandedCharacterDataRAM.ActionMisc,b,x

            lda #<>aSelectedCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataFromBuffer

          _Recovery

          pla
          sta wR0

          sec
          rts

          .databank 0

        rsAITryMovingToHealerOrHealingTile ; 8D/88BA

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          ; Tries to find a tile to stand on to be healed.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; aAISelectedUnitInfo: filled with decision

          ldx #<>aSelectedCharacterBuffer
          jsl rlAIFillMovementRangeMapByClass

          lda #-1
          sta wAITemp7E4008
          sta wAITemp7E400A
          sta wAICurrentBestTarget

          lda #<>rsAITryMovingToHealerOrHealingTileFilter
          sta lR24
          lda #>`rsAITryMovingToHealerOrHealingTileFilter
          sta lR24+size(byte)
          jsr rsAIRunRoutineForAllTilesInMovementRange

          ldx wAITemp7E400A
          bmi _NotFound

            lda aSelectedCharacterBuffer.X,b
            and #$00FF
            sta wR0
            lda aSelectedCharacterBuffer.Y,b
            and #$00FF
            sta wR1
            jsl rlGetMapTileIndexByCoords

            ; Skip this if the unit is already on the best tile.

            cmp wAITemp7E400A
            beq _OnTargetTile

              jsr rsAIRequestHealingInRecoveryMode

              lda wAITemp7E400A
              jsl rlGetMapCoordsByTileIndex

              sep #$20

              lda #AI_Action_Move
              sta aAISelectedUnitInfo.bActionDecision

              rep #$20

              stz aAIMainVariables.wScriptContinueFlag

              jsr rsAIApproachTile

          _Found
          sec
          rts

          _NotFound
          clc
          rts

          _OnTargetTile
          lda #AIMovementCycle
          sta wAIEngineCycleType
          bra _Found

          .databank 0

        rsAITryMovingToHealerOrHealingTileFilter ; 8D/891D

          .as
          .autsiz
          .databank `aAIMainVariables

          ; Filtering routine for rsAITryMovingToHealerOrHealingTile

          ; Inputs:
          ; X: tile index to check
          ; aSelectedCharacterBuffer: unit requesting healing
          ; wAITemp7E4008: current best healer
          ; wAITemp7E400A: current best tile index (of healer or tile)
          ; wAICurrentBestTarget: current best opponent count

          ; Outputs:
          ; wAITemp7E4008: current best healer
          ; wAITemp7E400A: current best tile index (of healer or tile)
          ; wAICurrentBestTarget: current best opponent count

          php

          lda aTerrainMap,x
          cmp #TerrainFort
          bne _CheckUnit

          lda aUnitMap,x
          beq _Found

          cmp aSelectedCharacterBuffer.DeploymentNumber,b
          beq _Found

          jsl rlCheckIfAllegianceDoesNotMatchPhaseTarget
          bcs _CheckUnit

            rep #$30

            lda aUnitMap,x
            and #$00FF
            sta wR0
            lda #<>aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            sep #$20

            lda aTargetingCharacterBuffer.MovementAI,b
            cmp #MovementAI_Stationary
            bne _Found

              bra _CheckTargetForStaff

          .as
          .autsiz

          _CheckUnit

          lda aUnitMap,x
          beq _End

          cmp aSelectedCharacterBuffer.DeploymentNumber,b
          beq _End

            rep #$30

            and #$00FF
            sta wR0
            lda #<>aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

          _CheckTargetForStaff

          rep #$30

          lda aTargetingCharacterBuffer.AIProperties,b
          bit #AI_Has1RangeHealingStaff
          beq _End

          _Found

          sep #$20

          lda aMovementMap,x
          cmp wAITemp7E4008
          bpl _End

            rep #$30

            jsr rsAIGetTargetsIn3TileRange
            lda wAITemp7E4010
            and #$00FF

            cmp wAICurrentBestTarget
            bge _End

              sta wAICurrentBestTarget

              lda aMovementMap,x
              and #$00FF
              sta wAITemp7E4008
              stx wAITemp7E400A

          _End
          plp
          rts

          .databank 0

        rsAITryUpdateAllRecoveryModeInCurrentAllegiance ; 8D/89A2

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Tries to update recovery mode for all units in
          ; the current allegiance.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #<>rlAITryUpdateAllRecoveryModeInCurrentAllegianceEffect
          sta lR25
          lda #>`rlAITryUpdateAllRecoveryModeInCurrentAllegianceEffect
          sta lR25+size(byte)

          lda wCurrentPhase,b
          inc a

          jsl rlRunRoutineForAllUnitsInAllegiance
          rts

          .databank 0

        rlAITryUpdateAllRecoveryModeInCurrentAllegianceEffect

          .al
          .autsiz
          .databank `aAIMainVariables

          lda #<>aTargetingCharacterBuffer
          sta wR3
          jsr rsAITryUpdateRecoveryMode
          rtl

          .databank 0

      .endsection AIRecoveryModeSection

      .section AITryCantoSection

        rlAITryCanto ; 8D/9A4F

          .al
          .autsiz
          .databank `aAIMainVariables

          jsr rsAIGetCantoRangeAndMovementMap

          lda aSelectedCharacterBuffer.Class,b
          jsl rlCopyClassDataToBuffer

          lda #-1
          sta wAITemp7E400C

          stz wAITemp7E4008
          stz wAITemp7E401B
          stz wAITemp7E401F

          ; Prioritize unthreatened > defense > avoid.

          lda #<>rsAIFindUnthreatenedCantoTile
          sta lR24
          lda #>`rsAIFindUnthreatenedCantoTile
          sta lR24+size(byte)
          jsr rsAIRunRoutineForAllTilesInMovementRange

          lda wAITemp7E400C
          bpl _FoundTile

          lda #-1
          sta wAITemp7E4008

          lda #<>rsAIFindHighestDefenseCantoTile
          sta lR24
          lda #>`rsAIFindHighestDefenseCantoTile
          sta lR24+size(byte)
          jsr rsAIRunRoutineForAllTilesInMovementRange

          lda wAITemp7E400C
          bpl _FoundTile

          lda #-1
          sta wAITemp7E4008

          lda #<>rsAIFindHighestAvoidCantoTile
          sta lR24
          lda #>`rsAIFindHighestAvoidCantoTile
          sta lR24+size(byte)
          jsr rsAIRunRoutineForAllTilesInMovementRange

          lda wAITemp7E400C
          bmi +

          _FoundTile
          jsr rsAISetCantoAction
          clc
          rtl

          +
          sec
          rtl

          .databank 0

        rsAIFindUnthreatenedCantoTile ; 8D/9AB1

          .as
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; X: tile index
          ; aSelectedCharacterBuffer: filled with unit
          ; wAITemp7E4008: current longest distance
          ; wAITemp7E400C: current best tile index

          ; Outputs:
          ; wAITemp7E4008: current longest distance
          ; wAITemp7E400C: current best tile index

          lda aUnitMap,x
          beq +

          cmp aSelectedCharacterBuffer.DeploymentNumber,b
          bne _End

          +
          cpx wAITemp7E401D
          bne _NotStartingTile

            lda aSelectedCharacterBuffer.ActionAI,b
            cmp #ActionAI_AmaldaGroup
            bne +

              lda #0
              bra _Set

            +
            lda aThreatenedTileMap,x
            bne _End

              lda #0
              bra _Set

          _NotStartingTile

            lda aThreatenedTileMap,x
            bne _End

            lda aMovementMap,x
            cmp wAITemp7E4008
            blt _End

          _Set
            sta wAITemp7E4008
            stx wAITemp7E400C

          _End
          rts

          .databank 0

        rsAIFindHighestDefenseCantoTile ; 8D/9AE8

          .as
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; X: tile index
          ; aSelectedCharacterBuffer: filled with unit
          ; wAITemp7E4008: current longest distance
          ; wAITemp7E400C: current best tile index
          ; wAITemp7E401B: current best defense

          ; Outputs:
          ; wAITemp7E4008: current longest distance
          ; wAITemp7E400C: current best tile index
          ; wAITemp7E401B: current best defense

          lda aUnitMap,x
          beq +

          cmp aSelectedCharacterBuffer.DeploymentNumber,b
          bne _End

          +
          lda aRangeMap,x
          cmp wAITemp7E4008
          bge _End

            ldy #<>aClassDataBuffer.TerrainDefensePointer
            jsr rsAIGetCantoTerrainStat

            cpy wAITemp7E401B
            blt _End

              lda aRangeMap,x
              sta wAITemp7E4008
              stx wAITemp7E400C
              sty wAITemp7E401B

          _End
          rts

          .databank 0

        rsAIFindHighestAvoidCantoTile ; 8D/9B12

          .as
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; X: tile index
          ; aSelectedCharacterBuffer: filled with unit
          ; wAITemp7E4008: current longest distance
          ; wAITemp7E400C: current best tile index
          ; wAITemp7E401F: current best avoid

          ; Outputs:
          ; wAITemp7E4008: current longest distance
          ; wAITemp7E400C: current best tile index
          ; wAITemp7E401F: current best avoid

          lda aUnitMap,x
          beq +

          cmp aSelectedCharacterBuffer.DeploymentNumber,b
          bne _End

          +
          lda aRangeMap,x
          cmp wAITemp7E4008
          bge _End

            ldy #<>aClassDataBuffer.TerrainAvoidPointer
            jsr rsAIGetCantoTerrainStat

            cpy wAITemp7E401F
            blt _End

              lda aRangeMap,x
              sta wAITemp7E4008
              stx wAITemp7E400C
              sty wAITemp7E401F

          _End
          rts

          .databank 0

        rsAICantoUnknown ; 8D/9B3C

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aAISelectedUnitInfo: filled with current unit info

          ; Outputs:
          ; aMovementMap: filled with unit's range

          lda aAISelectedUnitInfo.bStartXCoordinate
          and #$00FF
          sta wR0

          lda aAISelectedUnitInfo.bStartYCoordinate
          and #$00FF
          sta wR1

          jsl rlGetMapTileIndexByCoords
          sta wAITemp7E401D

          lda aAISelectedUnitInfo.bDestinationXCoordinate
          and #$00FF
          sta wR0

          lda aAISelectedUnitInfo.bDestinationYCoordinate
          and #$00FF
          sta wR1

          lda wRemainingMovement
          sta wR2

          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          sta wR3

          lda #-1
          sta wR4

          lda aSelectedCharacterBuffer.Skills1,b
          sta wR5

          jsl rlFillMovementRangeMapByClass

          rts

          .databank 0

        rsAIGetCantoRangeAndMovementMap ; 8D/9B7F

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aAISelectedUnitInfo: filled with current unit info

          ; Outputs:
          ; aMovementMap: filled with unit's range

          lda aAISelectedUnitInfo.bStartXCoordinate
          and #$00FF
          sta wR0

          lda aAISelectedUnitInfo.bStartYCoordinate
          and #$00FF
          sta wR1

          jsl rlGetMapTileIndexByCoords
          sta wAITemp7E401D

          lda #MovementMax - 1
          sta wR2

          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          sta wR3

          stz wR4

          lda aSelectedCharacterBuffer.Skills1,b
          sta wR5

          jsl rlFillMovementRangeMapByClass
          jsl rlAICopyMovementMapToRangeMap

          lda aAISelectedUnitInfo.bDestinationXCoordinate
          and #$00FF
          sta wR0

          lda aAISelectedUnitInfo.bDestinationYCoordinate
          and #$00FF
          sta wR1

          lda wRemainingMovement
          sta wR2

          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          sta wR3

          lda #-1
          sta wR4

          lda aSelectedCharacterBuffer.Skills1,b
          sta wR5

          jsl rlFillMovementRangeMapByClass

          rts

          .databank 0

        rsAISetCantoAction ; 8D/9BDE

          .autsiz
          .databank `aAIMainVariables

          ; Sets a unit to canto.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit
          ; wAITemp7E400C: target tile index

          ; Outputs:
          ; aAISelectedUnitInfo: filled with decision

          sep #$20

          lda aSelectedCharacterBuffer.X,b
          sta aAISelectedUnitInfo.bStartXCoordinate

          lda aSelectedCharacterBuffer.Y,b
          sta aAISelectedUnitInfo.bStartYCoordinate

          rep #$20

          lda wAITemp7E400C
          jsl rlGetMapCoordsByTileIndex

          lda wR0
          sta wAITemp7E4034

          lda wR1
          sta wAITemp7E4036

          jsl rlSetupMovementDirectionArray

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0

          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1

          jsl rlCheckIfMovePathIsBlocked
          cmp #-1
          beq _PathBlocked

            ; Otherwise path is clear

            sep #$20

            lda #AI_Action_Move
            sta aAISelectedUnitInfo.bActionDecision

            lda wAITemp7E4034
            sta aAISelectedUnitInfo.bDestinationXCoordinate

            lda wAITemp7E4036
            sta aAISelectedUnitInfo.bDestinationYCoordinate

            rep #$20

            bra _End

          .al
          .autsiz

          _PathBlocked

            sep #$20

            lda #AI_Action_Unknown06
            sta aAISelectedUnitInfo.bActionDecision

            lda wR0
            sta aAISelectedUnitInfo.bDestinationXCoordinate

            lda wR1
            sta aAISelectedUnitInfo.bDestinationYCoordinate

            rep #$20

          .al
          .autsiz

          _End

          lda #1
          sta wAIEngineStatus
          rts

          .databank 0

        rsAIGetCantoTerrainStat ; 8D/9C4D

          .as
          .autsiz
          .databank `aAIMainVariables

          ; Given a pointer to a class's terrain bonuses
          ; for either defense or avoid, get the bonus for
          ; the tile the unit is on.

          ; Inputs:
          ; X: tile index
          ; Y: short pointer to class terrain bonuses

          ; Outputs:
          ; Y: terrain bonus

          ; No idea

          lda #$80
          sta lR18+size(byte)

          sty lR18

          lda aTerrainMap,x
          tay

          lda [lR18],y

          rep #$20

          and #$00FF
          tay

          sep #$20

          rts

          .databank 0

      .endsection AITryCantoSection

      .section AIGetRandomTileInRangeSection

        rsAIGetRandomTileInRange ; 8D/9C62

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Tries to pick a random tile within range.
          ; As far as I can tell, this should always be successful.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; wR0: X coordinate of tile if selected
          ; wR1: Y coordinate of tile if selected
          ; Carry clear if tile selected, set otherwise

          stz wAITemp7E400A

          lda #-1
          sta wAITemp7E400C

          lda wAIStationaryFlag
          beq _UseMovement

            lda #0
            bra +

          _UseMovement
            lda #<>aSelectedCharacterBuffer
            sta wR14
            jsl rlGetEffectiveMove

          +
          sta wR2

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0

          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1

          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          sta wR3

          lda #-1
          sta wR4

          lda aSelectedCharacterBuffer.Skills1,b
          sta wR5

          jsl rlFillMovementRangeMapByClass

          lda #<>rsAIGetRandomTileInRangeFilter
          sta lR24
          lda #>`rsAIGetRandomTileInRangeFilter
          sta lR24+size(byte)
          jsr rsAIRunRoutineForAllTilesInMovementRange

          lda wAITemp7E400C
          bmi +

            jsl rlGetMapCoordsByTileIndex
            clc
            rts

          +
          sec
          rts

          .databank 0

        rsAIGetRandomTileInRangeFilter ; 8D/9CC0

          .as
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; X: tile index
          ; aSelectedCharacterBuffer: filled with unit
          ; wAITemp7E4008: current lowest RN
          ; wAITemp7E400C: current best tile index

          ; Outputs:
          ; wAITemp7E4008: current lowest RN
          ; wAITemp7E400C: current best tile index

          lda aUnitMap,x
          beq +

          cmp aSelectedCharacterBuffer.DeploymentNumber,b
          bne _End

          +
          rep #$20

          lda #100
          jsl rlGetRandomNumber100

          sep #$20

          cmp wAITemp7E400A
          blt _End

            sta wAITemp7E400A
            stx wAITemp7E400C

          _End
          rts

          .databank 0

      .endsection AIGetRandomTileInRangeSection

      .section AIMovementStarSection

        rlAIDeploymentListAppendMovementStarUnit ; 8D/9CE1

          .al
          .autsiz
          .databank `aAIMainVariables

          lda aSelectedCharacterBuffer.UnitState,b
          bit #UnitStateMovementStar
          beq _End

          ldx aAIMainVariables.wTempDeploymentNumber

          sep #$20

          lda aSelectedCharacterBuffer.DeploymentNumber,b
          sta aAIMainVariables.aDeploymentList,x

          inc aAIMainVariables.wTempDeploymentNumber

          ldx wAIAlternateDeploymentListIndex

          lda #-1
          sta aAIMainVariables.aDeploymentList,x

          rep #$30

          _End
          rtl

          .databank 0

      .endsection AIMovementStarSection

      .section AIUnknownGetLowThreatTileInRangeSection

        rsAIUnknownGetLowThreatTileInRange ; 8D/9D02

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; A: tile index

          ; Outputs:
          ; wAITemp7E4008: best threat
          ; wAITemp7E400C: best tile index

          tax
          lda aUnitMap,x
          and #$00FF
          sta wR0
          lda #<>aTargetingCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataToBufferByDeploymentNumber

          lda #<>aTargetingCharacterBuffer
          sta wR1
          jsr rsAITryGetUnitEquippedWeaponRange
          bcs _End

            clc
            adc #16
            sta wAITemp7E403A

            stz wR4
            lda #<>aTargetingCharacterBuffer
            sta wR14
            jsr rsAIFillMovementMapWithAttackRange

            ldx #<>aSelectedCharacterBuffer
            jsl rlAIFillRangeMap

            lda #-1
            sta wAITemp7E4008
            lda #<>rsAIUnknownGetLowThreatTileInRangeFilter
            sta lR24
            lda #>`rsAIUnknownGetLowThreatTileInRangeFilter
            sta lR24+size(byte)
            jsr rsAIRunRoutineForAllTilesInAttackRange

          _End
          rts

          .databank 0

        rsAIUnknownGetLowThreatTileInRangeFilter ; 8D/9D4A

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; X: tile index
          ; aSelectedCharacterBuffer: filled with unit
          ; wAITemp7E4008: current lowest threat
          ; wAITemp7E400C: current best tile index

          ; Outputs:
          ; wAITemp7E4008: current lowest threat
          ; wAITemp7E400C: current best tile index

          lda aRangeMap,x
          beq +

          lda aThreatenedTileMap,x
          and #$001F
          bne +

          lda aMovementMap,x
          cmp wAITemp7E4008
          bcs +

            sta wAITemp7E4008
            stx wAITemp7E400C

          +
          rts

          .databank 0

      .endsection AIUnknownGetLowThreatTileInRangeSection

      .section AIApproachTileSection

        rsAIApproachTile ; 8D/9D66

          .autsiz
          .databank `aAIMainVariables

          ; This is complicated and not well-understood.
          ; Tries to get the closest tile to a potential target
          ; and approaches it.

          ; Inputs:
          ; wR0: X coordinate of target
          ; wR1: Y coordinate of target
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; aAISelectedUnitInfo: filled with decision

          ; Get the pathable tiles from the target tile.

          sep #$20

          lda wR0
          sta aAISelectedUnitInfo.bDestinationXCoordinate

          lda wR1
          sta aAISelectedUnitInfo.bDestinationYCoordinate

          rep #$30

          jsr rsAIGetPathableTilesAtTile

          ; This loops up to twice:
          ; The first time, opponents will block the path
          ; and cause a failure, leading to the second loop
          ; where opponents are ignored.

          _Loop

            ; Copy the pathable tiles into the range map so
            ; we can fill the movement map with the unit's movement
            ; from their original tile.

            jsl rlAICopyMovementMapToRangeMap

            lda wAIStationaryFlag
            beq _UseMovement

              lda #0
              bra +

            _UseMovement
              lda #<>aSelectedCharacterBuffer
              sta wR14
              jsl rlGetEffectiveMove

            +
            sta wR2
            sta wAITemp7E4021

            lda aSelectedCharacterBuffer.X,b
            and #$00FF
            sta wR0
            lda aSelectedCharacterBuffer.Y,b
            and #$00FF
            sta wR1

            lda aSelectedCharacterBuffer.Class,b
            and #$00FF
            sta wR3

            lda #-1
            sta wR4

            lda aSelectedCharacterBuffer.Skills1,b
            sta wR5

            jsl rlFillMovementRangeMapByClass

            ; If the unit has a distance to go to their target,
            ; the range map tile they're on will be nonzero.

            lda aSelectedCharacterBuffer.X,b
            and #$00FF
            sta wR0
            lda aSelectedCharacterBuffer.Y,b
            and #$00FF
            sta wR1
            jsl rlGetMapTileIndexByCoords

            tax
            lda aRangeMap,x
            and #$00FF
            bne +

              ; At the tile, do nothing.

              jmp _End

            +

            jsr rsAIGetSafestTileNearTarget

            lda wAITemp7E400A
            bpl _FoundTile

            ; If we didn't get a path before, try again but
            ; ignoring opponents in the way.

            lda bAIPathCounter
            and #$00FF
            bne +

              jsr rsAIGetPathableTilesAtTileIgnoreOpponents
              bra _Loop

          +

          ; Otherwise, flag the current tile if it's
          ; in reach of the target.

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          jsl rlGetMapTileIndexByCoords

          tax
          lda aRangeMap,x
          and #$00FF

          cmp #narrow(-1, size(byte))
          bne +

            lda #2
            sta aAIMainVariables.aTemp._Vars[0]

            stz aAIMainVariables.wScriptContinueFlag

          +
          rts

          _FoundTile

          lda wAITemp7E400A
          jsl rlGetMapCoordsByTileIndex

          _SetApproach ; 8D/9E1F

          lda wR0
          sta wAITemp7E4034
          lda wR1
          sta wAITemp7E4036
          jsl rlSetupMovementDirectionArray

          sep #$20

          lda lR24
          sta aAISelectedUnitInfo.bDecisionDistance

          rep #$20

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          jsl rlCheckIfMovePathIsBlocked

          cmp #-1
          beq _PathBlocked

            jsr rsAITryGetBetterPath
            bcs _End

              ; Use destination coordinates.

              sep #$20

              lda wAITemp7E4034
              sta aAISelectedUnitInfo.bDestinationXCoordinate

              lda wAITemp7E4036
              sta aAISelectedUnitInfo.bDestinationYCoordinate

              rep #$20

              jsr rsAIHandleNoncombatCycleActionAI
              jsr rsAITryGetCantoDistance
              jsr rsAITryGetAdjacentInteractions
              bra +

          _PathBlocked

            ; Use unit's current coordinates.

            sep #$20

            lda #AI_Action_Unknown06
            sta aAISelectedUnitInfo.bActionDecision

            lda wR0
            sta aAISelectedUnitInfo.bDestinationXCoordinate

            lda wR1
            sta aAISelectedUnitInfo.bDestinationYCoordinate

            rep #$20

          +
          lda #1
          sta wAIEngineStatus

          _End

          stz aAIMainVariables.wScriptContinueFlag
          rts

          .databank 0

      .endsection AIApproachTileSection

      .section AIGetSafestTileNearTargetSection

        rsAIGetSafestTileNearTarget ; 8D/9E8C

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; wAITemp7E4008: safest tile range
          ; wAITemp7E400C: safest tile index

          lda #(`rsAIGetSafestTileNearTargetFilter)<<8
          sta lR24+size(byte)
          lda #<>rsAIGetSafestTileNearTargetFilter
          sta lR24

          lda #-1
          sta wAITemp7E400A
          sta wAITemp7E4008
          jsr rsAIRunRoutineForAllTilesInMovementRange

          rts

          .databank 0

        rsAIGetSafestTileNearTargetFilter ; 8D/9EA3

          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; X: tile index
          ; aSelectedCharacterBuffer: filled with unit
          ; wAITemp7E4008: current safest tile range
          ; wAITemp7E400C: current best tile index

          ; Outputs:
          ; wAITemp7E4008: current safest tile range
          ; wAITemp7E400C: current best tile index

          sep #$20

          lda aUnitMap,x
          beq +

          cmp aSelectedCharacterBuffer.DeploymentNumber,b
          bne _End

          +
          jsr rsAICheckIfTileIsLessThreatened
          bcs _End

          lda wAIStationaryFlag
          bne +

          lda wAIConsiderRecoveryModeFlag
          bne +

          jsr rlAICheckIfAdjacentMeleeOpponents
          bcs _End

          +
          lda aRangeMap,x
          cmp wAITemp7E4008
          bge _End

            sta wAITemp7E4008
            stx wAITemp7E400A

          _End
          rts

          .databank 0

        rlAICheckIfAdjacentMeleeOpponents ; 8D/9ED2

          .as
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; Carry set if any adjacent target has a melee-capable weapon,
          ;   otherwise carry clear

          php

          rep #$30

          lda lR24
          pha
          lda lR24+size(byte)
          pha

          phx

          stz wR5

          lda #<>rlAICheckIfAdjacentMeleeOpponentsEffect
          sta lR25
          lda #>`rlAICheckIfAdjacentMeleeOpponentsEffect
          sta lR25+size(byte)
          jsl rlRunRoutineForTilesIn1Range

          lda wR5
          bne +

          plx

          pla
          sta lR24+size(byte)
          pla
          sta lR24

          plp
          clc
          rts

          +
          plx

          pla
          sta lR24+size(byte)
          pla
          sta lR24

          plp
          sec
          rts

          .databank 0

        rlAICheckIfAdjacentMeleeOpponentsEffect ; 8D/9F04

          .al
          .autsiz
          .databank `aAIMainVariables

          ; If the opponent at a tile has a melee-capable weapon,
          ; update a running status.

          ; Inputs:
          ; X: tile index
          ; wR5: running status

          ; Outputs:
          ; wR5: running status

          lda aUnitMap,x
          and #$00FF
          beq _End

          jsl rlCheckIfAllegianceDoesNotMatchPhaseTarget
          bcc _End

          sta wR0

          lda #<>aTargetingCharacterBuffer
          sta wR1

          jsl rlCopyCharacterDataToBufferByDeploymentNumber

          lda aTargetingCharacterBuffer.PlayerProperties,b
          and #AI_HasMeleeWeapon
          ora wR5
          sta wR5

          _End
          rtl

          .databank 0

      .endsection AIGetSafestTileNearTargetSection

      .section AICheckIfUnitCanOpenChestsSection

        rsAICheckIfUnitCanOpenChests ; 8D/B88C

          .al
          .autsiz
          .databank ?

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; Carry clear if unit can open chests, else clear.

          ; Unit must have at least one free
          ; inventory slot.

          lda aSelectedCharacterBuffer.Item7ID,b
          bne _Unable

            ldy #0

            ; Check unit for chest keys or lockpicks+steal.

            _Loop

              lda aSelectedCharacterBuffer.Items,b,y
              beq _Unable

              and #$00FF
              cmp #ChestKey
              beq _Able

              cmp #Lockpick
              bne _Next

                lda aSelectedCharacterBuffer.Skills1,b
                bit #Skill1Steal
                bne _Able

            _Next

            inc y
            inc y

            cpy #size(structCharacterDataRAM.Items)
            bne _Loop

          _Unable
          sec
          rts

          _Able
          clc
          rts

          .databank 0

      .endsection AICheckIfUnitCanOpenChestsSection

      .section AICheckIfTileIsLessThreatenedSection

        rsAICheckIfTileIsLessThreatened ; 8D/BABC

          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; X: tile index
          ; wAILeastThreatenedTileThreatCount: current best threat

          ; Outputs:
          ; A: best threat
          ; Carry clear if tile has less threat or if current threat
          ;   is zero, otherwise carry set

          php

          sep #$20

          lda wAILeastThreatenedTileThreatCount
          beq +

            lda aThreatenedTileMap,x
            cmp wAILeastThreatenedTileThreatCount
            blt +

              plp
              sec
              rts

          +
          plp
          clc
          rts

          .databank 0

      .endsection AICheckIfTileIsLessThreatenedSection

      .section AIItemUseSection

        rsAICheckIfUsableItem ; 8D/D8A4

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Given an item ID, return if the AI can
          ; use the item.

          ; Inputs:
          ; A: item ID
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; wAITemp7E400A: PureWater, Antidote set this to the unit's current
          ;   tile index, other usabilities leave unchanged.
          ; Carry clear if able, set otherwise

          phx

          ; Items usable by the AI are ChestKey through
          ; Antidote, with some exceptions.

          cmp #MemberCard
          bge +

          sec
          sbc #ChestKey
          blt +

            asl a
            tax
            jsr (_ItemUsabilities,x)
            bcs +

              plx
              clc
              rts

          +
          plx
          sec
          rts

          _ItemUsabilities .block
            _ChestKey     .addr rsAIChestKeyUsability
            _DoorKey      .addr rsAIDoorKeyUsability
            _BridgeKey    .addr rsAIUnusableItem
            _Lockpick     .addr rsAILockpickUsability
            _StaminaDrink .addr rsAIUnusableItem
            _Vulnerary    .addr rsAIUnusableItem
            _PureWater    .addr rsAIPureWaterUsability
            _Torch        .addr rsAIUnusableItem
            _Antidote     .addr rsAIAntidoteUsability
            _MemberCard   .addr rsAIUnusableItem
          .endblock

          .databank 0

        rsAIUnusableItem ; 8D/D8D1

          .al
          .autsiz
          .databank `aAIMainVariables

          sec
          rts

          .databank 0

        rsAIChestKeyUsability ; 8D/D8D3

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Checks if an AI unit can use a chest key.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; wR0: X coordinate of chest if found
          ; wR1: Y coordinate of chest if found
          ; Carry clear if usable, set otherwise

          ; Unit must have a free item slot to open a chest.

          lda aSelectedCharacterBuffer.Item7ID,b
          bne _End

          ; Berserked units have a 50% chance to use an item.

          ldy wAIAllegianceHasBerserkedUnitFlag
          beq +

          lda #100
          jsl rlGetRandomNumber100

          cmp #50
          bpl _End

            bra ++

          +
          lda wAIActionCapabilityBitfield
          bit #AI_ACChestKey
          beq _End

          +
          jsr rsAIFindChestInMovementRange
          bcs _End

          inc aAIMainVariables.wScriptContinueFlag

          lda wAITemp7E400A
          pha

          jsr rsAIApproachTile

          pla
          sta wAITemp7E400A

          lda wAIEngineStatus
          beq _End

          clc
          rts

          _End
          sec
          rts

          .databank 0

        rsAIDoorKeyUsability ; 8D/D90F

          .al
          .autsiz
          .databank `aAIMainVariables

          ; See rsAIChestKeyUsability

          ldy wAIAllegianceHasBerserkedUnitFlag
          beq +

          lda #100
          jsl rlGetRandomNumber100

          cmp #50
          bpl _End

            bra ++

          +
          lda wAIActionCapabilityBitfield
          bit #AI_ACDoorKey2
          bne +

          bit #AI_ACDoorKey
          beq _End

          +
          jsr rsAITryGetClosestTileToDoor
          bcs _End

          inc aAIMainVariables.wScriptContinueFlag

          lda wAITemp7E400A
          pha

          jsr rsAIApproachTile

          pla
          sta wAITemp7E400A

          lda wAIEngineStatus
          beq _End

          clc
          rts

          _End
          sec
          rts

          .databank 0

        rsAILockpickUsability ; 8D/D94B

          .al
          .autsiz
          .databank `aAIMainVariables

          ; See rsAIChestKeyUsability

          ldy wAIAllegianceHasBerserkedUnitFlag
          beq +

          lda #100
          jsl rlGetRandomNumber100

          cmp #50
          bpl _End

            bra ++

          +
          lda wAIActionCapabilityBitfield
          bit #AI_ACLockpick
          beq _End

          +
          lda aSelectedCharacterBuffer.Skills1,b
          bit #Skill1Steal
          beq _End

          jsr rsAIFindChestInMovementRange
          bcc +

          jsr rsAITryGetClosestTileToDoor
          bcs _End

          +
          inc aAIMainVariables.wScriptContinueFlag

          lda wAITemp7E400A
          pha

          jsr rsAIApproachTile

          pla
          sta wAITemp7E400A

          lda wAIEngineStatus
          beq _End

          clc
          rts

          _End
          sec
          rts

          .databank 0

        rsAIPureWaterUsability ; 8D/D98F

          .al
          .autsiz
          .databank `aAIMainVariables

          ; See rsAIChestKeyUsability
          ; This overwrites wAITemp7E400A with the unit's current tile.

          ldy wAIAllegianceHasBerserkedUnitFlag
          beq +

          lda #100
          jsl rlGetRandomNumber100

          cmp #50
          bpl _End

            bra ++

          +
          lda wAIActionCapabilityBitfield
          bit #AI_ACPureWater
          beq _End

          +
          lda aSelectedCharacterBuffer.MagicBonus,b
          and #$00FF
          bne _End

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          jsl rlGetMapTileIndexByCoords
          pha

          jsr rsAIApproachTile

          pla
          sta wAITemp7E400A

          lda #1
          sta wAIEngineStatus

          stz aMovementDirectionArray

          clc
          rts

          _End
          sec
          rts

          .databank 0

        rsAIAntidoteUsability ; 8D/D9DB

          .al
          .autsiz
          .databank `aAIMainVariables

          ; See rsAIChestKeyUsability
          ; This overwrites wAITemp7E400A with the unit's current tile.

          ldy wAIAllegianceHasBerserkedUnitFlag
          beq +

          lda #100
          jsl rlGetRandomNumber100

          cmp #50
          bpl _End

            bra ++

          +
          bra _End

          +
          lda aSelectedCharacterBuffer.Status,b
          cmp #StatusPoison
          bne _End

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          jsl rlGetMapTileIndexByCoords
          pha

          jsr rsAIApproachTile

          pla
          sta wAITemp7E400A

          lda #1
          sta wAIEngineStatus

          stz aMovementDirectionArray

          clc
          rts

          _End
          sec
          rts

          .databank 0

        rsAIFindChestInMovementRange ; 8D/DA21

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          ; Tries to find the closest chest.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; wAITemp7E4008: terrain of tile if found
          ; wAITemp7E400A: tile index of tile if found
          ; wR0: X coordinate of tile if found
          ; wR1: Y coordinate of tile if found
          ; Carry clear if tile found, else set

          ldx #<>aSelectedCharacterBuffer
          jsl rlAIFillMovementRangeMapByClass

          lda #-1
          sta wAITemp7E4008
          sta wAITemp7E400A

          lda aSelectedCharacterBuffer.DeploymentNumber,b
          and #$00FF
          sta wR4

          stz wR5

          lda #(`_ChestTerrains)<<8
          sta lR25+size(byte)
          lda #<>_ChestTerrains
          sta lR25

          lda #(`rsAICheckIfTerrainIsInList)<<8
          sta lR24+size(byte)
          lda #<>rsAICheckIfTerrainIsInList
          sta lR24

          jsr rsAIRunRoutineForAllTilesInMovementRange

          lda wAITemp7E400A
          bmi +

            jsl rlGetMapCoordsByTileIndex
            clc
            rts

          +
          sec
          rts

          _ChestTerrains .byte ChestTerrainList, 0

          .databank 0

        rsAITryGetClosestTileToDoor ; 8D/DA62

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          jsl rlAIGetTraversableTilesAndFillRangeMap
          jsr rsAIGetDoorCoordsInMovementRange
          lda wAITemp7E400A
          bmi _End

            ldx #aSelectedCharacterBuffer
            jsl rlAIFillRangeMap

            ldx wAITemp7E400A

            lda #-1
            sta wAITemp7E4008
            sta wAITemp7E400A

            lda #<>rlAITryGetClosestTileToDoorEffect
            sta lR25
            lda #>`rlAITryGetClosestTileToDoorEffect
            sta lR25+1

            jsl rlRunRoutineForTilesIn1Range

            lda wAITemp7E400A
            bmi _End

              jsl rlGetMapCoordsByTileIndex
              clc
              rts

          _End
          sec
          rts

          .databank 0

        rlAITryGetClosestTileToDoorEffect ; 8D/DA9C

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          php
          sep #$20
          lda aMovementMap,x
          bmi _End

          lda aUnitMap,x
          beq +

          cmp aSelectedCharacterBuffer.DeploymentNumber,b
          bne _End

          +
          lda aMovementMap,x
          cmp wAITemp7E4008
          bcs _End

            sta wAITemp7E4008
            stx wAITemp7E400A

          _End
          plp
          rtl

          .databank 0

        rsAIGetDoorCoordsInMovementRange ; 8D/DABE





      .endsection AIItemUseSection

      .section AICountTargetsInRangeSection

        rsAIASMCCountTargetsInScaledAttackRange ; 8D/DCC6

          .al
          .autsiz
          .databank `wAITemp7E401B

          ; Counts all targetable units within a unit's
          ; attack range. Scales their range using the
          ; formula `ax + bx` where `x` is the range,
          ; `a` is an integer multiplier and
          ; `b` is one of `0`, `0.5`, or `0.375`. `b` is determined
          ; by the value passed in through
          ; aAIMainVariables.aCurrentScriptCommand.aParameters[2]:

          ; 0: `b` = 0
          ; 1: `b` = 0.375
          ; anything else: `b` = 0.5

          ; Inputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: `a` variable
          ;   .aParameters[2]: `b` variable

          ; Outputs:
          ; aAIMainVariables.Temp[0]: count

          ; Flag for checking attack range.

          lda #1
          sta wAITemp7E401D
          jsr rsAICountTargetsInScaledRange

          ; Inefficient array access for something
          ; known at assemble time?

          lda #0
          asl a
          tax

          lda wAITemp7E401B
          sta aAIMainVariables.aTemp,x

          rts

          .databank 0

        rsAIASMCCountTargetsInScaledMovementRange ; 8D/DCDB

          .al
          .autsiz
          .databank `wAITemp7E401B

          ; Counts all targetable units within a unit's
          ; movement range. Scales their range using the
          ; formula `ax + bx` where `x` is the range,
          ; `a` is an integer multiplier and
          ; `b` is one of `0`, `0.5`, or `0.375`. `b` is determined
          ; by the value passed in through
          ; aAIMainVariables.aCurrentScriptCommand.aParameters[2]:

          ; 0: `b` = 0
          ; 1: `b` = 0.375
          ; anything else: `b` = 0.5

          ; Inputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: `a` variable
          ;   .aParameters[2]: `b` variable

          ; Outputs:
          ; aAIMainVariables.aTemp._Vars[0]: count

          ; Flag for checking movement range.

          stz wAITemp7E401D
          jsr rsAICountTargetsInScaledRange

          ; Inefficient array access for something
          ; known at assemble time?

          lda #0
          asl a
          tax

          lda wAITemp7E401B
          sta aAIMainVariables.aTemp,x

          rts

          .databank 0

        rsAICountTargetsInScaledRange ; 8D/DCED

          .al
          .autsiz
          .databank `wAITemp7E401B

          ; Counts all targetable units within a unit's
          ; attack or movement range. Scales their range using the
          ; formula `ax + bx` where `x` is the range,
          ; `a` is an integer multiplier and
          ; `b` is one of `0`, `0.5`, or `0.375`. `b` is determined
          ; by the value passed in through
          ; aAIMainVariables.aCurrentScriptCommand.aParameters[2]:

          ; 0: `b` = 0
          ; 1: `b` = 0.375
          ; anything else: `b` = 0.5

          ; Inputs:
          ; wAITemp7E401D: nonzero if searching attack range,
          ;   zero if searching movement range
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: `a` variable
          ;   .aParameters[2]: `b` variable

          ; Outputs:
          ; wAITemp7E401B: count

          jsr rsAIScaleEffectiveRange
          jsr rsAICountTargetsInRange

          rts

          .databank 0

        rsAICountTargetsInRange ; 8D/DCF4

          .al
          .autsiz
          .databank `wAITemp7E401B

          ; Counts all targetable units within
          ; either attack or movement range.

          ; Inputs:
          ; wAITemp7E401D: nonzero if searching attack range,
          ;   zero if searching movement range
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; wAITemp7E401B: count

          stz wAITemp7E401B

          lda #(`rsAICountTargetsInRangeEffect)<<8
          sta lR24+size(byte)
          lda #<>rsAICountTargetsInRangeEffect
          sta lR24

          lda wAITemp7E401D
          beq +

            jsr rsAIRunRoutineForAllTilesInAttackRange
            bra ++

          +
          jsr rsAIRunRoutineForAllTilesInMovementRange

          +
          rts

          .databank 0

        rsAICountTargetsInRangeEffect ; 8D/DD0F

          .al
          .autsiz
          .databank `wAITemp7E401B

          ; Inputs:
          ; X: index into unit map
          ; wAITemp7E401B: running count
          ; wAITemp7E401D: nonzero if searching attack range,
          ;   zero if searching movement range
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; wAITemp7E401B: running count

          lda aUnitMap,x
          beq +

          cmp aSelectedCharacterBuffer.DeploymentNumber,b
          beq +

          jsl rlCheckIfAllegianceDoesNotMatchPhaseTarget
          bcc +

            inc wAITemp7E401B

          +
          rts

          .databank 0

        rsAIScaleEffectiveRange ; 8D/DD23

          .al
          .autsiz
          .databank `wAITemp7E401B

          ; Fills either the range or the movement
          ; map for a unit. Scales their range using the
          ; formula `ax + bx` where `x` is the range,
          ; `a` is an integer multiplier and
          ; `b` is one of `0`, `0.5`, or `0.375`. `b` is determined
          ; by the value passed in through
          ; aAIMainVariables.aCurrentScriptCommand.aParameters[2]:

          ; 0: `b` = 0
          ; 1: `b` = 0.375
          ; anything else: `b` = 0.5

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit
          ; wAITemp7E401D: nonzero if searching attack range,
          ;   zero if searching movement range
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: `a` variable
          ;   .aParameters[2]: `b` variable

          ; Outputs:
          ; Fills either aRangeMap or aMovementMap

          lda #<>aSelectedCharacterBuffer
          sta wR14

          jsl rlGetEffectiveMove
          sta wR3

          ; wR2 is our running total for effective range.

          stz wR2

          ; Multiply by a multiplier, if we have one.
          ; This is the `ax` part of the formula.

          ldx aAIMainVariables.aCurrentScriptCommand.aParameters[1]
          beq +

            -
            lda wR2
            clc
            adc wR3
            sta wR2

            dec x
            bne -

          +

          ; We act directly on the range in wR3 here
          ; because we don't need it again after this, having
          ; determined the first part of the formula.

          ; Scale range to either 0.5x or 0.375x depending
          ; on passed-in value.

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[2]
          beq +

            ; wR3 = 0.5 * range

            lsr wR3

            lda wR2
            clc
            adc wR3
            sta wR2

            lda aAIMainVariables.aCurrentScriptCommand.aParameters[2]
            cmp #1
            bne +

              ; wR3 = 0.125 * range
              ; Subtract this from the running total to get
              ; 0.375

              lsr wR3
              lsr wR3

              lda wR2
              sec
              sbc wR3
              sta wR2

          +
          lda wR2
          pha

          stz wR4

          lda wAITemp7E401D
          beq _MovementRange

          ; If the unit does not have a weapon equipped,
          ; use its movement range instead.

          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsr rsAITryGetUnitEquippedWeaponRange
          bcs _MovementRange

            ; Attack range

            sta wAITemp7E403A

            lda #<>aSelectedCharacterBuffer
            sta wR14

            pla
            jsr $8DACF1
            rts

          _MovementRange

          pla
          sta wR2

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1

          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          sta wR3

          lda aSelectedCharacterBuffer.Skills1,b
          sta wR5
          jsl rlFillMovementRangeMapByClass
          rts

          .databank 0

      .endsection AICountTargetsInRangeSection

      .section AICheckIfUnitInAreaSection

        rsAIASMCCheckIfUnitInArea ; 8D/DDA6

          .autsiz
          .databank `aAIMainVariables

          ; Given a rectangle [x_min, y_min, x_max, y_max], check
          ; if unit is within that rectangle.

          ; Inputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: X minimum
          ;   .aParameters[2]: Y maximum
          ;   .aParameters[3]: X minimum
          ;   .aParameters[4]: Y maximum

          ; Outputs:
          ; aAIMainVariables.aTemp._Vars[0]: 1 if in rectangle, unchanged otherwise

          php

          sep #$20

          ; Check against X bounds.

          lda aSelectedCharacterBuffer.X,b
          cmp aAIMainVariables.aCurrentScriptCommand.aParameters[1]
          bmi _End

          dec a

          cmp aAIMainVariables.aCurrentScriptCommand.aParameters[3]
          bpl _End

          ; Check against Y bounds.

          lda aSelectedCharacterBuffer.Y,b
          cmp aAIMainVariables.aCurrentScriptCommand.aParameters[2]
          bmi _End

          dec a

          cmp aAIMainVariables.aCurrentScriptCommand.aParameters[4]
          bpl _End

            rep #$30

            lda #1
            sta aAIMainVariables.aTemp._Vars[0]

          _End
          plp
          rts

          .databank 0

      .endsection AICheckIfUnitInAreaSection

      .section AICheckIfFlagSetSection

        rsAIASMCCheckIfFlagSet ; 8D/DDCF

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Checks if an event flag is set.

          ; Inputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: event flag

          ; Outputs:
          ; aAIMainVariables.aTemp._Vars[0]: 1 if set, 0 otherwise

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[1]
          jsl rlTestEventFlagSet
          bcs _Set

            ; Flag was unset

            lda #0
            asl a
            tax

            lda #0
            sta aAIMainVariables.aTemp,x
            bra _End

          _Set

            lda #0
            asl a
            tax

            lda #1
            sta aAIMainVariables.aTemp,x

          _End
          rts

          .databank 0

      .endsection AICheckIfFlagSetSection

      .section AIGetCurrentTurnSection

        rsAIASMCGetCurrentTurn ; 8D/DDF1

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Gets the current turn.

          ; Inputs:
          ; None

          ; Outputs:
          ; aAIMainVariables.aTemp._Vars[0]: turn

          ; Inefficient array access for something
          ; known at assemble time?

          lda #0
          asl a
          tax

          lda wCurrentTurn,b
          sta aAIMainVariables.aTemp,x

          rts

          .databank 0

      .endsection AIGetCurrentTurnSection

      .section AIPatrolSection

        rsAIASMCPatrolUntilAlerted ; 8D/DDFD

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Have a unit try to patrol until there
          ; are targets in their range.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; aAIMainVariables.aTemp._Vars[0]: number of targets in range

          jsr rsAITryGetUnitEquippedWeaponRange
          bcs +

            sta wAITemp7E403A

            stz wR4

            lda #<>aSelectedCharacterBuffer
            sta wR14
            jsr rsAIFillMovementMapWithAttackRange

            lda #1
            sta wAITemp7E401D
            jsr rsAICountTargetsInRange

            lda wAITemp7E401B
            bne _Continue

          +
            jsr rsApproachNextCoordinateIndex

          _Continue

          lda #0
          asl a
          tax

          lda wAITemp7E401B
          sta aAIMainVariables.aTemp,x

          rts

          .databank 0

        rsApproachNextCoordinateIndex ; 8D/DE2C

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Given a unit, try to have them move to
          ; the next patrol tile.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with current AI target

          ; Outputs:
          ; aAISelectedUnitInfo.bActionDecision: set to AI_Action_Move
          ;   if target tile selected, unchanged otherwise

          lda aSelectedCharacterBuffer.AIProperties,b
          and #AI_PropertySetting
          lsr a
          lsr a
          lsr a
          lsr a
          sta wR0

          lda aSelectedCharacterBuffer.ActionMisc,b
          and #AI_CoordinateIndex
          lsr a
          lsr a
          lsr a
          sta wR1

          jsr rsAIGetNextCoordinates
          bcs +

            sep #$20

            lda #AI_Action_Move
            sta aAISelectedUnitInfo.bActionDecision

            rep #$20

            jsr rsAIApproachTile

          +
          rts

          .databank 0

        rsAIGetNextCoordinates ; 8D/DE55

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          ; Gets the coordinates of the next partrol tile.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with current AI target

          ; Outputs:
          ; wR0: X coordinate if coordinate found
          ; wR1: Y coordinate if coordinate found
          ; Carry clear if coordinate found, else carry set.

          jsr rsAIIncrementCoordinateIndex

          lda #<>aAIChapterPatrolCoordinatePointers
          sta lR25
          lda #>`aAIChapterPatrolCoordinatePointers
          sta lR25+size(byte)

          ; Check if current chapter has a patrol table.

          lda wCurrentChapter,b
          asl a
          tay

          lda [lR25],y
          beq _NotFound

            ; Check if table is a dummy.

            sta lR25

            lda wR0
            asl a
            tay

            lda [lR25],y
            beq _NotFound

              sta lR25

              _Loop

              ; Get coordinates, looping at end of table.

              lda wR1
              asl a
              tay

              lda [lR25],y
              and #$00FF
              beq _Next

                sta wR0
                
                inc y
                lda [lR25],y
                and #$00FF
                sta wR1

                clc
                rts

          _NotFound
          sec
          rts

          _Next
          lda #-1
          sta wR1
          jsr rsAIIncrementCoordinateIndex
          bra _Loop

          .databank 0

        rsAIIncrementCoordinateIndex ; 8D/DE9A

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          ; Given a current coordinate index, set
          ; the counter to the next index.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with current AI target
          ; wR1: coordinate index

          ; Outputs:
          ; wR1: new coordinate index
          ; aSelectedCharacterBuffer.ActionMisc: Coordinate set

          lda wR0
          pha

          lda wR1
          inc a
          and #$000F
          sta wR1

          and #$000F
          asl a
          asl a
          asl a
          sta wR2

          lda aSelectedCharacterBuffer.ActionMisc,b
          and #~AI_CoordinateIndex
          ora wR2

          sep #$20

          sta aSelectedCharacterBuffer.ActionMisc,b

          rep #$20

          lda wR1
          pha

          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataFromBuffer

          pla
          sta wR1

          pla
          sta wR0

          rts

          .databank 0

      .endsection AIPatrolSection

      .section AIUpdateGroupAISection

        rsAIASMCUpdateMovementGroupAI ; 8D/DECF

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          ; Updates the AI of all units in an allegiance with
          ; the same movement AI to have new AI.

          ; Inputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: new ActionAI
          ;   .aParameters[2]: new Movement AI

          ; Outputs:
          ; None

          lda aSelectedCharacterBuffer.MovementAI,b
          and #$00FF
          sta wAITemp7E401B

          lda #<>rlAIASMCUpdateMovementGroupAIFilter
          sta lR25
          lda #>`rlAIASMCUpdateMovementGroupAIFilter
          sta lR25+size(byte)

          lda wCurrentPhase,b
          inc a

          jsl rlRunRoutineForAllUnitsInAllegiance

          sep #$20

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[1]
          sta aSelectedCharacterBuffer.ActionAI,b

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[2]
          sta aSelectedCharacterBuffer.MovementAI,b

          rep #$30

          stz aSelectedCharacterBuffer.ActionAIOffset,b

          lda aSelectedCharacterBuffer.AIProperties,b
          and #~AI_PropertySetting
          sta aSelectedCharacterBuffer.AIProperties,b

          ldx #<>aSelectedCharacterBuffer
          jsr rsAIAppendDeploymentList

          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataFromBuffer

          lda #AIItemCycle
          sta wAIEngineCycleType

          stz aAIMainVariables.wScriptContinueFlag

          rts

          .databank 0

        rlAIASMCUpdateMovementGroupAIFilter ; 8D/DF1F

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          ; Filtering routine for rsAIASMCUpdateMovementGroupAI

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with original unit
          ; aTargetingCharacterBuffer: filled with potential unit

          ; Outputs:
          ; None

          php

          ; Only living units have the same movement AI and
          ; aren't the original unit are affected.

          lda aTargetingCharacterBuffer.UnitState,b
          bit #(UnitStateDead | UnitStateHidden)
          bne _End

          sep #$20

          lda aTargetingCharacterBuffer.DeploymentNumber,b
          cmp aSelectedCharacterBuffer.DeploymentNumber,b
          beq _End

          rep #$30

          lda aTargetingCharacterBuffer.MovementAI,b
          and #$00FF
          cmp wAITemp7E401B
          bne _End

            sep #$20

            lda aAIMainVariables.aCurrentScriptCommand.aParameters[1]
            sta aTargetingCharacterBuffer.ActionAI,b

            lda aAIMainVariables.aCurrentScriptCommand.aParameters[2]
            sta aTargetingCharacterBuffer.MovementAI,b

            rep #$30

            stz aTargetingCharacterBuffer.ActionAIOffset,b

            lda aTargetingCharacterBuffer.AIProperties,b
            and #~AI_PropertySetting
            sta aTargetingCharacterBuffer.AIProperties,b

            ldx #<>aTargetingCharacterBuffer
            jsr rsAIAppendDeploymentList

            lda #<>aTargetingCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataFromBuffer

          _End
          plp
          rtl

          .databank 0

        rsAIAppendDeploymentList ; 8D/DF6C

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          ; Appends the target's deployment number
          ; to the end of the AI deployment list.

          ; Inputs:
          ; aTargetingCharacterBuffer: filled with unit

          ; Outputs:
          ; wAIAlternateDeploymentListIndex: incremented
          ; aAIMainVariables.aDeploymentList: deployment
          ;   number added to the end

          php

          lda wAIAllegianceHasBerserkedUnitFlag
          bne _End

          sep #$20

          lda aTargetingCharacterBuffer.UnitState,b
          bit #UnitStateGrayed
          bne _End

          ldy wAIAlternateDeploymentListIndex
          cpy #size(aAIMainVariables.aDeploymentList)-1
          bpl _End

          lda structExpandedCharacterDataRAM.Status,b,x

          .for _Status in [StatusSleep, StatusPetrify, StatusBerserk]

            cmp #_Status
            beq _End

          .endfor

            lda aAIMainVariables.aDeploymentList,y
            sta wR1

            lda structExpandedCharacterDataRAM.DeploymentNumber,b,x
            sta aAIMainVariables.aDeploymentList,y

            inc wAIAlternateDeploymentListIndex

            ldy wAIAlternateDeploymentListIndex
            lda wR1
            sta aAIMainVariables.aDeploymentList,y

          _End
          plp
          rts

          .databank 0

      .endsection AIUpdateGroupAISection

      .section AIMoveToCoordinatesByChapterSection

        rsAIASMCMoveToCoordinatesByChapter ; 8D/DFAA

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; aAISelectedUnitInfo: filled with decision info if
          ;   a target entry was found.

          lda aSelectedCharacterBuffer.AIProperties,b
          and #AI_PropertySetting
          lsr a
          lsr a
          lsr a
          lsr a
          sta wR0
          jsr rsAIGetChapterCoordinateTableEntry
          bcs +

            sep #$20

            lda #AI_Action_Move
            sta aAISelectedUnitInfo.bActionDecision

            rep #$20

            jsr rsAIApproachTile

          +
          rts

          .databank 0

        rsAIGetChapterCoordinateTableEntry ; 8D/DFC8

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Gets the coordinates of a requested
          ; index from the chapter's coordinate table.

          ; Inputs:
          ; wR0: coordinate entry index

          ; Outputs:
          ; wR0: X coordinate if entry
          ; wR1: Y coordinate if entry
          ; Carry clear if entry found else carry set.

          lda #<>aAIChapterCoordinatePointers
          sta lR25
          lda #>`aAIChapterCoordinatePointers
          sta lR25+size(byte)

          lda wCurrentChapter,b
          asl a
          tay

          ; This checks for null pointers despite
          ; every unused chapter getting an actual pointer
          ; to a dummy entry.

          lda [lR25],y
          beq +

            sta lR25

            lda wR0
            asl a
            tay

            ; Get a pointer to the coordinates.
            ; Weirdly inefficient way to do this.

            ; Also check for null pointers here.

            lda [lR25],y
            beq +

              sta lR25

              lda [lR25]
              and #$00FF
              sta wR0

              ldy #1
              lda [lR25],y
              and #$00FF
              sta wR1

              clc

              rts

          +
          sec
          rts

          .databank 0

      .endsection AIMoveToCoordinatesByChapterSection

      .section AIMoveToIsolatedTargetSection

        rsAIASMCMoveToIsolatedTarget ; 8D/DFFC

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Tries to move to the most isolated target
          ; the unit can reach. The unit's AI_PropertySetting
          ; is used as the threshold for the number of units
          ; in range of a target for them to be considered isolated.
          ; Respects wAIThreatMask?

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: max threat

          ; Outputs:
          ; None

          ; This forces the unit to consider recovery mode.

          inc wAIConsiderRecoveryModeFlag

          ; Get isolation threshold.

          lda aSelectedCharacterBuffer.AIProperties,b
          and #AI_PropertySetting
          lsr a
          lsr a
          lsr a
          lsr a
          sta wAITemp7E4021

          ; Current best target deployment number
          ; and tile index.

          lda #-1
          sta wAITemp7E4008
          sta wAITemp7E400A

          ldx #<>aSelectedCharacterBuffer
          jsl rlAIFillRangeMap

          lda #<>rsAIASMCMoveToIsolatedTargetFilter
          sta lR24
          lda #>`rsAIASMCMoveToIsolatedTargetFilter
          sta lR24+size(byte)
          jsr rsAIRunRoutineForAllTilesInMovementRange

          ; Check if we've found a tile to move to and
          ; set the unit's decision if so.

          lda wAITemp7E400A
          bmi _End

            sep #$20

            lda #AI_Action_Move
            sta aAISelectedUnitInfo.bActionDecision

            rep #$20

            lda aAIMainVariables.aCurrentScriptCommand.aParameters[1]
            and wAIThreatMask
            sta wAILeastThreatenedTileThreatCount

            lda wAITemp7E400A
            jmp rsAI_MOVEMENT_AI_MOVE_TO_UNITS_Handler._TargetTile

          _End
          stz aAIMainVariables.wScriptContinueFlag
          rts

          .databank 0

        rsAIASMCMoveToIsolatedTargetFilter ; 8D/E04A

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Filtering routine for rsAIASMCMoveToIsolatedTarget.

          ; Inputs:
          ; X: tile index
          ; wAITemp7E4008: current best target deployment number
          ; wAITemp7E400A: current best target tile index
          ; wAITemp7E4021: isolated ally count threshold
          ; aMovementMap: filled with active unit's movement range

          ; Outputs:
          ; wAITemp7E4008: current best target deployment number
          ; wAITemp7E400A: current best target tile index

          php

          ; Only targetable units with fewer nearby allies
          ; than the threshold are targeted.

          lda aUnitMap,x
          beq _End

          jsl rlCheckIfAllegianceDoesNotMatchPhaseTarget
          bcc _End

            rep #$30

            and #$00FF
            sta wR0

            lda #<>aTargetingCharacterBuffer
            sta wR1

            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            sep #$20

            lda aTargetingCharacterBuffer.AlliesInRange,b
            cmp wAITemp7E4021
            bpl _End

            lda aMovementMap,x
            cmp wAITemp7E4008
            bge _End

              sta wAITemp7E4008
              stx wAITemp7E400A

          _End
          plp
          rts

          .databank 0

      .endsection AIMoveToIsolatedTargetSection

      .section AIDanceSection

        rsAIASMCDance ; 8D/E080

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Tries to dance.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; aAISelectedUnitInfo: filled with decision
          ; aAIMainVariables.wScriptContinueFlag: cleared

          jsr rsAICanUnitDance
          bcs +

          jsr rsAISelectDanceTarget
          bcs +

            jsr rsAIInteractionSetup

            sep #$20

            lda #AI_Action_Dance
            sta aAISelectedUnitInfo.bActionDecision

            rep #$20

          +
          stz aAIMainVariables.wScriptContinueFlag
          rts

          .databank 0

        rsAICanUnitDance ; $8D/E09A

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Returns carry clear if unit can dance,
          ; carry set otherwise.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; Carry clear if unit can dance, else carry clear.

          lda aSelectedCharacterBuffer.Skills1,b
          bit #Skill1Dance
          beq +

            clc
            rts

          +
          sec
          rts

          .databank 0

        rsAISelectDanceTarget ; 8D/E0A6

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit

          ; Outputs:
          ; aAIMainVariables.wBestTarget: best target
          ; wAITemp7E400C: best tile index or -1 if none
          ; Carry clear if target, else carry set.

          lda #-1
          sta wAITemp7E400C

          stz aAIMainVariables.wTargetArrayOffset

          ; Stationary units can only dance in place.

          lda wAIStationaryFlag
          beq _GetMove

            lda #0
            bra +

          _GetMove
          lda #<>aSelectedCharacterBuffer
          sta wR14
          jsl rlGetEffectiveMove

          +
          sta wR2

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0

          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1

          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          sta wR3

          lda #-1
          sta wR4

          lda aSelectedCharacterBuffer.Skills1,b
          sta wR5

          jsl rlFillMovementRangeMapByClass
          jsl rlUnknown80E551

          lda #<>rsAISelectDanceTargetFilter
          sta lR24
          lda #>`rsAISelectDanceTargetFilter
          sta lR24+size(byte)
          jsr rsAIRunRoutineForAllTilesInMovementRange

          ldx aAIMainVariables.wTargetArrayOffset
          beq +

          lda #-1
          sta aAIMainVariables.aTargetArray,x

          jsr rsAIChooseDanceTarget

          lda wAITemp7E400C
          bmi +

            clc
            rts

          +
          sec
          rts

          .databank 0

        rsAISelectDanceTargetFilter ; 8D/E112

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Filtering routine for rsAISelectDanceTarget.

          ; Inputs:
          ; X: tile index
          ; aSelectedCharacterBuffer: filled with unit
          ; aAIMainVariables.aTargetArray: list of target deployment
          ;   number words

          ; Outputs:
          ; aAIMainVariables.aTargetArray: list of target deployment
          ;   number words

          php

          ; Check if unit at tile, that unit is of the same
          ; allegiance and that unit is not themselves.

          lda aUnitMap,x
          beq +

          bit wCurrentPhase,b
          beq +

          cmp aSelectedCharacterBuffer.DeploymentNumber,b
          beq +

            ; Only dance for units that have moved
            ; and aren't dancers themselves.

            rep #$30

            and #$00FF
            sta wR0

            lda #<>aTemporaryActionStruct
            sta wR1

            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aTemporaryActionStruct.Skills1,b
            bit #Skill1Dance
            bne +

            lda aTemporaryActionStruct.UnitState,b
            bit #UnitStateGrayed
            beq +

              txa
              ldy aAIMainVariables.wTargetArrayOffset
              sta aAIMainVariables.aTargetArray,y
              inc y
              inc y
              sty aAIMainVariables.wTargetArrayOffset

          +
          plp
          rts

          .databank 0

        rsAIChooseDanceTarget ; 8D/E150

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Given a target list, try to get
          ; the least-threatened and closest tile.

          ; Inputs:
          ; aAIMainVariables.aTargetArray: list of target deployment
          ;   number words

          ; Outputs:
          ; aAIMainVariables.wBestTarget: best target
          ; wAITemp7E400C: best tile index or -1 if none

          lda #-1
          sta wAITemp7E4010

          ldy #0

          _Loop

            lda #-1
            sta wAITemp7E401B

            ldx aAIMainVariables.aTargetArray,y
            bmi _End

              lda #<>rsAIChooseDanceTargetFilter
              sta lR25
              lda #>`rsAIChooseDanceTargetFilter
              sta lR25+size(byte)
              jsl rlRunRoutineForTilesIn1Range

              lda wAITemp7E401B
              cmp #-1
              beq _Next

              cmp wAITemp7E4010
              bge _Next

                sta wAITemp7E4010

                lda wAITemp7E400A
                sta wAITemp7E400C

                ldx aAIMainVariables.aTargetArray,y
                lda aUnitMap,x
                and #$00FF
                sta aAIMainVariables.wBestTarget

          _Next
          inc y
          inc y
          bra _Loop

          _End
          rts

          .databank 0

        rsAIChooseDanceTargetFilter ; 8D/E199

          .autsiz
          .databank `aAIMainVariables

          ; Filter for rsAIChooseDanceTarget.
          ; Check if tile is less threatened and closer
          ; than current best.

          ; Inputs:
          ; X: tile index
          ; aSelectedCharacterBuffer: filled with unit
          ; wAITemp7E401B: current best (threat * 8) + distance
          ; wAITemp7E400A: current best tile index

          ; Outputs:
          ; wAITemp7E401B: current best (threat * 8) + distance
          ; wAITemp7E400A: current best tile index

          php

          sep #$20

          ; Ensure that the tile is empty (or has the unit themself)

          lda aMovementMap,x
          cmp #MovementMax
          bge _End

          lda aUnitMap,x
          beq +

            cmp aSelectedCharacterBuffer.DeploymentNumber,b
            bne _End

          +

          ; Calculate 'cost' as (threat * 8) + distance.

          lda aThreatenedTileMap,x
          and #~Threat_AllEffective
          asl a
          asl a
          asl a

          clc
          adc aMovementMap,x

          ; Check if better than current best.

          cmp wAITemp7E401B
          bge _End

            sta wAITemp7E401B
            stx wAITemp7E400A

          _End
          plp
          rtl

          .databank 0

      .endsection AIDanceSection

      .section AIGetEffectiveThreatenedTilesSection

        rsAIASMCGetEffectiveThreatenedTiles ; 8D/E1C6

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Gets the threatened tiles against the current
          ; allegiance that are threatened by a unit with a
          ; certain kind of effective weapon.

          ; Inputs:
          ; wAITemp7E401B: effectiveness to look for

          ; Outputs:
          ; aRangeMap: threatened tiles set to -1 if effective

          lda #(`aRangeMap)<<8
          sta lR18+size(byte)
          lda #<>aRangeMap
          sta lR18
          lda #$0000
          jsl rlFillMapByWord

          lda #<>rlAIASMCGetEffectiveThreatenedTilesFilter
          sta lR25
          lda #>`rlAIASMCGetEffectiveThreatenedTilesFilter
          sta lR25+size(byte)
          jsr rsAIRunRoutineForOpposingAllegiances
          rts

          .databank 0

        rlAIASMCGetEffectiveThreatenedTilesFilter ; 8D/E1E5

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Filter for rsAIASMCGetEffectiveThreatenedTiles

          ; Inputs:
          ; aTargetingCharacterBuffer: current potential target
          ; wAITemp7E401B: effectiveness to look for

          ; Outputs:
          ; aRangeMap: threatened tiles set to -1 if effective

          lda lR25
          pha

          lda lR25+size(byte)
          pha

          ; Standing units with equipped weapons only.

          lda aTargetingCharacterBuffer.UnitState,b
          bit #(UnitStateUnknown1 | UnitStateRescued | UnitStateHidden)
          bne _End

          lda #<>aTargetingCharacterBuffer
          sta wR1
          jsr rsAITryGetUnitEquippedWeaponRange
          bcs _End

            ; Range

            sta wAITemp7E403A

            ; Effectiveness must match.

            lda aItemDataBuffer.Effectiveness,b
            cmp wAITemp7E401B
            bne _End

              stz wR4

              lda #<>aTargetingCharacterBuffer
              sta wR14
              jsr rsAIUnknown8DAD49

              lda #<>rlAIASMCGetEffectiveThreatenedTilesEffect
              sta lR24
              lda #>`rlAIASMCGetEffectiveThreatenedTilesEffect
              sta lR24+size(byte)
              jsr rsAIRunRoutineForAllTilesInMovementRange

          _End
          pla
          sta lR25+size(byte)

          pla
          sta lR25

          rtl

          .databank 0

        rlAIASMCGetEffectiveThreatenedTilesEffect ; 8D/E226

          .as
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; X: tile index

          ; Outputs:
          ; None

          lda #-1
          sta aRangeMap,x
          rts

          .databank 0

      .endsection AIGetEffectiveThreatenedTilesSection

      .section AIOverwriteStationaryFlagSection

        rsAIASMCOverwriteStationaryFlag ; 8D/E22C

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Sets the stationary flag to a specified value.

          ; Inputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: value

          ; Outputs:
          ; wAIStationaryFlag: set to value

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[1]
          sta wAIStationaryFlag
          rts

          .databank 0

      .endsection AIOverwriteStationaryFlagSection

      .section AISetUpperActionCapabilityBitfield

        rsAIASMCSetUpperActionCapabilityBitfield ; 8D/E233

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Sets bits in the upper byte of wAIActionCapabilityBitfield.

          ; Inputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: value

          ; Outputs:
          ; wAIActionCapabilityBitfield+size(byte): ORRed with value

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[1]

          sep #$20

          xba

          rep #$30

          sta aAIMainVariables.aCurrentScriptCommand.aParameters[1]

          lda wAIActionCapabilityBitfield
          ora aAIMainVariables.aCurrentScriptCommand.aParameters[1]
          sta wAIActionCapabilityBitfield

          rts

          .databank 0

      .endsection AISetUpperActionCapabilityBitfield

      .section AICountCharacterInMovementRangeSection

        rsAIASMCCountCharacterInMovementRange ; 8D/E248

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Counts the number of a specific character in a
          ; unit's movement range.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with current AI target
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: character

          ; Outputs:
          ; aAIMainVariables.aTemp._Vars[0]: count

          stz aAIMainVariables.aTemp._Vars[0]
          stz wR0

          lda wAIStationaryFlag
          beq +

            lda #0
            bra ++

          +
            lda #<>aSelectedCharacterBuffer
            sta wR14

            jsl rlGetEffectiveMove

          +
          sta wR2

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0

          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1

          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          sta wR3

          lda #-1
          sta wR4

          lda aSelectedCharacterBuffer.Skills1,b
          sta wR5

          jsl rlFillMovementRangeMapByClass
          jsl rlUnknown80E551

          lda #<>rlAIASMCCountCharacterInMovementRangeEffect
          sta lR24
          lda #>`rlAIASMCCountCharacterInMovementRangeEffect
          sta lR24+size(byte)
          jsr rsAIRunRoutineForAllTilesInMovementRange

          rts

          .databank 0

        rlAIASMCCountCharacterInMovementRangeEffect

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; X: index of current tile into maps
          ; aAIMainVariables.aCurrentScriptCommand.aParameters[1]: target character

          ; Output:
          ; aAIMainVariables.aTemp._Vars[0]: incremented if unit at
          ;   the current range map tile is the target character,
          ;   unchanged otherwise.

          lda aUnitMap,x
          beq _End

            sta wR0

            ldy #<>aTemporaryActionStruct
            sty wR1

            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            ldy aTemporaryActionStruct.Character,b
            cpy aAIMainVariables.aCurrentScriptCommand.aParameters[1]
            bne _End

              inc aAIMainVariables.aTemp._Vars[0]

            _End
            rts

            .databank 0

      .endsection AICountCharacterInMovementRangeSection

      .section AISetAIForUnitInCurrentPhaseSection

        rsAIASMCSetAIForUnitInCurrentPhase ; 8D/E2B6

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Sets all units with the given character ID in the
          ; current phase to have the specified AI settings.

          ; Inputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: character
          ;   .aParameters[2]: new Action AI
          ;   .aParameters[3]: new Movement AI

          ; Outputs:
          ; None

          lda #<>rlAIASMCSetAIForUnitInCurrentPhaseEffect
          sta lR25
          lda #>`rlAIASMCSetAIForUnitInCurrentPhaseEffect
          sta lR25+size(byte)

          lda wCurrentPhase,b
          inc a
          jsl rlRunRoutineForAllUnitsInAllegiance

          lda #AIItemCycle
          sta wAIEngineCycleType

          stz aAIMainVariables.wScriptContinueFlag

          rts

          .databank 0

        rlAIASMCSetAIForUnitInCurrentPhaseEffect ; 8D/E2D2

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Inputs:
          ; aTargetingCharacterBuffer: filled with target
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: character to look for
          ;   .aParameters[2]: new Action AI
          ;   .aParameters[3]: new Movement AI

          ; Outputs:
          ; None

          php

          lda aTargetingCharacterBuffer.Character,b
          cmp aAIMainVariables.aCurrentScriptCommand.aParameters[1]
          bne _End

          sep #$20

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[2]
          sta aTargetingCharacterBuffer.ActionAI,b

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[3]
          sta aTargetingCharacterBuffer.MovementAI,b

          rep #$30

          stz aTargetingCharacterBuffer.ActionAIOffset,b

          lda aTargetingCharacterBuffer.AIProperties,b
          and #~AI_PropertySetting
          sta aTargetingCharacterBuffer.AIProperties,b

          lda #<>aTargetingCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataFromBuffer

          _End
          plp
          rtl

          .databank 0

      .endsection AISetAIForUnitInCurrentPhaseSection

      .section AICountWeaponsInInventorySection

        rsAIASMCCountWeaponsInInventory ; 8D/E302

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          ; Counts all of the items with the weapon trait
          ; in a unit's inventory.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with current AI target

          ; Outputs:
          ; aAIMainVariables.aTemp._Vars[0]: counter

          ldx #0
          stz aAIMainVariables.aTemp._Vars[0]

          _Loop

            lda aSelectedCharacterBuffer.Items,b,x
            beq _End

              jsl rlCopyItemDataToBuffer

              lda aItemDataBuffer.Traits,b
              bit #TraitWeapon
              beq +

                inc aAIMainVariables.aTemp._Vars[0]

              +
              inc x
              inc x

              cpx #size(structExpandedCharacterDataRAM.Items)
              bne _Loop

          _End
          rts

          .databank 0

      .endsection AICountWeaponsInInventorySection

      .section AIGetAICounterSection

        rsAIASMCGetCounter ; 8D/E324

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Fetches a unit's AI counter.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with current AI target

          ; Outputs:
          ; aAIMainVariables.aTemp._Vars[0]: counter

          lda aSelectedCharacterBuffer.ActionMisc,b
          and #AI_CoordinateIndex

          lsr a
          lsr a
          lsr a

          sta aAIMainVariables.aTemp._Vars[0]

          rts

          .databank 0

      .endsection AIGetAICounterSection

      .section AIForceHealSection

        rsAIASMCTryForceHeal ; 8D/E331

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Try to find a healing target, ignoring
          ; whether or not the potential target is
          ; is recovery mode.

          ; This is bugged: the ignore table pointer isn't set properly,
          ; and thus it can't ignore anyone.

          ; Inputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with ACTION_AI_CALL_ASM
          ;   .wOpcode: $01 for ACTION_AI_CALL_ASM
          ;   .aParameters[0]: short pointer to this routine
          ;   .aParameters[1]: this is supposed to be a short
          ;     pointer to an ignore table in bank $8F but only a byte
          ;     was allocated to it in the ASMC parameters.
          ;   .aParameters[2]: percentage chance to act
          ;   .aParameters[3]: maximum threat

          lda #100
          jsl rlGetRandomNumber100
          cmp aAIMainVariables.aCurrentScriptCommand.aParameters[2]
          bpl _End2

            lda aAIMainVariables.aCurrentScriptCommand.aParameters[3]
            and wAIThreatMask
            sta wAILeastThreatenedTileThreatCount

            jsr rsAITryGetUsableItem
            bcc _End

            lda #-1
            sta wAIConsiderRecoveryModeFlag

            jsr rsAITryGetUsableStaff
            bcc _End

              lda #<>rsAIASMCTryForceHealFilter
              sta lAIParameterRoutine
              lda #>`rsAIASMCTryForceHealFilter
              sta lAIParameterRoutine+size(byte)
              jsr $8D8EDF

          _End
          rts

          _End2
          rts

          .databank 0

        rsAIASMCTryForceHealFilter ; 8D/E367

          .autsiz
          .databank `aAIMainVariables

          ; Filtering routine for rsAIASMCTryForceHeal.

          ; This is bugged: the ignore table pointer isn't set properly,
          ; and thus it can't ignore anyone.

          ; Inputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with ACTION_AI_CALL_ASM
          ;   .wOpcode: $01 for ACTION_AI_CALL_ASM
          ;   .aParameters[0]: short pointer to this routine
          ;   .aParameters[1]: this is supposed to be a short
          ;     pointer to an ignore table in bank $8F but only a byte
          ;   .aParameters[2]: percentage chance to act
          ;   .aParameters[3]: maximum threat

          php

          ; Check if unit at tile, that unit is targetable
          ; and that unit is not themselves.

          lda aUnitMap,x
          beq _End

          jsl rlCheckIfAllegianceDoesNotMatchPhaseTarget
          bcc _End

          cmp aSelectedCharacterBuffer.DeploymentNumber,b
          beq _End

            ; If a table of ignored characters was passed
            ; in, check if they're in the table.

            ; In reality, this is never set properly and should
            ; read 0 or bad things will happen.

            ; This is also bugged because the pointer to the
            ; ignore table needs to be in .aParameters[0] and not 1.

            lda aAIMainVariables.aCurrentScriptCommand.aParameters[1]
            beq +

              rep #$30

              lda aUnitMap,x
              and #$00FF
              sta wR0

              lda #<>aTemporaryActionStruct
              sta wR1

              jsl rlCopyCharacterDataToBufferByDeploymentNumber

              ldy aTemporaryActionStruct.Character,b
              sty wR2

              jsr rsAIIsCharacterInIgnoreTable
              bcs _End

            +
            rep #$20

            txa
            ldy aAIMainVariables.wTargetArrayOffset
            sta aAIMainVariables.aTargetArray,y
            inc y
            inc y
            sty aAIMainVariables.wTargetArrayOffset

            sep #$20

          _End
          plp
          rts

          .databank 0

      .endsection AIForceHealSection

      .section AIIsCharacterInIgnoreTableSection

        rsAIIsCharacterInIgnoreTable ; 8D/E3AC

          .autsiz
          .databank `aAIMainVariables

          ; Checks if a unit is in an ignore table.

          ; Inputs:
          ; wR2: target character ID
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[0]: short pointer to ignore table in bank $8F

          ; Outputs:
          ; Carry set if unit found in table, carry clear otherwise

          php

          rep #$30

          lda #`AIIgnoreTables
          sta lR18+size(addr)

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[0]
          sta lR18

          ldy #0

          _Loop

            lda [lR18],y
            beq _NotFound

            cmp wR2
            beq _Found

              inc y
              inc y
              bra _Loop

          _NotFound
          plp
          clc
          rts

          _Found
          plp
          sec
          rts

          .databank 0

      .endsection AIIsCharacterInIgnoreTableSection

      .section AISetAllegianceToNPCSection

        rsAIASMCSetAllegianceToNPC ; 8D/E3CE

          .autsiz
          .databank `aAIMainVariables

          ; Sets a unit's allegiance to NPC.

          ; Inputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: Unit ID

          ; Outputs:
          ; None

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[1]
          jsl rlSetAllegianceToNPC

          rts

          .databank 0

      .endsection AISetAllegianceToNPCSection

      .section AIUnknownSetAISection

        rlAIASMCUnknownSetAI ; 8D/E3D6

          .autsiz
          .databank `aAIMainVariables

          ; Unknow, unused? Sets a unit's AI.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with unit
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: New Action AI
          ;   .aParameters[2]: New Movement AI

          ; Outputs:
          ; None

          php

          sep #$20

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[1]
          sta aSelectedCharacterBuffer.ActionAI,b

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[2]
          sta aSelectedCharacterBuffer.MovementAI,b

          rep #$30

          stz aSelectedCharacterBuffer.ActionAIOffset,b

          lda aSelectedCharacterBuffer.AIProperties,b
          and #~AI_PropertySetting
          sta aSelectedCharacterBuffer.AIProperties,b

          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataFromBuffer

          plp
          rtl

          .databank 0

      .endsection AIUnknownSetAISection

      .section AICheckIfTerrainAtCoordinatesSection

        rsAIASMCCheckIfTerrainAtCoordinates ; 8D/E3FE

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Returns nonzero in aAIMainVariables.aTemp._Vars[0]
          ; if terrain at coordinates matches a given value.

          ; Inputs:
          ; aAIMainVariables.aCurrentScriptCommand: filled with command
          ;   .aParameters[1]: X coordinate
          ;   .aParameters[2]: Y coordinate
          ;   .aParameters[3]: terrain

          ; Outputs:
          ; aAIMainVariables.aTemp._Vars[0]: nonzero if terrain
          ;   matches, zero otherwise.

          stz aAIMainVariables.aTemp._Vars[0]

          lda aAIMainVariables.aCurrentScriptCommand.aParameters[1]
          sta wR0
          lda aAIMainVariables.aCurrentScriptCommand.aParameters[2]
          sta wR1
          jsl rlGetMapTileIndexByCoords

          tax
          lda aTerrainMap,x
          and #$00FF

          cmp aAIMainVariables.aCurrentScriptCommand.aParameters[3]
          beq +

            inc aAIMainVariables.aTemp._Vars[0]

          +
          rts

          .databank 0

      .endsection AICheckIfTerrainAtCoordinatesSection

      .section AITryOpenClosestDoorSection

        rsAIASMCTryOpenClosestDoor ; 8D/E41F

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          lda #6 ; TODO: actions? whatever this is
          sta aAIMainVariables.aTemp._Vars[0]

          lda #DoorKey
          sta wR2
          jsr rsAIFindItemInInventory
          bcs _End

            stx wAITemp7E4038

            jsr rsAITryGetClosestTileToDoor
            bcs _End

              lda wAITemp7E400A
              pha

              jsr rsAIApproachTile

              pla
              sta wAITemp7E400A

              lda wAIEngineStatus
              beq _End

                jsr rsAIActionUseItem
                stz aAIMainVariables.aTemp._Vars[0]

          _End
          rts

          .databank 0

        rsAIFindItemInInventory ; 8D/E44E

          .al
          .xl
          .autsiz
          .databank `aAIMainVariables

          ; Checks if an item is in a unit's inventory.

          ; Inputs:
          ; wR2: item ID
          ; aSelectedCharacterBuffer: filled with current AI target

          ; Outputs:
          ; X: inventory offset of it if found
          ; Carry clear if item found, else carry set.

          ldx #0

          _Loop

            lda aSelectedCharacterBuffer.Items,b,x
            beq _NotFound

              and #$00FF
              cmp wR2
              beq _Found

                inc x
                inc x

                cpx #size(structExpandedCharacterDataRAM.Items)
                bne _Loop

          _NotFound
          sec
          rts

          _Found
          clc
          rts

          .databank 0

      .endsection AITryOpenClosestDoorSection

      .section AIUnknown8DE468Section

        rsAIUnknown8DE468 ; 8D/E468

          .autsiz
          .databank `aAIMainVariables

          ; Presumably unused. Accidentally
          ; overwrites aAISelectedUnitInfo.aDecisionParameters[2].

          php

          sep #$20

          lda #AI_Action_Unknown02
          sta aAISelectedUnitInfo.bActionDecision

          stz aAISelectedUnitInfo.aDecisionParameters[0]

          lda wAITemp7E4038
          sta aAISelectedUnitInfo.aDecisionParameters[1]

          lda wR0
          sta aAISelectedUnitInfo.aDecisionParameters[2]

          lda wR1
          sta aAISelectedUnitInfo.aDecisionParameters[2]

          lda aSelectedCharacterBuffer.X,b
          sta aAISelectedUnitInfo.bDestinationXCoordinate

          lda aSelectedCharacterBuffer.Y,b
          sta aAISelectedUnitInfo.bDestinationYCoordinate

          stz aMovementDirectionArray

          plp
          rts

          .databank 0

      .endsection AIUnknown8DE468Section

      .section AISetBusyStatusSection

        rsAIASMCSetBusyStatus ; 8D/E494

          .al
          .autsiz
          .databank `aAIMainVariables

          ; Flags the AI engine as busy
          ; if the unit still has a distance
          ; to go before reaching their target.

          ; Inputs:
          ; aAISelectedUnitInfo.bDecisionDistance: target distance

          ; Outputs:
          ; wAIEngineStatus: nonzero if distance, otherwise unchanged.
          ; aAIMainVariables.wScriptContinueFlag: cleared

          lda aAISelectedUnitInfo.bDecisionDistance
          and #$00FF
          beq +

            lda #1
            sta wAIEngineStatus

          +
          stz aAIMainVariables.wScriptContinueFlag
          rts

          .databank 0

      .endsection AISetBusyStatusSection

      .section ActionAIScriptSection

        aActionAIScriptPointerTable .include "../TABLES/ActionAIPointers.csv.asm" ; 8F/8000
        .word 0

        aActionAI00Script ; 8F/8036

          ; Always try to perform an action.

          ACTION_AI_TARGET None, 100, AI_AnyThreat
          ACTION_AI_BRA aActionAI00Script

        aActionAI12Script ; 8F/803E

          ; Always try to heal targets, even if they
          ; are not in recovery mode.

          ACTION_AI_CALL_ASM rsAIASMCTryForceHeal, [None, 100, AI_AnyThreat]
          ACTION_AI_BRA aActionAI12Script

        aActionAI0AScript ; 8F/8048

          ; Try to perform an action 80% of the time.
          ; Unit will still try to move if they do not
          ; perform an action.

          ACTION_AI_TARGET None, 80, AI_AnyThreat
          ACTION_AI_BRA aActionAI0AScript

        aActionAI0BScript ; 8F/8050

          ; Try to perform an action 50% of the time.
          ; Unit will still try to move if they do not
          ; perform an action.

          ACTION_AI_TARGET None, 50, AI_AnyThreat
          ACTION_AI_BRA aActionAI0BScript

        aActionAI01Script ; 8F/8058

          ; Effectively identical to aActionAI0Script

          ACTION_AI_CHANCE 100
          ACTION_AI_BRA aActionAI01Script

        aActionAI0CScript ; 8F/805E

          ; Try to perform an action 80% of the time,
          ; skipping their action/movement 20% of the time.

          ACTION_AI_CHANCE 80
          ACTION_AI_BRA aActionAI0CScript

        aActionAI0FScript ; 8F/8064

          ; Always try to perform an action,
          ; ignoring Leif.

          ACTION_AI_TARGET AIIgnoreTables.aLeif, 100, AI_AnyThreat
          ACTION_AI_BRA aActionAI0FScript

        aActionAI0DScript ; 8F/806C

          ; Try to perform an action 50% of the time,
          ; skipping their action/movement 50% of the time.

          ACTION_AI_CHANCE 50
          ACTION_AI_BRA aActionAI0DScript

        aActionAI13Script ; 8F/8072

          ; Try to perform an action 20% of the time,
          ; skipping their action/movement 80% of the time.

          ACTION_AI_CHANCE 20
          ACTION_AI_BRA aActionAI13Script

        aActionAI02Script ; 8F/8078

          ; Perform no actions, tries movement.

          ACTION_AI_NO_ACTION 40
          ACTION_AI_BRA aActionAI02Script

        aActionAI03Script ; 8F/807E

          ; Don't fight, just use staves/items/etc.

          ACTION_AI_NONCOMBAT 40
          ACTION_AI_BRA aActionAI03Script

        aActionAI04Script ; 8F/8084

          ; Attack unit with the highest current
          ; HP in range.

          ACTION_AI_TARGET_BY_HIGHEST_STAT CurrentHP, 100
          ACTION_AI_BRA aActionAI04Script

        aActionAI05Script ; 8F/808C

          ; Try to target Lord class, switch to
          ; aActionAI00Script if Lord not found.

          ACTION_AI_TARGET_CLASS Lord, 250
          ACTION_AI_BEQ aAIMainVariables.aTemp._Vars[0], 0, aActionAI05Script

            ACTION_AI_SET_AI ActionAI_IgnoreNone, AI_NoChange

        aActionAI06Script ; 8F/809A

          ; Attack targets in 1/2 movement range,
          ; move toward certain tiles otherwise.

          ACTION_AI_CALL_ASM rsAIASMCCountTargetsInScaledAttackRange, [0, 5]
          ACTION_AI_BEQ aAIMainVariables.aTemp._Vars[0], 0, +

            ACTION_AI_TARGET None, 100, 250
            ACTION_AI_BRA aActionAI06Script

          +
          ACTION_AI_CALL_ASM rsAIASMCMoveToCoordinatesByChapter
          ACTION_AI_BRA aActionAI06Script

        aActionAI07Script ; 8F/80B9

          ; Always try to dance.

          ACTION_AI_CALL_ASM rsAIASMCDance
          ACTION_AI_BRA aActionAI07Script

        aActionAI09Script ; 8F/80B9

          ; Try to act if targets in 1/2 movement
          ; range. Otherwise, do nothing.

          ACTION_AI_CALL_ASM rsAIASMCCountTargetsInScaledAttackRange, [0, 5]
          ACTION_AI_BEQ aAIMainVariables.aTemp._Vars[0], 0, +

            ; Overwrite the stationary flag and
            ; only select unthreatened tiles.

            ACTION_AI_CALL_ASM rsAIASMCOverwriteStationaryFlag, [4]
            ACTION_AI_TARGET None, 100, 0

            ACTION_AI_BRA aActionAI09Script

          +
          ACTION_AI_NO_ACTION 100
          ACTION_AI_BRA aActionAI09Script

        aActionAI08Script ; 8F/80E5

          ; Try to heal allies until turn 10,
          ; then use keys before switching to
          ; aActionAI19Script.

          ACTION_AI_CALL_ASM rsAIASMCGetCurrentTurn
          ACTION_AI_BGE aAIMainVariables.aTemp._Vars[0], 10, +

            ACTION_AI_NONCOMBAT 40
            ACTION_AI_BRA aActionAI08Script

          +
          ACTION_AI_CALL_ASM rsAIASMCSetUpperActionCapabilityBitfield, [$40]
          ACTION_AI_NONCOMBAT 40
          ACTION_AI_SET_AI ActionAI_Chapter3Enemies, MovementAI_StationaryIfWeapon

        aActionAI0EScript ; 8F/8106

          ; Skip action and try movement if
          ; Leif in in range, otherwise act
          ; normally.

          ACTION_AI_CALL_ASM rsAIASMCCountCharacterInMovementRange, [Leif]
          ACTION_AI_BEQ aAIMainVariables.aTemp._Vars[0], 0, +

            ACTION_AI_NO_ACTION 100
            ACTION_AI_BRA aActionAI0EScript

          +
          ACTION_AI_TARGET None, 100, AI_AnyThreat
          ACTION_AI_BRA aActionAI0EScript

        aActionAI10Script ; 8F/8121

          ; Act normally for one turn before
          ; switching to aActionAI02Script.

          ACTION_AI_TARGET None, 100, AI_AnyThreat
          ACTION_AI_SET_AI ActionAI_NoAction, AI_NoChange

        aActionAI11Script ; 8F/812A

          ; Act normally while target point
          ; counter remains zero. Otherwise,
          ; swap to aActionAI02Script.

          ACTION_AI_TARGET None, 100, AI_AnyThreat
          ACTION_AI_CALL_ASM rsAIASMCGetCounter
          ACTION_AI_BGT aAIMainVariables.aTemp._Vars[0], 0, +

            ACTION_AI_BRA aActionAI11Script

          +
          ACTION_AI_SET_AI ActionAI_NoAction, MovementAI_Flee

        aActionAI14Script ; 8F/8143

          ; Target anyone but the Chapter 18 NPCs,
          ; switching to aActionAI02Script if without
          ; a weapon.

          ACTION_AI_CALL_ASM rsAIASMCCountWeaponsInInventory
          ACTION_AI_BEQ aAIMainVariables.aTemp._Vars[0], 0, +

            ACTION_AI_TARGET AIIgnoreTables.aChapter18NPCs, 100, AI_AnyThreat
            ACTION_AI_BRA aActionAI14Script

          +
          ACTION_AI_SET_AI ActionAI_NoAction, MovementAI_StationaryIfWeapon

        aActionAI17Script ; 8F/815C

          ; Target anyone but the Chapter 19 NPCs.

          ACTION_AI_TARGET AIIgnoreTables.aChapter19NPCS, 100, AI_AnyThreat
          ACTION_AI_BRA aActionAI17Script

        aActionAI15Script ; 8F/8164

          ; Act normally until the door at [38, 4]
          ; is opened, then switch to aActionAI02Script.

          ACTION_AI_CALL_ASM rsAIASMCCheckIfTerrainAtCoordinates, [38, 4, TerrainDoor]
          ACTION_AI_BEQ aAIMainVariables.aTemp._Vars[0], 0, +

            ACTION_AI_SET_AI ActionAI_NoAction, MovementAI_Flee

          +
          ACTION_AI_TARGET None, 100, AI_AnyThreat
          ACTION_AI_BRA aActionAI15Script

        aActionAI16Script ; 8F/817D

          ; Try to open reachable doors,
          ; switch to aActionAI00Script if
          ; they run out of keys.
          ; Otherwise, act normally.

          ACTION_AI_CALL_ASM rsAIASMCTryOpenClosestDoor
          ACTION_AI_BEQ aAIMainVariables.aTemp._Vars[0], 2, ++
            ACTION_AI_BEQ aAIMainVariables.aTemp._Vars[0], 6, +

              ACTION_AI_BRA aActionAI16Script

            +
            ; Out of keys, switch AI.
            ACTION_AI_SET_AI ActionAI_IgnoreNone, MovementAI_CaptureThrone

          +
          ; Act normally
          ACTION_AI_TARGET None, 100, AI_AnyThreat
          ACTION_AI_BRA aActionAI16Script

        aActionAI18Script ; 8F/819F

          ; Target anyone but Olwen.

          ACTION_AI_TARGET AIIgnoreTables.aOlwen, 100, AI_AnyThreat
          ACTION_AI_BRA aActionAI18Script

        aActionAI19Script ; 8F/81A7

          ; Target anyone but the Chapter 3 NPCs.

          ACTION_AI_TARGET AIIgnoreTables.aChapter3NPCs, 100, AI_AnyThreat
          ACTION_AI_BRA aActionAI19Script

      .endsection ActionAIScriptSection

      .section MovementAIScriptSection

        aMovementAIScriptPointerTable .include "../TABLES/MovementAIPointers.csv.asm" ; 8F/8000
        .word 0

        aMovementAI00Script ; 8F/8207

          ; General movement AI. Try to approach any targets.

          MOVEMENT_AI_MOVE_TO_UNITS None, AI_AnyThreat
          MOVEMENT_AI_BRA aMovementAI00Script

        aMovementAI01Script ; 8F/820E

          ; Move only when a target in in range.

          MOVEMENT_AI_MOVE_TO_REACHABLE_UNITS None, AI_AnyThreat
          MOVEMENT_AI_BRA aMovementAI01Script

        aMovementAI02Script ; 8F/8215

          ; Unused. Same as aMovementAI00Script but
          ; with a really low max threat?

          MOVEMENT_AI_MOVE_TO_UNITS None, 2
          MOVEMENT_AI_BRA aMovementAI02Script

        aMovementAI12Script ; 8F/821C

          ; Unused. Move to anyone but Leif.

          MOVEMENT_AI_MOVE_TO_UNITS AIIgnoreTables.aLeif, AI_AnyThreat
          MOVEMENT_AI_BRA aMovementAI12Script

        aMovementAI03Script ; 8F/8223

          ; Stationary AI.

          MOVEMENT_AI_SET_STATIONARY_FLAG
          MOVEMENT_AI_BRA aMovementAI03Script

        aMovementAI04Script ; 8F/8229

          ; Chapter 14 Arion
          ; Arion's only around for a cutscene,
          ; so this is basically unused.

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER Leif, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 0, aMovementAI04Script

          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], narrow(-1, size(byte)), _NoLeif

          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, +

            MOVEMENT_AI_MOVE_TO_UNITS None, AI_AnyThreat
            MOVEMENT_AI_BRA aMovementAI04Script

          +
            MOVEMENT_AI_CALL_ASM rsAIASMCSetBusyStatus
            MOVEMENT_AI_BRA aMovementAI04Script

          _NoLeif
            MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Pursue

        aMovementAI05Script ; 8F/8254

          ; Thieves in chapters 10, 12x, 23, 24?

          ; Try to target houses, then flee?

          MOVEMENT_AI_MOVE_TO_INTERACTABLE_TERRAIN $00, AI_AnyThreat
          MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

        aMovementAI06Script ; 8F/825C

          ; Thieves in chapters 12x, 18 and
          ; brigands in chapter 19.

          ; Try to target houses, then flee?

          MOVEMENT_AI_MOVE_TO_INTERACTABLE_TERRAIN $01, AI_AnyThreat
          MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

        aMovementAI23Script ; 8F/8264

          ; Thieves in chapter 19.

          MOVEMENT_AI_MOVE_TO_INTERACTABLE_TERRAIN $03, AI_AnyThreat
          MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

        aMovementAI07Script ; 8F/826C

          ; Try to stay out of range of enemies if
          ; unit has no weapons. Stand still while
          ; still holding a weapon.

          MOVEMENT_AI_CALL_ASM rsAIASMCCountWeaponsInInventory
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 0, +

            MOVEMENT_AI_SET_STATIONARY_FLAG
            MOVEMENT_AI_BRA aMovementAI07Script

          +
          MOVEMENT_AI_MOVE_IF_THREATENED 1
          MOVEMENT_AI_BRA aMovementAI07Script

        aMovementAIUnused8F8285Script ; 8F/8285

          ; Unused. Stand still until turn 3, then
          ; charge.

          MOVEMENT_AI_CALL_ASM rsAIASMCGetCurrentTurn
          MOVEMENT_AI_BGE aAIMainVariables.aTemp._Vars[0], 3, +

            MOVEMENT_AI_SET_STATIONARY_FLAG
            MOVEMENT_AI_BRA aMovementAIUnused8F8285Script

          +
          MOVEMENT_AI_SET_AI ActionAI_IgnoreNone, MovementAI_Pursue

        aMovementAI08Script ; 8F/829C

          ; Move towards enemies in 1.5x movement range.

          MOVEMENT_AI_CALL_ASM rsAIASMCCountTargetsInScaledMovementRange, [1, 5]
          MOVEMENT_AI_BGT aAIMainVariables.aTemp._Vars[0], 0, +

            MOVEMENT_AI_SET_STATIONARY_FLAG
            MOVEMENT_AI_BRA aMovementAI08Script

          +
          MOVEMENT_AI_SET_AI ActionAI_IgnoreNone, MovementAI_Pursue

        aMovementAI09Script ; 8F/82B3

          ; Destroy houses, then charge.

          MOVEMENT_AI_MOVE_TO_INTERACTABLE_TERRAIN $00, AI_AnyThreat
          MOVEMENT_AI_SET_AI ActionAI_IgnoreNone, MovementAI_Pursue

        aMovementAI0AScript ; 8F/82BB

          ; Patrol until an enemy is in range, then
          ; switch AI of all units with the same ActionAI and
          ; MovementAI settings to charge.

          MOVEMENT_AI_CALL_ASM rsAIASMCPatrolUntilAlerted
          MOVEMENT_AI_BGT aAIMainVariables.aTemp._Vars[0], 0, +

            MOVEMENT_AI_BRA aMovementAI0AScript

          +
          MOVEMENT_AI_CALL_ASM rsAIASMCUpdateMovementGroupAI, [ActionAI_IgnoreNone, MovementAI_Pursue]

        aMovementAI10Script ; 8F/82D2

          ; Move randomly.

          MOVEMENT_AI_RANDOM
          MOVEMENT_AI_BRA aMovementAI10Script

        aMovementAI0BScript ; 8F/82D8

          ; Flee.

          MOVEMENT_AI_BEGIN_RETREAT
          MOVEMENT_AI_BRA aMovementAI0BScript

        aMovementAI0CScript ; 8F/82DE

          ; Try to move to isolated units.

          MOVEMENT_AI_CALL_ASM rsAIASMCMoveToIsolatedTarget, [AI_AnyThreat]
          MOVEMENT_AI_BRA aMovementAI0CScript

        aMovementAI0DScript ; 8F/82E8

          ; Unused, identical to aMovementAI17Script.

          MOVEMENT_AI_TARGET_BREAKABLE_WALLS $01, AI_AnyThreat
          MOVEMENT_AI_SET_AI ActionAI_IgnoreNone, MovementAI_CaptureGate

        aMovementAI17Script ; 8F/82F0

          ; Chapter 20 Armored Axes.
          ; Try to break walls.

          MOVEMENT_AI_TARGET_BREAKABLE_WALLS $01, AI_AnyThreat
          MOVEMENT_AI_SET_AI ActionAI_IgnoreNone, MovementAI_CaptureGate

        aMovementAI24Script ; 8F/82F8

          ; Chapter 20 Armored Lances.
          ; Try to move to broken walls?

          MOVEMENT_AI_TARGET_BREAKABLE_WALLS $00, AI_AnyThreat
          MOVEMENT_AI_SET_AI ActionAI_IgnoreNone, MovementAI_CaptureThrone

        aMovementAI0EScript ; 8F/8300

          ; Chapter 9 wyverns.
          ; Try to capture the gate, attack units otherwise.

          ; Returns 5 if terrain blocked?

          MOVEMENT_AI_MOVE_TO_TERRAIN TerrainExit, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 5, +

            MOVEMENT_AI_BRA aMovementAI0EScript

          +
          MOVEMENT_AI_MOVE_TO_UNITS None, AI_AnyThreat
          MOVEMENT_AI_BRA aMovementAI0EScript

        aMovementAI0FScript ; 8F/8314

          ; Try to capture the gate, attack units otherwise.

          MOVEMENT_AI_MOVE_TO_TERRAIN TerrainGate, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 5, +

            MOVEMENT_AI_BRA aMovementAI0FScript

          +
          MOVEMENT_AI_MOVE_TO_UNITS None, AI_AnyThreat
          MOVEMENT_AI_BRA aMovementAI0FScript

        aMovementAI18Script ; 8F/8328

          ; Unused. Try to capture the church, then
          ; try gates.

          MOVEMENT_AI_MOVE_TO_TERRAIN TerrainChurch, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 5, +

            MOVEMENT_AI_BRA aMovementAI0FScript

          +
          MOVEMENT_AI_MOVE_TO_UNITS None, AI_AnyThreat
          MOVEMENT_AI_BRA aMovementAI0FScript

        aMovementAI22Script ; 8F/833C

          ; Try to capture the throne, attack units otherwise.

          MOVEMENT_AI_MOVE_TO_TERRAIN TerrainThrone, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 5, +

            MOVEMENT_AI_BRA aMovementAI22Script

          +
          MOVEMENT_AI_MOVE_TO_UNITS None, AI_AnyThreat
          MOVEMENT_AI_BRA aMovementAI22Script

        aMovementAI11Script ; 8F/8350

          ; Move to Leif and try to talk to him.
          ; Otherwise, target anyone.

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER Leif, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, _Talk

          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 3, +
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 2, +

            MOVEMENT_AI_BRA aMovementAI11Script

          +
          MOVEMENT_AI_MOVE_TO_UNITS None, AI_AnyThreat
          MOVEMENT_AI_BRA aMovementAI11Script

          _Talk
          MOVEMENT_AI_TALK 0
          MOVEMENT_AI_BRA aMovementAI11Script

        aMovementAI13Script ; 8F/8376

          ; Identical to aMovementAI0BScript.

          MOVEMENT_AI_BEGIN_RETREAT
          MOVEMENT_AI_BRA aMovementAI13Script

        aMovementAI14Script ; 8F/837C

          ; Chapter 9 wyverns.
          ; Wait for an opponent to enter range before switching
          ; group's AI to charge.

          MOVEMENT_AI_CALL_ASM rsAIASMCPatrolUntilAlerted
          MOVEMENT_AI_BGT aAIMainVariables.aTemp._Vars[0], 0, +

            MOVEMENT_AI_BRA aMovementAI14Script

          +
          MOVEMENT_AI_CALL_ASM rsAIASMCUpdateMovementGroupAI, [ActionAI_IgnoreNone, MovementAI_CaptureGate]

        aMovementAI15Script ; 8F/8393

          ; Stand still until an enemy enters attack range,
          ; then switch group AI to charge.

          MOVEMENT_AI_CALL_ASM rsAIASMCCountTargetsInScaledAttackRange, [1, 0]
          MOVEMENT_AI_BGT aAIMainVariables.aTemp._Vars[0], 0, +

            MOVEMENT_AI_SET_STATIONARY_FLAG
            MOVEMENT_AI_BRA aMovementAI15Script

          +
          MOVEMENT_AI_CALL_ASM rsAIASMCUpdateMovementGroupAI, [ActionAI_IgnoreNone, MovementAI_Pursue]

        aMovementAI16Script ; 8F/83AD

          ; Chapter 11x Olwen.
          ; Stay close to Fred, flee otherwise.

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER Fred, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, +
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 2, ++
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], narrow(-1, size(byte)), +++

            MOVEMENT_AI_BRA aMovementAI16Script

          +
          MOVEMENT_AI_CALL_ASM rsAIASMCSetBusyStatus
          MOVEMENT_AI_BRA aMovementAI16Script

          +
          MOVEMENT_AI_BEGIN_RETREAT
          MOVEMENT_AI_BRA aMovementAI16Script

          +
          MOVEMENT_AI_SET_AI ActionAI_NoAction, MovementAI_Flee

        aMovementAI19Script ; 8F/83DA

          ; Chapter 17B NPCs, approach gate, move
          ; randomly once closeby.

          MOVEMENT_AI_MOVE_TO_TERRAIN TerrainGate, AI_AnyThreat

          MOVEMENT_AI_CALL_ASM rsAIASMCCheckIfUnitInArea, [1, 1, 7, 6]
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 0, aMovementAI19Script

            MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Random

        aMovementAI1AScript ; 8F/83EF

          ; Chapter 18 Civilian9

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER XavierArmor1, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 2, _Stop
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, _Talk
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 3, +
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], narrow(-1, size(byte)), +

            MOVEMENT_AI_BRA aMovementAI1AScript

          _Stop
          MOVEMENT_AI_SET_STATIONARY_FLAG
          MOVEMENT_AI_BRA aMovementAI1AScript

          _Talk
          MOVEMENT_AI_TALK 1

          +
          MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

        aMovementAI1BScript ; 8F/841B

          ; Chapter 18 Civilian10

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER XavierArmor2, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 2, _Stop
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, _Talk
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 3, +
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], narrow(-1, size(byte)), +

            MOVEMENT_AI_BRA aMovementAI1BScript

          _Stop
          MOVEMENT_AI_SET_STATIONARY_FLAG
          MOVEMENT_AI_BRA aMovementAI1BScript

          _Talk
          MOVEMENT_AI_TALK 2

          +
          MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

        aMovementAI1CScript ; 8F/8447

          ; Chapter 18 Civilian11

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER XavierArmor3, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 2, _Stop
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, _Talk
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 3, +
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], narrow(-1, size(byte)), +

            MOVEMENT_AI_BRA aMovementAI1CScript

          _Stop
          MOVEMENT_AI_SET_STATIONARY_FLAG
          MOVEMENT_AI_BRA aMovementAI1CScript

          _Talk
          MOVEMENT_AI_TALK 3

          +
          MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

        aMovementAI1DScript ; 8F/8473

          ; Chapter 18 Civilian12

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER XavierArmor4, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 2, _Stop
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, _Talk
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 3, +
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], narrow(-1, size(byte)), +

            MOVEMENT_AI_BRA aMovementAI1DScript

          _Stop
          MOVEMENT_AI_SET_STATIONARY_FLAG
          MOVEMENT_AI_BRA aMovementAI1DScript

          _Talk
          MOVEMENT_AI_TALK 4

          +
          MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

        aMovementAI1EScript ; 8F/849F

          ; Chapter 18 Civilian13

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER XavierArmor5, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 2, _Stop
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, _Talk
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 3, +
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], narrow(-1, size(byte)), +

            MOVEMENT_AI_BRA aMovementAI1EScript

          _Stop
          MOVEMENT_AI_SET_STATIONARY_FLAG
          MOVEMENT_AI_BRA aMovementAI1EScript

          _Talk
          MOVEMENT_AI_TALK 5

          +
          MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

        aMovementAI1FScript ; 8F/84CB

          ; Chapter 18 Civilian14

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER XavierArmor6, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 2, _Stop
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, _Talk
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 3, +
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], narrow(-1, size(byte)), +

            MOVEMENT_AI_BRA aMovementAI1FScript

          _Stop
          MOVEMENT_AI_SET_STATIONARY_FLAG
          MOVEMENT_AI_BRA aMovementAI1FScript

          _Talk
          MOVEMENT_AI_TALK 6

          +
          MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

        aMovementAI20Script ; 8F/84F7

          ; Chapter 18 Civilian15

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER XavierArmor7, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 2, _Stop
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, _Talk
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 3, +
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], narrow(-1, size(byte)), +

            MOVEMENT_AI_BRA aMovementAI20Script

          _Stop
          MOVEMENT_AI_SET_STATIONARY_FLAG
          MOVEMENT_AI_BRA aMovementAI20Script

          _Talk
          MOVEMENT_AI_TALK 7

          +
          MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

        aMovementAI21Script ; 8F/8523

          ; Chapter 18 Civilian16

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER XavierArmor8, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 2, _Stop
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, _Talk
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 3, +
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], narrow(-1, size(byte)), +

            MOVEMENT_AI_BRA aMovementAI21Script

          _Stop
          MOVEMENT_AI_SET_STATIONARY_FLAG
          MOVEMENT_AI_BRA aMovementAI21Script

          _Talk
          MOVEMENT_AI_TALK 8

          +
          MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

        aMovementAI25Script ; 8F/854F

          ; Chapter 22 Reinhardt after bridge tile changes.
          ; Don't attack Olwen.

          MOVEMENT_AI_MOVE_TO_UNITS AIIgnoreTables.aOlwen, AI_AnyThreat
          MOVEMENT_AI_BRA aMovementAI25Script

        aMovementAI26Script ; 8F/8556

          ; Chapter 22 Reinhardt group.
          ; Follow Reinhardt.

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER Reinhardt, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 0, aMovementAI26Script
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, +

            MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

          +
          MOVEMENT_AI_CALL_ASM rsAIASMCSetBusyStatus
          MOVEMENT_AI_BRA aMovementAI26Script

        aMovementAI27Script ; 8F/8574

          ; Chapter 23 wyverns after Altena leaves.
          ; Go after Ced but attack anyone.

          MOVEMENT_AI_MOVE_NEXT_TO_CHARACTER CedChp23, AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 0, aMovementAI27Script
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, +

            MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

          +
          MOVEMENT_AI_CALL_ASM rsAIASMCSetBusyStatus
          MOVEMENT_AI_BRA aMovementAI27Script

        aMovementAI28Script ; 8F/8592

          ; Unused.

          MOVEMENT_AI_MOVE_TO_COORDINATES [10, 7], AI_AnyThreat
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 1, ++
          MOVEMENT_AI_BEQ aAIMainVariables.aTemp._Vars[0], 2, +

            MOVEMENT_AI_BRA aMovementAI28Script

          +
          MOVEMENT_AI_SET_STATIONARY_FLAG
          MOVEMENT_AI_BRA aMovementAI28Script

          +
          MOVEMENT_AI_TALK 0
          MOVEMENT_AI_SET_AI AI_NoChange, MovementAI_Flee

        aMovementAI29Script ; 8F/85B3

          ; Ignore chapter 3 NPCs

          MOVEMENT_AI_MOVE_TO_UNITS AIIgnoreTables.aChapter3NPCs, AI_AnyThreat
          MOVEMENT_AI_BRA aMovementAI29Script

        aMovementAI2AScript ; 8F/85BA

          ; Avoid being in range of more than one enemy.

           MOVEMENT_AI_MOVE_IF_THREATENED 1
           MOVEMENT_AI_BRA aMovementAI2AScript

      .endsection MovementAIScriptSection

      .section AIRecoveryThresholdTableSection

        aAIRecoveryThresholdTable ; 8F/85C0
          .for _RecoveryThreshold, _RecoveredThreshold in RecoveryThresholdList

            .byte _RecoveryThreshold, _RecoveredThreshold

          .endfor

      .endsection AIRecoveryThresholdTableSection

      .section AIChapterCoordinatesSection

        aAIChapterPatrolCoordinatePointers .block ; 8F/88F2
          Chapter1     .addr aAIDummyCoordinates
          Chapter2     .addr aAIDummyCoordinates
          Chapter2x    .addr aAIDummyCoordinates
          Chapter3     .addr aAIDummyCoordinates
          Chapter4     .addr aAIChapter4PatrolCoordinates
          Chapter4x    .addr aAIDummyCoordinates
          Chapter5     .addr aAIDummyCoordinates
          Chapter6     .addr aAIChapter6PatrolCoordinates
          Chapter7     .addr aAIDummyCoordinates
          Chapter8     .addr aAIDummyCoordinates
          Chapter8x    .addr aAIDummyCoordinates
          Chapter9     .addr aAIChapter9PatrolCoordinates
          Chapter10    .addr aAIDummyCoordinates
          Chapter11    .addr aAIDummyCoordinates
          Chapter11x   .addr aAIDummyCoordinates
          Chapter12    .addr aAIDummyCoordinates
          Chapter12x   .addr aAIDummyCoordinates
          Chapter13    .addr aAIDummyCoordinates
          Chapter14    .addr aAIDummyCoordinates
          Chapter14x   .addr aAIDummyCoordinates
          Chapter15    .addr aAIDummyCoordinates
          Chapter16A   .addr aAIDummyCoordinates
          Chapter17A   .addr aAIDummyCoordinates
          Chapter16B   .addr aAIDummyCoordinates
          Chapter17B   .addr aAIDummyCoordinates
          Chapter18    .addr aAIDummyCoordinates
          Chapter19    .addr aAIDummyCoordinates
          Chapter20    .addr aAIDummyCoordinates
          Chapter21    .addr aAIDummyCoordinates
          Chapter21x   .addr aAIDummyCoordinates
          Chapter22    .addr aAIDummyCoordinates
          Chapter23    .addr aAIDummyCoordinates
          Chapter24    .addr aAIDummyCoordinates
          Chapter24x   .addr aAIDummyCoordinates
          ChapterFinal .addr aAIDummyCoordinates
        .bend

        aAIChapter4PatrolCoordinates .macroAIPatrolCoordinates Chapter4AIPatrolCoordinateList ; 8F/8938

        aAIChapter6PatrolCoordinates .macroAIPatrolCoordinates Chapter6AIPatrolCoordinateList ; 8F/898C

        aAIChapter9PatrolCoordinates .macroAIPatrolCoordinates Chapter9AIPatrolCoordinateList ; 8F/89A1

        aAIChapterCoordinatePointers .block ; 8F/89BA
          Chapter1     .addr aAIChapter1Coordinates
          Chapter2     .addr aAIDummyCoordinates
          Chapter2x    .addr aAIDummyCoordinates
          Chapter3     .addr aAIDummyCoordinates
          Chapter4     .addr aAIDummyCoordinates
          Chapter4x    .addr aAIDummyCoordinates
          Chapter5     .addr aAIDummyCoordinates
          Chapter6     .addr aAIDummyCoordinates
          Chapter7     .addr aAIDummyCoordinates
          Chapter8     .addr aAIDummyCoordinates
          Chapter8x    .addr aAIDummyCoordinates
          Chapter9     .addr aAIDummyCoordinates
          Chapter10    .addr aAIDummyCoordinates
          Chapter11    .addr aAIDummyCoordinates
          Chapter11x   .addr aAIDummyCoordinates
          Chapter12    .addr aAIDummyCoordinates
          Chapter12x   .addr aAIDummyCoordinates
          Chapter13    .addr aAIDummyCoordinates
          Chapter14    .addr aAIDummyCoordinates
          Chapter14x   .addr aAIDummyCoordinates
          Chapter15    .addr aAIDummyCoordinates
          Chapter16A   .addr aAIDummyCoordinates
          Chapter17A   .addr aAIDummyCoordinates
          Chapter16B   .addr aAIDummyCoordinates
          Chapter17B   .addr aAIDummyCoordinates
          Chapter18    .addr aAIDummyCoordinates
          Chapter19    .addr aAIDummyCoordinates
          Chapter20    .addr aAIDummyCoordinates
          Chapter21    .addr aAIDummyCoordinates
          Chapter21x   .addr aAIDummyCoordinates
          Chapter22    .addr aAIDummyCoordinates
          Chapter23    .addr aAIDummyCoordinates
          Chapter24    .addr aAIDummyCoordinates
          Chapter24x   .addr aAIDummyCoordinates
          ChapterFinal .addr aAIDummyCoordinates
        .bend

        aAIChapter1Coordinates .macroAISpecialCoordinates Chapter1AISpecialCoordinateList ; 8F/8A00

        aAIDummyCoordinates .macroAISpecialCoordinates DummyAISpecialCoordinateList ; 8F/8A0C

      .endsection AIChapterCoordinatesSection

      .section AIIgnoreTableSection

        AIIgnoreTables .block

          aLeif .macroAIIgnoreList LeifAIIgnoreList ; 8F/8B6B
          aChapter18NPCs .macroAIIgnoreList Chapter18NPCAIIgnoreList ; 8F/8B6F
          aChapter19NPCS .macroAIIgnoreList Chapter19NPCAIIgnoreList ; 8F/8B81
          aOlwen .macroAIIgnoreList OlwenAIIgnoreList ; 8F/8B8B
          aChapter3NPCs .macroAIIgnoreList Chapter3NPCAIIgnoreList ; 8F/8B8F
          aDummy .macroAIIgnoreList DummyAIIgnoreList ; 8F/8B99

        .endblock

      .endsection AIIgnoreTableSection

.endif ; GUARD_FE5_AI
