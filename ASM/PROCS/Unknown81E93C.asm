
procUnknown81E93C .dstruct structProcInfo, None, rlProcUnknown81E93CInit, rlProcUnknown81E93COnCycle, None ; 81/E93C

rlProcUnknown81E93CInit ; 81/E944

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlProcUnknown81E93COnCycle ; 81/E945

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`wPrepItemsActionIndex
	pha
	rep #$20
	plb

	.databank `wPrepItemsActionIndex

	stz wR15
	lda wPrepItemsActionIndex
	asl a
	tax
	lda aUnknown81E1B9,x
	beq ++

	bpl +

	lda #$0040
	sta wR15

	+
	jsl rlUnknown81E96A

	+
	plb
	plp
	rtl

rlUnknown81E96A ; 81/E96A

	.al
	.xl
	.autsiz
	.databank `wPrepItemsActionIndex

	bra +

	_End
	rtl

	+
	lda wPrepDeploymentSlotsOffset
	sta wR17

	_Loop
	dec wR17
	dec wR17
	bmi _End

	ldx wR17
	lda aPrepDeploymentSlots,x
	tay
	lda structCharacterDataRAM.Character,b,y
	beq _Loop

	lda structCharacterDataRAM.TurnStatus,b,y
	bit #TurnStatusDead | TurnStatusInvisible | TurnStatusCaptured
	bne _Loop

	lda wR17
	asl a
	tax
	lda $85F2C7,x
	clc
	adc wPrepUnitListSpriteVerticalOffset
	sec
	sbc wBuf_BG3VOFS
	cmp #120
	beq _Loop
	bcc _Loop

	cmp #216
	bcs _Loop

	sta wR1
	lda $85F2C5,x
	sta wR0
	cmp wR15
	bcc _Loop

	inc x
	inc x
	inc x
	inc x
	stx wR16
	stz wR5
	lda structCharacterDataRAM.TurnStatus,b,y
	bit #TurnStatusGrayed
	beq +

	lda #$0600
	sta wR5

	+
	lda structCharacterDataRAM.SpriteInfo2,b,y
	sta wR4
	lda structCharacterDataRAM.SpriteInfo1,b,y
	bit #$0080
	bne _Tall

	phb
	php
	phk
	plb

	.databank `*

	ldy #<>_ShortSprite
	jsl rlPushToOAMBuffer
	plp
	plb
	jmp _Loop

	.databank `wPrepItemsActionIndex

	_Tall
	phb
	php
	phk
	plb

	.databank `*

	ldy #<>_TallSprite
	jsl rlPushToOAMBuffer
	plp
	plb
	jmp _Loop

	_ShortSprite .dstruct structSpriteArray, [[[0, 0], $42, True, $000, 2, 0, False, False]]

	_TallSprite .dstruct structSpriteArray, [[[0, 0], $42, True, $000, 2, 0, False, False], [[0, -16], $42, True, $002, 2, 0, False, False]]
