
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_ACTIONSTRUCT :?= false
.if (!GUARD_FE5_ACTIONSTRUCT)
  GUARD_FE5_ACTIONSTRUCT := true

  .include "../../VoltEdge/VoltEdge.h"

  ; Definitions

    .weak

      rlUnsignedDivide16By8                         :?= address($80AAC3)
      rlGetRandomNumber100                          :?= address($80B0E6)
      rlGetMapUnitsInRange                          :?= address($80E5CD)
      rlFillMapByWord                               :?= address($80E849)
      rlGetCharacterWinLossTableOffset              :?= address($81C9C7)
      rlGetMapTileIndexByCoords                     :?= address($838E76)
      rlCopyCharacterDataToBufferByDeploymentNumber :?= address($83901C)
      rlCopyExpandedCharacterDataBufferToBuffer     :?= address($83905C)
      rlCombineCharacterDataAndClassBases           :?= address($8390BE)
      rlCopyClassDataToBuffer                       :?= address($8393E0)
      rlCopyCharacterDataToBuffer                   :?= address($83941A)
      rlGetEquippableItemInventoryOffset            :?= address($839705)
      rlSearchForUnitAndWriteTargetToBuffer         :?= address($83976E)
      rlRunRoutineForAllUnitsInAllegiance           :?= address($839825)
      rlRunRoutineForAllVisibleUnitsInRange         :?= address($8398FD)
      rlRunRoutineForAllItemsInInventory            :?= address($83993C)
      rlGetTier1ClassRelativePowerModifier          :?= address($83A9EC)
      rlCopyItemDataToBuffer                        :?= address($83B00D)

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

      ; Stat stuff?

        ; These should probably be moved into
        ; a different file or something?

        HPCap   := 80
        StatCap := 20

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
        ;   None

        ; Outputs:
        ;   None

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
        ;   lR18: short pointer to action struct

        ; Outputs:
        ;   None

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
        ;   wR1: short pointer to action struct

        ; Outputs:
        ;   None

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
        ;   wR2: X coordinates
        ;   wR3: Y coordinate

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

    .section ActionStructWeaponTriangleSection

      rlActionStructCheckIfWeaponTriangleAdvantage ; 83/DBC4

        .autsiz
        .databank ?

        ; Given a weapon type and an opponent's
        ; weapon type, check if weapon is effective
        ; against opponent's weapon.

        ; Inputs:
        ;   wR0: weapon type to check
        ;   wR1: opponent's weapon type

        ; Outputs:
        ;   Carry set if advantage, else carry clear

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

    .section ActionStructLevelUpSection

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
        ;   X: short pointer to action struct

        ; Outputs:
        ;   aUnitAdjustedGrowths: filled with growths

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
        ;   A: item ID
        ;   aUnitAdjustedGrowths: filled with growths

        ; Outputs:
        ;   aUnitAdjustedGrowths: modified growths

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
        ;   aUnitAdjustedGrowths: filled with growths

        ; Outputs:
        ;   aUnitAdjustedGrowths: clamped growths

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




    .endsection ActionStructLevelUpSection

    .section ActionStructCalculateGainedWEXPSection

      rsActionStructRollGainedWEXP ; 83/E2B0

        .autsiz
        .databank ?

        ; Given a percent chance in A,
        ; roll number of gained weapon WEXP.

        ; Inputs:
        ;   A: percent chance

        ; Outputs:
        ;   wR1: WEXP

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
        ;   X: short pointer to action struct

        ; Outputs:
        ; None

        php

        sep #$20

        tdc
        lda structActionStructEntry.WeaponEXPGainChance,b,x
        jsr rsActionStructRollGainedWEXP
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

    .endsection ActionStructCalculateGainedWEXPSection

    .section ActionStructCalculateHitAvoidBonusSection

      rsActionStructCalculateHitAvoidBonus ; 83/E2F3

        .autsiz
        .databank `wActionStructType

        ; Given two units, a recipient and a target,
        ; get the recipient's hit/avoid bonus from
        ; supports, leadership, and charm.

        ; Inputs:
        ;   X: short pointer to recipient action struct
        ;   Y: short pointer to target action struct

        ; Outputs:
        ;   None

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
        ;   X: short pointer to action struct
        ;   wHitAvoidBonus: running total

        ; Outputs:
        ;   wHitAvoidBonus: running total

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
        sta wActiveTileXCoordinate

        lda structActionStructEntry.Y,b,x
        and #$00FF
        sta wR1
        sta wActiveTileYCoordinate

        lda structActionStructEntry.DeploymentNumber,b,x
        and #AllAllegiances
        sta wActiveTileUnitAllegiance

        lda #<>aMovementMap
        sta wR3
        lda #pack([1, 3], size(byte))
        jsl rlGetMapUnitsInRange

        ; Exclude the unit itself.

        lda wActiveTileXCoordinate
        sta wR0
        lda wActiveTileYCoordinate
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
        ;   wR0: deployment number
        ;   wActiveTileUnitAllegiance: target allegiance
        ;   wHitAvoidBonus: running total

        ; Output:
        ;   wHitAvoidBonus: running total

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
        ;   X: short pointer to action stuct
        ;   wHitAvoidBonus: running total

        ; Outputs:
        ;   wHitAvoidBonus: running total

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
        ;   aTargetingCharacterBuffer: potential leader unit
        ;   wR17: faction

        ; Outputs:
        ;   wHitAvoidBonus: running total

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
        ;   wCapturingFlag: set if capturing,
        ;     unset otherwise
        ;   aActionStructUnit1: filled with unit

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
        ;   X: short pointer to action struct

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
        ;   X: short pointer to action struct
        ;   wActionStructType: action struct type

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
        ;   X: short pointer to action struct
        ;   aActionStructUnit2: filled with unit

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
        ;   X: short pointer to action struct
        ;   Y: WEXP to gain

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
        ;   X: short pointer to player unit action struct
        ;   Y: short pointer to enemy unit action struct
        ;   wKillExperienceBonus: running total

        ; Outputs:
        ;   wKillExperienceBonus: running total

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
        ;   X: short pointer to player unit action struct
        ;   Y: short pointer to enemy unit action struct
        ;   wKillExperienceBonus: running total

        ; Outputs:
        ;   wKillExperienceBonus: running total

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
        ;   X: short pointer to player unit action struct
        ;   Y: short pointer to enemy unit action struct
        ;   wKillExperienceBonus: running total

        ; Outputs:
        ;   wKillExperienceBonus: running total

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
        ;   X: short pointer to action struct
        ;   wKillExperienceBonus: running total

        ; Outputs:
        ;   wKillExperienceBonus: running total

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
        ;   A: target deployment number
        ;   X: short pointer to recipient action struct

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
        ;   X: short pointer to action struct

        ; Outputs:
        ;   aItemStatBonusBuffer: bonuses

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
        ;   X: short pointer to action struct
        ;   aItemDataBuffer: filled with item

        ; Outputs:
        ;   aItemStatBonusBuffer: bonuses

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
        ;   X: short pointer to item bonuses
        ;   Y: short pointer to action struct

        ; Outputs:
        ;   aItemStatBonusBuffer: bonuses

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
        ;   aActionStructUnit1: filled with initiator
        ;   aActionStructUnit2: filled with defender
        ;   bUnknownTargetingDeploymentNumber: slain unit's deployment number
        ;   wCapturingFlag: nonzero if capturing, zero otherwise

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

.endif ; GUARD_FE5_ACTIONSTRUCT
