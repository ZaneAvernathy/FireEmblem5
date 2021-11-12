
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_ACTIONSTRUCT_STAFF :?= false
.if (!GUARD_FE5_ACTIONSTRUCT_STAFF)
  GUARD_FE5_ACTIONSTRUCT_STAFF := true

  .include "../../VoltEdge/VoltEdge.h"

  ; Definitions

    .weak

      rlUnsignedDivide16By8                         :?= address($80AAC3)
      rlFillMovementRangeArrayWithTerrainCosts      :?= address($80DE12)
      rlFillMovementRangeArray                      :?= address($80DE28)
      rlCopyTerrainMovementCostBuffer               :?= address($80E43B)
      rlGetMapTileIndexByCoords                     :?= address($838E76)
      rlGetMapCoordsByTileIndex                     :?= address($838E84)
      rlCopyCharacterDataToBufferByDeploymentNumber :?= address($83901C)
      rlCopyCharacterDataFromBuffer                 :?= address($839041)
      rlCopyExpandedCharacterDataBufferToBuffer     :?= address($83905C)
      rlCombineCharacterDataAndClassBases           :?= address($8390BE)
      rlGetEquippableItemInventoryOffset            :?= address($839705)
      rlRunRoutineForAllTilesInRange                :?= address($8398C7)
      rlUpdateRescuedUnitCoordinatesByBuffer        :?= address($839B5A)
      rlTryGiveCharacterItemFromBuffer              :?= address($83A443)
      rlClearInventorySlot                          :?= address($83A487)
      rlRollRandomNumber0To100                      :?= address($83A791)
      rlCopyItemDataToBuffer                        :?= address($83B00D)
      rlTryGetBrokenItemID                          :?= address($83B0B7)
      rlGetRepairedItemID                           :?= address($83B179)
      rlGetTransformedItem                          :?= address($83B1A9)
      rsActionStructCopyStartingStats               :?= address($83D037)
      rsActionStructGetTerrainBonusesAndDistance    :?= address($83D1F3)
      rsActionStructWriteRound                      :?= address($83D529)
      rsActionStructTerminateRoundArray             :?= address($83D55B)
      rlActionStructAddLevelupCoreStats             :?= address($83DABE)
      rsActionStructTryGetBothLevelupGains          :?= address($83DCC0)
      rlActionStructUnknownSetCallback              :?= address($83E63C)
      rlActionStructGetItemBonusesItemPreset        :?= address($83E669)
      rsActionStructTryGetGainedWeaponRank          :?= address($83E879)
      rsActionStructSetGainedEXP                    :?= address($83EF86)
      rsActionStructGetStaffInfo                    :?= address($83F006)

      rlUnknown848E5A                               :?= address($848E5A)

      rlGetItemTargetEffectPointer                  :?= address($87B192)
      rlMakeFortifyTargetList                       :?= address($87B8A9)

      rlRunChapterLocationEvents                    :?= address($8C9CBD)

    .endweak

  ; Freespace inclusions

    .section ActionStructStaffSection

      rsActionStructStaff ; 83/E990

        .xl
        .autsiz
        .databank ?

        php
        phb

        sep #$20

        lda #`aActionStructUnit1
        pha

        rep #$20

        plb

        .databank `aActionStructUnit1

        stz $7EA4E8

        jsl rlActionStructUnknownSetCallback

        lda #$0003
        sta wActionStructGeneratedRoundCombatType

        ldx #<>aActionStructUnit1
        stx wR1
        jsr rsActionStructCopyStartingStats

        ldx #<>aActionStructUnit2
        stx wR1
        jsr rsActionStructCopyStartingStats

        lda #<>aActionStructUnit2
        sta wR1
        jsl rlGetEquippableItemInventoryOffset

        sep #$20

        lda aItemDataBuffer.DisplayedWeapon,b
        sta aActionStructUnit2.EquippedItemID1

        lda aItemDataBuffer.Durability,b
        sta aActionStructUnit2.EquippedItemMaxDurability

        rep #$30

        jsr rsActionStructGetTerrainBonusesAndDistance

        ldx wUnknownStaffActionStructPointer

        lda aActionStructUnit1.Items,x
        jsl rlCopyItemDataToBuffer

        jsr rsActionStructGetStaffInfo
        jsr rsActionStructClearGeneratedRounds
        jsl rlGetItemTargetEffectPointer

        phk
        pea <>(+)-1
        jmp [lR18]

        +
        ldx wUnknownStaffActionStructPointer

        lda aActionStructUnit1.EquippedItemID2
        sta aActionStructUnit1.Items,x

        ldx #<>aActionStructUnit1
        txy
        jsr rsActionStructSetGainedWEXP

        ldx #<>aActionStructUnit1
        jsr rsActionStructTryGetGainedWeaponRank
        jsr rsActionStructAddStaffFatigue
        jsr rsActionStructStaffGetEXPByCost
        jsr rsActionStructSetGainedEXP
        jsr rsActionStructTryGetBothLevelupGains

        lda #<>aActionStructUnit1
        sta wR0
        lda #<>aSelectedCharacterBuffer
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        ldx #<>aActionStructUnit1
        ldy #<>aSelectedCharacterBuffer
        jsl rlActionStructAddLevelupCoreStats

        plb
        plp
        rtl

        .databank 0

      rsActionStructAddStaffFatigue ; 83/EA2B

        .al
        .xl
        .autsiz
        .databank `aActionStructUnit1

        _StaffFatigueTiers  := [(RankE, 1)]
        _StaffFatigueTiers ..= [(RankD, 2)]
        _StaffFatigueTiers ..= [(RankC, 3)]
        _StaffFatigueTiers ..= [(RankB, 4)]
        _StaffFatigueTiers ..= [(RankA, 5)]

        lda aActionStructUnit1.EquippedItemID2
        jsl rlCopyItemDataToBuffer

        lda aItemDataBuffer.BaseWeapon,b
        and #$00FF
        ora #pack([None, 1])
        jsl rlCopyItemDataToBuffer

        lda aItemDataBuffer.WeaponRank,b
        ldx #0

        _Loop
          cmp _CutoffTable,x
          blt +

            inc x
            inc x
            bra _Loop

          +
          sep #$20

          lda aActionStructUnit1.Fatigue
          cmp #-1
          beq _End

            clc
            adc _FatigueTable,x

            cmp #99
            blt +

              lda #99

            +
            sta aActionStructUnit1.Fatigue

        _End
        rep #$30

        rts

        .databank 0

        _CutoffTable .for _Rank in _StaffFatigueTiers[:,0]
          ; Automatically cap table
          .if _Rank == _StaffFatigueTiers[-1][0]
            .sint -1
          .else
            .word _Rank + WeaponRankIncrement
          .endif
        .endfor

        _FatigueTable .for _Tier in _StaffFatigueTiers[:,1]
          .word _Tier
        .endfor

    .endsection ActionStructStaffSection

    .section HealingStaffTargetEffectSection

      rlHealingStaffTargetEffect ; 83/EA7D

        .xl
        .autsiz
        .databank `wActiveTileUnitParameter2

        _HealingStaffAmountList  := [(Heal, 10)]
        _HealingStaffAmountList ..= [(Mend, 20)]
        _HealingStaffAmountList ..= [(Recover, 80)]
        _HealingStaffAmountList ..= [(Physic, 10)]

        stz wActiveTileUnitParameter2
        ldx #0

        sep #$20

        _Loop
        lda _aHealingStaffAmountTable,x
        cmp aItemDataBuffer.DisplayedWeapon,b
        beq +

          inc x
          inc x
          bra _Loop

        +
        rep #$30

        lda _aHealingStaffAmountTable+size(byte),x
        and #$00FF
        jsr rsActionStructStaffGetPower
        sta wR15
        bra _Continue

        _aHealingStaffAmountTable ; 83/EAA2
          .for _Tup in _HealingStaffAmountList
            _Staff  := _Tup[0]
            _Amount := _Tup[1]

            .byte _Staff, _Amount

          .endfor

        _Continue
        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc _Miss

          sep #$20
          lda aActionStructUnit2.CurrentHP
          pha
          clc
          adc wR15
          cmp aActionStructUnit2.MaxHP
          blt +

            lda aActionStructUnit2.MaxHP

          +
          sta aActionStructUnit2.CurrentHP

          pla
          sec
          sbc aActionStructUnit2.CurrentHP
          sta wActionStructRoundTempDamage

          rep #$30

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          inc $7EA4E8

          bra +

        _Miss
          lda wActionStructRoundAttackBitfield
          ora #RoundAttackFlagMiss
          sta wActionStructRoundAttackBitfield

        +
        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        jsr rsActionStructWriteRound

        stz wActionStructRoundAttackBitfield
        stz wActionStructRoundTempDamage

        inc wActiveTileUnitParameter2

        lda aActionStructUnit1.EquippedItemID2
        and #$00FF
        cmp #DrainedStaff
        beq +

          lda #<>aActionStructUnit1
          sta wR1
          lda #<>aActionStructUnit2
          sta wR2
          jsl rlActionStructStaffRollDoubling
          bcs _Continue

        +
        jsr rsActionStructTerminateRoundArray
        rtl

        .databank 0

    .endsection HealingStaffTargetEffectSection

    .section FortifyTargetEffectSection

      rlFortifyTargetEffect ; 83/EB1C

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc _Continue

          stz wActionStructRoundAttackBitfield

          lda #10
          jsr rsActionStructStaffGetPower
          sta wR15

          jsl rlMakeFortifyTargetList

          _Loop
            dec $7EA7AD
            dec $7EA7AD
            bmi _EndLoop

            ldx $7EA7AD

            lda $7EA7AF,x
            sta wR0
            lda #<>aActionStructUnit2
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            sep #$20

            lda aActionStructUnit2.CurrentHP
            clc
            adc wR15
            cmp aActionStructUnit2.MaxHP
            blt +

              lda aActionStructUnit2.MaxHP

            +
            sta aActionStructUnit2.CurrentHP

            rep #$30

            lda #<>aActionStructUnit2
            sta wR1
            jsl rlCopyCharacterDataFromBuffer
            bra _Loop

        _EndLoop
          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2
          inc $7EA4E8

        _Continue
        sep #$20

        lda aActionStructUnit1.DeploymentNumber
        sta aActionStructUnit2.DeploymentNumber

        rep #$20

        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

    .endsection FortifyTargetEffectSection

    .section SilenceStaffTargetEffectSection

      rlSilenceStaffTargetEffect ; 83/EB99

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          lda #<>rlStatusStaffCallback
          sta lUnknown7EA4EC
          lda #>`rlStatusStaffCallback
          sta lUnknown7EA4EC+size(byte)

          sep #$20

          lda #StatusSilence
          sta aActionStructUnit2.PostBattleStatus

          rep #$20

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          inc $7EA4E8

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

    .endsection SilenceStaffTargetEffectSection

    .section BerserkStaffTargetEffectSection

      rlBerserkStaffTargetEffect ; 83/EBDC

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          lda #<>rlStatusStaffCallback
          sta lUnknown7EA4EC
          lda #>`rlStatusStaffCallback
          sta lUnknown7EA4EC+size(byte)

          sep #$20

          lda #StatusBerserk
          sta aActionStructUnit2.PostBattleStatus

          rep #$20

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          inc $7EA4E8

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

    .endsection BerserkStaffTargetEffectSection

    .section SleepStaffTargetEffectSection

      rlSleepStaffTargetEffect ; 83/EC1F

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          inc $7EA4E8

          sep #$20

          lda #StatusSleep
          sta aActionStructUnit2.PostBattleStatus

          lda #$06
          sta bUnknown7E4FCF

          lda aActionStructUnit2.DeploymentNumber
          sta bDefeatedUnitDeploymentNumber

          rep #$30

          lda #<>rlStatusStaffCallback
          sta lUnknown7EA4EC
          lda #>`rlStatusStaffCallback
          sta lUnknown7EA4EC+size(byte)

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

    .endsection SleepStaffTargetEffectSection

    .section StatusStaffCallbackSection

      rlStatusStaffCallback ; 83/EC6D

        .autsiz
        .databank ?

        php
        phb

        sep #$20

        lda #`aActionStructUnit2
        pha

        rep #$20

        plb

        .databank `aActionStructUnit2

        sep #$20

        lda aActionStructUnit2.PostBattleStatus
        sta aActionStructUnit2.Status

        rep #$20

        lda $7E524C
        bne +

          lda #<>aActionStructUnit2
          sta wR1
          jsl rlUnknown848E5A

        +
        lda #<>aActionStructUnit2
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

        plb
        plp
        rtl

        .databank 0

    .endsection StatusStaffCallbackSection

    .section RestoreTargetEffectSection

      rlRestoreTargetEffect ; 83/EC9B

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          lda #<>rlStatusStaffCallback
          sta lUnknown7EA4EC
          lda #>`rlStatusStaffCallback
          sta lUnknown7EA4EC+size(byte)

          sep #$20

          lda #None
          sta aActionStructUnit2.PostBattleStatus

          rep #$20

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          inc $7EA4E8

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

    .endsection RestoreTargetEffectSection

    .section WarpTargetEffectSection

      rlWarpTargetEffect ; 83/ECDE

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          lda #<>aActionStructUnit2
          sta wR1
          jsl rlActionStructStaffTryGetClosestTile

          sep #$20

          lda wActiveTileUnitParameter1
          sta aActionStructUnit2.BattleAdjustedHit

          lda wActiveTileUnitParameter2
          sta aActionStructUnit2.BattleHit

          rep #$30

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          inc $7EA4E8

          lda #<>rlWarpCallback
          sta lUnknown7EA4EC
          lda #>`rlWarpCallback
          sta lUnknown7EA4EC+size(byte)

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

      rlWarpCallback ; 83/ED31

        .autsiz
        .databank ?

        php
        phb

        sep #$20

        lda #`aActionStructUnit2
        pha

        rep #$20

        plb

        .databank `aActionStructUnit2

        sep #$20

        lda wActiveTileUnitParameter1
        sta aActionStructUnit2.X
        lda wActiveTileUnitParameter2
        sta aActionStructUnit2.Y

        rep #$30

        lda #<>aActionStructUnit2
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

        lda #<>aActionStructUnit2
        sta wR1
        jsl rlUpdateRescuedUnitCoordinatesByBuffer

        plb
        plp
        rtl

        .databank 0

    .endsection WarpTargetEffectSection

    .section RewarpTargetEffectSection

      rlRewarpTargetEffect ; 83/ED60

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          lda #<>aActionStructUnit1
          sta wR1
          jsl rlActionStructStaffTryGetClosestTile

          sep #$20

          lda wActiveTileUnitParameter1
          sta aActionStructUnit1.BattleAdjustedHit

          lda wActiveTileUnitParameter2
          sta aActionStructUnit1.BattleHit

          stz aActionStructUnit2.DeploymentNumber

          rep #$30

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          inc $7EA4E8

          lda #<>rlRewarpCallback
          sta lUnknown7EA4EC
          lda #>`rlRewarpCallback
          sta lUnknown7EA4EC+size(byte)

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

      rlRewarpCallback ; 83/EDB6

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

        sep #$20

        lda wActiveTileUnitParameter1
        sta aSelectedCharacterBuffer.X,b
        lda wActiveTileUnitParameter2
        sta aSelectedCharacterBuffer.Y,b

        plb
        plp
        rtl

        .databank 0

    .endsection RewarpTargetEffectSection

    .section BarrierTargetEffectSection

      rlBarrierTargetEffect ; 83/EDD1

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          lda #<>aActionStructUnit1
          sta wR0

          lda #<>aActionStructUnit2
          sta wR1
          jsl rlActionStructStaffTryGetClosestTile

          sep #$20

          lda #$07
          sta aActionStructUnit2.MagicBonus

          rep #$30

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          inc $7EA4E8

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

    .endsection BarrierTargetEffectSection

    .section RescueStaffTargetEffectSection

      rlRescueStaffTargetEffect ; 83/EE16

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR0
        lda #<>aTemporaryActionStruct
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda #<>aActionStructUnit2
        sta wR0
        lda #<>aItemSkillCharacterBuffer
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda aTemporaryActionStruct.X,b
        and #$00FF
        sta wR0
        lda aTemporaryActionStruct.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords

        tax

        sep #$20

        lda aTemporaryActionStruct.DeploymentNumber,b
        sta aPlayerVisibleUnitMap,x

        rep #$20

        lda aItemSkillCharacterBuffer.X,b
        and #$00FF
        sta wR0
        lda aItemSkillCharacterBuffer.Y,b
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords

        tax

        sep #$20

        lda #None
        sta aPlayerVisibleUnitMap,x

        rep #$20

        jsl rlActionStructStaffGetClosestTile
        jmp rlWarpTargetEffect

        .databank 0

    .endsection RescueStaffTargetEffectSection

    .section TorchStaffTargetEffectSection

      rlTorchStaffTargetEffect ; 83/EE76

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          lda #<>rlTorchStaffCallback
          sta lUnknown7EA4EC

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          inc $7EA4E8

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

      rlTorchStaffCallback ; 83/EEAA

        .autsiz
        .databank ?

        sep #$20

        lda #10
        sta aSelectedCharacterBuffer.VisionBonus,b

        rep #$20

        rtl

        .databank 0

    .endsection TorchStaffTargetEffectSection

    .section HammerneTargetEffectSection

      rlHammerneTargetEffect ; 83/EEB4

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          ldx wActiveTileUnitParameter1

          lda aActionStructUnit2.Items,x
          jsl rlGetRepairedItemID

          ldx wActiveTileUnitParameter1

          sta aActionStructUnit2.Items,x

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          inc $7EA4E8

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

    .endsection HammerneTargetEffectSection

    .section ThiefStaffTargetEffectSection

      rlThiefStaffTargetEffect ; 83/EEF2

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        stz wActiveTileUnitParameter2

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc _End

          stz wActionStructRoundAttackBitfield

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          ldx wActiveTileUnitParameter1

          lda aActionStructUnit2.Items,x
          jsl rlGetTransformedItem

          sta aActionStructUnit2.EquippedItemID2
          sta wActiveTileUnitParameter2

          jsl rlCopyItemDataToBuffer

          lda #<>aActionStructUnit1
          sta wR1
          jsl rlTryGiveCharacterItemFromBuffer
          bcs +

            stz wActiveTileUnitParameter2

          +
          lda wActiveTileUnitParameter1
          sta wR0

          lda #<>aActionStructUnit2
          sta wR1
          jsl rlClearInventorySlot
          jsl rlActionStructUnknownSetCallback

        _End
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

    .endsection ThiefStaffTargetEffectSection

    .section ActionStructStaffGetEXPByCostSection

      rsActionStructStaffGetEXPByCost ; 83/EF54

        .al
        .autsiz
        .databank `aActionStructUnit2

        ; Gets the experience gain from a staff
        ; using the formula ((cost per use - 200) / 20) + 10

        ; Inputs:
        ; aActionStructUnit1: filled with unit

        ; Outputs:
        ; A: experience

        lda aActionStructUnit1.DeploymentNumber
        and #AllAllegiances
        bne +

          lda aActionStructUnit1.EquippedItemID1
          and #$00FF
          ora #pack([None, 1])
          jsl rlCopyItemDataToBuffer
          lda aItemDataBuffer.Cost,b
          sec
          sbc #200

          sta wR13
          lda #20
          sta wR14
          jsl rlUnsignedDivide16By8

          lda wR13
          clc
          adc #10
          rts

        +
        lda #0
        rts

        .databank 0

    .endsection ActionStructStaffGetEXPByCostSection

    .section ReturnStaffTargetEffectSection

      rlReturnStaffTargetEffect ; 83/F07E

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          sep #$20

          lda aActionStructUnit2.DeploymentNumber
          sta bDefeatedUnitDeploymentNumber

          lda #$10
          sta bUnknown7E4FCF

          rep #$30

          lda #<>rlReturnStaffCallback
          sta lUnknown7EA4EC
          lda #>`rlReturnStaffCallback
          sta lUnknown7EA4EC+size(byte)

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

      rlReturnStaffCallback ; 83/F0C4

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

        lda aActionStructUnit2.UnitState
        ora #(UnitStateUnknown1 | UnitStateHidden)
        sta aActionStructUnit2.UnitState

        lda #<>aActionStructUnit2
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

        plb
        plp
        rtl

        .databank 0

    .endsection ReturnStaffTargetEffectSection

    .section ActionStructStaffGetClosestTileSection

      rlActionStructStaffGetClosestTile ; 83/F0E3

        .al
        .autsiz
        .databank `wActiveTileUnitParameter1

        ; Given a unit in aTemporaryActionStruct,
        ; try to get the closest standable tile to their
        ; coordinates.

        ; Inputs:
        ; aTemporaryActionStruct: filled with unit

        ; Outputs:
        ; wActiveTileUnitParameter1: X coordinate
        ; wActiveTileUnitParameter2: Y coordinate

        lda aTemporaryActionStruct.X,b
        and #$00FF
        sta wActiveTileUnitParameter1

        lda aTemporaryActionStruct.Y,b
        and #$00FF
        sta wActiveTileUnitParameter2

        ; Try to get the closest tile that the
        ; unit's class could pathfind to from the
        ; original tile.

        lda aItemSkillCharacterBuffer.Class,b
        and #$00FF
        sta wR3
        jsl rlActionStructStaffGetClosestPathableTile

        ; If no pathable tile exists, just try
        ; getting the nearest standable tile.

        lda $7E4008
        cmp #-1
        bne +

        lda aItemSkillCharacterBuffer.Class,b
        and #$00FF
        sta wR3
        jsl rlActionStructStaffGetClosestStandableTile

        ; If no standable tiles exist, hang.

        lda $7E4008
        cmp #-1
        bne +

        -
        bra -

        +
        lda $7E400A
        jsl rlGetMapCoordsByTileIndex
        lda wR0
        sta wActiveTileUnitParameter1
        lda wR1
        sta wActiveTileUnitParameter2
        rtl

        .databank 0

      rlActionStructStaffGetClosestPathableTile ; 83/F131

        .al
        .autsiz
        .databank `wActiveTileUnitParameter1

        ; Gets the easiest-to-path-to unoccupied
        ; tile nearest to a tile.

        ; Inputs:
        ; wActiveTileUnitParameter1: X coordinate
        ; wActiveTileUnitParameter2: Y coordinate
        ; wR3: class

        ; Outputs:
        ; $7E4008: movement cost, -1 if no tile available
        ; $7E400A: tile index, -1 if no tile available

        lda wActiveTileUnitParameter1
        sta wR0
        lda wActiveTileUnitParameter2
        sta wR1
        jsl rlGetMapTileIndexByCoords
        pha

        ; Max movement range (-1?)

        lda #$0070
        sta wR2

        stz wR4

        jsl rlFillMovementRangeArrayWithTerrainCosts

        lda #-1
        sta $7E4008
        sta $7E400A

        ; Don't do anything if original tile
        ; isn't pathable?

        plx
        lda aTargetableUnitMap,x
        and #$00FF
        bne +

          lda aTerrainMap,x
          and #$00FF
          tax

          lda aTerrainMovementCostBuffer-size(byte),x
          bmi _End

        +
        lda #<>rlActionStructStaffGetClosestPathableTileEffect
        sta lR25
        lda #>`rlActionStructStaffGetClosestPathableTileEffect
        sta lR25+size(byte)
        jsl rlRunRoutineForAllTilesInRange

        _End
        rtl

        .databank 0

      rlActionStructStaffGetClosestPathableTileEffect ; 83/F178

        .autsiz
        .databank `aPlayerVisibleUnitMap

        ; Given a tile index in X, check if
        ; tile is unoccupied and costs less to
        ; move to than current target tile.

        ; Inputs:
        ; X: tile index

        ; Outputs:
        ; $7E4008: new cost if less than current, otherwise unchanged
        ; $7E400A: new tile if cost less than current, otherwise unchanged

        lda aPlayerVisibleUnitMap,x
        bne +

        lda aTargetableUnitMap,x
        bne +

        lda aRangeMap,x
        cmp $7E4008
        bge +

        sta $7E4008
        stx $7E400A

        +
        rtl

        .databank 0

      rlActionStructStaffGetClosestStandableTile ; 83/F191

        .al
        .autsiz
        .databank `wActiveTileUnitParameter1

        ; Gets the nearest unoccupied standable tile.
        ; It doesn't seem like the class needs to be able
        ; to path from the original point to here, only
        ; that they can stand there.

        ; Inputs:
        ; wActiveTileUnitParameter1: X coordinate
        ; wActiveTileUnitParameter2: Y coordinate
        ; wR3: class

        ; Outputs:
        ; $7E4008: movement cost, -1 if no tile available
        ; $7E400A: tile index, -1 if no tile available

        lda wActiveTileUnitParameter1
        sta wR0
        lda wActiveTileUnitParameter2
        sta wR1
        jsl rlGetMapTileIndexByCoords

        lda wR3
        pha

        lda #$007F
        sta wR2
        stz wR4
        jsl rlActionStructStaffFillRangeArrayWith1CostTerrain

        pla
        sta wR3
        jsl rlCopyTerrainMovementCostBuffer

        lda #-1
        sta $7E4008
        sta $7E400A

        lda #<>rlActionStructStaffGetClosestStandableTileEffect
        sta lR25
        lda #>`rlActionStructStaffGetClosestStandableTileEffect
        sta lR25+size(byte)
        jsl rlRunRoutineForAllTilesInRange

        rtl

        .databank 0

      rlActionStructStaffGetClosestStandableTileEffect ; 83/F1CC

        .xl
        .autsiz
        .databank `aRangeMap

        ; Given a tile index in X, check if
        ; tile is unoccupied and costs less to
        ; move to than current target tile.

        ; Inputs:
        ; X: tile index

        ; Outputs:
        ; $7E4008: new cost if less than current, otherwise unchanged
        ; $7E400A: new tile if cost less than current, otherwise unchanged

        lda aPlayerVisibleUnitMap,x
        bne _End

        lda aTargetableUnitMap,x
        bne _End

        lda aRangeMap,x
        cmp $7E4008
        bge _End

          ; Only allow tiles pathable by that class.

          tdc
          lda aTerrainMap,x
          tay
          lda aTerrainMovementCostBuffer,y
          bmi _End

            lda aRangeMap,x
            sta $7E4008
            stx $7E400A

        _End
        rtl

        .databank 0

      rlActionStructStaffFillRangeArrayWith1CostTerrain ; 83/F1F2

        .xl
        .autsiz
        .databank `aTerrainMovementCostBuffer

        sep #$20

        ldx #size(structTerrainEntry)-size(byte)

        lda #$01

        -
        sta aTerrainMovementCostBuffer,x
        dec x
        bne -

        rep #$30

        php
        phb

        sep #$20

        lda #`aRangeMap
        pha

        rep #$20

        plb

        .databank `aRangeMap

        jmp rlFillMovementRangeArray

        .databank 0

    .endsection ActionStructStaffGetClosestTileSection

    .section ActionStructStaffRollHitSection

      rlActionStructStaffRollHit ; 83/F20F

        .al
        .autsiz
        .databank ?

        ; Given a short pointer to an action
        ; struct, return rlRollRandomNumber0To100(60 + (skill * 4))

        ; Inputs:
        ; wR1: short pointer to action struct

        ; Outputs:
        ; Carry set if hit, carry clear otherwise

        lda wR1
        sta wR0
        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCombineCharacterDataAndClassBases

        lda aBurstWindowCharacterBuffer.Skill,b
        and #$00FF
        asl a
        asl a
        clc
        adc #60
        jsl rlRollRandomNumber0To100
        rtl

        .databank 0

    .endsection ActionStructStaffRollHitSection

    .section ActionStructStaffRollDoublingSection

      rlActionStructStaffRollDoubling ; 83/F236

        .al
        .autsiz
        .databank `wActiveTileUnitParameter2

        ; Given two action structs and a running
        ; total of casts, return carry set if unit
        ; should cast again.

        ; Inputs:
        ; wActiveTileUnitParameter2: running total
        ; aActionStructUnit1: filled with caster
        ; aActionStructUnit2: filled with recipient
        ; wR1: short pointer to aActionStructUnit1
        ; wR2: short pointer to aActionStructUnit2

        ; Outputs:
        ; carry set if unit should double, carry clear otherwise

        lda wActiveTileUnitParameter2
        cmp #$0001
        beq +
        bge _False

          +
          ldx wR2

          sep #$20

          lda structActionStructEntry.CurrentHP,b,x
          cmp structActionStructEntry.MaxHP,b,x
          beq _False

            rep #$30

            lda #<>aActionStructUnit1
            sta wR0
            lda #<>aBurstWindowCharacterBuffer
            sta wR1
            jsl rlCopyExpandedCharacterDataBufferToBuffer
            jsl rlCombineCharacterDataAndClassBases

            ldx #<>aBurstWindowCharacterBuffer
            lda structActionStructEntry.Luck,b,x

            clc
            adc structActionStructEntry.Skill,x

            clc
            adc structActionStructEntry.Speed,x
            and #$00FF
            lsr a
            jsl rlRollRandomNumber0To100
            bcc _False

              sec
              rtl

        _False
        rep #$30
        clc
        rtl

        .databank 0

    .endsection ActionStructStaffRollDoublingSection

    .section ActionStructStaffTryGetClosestTileSection

      rlActionStructStaffTryGetClosestTile ; 83/F27C

        .al
        .autsiz
        .databank `wActiveTileUnitParameter1

        ; Given an action struct and some target coordinates
        ; return the closest standable tile, possibly the
        ; original coordinates if unoccupied.

        ; Inputs:
        ; wR1: short pointer to action struct
        ; wActiveTileUnitParameter1: X coordinate
        ; wActiveTileUnitParameter2: Y coordinate

        ; Outputs:
        ; wActiveTileUnitParameter1: X coordinate
        ; wActiveTileUnitParameter2: Y coordinate

        lda wR1
        pha

        lda wActiveTileUnitParameter1
        and #$00FF
        sta wR0
        lda wActiveTileUnitParameter2
        and #$00FF
        sta wR1
        jsl rlGetMapTileIndexByCoords

        tax

        pla
        sta wR1

        ; If target coordinates are not occupied, nothing to do.

        lda aTargetableUnitMap,x
        and #$00FF
        beq +

          ; Otherwise try to get the closest unoccupied standable tile to them.

          lda wR1
          sta wR0
          lda #<>aTemporaryActionStruct
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBuffer

          sep #$20

          lda wActiveTileUnitParameter1
          sta aTemporaryActionStruct.X,b
          lda wActiveTileUnitParameter2
          sta aTemporaryActionStruct.Y,b

          rep #$30

          lda #<>aTemporaryActionStruct
          sta wR0
          lda #<>aItemSkillCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBuffer

          jsl rlActionStructStaffGetClosestTile

        +
        rtl

        .databank 0

    .endsection ActionStructStaffTryGetClosestTileSection

    .section ActionStructStaffGetPowerSection

      rsActionStructStaffGetPower ; 83/F2CF

        .al
        .xl
        .autsiz
        .databank ?

        ; Given a unit and a base power in A,
        ; return total power (for healing, etc.)

        ; Inputs:
        ; aActionStructUnit1: filled with unit
        ; A: base power

        ; Outputs:
        ; A: total power

        pha

        lda #<>aActionStructUnit1
        sta wR0
        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCopyExpandedCharacterDataBufferToBuffer

        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlCombineCharacterDataAndClassBases

        lda #<>aBurstWindowCharacterBuffer
        sta wR1
        jsl rlGetEquippableItemInventoryOffset

        ldx #<>aBurstWindowCharacterBuffer
        jsl rlActionStructGetItemBonusesItemPreset

        pla

        clc
        adc aBurstWindowCharacterBuffer.Magic,b
        and #$00FF
        rts

        .databank 0

    .endsection ActionStructStaffGetPowerSection

    .section UnlockTargetEffectSection

      rlUnlockTargetEffect ; 83/F300

        .autsiz
        .databank `wActionStructRoundAttackBitfield

        sep #$20

        lda wActiveTileUnitParameter1
        sta aActionStructUnit2.X
        lda wActiveTileUnitParameter2
        sta aActionStructUnit2.Y

        rep #$30

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          inc $7EA4E8

          lda #<>rlUnlockCallback
          sta lUnknown7EA4EC
          lda #>`rlUnlockCallback
          sta lUnknown7EA4EC+size(byte)

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

      rlUnlockCallback ; 83/F34A

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

        sep #$20

        lda aActionStructUnit2.X
        sta wCursorXCoord,b
        lda aActionStructUnit2.Y
        sta wCursorYCoord,b

        rep #$30

        jsl rlRunChapterLocationEvents

        plb
        plp
        rtl

        .databank 0

    .endsection UnlockTargetEffectSection

    .section WatchTargetEffectSection

      rlWatchTargetEffect ; 83/F36B

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

    .endsection WatchTargetEffectSection

    .section KiaTargetEffectSection

      rlKiaTargetEffect ; 83/F396

        .al
        .autsiz
        .databank `wActionStructRoundAttackBitfield

        lda #RoundAttackFlagMiss
        sta wActionStructRoundAttackBitfield

        lda #<>aActionStructUnit1
        sta wR1
        jsl rlActionStructStaffRollHit
        bcc +

          stz wActionStructRoundAttackBitfield

          lda aActionStructUnit1.EquippedItemID2
          jsl rlTryGetBrokenItemID
          sta aActionStructUnit1.EquippedItemID2

          lda #<>rlKiaCallback
          sta lUnknown7EA4EC
          lda #>`rlKiaCallback
          sta lUnknown7EA4EC+size(byte)

        +
        jsr rsActionStructWriteRound
        jsr rsActionStructTerminateRoundArray

        ldx #<>aActionStructUnit1
        jsr rsActionStructStaffGetGainedWEXP
        rtl

        .databank 0

      rlKiaCallback ; 83/F3CD

        .autsiz
        .databank ?

        php
        phb

        sep #$20

        lda #`aActionStructUnit2
        pha

        rep #$20

        plb

        .databank `aActionStructUnit2

        sep #$20

        lda #None
        sta aActionStructUnit2.Status

        rep #$20

        lda aActionStructUnit2.UnitState
        and #~UnitStateGrayed
        sta aActionStructUnit2.UnitState

        lda #<>aActionStructUnit2
        sta wR1
        jsl rlUnknown848E5A

        lda #<>aActionStructUnit2
        sta wR1
        jsl rlCopyCharacterDataFromBuffer

        plb
        plp
        rtl

        .databank 0

    .endsection KiaTargetEffectSection

    .section ActionStructStaffGetGainedWEXPSection

      rsActionStructStaffGetGainedWEXP ; 83/F3FE

        .al
        .autsiz
        .databank ?

        _StaffWEXPTiers  := [(None,  0)]
        _StaffWEXPTiers ..= [(RankE, 1)]
        _StaffWEXPTiers ..= [(RankD, 2)]
        _StaffWEXPTiers ..= [(RankC, 3)]
        _StaffWEXPTiers ..= [(RankB, 4)]
        _StaffWEXPTiers ..= [(RankA, 5)]

        ; Given a short pointer to an action
        ; struct in X, get the WEXP gain for using
        ; their equipped staff.

        ; Inputs:
        ; X: short pointer to action struct

        ; Outputs:
        ; None

        php

        txy

        lda structActionStructEntry.EquippedItemID1,b,x
        and #$00FF
        ora #pack([None, 1])
        jsl rlCopyItemDataToBuffer

        lda aItemDataBuffer.WeaponRank,b
        bmi _PersonalStaff

        sta wR13
        lda #WeaponRankIncrement
        sta wR14
        jsl rlUnsignedDivide16By8

        lda wR13
        asl a
        tax

        lda _WEXPTable,x
        sta wR0
        bra +

        _WEXPTable ; 83/F429
          .for _WEXP in _StaffWEXPTiers[:,1]
            .word _WEXP
          .endfor

        _PersonalStaff

        lda #10
        sta wR0

        +
        sep #$20

        tdc

        lda structActionStructEntry.GainedWeaponEXP,b,y
        clc
        adc wR0
        cmp #RankA
        blt +

          lda #RankA

        +
        sta structActionStructEntry.GainedWeaponEXP,b,y

        plp
        rts

        .databank 0

    .endsection ActionStructStaffGetGainedWEXPSection

.endif ; GUARD_FE5_ACTIONSTRUCT_STAFF
