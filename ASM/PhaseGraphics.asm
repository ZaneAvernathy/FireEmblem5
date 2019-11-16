
rlGetPhaseChangeGraphics ; 81/B563

	.al
	.xl
	.autsiz
	.databank `wBGUpdateFlags

	lda wBGUpdateFlags
	beq +

	rtl

	+
	lda #$0017
	jsl rlUnknown808C87

	stz wUnknown000302,b
	jsl $8593EB
	sep #$20
	lda #TM_Setting(False, False, False, False, True)
	sta bBuf_TM
	lda #TS_Setting(False, True, True, False, False)
	sta bBuf_TS
	lda #CGADSUB_Setting(CGADSUB_Add, False, False, False, False, False, True, True)
	sta bBuf_CGADSUB
	lda #CGWSEL_Setting(False, True, CGWSEL_MathAlways, CGWSEL_BlackNever)
	sta bBuf_CGWSEL
	rep #$30
	lda #<>$F2E780
	sta lR18
	lda #>`$F2E780
	sta lR18+1
	lda #$0800
	sta wR0
	lda #$2000
	sta wr1
	lda wCurrentPhase,b
	jsl $83B296
	txa
	asl a
	tax
	lda aPhaseGraphicOffsetTable,x
	clc
	adc lR18
	sta lR18
	jsl rlDMAByPointer
	lda #<>$F4E000
	sta lR18
	lda #>`$F4E000
	sta lR18+1
	lda #$0800
	sta wR0
	lda #$1C00
	sta wR1
	jsl rlDMAByPointer
	jsl $87B171
	rtl

aPhaseGraphicOffsetTable ; 81/B5D3
	.word $0000
	.word $0800
	.word $1000

rlUnknown81B5D9 ; 81/B5D9

	.al
	.xl
	.autsiz
	.databank ?

	lda #(`$9E81E0)<<8
	sta lR18+1
	lda #<>$9E81E0
	sta lR18
	lda #(`aOAMPal7)<<8
	sta lR19+1
	lda #<>aOAMPal7
	sta lR19
	lda #size(aOAMPal7)
	sta wR20
	jsl rlBlockCopy

	lda #(`$9E81E0)<<8
	sta lR18+1
	lda #<>$9E81E0
	sta lR18
	lda #(`aBGPal1)<<8
	sta lR19+1
	lda #<>aBGPal1
	sta lR19
	lda #size(aBGPal1)
	sta wR20
	jsl rlBlockCopy

	lda #$0010
	sta wR0
	lda #<>aOAMPal7
	sta wR1
	lda #$B8FD
	sta wR2
	stz wR3
	jsl $83CA69

	lda wCurrentPhase,b
	jsl $83B296

	txa
	sta wR0
	asl a
	clc
	adc wR0
	tax
	lda aUnknown81B695,x
	sta lR18
	lda aUnknown81B695+1,x
	sta lR18+1
	lda #$0012
	sta wR0
	lda #$0003
	sta wR1
	lda #$CA8A
	sta wR19
	lda #$2400
	sta wUnknown000DE7,b
	jsl $84A3FF
	jsl rlEnableBG1Sync
	jsl $87B171

	phx
	lda #(`procUnknown81BDA3)<<8
	sta lR43+1
	lda #<>procUnknown81BDA3
	sta lR43
	jsl rlProcEngineCreateProc
	plx

	phx
	lda #(`procUnknown81BE18)<<8
	sta lR43+1
	lda #<>procUnknown81BE18
	sta lR43
	jsl rlProcEngineCreateProc
	plx

	phx
	lda #(`procPhaseGraphicSprites)<<8
	sta lR43+1
	lda #<>procPhaseGraphicSprites
	sta lR43
	jsl rlProcEngineCreateProc
	plx

	rtl

aUnknown81B695 ; 81/B695
	.long $9E82C0
	.long $9E8380
	.long $9E8440

rlUnknown81B69E ; 81/B69E

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlProcEngineFreeProc
	rtl
