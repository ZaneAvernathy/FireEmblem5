
rlBlockCopy ; 80/B340

	.al
	.xl
	.autsiz
	.databank ?

	; Copies data from one place to another.

	; Inputs:
	; lR18: Source
	; lR19: Destination
	; wR20: Count

	; Outputs:
	; None

	; Y used as counter

	phb
	php
	phk
	plb

	.databank `*

	phx
	phy

	; If nothing to copy, end

	ldy wR20
	beq _End

	; Else check if we have an odd number of
	; bytes to copy, as we want to copy in units
	; of two bytes

	tya
	bit #$0001
	beq _Next

	; Copy a single byte

	dec y
	sep #$20
	lda [lR18],y
	sta [lR19],y
	rep #$20
	bra _Next

	; Copy word by word

	_Loop

	; Copy a word

	lda [lR18],y
	sta [lR19],y

	_Next
	dec y
	dec y
	bne _Loop

	; Copy the last word

	lda [lR18],y
	sta [lR19],y

	_End
	ply
	plx
	plp
	plb
	rtl

rlBlockFillWord ; 80/B36C

	.al
	.xl
	.autsiz
	.databank ?

	; Fills space with a repeated value.

	; Inputs:
	; A: Fill value
	; lR18: Destination
	; wR19: Count

	phb
	php
	phk
	plb

	.databank `*

	phx
	phy
	tax

	; Y used as counter

	; If count = 0, end

	ldy wR19
	beq _End

	; Else check if we have an odd number of
	; bytes to copy, as we want to copy in units
	; of two bytes

	tya
	bit #$0001
	bne _Odd

	txa
	bra _Next

	; Copy a single byte

	_Odd
	txa
	dec y
	sep #$20
	sta [lR18],y
	rep #$20
	bra _Next

	_Loop
	sta [lR18],y

	_Next
	dec y
	dec y
	bne _Loop

	sta [lR18],y

	_End
	ply
	plx
	plp
	plb
	rtl

rlBlockANDWord ; 80/B397

	.al
	.xl
	.autsiz
	.databank ?

	; ANDs a block of memory with a value.

	; Inputs:
	; A: AND value
	; lR18: Destination
	; wR19: Count

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	phx
	phy
	ldy wR0
	phy

	; Use wR0 to keep AND value

	sta wR0

	; Same deal as above but we're
	; grabbing data from the destination,
	; ANDing it with the value, and then storing
	; it back.

	ldy wR19
	beq _End

	tya
	bit #$0001
	beq _Next

	dec y
	sep #$20
	lda [lR18],y
	and wR0
	sta [lR18],y
	rep #$20
	bra _Next

	_Loop
	lda [lR18],y
	and wR0
	sta [lR18],y

	_Next
	dec y
	dec y
	bne _Loop

	lda [lR18],y
	and wR0
	sta [lR18],y

	_End
	ply
	sty wR0
	ply
	plx
	plp
	plb
	rtl

rlBlockORRWord ; 80/B3D1

	.al
	.xl
	.autsiz
	.databank ?

	; Same as abve but with ORR instead of AND

	; Inputs:
	; A: ORR value
	; lR18: Destination
	; wR19: Count

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	phx
	phy
	ldy wR0
	phy
	sta wR0
	ldy wR19
	beq _End

	tya
	bit #$0001
	beq _Next

	dec y
	sep #$20
	lda [lR18],y
	ora wR0
	sta [lR18],y
	rep #$20
	bra _Next

	_Loop
	lda [lR18],y
	ora wR0
	sta [lR18],y

	_Next
	dec y
	dec y
	bne _Loop

	lda [lR18],y
	ora wR0
	sta [lR18],y

	_End
	ply
	sty wR0
	ply
	plx
	plp
	plb
	rtl

rlBlockAddWord ; 80/B40B

	.al
	.xl
	.autsiz
	.databank ?

	; Same as abve but we're adding a value

	; Inputs:
	; A: added value
	; lR18: Destination
	; wR19: Count

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	phx
	phy
	ldy wR0
	phy
	sta wR0
	ldy wR19
	beq _End

	tya
	bit #$0001
	beq _Next

	dec y
	sep #$20
	lda [lR18],y
	clc
	adc wR0
	sta [lR18],y
	rep #$20
	bra _Next

	_Loop
	lda [lR18],y
	clc
	adc wR0
	sta [lR18],y

	_Next
	dec y
	dec y
	bne _Loop

	lda [lR18],y
	clc
	adc wR0
	sta [lR18],y

	_End
	ply
	sty wR0
	ply
	plx
	plp
	plb
	rtl

rlUnknown80B448 ; 80/B448

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy
	ldy wR6
	phy
	ldy wR7
	phy

	sep #$20
	sta wR7
	xba
	sta wR6

	ldy #$0000
	lda [lR18],y
	cmp wR7
	beq +

	inc a
	bra ++

	+
	lda wR6

	+
	sta [lR18],y

	ply
	sty wR7
	ply
	sty wR6
	ply
	plp
	rtl

rlUnknown80B470 ; 80/B470

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy
	ldy wR6
	phy
	ldy wR7
	phy

	sep #$20
	sta wR7
	xba
	sta wR6

	ldy #$0000
	lda [lR18],y
	cmp wR6
	beq +

	dec a
	bra ++

	+
	lda wR7

	+
	sta [lR18],y

	ply
	sty wR7
	ply
	sty wR6
	ply
	plp
	rtl

rlUnknown80B498 ; 80/B498

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php
	phk
	plb

	.databank `*

	phx
	phy
	sta wR0

	lda wR20
	xba
	and #$00FF
	tay

	-
	phy
	tya
	dec a
	xba
	clc
	adc wR19
	jsl rlUnknown80B4DD
	lda wR20
	and #$00FF
	tax
	lda wR0

	-
	sta [lR18],y
	inc y
	inc y
	dec x
	bne -

	ply
	dec y
	bne --

	ply
	plx
	plp
	plb
	rtl

rlUnknown80B4CA ; 80/B4CA

	.al
	.xl
	.autsiz
	.databank ?

	pha
	and #$FF00
	lsr a
	lsr a
	lsr a
	sta wR0
	pla
	and #$00FF
	clc
	adc wR0
	asl a
	tay
	rtl

rlUnknown80B4DD ; 80/B4DD

	.al
	.xl
	.autsiz
	.databank ?

	pha
	and #$FF00
	lsr a
	lsr a
	lsr a
	sta wR0
	pla
	and #$00FF
	clc
	adc wR0
	asl a
	tay
	rtl

rlBlockCopyMVNByRAM ; 80/B4F0

	.al
	.xl
	.autsiz
	.databank ?

	; Copies memory using a routine written
	; to RAM.

	; Inputs:
	; lBlockCopySource: Source
	; lBlockCopyDest: Destination
	; wBlockCopySize: Count

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	phx
	phy
	sep #$20
	lda lBlockCopyDest+2,b
	sta bBlockCopyMVNDestBank,b
	lda lBlockCopySource+2,b
	sta bBlockCopyMVNSourceBank,b
	lda #rsBlockCopyMVNRoutine[0]
	sta bBlockCopyMVNOpcode,b
	lda #rsBlockCopyMVNRoutine[3]
	sta bBlockCopyMVNRetOpcode,b
	rep #$20
	ldx lBlockCopySource,b
	ldy lBlockCopyDest,b
	lda wBlockCopySize,b
	dec a
	jsr <>rsBlockCopyMVNRAM,k
	ply
	plx
	plp
	plb
	rtl

rlBlockCopyMVPByRAM ; 80/B522

	.al
	.xl
	.autsiz
	.databank ?

	; Copies memory using a routine written
	; to RAM.

	; Inputs:
	; lBlockCopySource: Source
	; lBlockCopyDest: Destination
	; wBlockCopySize: Count

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	phx
	phy
	sep #$20
	lda lBlockCopyDest+2,b
	sta bBlockCopyMVPDestBank,b
	lda lBlockCopySource+2,b
	sta bBlockCopyMVPSourceBank,b
	lda #rsBlockCopyMVPRoutine[0]
	sta bBlockCopyMVPOpcode,b
	lda #rsBlockCopyMVPRoutine[3]
	sta bBlockCopyMVPRetOpcode,b
	rep #$20
	ldx lBlockCopySource,b
	ldy lBlockCopyDest,b
	lda wBlockCopySize,b
	dec a
	jsr <>rsBlockCopyMVPRAM,k
	ply
	plx
	plp
	plb
	rtl
