
rlUnknownDMAByPushedPointer ; 80/842C

	.autsiz
	.databank ?

	; DMA using a pointer on the stack.

	; Inputs:
	; pushed long pointer to DMA
	; info before jsl

	; Outputs:
	; None

	php
	phb
	sep #$20

	; Get bank of DMA info

	lda #$05,s
	pha
	plb
	rep #$30

	; Offset of DMA info

	lda #$03,s
	tax

	; Get channels to use

	lda $0001,b,x
	and #$00FF
	sta wR34
	sta wR35
	inc x
	ldy #$0000

	; For each channel, set info if channel is used

	-
	lsr wR34 ; check if nothing to be done for channel
	bcc +
	lda $0001,b,x
	sta DMAP0,b,y
	lda $0003,b,x
	sta A1T0,b,y
	lda $0005,b,x
	sta A1T0+2,b,y
	lda $0006,b,x
	sta DAS0,b,y
	txa
	clc
	adc #$0007 ; next entry in info struct
	tax

	+
	tya
	clc
	adc #$0010 ; Move to next set of registers
	tay
	cpy #$0080 ; Loop until all possible channels
	bne -
	txa
	sta #$03,s ; Store over old info offset
	sep #$20
	lda wR35
	sta MDMAEN,b ; Commence writes
	plb
	plp
	rtl
