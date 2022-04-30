
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_DIALOGUE :?= false
.if (!GUARD_FE5_DIALOGUE)
  GUARD_FE5_DIALOGUE := true

  ; Definitions

    .weak

      .include "../TEXT/DIALOGUE/Dialogue.h"

      ; Control codes

      DIALOGUE_EOF .segment
        .byte $01
      .endsegment

      DIALOGUE_NL .segment
        .byte $02
      .endsegment

      DIALOGUE_CLEAR .segment
        .byte $03
      .endsegment

      DIALOGUE_SCROLL .segment
        .byte $04
      .endsegment

      DIALOGUE_END_SCENE .segment
        .byte $05
      .endsegment

      DIALOGUE_LEFT .segment
        .byte $06
      .endsegment

      DIALOGUE_RIGHT .segment
        .byte $07
      .endsegment

      DIALOGUE_WAIT_PRESS .segment
        .byte $08
      .endsegment

      DIALOGUE_PAGE0 .segment
        .byte $09
        .enc "DialoguePage0"
      .endsegment

      DIALOGUE_PAGE1 .segment
        .byte $0A
        .enc "DialoguePage1"
      .endsegment

      DIALOGUE_PAGE2 .segment
        .byte $0B
        .enc "DialoguePage2"
      .endsegment

      DIALOGUE_PAGE3 .segment
        .byte $0C
        .enc "DialoguePage3"
      .endsegment

      DIALOGUE_PAGE4 .segment
        .byte $0D
        .enc "DialoguePage4"
      .endsegment

      DIALOGUE_PAGE5 .segment
        .byte $0E
        .enc "DialoguePage5"
      .endsegment

      DIALOGUE_PAUSE .segment Time
        .byte $0F
        .byte \Time
      .endsegment

      DIALOGUE_NUMBER .segment
        .byte $00, $24
      .endsegment

      DIALOGUE_CLEAR_ALL .segment
        .byte $00, $2A
      .endsegment

      DIALOGUE_ASMC_0 .segment Pointer
        .byte $00, $2E
        .long \Pointer
      .endsegment

      DIALOGUE_ASMC_1 .segment Pointer, Arg1
        .byte $00, $2F
        .long \Pointer
        .word \Arg1
      .endsegment

      DIALOGUE_ASMC_2 .segment Pointer, Arg1, Arg2
        .byte $00, $30
        .long \Pointer
        .word \Arg1
        .word \Arg2
      .endsegment

      DIALOGUE_LOAD_RAM .segment
        .byte $00, $32
      .endsegment

      DIALOGUE_OPEN .segment
        .byte $00, $38
      .endsegment

      DIALOGUE_CLOSE .segment
        .byte $00, $39
      .endsegment

      DIALOGUE_LOAD .segment Portrait
        .byte $00, $3A
        .word \Portrait
      .endsegment

      DIALOGUE_UNLOAD .segment
        .byte $00, $3B
      .endsegment

      DIALOGUE_UNK .segment Byte
        .byte $00, \Byte
      .endsegment

    .endweak

.endif ; GUARD_FE5_DIALOGUE
