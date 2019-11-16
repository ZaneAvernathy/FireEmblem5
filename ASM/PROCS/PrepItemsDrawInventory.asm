
; Proc overlaps code

.union

procPrepItemsDrawInventory .dstruct structProcInfo, None, rlProcPrepItemsDrawInventoryInit, rlProcPrepItemsDrawInventoryOnCycle, ?

.struct

.fill 6

rlProcPrepItemsDrawInventoryInit ; 81/EBEA

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlProcPrepItemsDrawInventoryOnCycle ; 81/EBEB

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`aBG3TilemapBuffer
	pha
	rep #$20
	plb

	.databank `aBG3TilemapBuffer

	phx

	; Clear space for item names

	lda #<>aBG3TilemapBuffer + ((21 + (1 * $20)) * 2)
	sta wR0
	lda #10
	sta wR1
	lda #14
	sta wR2
	lda #$01DF
	jsl rlFillTilemapRectByWord

	; Clear space for item icons

	lda #<>aBG2TilemapBuffer + ((19 + (1 * $20)) * 2)
	sta wR0
	lda #2
	sta wR1
	lda #14
	sta wR2
	lda #$02FF
	jsl rlFillTilemapRectByWord

	lda #<>$83C0F6
	sta lUnknown000DDE,b
	lda #>`$83C0F6
	sta lUnknown000DDE+1,b

	; Next draw the items and their names in groups.
	; This is probably done this way (and done with a proc)
	; to avoid writing too much to VRAM over a single frame

	; Just the last item now

	ldx #(7 - 1) * 2
	stx wR17

	; Skip if no item

	lda aSelectedCharacterBuffer.Items,b,x
	beq ++

	; Write data and see if unit can equip it

	jsl rlCopyItemDataToBuffer
	stz wR16
	lda #<>aSelectedCharacterBuffer
	sta wR1
	jsl $83965E
	bcs +

	lda #$0002 ; Gray palette
	sta wR16

	+

	; Write name and icon

	jsl $85B686
	jsl $85B69F
	jsl $85B6B4

	+
	plx
	lda #<>rlProcPrepItemsDrawInventoryOnCycle2
	sta aProcHeaderOnCycle,b,x
	plb
	plp
	rtl

.ends

.endu

rlProcPrepItemsDrawInventoryOnCycle2 ; 81/EC64

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`aBG3TilemapBuffer
	pha
	rep #$20
	plb

	.databank `aBG3TilemapBuffer

	; Same as above but for items 4-6

	phx
	lda #<>$83C0F6
	sta lUnknown000DDE,b
	lda #>`$83C0F6
	sta lUnknown000DDE+1,b
	lda #(6 - 1) * 2
	sta wR17

	-
	ldx wR17
	lda aSelectedCharacterBuffer.Items,b,x
	beq ++

	jsl rlCopyItemDataToBuffer
	stz wR16
	lda #<>aSelectedCharacterBuffer
	sta wR1
	jsl $83965E
	bcs +

	lda #$0002
	sta wR16

	+
	jsl $85B686
	jsl $85B69F
	jsl $85B6B4

	+
	dec wR17
	dec wR17
	lda wR17
	cmp #(3 - 1) * 2
	bne -

	plx
	lda #<>rlProcPrepItemsDrawInventoryOnCycle3
	sta aProcHeaderOnCycle,b,x
	plb
	plp
	rtl

rlProcPrepItemsDrawInventoryOnCycle3 ; 81/ECBE

	.al
	.xl
	.autsiz
	.databank ?

	; Same as above but for items 1-3

	php
	phb
	sep #$20
	lda #`aBG3TilemapBuffer
	pha
	rep #$20
	plb

	.databank `aBG3TilemapBuffer

	phx
	lda #<>$83C0F6
	sta lUnknown000DDE,b
	lda #>`$83C0F6
	sta lUnknown000DDE+1,b

	lda #(3 - 1) * 2
	sta wR17

	-
	ldx wR17
	lda aSelectedCharacterBuffer.Items,b,x
	beq ++

	jsl rlCopyItemDataToBuffer
	stz wR16
	lda #<>aSelectedCharacterBuffer
	sta wR1
	jsl $83965E
	bcs +

	lda #$0002
	sta wR16

	+
	jsl $85B686
	jsl $85B69F
	jsl $85B6B4

	+
	dec wR17
	dec wR17
	bpl -

	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG3TilemapBuffer+$40, $0380, VMAIN_Setting(True), $A040

	plx
	lda #<>rlProcPrepItemsDrawInventoryOnCycle4
	sta aProcHeaderOnCycle,b,x
	plb
	plp
	rtl

rlProcPrepItemsDrawInventoryOnCycle4 ; 81/ED20

	.al
	.xl
	.autsiz
	.databank ?

	phx
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG2TilemapBuffer+$40, $0380, VMAIN_Setting(True), $F040

	plx
	jsl rlProcEngineFreeProc
	rtl
