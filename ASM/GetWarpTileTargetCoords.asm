
rlGetWarpTileTargetCoords ; 9A/9C3C

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	; Check if wait was used

	lda $7E4F98
	bit #$0010
	beq _False

	; Get the coordinates of the unit

	sep #$20
	lda aSelectedCharacterBuffer.X,b
	sta wR0
	lda aSelectedCharacterBuffer.Y,b
	sta wR0+1

	; Fetch the warp tile table for the current chapter

	rep #$20
	lda wCurrentChapter,b
	asl a
	tax
	lda <>_ChapterTable,b,x

	; If the chapter doesn't have any warp tiles, end

	beq _False
	tax

	-

	; Check for the end of the table

	lda $0000,b,x
	bmi _False

	; See if unit's coords match table entry

	cmp wR0
	beq +
	inc x
	inc x
	inc x
	inc x
	inc x
	inc x
	bra -

	+

	; Fetch the target coords

	lda $0002,b,x
	and #$00FF
	sta wR0
	lda $0003,b,x
	and #$00FF
	sta wR1

	; Check that there's nobody on that tile

	jsl rlCheckTileOccupied
	bcs _False

	; Return true and have the target coords
	; ready to go

	lda $0002,b,x
	and #$00FF
	sta wEventEngineXCoordinate,b
	lda $0003,b,x
	and #$00FF
	sta wEventEngineYCoordinate,b
	plp
	plb
	sec
	rtl

	_False
	plp
	plb
	clc
	rtl

	_ChapterTable ; 9A/9CA2
		.word None ; Chapter1
		.word None ; Chapter2
		.word None ; Chapter2x
		.word None ; Chapter3
		.word None ; Chapter4
		.word None ; Chapter4x
		.word None ; Chapter5
		.word None ; Chapter6
		.word None ; Chapter7
		.word None ; Chapter8
		.word None ; Chapter8x
		.word None ; Chapter9
		.word None ; Chapter10
		.word None ; Chapter11
		.word None ; Chapter11x
		.word None ; Chapter12
		.word None ; Chapter12x
		.word None ; Chapter13
		.word None ; Chapter14
		.word None ; Chapter14x
		.word None ; Chapter15
		.word None ; Chapter16A
		.word None ; Chapter17A
		.addr _Chapter16BTable ; Chapter16B
		.word None ; Chapter17B
		.word None ; Chapter18
		.word None ; Chapter19
		.word None ; Chapter20
		.word None ; Chapter21
		.word None ; Chapter21x
		.word None ; Chapter22
		.word None ; Chapter23
		.word None ; Chapter24
		.addr _Chapter24xTable ; Chapter24x
		.word None ; ChapterFinal
		.word None ; ChapterUnknown

	_Chapter16BTable ; 9A/9CBE
		.byte 12, 6
		.byte 9, 13
		.byte 12, 6

		.byte 8, 8
		.byte 1, 12
		.byte 8, 8

		.byte 11, 3
		.byte 2, 18
		.byte 11, 3

		.byte 15, 10
		.byte 11, 15
		.byte 15, 10

		.byte 18, 12
		.byte 10, 13
		.byte 18, 12

		.byte 13, 18
		.byte 2, 8
		.byte 13, 18
	.word $FFFF

	_Chapter24xTable ; 99/9D11
		.byte 21, 16
		.byte 13, 37
		.byte 21, 16

		.byte 19, 10
		.byte 13, 37
		.byte 19, 10

		.byte 13, 12
		.byte 13, 37
		.byte 13, 12

		.byte 11, 16
		.byte 13, 37
		.byte 11, 16

		.byte 15, 16
		.byte 13, 37
		.byte 15, 16

		.byte 13, 25
		.byte 13, 37
		.byte 13, 25

		.byte 9, 21
		.byte 13, 37
		.byte 9, 21

		.byte 17, 24
		.byte 13, 37
		.byte 17, 24

		.byte 14, 9
		.byte 13, 37
		.byte 14, 9

		.byte 12, 9
		.byte 13, 37
		.byte 12, 9

		.byte 13, 5
		.byte 13, 37
		.byte 13, 5

		.byte 4, 22
		.byte 13, 37
		.byte 4, 22

		.byte 11, 29
		.byte 13, 37
		.byte 11, 29

		.byte 18, 30
		.byte 13, 37
		.byte 18, 30
	.word $FFFF
