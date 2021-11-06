
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_ACTIONSTRUCT :?= false
.if (!GUARD_FE5_ACTIONSTRUCT)
  GUARD_FE5_ACTIONSTRUCT := true

  .include "../../VoltEdge/VoltEdge.h"

  ; Definitions

    .weak

      rlUnsignedMultiply16By16                      :?= address($80AA27)
      rlUnsignedDivide16By8                         :?= address($80AAC3)
      rlGetRandomNumber100                          :?= address($80B0E6)
      rlBlockFillWord                               :?= address($80B36C)
      rlGetMapUnitsInRange                          :?= address($80E5CD)
      rlFillMapByWord                               :?= address($80E849)
      rlUpdateSaveSlotLosses                        :?= address($81C99F)
      rlGetCharacterWinLossTableOffset              :?= address($81C9C7)
      rlGetMapTileIndexByCoords                     :?= address($838E76)
      rlCopyCharacterDataToBufferByDeploymentNumber :?= address($83901C)
      rlCopyCharacterDataFromBuffer                 :?= address($839041)
      rlCopyExpandedCharacterDataBufferToBuffer     :?= address($83905C)
      rlCombineCharacterDataAndClassBases           :?= address($8390BE)
      rlCopyClassDataToBuffer                       :?= address($8393E0)
      rlClampCharacterStats                         :?= address($839278)
      rlCopyCharacterDataToBuffer                   :?= address($83941A)
      rlGetEquippableItemInventoryOffset            :?= address($839705)
      rlSearchForUnitAndWriteTargetToBuffer         :?= address($83976E)
      rlRunRoutineForAllUnitsInAllegiance           :?= address($839825)
      rlRunRoutineForAllVisibleUnitsInRange         :?= address($8398FD)
      rlRunRoutineForAllItemsInInventory            :?= address($83993C)
      rlTryGiveCharacterItemFromBuffer              :?= address($83A443)
      rlRollRandomNumber0To100                      :?= address($83A791)
      rlGetTier1ClassRelativePowerModifier          :?= address($83A9EC)
      rlCheckIfTileIsGateOrThroneByTerrainID        :?= address($83AF3F)
      rlCopyItemDataToBuffer                        :?= address($83B00D)
      rlTryGetBrokenItemID                          :?= address($83B0B7)
      rlUnknown848E5A                               :?= address($848E5A)

      rsActionStructGetItemInfoAndCapturingStats   :?= address($83D085)
      rsActionStructGetTerrainBonusesAndDistance   :?= address($83D1F3)
      rsActionStructGetStatsNoTerrainOrSupports    :?= address($83D295)
      rsActionStructGetStatsWithTerrainAndSupports :?= address($83D2AE)

      ; Action struct types

        ActionStruct_Default         :?= 0
        ActionStruct_EnemyInitiated  :?= 1
        ActionStruct_PlayerInitiated :?= 2
        ActionStruct_Unknown3        :?= 3
        ActionStruct_Single          :?= 4

      ; Bitfields

        ; TODO: names, unknowns

        RoundFlowFlag01             := bits($01)
        RoundFlowFlagDefenderMove   := bits($02)
        RoundFlowFlag04             := bits($04)
        RoundFlowFlag08             := bits($08)
        RoundFlowFlagUnitKilled     := bits($10)
        RoundFlowFlagDefenderKilled := bits($20)
        RoundFlowFlag40             := bits($40)
        RoundFlowFlag80             := bits($80)

        RoundAttackFlagCritical     := bits($0001)
        RoundAttackFlagMiss         := bits($0002)
        RoundAttackFlagPavise       := bits($0004)
        RoundAttackFlagImmortal     := bits($0008)
        RoundAttackFlagAstra        := bits($0010)
        RoundAttackFlagLuna         := bits($0020)
        RoundAttackFlagSol          := bits($0040)
        RoundAttackFlagWeaponEffect := bits($0080)
        RoundAttackFlagDouble       := bits($0100)
        RoundAttackFlagCounter      := bits($0200)
        RoundAttackFlagUnableToAct  := bits($0400)
        RoundAttackFlag0800         := bits($0800)
        RoundAttackFlag1000         := bits($1000)
        RoundAttackFlag2000         := bits($2000)
        RoundAttackFlag4000         := bits($4000)
        RoundAttackFlag8000         := bits($8000)

      ; Stat stuff?

        ; These should probably be moved into
        ; a different file or something?

        HPCap   := 80
        StatCap := 20

        LevelCap := 20
        ExperienceCap := 100

        CritCap := 100
        FirstAttackCritCap := 25

    .endweak

  ; Freespace inclusions

    .section ActionStructSingleSection

      rlActionStructSingleEntry ; 83/CE64

        .xl
        .autsiz
        .databank ?

        ; Writes a unit's action struct to
        ; aActionStructUnit1, filling aActionStructUnit2
        ; with a dummy unit.

        ; Inputs:
        ; wR0: short pointer to character buffer
        ;   filled with character

        ; Outputs:
        ; aActionStructUnit1: unit
        ; aActionStructUnit2: dummy unit

        php
        phb

        sep #$20

        lda #`aActionStructUnit1
        pha

        rep #$20

        plb

        .databank `aActionStructUnit1

        ; Write flag for single battle struct entry.

        lda #ActionStruct_Single
        sta wActionStructType

        jsr rsActionStructGetBaseStats

        ; Use a dummy second entry and write bonuses,
        ; discard distance.

        sep #$20

        lda #Dancer
        sta aActionStructUnit2.Class

        rep #$20

        jsr rsActionStructGetTerrainBonusesAndDistance

        sep #$20

        lda #-1
        sta bActionStructDistance

        rep #$20

        jsr rsActionStructGetItemInfoAndCapturingStats

        ldx #<>aActionStructUnit1
        ldy #<>aActionStructUnit2

        ; Ally units don't get bonuses from terrain or supports
        ; factored in during the prep screen. Enemies always have
        ; terrain and supports factored in.

        lda aActionStructUnit1.DeploymentNumber
        and #AllAllegiances
        bne +

          lda wPrepScreenFlag,b
          bne _Prep

        +
        jsr rsActionStructGetStatsWithTerrainAndSupports
        plb
        plp
        rtl

        _Prep
        jsr rsActionStructGetStatsNoTerrainOrSupports
        plb
        plp
        rtl

        .databank 0

    .endsection ActionStructSingleSection

    .section ActionStructGetBaseStatsSection

      rsActionStructGetBaseStats ; 83/CFED

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Writes preliminary stats
        ; to the action structs, depending
        ; on action struct type.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        lda #<>aActionStructUnit1
        sta lR18
        jsr rsActionStructClearActionStruct

        ; I don't think wR1 is passed in and
        ; wR0 (later) isn't used.

        lda wR1
        pha

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        jsr rsActionStructCopyStartingStats

        pla
        sta wR0

        lda wActionStructType
        cmp #ActionStruct_Single
        beq _End

          lda #<>aActionStructUnit2
          sta lR18
          jsr rsActionStructClearActionStruct

          lda #<>aActionStructUnit2
          sta wR1
          jsl rlCopyCharacterDataToBufferByDeploymentNumber

          jsr rsActionStructCopyStartingStats

        _End
        rts

        .databank 0

    .endsection ActionStructGetBaseStatsSection

    .section ActionStructClearActionStructSection

      rsActionStructClearActionStruct ; 83/D024

        .autsiz
        .databank `aActionStructUnit1

        ; Given a short pointer to an action
        ; struct in lR18, clear it.

        ; Inputs:
        ; lR18: short pointer to action struct

        ; Outputs:
        ; None

        sep #$20

        ldy #size(structActionStructEntry)-size(byte)
        lda #0

        -
          sta (lR18),y
          dec y
          bpl -

        rep #$30

        rts

        .databank 0

    .endsection ActionStructClearActionStructSection

    .section ActionStructCopyStartingStatsSection

      rlActionStructCopyStartingStatsWrapper ; 83/D033

        .autsiz
        .databank `aActionStructUnit1

        ; jsl wrapper for rsActionStructCopyStartingStats

        jsr rsActionStructCopyStartingStats
        rtl

        .databank 0

      rsActionStructCopyStartingStats ; 83/D037

        .autsiz
        .databank `aActionStructUnit1

        ; Given a short pointer to an action
        ; struct in wR1, write stats to their
        ; starting stats.

        ; Inputs:
        ; wR1: short pointer to action struct

        ; Outputs:
        ; None

        _StatList  := [(structActionStructEntry.MaxHP, structActionStructEntry.StartingMaxHP)]
        _StatList ..= [(structActionStructEntry.CurrentHP, structActionStructEntry.StartingCurrentHP)]
        _StatList ..= [(structActionStructEntry.Level, structActionStructEntry.StartingLevel)]
        _StatList ..= [(structActionStructEntry.Experience, structActionStructEntry.StartingExperience)]
        _StatList ..= [(structActionStructEntry.Class, structActionStructEntry.StartingClass)]
        _StatList ..= [(structActionStructEntry.Status, structActionStructEntry.PostBattleStatus)]

        php

        sep #$20

        ldx wR1

        .for _Tup in _StatList

          _Source := _Tup[0]
          _Dest   := _Tup[1]

          lda _Source,b,x
          sta _Dest,b,x

        .endfor

        stz structActionStructEntry.GainedExperience,b,x
        stz structActionStructEntry.EquippedItemID1,b,x

        lda #-1
        sta structActionStructEntry.WeaponEXP,b,x

        plp
        rts

        .databank 0

    .endsection ActionStructCopyStartingStatsSection

    .section ActionStructTrySetUnitCoordinatesSection

      rsActionStructTrySetUnitCoordinates ; 83/D06D

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; If enemy initiated, write coordinates.

        ; Inputs:
        ; wR2: X coordinates
        ; wR3: Y coordinate

        ; Outputs:
        ; None

        lda wActionStructType
        cmp #ActionStruct_EnemyInitiated
        beq +

          rts

        +
        sep #$20

        lda wR2
        sta aActionStructUnit1.X

        lda wR3
        sta aActionStructUnit1.Y

        rep #$30

        rts

        .databank 0

    .endsection ActionStructTrySetUnitCoordinatesSection

    .section ActionStructGetCoreStatsSection

      rsActionStructCheckUnkillable ; 83/D4AC

        .autsiz
        .databank `aActionStructUnit1

        ; Given a short pointer to an action struct
        ; in X, flag a unit as unkillable.

        ; Inputs:
        ; X: short pointer to action struct

        ; Outputs:
        ; None

        sep #$20

        stz structActionStructEntry.UnkillableFlag,b,x

        rep #$30

        cpx #<>aActionStructUnit1
        beq +

          lda wCapturingFlag
          bne _Continue

        +
        lda structActionStructEntry.Skills2,b,x
        bit #pack([None, Skill3Immortal])
        bne _Unkillable

        _Continue
        lda structActionStructEntry.Skills2,b,x
        bit #pack([Skill2Miracle, None])
        beq +

          lda structActionStructEntry.Luck,b,x
          clc
          adc structActionStructEntry.Luck,b,x
          clc
          adc structActionStructEntry.Luck,b,x
          and #$00FF
          jsl rlRollRandomNumber0To100
          bcc +

            _Unkillable
            inc structActionStructEntry.UnkillableFlag,b,x

        +
        rts

        .databank 0

    .endsection ActionStructGetCoreStatsSection

    .section ActionStructRoundSection

      rsActionStructGetGeneratedRoundBitfields ; 83/D4E5

        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; Writes the current round accessed
        ; by wActionStructGeneratedRoundOffset to
        ; the temp area.

        ; Inputs:
        ;   wActionStructGeneratedRoundOffset: offset into aActionStructGeneratedRounds
        ;   aActionStructGeneratedRounds: filled with rounds

        ; Outputs:
        ;   wActionStructRoundFlowBitfield: structBattleGeneratedRound.FlowFlagBitfield
        ;   wActionStructRoundAttackBitfield: structBattleGeneratedRound.AttackFlagBitfield

        php
        phx

        rep #$30

        ldx wActionStructGeneratedRoundOffset
        lda aActionStructGeneratedRounds+structBattleGeneratedRound.AttackFlagBitfield,x
        sta wActionStructRoundAttackBitfield

        lda aActionStructGeneratedRounds+structBattleGeneratedRound.FlowFlagBitfield,x
        and #$00FF
        sta wActionStructRoundFlowBitfield

        plx
        plp
        rts

        .databank 0

      rsActionStructGetGeneratedRoundBitfieldsAndAdvance ; 83/D4FE

        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; Writes the current round accessed
        ; by wActionStructGeneratedRoundOffset to
        ; the temp area and advances an entry.

        ; Inputs:
        ;   wActionStructGeneratedRoundOffset: offset into aActionStructGeneratedRounds
        ;   aActionStructGeneratedRounds: filled with rounds

        ; Outputs:
        ;   wActionStructRoundFlowBitfield: structBattleGeneratedRound.FlowFlagBitfield
        ;   wActionStructRoundAttackBitfield: structBattleGeneratedRound.AttackFlagBitfield
        ;   wActionStructGeneratedRoundOffset: advanced an entry

        php
        phb

        sep #$20

        lda #`aActionStructGeneratedRounds
        pha

        rep #$20

        plb

        .databank `aActionStructGeneratedRounds

        phx
        rep #$30

        ldx wActionStructGeneratedRoundOffset

        lda aActionStructGeneratedRounds+structBattleGeneratedRound.AttackFlagBitfield,x
        sta wActionStructRoundAttackBitfield

        lda aActionStructGeneratedRounds+structBattleGeneratedRound.FlowFlagBitfield,x
        and #$00FF
        sta wActionStructRoundFlowBitfield

        txa
        clc
        adc #size(structBattleGeneratedRound)
        sta wActionStructGeneratedRoundOffset

        plx
        plb
        plp
        rts

        .databank 0

      rsActionStructWriteRound ; 83/D529

        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; Writes an entry to aActionStructGeneratedRounds
        ; using the temp area. Doesn't write the entry
        ; if the rounds array is full.

        ; Inputs:
        ;   wActionStructRoundFlowBitfield: filled with bitfield
        ;   wActionStructRoundAttackBitfield: filled with bitfield
        ;   wActionStructRoundTempDamage: damage
        ;   wActionStructGeneratedRoundOffset: offset into array to write to

        ; Outputs:
        ;   wActionStructGeneratedRoundOffset: advanced an entry
        ;   Carry set if array full, else carry clear and entry written
        ;     to aActionStructGeneratedRounds

        php
        phx

        rep #$30

        ldx wActionStructGeneratedRoundOffset

        cpx #size(aActionStructGeneratedRounds) - size(structBattleGeneratedRound)
        beq _Full

        lda wActionStructRoundAttackBitfield
        sta aActionStructGeneratedRounds+structBattleGeneratedRound.AttackFlagBitfield,x

        sep #$20

        lda wActionStructRoundFlowBitfield
        sta aActionStructGeneratedRounds+structBattleGeneratedRound.FlowFlagBitfield,x

        lda wActionStructRoundTempDamage
        sta aActionStructGeneratedRounds+structBattleGeneratedRound.Damage,x

        rep #$30

        txa
        clc
        adc #size(structBattleGeneratedRound)
        sta wActionStructGeneratedRoundOffset

        plx
        plp
        clc
        rts

        _Full
        plx
        plp
        sec
        rts

        .databank 0

      rsActionStructTerminateRoundArray ; 83/D55B

        .databank `wActionStructGeneratedRoundOffset

        php
        phx

        rep #$30

        ldx wActionStructGeneratedRoundOffset

        lda #-1
        sta aActionStructGeneratedRounds+structBattleGeneratedRound.AttackFlagBitfield,x

        lda wActionStructGeneratedRoundOffset
        sta wActionStructGeneratedRoundLastOffset

        sep #$20

        lda #-1
        sta aActionStructGeneratedRounds+structBattleGeneratedRound.FlowFlagBitfield,x

        lda #-1
        sta aActionStructGeneratedRounds+structBattleGeneratedRound.Damage,x

        plx
        plp
        rts

        .databank 0

      rsActionStructGetAttacksAndGenerateRounds ; 83/D57D

        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; Determines how many attacks a unit is
        ; going to make and writes round data for each.

        ; Inputs:
        ;   X: short pointer to attacker action struct
        ;   Y: short pointer to defender action struct

        ; Outputs:
        ;   aActionStructGeneratedRounds: rounds
        ;   wActionStructGeneratedRoundOffset: offset of terminator
        ;   wActionStructRoundTempUnknownAttackCount: number of attacks

        stz wActionStructGeneratedRoundOffset
        stz wActionStructRoundAttackBitfield
        stz wActionStructRoundTempDamage
        stz wActionStructRoundTempUnknownAttackCount
        stz wActionStructGeneratedRoundBonusCombat

        jsr rsActionStructAdjustVantageRoundOrder
        jsr rsActionStructRoundUnknownCheckIfDefender

        _AttackLoop
          inc wActionStructRoundTempUnknownAttackCount
          jsr rsActionStructRoundTryGetMultipleAttacks
          jsr rsActionStructRoundCheckBothAssail
          bcs _AttackLoop

        jsr rsActionStructTerminateRoundArray

        rts

        .databank 0

      rsActionStructRoundUnknownCheckIfDefender ; 83/D5A1

        .al
        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; Checks if the round actor is the defender.

        ; Inputs:
        ;   wActionStructGeneratedRoundActor

        ; Outputs:
        ;   wActionStructTempRoundAttackBitfield: 1 if defender, 0 otherwise

        stz wActionStructTempRoundAttackBitfield
        lda wActionStructGeneratedRoundActor
        beq +

          lda wActionStructTempRoundAttackBitfield
          ora #RoundFlowFlag01
          sta wActionStructTempRoundAttackBitfield

        +
        rts

        .databank 0

      rsActionStructRoundTryGetMultipleAttacks ; 83/D5B3

        .al
        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; Tries to get all attacks for both units.

        ; Inputs:
        ;   X: short pointer to attacker action struct
        ;   Y: short pointer to defender action struct

        ; Outputs:
        ;   aActionStructGeneratedRounds: rounds

        ; Fetch attacks made by the attacker.

        lda wActionStructGeneratedRoundUnknownActor
        sta wActionStructGeneratedRoundActor

        jsr rsActionStructRoundGetRoundCharacters
        phx
        phy

        lda wActionStructRoundFlowBitfield
        ora #RoundFlowFlag80
        sta wActionStructRoundFlowBitfield

        jsr rsActionStructRoundGetBattleLengthModifiers

        ; Fetch attacks made by the defender.

        jsr rsActionStructRoundGetRoundCharacters

        lda wActionStructRoundAttackBitfield
        ora #RoundAttackFlagCounter
        sta wActionStructRoundAttackBitfield

        jsr rsActionStructRoundGetBattleLengthModifiers
        jsr rsActionStructRoundGetRoundCharacters

        jsr rsActionStructRoundCheckDoubling
        bcc +

          jsr rsActionStructRoundGetBattleLengthModifiers

        +
        ply
        plx
        rts

        .databank 0

      rsActionStructRoundGetRoundCharacters ; 83/D5E7

        .al
        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; Gets which unit is attacking next.

        ; Inputs:
        ;   wActionStructGeneratedRoundActor: current attacker (0, 2)

        ; Outputs:
        ;   wActionStructRoundFlowBitfield: sets
        ;     RoundFlowFlagDefenderMove if
        ;     defender next
        ;   wActionStructGeneratedRoundActor: new attacker (0, 2)

        lda wActionStructTempRoundAttackBitfield
        sta wActionStructRoundFlowBitfield

        stz wActionStructRoundAttackBitfield

        lda wActionStructGeneratedRoundActor
        bit #$0002
        beq +

          lda wActionStructRoundFlowBitfield
          ora #RoundFlowFlagDefenderMove
          sta wActionStructRoundFlowBitfield

        +
        ldx wActionStructGeneratedRoundActor
        lda _CharacterOrderTable+size(word),x
        tay
        lda _CharacterOrderTable,x
        tax
        lda wActionStructGeneratedRoundActor
        eor #$0002
        sta wActionStructGeneratedRoundActor
        rts

        _CharacterOrderTable ; 83/D618
          .word <>aActionStructUnit1.Character
          .word <>aActionStructUnit2.Character
          .word <>aActionStructUnit1.Character

        .databank 0

      rsActionStructRoundGetBattleLengthModifiers ; 83/D61E

        .al
        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; If unit has a weapon, get all of the different
        ; ways they might get more than one attack.

        ; Inputs:
        ;   X: short pointer to attacker action struct
        ;   Y: short pointer to defender action struct

        ; Outputs:
        ;   aActionStructGeneratedRounds: rounds

        lda structActionStructEntry.EquippedItemID2,b,x
        and #$00FF
        beq +

          ; Number of attacks

          lda #1
          sta wActionStructGeneratedRoundVar1

          jsr rsActionStructRoundTryProcAstra
          jsr rsActionStructRoundTryProcAdept
          jsr rsActionStructRoundDoubleRoundsIfBrave
          jsr rsActionStructRoundFlushAttacksToRoundArray

        +
        rts

        .databank 0

      rsActionStructRoundCheckBothAssail ; 83/D639

        .al
        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; Increases the number of bonus rounds
        ; for each unit with assail.

        ; Inputs:
        ;   wActionStructType: struct type

        ; Outputs:
        ;   wActionStructGeneratedRoundBonusCombat: bonus rounds
        ;   Carry set if assail, else carry clear unless
        ;     struct type is ActionStruct_Unknown3, then carry set?

        lda wActionStructType
        cmp #ActionStruct_Unknown3
        bne +

        lda wActionStructGeneratedRoundOffset
        cmp #size(aActionStructGeneratedRounds) - size(structBattleGeneratedRound)
        beq _Full

        sec
        rts

        +
        lda wActionStructGeneratedRoundBonusCombat
        bne _NotAssail

          ldx #<>aActionStructUnit1
          ldy #<>aActionStructUnit2
          jsr rsActionStructRoundCheckAssail

          ldx #<>aActionStructUnit2
          ldy #<>aActionStructUnit1
          jsr rsActionStructRoundCheckAssail

          lda wActionStructGeneratedRoundBonusCombat
          beq _NotAssail

            sec
            rts

        _Full
        jsr rsActionStructTerminateRoundArray

        _NotAssail
        clc
        rts

        .databank 0

      rsActionStructRoundCheckAssail ; 83/D66E

        .al
        .autsiz
        .databank `wActionStructGeneratedRoundBonusCombat

        ; Increases wActionStructGeneratedRoundBonusCombat
        ; if the attacker has assail.

        ; Inputs:
        ;   X: short pointer to attacker action struct
        ;   Y: short pointer to defender action struct
        ;   wActionStructGeneratedRoundBonusCombat bonus rounds

        ; Outputs:
        ;   wActionStructGeneratedRoundBonusCombat: bonus rounds

        lda structActionStructEntry.Skills2,b,x
        bit #Skill2Assail
        beq +

          sep #$20

          lda structActionStructEntry.CurrentHP,b,x
          cmp structActionStructEntry.CurrentHP,b,y
          beq +
          blt +

            lda structActionStructEntry.BattleAttackSpeed,b,x
            cmp structActionStructEntry.BattleAttackSpeed,b,y
            beq +
            blt +

              inc wActionStructGeneratedRoundBonusCombat

        +
        rep #$30
        rts

        .databank 0

      rsActionStructRoundCheckDoubling ; 83/D692

        .xl
        .autsiz
        .databank `aActionStructUnit1

        ; Checks to see if either unit can double.

        ; Inputs:
        ;   aActionStructUnit1: filled with unit
        ;   aActionStructUnit2: filled with unit

        ; Outputs:
        ;   Bitfields set
        ;   X: short pointer to attacker action struct
        ;   Y: short pointer to defender action struct

        sep #$20

        lda aActionStructUnit1.BattleAttackSpeed
        sec
        sbc aActionStructUnit2.BattleAttackSpeed
        bpl +

          eor #-1
          inc a

        +
        cmp #4
        blt _NoDoubling

        lda aActionStructUnit1.BattleAttackSpeed
        cmp aActionStructUnit2.BattleAttackSpeed
        blt _DefenderDoubles

          ldx #<>aActionStructUnit1
          ldy #<>aActionStructUnit2
          lda wActionStructTempRoundAttackBitfield
          sta wActionStructRoundFlowBitfield
          bra _Continue

        _DefenderDoubles
          ldx #<>aActionStructUnit2
          ldy #<>aActionStructUnit1
          lda wActionStructTempRoundAttackBitfield
          ora #RoundFlowFlagDefenderMove
          sta wActionStructRoundFlowBitfield
          bra _Continue

        _NoDoubling
        rep #$30
        clc
        rts

        _Continue
        rep #$30

        lda #RoundAttackFlagDouble
        sta wActionStructRoundAttackBitfield
        sec
        rts

        .databank 0

      rsActionStructRoundTryProcAstra ; 83/D6D8

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Sets the number of attacks to 5 if unit
        ; has astra and procs it.

        ; Inputs:
        ;   X: short pointer to action struct

        ; Outputs:
        ;   wActionStructGeneratedRoundVar1: 5 if astra, unchanged otherwise
        ;   wActionStructRoundAttackBitfield: modified with RoundAttackFlagAstra
        ;     if astra, unchanged otherwise

        lda structActionStructEntry.Skills2,b,x
        bit #pack([None, Skill3Astra])
        beq +

          lda structActionStructEntry.Skill,b,x
          and #$00FF
          jsl rlRollRandomNumber0To100
          bcc +

            lda #5
            sta wActionStructGeneratedRoundVar1

            lda wActionStructRoundAttackBitfield
            ora #RoundAttackFlagAstra
            sta wActionStructRoundAttackBitfield

        +
        rts

        .databank 0

      rsActionStructRoundTryProcAdept ; 83/D6FC

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Sets the number of attacks to 2 if unit
        ; has adept and procs it, as long as astra
        ; wasn't triggered.

        ; Inputs:
        ;   X: short pointer to action struct

        ; Outputs:
        ;   wActionStructGeneratedRoundVar1: 2 if adept, unchanged otherwise

        lda #1
        cmp wActionStructGeneratedRoundVar1
        bne +

          lda structActionStructEntry.Skills2,b,x
          bit #Skill2Adept
          beq +

            lda structActionStructEntry.BattleAttackSpeed,b,x
            and #$00FF
            jsl rlRollRandomNumber0To100
            bcc +

              lda #2
              sta wActionStructGeneratedRoundVar1

        +
        rts

        .databank 0

      rsActionStructRoundDoubleRoundsIfBrave ; 83/D71F

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; If unit has brave, double number of attacks.

        ; Inputs:
        ;   X: short pointer to action struct

        ; Outputs:
        ;   wActionStructGeneratedRoundVar1: doubled if brave, unchanged otherwise

        lda structActionStructEntry.Skills2,b,x
        bit #pack([None, Skill3Brave])
        beq +

          asl wActionStructGeneratedRoundVar1

        +
        rts

        .databank 0

      rsActionStructRoundFlushAttacksToRoundArray ; 83/D72B

        .autsiz
        .databank `aActionStructUnit1

        ; Writes wActionStructGeneratedRoundVar1
        ; attacks to aActionStructGeneratedRounds

        ; Inputs:
        ;   wActionStructGeneratedRoundVar1: number of attacks
        ;   Bitfields, damage, etc. set

        ; Outputs:
        ;   aActionStructGeneratedRounds: rounds

        php
        rep #$30

        _Loop
          jsr rsActionStructWriteRound
          bcs +

            lda wActionStructRoundFlowBitfield
            and #~RoundFlowFlag80
            sta wActionStructRoundFlowBitfield

            lda wActionStructRoundAttackBitfield
            and #~RoundFlowFlagUnitKilled
            sta wActionStructRoundAttackBitfield

            dec wActionStructGeneratedRoundVar1
            bne _Loop

        +
        plp
        rts

        .databank 0

      rsActionStructClearGeneratedRounds ; 83/D74C

        .autsiz
        .databank `wActionStructGeneratedRoundVar1

        ; Clears aActionStructGeneratedRounds
        ; and related variables.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        php
        rep #$30

        lda #(`aActionStructGeneratedRounds)<<8
        sta lR18+size(byte)
        lda #<>aActionStructGeneratedRounds
        sta lR18
        lda #size(aActionStructGeneratedRounds)
        sta lR19
        lda #$0000
        jsl rlBlockFillWord

        stz wActionStructGeneratedRoundOffset
        stz wActionStructRoundFlowBitfield
        stz wActionStructRoundAttackBitfield
        stz wActionStructRoundTempDamage

        plp
        rts

        .databank 0

      rsActionStructRoundGetAttackerDefenderOrder ; 83/D773

        .al
        .xl
        .autsiz
        .databank `aActionStructUnit1

        ; Gives action structs in X/Y depending
        ; on whose move it is.

        ; Inputs:
        ;   wActionStructRoundFlowBitfield: actor

        ; Outputs:
        ;   X: short poitner to attacker action struct
        ;   Y: short pointer to defender action struct

        lda wActionStructRoundFlowBitfield
        bit #RoundFlowFlagDefenderMove
        beq +

          ldx #<>aActionStructUnit2
          ldy #<>aActionStructUnit1
          rts

        +
        ldx #<>aActionStructUnit1
        ldy #<>aActionStructUnit2
        rts

        .databank 0

      rsActionStructRoundGetRoundModifiers ; 83/D789

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Sets modifiers like crits and skills
        ; for each round.

        ; Inputs:
        ;   aActionStructUnit1: filled with unit
        ;   aActionStructUnit2: filled with unit

        ; Outputs:
        ;   aActionStructGeneratedRounds: rounds

        stz wActionStructGeneratedRoundOffset

        _Loop
        jsr rsActionStructGetGeneratedRoundBitfields

        ; Check for end of rounds terminator.

        lda wActionStructRoundAttackBitfield
        cmp #-1
        beq _End

          jsr rsActionStructRoundGetAttackerDefenderOrder

          stz wActionStructGeneratedRoundDamage

          jsr rsActionStructRoundTrySetUnableToAct
          bcs +

            jsr rsActionStructRoundStoreParameters
            jsr rsActionStructRoundAdjustCrit
            jsr rsActionStructRoundTryProcLuna
            jsr rsActionStructRoundTryProcSol
            jsr rsActionStructRoundTryProcPavise
            jsr rsActionStructRoundCheckWrath
            jsr rsActionStructRoundTryProcCrit
            jsr rsActionStructRoundApplyHit

          +
          jsr rsActionStructRoundWriteRoundAndMarkDeaths
          bcc _Loop

          jsr rsActionStructTerminateRoundArray

        _End
        rts

        .databank 0

      rsActionStructRoundTrySetUnableToAct ; 83/D7C3

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Marks a unit as unable to act if they're
        ; asleep or petrified.

        ; Inputs:
        ;   X: short pointer to action struct

        ; Outputs:
        ;   wActionStructRoundAttackBitfield: modified with
        ;     RoundAttackFlagUnableToAct if unable
        ;     to act, unchanged otherwise.
        ;   Carry set if unable to act, carry clear otherwise

        lda structActionStructEntry.Status,b,x
        and #$00FF
        cmp #StatusPetrify
        beq +

        cmp #StatusSleep
        beq +

          clc
          rts

        +
        lda wActionStructRoundAttackBitfield
        ora #RoundAttackFlagUnableToAct
        sta wActionStructRoundAttackBitfield
        sec
        rts

        .databank 0

      rsActionStructRoundStoreParameters ; 83/D7E0

        .al
        .autsiz
        .databank `wActionStructGeneratedRoundMight

        ; Gets stats used by a round.

        ; Inputs:
        ;   X: short pointer to action struct

        ; Outputs:
        ; None

        lda structActionStructEntry.BattleMight,b,x
        and #$00FF
        sta wActionStructGeneratedRoundMight

        lda structActionStructEntry.BattleDefense,b,y
        and #$00FF
        sta wActionStructGeneratedRoundDefense

        lda structActionStructEntry.BattleAdjustedHit,b,x
        and #$00FF
        sta wActionStructGeneratedRoundHit

        lda structActionStructEntry.BattleAdjustedCrit,b,x
        and #$00FF
        sta wActionStructGeneratedRoundCrit

        rts

        .databank 0

      rsActionStructRoundAdjustCrit ; 83/D805

        .al
        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; If a unit is doubling, calculate their critrate
        ; as BattleAdjustedCrit * CriticalCoefficient.

        ; If not a double attack, cap crit at FirstAttackCritCap.

        ; Inputs:
        ;   X: short pointer to action struct

        ; Outputs:
        ;   wActionStructGeneratedRoundCrit: adjusted crit

        lda wActionStructRoundAttackBitfield
        bit #RoundAttackFlagDouble
        bne _WithCoefficient

          lda wActionStructGeneratedRoundCrit
          cmp #FirstAttackCritCap
          blt _End

            lda #FirstAttackCritCap
            sta wActionStructGeneratedRoundCrit
            bra _End

        _WithCoefficient
          phx
          phy
          lda structActionStructEntry.CriticalCoefficient,b,x
          and #$00FF
          sta wR10
          lda structActionStructEntry.BattleAdjustedCrit,b,x
          and #$00FF
          sta wR11
          jsl rlUnsignedMultiply16By16

          ply
          plx
          lda wR12
          cmp #CritCap
          blt +

            lda #CritCap

          +
          sta wActionStructGeneratedRoundCrit

        _End
        rts

        .databank 0

      rsActionStructRoundTryProcLuna ; 83/D843

        .al
        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; Sets an attack as luna if the unit
        ; has it and it successfully procs.

        ; Inputs:
        ;   X: short pointer to action struct

        ; Outputs:
        ; None

        lda structActionStructEntry.Skills2,b,x
        bit #pack([None, Skill3Luna])
        beq +

          lda structActionStructEntry.Skill,b,x
          and #$00FF
          jsl rlRollRandomNumber0To100
          bcc +

            lda wActionStructRoundAttackBitfield
            ora #RoundAttackFlagLuna
            sta wActionStructRoundAttackBitfield

            stz wActionStructGeneratedRoundDefense

            lda #100
            sta wActionStructGeneratedRoundHit

        +
        rts

        .databank 0

      rsActionStructRoundTryProcSol ; 83/D86A

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Sets an attack as sol if the unit
        ; has it and it successfully procs.

        ; Will not proc if the unit is using a weapon
        ; with an effect (other than lifesteal).

        ; Inputs:
        ;   X: short pointer to action struct

        ; Outputs:
        ; None

        lda structActionStructEntry.Skills2,b,x
        bit #pack([None, Skill3Sol])
        beq _End

          lda structActionStructEntry.Skill,b,x
          and #$00FF
          jsl rlRollRandomNumber0To100
          bcc _End

            lda structActionStructEntry.EquippedItemID2,b,x
            jsl rlCopyItemDataToBuffer

            lda aItemDataBuffer.WeaponEffect,b
            beq +

              cmp #WeaponEffects.LifestealWeaponEffect
              beq +

              bra _End

        +
        lda #100
        sta wActionStructGeneratedRoundHit

        lda wActionStructRoundAttackBitfield
        ora #RoundAttackFlagSol
        sta wActionStructRoundAttackBitfield

        _End
        rts

        .databank 0

      rsActionStructRoundTryProcPavise ; 83/D8A1

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Tries to proc pavise. Will not
        ; proc if attacker has proc'd luna or sol
        ; during this attack.

        ; Inputs:
        ;   X: short pointer to attacker action struct
        ;   Y: short pointer to attacker action struct

        ; Outputs:
        ; None

        lda structActionStructEntry.Skills2,b,y
        bit #Skill2Pavise
        beq +

        lda structActionStructEntry.Level,b,y
        jsl rlRollRandomNumber0To100
        bcc +

        lda wActionStructRoundAttackBitfield
        bit #(RoundAttackFlagLuna | RoundAttackFlagSol)
        bne +

        lda wActionStructRoundAttackBitfield
        ora #RoundAttackFlagPavise
        sta wActionStructRoundAttackBitfield

        +
        rts

        .databank 0

      rsActionStructRoundCheckWrath ; 83/D8C4

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Checks if a unit has wrath and
        ; sets their crit to 100 if counterattacking.

        ; Inputs:
        ;   X: short pointer to action struct

        ; Outputs:
        ; None

        lda structActionStructEntry.Skills2,b,x
        bit #pack([None, Skill3Wrath])
        beq +

        lda wActionStructRoundAttackBitfield
        bit #RoundAttackFlagCounter
        beq +

          lda #100
          sta wActionStructGeneratedRoundCrit

        +
        rts

        .databank 0

      rsActionStructRoundNullDamageIfImmortal ; 83/D8DB

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Nullifies damage if the defender is immortal
        ; during this attack.

        ; Inputs:
        ;   X: short pointer to attacker action struct
        ;   Y: short pointer to defender action struct

        ; Outputs:
        ; None

        lda structActionStructEntry.CurrentHP,b,y
        and #$00FF
        sec
        sbc wActionStructGeneratedRoundDamage
        beq +
        bpl _False

        +
        lda structActionStructEntry.UnkillableFlag,b,y
        and #$00FF
        beq _False

        lda wActionStructRoundAttackBitfield
        ora #RoundAttackFlagImmortal
        sta wActionStructRoundAttackBitfield

        stz wActionStructGeneratedRoundDamage

        sec
        rts

        _False
        clc
        rts

        .databank 0

      rsActionStructRoundTryProcCrit ; 83/D901

        .al
        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; Checks if an attack was a crit, sets
        ; might accordingly.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        lda #100
        jsl rlGetRandomNumber100
        cmp wActionStructGeneratedRoundCrit
        bge +

          lda wActionStructRoundAttackBitfield
          ora #RoundAttackFlagCritical
          sta wActionStructRoundAttackBitfield

          lda wActionStructGeneratedRoundMight
          asl a
          sta wActionStructGeneratedRoundMight

        +
        rts

        .databank 0

      rsActionStructRoundApplyHit ; 83/D91E

        .al
        .autsiz
        .databank `wActionStructGeneratedRoundOffset

        ; Inputs:
        ;   X: short pointer to attacker action struct
        ;   Y: short pointer to defender action struct

        ; Outputs:
        ;   bUnknown7E4FCF: $02 on kill, unchanged otherwise
        ;   bUnknownTargetingDeploymentNumber: defender deployment
        ;     number on kill, unchanged otherwise

        jsr rsActionStructCalculateWEXPGain

        ; Pavise doesn't care if the attack
        ; would have dealt damage or missed.

        lda wActionStructRoundAttackBitfield
        bit #RoundAttackFlagPavise
        beq +

          jmp _End

        +
        lda wActionStructGeneratedRoundHit
        jsl rlRollRandomNumber0To100
        bcc _Miss

          lda wActionStructGeneratedRoundMight
          sec
          sbc wActionStructGeneratedRoundDefense
          bpl +

            lda #0

          +
          cmp #HPCap
          blt +

            lda #80

          +
          sta wActionStructGeneratedRoundDamage

          ; Immortal acts like a miss.

          jsr rsActionStructRoundNullDamageIfImmortal
          bcs _Miss

          jsr rsActionStructGetWeaponEffect
          jsr rsActionStructSwapUnitsIfDevilEffect

          sep #$20

          lda structActionStructEntry.CurrentHP,b,y
          sec
          sbc wActionStructGeneratedRoundDamage
          beq _Kill
          bpl +

            _Kill
            lda #$02
            sta bUnknown7E4FCF
            lda structActionStructEntry.DeploymentNumber,b,y
            sta bUnknownTargetingDeploymentNumber
            lda #0

          +
          sta structActionStructEntry.CurrentHP,b,y

          rep #$30

          jsr rsActionStructSwapUnitsIfDevilEffect
          lda structActionStructEntry.EquippedItemID2,b,x
          jsl rlTryGetBrokenItemID
          sta structActionStructEntry.EquippedItemID2,b,x
          rts

        _Miss

        ; Tomes always lose durability on a miss
        ; 1-2 range weapons only lose durability at 2
        ; range on a miss, staves always lose durability
        ; on a miss.

        lda structActionStructEntry.WeaponTraits,b,x
        bit #TraitTome
        bne _Continue

          lda bActionStructDistance
          and #$00FF

          cmp #1
          beq +

          cmp #narrow(-1, 1)
          beq +

        _Continue
        lda structActionStructEntry.EquippedItemID2,b,x
        jsl rlTryGetBrokenItemID
        sta structActionStructEntry.EquippedItemID2,b,x

        +
        lda wActionStructRoundAttackBitfield
        and #~RoundAttackFlagCritical
        ora #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield
        rts

        _End
        rts

        .databank 0

      rsActionStructSwapUnitsIfDevilEffect ; 83/D9B4

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        ; Swaps the order of units if the
        ; devil effect was triggered.

        ; Inputs:
        ;   X: short pointer to attacker action struct
        ;   Y: short pointer to defender action struct
        ;   aItemDataBuffer: filled with item

        ; Outputs:
        ;   X: new attacker
        ;   Y: new defender

        lda aItemDataBuffer.WeaponEffect,b
        and #$00FF
        cmp #WeaponEffects.DevilWeaponEffect
        bne +

        lda wActionStructRoundAttackBitfield
        bit #RoundAttackFlagWeaponEffect
        beq +

          txa
          tyx
          tay

        +
        rts

        .databank 0

      rsActionStructRoundWriteRoundAndMarkDeaths ; 83/D9CB

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        ; Writes the round and checks if combat should
        ; end due to a broken item or a death.

        ; Inputs:
        ;   X: short pointer to attacker action struct
        ;   Y: short pointer to defender action struct

        ; Outputs:
        ;   Carry set if combat should end, carry clear if
        ;     combat can continue.

        php
        phx

        lda wActionStructRoundAttackBitfield
        ora structActionStructEntry.RoundAttackHistory,b,x
        sta structActionStructEntry.RoundAttackHistory,b,x

        sep #$20

        lda structActionStructEntry.CurrentHP,b,x
        beq _AttackerDeath

        lda structActionStructEntry.CurrentHP,b,y
        beq _DefenderDeath

        bra +

        _AttackerDeath
          lda wActionStructRoundFlowBitfield
          ora #RoundFlowFlagUnitKilled
          sta wActionStructRoundFlowBitfield

          bra +

        _DefenderDeath
          lda wActionStructRoundFlowBitfield
          ora #(RoundFlowFlagUnitKilled | RoundFlowFlagDefenderKilled)
          sta wActionStructRoundFlowBitfield

        +
        lda wActionStructGeneratedRoundDamage
        sta wActionStructRoundTempDamage
        jsr rsActionStructWriteRound

        lda bUnknownTargetingDeploymentNumber
        bne _EndCombat

        lda structActionStructEntry.EquippedItemID2,b,x
        and #$FF
        beq _EndCombat

        plx
        plp
        clc
        rts

        _EndCombat
        plx
        plp
        sec
        rts

        .databank 0

    .endsection ActionStructRoundSection

    .section ActionStructUnknown83DA13Section

      rlActionStructUnknown83DA13 ; 83/DA13

        .autsiz
        .databank ?

        php
        phb

        sep #$20

        lda #`wActiveTileUnitParameter1
        pha

        rep #$20

        plb

        .databank `wActiveTileUnitParameter1

        lda #$0009
        sta wActionStructGeneratedRoundCombatType

        lda wActiveTileUnitParameter1
        beq _Dead

          lda #$0008
          sta wActionStructGeneratedRoundCombatType

          lda wActiveTileUnitParameter2
          beq _DA60

            lda wActiveTileUnitAllegiance
            beq _Player

              lda #$000A
              sta wActionStructGeneratedRoundCombatType

              sep #$20

              lda wActiveTileUnitParameter1
              sta aSelectedCharacterBuffer.CurrentHP,b

              rep #$20

              stz bUnknownTargetingDeploymentNumber

        _End
        plb
        plp
        rtl

        .al
        .autsiz

        _Player
          lda #$000B
          sta wActionStructGeneratedRoundCombatType

          sep #$20

          lda wActiveTileUnitParameter1
          sta aSelectedCharacterBuffer.CurrentHP,b

          rep #$20

          bra _End

        .al
        .autsiz

        _DA60
          jsl rlActionStructTryUpdateWinsLosses

          stz bUnknownTargetingDeploymentNumber
          bra +

        .al
        .autsiz

        _Dead
          jsl rlActionStructTryUpdateWinsLosses

        +
        lda aSelectedCharacterBuffer.Item1ID,b
        pha

        sep #$20

        lda wActiveTileUnitParameter1
        sta aActionStructUnit1.CurrentHP

        rep #$20

        ldx #<>aActionStructUnit1
        ldy wActionStructGeneratedRoundBufferPointer
        jsr rsActionStructWriteLevelUpActionStruct
        jsl rlUpdateSaveSlotLosses

        pla
        sta aSelectedCharacterBuffer.Item1ID,b

        bra _End

        .databank 0

    .endsection ActionStructUnknown83DA13Section

    .section ActionStructWriteLevelUpActionStructSection

      rsActionStructWriteBothLevelUpActionStructs ; 83/DA8E

        .autsiz
        .databank `wActionStructGeneratedRoundDeploymentNumber

        ; Tries to add level-up stats for both units.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        php
        sep #$20

        ldx #<>aActionStructUnit1
        ldy wActionStructGeneratedRoundBufferPointer
        jsr rsActionStructWriteLevelUpActionStruct

        rep #$30

        lda wActionStructGeneratedRoundDeploymentNumber
        sta wR0
        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataToBufferByDeploymentNumber

        ldx #<>aActionStructUnit2
        ldy #<>aBurstWindowCharacterBuffer
        jsr rsActionStructWriteLevelUpActionStruct

        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

        plp
        rts

        .databank 0

      rlActionStructAddLevelupCoreStats ; 83/DABE

        .autsiz
        .databank `aActionStructUnit1

        _StatList  := [(structActionStructEntry.CurrentHP, structActionStructEntry.LevelUpHPGain)]
        _StatList ..= [(structActionStructEntry.MaxHP, structActionStructEntry.LevelUpHPGain)]
        _StatList ..= [(structActionStructEntry.Strength, structActionStructEntry.LevelUpStrengthGain)]
        _StatList ..= [(structActionStructEntry.Magic, structActionStructEntry.LevelUpMagicGain)]
        _StatList ..= [(structActionStructEntry.Skill, structActionStructEntry.LevelUpSkillGain)]
        _StatList ..= [(structActionStructEntry.Speed, structActionStructEntry.LevelUpSpeedGain)]
        _StatList ..= [(structActionStructEntry.Defense, structActionStructEntry.LevelUpDefenseGain)]
        _StatList ..= [(structActionStructEntry.Constitution, structActionStructEntry.LevelUpConstitutionGain)]
        _StatList ..= [(structActionStructEntry.Luck, structActionStructEntry.LevelUpLuckGain)]
        _StatList ..= [(structActionStructEntry.Movement, structActionStructEntry.LevelUpMovementGain)]

        ; Adds gained stats to an action struct's
        ; core stats.

        ; Inputs:
        ; X: short pointer to main action struct
        ; Y: short pointer to level action struct

        ; Outputs:
        ; None

        php

        sep #$20

        .for _Stat in _StatList

          lda _Stat[0],b,y
          clc
          adc _Stat[1],b,x
          sta _Stat[0],b,y

        .endfor

        plp
        rtl

        .databank 0

      rsActionStructWriteLevelUpActionStruct ; 83/DB27

        .autsiz
        .databank ?

        _ByteStatList  := [structActionStructEntry.Level]
        _ByteStatList ..= [structActionStructEntry.CurrentHP]
        _ByteStatList ..= [structActionStructEntry.MaxHP]
        _ByteStatList ..= [structActionStructEntry.Experience]
        _ByteStatList ..= [structActionStructEntry.Class]
        _ByteStatList ..= [structActionStructEntry.SpriteInfo1]

        _WordStatList  := [structActionStructEntry.UnitState]
        _WordStatList ..= [structActionStructEntry.TotalEXP]

        ; Copies stats from one action struct to
        ; another for level up/weapon rank gains.

        ; Inputs:
        ; X: short pointer to action struct
        ; Y: short pointer to new action struct

        ; Outputs:
        ; Y: short pointer to new action struct, set up for level

        sep #$20

        .for _Stat in _ByteStatList

          lda _Stat,b,x
          sta _Stat,b,y

        .endfor

        rep #$30

        .for _Stat in _WordStatList

          lda _Stat,b,x
          sta _Stat,b,y

        .endfor

        sep #$20

        lda structActionStructEntry.WeaponTraits,b,x
        bit #TraitBallista
        bne +

          lda structActionStructEntry.EquippedItemID2,b,x
          beq _Continue

        +
        rep #$30

        ; Copy their equipped item.

        sty wR1

        lda structActionStructEntry.EquippedItemID2,b,x
        sta wR0

        lda structActionStructEntry.EquippedItemInventoryIndex,b,x
        and #$00FF
        clc
        adc #structActionStructEntry.Items
        tay
        lda wR0
        sta (wR1),y
        ldy wR1

        sep #$20

        _Continue

        ; Increment fatigue, cap.

        lda structActionStructEntry.Fatigue,b,y
        cmp #99
        bge +

          inc a
          sta structActionStructEntry.Fatigue,b,y

        +
        jsl rlActionStructAddLevelupCoreStats
        jsl rlClampCharacterStats

        rep #$30

        jsr rsActionStructSetGainedWEXP
        jsr rsActionStructTryGetGainedWeaponRank
        rts

        .databank 0

    .endsection ActionStructWriteLevelUpActionStructSection

    .section ActionStructTryUpdateRoundCaptureFlagSection

      rsActionStructTryUpdateRoundCaptureFlag ; 83/DBA1

        .al
        .autsiz
        .databank `wCapturingFlag

        ; Flags a round as a capture
        ; attempt and sets bUnknown7E4FCF
        ; if successful?

        ; Inputs:
        ;   wCapturingFlag: nonzero if capture attempt
        ;   aActionStructUnit2: filled with defender

        ; Outputs:
        ;   wActionStructGeneratedRoundCombatType: set to $0006
        ;     if capture attempt
        ;   bUnknown7E4FCF: set to $04 if successful,
        ;     otherwise unchanged

        lda wCapturingFlag
        beq +

          lda #$0006
          sta wActionStructGeneratedRoundCombatType

          stz wCapturingFlag

          lda aActionStructUnit2.CurrentHP
          and #$00FF
          bne +

            inc wCapturingFlag

            sep #$20

            lda #$04
            sta bUnknown7E4FCF

            rep #$20

        +
        rts

        .databank 0

    .endsection ActionStructTryUpdateRoundCaptureFlagSection

    .section ActionStructWeaponTriangleSection

      rlActionStructCheckIfWeaponTriangleAdvantage ; 83/DBC4

        .autsiz
        .databank ?

        ; Given a weapon type and an opponent's
        ; weapon type, check if weapon is effective
        ; against opponent's weapon.

        ; Inputs:
        ; wR0: weapon type to check
        ; wR1: opponent's weapon type

        ; Outputs:
        ; Carry set if advantage, else carry clear

        php

        rep #$30

        ; Type * 3 bytes per entry

        lda wR0
        and #$000F

        asl a
        clc
        adc wR0

        tax

        sep #$20

        lda wR1
        and #$0F

        ; Each type can be effective against up to
        ; 3 other types.

        .for _AdvantageOffset in range(3)

          cmp _aWeaponTriangleTable+(size(char) * _AdvantageOffset),x
          beq _Advantage

        .endfor

        plp
        clc
        rtl

        _Advantage

        plp
        sec
        rtl

        _aWeaponTriangleTable .block ; 83/DBEF
          _Sword   .char TypeAxe, -1, -1
          _Lance   .char TypeSword, -1, -1
          _Axe     .char TypeLance, -1, -1
          _Bow     .char -1, -1, -1
          _Staff   .char -1, -1, -1
          _Fire    .char TypeWind, -1, -1
          _Thunder .char TypeFire, -1, -1
          _Wind    .char TypeThunder, -1, -1
          _Light   .char TypeWind, TypeFire, TypeThunder
          _Dark    .char TypeWind, TypeFire, TypeThunder
        .endblock

        .databank 0

    .endsection ActionStructWeaponTriangleSection

    .section ActionStructAdjustVantageRoundOrderSection

      rsActionStructAdjustVantageRoundOrder ; 83/DC0D

        .autsiz
        .databank `wActionStructGeneratedRoundActor

        ; Sets the round actor be be the
        ; second unit if they have vantage.

        ; Inputs:
        ; aActionStructUnit2: filled with unit

        ; Outputs:
        ; wActionStructGeneratedRoundActor: set to second unit
        ;   if success, unchanged otherwise.

        php

        rep #$30

        stz wActionStructGeneratedRoundActor

        lda aActionStructUnit2.EquippedItemID2
        and #$00FF
        beq +

          lda aActionStructUnit2.Skills2
          bit #Skill2Vantage
          beq +

            ldx #$0002
            stx wActionStructGeneratedRoundActor

        +
        lda wActionStructGeneratedRoundActor
        sta wActionStructGeneratedRoundUnknownActor

        plp
        rts

        .databank 0

    .endsection ActionStructAdjustVantageRoundOrderSection

    .section ActionStructUnknown83DC31Section

      rlActionStructUnknown83DC31 ; 83/DC31

        .xl
        .autsiz
        .databank `aActionStructUnit1

        stz wActionStructGeneratedRoundVar1
        stz wActionStructGeneratedRoundOffset
        stz wActionStructGeneratedRoundLastOffset
        stz wActionStructGeneratedRoundBonusCombat
        stz wActionStructGeneratedRoundDamage
        stz wActionStructGeneratedRoundBufferPointer
        stz wActionStructGeneratedRoundDeploymentNumber
        stz wActionStructGeneratedRoundCombatType

        ldx #<>aActionStructUnit1
        jsr rsActionStructUnknown83DC59

        ldx #<>aActionStructUnit2
        jsr rsActionStructUnknown83DC59

        jsr rsActionStructUnknown83DCA3

        rts

        .databank 0

      rsActionStructUnknown83DC59 ; 83/DC59

        .xl
        .autsiz
        .databank `aActionStructUnit1

        ; This seems to have had two purposes:
        ; to set wActionStructGeneratedRoundVar1 to
        ; a pointer to a living player unit's inventory,
        ; or to store a dead non-player's items
        ; to a previously-saved unit.

        sep #$20

        ; Check if successfully captured?

        lda structActionStructEntry.CurrentHP,b,x
        bne +

        ; Player units?

        lda structActionStructEntry.DeploymentNumber,b,x
        and #AllAllegiances
        beq +

          bra _NotPlayerDead

        +
        rep #$30

        lda structActionStructEntry.DeploymentNumber,b,x
        sta wActionStructGeneratedRoundVar1

        ; Seems like this is missing something
        ; about a free inventory slot in
        ; a player unit's inventory?

        ; Maybe not an inventory but somewhere
        ; else in RAM?

        stx wActionStructGeneratedRoundVar1
        rts

        _NotPlayerDead
        rep #$30

        ; Seems like this is supposed to
        ; set up pointers inventories.

        txa
        clc
        adc #structActionStructEntry.Items
        sta wR1

        lda #<>wActionStructGeneratedRoundVar1
        sta wR2

        ldy #0

        ; Supposed to copy items from the
        ; dead unit?

        _Loop
          lda (wR1),y
          beq _End

          jsl rlCopyItemDataToBuffer

          lda aItemDataBuffer.Traits,b
          bne +

            lda (wR1),y
            sta (wR2)
            inc wR2
            inc wR2

          +
          inc y
          inc y
          cpy #size(structActionStructEntry.Items)
          bra _Loop

        _End
        rts

        .databank 0

      rsActionStructUnknown83DCA3 ; 83/DCA3

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Seems like it's supposed to
        ; copy the items taken from the dead
        ; unit in the previous routine to the
        ; target unit.

        lda #<>wActionStructGeneratedRoundVar1
        sta wR17

        _Loop
          lda (wR17)
          beq _End

          jsl rlCopyItemDataToBuffer

          lda wActionStructGeneratedRoundVar1
          sta wR1
          jsl rlTryGiveCharacterItemFromBuffer

          inc wR17
          inc wR17

          bra _Loop

        _End
        rts

        .databank 0

    .endsection ActionStructUnknown83DC31Section

    .section ActionStructLevelUpSection

      rsActionStructTryGetBothLevelupGains ; 83/DCC0

        .xl
        .autsiz
        .databank `aActionStructUnit1

        ; Tries to get both units' level up gains.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        ldx #<>aActionStructUnit1
        jsr rsActionStructTryGetLevelUpGains
        ldx #<>aActionStructUnit2
        jsr rsActionStructTryGetLevelUpGains

        rts

        .databank 0

      rsActionStructTryGetLevelUpGains ; 83/DCCD

        .autsiz
        .databank `aActionStructUnit1

        _StatList  := [(aBurstWindowCharacterBuffer.Strength, structActionStructEntry.Strength)]
        _StatList ..= [(aBurstWindowCharacterBuffer.Magic, structActionStructEntry.Magic)]
        _StatList ..= [(aBurstWindowCharacterBuffer.Skill, structActionStructEntry.Skill)]
        _StatList ..= [(aBurstWindowCharacterBuffer.Speed, structActionStructEntry.Speed)]
        _StatList ..= [(aBurstWindowCharacterBuffer.Defense, structActionStructEntry.Defense)]
        _StatList ..= [(aBurstWindowCharacterBuffer.Constitution, structActionStructEntry.Constitution)]
        _StatList ..= [(aBurstWindowCharacterBuffer.Luck, structActionStructEntry.Luck)]

        ; Given a short pointer to an action
        ; struct in X, check if a unit has
        ; gained enough EXP to level up and
        ; gain stats.

        ; Inputs:
        ; X: short pointer to action struct

        ; Outputs:
        ; None

        jsl rlActionStructClearLevelUpStatGains

        jsr rsActionStructTrySetLevelUp
        bcc _End

          phx

          lda #ActionStruct_Unknown3
          cmp wActionStructGeneratedRoundCombatType
          beq +

            lda structActionStructEntry.DeploymentNumber,b,x
            sta wR0
            lda #<>aBurstWindowCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda structActionStructEntry.Coordinates,b,x
            sta aBurstWindowCharacterBuffer.Coordinates,b

            lda #<>aBurstWindowCharacterBuffer
            sta wR1
            jsl rlCombineCharacterDataAndClassBases

            lda #$01,s
            tax

            sep #$20

            .for _Stat in _StatList

              lda _Stat[0],b
              sta _Stat[1],b,x

            .endfor

            rep #$30

          +
          jsl rlActionStructCopyGrowthsToBuffer
          jsr rsActionStructGetScrollGrowths
          jsr rsActionStructClampAdjustedGrowths
          plx
          jsl rlActionStructGetLevelUpStatGains

        _End
        rts

        .databank 0

      rsActionStructTrySetLevelUp ; 83/DD3D

        .autsiz
        .databank `aActionStructUnit1

        ; Given a short pointer to an action
        ; struct in X, try increasing the unit's
        ; level.

        ; Inputs:
        ; X: short pointer to action struct

        ; Outputs:
        ; None

        php
        sep #$20

        lda structActionStructEntry.Level,b,x
        cmp #LevelCap
        beq _False

          lda structActionStructEntry.Experience,b,x
          sec
          sbc #ExperienceCap
          bmi _False

            sta structActionStructEntry.Experience,b,x

            lda structActionStructEntry.Level,b,x
            inc a
            cmp #LevelCap
            blt +

              lda #ExperienceCap
              sec
              sbc structActionStructEntry.StartingExperience,b,x
              sta structActionStructEntry.GainedExperience,b,x

              lda #-1
              sta structActionStructEntry.Experience,b,x

              lda #LevelCap

            +
            sta structActionStructEntry.Level,b,x
            plp
            sec
            rts

        _False
        plp
        clc
        rts

        .databank 0

      rlActionStructCopyGrowthsToBuffer ; 83/DD73

        .al
        .autsiz
        .databank `aCharacterDataBuffer

        _GrowthList  := [(aCharacterDataBuffer.HPGrowth, aUnitAdjustedGrowths.wHP)]
        _GrowthList ..= [(aCharacterDataBuffer.StrengthGrowth, aUnitAdjustedGrowths.wSTR)]
        _GrowthList ..= [(aCharacterDataBuffer.MagicGrowth, aUnitAdjustedGrowths.wMAG)]
        _GrowthList ..= [(aCharacterDataBuffer.SkillGrowth, aUnitAdjustedGrowths.wSKL)]
        _GrowthList ..= [(aCharacterDataBuffer.SpeedGrowth, aUnitAdjustedGrowths.wSPD)]
        _GrowthList ..= [(aCharacterDataBuffer.DefenseGrowth, aUnitAdjustedGrowths.wDEF)]
        _GrowthList ..= [(aCharacterDataBuffer.ConstitutionGrowth, aUnitAdjustedGrowths.wCON)]
        _GrowthList ..= [(aCharacterDataBuffer.LuckGrowth, aUnitAdjustedGrowths.wLUK)]
        _GrowthList ..= [(aCharacterDataBuffer.MovementGrowth, aUnitAdjustedGrowths.wMOV)]

        ; Given a short pointer to a unit's action
        ; struct in X, copy their growths to
        ; aUnitAdjustedGrowths

        ; Inputs:
        ; X: short pointer to action struct

        ; Outputs:
        ; aUnitAdjustedGrowths: filled with growths

        lda structActionStructEntry.Character,b,x
        jsl rlCopyCharacterDataToBuffer

        .for _Growth in _GrowthList

          lda _Growth[0]
          and #$00FF
          sta _Growth[1]

        .endfor

        rtl

        .databank 0

      rsActionStructGetScrollGrowths ; 83/DDCC

        .al
        .xl
        .autsiz
        .databank `aUnitAdjustedGrowths

        ; Tries to modify a unit's growths
        ; using all scrolls in their inventory.

        ; Inputs:
        ; X: short pointer to action struct

        ; Outputs:
        ; aUnitAdjustedGrowths: modified growths

        lda #<>rlActionStructGetScrollGrowthsEffect
        sta lR25
        lda #>`rlActionStructGetScrollGrowthsEffect
        sta lR25+size(byte)
        txa
        clc
        adc #structActionStructEntry.Items
        jsl rlRunRoutineForAllItemsInInventory

        rts

        .databank 0

      rlActionStructGetScrollGrowthsEffect ; 83/DDE0

        .xl
        .autsiz
        .databank `aUnitAdjustedGrowths

        _GrowthList  := [aUnitAdjustedGrowths.wHP]
        _GrowthList ..= [aUnitAdjustedGrowths.wSTR]
        _GrowthList ..= [aUnitAdjustedGrowths.wMAG]
        _GrowthList ..= [aUnitAdjustedGrowths.wSKL]
        _GrowthList ..= [aUnitAdjustedGrowths.wSPD]
        _GrowthList ..= [aUnitAdjustedGrowths.wDEF]
        _GrowthList ..= [aUnitAdjustedGrowths.wCON]
        _GrowthList ..= [aUnitAdjustedGrowths.wLUK]
        _GrowthList ..= [aUnitAdjustedGrowths.wMOV]

        ; Given an item ID in A, check if
        ; it's a scroll and modify the growths
        ; in aUnitAdjustedGrowths if it is.

        ; Inputs:
        ; A: item ID
        ; aUnitAdjustedGrowths: filled with growths

        ; Outputs:
        ; aUnitAdjustedGrowths: modified growths

        ldx #<>aScrollTable
        stx lR18
        ldx #>`aScrollTable
        stx lR18+size(byte)

        sep #$20

        sta wR0

        ; Look through the scroll table
        ; until a matching scroll or terminator
        ; is found.

        _Loop

          lda [lR18]
          beq _End

          cmp wR0
          beq _Match

            rep #$30

            lda lR18
            clc
            adc #size(structScrollGrowthModifiers)
            sta lR18

            sep #$20

            bra _Loop

        .as
        .autsiz

        _End
        rtl

        .as
        .autsiz

        _Match

        rep #$30

        ; Add all of the growths in aUnitAdjustedGrowths
        ; to the scroll modifiers.

        .for _Growth in _GrowthList

          inc lR18

          lda [lR18]
          and #$00FF

          ; Nice trick to convert s8 -> s16

          xba

          ora #0
          bpl +

            ora #narrow(-1, 1)

          +
          xba

          clc
          adc _Growth
          sta _Growth

        .endfor

        rtl

        .databank 0

      rsActionStructClampAdjustedGrowths ; 83/DEE0

        .al
        .autsiz
        .databank `aUnitAdjustedGrowths

        _GrowthList  := [aUnitAdjustedGrowths.wHP]
        _GrowthList ..= [aUnitAdjustedGrowths.wSTR]
        _GrowthList ..= [aUnitAdjustedGrowths.wMAG]
        _GrowthList ..= [aUnitAdjustedGrowths.wSKL]
        _GrowthList ..= [aUnitAdjustedGrowths.wSPD]
        _GrowthList ..= [aUnitAdjustedGrowths.wDEF]
        _GrowthList ..= [aUnitAdjustedGrowths.wCON]
        _GrowthList ..= [aUnitAdjustedGrowths.wLUK]
        _GrowthList ..= [aUnitAdjustedGrowths.wMOV]

        ; Clamps aUnitAdjustedGrowths to be 0-255

        ; Inputs:
        ; aUnitAdjustedGrowths: filled with growths

        ; Outputs:
        ; aUnitAdjustedGrowths: clamped growths

        .for _Growth in _GrowthList

          lda _Growth
          bpl +

            lda #0

          +
          cmp #255
          blt +

            lda #255

          +
          sta _Growth

        .endfor

        rts

        .databank 0

      ActionStructLevelUpInfo  := [(aUnitAdjustedGrowths.wHP, structActionStructEntry.LevelUpHPGain, structActionStructEntry.MaxHP, HPCap)]
      ActionStructLevelUpInfo ..= [(aUnitAdjustedGrowths.wSTR, structActionStructEntry.LevelUpStrengthGain, structActionStructEntry.Strength, StatCap)]
      ActionStructLevelUpInfo ..= [(aUnitAdjustedGrowths.wMAG, structActionStructEntry.LevelUpMagicGain, structActionStructEntry.Magic, StatCap)]
      ActionStructLevelUpInfo ..= [(aUnitAdjustedGrowths.wSKL, structActionStructEntry.LevelUpSkillGain, structActionStructEntry.Skill, StatCap)]
      ActionStructLevelUpInfo ..= [(aUnitAdjustedGrowths.wSPD, structActionStructEntry.LevelUpSpeedGain, structActionStructEntry.Speed, StatCap)]
      ActionStructLevelUpInfo ..= [(aUnitAdjustedGrowths.wDEF, structActionStructEntry.LevelUpDefenseGain, structActionStructEntry.Defense, StatCap)]
      ActionStructLevelUpInfo ..= [(aUnitAdjustedGrowths.wCON, structActionStructEntry.LevelUpConstitutionGain, structActionStructEntry.Constitution, StatCap)]
      ActionStructLevelUpInfo ..= [(aUnitAdjustedGrowths.wLUK, structActionStructEntry.LevelUpLuckGain, structActionStructEntry.Luck, StatCap)]
      ActionStructLevelUpInfo ..= [(aUnitAdjustedGrowths.wMOV, structActionStructEntry.LevelUpMovementGain, structActionStructEntry.Movement, StatCap)]

      aActionStructGrowthOffsetsTable ; 83/DF8C
        .for _Growth in ActionStructLevelUpInfo[:,0]
          .word <>_Growth
        .endfor
      .word 0

      aActionStructLevelUpGainTable ; 83/DFA0
        .for _LevelUpGain in ActionStructLevelUpInfo[:,1]
          .word _LevelUpGain
        .endfor

      aActionStructLevelUpStatTable ; 83/DFB2
        .for _LevelUpStat in ActionStructLevelUpInfo[:,2]
          .word _LevelUpStat
        .endfor

      aActionStructLevelUpCapTable ; 83/DFC4
        .for _Cap in ActionStructLevelUpInfo[:,3]
          .word _Cap
        .endfor

      rlActionStructGetLevelUpStatGains ; 83/DFD6

        .al
        .xl
        .autsiz
        .databank `aActionStructUnit1

        ; Given a short pointer to an action
        ; struct in X and a set of growths in
        ; aUnitAdjustedGrowths, roll growths and
        ; store the gains in the action struct's
        ; level up gains.

        ; Inputs:
        ; X: short pointer to action struct
        ; aUnitAdjustedGrowths: filled with growths

        ; Outputs:
        ; None

        stx wR2
        cpx #<>aActionStructUnit1
        beq _Unit1

          ; Otherwise get pointer by slot

          lda aActionStructUnit2.DeploymentNumber
          and #$00FF
          asl a
          tax
          lda aDeploymentSlotTable,x
          sta wR3

          bra +

        _Unit1

          lda #<>aSelectedCharacterBuffer
          sta wR3

        +

        ldx #0

        _Loop

          ; Get a growth or table end.
          ; Roll the growth for potential gains.

          lda aActionStructGrowthOffsetsTable,x
          beq _End

          tay
          lda 0,b,y
          jsr rsActionStructRollPercentage
          sta wR4

          ; Get the unit's current stat and
          ; add to gain.

          lda aActionStructLevelUpStatTable,x
          tay
          lda (wR3),y
          and #$00FF
          clc
          adc wR4

          ; If the result is higher than
          ; the cap, use the difference to set
          ; to the cap.

          sec
          sbc aActionStructLevelUpCapTable,x
          bmi +

            sta wR5

            lda wR4
            sec
            sbc wR5
            sta wR4

          +

          ; Store gain to action struct.

          lda aActionStructLevelUpGainTable,x
          tay

          sep #$20

          lda wR4
          sta (wR2),y

          rep #$30

          inc x
          inc x
          bra _Loop

        _End
        rtl

        .databank 0

      rlActionStructClearLevelUpStatGains ; 83/E033

        .autsiz
        .databank `aActionStructUnit1

        _LevelUpStatList  := [structActionStructEntry.LevelUpHPGain]
        _LevelUpStatList ..= [structActionStructEntry.LevelUpStrengthGain]
        _LevelUpStatList ..= [structActionStructEntry.LevelUpMagicGain]
        _LevelUpStatList ..= [structActionStructEntry.LevelUpSkillGain]
        _LevelUpStatList ..= [structActionStructEntry.LevelUpSpeedGain]
        _LevelUpStatList ..= [structActionStructEntry.LevelUpDefenseGain]
        _LevelUpStatList ..= [structActionStructEntry.LevelUpConstitutionGain]
        _LevelUpStatList ..= [structActionStructEntry.LevelUpLuckGain]
        _LevelUpStatList ..= [structActionStructEntry.LevelUpMovementGain]

        ; Given a short pointer to an action
        ; struct in X, clear level up stat gains.

        ; Inputs:
        ; X: short pointer to action struct

        ; Outputs:
        ; None

        php
        sep #$20

        .for _LevelUpStat in _LevelUpStatList

          stz _LevelUpStat,b,x

        .endfor

        plp
        rtl

        .databank 0

    .endsection ActionStructLevelUpSection

    .section ActionStructCalculateWeaponTriangleBonusSection

      rsActionStructCalculateWeaponTriangleBonus ; 83/E053

        .autsiz
        .databank `aActionStructUnit1

        ; Check to see if either unit should
        ; get a weapon triangle bonus.

        ; Inputs:
        ; aActionStructUnit1: filled with unit
        ; aActionStructUnit2: filled with unit

        php
        sep #$20

        stz aActionStructUnit1.WeaponTriangleBonus
        stz aActionStructUnit2.WeaponTriangleBonus

        ; Assume the first unit has a weapon.

        lda aActionStructUnit2.EquippedItemID1
        beq _End

          lda aActionStructUnit1.AttackType
          sta wR0
          lda aActionStructUnit2.AttackType
          sta wR1
          jsl rlActionStructCheckIfWeaponTriangleAdvantage
          bcc +

            lda #5
            sta aActionStructUnit1.WeaponTriangleBonus

          +
          lda aActionStructUnit2.AttackType
          sta wR0
          lda aActionStructUnit1.AttackType
          sta wR1
          jsl rlActionStructCheckIfWeaponTriangleAdvantage
          bcc _End

            lda #5
            sta aActionStructUnit2.WeaponTriangleBonus

        _End
        plp
        rts

        .databank 0

    .endsection ActionStructCalculateWeaponTriangleBonusSection

    .section ActionStructWeaponEffectSection

      rsActionStructGetWeaponEffect ; 83/E08D

        .autsiz
        .databank `aActionStructUnit1

        ; Given a short pointer to an attacker's
        ; action struct in X and a defender's in
        ; Y, apply the attacker's weapon's effect,
        ; if it has one.

        ; Inputs:
        ; X: short pointer to action struct
        ; Y: short pointer to action struct

        ; Outputs:
        ; None

        php
        phx
        phy

        rep #$30

        lda structActionStructEntry.EquippedItemID2,b,x
        jsl rlCopyItemDataToBuffer

        lda wActionStructRoundAttackBitfield
        bit #RoundAttackFlagSol
        beq +

          sep #$20

          lda #WeaponEffects.LifestealWeaponEffect
          sta aItemDataBuffer.WeaponEffect,b

          rep #$20

        +
        lda aItemDataBuffer.WeaponEffect,b
        and #$00FF
        beq +

          phx

          tax
          lda aWeaponEffectPointers,x
          sta lR19

          plx

          pea <>(+)-size(byte)
          jmp (lR19)

        +
        ply
        plx
        plp
        rts

        .databank 0

      aWeaponEffectPointers .include "../TABLES/WeaponEffectTable.csv.asm" ; 83/E0C5
      WeaponEffects .binclude "../TABLES/WeaponEffectOffsets.csv.asm"

      rsActionStructLifestealWeaponEffect ; 83/E0D5

        .al
        .xl
        .autsiz
        .databank `aActionStructUnit1

        ; Inputs:
        ; X: short pointer to action struct
        ; Y: short pointer to action struct

        php

        sep #$20

        lda structActionStructEntry.CurrentHP,b,y
        sec
        sbc wActionStructGeneratedRoundDamage
        bpl +

          lda structActionStructEntry.CurrentHP,b,y
          sta wActionStructGeneratedRoundDamage

        +
        lda structActionStructEntry.CurrentHP,b,x
        clc
        adc wActionStructGeneratedRoundDamage
        cmp structActionStructEntry.MaxHP,b,x
        blt +

          lda structActionStructEntry.MaxHP,b,x

        +
        sta structActionStructEntry.CurrentHP,b,x

        rep #$30

        lda wActionStructRoundAttackBitfield
        ora #$0080
        sta wActionStructRoundAttackBitfield

        plp
        rts

        .databank 0

      rsActionStructPoisonWeaponEffect ; 83/E106

        .autsiz
        .databank `aActionStructUnit1

        ; Inputs:
        ; X: short pointer to action struct
        ; Y: short pointer to action struct

        php
        sep #$20

        lda structActionStructEntry.DeploymentNumber,b,x
        and #AllAllegiances
        beq _End

        rep #$30

        lda structActionStructEntry.Skills2,b,y
        bit #pack([None, Skill3Immortal])
        bne _End

          sep #$20

          lda structActionStructEntry.Status,b,y
          cmp #StatusPetrify
          beq _End

            lda #StatusPoison
            sta structActionStructEntry.PostBattleStatus,b,y

            rep #$30

            lda wActionStructRoundAttackBitfield
            ora #RoundAttackFlagWeaponEffect
            sta wActionStructRoundAttackBitfield

            lda #<>rlActionStructStatusCallback
            sta lUnknown7EA4EC
            lda #>`rlActionStructStatusCallback
            sta lUnknown7EA4EC+size(byte)

        _End
        plp
        rts

        .databank 0

      rsActionStructDevilWeaponEffect ; 83/E106

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Inputs:
        ; X: short pointer to action struct
        ; Y: short pointer to action struct

        lda structActionStructEntry.Skills2,b,y
        bit #pack([None, Skill3Immortal])
        bne _End

          lda structActionStructEntry.Luck,b,x
          and #$00FF
          sta wR0

          lda #StatCap + 1
          sec
          sbc wR0
          bpl +

            lda #1

          +
          jsl rlRollRandomNumber0To100
          bcc _End

          lda wActionStructRoundAttackBitfield
          ora #$0080
          sta wActionStructRoundAttackBitfield

        _End
        rts

        .databank 0

      rsActionStructPetrifyWeaponEffect ; 83/E16C

        .autsiz
        .databank `aActionStructUnit1

        ; Inputs:
        ; X: short pointer to action struct
        ; Y: short pointer to action struct

        sep #$20

        lda #StatusPetrify
        sta structActionStructEntry.PostBattleStatus,b,y

        lda #$06
        sta bUnknown7E4FCF

        lda structActionStructEntry.DeploymentNumber,b,y
        sta bUnknownTargetingDeploymentNumber

        rep #$30

        lda wActionStructRoundAttackBitfield
        ora #RoundAttackFlagWeaponEffect
        sta wActionStructRoundAttackBitfield

        lda #<>rlActionStructStatusCallback
        sta lUnknown7EA4EC
        lda #>`rlActionStructStatusCallback
        sta lUnknown7EA4EC+size(byte)

        rts

        .databank 0

      rlActionStructStatusCallback ; 83/E196

        .autsiz
        .databank `aActionStructUnit1

        ; Copies the post battle stauses
        ; of the action struct units into their
        ; statuses. Also does map sprite stuff?

        php
        phb

        sep #$20

        lda #`wUnknownMapBattleFlag
        pha

        rep #$20

        plb

        .databank `wUnknownMapBattleFlag

        lda wUnknownMapBattleFlag
        bmi _End

          sep #$20

          lda aActionStructUnit1.Status
          cmp aActionStructUnit1.PostBattleStatus
          beq +

            lda aActionStructUnit1.PostBattleStatus
            sta aSelectedCharacterBuffer.Status,b

            lda wUnknownMapBattleFlag
            bne +

              ldx #<>aSelectedCharacterBuffer
              stx wR1
              jsl rlUnknown848E5A

          +
          lda aActionStructUnit2.Status
          cmp aActionStructUnit2.PostBattleStatus
          beq _Continue

            lda aActionStructUnit2.DeploymentNumber
            sta wR0
            ldx #<>aBurstWindowCharacterBuffer
            stx wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            lda aActionStructUnit2.PostBattleStatus
            sta aBurstWindowCharacterBuffer.Status,b

            lda wUnknownMapBattleFlag
            bne +

              ldx #<>aBurstWindowCharacterBuffer
              stx wR1
              jsl rlUnknown848E5A

            +
            ldx #<>aBurstWindowCharacterBuffer
            stx wR1
            jsl rlCopyCharacterDataFromBuffer

          _Continue
          ldx #-1
          stx wUnknownMapBattleFlag

        _End
        plb
        plp
        rtl

        .databank 0

      rsActionStructHelWeaponEffect ; 83/E1FF

        .al
        .autsiz
        .databank `aActionStructUnit1

        lda structActionStructEntry.CurrentHP,b,y
        and #$00FF
        dec a
        sta wActionStructGeneratedRoundDamage

        lda wActionStructRoundAttackBitfield
        ora #$0080
        sta wActionStructRoundAttackBitfield

        rts

        .databank 0

      rsActionStructBerserkWeaponEffect ; 83/E213

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Inputs:
        ; X: short pointer to action struct
        ; Y: short pointer to action struct

        lda structActionStructEntry.Skills2,b,y
        bit #pack([None, Skill3Immortal])
        bne +

          lda structActionStructEntry.TerrainType,b,y
          jsl rlCheckIfTileIsGateOrThroneByTerrainID
          bcs +

          lda structActionStructEntry.Status,b,y
          and #$00FF
          cmp #StatusPetrify
          beq +

            sep #$20

            lda #StatusBerserk
            sta structActionStructEntry.PostBattleStatus,b,y

            rep #$20

            lda structActionStructEntry.UnitState,b,y
            ora #(UnitStateMovementStar | UnitStateMoved)
            sta structActionStructEntry.UnitState,b,y

            lda wActionStructRoundAttackBitfield
            ora #RoundAttackFlagWeaponEffect
            sta wActionStructRoundAttackBitfield

            lda #<>rlActionStructStatusCallback
            sta lUnknown7EA4EC
            lda #>`rlActionStructStatusCallback
            sta lUnknown7EA4EC+size(byte)

        +
        rts

        .databank 0

      rsActionStructSleepWeaponEffect ; 83/E257

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Inputs:
        ; X: short pointer to action struct
        ; Y: short pointer to action struct

        lda structActionStructEntry.Skills2,b,y
        bit #pack([None, Skill3Immortal])
        bne _End

        lda structActionStructEntry.TerrainType,b,y
        jsl rlCheckIfTileIsGateOrThroneByTerrainID
        bcs _End

        lda structActionStructEntry.Status,b,y
        and #$00FF

        cmp #StatusPetrify
        beq _End

          sep #$20

          lda structActionStructEntry.PostBattleStatus,x

          cmp #StatusSleep
          beq _End

          cmp #StatusPetrify
          beq _End

            lda #StatusSleep
            sta structActionStructEntry.PostBattleStatus,b,y

            lda #$06
            sta $7E4FCF

            lda structActionStructEntry.DeploymentNumber,b,y
            sta bUnknownTargetingDeploymentNumber

            rep #$30

            lda structActionStructEntry.UnitState,b,y
            ora #(UnitStateMovementStar | UnitStateMoved)
            sta structActionStructEntry.UnitState,b,y

            lda wActionStructRoundAttackBitfield
            ora #RoundAttackFlagWeaponEffect
            sta wActionStructRoundAttackBitfield

            lda #<>rlActionStructStatusCallback
            sta lUnknown7EA4EC
            lda #>`rlActionStructStatusCallback
            sta lUnknown7EA4EC+size(byte)

        _End
        rts

        .databank 0

    .endsection ActionStructWeaponEffectSection

    .section ActionStructRollGainsSection

      rsActionStructRollPercentage ; 83/E2B0

        .autsiz
        .databank ?

        ; Rolls a percent chance.
        ; Values over 100% are returned as
        ; (chance // 100) + (roll(chance % 100) ? 1 : 0)

        ; Inputs:
        ; A: percent chance

        ; Outputs:
        ; wR1: proc'd gains

        php

        rep #$30

        phx
        phy

        stz wR0

        -
          sec
          sbc #100
          bmi +

            inc wR0

            bra -

        +
        clc
        adc #100
        sta wR1

        lda #100
        jsl rlGetRandomNumber100

        cmp wR1
        bge +

          inc wR0

        +
        lda wR0

        ply
        plx
        plp
        rts

        .databank 0

      rsActionStructCalculateWEXPGain ; 83/E2DA

        .autsiz
        .databank ?

        ; Given a short pointer to a action
        ; struct in X, roll gained WEXP.

        ; Inputs:
        ; X: short pointer to action struct

        ; Outputs:
        ; None

        php

        sep #$20

        tdc
        lda structActionStructEntry.WeaponEXPGainChance,b,x
        jsr rsActionStructRollPercentage
        clc
        adc structActionStructEntry.GainedWeaponEXP,b,x
        cmp #250
        blt +

          lda #250

        +
        sta structActionStructEntry.GainedWeaponEXP,b,x

        plp
        rts

        .databank 0

    .endsection ActionStructRollGainsSection

    .section ActionStructCalculateHitAvoidBonusSection

      rsActionStructCalculateHitAvoidBonus ; 83/E2F3

        .autsiz
        .databank `wActionStructType

        ; Given two units, a recipient and a target,
        ; get the recipient's hit/avoid bonus from
        ; supports, leadership, and charm.

        ; Inputs:
        ; X: short pointer to recipient action struct
        ; Y: short pointer to target action struct

        ; Outputs:
        ; None

        php
        rep #$30

        lda #ActionStruct_Unknown3
        cmp wActionStructType
        beq +

          phx
          phy

          phx
          phy

          lda structActionStructEntry.Character,b,y
          jsl rlActionStructGetSupportBonus
          sta wHitAvoidBonus

          ply
          plx

          jsr rlActionStructGetCharmBonus
          jsr rlActionStructGetBonusFromLeader

          lda wHitAvoidBonus
          clc
          adc structActionStructEntry.WeaponTriangleBonus,b,x

          clc
          adc structActionStructEntry.TerrainHitAvoid,b,x

          and #$00FF

          sep #$20

          sta structActionStructEntry.HitAvoidBonus,b,x

          ply
          plx
          plp
          rts

        .al
        .xl
        .autsiz

        +
        phx
        phy

        lda structActionStructEntry.Character,b,y
        jsl rlActionStructGetSupportBonus
        sta wHitAvoidBonus

        ply
        plx

        sep #$20

        sta structActionStructEntry.HitAvoidBonus,b,x

        rep #$20

        plp
        rts

        .databank 0

      rlActionStructGetCharmBonus ; 83/E342

        .al
        .xl
        .autsiz
        .databank `wActionStructType

        ; Given a short pointer to an action
        ; struct in X, get the bonus given to
        ; that unit by nearby units with charm.

        ; Inputs:
        ; X: short pointer to action struct
        ; wHitAvoidBonus: running total

        ; Outputs:
        ; wHitAvoidBonus: running total

        phx
        phy
        phx

        ; Clear the movement map.

        lda #<>aMovementMap
        sta lR18
        lda #>`aMovementMap
        sta lR18+size(byte)
        lda #0
        jsl rlFillMapByWord

        plx

        ; Grab the target's coordinates
        ; and use them to fill the movement map
        ; in a 1-3 range.

        lda structActionStructEntry.X,b,x
        and #$00FF
        sta wR0
        sta wActiveTileUnitParameter1

        lda structActionStructEntry.Y,b,x
        and #$00FF
        sta wR1
        sta wActiveTileUnitParameter2

        lda structActionStructEntry.DeploymentNumber,b,x
        and #AllAllegiances
        sta wActiveTileUnitAllegiance

        lda #<>aMovementMap
        sta wR3
        lda #pack([1, 3], size(byte))
        jsl rlGetMapUnitsInRange

        ; Exclude the unit itself.

        lda wActiveTileUnitParameter1
        sta wR0
        lda wActiveTileUnitParameter2
        sta wR1
        jsl rlGetMapTileIndexByCoords

        tax

        sep #$20

        stz aMovementMap,x

        rep #$30

        ; Check all units in that 1-3 range
        ; for units with charm.

        lda #<>rlActionStructGetCharmBonusEffect
        sta lR25
        lda #>`rlActionStructGetCharmBonusEffect
        sta lR25+size(byte)
        lda #<>aPlayerVisibleUnitMap
        sta lR24

        lda wCurrentPhase,b
        beq +

        lda #<>aUnitMap
        sta lR24

        +
        jsl rlRunRoutineForAllVisibleUnitsInRange

        ply
        plx
        rts

        .databank 0

      rlActionStructGetCharmBonusEffect ; 83/E3B8

        .as
        .autsiz
        .databank `wActiveTileUnitAllegiance

        ; Given a target deployment number in wR0
        ; and an allegiance to match in wActiveTileUnitAllegiance,
        ; add their charm bonus, if one exists, to
        ; a running total.

        ; Inputs:
        ; wR0: deployment number
        ; wActiveTileUnitAllegiance: target allegiance
        ; wHitAvoidBonus: running total

        ; Output:
        ; wHitAvoidBonus: running total

        ; Store deployment number for later.
        ; If unit at tile doesn't have the same allegiance
        ; as the bonus recipient, short out.

        sta wR0
        and #AllAllegiances
        cmp wActiveTileUnitAllegiance
        bne +

          ; If unit, get the unit's equipped item's
          ; skills to combine with their character/class
          ; skills.

          rep #$30

          lda #<>aBurstWindowCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataToBufferByDeploymentNumber

          lda #<>aBurstWindowCharacterBuffer
          sta wR1
          jsl rlGetEquippableItemInventoryOffset

          lda aItemDataBuffer.Skills2,b
          ora aBurstWindowCharacterBuffer.Skills2,b
          sta aBurstWindowCharacterBuffer.Skills2,b

          ; If they have charm, add to running total.

          lda aBurstWindowCharacterBuffer.Skills2,b
          bit #Skill2Charm
          beq +

            lda wHitAvoidBonus
            clc
            adc #10
            sta wHitAvoidBonus

        +
        sep #$20

        rtl

        .databank 0

      rlActionStructGetBonusFromLeader ; 83/E3F3

        .al
        .autsiz
        .databank ?

        ; Given a short pointer to an action struct
        ; in X, add any leadership bonuses that unit
        ; is getting to wHitAvoidBonus.

        ; Inputs:
        ; X: short pointer to action stuct
        ; wHitAvoidBonus: running total

        ; Outputs:
        ; wHitAvoidBonus: running total

        phx
        phy

        lda #<>rlActionStructGetBonusFromLeaderEffect
        sta lR25
        lda #>`rlActionStructGetBonusFromLeaderEffect
        sta lR25+size(byte)

        lda structActionStructEntry.Leader,b,x
        and #$00FF
        sta wR17

        lda structActionStructEntry.DeploymentNumber,b,x
        and #AllAllegiances
        jsl rlRunRoutineForAllUnitsInAllegiance

        ply
        plx

        rts

        .databank 0

      rlActionStructGetBonusFromLeaderEffect ; 83/E414

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Given a unit and a faction, add that
        ; unit's leader's bonus to a running total.

        ; Inputs:
        ; aTargetingCharacterBuffer: potential leader unit
        ; wR17: faction

        ; Outputs:
        ; wHitAvoidBonus: running total

        lda aTargetingCharacterBuffer.UnitState,b
        bit #(UnitStateDead | UnitStateUnknown1 | UnitStateRescued | UnitStateDisabled | UnitStateCaptured)
        bne _End

          sep #$20

          ; If potential leader's faction matches target
          ; faction and potential leader has leadership
          ; stars, add stars * 3 to total.

          lda aTargetingCharacterBuffer.Leader,b
          cmp wR17
          bne +

          lda aTargetingCharacterBuffer.LeadershipStars,b
          beq +

            asl a
            clc
            adc aTargetingCharacterBuffer.LeadershipStars,b
            clc
            adc wHitAvoidBonus
            sta wHitAvoidBonus

          +
          rep #$30

        _End
        rtl

        .databank 0

    .endsection ActionStructCalculateHitAvoidBonusSection

    .section ActionStructHalveStatsSection

      rsActionStructHalveStatsWhenCapturing; 83/E439

        .al
        .databank `wCapturingFlag

        ; When the capturing flag is set,
        ; halves the stats of the first
        ; action struct unit.

        ; Inputs:
        ; wCapturingFlag: set if capturing,
        ;   unset otherwise
        ; aActionStructUnit1: filled with unit

        ; Outputs:
        ; None

        lda wCapturingFlag
        beq +

          lda #<>aActionStructUnit1
          sta wR1
          jsl rlActionStructHalveCapturingStats

        +
        rts

        .databank 0

      rlActionStructHalveCarryingStats ; 83/E448

        .autsiz
        .databank ?

        ; Given a short pointer to an
        ; action struct in X, halve specific stats.

        ; Inputs:
        ; X: short pointer to action struct

        ; Outputs:
        ; None

        _StatList  := [structActionStructEntry.Strength]
        _StatList ..= [structActionStructEntry.Magic]
        _StatList ..= [structActionStructEntry.Skill]
        _StatList ..= [structActionStructEntry.Speed]
        _StatList ..= [structActionStructEntry.Defense]

        php

        sep #$20

        .for _Stat in _StatList

          lda _Stat,b,x
          lsr a
          sta _Stat,b,x

        .endfor

        plp

        rtl

        .databank 0

      rlActionStructHalveCapturingStats ; 83/E470

        .autsiz
        .databank ?

        ; Given a short pointer to an action struct
        ; in X, halve the unit's combat stats. In
        ; ActionStruct_EnemyInitiated cases, enemies
        ; do not get their skill halved.

        ; Inputs:
        ; X: short pointer to action struct
        ; wActionStructType: action struct type

        ; Outputs:
        ; None

        php
        phb

        sep #$20

        lda #`wActionStructType
        pha

        rep #$20

        plb

        .databank `wActionStructType

        phx
        phy

        ldx wR1

        ; Enemies don't get their skill halved?

        lda #ActionStruct_EnemyInitiated
        cmp wActionStructType
        bne +

          lda structActionStructEntry.DeploymentNumber,b,x
          and #AllAllegiances
          cmp #Enemy
          bne +

            sep #$20

            lda structActionStructEntry.Skill,b,x
            asl a
            sta structActionStructEntry.Skill,b,x

        +
        jsl rlActionStructHalveCarryingStats

        ply
        plx
        plb
        plp
        rtl

        .databank 0

    .endsection ActionStructHalveStatsSection

    .section ActionStructZeroCombatStatsSection

      rlActionStructZeroCombatStats ; 83/E4A3

        .al
        .databank `aActionStructUnit1

        ; Given a short pointer to an action
        ; struct in X, clear combat stats?

        ; Always clears the second unit's item info?

        ; Inputs:
        ; X: short pointer to action struct
        ; aActionStructUnit2: filled with unit

        ; Ouputs:
        ; None

        stz aActionStructUnit2.EquippedItemID2
        stz aActionStructUnit2.EquippedItemMaxDurability
        stz aActionStructUnit2.EquippedItemInventoryIndex

        php
        sep #$20

        stz structActionStructEntry.Strength,b,x
        stz structActionStructEntry.Magic,b,x
        stz structActionStructEntry.Skill,b,x
        stz structActionStructEntry.Speed,b,x
        stz structActionStructEntry.Defense,b,x

        plp
        rtl

        .databank 0

    .endsection ActionStructZeroCombatStatsSection

    .section ActionStructSetGainedWEXPSection

      rsActionStructSetGainedWEXP ; 83/E4C0

        .autsiz
        .databank ?

        ; Given a short pointer to an action
        ; struct in X and WEXP to be gained in Y,
        ; add WEXP and cap it.

        ; Inputs:
        ; X: short pointer to action struct
        ; Y: WEXP to gain

        ; Outputs:
        ; None

        sep #$20

        lda structActionStructEntry.Status,b,x
        cmp #StatusBerserk
        beq _End

        lda structActionStructEntry.GainedWeaponEXP,b,x
        beq _End

          sta wR0
          stz wR0+size(byte)

          sty wR1
          tdc
          lda structActionStructEntry.AttackType,b,x
          clc
          adc #structActionStructEntry.WeaponRanks
          tay

          rep #$30

          lda (wR1),y
          and #$00FF
          clc
          adc wR0
          cmp #RankA
          blt +

            lda #RankA

          +
          sep #$20

          sta (wR1),y

        _End
        rep #$30

        rts

        .databank 0

    .endsection ActionStructSetGainedWEXPSection

    .section ActionStructEXPSection

      rsActionStructCalculateCombatEXPGain ; 83/E4F5

        .al
        .xl
        .autsiz
        .databank `aActionStructUnit1

        ; Try to calculate and set gained experience.

        ; Inputs:
        ; aActionStructUnit1: filled with unit
        ; aActionStructUnit2: filled with unit

        ; Outputs:
        ; None

        ; Player units gain EXP.

        lda aActionStructUnit1.DeploymentNumber
        and #AllAllegiances
        bne +

          ldx #<>aActionStructUnit1
          ldy #<>aActionStructUnit2
          bra _Continue

        +
        lda aActionStructUnit2.DeploymentNumber
        and #AllAllegiances
        bne +

          ldx #<>aActionStructUnit2
          ldy #<>aActionStructUnit1
          bra _Continue

        +
        rts

        _Continue
        stz wKillExperienceBonus

        lda structActionStructEntry.CurrentHP,b,y
        and #$00FF
        bne +

          jsr rsActionStructGetBossKillEXPBonus
          jsr rsActionStructGetThiefKillEXPBonus
          jsr rsActionStructGetKillBaseEXP

        +
        rep #$30

        jsr rsActionStructGetCombatEXP
        rts

        .databank 0

      rsActionStructGetBossKillEXPBonus ; 83/E530

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Given a short pointer to a player
        ; unit's action struct in X and an
        ; enemy's in Y, add a bonus to the
        ; running EXP bonus total if the enemy
        ; is a boss.

        ; Inputs:
        ; X: short pointer to player unit action struct
        ; Y: short pointer to enemy unit action struct
        ; wKillExperienceBonus: running total

        ; Outputs:
        ; wKillExperienceBonus: running total

        lda structActionStructEntry.Character,b,y
        cmp wChapterBoss,b
        bne +

          lda wKillExperienceBonus
          clc
          adc #40
          sta wKillExperienceBonus

        +
        rts

        .databank 0

      rsActionStructGetThiefKillEXPBonus ; 83/E543

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Given a short pointer to a player
        ; unit's action struct in X and an
        ; enemy's in Y, add a bonus to the
        ; running EXP bonus total if the enemy
        ; can steal.

        ; Inputs:
        ; X: short pointer to player unit action struct
        ; Y: short pointer to enemy unit action struct
        ; wKillExperienceBonus: running total

        ; Outputs:
        ; wKillExperienceBonus: running total

        lda structActionStructEntry.Skills1,b,y
        bit #Skill1Steal
        beq +

          lda wKillExperienceBonus
          clc
          adc #20
          sta wKillExperienceBonus

        +
        rts

      rsActionStructGetKillBaseEXP ; 83/E556

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Given a short pointer to a player
        ; unit's action struct in X and an
        ; enemy's in Y, calculate a bonus based
        ; on the units' relative powers.

        ; Inputs:
        ; X: short pointer to player unit action struct
        ; Y: short pointer to enemy unit action struct
        ; wKillExperienceBonus: running total

        ; Outputs:
        ; wKillExperienceBonus: running total

        ; Enemy mod + 20 - player mod, floor 0.

        stx wR1
        jsl rlGetTier1ClassRelativePowerModifier
        sta wR17

        sty wR1
        jsl rlGetTier1ClassRelativePowerModifier

        clc
        adc #20

        sec
        sbc wR17
        bpl +

          lda #0

        +
        clc
        adc wKillExperienceBonus
        sta wKillExperienceBonus

        rts

        .databank 0

      rsActionStructGetCombatEXP ; 83/E578

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Given a short pointer to a player
        ; unit's action struct in X and
        ; a running EXP bonus total in
        ; wKillExperienceBonus, get total
        ; EXP gained.

        ; Inputs:
        ; X: short pointer to action struct
        ; wKillExperienceBonus: running total

        ; Outputs:
        ; wKillExperienceBonus: running total

        lda structActionStructEntry.Class,b,x
        jsl rlCopyClassDataToBuffer

        lda aClassDataBuffer.ClassRelativePower
        and #$00FF
        sta wR14

        lda structActionStructEntry.Level,b,x
        and #$00FF
        sta wR0

        lda #31
        sec
        sbc wR0
        sta wR13
        jsl rlUnsignedDivide16By8

        lda wKillExperienceBonus
        clc
        adc wR13
        sta wKillExperienceBonus

        rts

        .databank 0

    .endsection ActionStructEXPSection

    .section ActionStructGetSupportBonusSection

      rlActionStructGetSupportBonus ; 83/E5A5

        .al
        .xl
        .autsiz
        .databank ?

        ; Given a recipient and a potential
        ; target, get the recipient's support bonuses.

        ; Also, seems to clear the target's weapon
        ; if they're a support partner of the recipient.

        ; Inputs:
        ; A: target deployment number
        ; X: short pointer to recipient action struct

        ; Outputs:
        ; None

        php
        phb

        tay

        sep #$20

        lda #`aActionStructUnit1
        pha

        rep #$20

        plb

        .databank `aActionStructUnit1

        ; Keep track of target, but only
        ; for players?

        sty wR14

        cpx #<>aActionStructUnit2
        beq +

          stz wR14

        +

        stz wR16 ; Running bonus total

        lda #<>aSupportData
        sta lR18
        lda #>`aSupportData
        sta lR18+size(byte)

        _Loop

        ; Grab an entry, check if end
        ; or recipient.

        lda [lR18]
        beq _End

          cmp structActionStructEntry.Character,b,x
          bne _Next

          ; Grab the giver and clear the
          ; recipient's weapon if the giver
          ; is the target.

          ldy #structSupportEntry.Giver
          lda [lR18],y
          sta wR0

          cmp wR14
          bne +

            stz aActionStructUnit2.EquippedItemID2

          +

          ; Check if the giver is alive
          ; on the map and is 3 tiles or
          ; less from the recipient.

          phx

          ldx #<>aBurstWindowCharacterBuffer
          stx wR1

          jsl rlSearchForUnitAndWriteTargetToBuffer

          plx

          ora #0
          bne _Next

          lda aBurstWindowCharacterBuffer.UnitState,b
          bit #(UnitStateDead | UnitStateUnknown1 | UnitStateDisabled | UnitStateCaptured)
          bne _Next

          sep #$20

          lda structActionStructEntry.X,b,x
          sec
          sbc aBurstWindowCharacterBuffer.X,b
          bpl +

            eor #-1
            inc a

          +
          sta wR0

          lda structActionStructEntry.Y,b,x
          sec
          sbc aBurstWindowCharacterBuffer.Y,b
          bpl +

            eor #-1
            inc a

          +
          clc
          adc wR0

          cmp #3
          beq +
          bge _Next

          +
          rep #$30

          ; Add the bonus to the
          ; running total.

          ldy #structSupportEntry.Bonus
          lda [lR18],y
          and #$00FF
          clc
          adc wR16
          sta wR16

        _Next
        rep #$30

        lda lR18
        clc
        adc #size(structSupportEntry)
        sta lR18
        bra _Loop

        _End
        lda wR16
        sta wSupportBonus
        plb
        plp
        rtl

        .databank 0

    .endsection ActionStructGetSupportBonusSection

    .section ActionStructUnknownSetCallbackSection

      rlActionStructUnknownSetCallback ; 83/E63C

        .autsiz
        .databank `lUnknown7EA4EC

        rep #$30

        lda #<>+
        sta lUnknown7EA4EC
        lda #>`+
        sta lUnknown7EA4EC+size(byte)

        +
        rtl

        .databank 0

    .endsection ActionStructUnknownSetCallbackSection

    .section ActionStructGetItemBonusesSection

      rlActionStructGetItemBonuses ; 83/E64B

        .autsiz
        .databank `aItemStatBonusBuffer

        ; Given a short pointer to an action
        ; struct in X, get and apply the unit's
        ; item bonuses.

        ; Inputs:
        ; X: short pointer to action struct

        ; Outputs:
        ; aItemStatBonusBuffer: bonuses

        php

        sep #$20

        phx

        jsr rsActionStructClearItemBonuses

        lda structActionStructEntry.EquippedItemMaxDurability,b,x
        xba
        lda structActionStructEntry.EquippedItemID1,b,x
        jsl rlCopyItemDataToBuffer

        _Main
        txy
        ldx aItemDataBuffer.StatBonus,b
        beq +

          jsr rsActionStructApplyItemBonuses

        +
        plx
        plp
        rtl

        .databank 0

      rlActionStructGetItemBonusesItemPreset ; 83/E669

        .autsiz
        .databank `aItemStatBonusBuffer

        ; Given a short pointer to an action
        ; struct in X, get and apply the unit's
        ; item bonuses.

        ; This routine assumes that aItemDataBuffer
        ; is already filled.

        ; Inputs:
        ; X: short pointer to action struct
        ; aItemDataBuffer: filled with item

        ; Outputs:
        ; aItemStatBonusBuffer: bonuses

        php

        sep #$20

        phx

        jsr rsActionStructClearItemBonuses

        bra rlActionStructGetItemBonuses._Main

        .databank 0

      rsActionStructClearItemBonuses ; 83/E672

        .as
        .autsiz
        .databank `aItemStatBonusBuffer

        ; Clears the item stat bonus buffer.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        _BonusList  := [aItemStatBonusBuffer.Strength]
        _BonusList ..= [aItemStatBonusBuffer.Skill]
        _BonusList ..= [aItemStatBonusBuffer.Speed]
        _BonusList ..= [aItemStatBonusBuffer.Luck]
        _BonusList ..= [aItemStatBonusBuffer.Defense]
        _BonusList ..= [aItemStatBonusBuffer.Constitution]
        _BonusList ..= [aItemStatBonusBuffer.Movement]

        .for _Bonus in _BonusList

          stz _Bonus

        .endfor

        rts

        .databank 0

      rsActionStructApplyItemBonuses ; 83/E688

        .autsiz
        .databank `aItemStatBonusBuffer

        ; Given a short pointer to an item
        ; bonus struct and a short pointer to an
        ; action struct, get and apply item bonuses.

        ; Inputs:
        ; X: short pointer to item bonuses
        ; Y: short pointer to action struct

        ; Outputs:
        ; aItemStatBonusBuffer: bonuses

        _BonusList  := [(structItemStatBonuses.Strength, aItemStatBonusBuffer.Strength, structActionStructEntry.Strength)]
        _BonusList ..= [(structItemStatBonuses.Skill, aItemStatBonusBuffer.Skill, structActionStructEntry.Skill)]
        _BonusList ..= [(structItemStatBonuses.Speed, aItemStatBonusBuffer.Speed, structActionStructEntry.Speed)]
        _BonusList ..= [(structItemStatBonuses.Defense, aItemStatBonusBuffer.Defense, structActionStructEntry.Defense)]
        _BonusList ..= [(structItemStatBonuses.Luck, aItemStatBonusBuffer.Luck, structActionStructEntry.Luck)]

        .for _Tup in _BonusList

          _Source := _Tup[0]
          _Bonus  := _Tup[1]
          _Stat   := _Tup[2]

          lda _Source+((`aItemBonuses)<<16),x
          sta _Bonus

          clc
          adc _Stat,b,y
          sta _Stat,b,y

        .endfor

        lda structItemStatBonuses.Magic+((`aItemBonuses)<<16),x
        clc
        adc structActionStructEntry.Magic,b,y
        sta structActionStructEntry.Magic,b,y

        lda structItemStatBonuses.Magic+((`aItemBonuses)<<16),x
        clc
        adc aItemStatBonusBuffer.Magic
        sta aItemStatBonusBuffer.Magic

        rts

        .databank 0

    .endsection ActionStructGetItemBonusesSection

    .section ActionStructWinsLossesSection

      rlTryUpdateTotalWinsCaptures ; 83/E6E5

        .al
        .autsiz
        .databank `bUnknownTargetingDeploymentNumber

        ; Increments either the wins or captures
        ; counter if a non-player unit is defeated
        ; by a player unit.

        ; Inputs:
        ; aActionStructUnit1: filled with initiator
        ; aActionStructUnit2: filled with defender
        ; bUnknownTargetingDeploymentNumber: slain unit's deployment number
        ; wCapturingFlag: nonzero if capturing, zero otherwise

        ; Outputs:
        ; None

        ; Check the defeated unit's allegiance,
        ; exit if player unit.

        lda bUnknownTargetingDeploymentNumber
        and #AllAllegiances
        beq +

          ; Check if a player unit was involved.

          lda aActionStructUnit1.DeploymentNumber
          and #AllAllegiances
          beq _CheckType

          lda aActionStructUnit2.DeploymentNumber
          and #AllAllegiances
          beq _CheckType

        +
        rtl

        _CheckType

          ; Use the capturing flag to determine
          ; the type of victory.

          lda wCapturingFlag
          beq _Win

            ; Oops, the inc doesn't load
            ; the counter's value into A,
            ; while the cmp thinks that the
            ; count is in A. In reality, the
            ; capturing flag is in A and the
            ; cap-at-9999 stuff here will never
            ; be used. Also, it returns the capped
            ; value in A instead of storing it
            ; to the counter. The routine that
            ; calls this one thankfully doesn't
            ; use the return value.

            inc wCaptureCounter,b
            cmp #9999
            bcc +

              lda #9999

            +
            rtl

        _Win

          ; See above.

          inc wWinCounter,b
          cmp #9999
          bcc +

            lda #9999

          +
          rtl

          .databank 0

      rlActionStructTryUpdateWinsLosses ; 83/E71B

        .al
        .xl
        .autsiz
        .databank `bUnknown7E4FCF

        ; Given a battle outcome type, try updating
        ; wins/losses for each unit

        ; Inputs:
        ; aActionStructUnit1: filled with initiator
        ; aActionStructUnit2: filled with defender
        ; bUnknown7E4FCF: battle outcome type
        ; bUnknownTargetingDeploymentNumber: deployment number
        ;   of defeated unit

        ; Outputs:
        ; None

        _BattleOutcomeList := [$02, $04, $12, $14]

        lda bUnknown7E4FCF
        and #$00FF

        .for _Outcome in _BattleOutcomeList

          cmp #_Outcome
          beq +

        .endfor

        rtl

        +
        ldy #<>aActionStructUnit1
        jsr rsActionStructTryUpdateWinsLosses

        ldy #<>aActionStructUnit2
        jsr rsActionStructTryUpdateWinsLosses

        rtl

        .databank 0

      rsActionStructTryUpdateWinsLosses ; 83/E743

        .al
        .xl
        .autsiz
        .databank `bUnknown7E4FCF

        ; Inputs:
        ; Y: short pointer to action struct
        ; bUnknownTargetingDeploymentNumber: deployment number
        ;   of defeated unit

        ; Outputs:
        ; None

        ; Only player units have win/loss entries.

        lda structActionStructEntry.DeploymentNumber,b,y
        and #AllAllegiances
        bne _End

        ; Only specific characters have an entry
        ; in the wins/losses offset table.

        lda structActionStructEntry.Character,b,y
        jsl rlGetCharacterWinLossTableOffset
        bcs _End

          ; Table offset

          tax

          sep #$20

          ; Determine if it's a win or a loss.

          lda structActionStructEntry.DeploymentNumber,b,y
          cmp bUnknownTargetingDeploymentNumber
          beq +

            lda aWinsTable,x
            cmp #-1
            beq _End

              inc aWinsTable,x
              bra _End

          +
          lda aLossesTable,x
          cmp #-1
          beq _End

            inc aLossesTable,x

        _End
        rep #$30
        rts

        .databank 0

    .endsection ActionStructWinsLossesSection

    .section ActionStructGetCombatStatTotalSection

      rlActionStructGetCombatStatTotal ; 83/E778

        .autsiz
        .databank ?

        ; Given a unit's action struct,
        ; calculate the total of their core
        ; combat stats.

        ; Inputs:
        ; Y: short pointer to action struct

        ; Outputs:
        ; A: stat total

        _StatList  := [structActionStructEntry.Strength]
        _StatList ..= [structActionStructEntry.Magic]
        _StatList ..= [structActionStructEntry.Skill]
        _StatList ..= [structActionStructEntry.Speed]
        _StatList ..= [structActionStructEntry.Defense]

        ldy wR1

        tdc

        sep #$20

        lda _StatList[0],b,y

        .for stat in _StatList[1:]

          clc
          adc stat,b,y

        .endfor

        rep #$30

        rtl

        .databank 0

    .endsection ActionStructGetCombatStatTotalSection

    .section ActionStructGetStatTotalDifferenceTierSection

      rlActionStructGetStatTotalDifferenceTier ; 83/E793

        _StatList  := [structActionStructEntry.Strength]
        _StatList ..= [structActionStructEntry.Magic]
        _StatList ..= [structActionStructEntry.Skill]
        _StatList ..= [structActionStructEntry.Speed]
        _StatList ..= [structActionStructEntry.Defense]

        _TotalCap := StatCap * len(_StatList)

        _Tiers  := [( 85, 0)]
        _Tiers ..= [( 95, 1)]
        _Tiers ..= [(105, 2)]
        _Tiers ..= [(115, 2)]

        ; Dummy snippet for size()

        .virtual

          .al
          .autsiz

          _TierSetting .block
            lda #$0000
            rtl
          .bend

        .endv

        .al
        .autsiz
        .databank ?

        ; Given the combat stat totals of two
        ; units, return a `tier` representing
        ; their relative strength.

        ; Inputs:
        ; wR0: unit 1 combat stat total
        ; wR1: unit 2 combat stat total

        ; Outputs:
        ; A: difference tier

        ; Calculate threshold as
        ; unit1 + 100 - unit2

        lda wR0
        clc
        adc #_TotalCap

        sec
        sbc wR1

        ; This is done using calculated jump
        ; distances to allow for a list of arbitrary
        ; size.

        .for _Tier in _Tiers

          _Threshold := _Tier[0]
          _Tier      := _Tier[1]

          cmp #_Threshold
          blt _TierReturns + (size(_TierSetting) * _Tier)

        .endfor

        bra _TierReturns + (size(_TierSetting) * _Tiers[-1][1])

        _TierReturns

        .for _Tier in _Tiers[:-1,1]

          lda #_Tier
          rtl

        .endfor

        .databank 0

    .endsection ActionStructGetStatTotalDifferenceTierSection

    .section ActionStructTryGetGainedWeaponRankSection

      rsActionStructTryGetGainedWeaponRank ; 83/E879

        .al
        .autsiz
        .databank `aActionStructUnit1

        ; Given a short pointer to an action 
        ; struct in X with its GainedWeaponEXP set,
        ; Check if a weapon rank was gained.

        ; Inputs:
        ; X: short pointer to action struct

        ; Outputs:
        ; structActionStructEntry.WeaponEXP: attack type if rank gained
        ;   or -1 if no rank gained

        ; To gain a weapon rank, a unit needs to be alive,
        ; not berserked, and have a weapon rank in that type.

        lda structActionStructEntry.CurrentHP,b,x
        and #$00FF
        beq _NoRankIncrease

        lda structActionStructEntry.Status,b,x
        and #$00FF
        cmp #StatusBerserk
        beq _NoRankIncrease

        lda structActionStructEntry.Class,b,x
        jsl rlCopyClassDataToBuffer

        lda structActionStructEntry.AttackType,b,x
        and #$00FF
        tay
        lda aClassDataBuffer.WeaponRanks,y
        and #$00FF
        beq _NoRankIncrease

          ; Get current weapon rank.

          lda structActionStructEntry.WeaponEXP,b,x
          and #$00FF
          sta wR13
          lda #WeaponRankIncrement
          sta wR14
          jsl rlUnsignedDivide16By8

          lda wR13
          sta wR0

          ; Get new weapon rank, capping at A.

          lda structActionStructEntry.GainedWeaponEXP,b,x
          and #$00FF
          sta wR1

          lda structActionStructEntry.WeaponEXP,b,x
          and #$00FF
          clc
          adc wR1

          cmp #RankA
          bcc +

            lda #RankA

          +
          sta wR13
          lda #WeaponRankIncrement
          sta wR14
          jsl rlUnsignedDivide16By8

          ; We've gained a rank if the ranks
          ; are different.

          lda wR13
          cmp wR0
          bne _RankIncrease

        _NoRankIncrease
        sep #$20

        lda #-1
        sta structActionStructEntry.WeaponEXP,b,x

        rep #$20

        rts

        _RankIncrease
        sep #$20

        lda structActionStructEntry.AttackType,b,x
        sta structActionStructEntry.WeaponEXP,b,x

        rep #$20

        rts

        .databank 0

    .endsection ActionStructTryGetGainedWeaponRankSection

.endif ; GUARD_FE5_ACTIONSTRUCT
