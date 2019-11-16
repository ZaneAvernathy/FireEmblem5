
procPhaseGraphicSprites .dstruct structProcInfo, None, rlProcPhaseGraphicSpritesInit, rlProcPhaseGraphicSpritesOnCycle, None ; 81/B6A3

rlProcPhaseGraphicSpritesInit ; 81/B6AB

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda wCurrentPhase,b

	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	tax
	lda aPhaseGraphicSpritePointerTable,x
	plx
	sta aProcBody7,b,x
	stz aProcBody6,b,x
	rtl

rlProcPhaseGraphicSpritesOnCycle ; 81/B6C1

	.al
	.xl
	.autsiz
	.databank `rlProcPhaseGraphicSpritesOnCycle

	lda aProcBody6,b,x
	cmp #$0040
	beq +

	inc aProcBody6,b,x
	inc aProcBody6,b,x
	tay
	lda aPhaseGraphicDisplacementTable,y
	sta wR0
	lda #$0060
	sta wR1
	stz wR4
	stz wR5
	lda aProcBody7,b,x
	tay
	jsl rlPushToOAMBuffer

	lda #$0010
	sta wR0
	lda #<>aOAMPal7
	sta wR1
	lda #$B8FD
	sta wR2
	jsl $83CAB2

	lda #$0001
	sta wR0
	lda #$B8FD
	sta wR1
	jsl $83C90F
	rtl

	+
	phx
	lda #(`procPhaseGraphicColor)<<8
	sta lR43+1
	lda #<>procPhaseGraphicColor
	sta lR43
	jsl rlProcEngineCreateProc
	plx

	lda #<>+
	sta aProcHeaderOnCycle,b,x

	+
	stz wR0
	lda #$0060
	sta wR1
	stz wR4
	stz wR5
	lda aProcBody7,b,x
	tay
	jsl rlPushToOAMBuffer
	rtl

aPhaseGraphicSpritePointerTable ; 81/B732
	.addr aPlayerPhaseGraphicSprites
	.addr aEnemyPhaseGraphicSprites
	.addr aNPCPhaseGraphicSprites

aPlayerPhaseGraphicSprites .dstruct structSpriteArray, [[[64, 4], $42, True, $1C0, 3, 7, False, False], [[80, 4], $42, True, $1C2, 3, 7, False, False], [[96, 4], $42, True, $1C4, 3, 7, False, False], [[112, 4], $42, True, $1C6, 3, 7, False, False], [[128, 4], $42, True, $1C8, 3, 7, False, False], [[144, 4], $42, True, $1CA, 3, 7, False, False], [[160, 4], $42, True, $1CC, 3, 7, False, False], [[176, 4], $42, True, $1CE, 3, 7, False, False]]

aEnemyPhaseGraphicSprites .dstruct structSpriteArray, [[[65, 4], $42, True, $1E0, 3, 7, False, False], [[81, 4], $42, True, $1E2, 3, 7, False, False], [[97, 4], $42, True, $1E4, 3, 7, False, False], [[113, 4], $42, True, $1E6, 3, 7, False, False], [[133, 4], $42, True, $1C9, 3, 7, False, False], [[141, 4], $42, True, $1CA, 3, 7, False, False], [[157, 4], $42, True, $1CC, 3, 7, False, False], [[173, 4], $42, True, $1CE, 3, 7, False, False]]

aNPCPhaseGraphicSprites .dstruct structSpriteArray, [[[76, 4], $42, True, $1E9, 3, 7, False, False], [[92, 4], $42, True, $1EB, 3, 7, False, False], [[108, 4], $42, True, $1ED, 3, 7, False, False], [[119, 4], $42, True, $1C9, 3, 7, False, False], [[127, 4], $42, True, $1CA, 3, 7, False, False], [[143, 4], $42, True, $1CC, 3, 7, False, False], [[159, 4], $42, True, $1CE, 3, 7, False, False]]

aPhaseGraphicDisplacementTable ; 81/B7B1
	.sint -64
	.sint -55
	.sint -47
	.sint -40
	.sint -35
	.sint -30
	.sint -25
	.sint -22
	.sint -19
	.sint -16
	.sint -14
	.sint -12
	.sint -10
	.sint -9
	.sint -7
	.sint -6
	.sint -5
	.sint -4
	.sint -4
	.sint -3
	.sint -3
	.sint -2
	.sint -2
	.sint -1
	.sint -1
	.sint -1
	.sint -1
	.sint -1
	.sint 0
	.sint 0
	.sint 0
	.sint 0

procPhaseGraphicColor .dstruct structProcInfo, None, rlProcPhaseGraphicColorInit, rlProcPhaseGraphicColorOnCycle, None ; 81/B7F1

rlProcPhaseGraphicColorInit ; 81/B7F9

	.al
	.xl
	.autsiz
	.databank ?

	sep #$20
	lda #CGADSUB_Setting(CGADSUB_Add, False, True, False, False, False, False, True)
	sta bBuf_CGADSUB
	lda #CGWSEL_Setting(False, True, CGWSEL_MathAlways, CGWSEL_BlackNever)
	sta bBuf_CGWSEL
	lda #TM_Setting(True, True, False, False, True)
	sta bBuf_TM
	lda #Ts_Setting(False, True, False, False, True)
	sta bBuf_TS

	rep #$30
	stz aProcBody7,b,x

	lda wCurrentPhase,b
	lsr a
	lsr a
	lsr a
	and #(Player | Enemy | NPC) >> 3
	sta aProcBody6,b,x
	rtl

rlProcPhaseGraphicColorOnCycle ; 81/B81D

	.al
	.xl
	.autsiz
	.databank `rlProcPhaseGraphicColorOnCycle

	lda aProcBody7,b,x
	tay
	lda aUnknown81B878,y
	bmi +

	inc aProcBody7,b,x
	inc aProcBody7,b,x
	clc
	adc aProcBody6,b,x
	tax
	lda $9E8100,x
	sta aBGPal1+8,b
	lda $9E8100+2,x
	sta aBGPal1+10,b
	lda $9E8100+4,x
	sta aBGPal1+12,b
	rtl

	+
	lda #$0020
	sta aProcBody0,b,x
	lda #<>rlProcPhaseGraphicColorOnCycle2
	sta aProcHeaderOnCycle,b,x
	lda #(`procPhaseGraphicSprites)<<8
	sta lR43+1
	lda #<>procPhaseGraphicSprites
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	stz aProcHeaderTypeOffset,b,x

	+
	phx
	lda #(`procUnknown81BDA9)<<8
	sta lR43+1
	lda #<>procUnknown81BDA9
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	bra rlProcPhaseGraphicColorOnCycle2

aUnknown81B878 ; 81/B878
	.word $0020
	.word $0020
	.word $0040
	.word $0040
	.word $0060
	.word $0060
	.word $0060
	.word $0080
	.word $0080
	.word $0080
	.word $00A0
	.word $00A0
	.word $00A0
	.word $00A0
	.word $00C0
	.word $00C0
	.word $00C0
	.word $00C0
	.word $00C0
	.word $00C0
	.word $00C0
	.word $00C0
	.word $00C0
	.word $00C0
	.word $00C0
	.word $00C0
	.word $00C0
	.word $00C0
	.word $00A0
	.word $00A0
	.word $00A0
	.word $00A0
	.word $0080
	.word $0080
	.word $0080
	.word $0060
	.word $0060
	.word $0060
	.word $0040
	.word $0040
	.word $0020
	.word $0020
	.sint -1

rlProcPhaseGraphicColorOnCycle2 ; 81/B8CE

	.al
	.xl
	.autsiz
	.databank `rlProcPhaseGraphicColorOnCycle2

	dec aProcBody0,b,x
	beq +

	lda #$0010
	sta wR0
	lda #<>aBGPal1
	sta wR1
	lda #$B8FD
	sta wR2
	jsl $83CAB2

	lda #$0001
	sta wR0
	lda #$B8FD
	sta wR1
	jsl $83C9BC

	lda #$0001
	sta wR0
	lda #$B8FD
	sta wR1
	jsl $83C9BC
	rtl

	+
	jsl rlProcEngineFreeProc
	lda #$0003
	sta wUnknown000302,b
	lda #(`procUnknown81BE18)<<8
	sta lR43+1
	lda #<>procUnknown81BE18
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	stz aProcHeaderTypeOffset,b,x

	+
	lda #<>aBG1TilemapBuffer
	sta wR0
	lda #$02FF
	jsl rlFillTilemapByWord
	jsl rlEnableBG1Sync
	jsl $85910B
	jsl $8593AD
	sep #$20
	lda #TM_Setting(True, True, True, False, True)
	sta bBuf_TM
	rep #$20
	rtl
