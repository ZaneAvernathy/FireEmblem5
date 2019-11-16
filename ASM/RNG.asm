
rlUnknown80B0D1 ; 80/B0D1

	.autsiz
	.databank ?

	phb
	php
	phk
	plb

	.databank `*

	sep #$20
	inc bUnknown000469,b

	lda bUnknown00046A,b
	clc
	adc #$03
	sta bUnknown00046A,b
	plp
	plb
	rtl

rlUnknown80B0E6 ; 80/B0E6

	.al
	.autsiz
	.databank ?

	; (val * RN) / 100

	; Inputs:
	; A: value to multiply

	; Outputs:
	; A: result

	phb
	php
	phk
	plb

	.databank `*

	phx
	phy

	; If 0 chance

	and #$00FF
	beq _End

	sta wR10

	jsl rlGetRandomNumber
	and #$00FF
	beq _End

	sta wR11
	jsl rlUnsignedMultiply16By16


	lda dwR12
	sta wR13

	lda #100
	sta wR14
	jsl rlUnsignedDivide16By8
	lda wR13

	_End
	ply
	plx
	plp
	plb
	rtl

rlGetRandomNumber ; 80/B116

	.autsiz
	.databank ?

	; Grabs a random number.

	; Inputs:
	; None

	; Outputs:
	; A: RN

	phx
	phy
	phb
	php
	phk
	plb

	.databank `*

	lda #$0000
	sep #$30
	inc wNextRNIndex,b
	lda wNextRNIndex,b
	cmp #size(aRNTable)
	blt +

	jsr rsShuffleRNTable
	rep #$30
	lda #$0000
	sep #$30
	sta wNextRNIndex,b

	+
	tay
	lda aRNTable,b,y
	dec a
	bpl +

	lda #99

	+
	plp
	plb
	ply
	plx
	rtl

rlResetRNTable ; 80/B146

	.al
	.autsiz
	.databank ?

	; Regenerates the RN table.

	; Inputs:
	; None

	; Outputs:
	; None

	php
	phb
	phk
	plb

	.databank `*

	stz wNextRNIndex,b
	sep #$30
	lda bUnknown000469,b
	and #$3F
	sta bRNShuffleCounter,b
	sta aRNTable + size(aRNTable) - 1,b

	lda #$01
	sta bRNShuffleValue,b

	ldy #20
	ldx #size(aRNTable) - 1

	-
	lda bRNShuffleValue,b
	sta aRNTable,b,y

	lda bRNShuffleCounter,b
	sec
	sbc bRNShuffleValue,b
	bge +

	clc
	adc #100

	+
	sta bRNShuffleValue,b

	lda aRNTable,b,y
	sta bRNShuffleCounter,b
	tya
	clc
	adc #21
	cmp #size(aRNTable)
	blt +

	sbc #size(aRNTable)

	+
	tay
	dec x
	bne -

	jsr rsShuffleRNTable
	jsr rsShuffleRNTable
	jsr rsShuffleRNTable
	plb
	plp
	rtl

rsShuffleRNTable ; 80/B198

	.as
	.xs
	.autsiz
	.databank ?

	ldy #$00

	-
	tya
	sta bRNShuffleCounter,b
	cmp #24
	bge +

	adc #31
	bcc ++

	+
	sbc #24

	+
	tay
	lda aRNTable,b,y
	sta bRNShuffleValue,b
	ldy bRNShuffleCounter,b
	lda aRNTable,b,y
	sec
	sbc bRNShuffleValue,b
	bge +

	adc #100

	+
	sta aRNTable,b,y
	inc y
	cpy #size(aRNTable)
	bne -

	rts

rsUnknown80B1C6 ; 80/B1C6

	.autsiz
	.databank ?

	rep #$30
	lda #$0000
	lsr a
	lsr a
	sta bRNShuffleCounter,b

	txa
	asl a
	asl a
	asl a
	asl a
	clc
	adc bRNShuffleCounter,b
	sec
	sbc #80
	blt +

	cmp #100
	blt ++

	lda #100
	bra ++

	+
	lda #$0000

	+
	sta bRNShuffleCounter,b

	sep #$30
	ldy #$00
	tyx

	-
	lda aRNTable,b,y
	cmp bRNShuffleCounter,b
	bge +

	txa
	sta aRNTable,b,y

	+
	inc y
	cpy #size(aRNTable)
	bne -

	rep #$30
	rts
