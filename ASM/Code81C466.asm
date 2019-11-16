
rlUnknown81C466 ; 81/C466

	.xl
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`aPhaseControllerInfo
	pha
	rep #$20
	plb

	.databank `aPhaseControllerInfo

	lda wCurrentPhase,b
	jsl $83B296

	lda aPhaseControllerInfo,x
	and #$00FF
	cmp #$0004
	bne +

	lda aSelectedCharacterBuffer.X,b
	and #$00FF
	sta wCursorXCoord,b

	lda aSelectedCharacterBuffer.Y,b
	and #$00FF
	sta wCursorYCoord,b

	+
	lda wCursorXCoord,b
	sta wR0
	lda wCursorYCoord,b
	sta wR1
	jsl $83C181

	lda wCursorXCoordPixelsScrolling,b
	sta wR0
	lda wCursorYCoordPixelsScrolling,b
	sta wR1
	jsl $83C108

	lda wR2
	sta wMapScrollWidthPixels,b
	lda wR3
	sta wMapScrollHeightPixels,b
	plb
	plp
	rtl
