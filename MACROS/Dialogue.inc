
DIALOGUE_EOF .segment
	.byte $01
.endm

DIALOGUE_NL .segment
	.byte $02
.endm

DIALOGUE_CLEAR .segment
	.byte $03
.endm

DIALOGUE_SCROLL .segment
	.byte $04
.endm

DIALOGUE_END_SCENE .segment
	.byte $05
.endm

DIALOGUE_LEFT .segment
	.byte $06
.endm

DIALOGUE_RIGHT .segment
	.byte $07
.endm

DIALOGUE_WAIT_PRESS .segment
	.byte $08
.endm

DIALOGUE_FONT_0 .segment
	.byte $09
	.enc "DialoguePage0"
.endm

DIALOGUE_FONT_1 .segment
	.byte $0A
	.enc "DialoguePage1"
.endm

DIALOGUE_FONT_2 .segment
	.byte $0B
	.enc "DialoguePage2"
.endm

DIALOGUE_FONT_3 .segment
	.byte $0C
	.enc "DialoguePage3"
.endm

DIALOGUE_FONT_4 .segment
	.byte $0D
	.enc "DialoguePage4"
.endm

DIALOGUE_FONT_5 .segment
	.byte $0E
	.enc "DialoguePage5"
.endm

DIALOGUE_PAUSE .segment Time
	.byte $0F
	.byte \Time
.endm

DIALOGUE_NUMBER .segment
	.byte $00, $24
.endm

DIALOGUE_CLEAR_ALL .segment
	.byte $00, $2A
.endm

DIALOGUE_ASMC_0 .segment Pointer
	.byte $00, $2E
	.long \Pointer
.endm

DIALOGUE_ASMC_1 .segment Pointer, Arg1
	.byte $00, $2F
	.long \Pointer
	.word \Arg1
.endm

DIALOGUE_ASMC_2 .segment Pointer, Arg1, Arg2
	.byte $00, $30
	.long \Pointer
	.word \Arg1
	.word \Arg2
.endm

DIALOGUE_LOAD_RAM .segment
	.byte $00, $32
.endm

DIALOGUE_OPEN .segment
	.byte $00, $38
.endm

DIALOGUE_CLOSE .segment
	.byte $00, $39
.endm

DIALOGUE_LOAD .segment Portrait
	.byte $00, $3A
	.word \Portrait
.endm

DIALOGUE_UNLOAD .segment
	.byte $00, $3B
.endm

DIALOGUE_UNK .segment Byte
	.byte $00, \Byte
.endm
