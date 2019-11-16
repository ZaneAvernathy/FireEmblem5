
rlRegisterAllMapSpritesAndStatus ; 88/85D1

	.al
	.autsiz
	.databank ?

	; Inputs:
	; None

	; Outputs:
	; None

	php
	phb

	sep #$20
	lda #`aUpperMapSpriteAndStatusBuffer
	pha
	rep #$20
	plb

	.databank `aUpperMapSpriteAndStatusBuffer

	stz wR16
	stz wR17

	lda #OAMTileAndAttr($000, 0, 2, False, False)
	sta wR9
	lda #(Player + 1) * 2
	sta wR6
	jsr rsRegisterMapSpriteAndStatus

	lda #OAMTileAndAttr($000, 1, 2, False, False)
	sta wR9
	lda #(Enemy + 1) * 2
	sta wR6
	jsr rsRegisterMapSpriteAndStatus

	lda #OAMTileAndAttr($000, 2, 2, False, False)
	sta wR9
	lda #(NPC + 1) * 2
	sta wR6
	jsr rsRegisterMapSpriteAndStatus

	lda #-1
	ldy wR16
	sta aUpperMapSpriteAndStatusBuffer+2,y
	ldy wR17
	sta aLowerMapSpriteBuffer+2,y
	plb
	plp
	rtl

rsRegisterMapSpriteAndStatus ; 88/8616

	.al
	.autsiz
	.databank `aUpperMapSpriteAndStatusBuffer

	; Inputs:
	; wR6: Starting deployment slot
	; wR9: Base tile and attributes
	; wR16: Current size of aUpperMapSpriteAndStatusBuffer
	; wR17: Current size of aLowerMapSpriteBuffer

	; Go through all units of an allegiance

	_Loop
	ldx wR6
	lda aDeploymentSlotTable,x
	cmp #-1
	beq _End

	tax
	lda structExpandedCharacterDataRAM.Character,b,x
	bne _Unit

	_Next
	inc wR6
	inc wR6
	bra _Loop

	_End
	rts

	_Unit

	; We don't want to register dead/missing sprites

	lda structExpandedCharacterDataRAM.TurnStatus,b,x
	bit #TurnStatusRescued
	bne +

	bit #TurnStatusDead | TurnStatusUnknown1 | TurnStatusUnselectable | TurnStatusActing | TurnStatusInvisible | TurnStatusCaptured
	bne _Next

	+

	; Get coords and tile bases

	lda structExpandedCharacterDataRAM.X,b,x
	and #$00FF
	asl a
	asl a
	asl a
	asl a
	sta wR7

	lda structExpandedCharacterDataRAM.Y,b,x
	and #$00FF
	asl a
	asl a
	asl a
	asl a
	sta wR8

	lda wR9
	sta wR20

	; Grayed units get the gray palette

	lda structExpandedCharacterDataRAM.TurnStatus,b,x
	bit #TurnStatusGrayed
	beq +

	lda #OAMTileAndAttr($000, 3, 2, False, False)
	sta wR20

	+
	lda structExpandedCharacterDataRAM.TurnStatus,b,x
	bit #TurnStatusRescued
	bne _Rescued

	lda structExpandedCharacterDataRAM.Status,b,x
	and #$00FF
	beq _SetSprite

	cmp #StatusSleep
	beq _Sleep

	cmp #StatusBerserk
	beq _Berserk

	cmp #StatusSilence
	bne +

	jmp _Silence

	+
	cmp #StatusPoison
	beq _Poison

	bra _Petrify

	_SetSprite
	lda structExpandedCharacterDataRAM.SpriteInfo,b,x
	bit #$0080
	beq _ShortSprite

	jmp _TallSprite

	_ShortSprite

	; Store coords, tile, etc and advance

	ldy wR17

	lda wR7
	sta aLowerMapSpriteBuffer+structMapSpriteAndStatusEntry.X,y

	lda wR8
	sta aLowerMapSpriteBuffer+structMapSpriteAndStatusEntry.Y,y

	lda structExpandedCharacterDataRAM.SpriteInfo2,b,x
	ora wR20
	sta aLowerMapSpriteBuffer+structMapSpriteAndStatusEntry.TileAndAttr,y

	tya
	clc
	adc #size(structMapSpriteAndStatusEntry)
	sta wR17

	jmp _Next

	_Rescued

	; Draw the rescue icon over anyone rescuing

	phx
	lda structExpandedCharacterDataRAM.Rescue,b,x
	and #$00FF
	asl a
	tax
	lda aDeploymentSlotTable,x
	tax
	lda structExpandedCharacterDataRAM.TurnStatus,b,x
	plx
	bit #TurnStatusUnselectable | TurnStatusActing
	beq +

	jmp _Next

	+

	ldy wR16

	lda wR7
	clc
	adc #7
	sta aUpperMapSpriteAndStatusBuffer+structMapSpriteAndStatusEntry.X,y

	lda wR8
	clc
	adc #7
	sta aUpperMapSpriteAndStatusBuffer+structMapSpriteAndStatusEntry.Y,y

	lda #OAMTileAndAttr($114, 0, 0, False, False)
	ora wR9
	sta aUpperMapSpriteAndStatusBuffer+structMapSpriteAndStatusEntry.TileAndAttr,y

	tya
	clc
	adc #size(structMapSpriteAndStatusEntry)
	sta wR16

	jmp _Next

	_Sleep
	lda #OAMTileAndAttr($11F, 0, 2, False, False)
	bra +

	_Berserk
	lda #OAMTileAndAttr($12C, 0, 2, False, False)
	bra +

	_Poison
	lda #OAMTileAndAttr($12D, 1, 2, False, False)
	bra +

	_Petrify
	lda #OAMTileAndAttr($13D, 1, 2, False, False)
	bra +

	_Silence
	lda #OAMTileAndAttr($13C, 0, 2, False, False)

	+
	sta wR0

	ldy wR16

	; Draw the tile for the status

	lda wR7
	clc
	adc #8
	sta aUpperMapSpriteAndStatusBuffer+structMapSpriteAndStatusEntry.X,y

	lda wR8
	sta aUpperMapSpriteAndStatusBuffer+structMapSpriteAndStatusEntry.Y,y
	lda wR0

	sta aUpperMapSpriteAndStatusBuffer+structMapSpriteAndStatusEntry.TileAndAttr,y
	tya
	clc
	adc #size(structMapSpriteAndStatusEntry)
	sta wR16

	jmp _SetSprite

	_TallSprite
	ldy wR16

	lda wR7
	ora #$8000 ; Flag for nonstatus
	sta aUpperMapSpriteAndStatusBuffer+structMapSpriteAndStatusEntry.X,y

	lda wR8
	sec
	sbc #16
	sta aUpperMapSpriteAndStatusBuffer+structMapSpriteAndStatusEntry.Y,y

	lda structExpandedCharacterDataRAM.SpriteInfo2,b,x
	inc a
	inc a
	ora wR20
	sta aUpperMapSpriteAndStatusBuffer+structMapSpriteAndStatusEntry.TileAndAttr,y

	tya
	clc
	adc #size(structMapSpriteAndStatusEntry)
	sta wR16

	jmp _ShortSprite

rsRenderMapSpritesAndStatus ; 88/8755

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb

	sep #$20
	lda #`aUpperMapSpriteAndStatusBuffer
	pha
	rep #$20
	plb

	.databank `aUpperMapSpriteAndStatusBuffer

	lda wMapScrollWidthPixels,b
	sec
	sbc #16
	sta lR18+structMapSpriteAndStatusEntry.X ; always shown
	sta lR18+structMapSpriteAndStatusEntry.Y+2 ; fades in/out

	lda wMapScrollHeightPixels,b
	sec
	sbc #16
	sta lR18+structMapSpriteAndStatusEntry.Y

	lda wUnknown0000DB
	and #$0030
	bne +

	lda #$0400
	sta lR18+structMapSpriteAndStatusEntry.Y+2

	+
	jsr rsRenderTallMapSpriteAndStatusLoop
	jsr rsRenderMapSpriteLoop
	plb
	plp
	rtl

	-

	.al
	.xl
	.autsiz
	.databank `aUpperMapSpriteAndStatusBuffer

	stx wNextFreeSpriteOffs,b
	rts

rsRenderTallMapSpriteAndStatusLoop ; 88/878C

	.al
	.xl
	.autsiz
	.databank `aUpperMapSpriteAndStatusBuffer

	; Inputs:
	; lR18: modified structMapSpriteAndStatusEntry

	; Outputs:
	; None

	ldx wNextFreeSpriteOffs,b
	ldy #$0000

	_Loop
	lda aUpperMapSpriteAndStatusBuffer+structMapSpriteAndStatusEntry.Y,y
	bmi -

	sec
	sbc lR18+structMapSpriteAndStatusEntry.Y
	bit #$8700
	bne _Next

	sta wR5

	lda aUpperMapSpriteAndStatusBuffer+structMapSpriteAndStatusEntry.X,y
	bmi _TallSpriteUpper

	sec
	sbc lR18+structMapSpriteAndStatusEntry.Y+2
	bmi _Next

	cmp #256 + 16
	bge _Next

	sec
	sbc #16
	sta aSpriteBuf+structPPUOAMEntry.X,b,x
	bpl _YAndAttr

	lda aOAMSizeBitTable,x
	sta wR0
	lda (wR0)
	ora aOAMUpperXBitTable,x
	sta (wR0)

	_YAndAttr
	lda wR5
	sec
	sbc #16
	sta aSpriteBuf+structPPUOAMEntry.Y,b,x

	lda aUpperMapSpriteAndStatusBuffer+structMapSpriteAndStatusEntry.TileAndAttr,y
	sta aSpriteBuf+structPPUOAMEntry.Index,b,x
	inc x
	inc x
	inc x
	inc x

	_Next
	tya
	clc
	adc #size(structMapSpriteAndStatusEntry)
	tay
	bra _Loop

	_TallSpriteUpper
	and #~$8000
	sec
	sbc lR18+structMapSpriteAndStatusEntry.X
	bmi _Next

	cmp #256 + 16
	bge _Next
	sec
	sbc #16
	sta aSpriteBuf+structPPUOAMEntry.X,b,x
	bpl +

	lda aOAMSizeBitTable,x
	sta wR0
	lda (wR0)
	ora aOAMSizeBitTable+2,x
	sta (wR0)
	bra _YAndAttr

	+
	lda aOAMSizeBitTable,x
	sta wR0
	lda (wR0)
	ora aOAMUpperXBitTable+2,x
	sta (wR0)
	bra _YAndAttr

	-

	.al
	.xl
	.autsiz
	.databank `aUpperMapSpriteAndStatusBuffer

	stx wNextFreeSpriteOffs,b
	rts

rsRenderMapSpriteLoop ; 88/881C

	.al
	.xl
	.autsiz
	.databank `aUpperMapSpriteAndStatusBuffer

	ldx wNextFreeSpriteOffs,b
	ldy #$0000

	_Loop
	lda aLowerMapSpriteBuffer+structMapSpriteAndStatusEntry.Y,y
	bmi -

	sec
	sbc lR18+structMapSpriteAndStatusEntry.Y
	bit #$8700
	bne _Next

	sta wR5

	lda aLowerMapSpriteBuffer+structMapSpriteAndStatusEntry.X,y
	sec
	sbc lR18+structMapSpriteAndStatusEntry.X
	bmi _Next

	cmp #256 + 16
	bge _Next

	sec
	sbc #16

	sta aSpriteBuf+structPPUOAMEntry.X,b,x
	bpl +

	lda aOAMSizeBitTable,x
	sta wR0
	lda (wR0)
	ora aOAMSizeBitTable+2,x
	sta (wR0)
	bra _YAndAttr

	+
	lda aOAMSizeBitTable,x
	sta wR0
	lda (wR0)
	ora aOAMUpperXBitTable+2,x
	sta (wR0)

	_YAndAttr
	lda wR5
	sec
	sbc #16
	sta aSpriteBuf+structPPUOAMEntry.Y,b,x

	lda aLowerMapSpriteBuffer+structMapSpriteAndStatusEntry.TileAndAttr,y
	sta aSpriteBuf+structPPUOAMEntry.Index,b,x

	inc x
	inc x
	inc x
	inc x

	_Next
	tya
	clc
	adc #size(structMapSpriteAndStatusEntry)
	tay
	bra _Loop
