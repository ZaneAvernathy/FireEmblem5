
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

	.dstruct structProcCodeCall, $9A8154
	.dstruct structProcCodeSetOnCycle, $9A823E
	.dstruct structProcCodeYield, 1

	.dstruct structProcCodeSetOnCycle, None

	.dstruct structProcCodeHaltWhileDecompressing

	.dstruct structProcCodeCall, $9A82B7
	.dstruct structProcCodeHaltWhile, $94CCDF

	.dstruct structProcCodeCall, $9A827D
	.dstruct structProcCodeYield, 1

	.dstruct structProcCodeSetOnCycle, $9A82ED
	.dstruct structProcCodeYield, 1

	.dstruct structProcCodeSetOnCycle, None

	.dstruct structProcCodeCallArgs, $8EEC3A, size(_Args1)
	_Args1 .block
		.word $0030
		.long $7E4BF8
		.word $0050
		.word $0040
		.byte $00
	.bend
	.dstruct structProcCodeYield, 10

	.dstruct structProcCodeCall, rlUnknown9A8220
	.dstruct structProcCodeCall, $8EB1AC

	_Label1
	.dstruct structProcCodeYield, 1
	.dstruct structProcCodeJumpIfRoutineTrue, _Label1, $8EB1CE

	.dstruct structProcCodeHaltWhile, $8EEC55

	.word <>rsProcCodeUnknown82A088

	.dstruct structProcCodeHaltUntilButtonNewAndTime, 150, (JoypadA | JoypadStart | JoypadB)
	.dstruct structProcCodeCall, $8EB1E2

	.dstruct structProcCodeCallArgs, $8EEC3A, size(_Args2)
	_Args2 .block
		.word $0030
		.long $7E4CF8
		.word $0050
		.word $0040
		.byte $00
	.bend

	_Label2
	.dstruct structProcCodeYield, 1
	.dstruct structProcCodeJumpIfRoutineTrue, _Label2, $8EB1F6

	.dstruct structProcCodeHaltWhile, $8EEC55

	.dstruct structProcCodeCall, $9A8229

	.dstruct structProcCodeEnd

rlUnknown9A8220 ; 9A/8220

	.autsiz
	.databank ?

	jsl rlEnableBG1Sync
	jsl rlEnableBG3Sync
	rtl



