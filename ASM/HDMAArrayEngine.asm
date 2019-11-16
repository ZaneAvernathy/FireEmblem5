
aHDMAArrayEngineMainActionTable ; 82/A396

	.addr rlResetHDMAArrayEngine
	.addr rlHDMAArrayEngineMainLoop
	.addr rlHDMAArrayEngineStub

rlClearHDMAArray ; 82/A39C

	.al
	.xl
	.autsiz
	.databank ?

	; Clears the RAM used by the HDMA array

	; Inputs:
	; None

	; Outputs:
	; None

	phb
	php

	phk
	plb

	.databank `*

	ldx #size(aHDMAArrayTypeOffset)-2

	-
	stz aHDMAArrayTypeOffset,b,x
	dec x
	dec x
	bpl -

	plp
	plb
	rtl

rlResetHDMAArrayEngine ; 82/A3AD

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb

	phk
	plb

	.databank `*

	ldx #size(aHDMAArraySpace)
	lda #$0000

	-
	sta aHDMAArraySpace,b,x
	dec x
	dec x
	bpl -

	ldx #7 * $10

	sep #$20

	lda #$00
	sta HDMAEN,b
	sta bHDMAPendingChannels,b

	-
	lda #$00
	sta DMAP0,b,x
	sta DAS0+2,b,x
	sta A1T0,b,x
	sta A1T0+1,b,x
	sta A1T0+2,b,x

	lda #BG4HOFS - PPU_REG_BASE
	sta BBAD0,b,x

	txa
	sec
	sbc #$10
	bmi +

	tax
	bra -

	+
	plb
	plp
	rtl

rlHDMAArrayEngineCreateEntry ; 82/A3ED

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda lR43+2
	pha
	rep #$20
	plb

	.databank ?

	phx
	phy

	lda #$0000
	sta wR40

	ldy lR43
	ldx #$0000

	-
	lda aHDMAArrayTypeOffset,b,x
	beq _AddEntry

	lda wR40
	clc
	adc #$0010
	sta wR40
	inc x
	inc x
	cpx #size(aHDMAArrayTypeOffset)
	blt -

	ply
	plx
	plb
	plp
	sec
	rtl

	_AddEntry
	tya
	sta aHDMAArrayTypeOffset,b,x
	lda lR43+1
	and #$FF00
	sta lHDMAArrayCodePointer+1,b
	xba
	sta aHDMAArrayTypeBank,b,x

	lda #$0001
	sta aHDMAArraySleepTimer,b,x

	lda #$0000
	sta aHDMAArrayBitfield,b,x
	sta aHDMAArrayUnknownTimer,b,x

	lda structHDMAArrayEntryInfo.Init,b,y
	sta lHDMAArrayCodePointer,b

	lda structHDMAArrayEntryInfo.OnCycle,b,y
	sta aHDMAArrayOnCycle,b,x

	lda structHDMAArrayEntryInfo.Code,b,y
	sta aHDMAArrayCodeOffset,b,x

	lda structHDMAArrayEntryInfo.TableOffset,b,y
	sta aHDMAArrayTableOffset,b,x

	lda structHDMAArrayEntryInfo.TableBankAndBBADx,b,y
	sta aHDMAArrayTableBankAndBBADx,b,x

	lda structHDMAArrayEntryInfo.DMAPx,b,y
	sta aHDMAArrayDMAPxAndHDMABank,b,x

	stx wHDMAArrayIndex,b
	jsl +

	ply
	plx
	plb
	plp
	clc
	rtl

	+
	jmp [lHDMAArrayCodePointer]

rlHDMAArrayEngineCreateEntryByIndex ; 82/A470

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb

	sep #$20
	lda lR43+2
	pha
	rep #$20
	plb

	.databank ?

	phx
	phy
	ldy lR43
	lda wR39
	asl a
	tax
	asl a
	asl a
	asl a
	sta wR40
	lda aHDMAArrayTypeOffset,b,x
	bne +

	jmp rlHDMAArrayEngineCreateEntry._AddEntry

	+
	ply
	plx
	plb
	plp
	sec
	rtl

rlHDMAArrayEngineFreeEntryByIndex ; 82/A495

	.al
	.xl
	.autsiz
	.databank ?

	phx
	asl a
	tax
	jsl rlHDMAArrayEngineFreeEntryByOffset
	plx
	rtl

rlHDMAArrayEngineMainLoop ; 82/A49E

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb

	phk
	plb

	.databank `*

	sep #$20
	stz bHDMAArrayPendingChannels,b
	rep #$20
	ldx #$0000

	-
	stx wHDMAArrayIndex,b
	lda aHDMAArrayTypeOffset,b,x
	beq +

	jsr rsHDMAArrayEngineRunOnCycleAndCode

	+
	ldx wHDMAArrayIndex,b
	inc x
	inc x
	cpx #size(aHDMAArrayTypeOffset)
	blt -

	sep #$20
	lda bHDMAArrayPendingChannels,b
	sta bHDMAPendingChannels,b
	stz bHDMAArrayPendingChannels,b
	rep #$20
	plb
	plp
	rtl

rsHDMAArrayEngineRunOnCycleAndCode ; 82/A4D1

	.al
	.xl
	.autsiz
	.databank ?

	lda aHDMAChannelTable,x
	ora bHDMAArrayPendingChannels,b
	sta bHDMAArrayPendingChannels,b
	lda aHDMAArrayBitfield,b,x
	bit #$1000
	bne _End

	sep #$20
	lda aHDMAArrayTypeBank,b,x
	pha
	rep #$20
	plb

	.databank ?

	jsl rlHDMAArrayEngineRunOnCycle
	ldx wHDMAArrayIndex,b
	dec aHDMAArraySleepTimer,b,x
	bne _End

	ldy aHDMAArrayCodeOffset,b,x

	_Loop
	lda $0000,b,y
	bpl +

	sta lHDMAArrayCodePointer,b
	inc y
	inc y
	pea <>_Loop-1
	jmp (lHDMAArrayCodePointer)

	+
	sta aHDMAArraySleepTimer,b,x
	lda $0002,b,y
	sta aHDMAArrayTableOffset,b,x
	tya
	clc
	adc #$0004
	sta aHDMAArrayCodeOffset,b,x

	_End
	rts

rlHDMAArrayEngineRunOnCycle ; 82/A51D

	.al
	.xl
	.autsiz
	.databank ?

	lda aHDMAArrayTypeBank,b,x
	xba
	sta lHDMAArrayCodePointer+1,b
	lda aHDMAArrayOnCycle,b,x
	sta lHDMAArrayCodePointer,b
	jmp [lHDMAArrayCodePointer]

aHDMAChannelTable ; 82/A52D

	.for i in range(8)

		.word 1 << i

	.next

rlHDMAArrayEngineStub ; 82/A53D

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlHDMAArrayEngineProcessHDMAArray ; 82/A53E

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda wR0
	pha
	sep #$30
	lda bBuf_HDMAEN
	sta wR0
	ldx #size(aHDMAArrayTypeOffset)-2
	ldy #7 * $10

	-
	asl wR0
	bcc +

	lda aHDMAArrayTableOffset,b,x
	sta A1T0,b,y
	lda aHDMAArrayTableOffset+1,b,x
	sta A1T0+1,b,y
	lda aHDMAArrayTableBank,b,x
	sta A1T0+2,b,y
	lda aHDMAArrayBBADxSetting,b,x
	sta BBAD0,b,y
	lda aHDMAArrayDMAPxSetting,b,x
	sta DMAP0,b,y
	lda aHDMAArrayHDMABank,b,x
	sta DAS0+2,b,y

	+
	tya
	sec
	sbc #$10
	tay
	dec x
	dec x
	bpl -

	pla
	sta wR0
	plp
	rtl

rlHDMAArrayEngineFreeEntryByOffset ; 82/A582

	.al
	.xl
	.autsiz
	.databank ?

	stz aHDMAArrayTypeOffset,b,x
	rtl

rlHDMAArrayEngineFindEntry ; 82/A586

	.al
	.xl
	.autsiz
	.databank ?

	php
	ldx #size(aHDMAArrayTypeOffset)-2

	-
	rep #$20

	lda aHDMAArrayTypeOffset,b,x
	cmp lR43
	bne +

	sep #$20
	lda aHDMAArrayTypeBank,b,x
	cmp lR43+2
	rep #$20
	beq ++

	+
	dec x
	dec x
	bpl -

	plp
	clc
	rtl

	+
	plp
	sec
	rtl
