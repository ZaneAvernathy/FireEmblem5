
procChapterTitle .dstruct structProcInfo, "xx", None, None, aProcChapterTitleCode ; 9A/814C

rlSetupChapterTitleWindow ; 9A/8154

	.al
	.xl
	.autsiz
	.databank ?

	; Inputs:
	; wProcInput1: lower part of text pointer
	; wProcInput2: upper part of text pointer

	; Outputs:
	; None

	lda wProcInput1,b
	sta aProcBody1,b,x
	lda wProcInput2,b
	sta aProcBody2,b,x

	sep #$20

	lda #TM_Setting(True, True, True, False, True)
	sta bBuf_TM

	lda #TS_Setting(False, False, False, False, False)
	sta bBuf_TS

	lda #CGWSEL_Setting(False, False, CGWSEL_MathAlways, CGWSEL_BlackNever)
	sta bBuf_CGWSEL

	lda #CGADSUB_Setting(CGADSUB_Add, False, False, False, False, False, False, False)
	sta bBuf_CGADSUB

	rep #$20

	lda #$0001
	sta wUnknown001592,b

	; Copy palette

	lda #(`$A0E040)<<8
	sta lR18+1
	lda #<>$A0E040
	sta lR18

	lda #(`aBGPal1)<<8
	sta lR19+1
	lda #<>aBGPal1
	sta lR19

	lda #size(aBGPal1)
	sta wR20

	jsl rlBlockCopy
	rtl

aProcChapterTitleCode ; 9A/8198

	PROC_CALL $9A8154
	PROC_SET_ONCYCLE $9A823E
	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_HALT_WHILE_DECOMPRESSING

	PROC_CALL $9A82B7
	PROC_HALT_WHILE $94CCDF

	PROC_CALL $9A827D
	PROC_YIELD 1

	PROC_SET_ONCYCLE $9A82ED
	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_CALL_ARGS $8EEC3A, size(_Args1)
	_Args1 .block
		.word $0030
		.long $7E4BF8
		.word $0050
		.word $0040
		.byte $00
	.bend
	PROC_YIELD 10

	PROC_CALL rlUnknown9A8220
	PROC_CALL $8EB1AC

	_Label1
	PROC_YIELD 1
	PROC_JUMP_IF_ROUTINE_TRUE _Label1, $8EB1CE

	PROC_HALT_WHILE $8EEC55

	.word <>rsProcCodeUnknown82A088

	PROC_HALT_UNTIL_BUTTON_NEW_TIME 150, (JoypadA | JoypadStart | JoypadB)
	PROC_CALL $8EB1E2

	PROC_CALL_ARGS $8EEC3A, size(_Args2)
	_Args2 .block
		.word $0030
		.long $7E4CF8
		.word $0050
		.word $0040
		.byte $00
	.bend

	_Label2
	PROC_YIELD 1
	PROC_JUMP_IF_ROUTINE_TRUE _Label2, $8EB1F6

	PROC_HALT_WHILE $8EEC55

	PROC_CALL $9A8229

	PROC_END

rlUnknown9A8220 ; 9A/8220

	.autsiz
	.databank ?

	jsl rlEnableBG1Sync
	jsl rlEnableBG3Sync
	rtl



