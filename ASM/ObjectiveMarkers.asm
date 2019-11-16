
rlRenderObjectiveMarkers ; 81/C318

	.xl
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`wObjectiveMarkerColorValue
	pha
	rep #$20
	plb

	.databank `wObjectiveMarkerColorValue

	stz wR17

	lda wObjectiveMarkerColorValue
	sta wR5

	inc wObjectiveMarkerFrame
	ldx wObjectiveMarkerFrame

	lda _FrameTable,x
	and #$00FF
	bne +

	stz wObjectiveMarkerFrame
	lda #$0002

	+
	sta wR6
	phb
	php
	phk
	plb

	.databank `*

	-
	ldx wR17
	lda aObjectiveMarkers+structObjectiveMarkerEntryRAM.X,x
	bmi _End

	sec
	sbc wMapScrollWidthPixels,b
	sta wR0

	lda aObjectiveMarkers+structObjectiveMarkerEntryRAM.Y,x
	sec
	sbc wMapScrollHeightPixels,b
	sta wR1

	lda aObjectiveMarkers+structObjectiveMarkerEntryRAM.Sprite,x
	clc
	adc wR6
	sta wR4

	ldy #<>_Sprite
	jsl rlPushToOAMBuffer
	lda wR17
	clc
	adc #size(structObjectiveMarkerEntryRAM)
	sta wR17
	bra -

	_End
	plp
	plb
	plb
	plp
	rtl

	_Sprite .dstruct structSpriteArray, [[[0, 0], $42, True, $000, 2, 0, False, False]] ; 81/C37B

	_FrameTable ; 81/C382
	.for n in range(2, 8, 2)
		.for i in range(12)
			.byte n
		.next
	.next
	.byte 0

rlCreateObjectiveMarkerArray ; 81/C3A7

	.xl
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`wObjectiveMarkerColorIndex
	pha
	rep #$20
	plb

	.databank `wObjectiveMarkerColorIndex

	; Clear color

	stz wObjectiveMarkerColorIndex

	; Start array with a terminator in case there
	; are no markers

	lda #-1
	sta aObjectiveMarkers+structObjectiveMarkerEntryRAM.X
	sta aObjectiveMarkers+structObjectiveMarkerEntryRAM.Tile

	; Fetch chapter's objective markers

	lda #structChapterDataTableEntry.ObjectiveMarkers
	sta lR18
	lda wCurrentChapter,b
	jsl $848933

	; Wrap up if no markers

	lda lR18
	beq _End

	; Grab marker color

	lda [lR18]
	and #$00FF
	sta wObjectiveMarkerColorIndex

	; Default color is red

	ldx #$0000
	stx wObjectiveMarkerColorValue

	cmp #$0002 ; Blue
	beq +

	ldx #$0200
	stx wObjectiveMarkerColorValue

	+
	stz wR17 ; Loop counter

	_Loop
	inc lR18

	; Some chapters have 3 for their color
	; (Green) but this routine only understands
	; red or blue. Chapters with a color value of 3
	; have no actual entries.

	; Grab the X coordinate and check if we've hit
	; the end

	lda [lR18]
	and #$00FF
	beq _End

	sta wR0

	; Y coordinate

	inc lR18
	lda [lR18]
	and #$00FF
	sta wR1

	; Sprite base

	inc lR18
	lda [lR18]
	and #$00FF
	sta wR2

	jsr rsAppendObjectiveMarkerArray
	bra _Loop

	_End
	plb
	plp
	rtl

rsAppendObjectiveMarkerArray ; 81/C40D

	.al
	.xl
	.autsiz
	.databank `wObjectiveMarkerColorIndex

	ldx wR17 ; Loop counter

	; Fetch tile from coordinates

	jsl rlGetMapTileIndexByCoords

	sta aObjectiveMarkers+structObjectiveMarkerEntryRAM.Tile,x

	; Coordinates

	lda wR0
	asl a
	asl a
	asl a
	asl a
	sta aObjectiveMarkers+structObjectiveMarkerEntryRAM.X,x

	lda wR1
	asl a
	asl a
	asl a
	asl a
	sta aObjectiveMarkers+structObjectiveMarkerEntryRAM.Y,x

	; Sprite

	txy
	ldx wR2
	lda aObjectiveMarkerArrowSpriteTable,x
	sta aObjectiveMarkers+structObjectiveMarkerEntryRAM.Sprite,y
	tya

	; Advance, lay a terminator over next entry

	clc
	adc #size(structObjectiveMarkerEntryRAM)
	sta wR17

	tax

	lda #-1
	sta aObjectiveMarkers+structObjectiveMarkerEntryRAM.X,x
	sta aObjectiveMarkers+structObjectiveMarkerEntryRAM.Tile,x
	rts

aObjectiveMarkerArrowSpriteTable ; 81/C444
	; Tile ID, X flip, Y flip
	_Right	.word $011E | (False << 14) | (False << 15)
	_Left	.word $011E | (True  << 14) | (False << 15)
	_Up		.word $0124 | (False << 14) | (False << 15)
	_Down	.word $0124 | (False << 14) | (True  << 15)

rlFindObjectiveMarker ; 81/C44C

	.al
	.xl
	.autsiz
	.databank `aObjectiveMarkers

	; Given a tile index, checks if an objective marker
	; is there.

	; Inputs:
	; A: Map tile index

	; Outputs:
	; Carry set if found, clear otherwise
	; X: Offset of entry if found

	ldx #$0000
	sta wR0

	-
	lda aObjectiveMarkers+structObjectiveMarkerEntryRAM.Tile,x
	bmi ++

	cmp wR0
	beq +

	txa
	clc
	adc #size(structObjectiveMarkerEntryRAM)
	tax
	bra -

	+
	sec
	rtl

	+
	clc
	rtl
