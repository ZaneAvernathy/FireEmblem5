
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_CODE83TEMP :?= false
.if (!GUARD_FE5_CODE83TEMP)
  GUARD_FE5_CODE83TEMP := true

  .include "../../VoltEdge/VoltEdge.h"

  ; Definitions

    .weak

      rlCopyCharacterDataFromBuffer       :?= address($839041)
      rlRunRoutineForAllUnitsInAllegiance :?= address($839825)

    .endweak

  ; Freespace inclusions

    .section

      rs

        .al
        .autsiz
        .databank ?

        lda #<>aUnknown83FC70
        sta lR18
        lda #>`aUnknown83FC70
        sta lR18+1

        lda #<>rlUnknown83FC4B
        sta lR25
        lda #>`rlUnknown83FC4B
        sta lR25+1

        lda #Player + 1
        jsl rlRunRoutineForAllUnitsInAllegiance

        rts

        .databank 0

      rlUnknown83FC4B ; 83/FC4B

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
        and #~UnitStateRescuing
        sta aTargetingCharacterBuffer.UnitState,b

        lda #<>aTargetingCharacterBuffer
        sta wR1

        jsl rlCopyCharacterDataFromBuffer

        rtl

        .databank 0

      aUnknown83FC70 ; 83/FC70
        .word pack([6, 25])
        .word pack([6, 26])
        .word pack([6, 27])
        .word pack([6, 24])
        .word pack([6, 23])
        .word pack([5, 25])
        .word pack([5, 26])
        .word pack([5, 27])
        .word pack([5, 24])
        .word pack([5, 23])
        .word pack([7, 25])
        .word pack([7, 26])
        .word pack([7, 27])
        .word pack([7, 24])
        .word pack([7, 23])

    .endsection

    .section SetChapterTurncountSection

      rlSetChapterTurncount ; 83/FC8F

        .xl
        .autsiz
        .databank ?

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
        .databank ?

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
