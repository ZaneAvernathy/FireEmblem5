
procUnknown81BE18 .dstruct structProcInfo, None, rlProcUnknown81BE18Init, rlProcUnknown81BE18OnCycle, None ; 81/BE18

rlProcUnknown81BE18Init ; 81/BE20

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlProcUnknown81BE18OnCycle ; 81/BE21

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown000E6D,b
	bne +

	phx
	lda #(`procPhaseGraphicSprites)<<8
	sta lR43+1
	lda #<>procPhaseGraphicSprites
	sta lR43
	jsl rlProcEngineFindProc
	plx
	bcc +

	lda wJoy1New
	bit #JoypadR | JoypadL | JoypadX | JoypadA | JoypadStart | JoypadY | JoypadB
	bne ++

	+
	rtl

	+
	phx
	jsl rlProcEngineFreeProc
	lda #(`$87C4EF)<<8
	sta lR43+1
	lda #<>$87C4EF
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	stz aProcHeaderTypeOffset,b,x

	+
	lda #(`procUnknown81BDA3)<<8
	sta lR43+1
	lda #<>procUnknown81BDA3
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	stz aProcHeaderTypeOffset,b,x

	+
	lda #(`procUnknown81BDA9)<<8
	sta lR43+1
	lda #<>procUnknown81BDA9
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	stz aProcHeaderTypeOffset,b,x

	+
	lda #(`procPhaseGraphicSprites)<<8
	sta lR43+1
	lda #<>procPhaseGraphicSprites
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	stz aProcHeaderTypeOffset,b,x

	+
	lda #(`procPhaseGraphicColor)<<8
	sta lR43+1
	lda #<>procPhaseGraphicColor
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	stz aProcHeaderTypeOffset,b,x

	+
	lda #(`aFadingPaletteSpace)<<8
	sta lR18+1
	lda #<>aFadingPaletteSpace
	sta lR18
	lda #(`aBGPal3)<<8
	sta lR19+1
	lda #<>aBGPal3
	sta lR19
	lda #5 * $10 * 2
	sta wR20
	jsl rlBlockCopy

	lda #(`aFadingPaletteSpace+(5 * $10 * 2))<<8
	sta lR18+1
	lda #<>aFadingPaletteSpace+(5 * $10 * 2)
	sta lR18
	lda #(`aOAMPal0)<<8
	sta lR19+1
	lda #<>aOAMPal0
	sta lR19
	lda #4 * $10 * 2
	sta wR20
	jsl rlBlockCopy

	plx
	lda #$0003
	sta wUnknown000302,b
	sep #$20
	lda #TM_Setting(True, True, True, False, True)
	sta bBuf_TM
	stz bBuf_TS
	rep #$30
	lda #<>aBG1TilemapBuffer
	sta wR0
	lda #$02FF
	jsl rlFillTilemapByWord
	jsl rlEnableBG1Sync
	rtl
