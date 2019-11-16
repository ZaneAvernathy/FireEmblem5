
aOAMUpperXBitTable ; 80/8481

	.for i=0, i<16, i+=1

		.for n=0, n<16, n+=1

			.word 1<<n

		.next

	.next

aOAMSizeBitTable ; 80/8681

	.for i=0, i<16, i+=1

		.for n=0, n<16, n+=2

			.word <>aSpriteBufUpperAttributes + (i*2)
			.word 3<<n

		.next

	.next

rlPushToOAMBuffer ; 80/8881

	.al
	.xl
	.autsiz
	.databank ?

	; Sets a sprite to be rendered.

	; Inputs:
	; Y: Pointer to sprite array
	; DB: Bank of sprite array
	; wR0: X Coordinate base in pixels
	; wR1: Y Coordinate base in pixels
	; wR4: Sprite base
	; wR5: Attribute base

	; Outputs:
	; None

	; Immediately return if no sprites
	; to push

	lda structSpriteArray.SpriteCount,b,y
	bne +
	rtl

	+
	sta wR2
	inc y
	inc y

	_Loop
	phx
	ldx wNextFreeSpriteOffs,b
	clc

	_SpriteLoop
	lda structSpriteEntry.X,b,y ; get x coord, unk, size flag
	bpl _SmallSprite

	; Else large sprite

	adc wR0 ; add to x coord
	sta aSpriteBuf,b,x ; store to OAM buf
	bit #$0100
	bne _LargeSpriteXNegative

	; Store large size bit

	lda aOAMSizeBitTable,x ; get offset for bit
	sta wR3
	lda (wR3)
	ora aOAMUpperXBitTable+2,x ; combine with bit
	bra _8088C3

	_SmallSprite
	adc wR0 ; add to x coord
	sta aSpriteBuf,b,x ; store to OAM buf
	bit #$0100
	beq _SmallSpriteXPositive

	; Store upper x bit

	lda aOAMSizeBitTable,x ; get offset for bit
	sta wR3
	lda (wR3)
	ora aOAMUpperXBitTable,x ; combine with bit

	_8088C3
	sta (wR3)

	_SmallSpriteXPositive
	lda structSpriteEntry.Y,b,y ; get y coord and index
	bit #$0080
	bne _YNegative
	and #$007F
	bra +

	_YNegative
	ora #$FF80 ; s8 -> s16

	+
	clc
	adc wR1 ; add to Y
	sta aSpriteBuf+1,b,x
	adc #16
	cmp #256
	bge _Offscreen
	lda structSpriteEntry.Index,b,y ; index and attributes
	clc
	adc wR4 ; add to sprite base
	ora wR5 ; combine with attribute base
	sta aSpriteBuf+2,b,x

	-
	txa
	clc
	adc #size(structPPUOAMEntry)
	and #$01FF
	tax
	tya
	adc #size(structSpriteEntry)
	tay
	dec wR2 ; sprite count
	bne _SpriteLoop
	stx wNextFreeSpriteOffs,b
	plx
	rtl

	_Offscreen
	lda #240
	sta aSpriteBuf+1,b,x
	bra -

	_LargeSpriteXNegative
	lda aOAMSizeBitTable,x ; get table entry
	sta wR3
	lda (wR3)
	ora aOAMSizeBitTable+2,x ; get both size and upper x bit
	bra _8088C3

rlSpliceOAMBuffer ; 80/891B

	lda wR2 ; sprite count
	beq +

	lda structSpriteArray.SpriteCount,b,y
	bne ++

	+
	rtl

	+
	cmp wR2
	bge +

	sta wR2

	+
	inc y
	inc y
	jmp rlPushToOAMBuffer._Loop
