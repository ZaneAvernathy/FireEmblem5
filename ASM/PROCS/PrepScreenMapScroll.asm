
procPrepScreenMapScroll .dstruct structProcInfo, None, rlProcPrepScreenMapScrollInit, rlProcPrepScreenMapScrollOnCycle, None ; 81/C213

rlProcPrepScreenMapScrollInit ; 81/C21B

	.al
	.xl
	.autsiz
	.databank ?

	lda #$FFFF
	sta $7FAA14

	stz wMapScrollWidthPixels,b
	stz wMapScrollHeightPixels,b

	phx
	jsl rlUpdateUnitMapsAndFog
	plx
	lda #30
	sta aProcBody0,b,x
	lda #$0000
	sta aProcBody1,b,x
	lda @l wDefaultVisibilityFill
	bne +

	lda #<>rlProcPrepScreenMapScrollOnCycle5._End
	sta aProcHeaderOnCycle,b,x

	+
	rtl

rlProcPrepScreenMapScrollOnCycle ; 81/C247

	.al
	.xl
	.autsiz
	.databank ?

	dec aProcBody0,b,x
	bne +

	lda #<>rlProcPrepScreenMapScrollOnCycle2
	sta aProcHeaderOnCycle,b,x

	+
	rtl

rlProcPrepScreenMapScrollOnCycle2 ; 81/C253

	.al
	.xl
	.autsiz
	.databank ?

	; Scroll right

	lda wMapScrollWidthPixels,b
	cmp wMapWidthPixels,b
	beq +

	inc a
	inc a
	sta wMapScrollWidthPixels,b
	jsr rsPrepScreenMapScrollCheckJoypad
	rtl

	+
	lda #<>rlProcPrepScreenMapScrollOnCycle3
	sta aProcHeaderOnCycle,b,x
	rtl

rlProcPrepScreenMapScrollOnCycle3 ; 81/C26B

	.al
	.xl
	.autsiz
	.databank ?

	; Scroll down

	lda wMapScrollHeightPixels,b
	cmp wMapHeightPixels,b
	beq +

	inc a
	inc a
	sta wMapScrollHeightPixels,b
	jsr rsPrepScreenMapScrollCheckJoypad
	rtl

	+
	lda #<>rlProcPrepScreenMapScrollOnCycle4
	sta aProcHeaderOnCycle,b,x
	rtl

rlProcPrepScreenMapScrollOnCycle4 ; 81/C283

	.al
	.xl
	.autsiz
	.databank ?

	; Scroll left

	lda wMapScrollWidthPixels,b
	beq +

	dec a
	dec a
	sta wMapScrollWidthPixels,b
	jsr rsPrepScreenMapScrollCheckJoypad
	rtl

	+
	lda #<>rlProcPrepScreenMapScrollOnCycle5
	sta aProcHeaderOnCycle,b,x
	rtl

rlProcPrepScreenMapScrollOnCycle5 ; 81/C298

	.al
	.xl
	.autsiz
	.databank ?

	; Scroll up

	lda wMapScrollHeightPixels,b
	beq _End

	dec a
	dec a
	sta wMapScrollHeightPixels,b
	jsr rsPrepScreenMapScrollCheckJoypad
	rtl

	_End

	; Wrap up

	lda #$0000
	sta $7FAA14

	jsl rlProcEngineFreeProc

	lda wMapScrollWidthPixels,b
	lsr A
	lsr A
	lsr A
	lsr A
	clc 
	adc #$0007
	sta wR0
	lda wMapScrollHeightPixels,b
	lsr A
	lsr A
	lsr A
	lsr A
	clc
	adc #$0006
	sta wR1
	jsl $83C181
	rtl

rsPrepScreenMapScrollCheckJoypad ; 81/C2D0

	.al
	.xl
	.autsiz
	.databank ?

	lda wJoy1New
	bit #~(JoypadID | JoypadRight | JoypadLeft | JoypadDown | JoypadUp)
	beq +

	lda #$0001
	sta aProcBody1,b,x

	+
	lda aProcBody1,b,x
	beq +

	lda wMapScrollWidthPixels,b
	ora wMapScrollHeightPixels,b
	and #$000F
	bne +

	lda #<>rlProcPrepScreenMapScrollOnCycle5._End
	sta aProcHeaderOnCycle,b,x

	+
	rts
