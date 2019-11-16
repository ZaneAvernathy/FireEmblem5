
rlDecompressSingle ; 80/AF93

	.al
	.autsiz
	.databank ?

	; Decompresses a single thing.

	; Inputs:
	; lR44: Source pointer
	; lR46: Destination pointer

	; Outputs:
	; None

	; Copy offsets

	lda lR44
	sta lDecompSource
	lda lR46
	sta lDecompDest

	; Copy banks

	sep #$20
	lda lR44+2
	sta lDecompSource+2
	lda lR46+2
	sta lDecompDest+2
	rep #$20

	; Decompress

	jsl rlDecompressor
	rtl

rlClearDecompList ; 80/AFAC

	.autsiz
	.databank ?

	; Clears all pending decompresses.

	; Inputs:
	; None

	; Outputs:
	; None

	php
	rep #$20
	stz aDecompList,b
	stz wDecompListPosition,b
	sep #$20
	stz bDecompListFlag,b
	plp
	rtl

rlDecompressByList ; 80/AFBC

	.autsiz
	.databank ?

	; Tries to decompress all pending requests.

	; Inputs:
	; None

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	sep #$20
	rep #$10

	; Check if there's anything to decompress

	lda bDecompListFlag,b
	beq _End

	rep #$20
	stz wDecompListPosition,b

	; Loop counter

	ldy #$0000

	_Loop
	cpy #size(aDecompList)
	blt _DoNotHang

	; Hang if too many things to decompress?

	_Hang
	bra _Hang

	_DoNotHang

	; Check for end of list

	lda aDecompList+structDecompListEntry.Source,b,y
	ora aDecompList+structDecompListEntry.Source+1,b,y
	beq _ListEnd

	; Else decompress

	lda aDecompList+structDecompListEntry.Source,b,y
	sta lDecompSource
	lda aDecompList+structDecompListEntry.Source+1,b,y
	sta lDecompSource+1

	lda aDecompList+structDecompListEntry.Dest,b,y
	sta lDecompDest
	lda aDecompList+structDecompListEntry.Dest+1,b,y
	sta lDecompDest+1

	phy
	jsl rlDecompressor
	pla
	clc
	adc #size(structDecompListEntry)
	tay
	bra _Loop

	_ListEnd
	stz bDecompListFlag,b
	stz aDecompList,b

	_End
	plp
	plb
	rtl

rlAppendDecompList ; 80/B00A

	.al
	.autsiz
	.databank ?

	php
	phx

	ldx wDecompListPosition,b

	lda lR18
	sta aDecompList+structDecompListEntry.Source,b,x
	lda lR18+1
	sta aDecompList+structDecompListEntry.Source+1,b,x

	lda lR19
	sta aDecompList+structDecompListEntry.Dest,b,x
	lda lR19+1
	sta aDecompList+structDecompListEntry.Dest+1,b,x

	; Clear the slot after that

	lda #$0000
	sta aDecompList+size(structDecompListEntry)+structDecompListEntry.Source,b,x
	sta aDecompList+size(structDecompListEntry)+structDecompListEntry.Source+1,b,x
	sta aDecompList+size(structDecompListEntry)+structDecompListEntry.Source+2,b,x

	; Advance a slot

	txa
	clc
	adc #size(structDecompListEntry)
	sta wDecompListPosition,b

	; Set flag for pending decompression

	sep #$20
	lda #$01
	sta bDecompListFlag,b

	; Decompress if forced blank enabled

	lda bBuf_INIDISP
	bpl +

	jsl rlDecompressByList

	+
	rep #$20
	plx
	plp
	rtl
