
procUnknown81F12C .dstruct structProcInfo, None, rlProcUnknown81F12CInit, rlProcUnknown81F12COnCycle, None ; 81/F12C

rlProcUnknown81F12CInit ; 81/F134

	.al
	.xl
	.autsiz
	.databank ?

	lda #240
	sta wR0
	lda #131
	sta wR1
	jsl $83CB26

	lda #240
	sta wR0
	lda #212
	sta wR1
	jsl $83CB53

	rtl

rlProcUnknown81F12COnCycle ; 81/F151

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`wMenuLineScrollCount
	pha
	rep #$20
	plb

	.databank `wMenuLineScrollCount

	lda wMenuLineScrollCount
	bne +

	lda #$0001
	jsl $83CCE1
	bra ++

	+
	lda #$0000
	jsl $83CCE1

	+
	lda wMenuLineScrollCount
	clc
	adc wMenuBottomThreshold
	cmp wMenuMaximumLine
	beq +

	bcs ++

	+
	lda #$0000
	jsl $83CCF9
	bra ++

	+
	lda #$0001
	jsl $83CCF9

	+
	plb
	plp
	rtl
