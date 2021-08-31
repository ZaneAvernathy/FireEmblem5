
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_CODE83TEMP :?= false
.if (!GUARD_FE5_CODE83TEMP)
  GUARD_FE5_CODE83TEMP := true

  .include "../../VoltEdge/VoltEdge.h"

  ; Definitions

    .weak

      rlCopyCharacterDataFromBuffer              :?= address($839041)
      rlRunRoutineForAllUnitsInAllegiance        :?= address($839825)
      rlSetChapterVisionRange                    :?= address($849485)
      rlSetChapterAllegiancesAndPhaseControllers :?= address($8494B3)
      rlCopyDefaultOptions                       :?= address($8594CE)
      rlSetCurrentMenuColor                      :?= address($859532)
      rlClearConvoy                              :?= address($85C769)
      rlSetDefaultSpeedOptions                   :?= address($8AC46F)
      rlClearPermanentEventFlags                 :?= address($8C9C23)
      rlClearTemporaryEventFlags                 :?= address($8C9C3A)

    .endweak

  ; Freespace inclusions

    .section ResetCapturedPlayerUnitsSection

      rlResetCapturedPlayerUnits ; 83/FB4D

        .al
        .autsiz
        .databank ?

        lda #<>rlResetCapturedPlayerUnitsEffect
        sta lR25
        lda #>`rlResetCapturedPlayerUnitsEffect
        sta lR25+size(byte)

        lda #Player + 1
        jsl rlRunRoutineForAllUnitsInAllegiance

        rtl

        .databank 0

      rlResetCapturedPlayerUnitsEffect ; 83/FB5F

        .al
        .autsiz
        .databank ?

        lda aTargetingCharacterBuffer.UnitState,b
        ora #UnitStateHidden
        sta aTargetingCharacterBuffer.UnitState,b

        lda aTargetingCharacterBuffer.UnitState,b
        bit #(UnitStateDead | UnitStateDisabled | UnitStateCaptured)
        bne _End

        and #~(UnitStateRescued | UnitStateRescuing)
        and #~(UnitStateMoved | UnitStateUnknown3)
        sta aTargetingCharacterBuffer.UnitState,b

        lda #pack([1, 1])
        sta aTargetingCharacterBuffer.Coordinates,b

        sep #$20

        lda #Leif
        sta aTargetingCharacterBuffer.Leader,b

        lda aTargetingCharacterBuffer.MaxHP,b
        sta aTargetingCharacterBuffer.CurrentHP,b

        stz aTargetingCharacterBuffer.Rescue,b
        stz aTargetingCharacterBuffer.VisionBonus,b
        stz aTargetingCharacterBuffer.MagicBonus,b

        lda aTargetingCharacterBuffer.Status,b
        cmp #StatusPetrify
        beq +

        stz aTargetingCharacterBuffer.Status,b

        rep #$30

        lda aTargetingCharacterBuffer.UnitState,b
        and #~UnitStateGrayed
        sta aTargetingCharacterBuffer.UnitState,b

        +
        rep #$30

        _End
        lda #<>aTargetingCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer
        rtl

        .databank 0

    .endsection ResetCapturedPlayerUnitsSection

    .section FreeNonplayerDeploymentSlotsSection

      rlFreeNonplayerDeploymentSlots ; 83/FBB6

        .al
        .autsiz
        .databank ?

        ; Frees all Enemy and NPC deployment
        ; slots by clearing the slots' character.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        lda #<>rlFreeNonplayerDeploymentSlotsEffect
        sta lR25
        lda #>`rlFreeNonplayerDeploymentSlotsEffect
        sta lR25+size(byte)

        lda #Enemy + 1
        jsl rlRunRoutineForAllUnitsInAllegiance

        lda #NPC + 1
        jsl rlRunRoutineForAllUnitsInAllegiance

        rtl

        .databank 0

      rlFreeNonplayerDeploymentSlotsEffect ; 83/FBCF

        .autsiz
        .databank ?

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        stz aTargetingCharacterBuffer.Character,b

        lda #<>aTargetingCharacterBuffer
        sta wR1
        jsl rlCopyCharacterDataFromBuffer
        rtl

        .databank 0

    .endsection FreeNonplayerDeploymentSlotsSection

    .section SetNewGameOptionsSection

      rlSetNewGameOptions ; 83/FBDC

        .autsiz
        .databank ?

        php
        phb

        sep #$20

        lda #`aOptions
        pha

        rep #$20

        plb

        .databank `aOptions

        stz aOptions.wWindow

        jsl rlCopyDefaultOptions
        jsl rlSetCurrentMenuColor

        stz wIngameTime,b
        stz wMenuCounter,b
        stz wWinCounter,b
        stz wCaptureCounter,b

        lda #NPC
        sta wCurrentPhase,b

        stz wCurrentChapter,b
        stz wCurrentTurn,b
        stz wParagonModeEnable,b

        jsl rlSetChapterAllegiancesAndPhaseControllers
        jsl rlSetChapterVisionRange
        jsl rlClearPermanentEventFlags
        jsl rlClearTemporaryEventFlags
        jsl rlClearConvoy
        jsl rlClearUnitArrays
        jsl rlClearLossesWinsTurncounts
        jsl rlSetDefaultSpeedOptions

        plb
        plp
        rtl

        .databank 0

    .endsection SetNewGameOptionsSection

    .section UnknownResetPlayerUnitVisibilitySection

      rsUnknownResetPlayerUnitVisibility ; 83/FC2F

        .al
        .autsiz
        .databank ?

        lda #<>aUnknownResetPlayerUnitVisibilityCoordinates
        sta lR18
        lda #>`aUnknownResetPlayerUnitVisibilityCoordinates
        sta lR18+size(byte)

        lda #<>rlUnknownResetPlayerUnitVisibilityEffect
        sta lR25
        lda #>`rlUnknownResetPlayerUnitVisibilityEffect
        sta lR25+size(byte)

        lda #Player + 1
        jsl rlRunRoutineForAllUnitsInAllegiance

        rts

        .databank 0

      rlUnknownResetPlayerUnitVisibilityEffect ; 83/FC4B

        .autsiz
        .databank ?

        sep #$20

        lda [lR18]
        inc lR18
        sta aTargetingCharacterBuffer.X,b

        lda [lR18]
        inc lR18
        sta aTargetingCharacterBuffer.Y,b

        rep #$20

        lda aTargetingCharacterBuffer.UnitState,b
        and #~UnitStateHidden
        sta aTargetingCharacterBuffer.UnitState,b

        lda #<>aTargetingCharacterBuffer
        sta wR1

        jsl rlCopyCharacterDataFromBuffer

        rtl

        .databank 0

      aUnknownResetPlayerUnitVisibilityCoordinates ; 83/FC70
        .word pack([25, 6])
        .word pack([26, 6])
        .word pack([27, 6])
        .word pack([24, 6])
        .word pack([23, 6])
        .word pack([25, 5])
        .word pack([26, 5])
        .word pack([27, 5])
        .word pack([24, 5])
        .word pack([23, 5])
        .word pack([25, 7])
        .word pack([26, 7])
        .word pack([27, 7])
        .word pack([24, 7])
        .word pack([23, 7])

    .endsection UnknownResetPlayerUnitVisibilitySection

    .section SetChapterTurncountSection

      rlSetChapterTurncount ; 83/FC8F

        .xl
        .autsiz
        .databank ?

        ; Adds an entry to aTurncountsTable
        ; for the current chapter.

        ; Warning: no bounds checking.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        php
        phb

        sep #$20

        lda #`aTurncountsTable
        pha

        rep #$20

        plb

        .databank `aTurncountsTable

        ldx #0

        ; Look for the next free entry.

        _Loop

          ; Grab an entry, check if clear.

          lda aTurncountsTable+structTurncountEntryRAM.Chapter,x
          ora aTurncountsTable+structTurncountEntryRAM.Turncount,x
          beq _Found

            inc x
            inc x
            inc x

            bra _Loop

        _Found

          lda wCurrentChapter,b
          sta aTurncountsTable+structTurncountEntryRAM.Chapter,x

          lda wCurrentTurn,b
          sta aTurncountsTable+structTurncountEntryRAM.Turncount,x

          plb
          plp
          rtl

        .databank 0

    .endsection SetChapterTurncountSection

    .section ClearUnitArraysSection

      rlClearUnitArrays ; 83/FCB7

        .xl
        .autsiz
        .databank `aPlayerUnits

        ; Clears every deployment slot.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        php

        sep #$20

        ldx #size(aPlayerUnits)+size(aEnemyUnits)+size(aNPCUnits)-size(word)

        _Loop
          stz aPlayerUnits,x
          dec x
          bpl _Loop

        plp
        rtl

        .databank 0

    .endsection ClearUnitArraysSection

    .section ClearLossesWinsTurncountsSection

      rlClearLossesWinsTurncounts ; 83/FCC5

        .xl
        .autsiz
        .databank `aLossesTable

        ; Clears the losses, wins, and turncounts
        ; tables.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        php

        sep #$20

        ldx #size(aLossesTable)+size(aWinsTable)+size(aTurncountsTable)-size(byte)

        _Loop
          stz aLossesTable,x
          dec x
          bpl _Loop

        plp
        rtl

        .databank 0

    .endsection ClearLossesWinsTurncountsSection

.endif ; GUARD_FE5_CODE83TEMP
