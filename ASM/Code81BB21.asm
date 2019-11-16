
rlDrawAttackRange ; 81/BB21

	.al
	.xl
	.autsiz
	.databank ?

	; Fills out the movement and range maps
	; based on equipped items

	; Clear map

	lda #<>aMovementMap
	sta lR18
	lda #>`aMovementMap
	sta lR18+1
	lda #$0000
	jsl rlFillMapByWord

	; Uses these as a set of flags

	stz wR15
	stz wR16

	; Loop through items, getting ranges if weapons

	ldy #size(aSelectedCharacterBuffer.Items) - 2

	_Loop
	lda aSelectedCharacterBuffer.Items,b,y
	beq _Next

	jsl rlCopyItemDataToBuffer
	lda aItemDataBuffer.Traits,b
	bit #TraitWeapon
	beq _Next

	lda #<>aSelectedCharacterBuffer
	sta wR1
	jsl $83965E
	bcc _Next

	lda aItemDataBuffer.Range,b
	and #$00FF
	cmp # 3 | (15 << 4)
	bne +

	jmp _3To15Range

	+
	and #$000F
	tax
	inc wR15,x
	cmp #3
	beq _Next

	lda aItemDataBuffer.Range,b
	and #$00F0
	lsr a
	lsr a
	lsr a
	lsr a
	tax
	inc wR15,x

	_Next
	dey
	dey
	bpl _Loop

	sep #$20
	lda wR15+1
	beq +

	lda #$10

	+
	sta wR15

	lda wR16
	beq +

	lda #$01

	+
	sta wR16

	lda wR16+1
	beq +

	lda #$10

	+
	ora wR16
	sta wR15+1

	rep #$30
	lda wR15
	cmp #$0010
	beq _1RangeOnly

	cmp #$0100
	beq _2RangeOnly

	cmp #$0110
	beq _1To2Range

	cmp #$1000
	beq _3To10Range

	cmp #$1010
	beq _Not2Range

	cmp #$1110
	beq _1To10Range

	rtl

	_1RangeOnly
	jsl rlDrawRangeTiles1RangeOnly
	jsl $848B72 ; movement + edge cleanup?
	rtl

	_1To2Range
	jsl rlDrawRangeTiles1To2Range
	jsl $848B72
	rtl

	_2RangeOnly
	jsl rlDrawRangeTiles2RangeOnly
	jsl $848B72
	rtl

	_Not2Range ; dunno really
	jsl rlSetupRangePathDirectionDistances
	sep #$20
	lda #$71
	sta bMovementCostCap,b
	rep #$20
	jsl rlUnknown80E551

	_3To10Range
	lda #3 | (10 << 4)
	sta wR17
	jsr rsDrawAttackRangeByMinMax
	jsl $848B72
	rtl

	_1To10Range
	lda #1 | (10 << 4)
	sta wR17
	jsr rsDrawAttackRangeByMinMax
	jsl $848B72
	rtl

	_3To15Range
	lda #3 | (15 << 4)
	sta wR17
	jsr rsDrawAttackRangeByMinMax
	jsl $848B72
	rtl

rsDrawAttackRangeByMinMax ; 81/BC11

	.al
	.xl
	.autsiz
	.databank `aPlayerVisibleUnitMap

	lda #<>rlDrawAttackRangeByMinMaxEffect
	sta lR25
	lda #>`rlDrawAttackRangeByMinMaxEffect
	sta lR25+1
	jsl $8398C7
	rts

rlDrawAttackRangeByMinMaxEffect ; 81/BC20

	.al
	.xl
	.autsiz
	.databank `aPlayerVisibleUnitMap

	lda aPlayerVisibleUnitMap,x
	bne _End

	rep #$30
	txa
	jsl rlGetMapCoordsByTileIndex
	lda #<>aMovementMap
	sta wR3
	lda wR17 ; min | (max << 4)
	jsl rlUnknown80E5CD
	sep #$20

	_End
	rtl

rlUnknown81BC3A ; 81/BC3A

	.al
	.xl
	.autsiz
	.databank `aConvoy

	lda $7EACE2,x
	pha
	stz $7EACE2,x
	ldx #$0000
	ldy #$0000

	_Loop
	lda $7EACE2,x
	beq +

	sta aSelectedCharacterBuffer.Items,b,y
	inc y
	inc y

	+
	inc x
	inc x
	cpy #size(aSelectedCharacterBuffer.Items)
	bne _Loop

	lda $7E50CE
	bne +

	jsl $85C70F
	pla
	sta aConvoy,x
	rtl

	+
	jsl rlUnknown81BC6F
	pla
	sta aConvoy,x
	rtl

rlUnknown81BC6F ; 81/BC6F

	.al
	.xl
	.autsiz
	.databank `aConvoy

	ldx #size(aConvoy) - 2

	_Loop
	lda aConvoy,x

	-
	beq -

	jsl rlCopyItemDataToBuffer
	jsl $83B234
	lda aItemDataBuffer.Cost,b
	sta $7EA968,x
	dec x
	dec x
	bpl _Loop

	jsl rlUnknown81BC8E
	rtl

rlUnknown81BC8E ; 81/BC8E

	.al
	.xl
	.autsiz
	.databank `aConvoy

	lda #$FFFF
	sta wR17

	ldy #$0000
	ldx #$0000

	_Loop
	lda $7EA968,x
	cmp wR17
	bge +

	sta wR17
	txy

	+
	inc x
	inc x
	cpx #size(aConvoy)
	bne _Loop

	tyx
	lda wR17
	rtl

rlUnknown81BCAE ; 81/BCAE

	.al
	.xl
	.autsiz
	.databank `wEventEngineUnknownXTarget

	lda #5 * $10
	sta wR0
	lda #<>aBGPal3
	sta wR1
	lda #<>aFadingBGPaletteBands
	sta wR2
	jsl rlSeparatePaletteBands

	lda #4 * $10
	sta wR0
	lda #<>aOAMPal0
	sta wR1
	lda #<>aFadingOAMPaletteBands
	sta wR2
	jsl rlSeparatePaletteBands

	stz wEventEngineUnknownXTarget

	-
	ldx wEventEngineUnknownXTarget
	lda aUnknown81BD14,x
	beq +

	sta wR2
	lda #5 * $10
	sta wR0
	lda #<>aFadingBGPaletteBands
	sta wR1
	jsl rlReduceAndCombinePaletteBands

	ldx wEventEngineUnknownXTarget
	lda aUnknown81BD14+2,x
	sta wR2
	lda #4 * $10
	sta wR0
	lda #<>aFadingOAMPaletteBands
	sta wR1
	jsl rlReduceAndCombinePaletteBands

	lda wEventEngineUnknownXTarget
	clc
	adc #$0004
	sta wEventEngineUnknownXTarget
	bra -

	+
	rtl

aUnknown81BD14 .block ; 81/BD14

	.for i in range(8)

		.word <>aFadingPaletteSpace + ($120 * i)
		.word <>aFadingPaletteSpace + ($120 * i) + $A0

	.next

	.word $0000
	.bend

rlSeparatePaletteBands ; 81/BD36

	.al
	.xl
	.autsiz
	.databank `wEventEngineUnknownXTarget

	; Separates colors in a palette out into
	; their r, g, b intensities

	; Inputs:
	; wR0: Color count
	; wR1: Source palette
	; wR2: Destination bands

	; Outputs:
	; None

	ldy wR2
	ldx wR1

	-
	lda $0000,b,x
	and #%0111110000000000
	sta $0000,b,y

	lda $0000,b,x
	and #%0000001111100000
	sta $0002,b,y

	lda $0000,b,x
	and #%0000000000011111
	sta $0004,b,y

	tya
	clc
	adc #$0006
	tay

	inc x
	inc x

	dec wR0
	bne -
	rtl

rlReduceAndCombinePaletteBands ; 81/BD62

	.al
	.xl
	.autsiz
	.databank `wEventEngineUnknownXTarget

	; Reduces the intensity of color bands by one
	; and recombines them. Wouldn't this miss the first color?

	; Inputs:
	; wR0: Color count
	; wR1: Source bands
	; wR2: Destination palette

	; Outputs:
	; None

	ldy wR2
	ldx wR1

	-
	lda $0000,b,x
	ora $0002,b,x
	ora $0004,b,x
	sta $0000,b,y

	lda $0000,b,x
	sec
	sbc #1 << 10
	bpl +

	tdc

	+
	sta $0000,b,x

	lda $0002,b,x
	sec
	sbc #1 << 5
	bpl +

	tdc

	+
	sta $0002,b,x

	lda $0004,b,x
	dec a
	bpl +

	tdc

	+
	sta $0004,b,x

	txa
	clc
	adc #$0006
	tax

	inc y
	inc y

	dec wR0
	bpl -

	rtl
