
procInventoryScrollingArrows .dstruct structProcInfo, None, rlProcInventoryScrollingArrowsInit, rlProcInventoryScrollingArrowsOnCycle, None ; 81/E034

rlProcInventoryScrollingArrowsInit ; 81/E03C

	.al
	.xl
	.autsiz
	.databank ?

	; Downwards arrow

	lda #124 ; X
	sta wR0

	lda #79 ; Y
	sta wR1

	jsl $83CB26

	; Upwards arrow

	lda #124 ; X
	sta wR0

	lda #216 ; Y
	sta wR1

	jsl $83CB53
	rtl

rlProcInventoryScrollingArrowsOnCycle ; 81/E059

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb

	sep #$20
	lda #`wInventoryActionIndex
	pha
	rep #$20
	plb

	.databank `wInventoryActionIndex

	lda wInventoryActionIndex
	cmp #aMainInventoryActionTable.Default
	bne _NoArrows

	lda wInventoryScrolledFlag
	beq _TopArrow

	; Else bottom arrow

	lda #$0000 ; bottom on
	jsl $83CCE1
	lda #$0001 ; top off
	jsl $83CCF9
	bra _End

	_TopArrow

	lda #$0001 ; bottom off
	jsl $83CCE1
	lda #$0000 ; top on
	jsl $83CCF9
	bra _End

	_NoArrows

	lda #$0001 ; both arrows disabled while moving
	jsl $83CCE1
	lda #$0001
	jsl $83CCF9

	_End

	plb
	plp
	rtl
