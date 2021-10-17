
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_ACTIONSTRUCT :?= false
.if (!GUARD_FE5_ACTIONSTRUCT)
  GUARD_FE5_ACTIONSTRUCT := true

  .include "../../VoltEdge/VoltEdge.h"

  ; Definitions

    .weak

      rsActionStructGetBaseStats                   :?= address($83CFED)
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






.endif ; GUARD_FE5_ACTIONSTRUCT
