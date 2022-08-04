
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_PICK_PHASE_MUSIC :?= false
.if (!GUARD_FE5_PICK_PHASE_MUSIC)
  GUARD_FE5_PICK_PHASE_MUSIC := true

  ; TODO: put this into something larger.

  ; Definitions

    .weak

      rlGetAllegianceInfoOffset :?= address($83B296)
      rlGetChapterDataField     :?= address($848933)
      rlCountLivingPhaseTargets :?= address($8599B7)

    .endweak

  ; Freespace inclusions

    .section PickPhaseMusicSection

      startCode

        rlPickPhaseMusic ; 83/A5B2

          .autsiz
          .databank ?

          ; Picks the phase's music.

          ; Inputs:
          ; None

          ; Outputs:
          ; A: Returns:
          ;   if it's still turn 0: 0
          ;   if Player phase:
          ;     if there are 6 or fewer foes alive: VictoryMusicID
          ;     else if FlagAlliedDeath is set: SadMusicID
          ;     else: the chapter's phase music for Player phase
          ;   else: the chapter's phase music for the phase

          ; TODO: music definitions

          VictoryMusicID := $0005
          SadMusicID     := $0006

          php
          phb

          sep #$20

          lda #`aTemporaryEventFlags
          pha

          rep #$20

          plb

          .databank `aTemporaryEventFlags

          lda wCurrentTurn,b
          beq _End

          lda wCurrentPhase,b
          bne _GetPhaseMusic

          lda aTemporaryEventFlags + ((FlagAlliedDeath - 1) / 8)
          bit #%1 << ((FlagAlliedDeath - 1) & 7)
          beq +

          lda #SadMusicID
          bra _End

          +
          jsl rlCountLivingPhaseTargets
          cmp #6
          beq +

          bge _GetPhaseMusic

          +
          lda #VictoryMusicID
          bra _End

          _GetPhaseMusic

          lda #structChapterDataTableEntry.PlayerPhaseMusic
          sta lR18

          lda wCurrentChapter,b
          jsl rlGetChapterDataField

          lda wCurrentPhase,b
          jsl rlGetAllegianceInfoOffset

          lda lR18,x
          and #$00FF

          _End
          plb
          plp
          rtl

          .databank 0

      endCode

    .endsection

.endif ; GUARD_FE5_PICK_PHASE_MUSIC
