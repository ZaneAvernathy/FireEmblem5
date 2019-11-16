
rsHDMAArrayCodeSleep ; 82/A5A8

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	sta aHDMAArraySleepTimer,b,x
	inc y
	inc y
	tya
	sta aHDMAArrayCodeOffset,b,x
	pla
	rts

rsHDMAArrayCodeEnd ; 82/A5B6

	.al
	.xl
	.autsiz
	.databank ?

	stz aHDMAArrayTypeOffset,b,x
	lda aHDMAArrayBitfield,b,x
	ora #$2000
	sta aHDMAArrayBitfield,b,x
	pla
	rts

rsHDMAArrayCodeHaltSleep ; 82/A5C4

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	sta aHDMAArraySleepTimer,b,x

rsHDMAArrayCodeHalt ; 82/A5CA

	.al
	.xl
	.autsiz
	.databank ?

	dec y
	dec y
	tya
	sta aHDMAArrayCodeOffset,b,x
	pla
	rts

rsHDMAArrayCodeCallRoutine ; 82/A5D2

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	sta lHDMAArrayCodePointer,b
	lda $0001,b,y
	sta lHDMAArrayCodePointer+1,b
	phy
	phx
	jsl _Goto
	plx
	ply
	inc y
	inc y
	inc y
	rts

	_Goto
	jmp [lHDMAArrayCodePointer]

rsHDMAArrayCodeSetOnCycle ; 82/A5ED

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	sta aHDMAArrayOnCycle,b,x
	lda aHDMAArrayBitfield,b,x
	ora #$0800
	sta aHDMAArrayBitfield,b,x
	inc y
	inc y
	rts

rsHDMAArrayCodeJump ; 82/A5FF

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	tay
	rts

rsHDMAArrayCodeSetUnknownTimer ; 82/A604

	.al
	.xl
	.autsiz
	.databank ?

	lda $0000,b,y
	sta aHDMAArrayUnknownTimer,b,x
	inc y
	inc y
	rts

rsHDMAArrayCodeJumpWhileUnknownTimer ; 82/A60D

	.al
	.xl
	.autsiz
	.databank ?

	dec aHDMAArrayUnknownTimer,b,x
	bne rsHDMAArrayCodeJump

	inc y
	inc y
	rts

rsHDMAArrayCodeJumpIfBitUnset ; 82/A615

	.al
	.xl
	.autsiz
	.databank ?

	lda $0002,b,y
	bit aHDMAArrayBitfield,b,x
	beq rsHDMAArrayCodeJump

	inc y
	inc y
	inc y
	inc y
	rts

rsHDMAArrayCodeJumpIfBitSet ; 82/A622

	.al
	.xl
	.autsiz
	.databank ?

	lda $0002,b,y
	bit aHDMAArrayBitfield,b,x
	bne rsHDMAArrayCodeJump

	inc y
	inc y
	inc y
	inc y
	rts

rsHDMAArrayCodeSetTableBank ; 82/A62F

	.al
	.xl
	.autsiz
	.databank ?

	sep #$20
	lda $0000,b,y
	sta aHDMAArrayTableBank,b,x
	rep #$20
	inc y
	rts
