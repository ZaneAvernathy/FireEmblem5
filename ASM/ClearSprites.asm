
rlHideAllSprites ; 80/8325

	.autsiz
	.databank ?

	; Moves all sprites in the sprite buffer offscreen.

	; Inputs:
	; None

	; Outputs:
	; None

	stz wNextFreeSpriteOffs,b

rlHideSprites ; 80/8328

	.autsiz
	.databank ?

	; Moves unused sprites offscreen.

	; Inputs:
	; None

	; Outputs:
	; None

	phd
	sep #$30
	lda wNextFreeSpriteOffs + 1,b
	and #$03
	asl a
	tax
	jsr (_Table,x)
	rep #$30
	stz wNextFreeSpriteOffs,b
	pld
	rtl

	_Table
	.addr _Under64Sprites
	.addr _Over64Sprites
	.addr _HideNoSprites
	.addr _HideNoSprites

	_Under64Sprites ; 80/8344

	.xs
	.autsiz

	rep #$20
	ldx #240 ; offscreen
	phd

	; Clear all of upper part of buffer

	lda #<>aSpriteBuf + (4 * 64)
	tcd
	jsr _Clearer
	pld

	; Actually count for lower

	lda wNextFreeSpriteOffs,b
	lsr a
	clc
	adc #<>_Clearer
	sta wR0
	lda #<>aSpriteBuf
	tcd
	jmp (wR0)

	_Over64Sprites ; 80/8362

	.xs
	.autsiz

	rep #$20
	ldx #240

	; Calculate once

	lda wNextFreeSpriteOffs,b
	and #$00FF
	lsr a
	clc
	adc #<>_Clearer
	sta wR0

	; Only clear upper part of buffer

	lda #<>aSpriteBuf + (4 * 64)
	tcd
	jmp (wR0)

	_Clearer ; 80/837A

	.xs
	.autsiz

	.for i=0+1, i<=256-4+1, i+=4

	stx i

	.next

	_HideNoSprites ; 80/83FA

	.xs
	.autsiz

	rts

rlClearSpriteAttributeBuffer ; 80/83FB

	.autsiz
	.databank ?

	; Clears all sprite attributes.

	; Inputs:
	; None

	; Outputs:
	; None

	.for i=0, i<$20, i+=2

	stz aSpriteBufUpperAttributes + i,b

	.next

	rtl
