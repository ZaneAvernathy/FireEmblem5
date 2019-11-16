
rlUnknown80B231 ; 80/B231

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php
	phk
	plb

	.databank `*

	phy
	clc
	adc $0000,b,x
	tay
	sep #$20
	lda $0002,b,x
	pha
	rep #$20
	plb
	lda $0000,b,y
	ora $0001,b,y
	beq +

	lda $0000,b,y
	sta lR23
	lda $0001,b,y
	sta lR23+1
	jsl rlUnknown80B25E

	+
	ply
	plp
	plb
	rtl

rlUnknown80B25E ; 80/B25E

	.autsiz
	.databank ?

	sep #$20
	lda lR23+2
	pha
	rep #$20
	plb
	jmp [lR23]

rlUnknown80B269 ; 80/B269

	.al
	.xl
	.autsiz
	.databank ?

	ora #$0000
	beq +

	phx
	dec a
	asl a
	tax
	lda aUnknown80B278,x
	plx

	+
	rtl

aUnknown80B278 ; 80/B278

.for i=1, i<=100, i+=1

	.word (256.0 / 100.0) * i

.next
