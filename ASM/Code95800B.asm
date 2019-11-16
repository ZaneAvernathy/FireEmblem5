
rlUnknown95800B ; 95/800B

	.al
	.autsiz
	.databank ?

	phb
	php
	phk
	plb
	phx
	phy
	lda #$0000
	sta wUnknown0017E9,b
	sta wUnknown0017EB,b
	sta wUnknown0017EF,b
	sta wUnknown0017F1,b
	sta wUnknown0017F3,b
	sta wUnknown001806,b
	sta $7E458E
	sta $7E4590
	sta $7E4592

	jsl $959106

	sep #$20
	stz bUnknown0017F9,b
	stz wUnknown001800,b
	rep #$20

	lda #$0000
	sta wUnknown001808,b
	stz wUnknown0017F5,b
	stz wUnknown0017FC,b
	stz wUnknown0017FE,b

	lda #$000A
	sta wUnknown0017F7,b

	lda #$2000
	sta wUnknown001804,b

	lda #$02D0
	sta wUnknown001802,b

	jsr $958919

	lda #(`$959668)<<8
	sta lUnknown7E45B5+1
	lda #<>$959668
	sta lUnknown7E45B5

	; Pointer to dialogue font image

	lda #(`$E88000)<<8
	sta lUnknown7E45AF+1
	lda #<>$E88000
	sta lUnknown7E45AF

	lda #(`$959A50)<<8
	sta lUnknown7E45B2+1
	lda #<>$959A50
	sta lUnknown7E45B2

	lda #$5000
	sta wUnknown7E45B8

	lda #$5C00
	sta wUnknown7E45BF

	lda #$6200
	sta wUnknown7E45D8

	ldx #$0000
	lda #<>aBG3TilemapBuffer + (((2 * $20) + 3) * 2)
	jsr rsUnknown9580BA

	ldx #$0019
	lda #$EC42
	jsr rsUnknown9580BA

	ply
	plx
	plp
	plb
	rtl

rsUnknown9580BA ; 95/80BA

	.al
	.autsiz
	.databank ?

	pha
	lda #(`aBG3TilemapBuffer)<<8
	sta lUnknownDialogueTextTilemapBufferPosition+1,x
	pla
	sta lUnknownDialogueTextTilemapBufferPosition,x
	lda #$2020
	sta $7E45C3,x
	jsl $9580D3
	rts









