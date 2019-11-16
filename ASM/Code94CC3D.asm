
rlUnknownDialogueText ; 94/CC3D

	.al
	.xl
	.autsiz
	.databank ?

	; Inputs:
	; wR0: VRAM offset
	; wR1: Flag to disable drawing tilemap in realtime
	; wR2: delay between writing characters
	; wR3: status bitfield?
	; X: (Y << 8) | X in tiles?

	; (wR0 << 1) + base = actual vram position

	jsr rsUnknown94CCA8
	lda wR2
	bne +

	ldy wR1
	cpy #$0000
	beq +

	lda #10

	+
	sta wProcInput0,b

	lda wR1
	sta wProcInput1,b

	lda wR3
	sta wProcInput2,b

	lda bBuf_BG34NBA
	and #BG34NBA.BG3Base
	xba
	asl a
	asl a
	asl a
	asl a
	clc
	adc wR0
	sta wUnknown7E45BF

	lda #$5000
	sta wUnknown7E45B8

	lda #$0001
	jsl $958162

	lda #$0000
	sta $7E45C5

	lda #$0000
	sta $7E45C9

	txa
	jsl $95812F
	clc
	adc #<>aBG3TilemapBuffer
	sta lUnknownDialogueTextTilemapBufferPosition

	jsl $94DD59

	lda #(`proclm)<<8
	sta lR43+1
	lda #<>proclm
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown94CCA8 ; 94/CCA8

	.al
	.autsiz
	.databank ?

	txa
	and #$00FF
	cmp #$00FF
	bne _End

	lda wR0
	pha
	lda wR1
	pha
	lda wR2
	pha
	lda lR18
	pha
	lda lR18+1
	pha
	txa
	and #$FF00
	pha
	jsl $8ABB6B
	plx
	stx wR0
	ora wR0
	tax
	pla
	sta lR18+1
	pla
	sta lR18
	pla
	sta wR2
	pla
	sta wR1
	pla
	sta wR0

	_End
	rts


