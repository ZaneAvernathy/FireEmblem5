
aResetChecksum ; 82/A922
	.word $0000

aUnknown82A924 ; 82/A924
	.word $0000

aUnknown82A926 ; 82/A926
	.word $0000

rlUnknownChecksumChecker ; 82/A928

	.as
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	phx
	lda @l aUnknown82A926
	beq _False

	lda #$00
	ldx #<>riResetE

	-
	clc
	adc riResetE&$FF0000,x
	inc x
	inc x
	cpx #<>riResetE._ClearRAM
	blt -

	cmp aResetChecksum
	bne _True

	lda #$00
	ldx #<>$8AAFA3

	-
	clc
	adc $8AAFA3&$FF0000,x
	inc x
	inc x
	cpx #<>$8AB035
	blt -

	cmp aUnknown82A924
	bne _True

	lda @l aResetChecksum
	cmp $888880
	bne _True

	cmp $8AAF95
	bne _True

	lda @l aUnknown82A924
	cmp $888882
	bne _True

	cmp $8AAF97
	bne _True

	_False

	plx
	plp
	plb
	clc
	rtl

	_True

	plx
	plp
	plb
	sec
	rtl
