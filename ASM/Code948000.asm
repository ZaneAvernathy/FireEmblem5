
rlDrawMapSpellAnimation ; 94/8000

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	stz wUnknown001611,b

	; Get map spell animation projectile

	lda wUnknown0015A5,b
	jsl $8E8725
	cmp #$00FF
	beq +

	jmp _ProjectileByIndex

	+

	; Else projectile by proc

	lda wUnknown0015A5,b
	asl a
	clc
	adc wUnknown0015A5,b
	tax
	lda $9098FF,x
	sta lR43
	lda $9098FF+1,x
	sta lR43+1
	jsl rlProcEngineCreateProc

	lda #(`$84CFF8)<<8
	sta lR43+1
	lda #<>$84CFF8
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	lda wUnknown001594,b
	sta wR0

	lda #(`$8E925A)<<8
	sta lR43+1
	lda #<>$8E925A
	sta lR43
	jsl rlHDMAArrayEngineCreateEntry

	+
	lda #(`$97D9B2)<<8
	sta lR43+1
	lda #<>$97D9B2
	sta lR43
	jsl rlHDMAArrayEngineCreateEntry

	lda #(`$97D9EB)<<8
	sta lR43+1
	lda #<>$97D9EB
	sta lR43
	jsl rlHDMAArrayEngineCreateEntry

	lda wUnknown001594,b
	sta wR0

	lda #(`$8E9350)<<8
	sta lR43+1
	lda #<>$8E9350
	sta lR43
	jsl rlHDMAArrayEngineCreateEntry

	lda wHDMAArrayIndex,b
	sta wUnknown001598,b
	bra _End

	_ProjectileByIndex
	sta $7FB085
	jsr $948097
	jsl $978F29

	_End
	plp
	plb
	rtl









