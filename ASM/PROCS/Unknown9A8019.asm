
procUnknown9A8019 .dstruct structProcInfo, "xx", rlProcUnknown9A8019Init, None, aProcUnknown9A8019Code ; 9A/8019

rlProcUnknown9A8019Init ; 9A/8021

	.al
	.xl
	.autsiz
	.databank ?

	lda wProcInput1,b
	sta lR18
	lda wProcInput2,b
	sta lR18+1
	jsl $8ABB6B

	ora #$0900
	sta wR0

	lda #(`procUnknown9A804A)<<8
	sta lR43+1
	lda #<>procUnknown9A804A
	sta lR43
	jsl rlProcEngineCreateProc

	rtl

aProcUnknown9A8019Code ; 9A/8043

	PROC_HALT_WHILE procUnknown9A804A
	PROC_END

procUnknown9A804A .dstruct structProcInfo, "xx", None, None, aProcUnknown9A804ACode ; 9A/804A

aProcUnknown9A804ACode ; 9A/8052

	PROC_CALL rlUnknown9A8074
	PROC_CALL rlUnknown9A8098
	PROC_CALL rlUnknown9A80D7
	PROC_HALT_WHILE $94CCDF
	PROC_CALL rlUnknown9A808B
	PROC_YIELD 120
	PROC_CALL rlUnknown9A80FE
	PROC_END

rlUnknown9A8074 ; 9A/8074

	.al
	.xl
	.autsiz
	.databank ?

	lda lR18
	sta aProcBody1,b,x
	lda lR18+1
	sta aProcBody2,b,x

	lda wR0
	sta aProcBody3,b,x

	jsl $8ABB9D

	sta aProcBody4,b,x

	rtl

rlUnknown9A808B ; 9A/808B

	.al
	.xl
	.autsiz
	.databank ?

	sep #$20

	lda #TM_Setting(True, True, True, False, True)
	sta bBuf_TM

	rep #$20

	jsl rlEnableBG3Sync
	rtl

rlUnknown9A8098 ; 9A/8098

	.al
	.xl
	.autsiz
	.databank `wBGUpdateFlags

	jsl $858033

	lda aProcBody3,b,x
	and #$00FF
	dec a
	sta wR0

	lda aProcBody3,b,x
	xba
	and #$00FF
	dec a
	sta wR1

	lda aProcBody4,b,x
	inc a
	inc a
	sta wR2

	lda #$0004
	sta wR3

	jsl $8593AD
	jsl $85805C
	jsl $85827A
	jsl $858310

	stz wBGUpdateFlags

	sep #$20

	lda #TM_Setting(False, True, False, False, True)
	sta bBuf_TM

	rep #$20

	rtl

rlUnknown9A80D7 ; 9A/80D7

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0800
	sta wR0

	lda #$0002
	sta wR1

	lda #$0002
	sta wR2

	lda #$0000
	sta wR3

	lda aProcBody1,b,x
	sta lR18
	lda aProcBody2,b,x
	sta lR18+1

	lda aProcBody3,b,x
	tax
	jsl rlUnknownDialogueText

	rtl

rlUnknown9A80FE ; 9A/80FE

	.al
	.xl
	.autsiz
	.databank ?

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

	lda #<>aBG1TilemapBuffer
	sta wR0
	lda #$02FF
	jsl rlFillTilemapByWord

	lda #<>aBG3TilemapBuffer
	sta wR0
	lda #$01DF
	jsl rlFillTilemapByWord

	jsl rlEnableBG1Sync
	jsl rlEnableBG3Sync

	rtl
