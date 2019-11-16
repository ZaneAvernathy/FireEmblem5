
procUnknown81BAC5 .dstruct structProcInfo, None, rlProcUnknown81BAC5Init, rlProcUnknown81BAC5OnCycle, None ; 81/BAC5

rlProcUnknown81BAC5Init ; 81/BACD

	.al
	.xl
	.autsiz
	.databank ?

	lda wProcInput0,b
	sta aProcBody0,b,x
	rtl

rlProcUnknown81BAC5OnCycle ; 81/BAD4

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlProcUnknown81BAC5OnCycle2
	sta aProcHeaderOnCycle,b,x
	rtl

rlProcUnknown81BAC5OnCycle2 ; 81/BADB

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`$7E4F96
	pha
	rep #$20
	plb

	.databank `$7E4F96

	phx
	lda aProcBody0,b,x
	tay
	lda structCharacterDataRAM.X,b,y
	and #$00FF
	sta wR0
	lda structCharacterDataRAM.Y,b,y
	and #$00FF
	sta wR1
	jsl $83C181

	lda wCursorXCoord,b
	sta wR0
	lda wCursorYCoord,b
	sta wR1
	jsl rlUnknown81B4ED

	lda #$0008
	jsl rlUnknown808C87

	plx
	jsl rlProcEngineFreeProc

	lda #$0003
	sta wUnknown000302,b
	plb
	plp
	rtl
