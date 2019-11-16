
rlSoundSystemSetup ; 80/8BD0

	.autsiz
	.databank ?

	; Sets up the sound system.
	; You shouldn't call this yourself.

	; Inputs:
	; None

	; Outputs:
	; None

	php
	phb
	phk
	plb

	.databank `*

	rep #$30
	phx
	phy

	lda lR37
	pha
	lda lR37+1
	pha
	lda lR38
	pha
	lda lR38+1
	pha

	; Clear area used by sound system

	ldx #size(aSoundSystemSpace) - 2
	lda #$0000

	-
	sta aSoundSystemSpace,b,x
	dec x
	dec x
	bpl -

	; Store a pointer to the start of
	; sound system data 

	lda #(`$DB8000)<<8
	sta wSoundSystemBank,b
	lda #<>$DB8000
	sta wSoundSystemOffset,b

	; The adc thing ahead gets undone
	; by the stz, so really we're just
	; storing the bank byte to the uppermost
	; byte of lR37

	lda $DB8000
	tay
	lda $DB8000+1
	clc
	adc wSoundSystemBank,b
	sta lR37+1
	stz lR37

	sep #$20
	lda #$FE
	sta wUnknown0004F4,b
	jsl rlSoundSystemInitialUploader



	sep #$20
	stz wUnknown0004F4+1,b
	lda #$FD
	sta wUnknown0004F4,b
	rep #$20
	lda wSoundSystemBank,b
	sta lR38+1
	lda $DB800E
	sta lR38
	lda [lR38]
	sta lR38

	jsl rlUnknown808ED7

	pla
	sta lR38+1
	pla
	sta lR38
	pla
	sta lR37+1
	pla
	sta lR37
	ply
	plx
	plb
	plp
	rtl

rlUnknown808C49 ; 80/8C49

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$30
	phx
	pha
	and #$00FF
	cmp #$00C8
	bcc rlUnknown808C87._8CA0

	cmp #$00E0
	bcs rlUnknown808C87._8CA0

	sep #$20
	stz wUnknown0004EA+1,b
	cmp #$CE
	bcs +
	cmp #$CB
	bcc +
	sta wUnknown0004EA+1,b

	+
	rep #$20
	lda wUnknown0004EA,b
	and #$0010
	beq rlUnknown808C87._8CA0

	pla
	plx
	plb
	plp
	rtl

rlUnknown808C7D ; 80/8C7D

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$30
	phx
	pha
	bra rlUnknown808C87._8CA0

rlUnknown808C87 ; 80/8C87

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$30
	phx
	tax
	lda wUnknown0004F4,b
	and #$00FF
	bne _8CB3

	lda wUnknown0004EA,b
	and #$0001
	bne _8CB3

	phx

	_8CA0
	ldx #$0000

	-
	lda aUnknown0004D6+2,b,x
	beq +

	inx
	inx
	cpx #$0006
	bcc -

	+
	pla
	sta aUnknown0004D6+2,b,x

	_8CB3
	plx
	plb
	plp
	rtl

rlUnknown808CB7 ; 80/8CB7

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$30

	phx
	tax
	lda wUnknown0004F4,b
	and #$00FF
	beq rlUnknown808CDD._8CED

	cpx aUnknown0004E0+2,b
	beq rlUnknown808CDD._8D09

	cpx aUnknown0004E0+4,b
	beq rlUnknown808CDD._8D09

	cpx aUnknown0004E0+6,b
	beq rlUnknown808CDD._8D09

	cpx aUnknown0004E0+8,b
	beq rlUnknown808CDD._8D09

	bra rlUnknown808CDD._8CED

rlUnknown808CDD ; 80/8CDD

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$30
	phx
	tax
	lda wUnknown0004F4,b
	and #$00FF
	bne _8D09

	_8CED
	lda wUnknown0004EA,b
	and #$0004
	bne _8D09

	phx
	ldx #$0000

	-
	lda aUnknown0004E0+2,b,x
	beq +
	inc x
	inc x
	cpx #$0006
	bcc -

	+
	pla
	sta aUnknown0004E0+2,b,x

	_8D09
	plx
	plb
	plp
	rtl

rlUnknown808D0D ; 80/8D0D

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$20
	lda wUnknown0004F6,b
	and #$0002
	bne +

	lda wUnknown0004EA+1,b
	and #$00FF
	beq +

	jsl rlUnknown808C49

	+
	plb
	plp
	rtl

rlUnknown808D2A ; 80/8D2A

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$20
	lda wUnknown0004F6,b
	and #$0002
	beq +

	lda #$00F8
	jsl rlUnknown808C7D

	+
	plb
	plp
	rtl

rlUnknown808D42 ; 80/8D42

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$20
	lda wUnknown0004F6,b
	and #$0080
	beq +

	lda #$00F3
	jsl rlUnknown808C7D

	+
	plb
	plp
	rtl

rlUnknown808D5A ; 80/8D5A

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$20
	lda wUnknown0004F6,b
	and #$0080
	bne +

	lda #$00F2
	jsl rlUnknown808C7D

	+
	plb
	plp
	rtl

rlUnknown808D72 ; 80/8D72

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$20
	stz aUnknown0004D6+2,b
	stz aUnknown0004D6+4,b
	stz aUnknown0004D6+6,b
	stz aUnknown0004D6+8,b
	plb
	plp
	rtl

rlUnknown808D87 ; 80/8D87

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$20
	stz aUnknown0004E0+2,b
	stz aUnknown0004E0+4,b
	stz aUnknown0004E0+6,b
	stz aUnknown0004E0+8,b
	plb
	plp
	rtl

rlUnknown808D9C ; 80/8D9C

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	sep #$10
	rep #$20
	ldy wUnknown0004F4,b
	bne _End

	-
	ldx APU01,b
	cpx APU01,b
	bne -

	stx wUnknown000506,b

	-
	ldx APU00,b
	cpx APU00,b
	bne -

	cpx aUnknown0004D6,b
	bne +

	lda aUnknown0004D6+2,b
	sta aUnknown0004D6,b
	lda aUnknown0004D6+4,b
	sta aUnknown0004D6+2,b
	lda aUnknown0004D6+6,b
	sta aUnknown0004D6+4,b
	lda aUnknown0004D6+8,b
	sta aUnknown0004D6+6,b
	stz aUnknown0004D6+8,b

	+
	ldx aUnknown0004D6,b
	ldy aUnknown0004D6+1,b
	stx APU00,b
	sty APU01,b

	-
	ldx APU03,b
	cpx APU03,b
	bne -

	stx wUnknown0004F6,b

	-
	ldx APU02,b
	cpx APU02,b
	bne -

	cpx aUnknown0004E0,b
	bne +

	lda aUnknown0004E0+2,b
	sta aUnknown0004E0,b
	lda aUnknown0004E0+4,b
	sta aUnknown0004E0+2,b
	lda aUnknown0004E0+6,b
	sta aUnknown0004E0+4,b
	lda aUnknown0004E0+8,b
	sta aUnknown0004E0+6,b
	stz aUnknown0004E0+8,b

	+
	ldx aUnknown0004E0,b
	ldy aUnknown0004E0+1,b
	stx APU02,b
	sty APU03,b

	_End
	plb
	plp
	rtl

rlSoundSystemInitialUploader ; 80/8E2A

	.autsiz
	.databank ?

	; Uploads the sound code to the APU.
	; You shouldn't call this yourself.

	; Inputs:
	; None

	; Outputs:
	; None

	php
	phb
	phk
	plb

	.databank `*

	sep #$20
	rep #$10

	-

	; Read chip status

	lda APU00,b
	sta bUnknown000517,b
	lda APU01,b
	sta wUnknown000518,b
	lda #$CC
	ldx #$BBAA

	; chip should send $BBAA
	; when ready

	cpx bUnknown000517,b
	beq rlTransferSoundSystemByBlock._GetBlockInfo

	; Otherwise we wait

	lda wUnknown0004F4,b
	sta APU00,b
	bra -

rsGetSoundSystemByte ; 80/8E50

	.as
	.autsiz
	.databank `rlSoundSystemInitialUploader

	; Get sound system byte

	lda [lR37],y
	inc y

	; Increment bank and reset offset
	; if we reach a bank boundary

	bne +
	inc lR37+2
	ldy #$8000

	+
	rts

rlTransferSoundSystemByBlock ; 80/8E5B

	.autsiz
	.databank `rlSoundSystemInitialUploader

	; Get first byte of block

	jsr rsGetSoundSystemByte
	xba

	; Start index = 0

	lda #$00
	bra _TransferByte

	-
	xba
	jsr rsGetSoundSystemByte
	xba

	; Wait for transfer
	; then inc index

	-
	cmp APU00,b
	bne -
	inc a

	_TransferByte

	; Store byte and index
	; and dec block size counter

	xba
	sta APU01,b
	xba
	sta APU00,b
	dec x
	bne --

	; wait for last transfer

	-
	cmp APU00,b
	bne -

	; next kick must be (index+2 AND $FF) | 1

	-
	adc #$03
	beq -

	_GetBlockInfo
	pha

	; Get block size

	jsr rsGetSoundSystemByte
	xba
	jsr rsGetSoundSystemByte
	xba
	rep #$20
	tax
	sep #$20

	; Get offset to write to

	jsr rsGetSoundSystemByte
	sta APU02,b
	jsr rsGetSoundSystemByte
	sta APU03,b

	cpx #$0001
	lda #$00
	rol a
	sta APU01,b
	adc #$7F ; set V if more to transfer
	pla
	sta APU00,b

	; Wait for transfer

	-
	cmp APU00,b
	bne -

	bvs rlTransferSoundSystemByBlock
	stz wUnknown0004F4,b
	sep #$10
	rep #$20

	-
	ldx APU00,b
	cpx APU00,b
	bne -

	; chip status?

	stx bUnknown000517,b

	-
	ldx APU01,b
	cpx APU01,b
	bne -

	stx wUnknown000518,b

	; Wait until status is 0000?

	lda bUnknown000517,b
	bne --

	plb
	plp
	rtl

rlUnknown808ED7 ; 80/8ED7

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	sep #$30
	lda wUnknown0004F4,b
	stz APU01,b
	sta APU00,b
	sep #$10
	rep #$20
	ldx #$00
	stx bUnknown0004FD,b
	ldx wUnknown0004F4+1,b
	beq +

	jsl rlDisableVBlank

	+
	ldx wUnknown0004F4,b
	bra _8F2E

	_8EFD
	pea #<>_8F14-1
	inc y
	inc y

	_8F02
	lda [lR37]
	inc lR37
	inc lR37
	bne +

	pha
	lda #$8000
	sta lR37
	pla
	inc lR37+2

	+
	rts

	_8F14
	cpx APU00,b
	bne _8F14

	sep #$20
	sta APU02,b
	xba
	sta APU03,b
	rep #$20
	sty APU00,b
	inc x
	inc x

	_8F29
	dec wUnknown0004F0,b
	bne _8EFD

	_8F2E
	phx

	_8F2F
	lda [lR38]
	beq _8FB2

	cmp #$0064
	bcs +

	jsr rsUnknown809115
	ldx bUnknown0004FD,b
	bne ++

	+
	inc lR38
	inc lR38

	+
	sta wUnknown0004F0,b
	xba
	sep #$20
	and #$F0
	beq +

	lsr a
	lsr a
	lsr a
	tax
	jsr (_9023,x)

	+
	rep #$20
	lda wUnknown0004F0,b
	beq _8F2F
	phb
	ldx wSoundSystemBank+1,b
	phx
	plb
	rep #$10
	and #$07FF
	sec
	sbc #$0064
	asl a
	asl a
	asl a
	clc
	adc $DB800C
	tax
	lda $0007,b,x
	lsr a
	bcc +

	jsr rsUnknown809092
	bra _8F99

	+
	lda $0002,b,x
	xba
	clc
	adc @l wSoundSystemBank
	sta lR37+1
	lda $0000,b,x
	sta lR37
	ldy $0005,b,x
	bne _8F99
	lda @l wUnknown0004F2
	tay

	_8F99
	lda $0003,b,x
	pha
	inc a
	lsr a
	sta @l wUnknown0004F0
	pla
	plb
	sty wUnknown0004F2,b
	clc
	adc wUnknown0004F2,b
	sta wUnknown0004F2,b
	tya
	sep #$10

	_8FB2
	plx
	txy
	inc y
	inc y
	inc y

	-
	inc y
	beq -

	-
	cpx APU00,b
	bne -
	ldx #$00
	cmp #$FFF8
	bne +

	ldx #$01

	+
	sep #$20
	sta APU02,b
	xba
	sta APU03,b
	rep #$20
	sty APU01,b
	sty APU00,b
	cmp #$0000
	beq _900A

	jsr _8F02
	cpx #$00
	beq _8FED

	sep #$20
	sta @l wUnknown000506+1
	rep #$20

	_8FED
	cpy APU00,b
	bne _8FED

	ldy #$02
	ldx #$00
	sep #$20
	sta APU02,b
	xba
	sta APU03,b
	rep #$20
	sty APU00,b
	stx APU01,b
	jmp _8F29

	_900A
	ldx APU01,b
	cpx wUnknown0004F4,b
	beq _900A

	ldx #$00
	stx wUnknown0004F4,b
	ldx wUnknown0004F4+1,b
	beq +

	jsl rlEnableVBlank

	+
	plb
	plp
	rtl

	_9023

	.sint -1
	.addr rsUnknown80905E
	.addr rsUnknown80905E
	.addr rsUnknown80905E
	.addr rsUnknown80905E
	.addr rsUnknown80905E
	.addr rsUnknown80905E
	.addr rsUnknown80905E
	.addr rsUnknown80905E
	.addr rsUnknown809043
	.addr rsUnknown809232
	.addr rsUnknown80907C
	.addr rsUnknown80904E
	.addr rsUnknown80905D
	.addr rsUnknown80905E
	.addr rsUnknown80907C._9084

rsUnknown809043 ; 80/9043

	.as
	.autsiz
	.databank `rlUnknown808ED7

	sep #$20
	stz wUnknown0004EA+1,b
	rep #$20
	stz wUnknown0004F0,b
	rts

rsUnknown80904E ; 80/904E

	.as
	.autsiz
	.databank `rlUnknown808ED7

	rep #$20
	lda [lR38]
	sta wUnknown0004F2,b
	inc lR38
	inc lR38
	stz wUnknown0004F0,b
	rts

rsUnknown80905D ; 80/905D

	.as
	.autsiz
	.databank `rlUnknown808ED7

	rts

rsUnknown80905E ; 80/905E

	.as
	.autsiz
	.databank `rlUnknown808ED7

	rep #$20
	lda wUnknown0004F0,b
	dec lR38
	dec lR38
	asl a
	and #$1FFF
	cmp #$1000
	bcc +

	ora #$F000

	+
	clc
	adc lR38
	sta lR38
	stz wUnknown0004F0,b
	rts

rsUnknown80907C ; 80/907C

	.as
	.autsiz
	.databank `rlUnknown808ED7

	rep #$20
	stz wUnknown000502,b
	stz wUnknown000504,b

	_9084
	sep #$20
	stz wUnknown0004FE,b
	stz wUnknown0004FE+1,b
	rep #$20
	stz wUnknown0004F0,b
	rts

rsUnknown809092 ; 80/9092

	.al
	.autsiz
	.databank `rlUnknown808ED7

	ldy aDecompVariables
	phy
	ldy aDecompVariables+2
	phy
	ldy aDecompVariables+4
	phy
	ldy aDecompVariables+6
	phy
	ldy aDecompVariables+8
	phy
	ldy aDecompVariables+9
	phy
	lsr a
	bcc +

	lda #(`$7E3000)<<8
	sta lDecompDest+1
	sta lR37+1
	lda #<>$7E3000
	sta lDecompDest
	sta lR37
	txa
	cmp @l wUnknown000504
	beq _90FD

	pea #$0001
	bra _90D9

	+
	lda #(`$7E2000)<<8
	sta lDecompDest+1
	sta lR37+1
	lda #<>$7E2000
	sta lDecompDest
	sta lR37
	txa
	cmp @l wUnknown000502
	beq _90FD

	pea #$0000

	_90D9
	lda $0002,b,x
	xba
	clc
	adc @l wSoundSystemBank
	sta lDecompSource+1
	lda $0000,b,x
	sta lDecompSource
	phx
	jsl rlDecompressor
	plx
	txa
	ply
	beq +

	sta @l wUnknown000504
	bra _90FD

	+
	sta @l wUnknown000502

	_90FD
	rep #$20
	ply
	sty aDecompVariables+9
	ply
	sty aDecompVariables+8
	ply
	sty aDecompVariables+6
	ply
	sty aDecompVariables+4
	ply
	sty aDecompVariables+2
	ply
	sty aDecompVariables
	ldy $0005,b,x
	rts

rsUnknown809115 ; 80/9115

	.al
	.autsiz
	.databank `rlUnknown808ED7

	cmp #$0005
	bcc _9162

	ldx bUnknown0004FD,b
	bne _9136

	sep #$20
	ldy #$00
	cmp #$32
	bcs +

	inc y

	+
	cmp wUnknown0004FE,b,y
	sta wUnknown0004FE,b,y
	bne _9136

	rep #$20
	lda #$0000
	rts

	_9136
	inc x
	phx
	rep #$20
	dec a
	asl a
	clc
	adc $DB8008
	sta lR37
	ldy wSoundSystemBank+1,b
	sty lR37+2
	lda [lR37]

	-
	dec x
	beq +
	inc a
	inc a
	bra -

	+
	sta lR37
	plx
	ldy #$02
	lda [lR37],y
	bne +
	ldx #$00

	+
	lda [lR37]
	stx bUnknown0004FD,b
	rts

	_9162
	cmp #$0003
	bcs _91C7

	ldx wSoundSystemBank+1,b
	stx lR37+2
	rep #$10
	dec a
	asl a
	tax
	lda <>aUnknown8092E8,b,x
	tay
	lda <>aUnknown8092E0,b,x
	tax
	lda $7E41AC,x
	cmp #$FFFF
	bne +

	inc a
	bra ++

	+
	and #$00FF
	clc
	adc $DB8012
	sta lR37
	lda [lR37],y

	+
	sep #$10
	and #$00FF
	bne +

	ldx #$00
	bra _91C3

	+
	dec a
	asl a
	clc
	adc $DB8008
	sta lR37
	lda [lR37]
	sta lR37
	lda bUnknown0004FD,b
	ldx bUnknown0004FD,b
	inc x
	and #$000F
	asl a
	clc
	adc lR37
	sta lR37
	ldy #$02
	lda [lR37],y
	bne +
	ldx #$00

	+
	lda [lR37]

	_91C3
	stx bUnknown0004FD,b
	rts

	_91C7
	ldx wSoundSystemBank+1,b
	stx lR37+2
	pha
	rep #$10
	cmp #$0004
	bne +

	lda wUnknown00050E,b
	bra ++

	+
	lda wUnknown00050C,b

	+
	sta wUnknown0004F0,b
	pla
	dec a
	asl a
	tax
	lda <>aUnknown8092E0,b,x
	tax
	ldy #$0154
	lda $7E41AC,x
	and #$007F
	clc
	adc $DB8012
	sta lR37
	lda [lR37],y
	sep #$10
	and #$00FF
	bne +

	ldx #$00
	bra _922E

	+
	dec a
	clc
	adc $DB8014
	adc wUnknown0004F0,b
	sta lR37
	lda [lR37]
	sta lR37
	lda bUnknown0004FD,b
	ldx bUnknown0004FD,b
	inc x
	and #$000F
	asl a
	clc
	adc lR37
	sta lR37
	ldy #$02
	lda [lR37],y
	bne +

	ldx #$00

	+
	lda [lR37]

	_922E
	stx bUnknown0004FD,b
	rts

rsUnknown809232 ; 80/9232

	.autsiz
	.databank ?

	rep #$30
	lda $7E41AD
	and #$0001
	sta wUnknown0004F0,b
	beq +

	lda $7E41C6
	bra ++

	+
	lda $7E4226

	+
	and #$003F
	sta wUnknown00050C,b
	sta wUnknown00050E,b
	lda $7E41AE
	tax
	lda wUnknown0004F0,b
	bne +

	lda $7E41E0
	bra ++

	+
	lda $7E4240

	+
	cmp #$006C
	beq +

	cpx #$0003
	bcc _92BE

	cmp #$006B
	beq +

	cmp #$006F
	beq +

	cmp #$0070
	beq +

	cmp #$0071
	beq +

	cmp #$0077
	beq +

	cmp #$0079
	beq +

	cmp #$005E
	beq +

	cmp #$0061
	beq +

	cmp #$0062
	beq +

	cmp #$0063
	bne _92BE

	+
	lda wUnknown0004F0,b
	bne +

	lda $7E41C6
	and #$003F
	sta wUnknown00050E,b
	bra _92BE

	+
	lda $7E4226
	and #$003F
	sta wUnknown00050C,b

	_92BE
	ldx wUnknown00050C,b
	jsr rsUnknown8092D8
	stx wUnknown00050C,b
	ldx wUnknown00050E,b
	jsr rsUnknown8092D8
	inc x
	inc x
	stx wUnknown00050E,b
	stz wUnknown0004F0,b
	sep #$30
	rts

rsUnknown8092D8 ; 80/92D8

	.al
	.autsiz
	.databank ?

	lda <>aUnknown8092EC,b,x
	and #$001C
	tax
	rts

aUnknown8092E0 ; 80/92E0

	.word $0094
	.word $0034
	.word $0076
	.word $0016

aUnknown8092E8 ; 80/92E8

	.word $0000
	.word $00AA

aUnknown8092EC ; 80/92EC

	.byte $00, $00, $04, $00, $00, $04, $08, $00
	.byte $00, $08, $0C, $00, $00, $0C, $0C, $00
	.byte $10, $00, $00, $00, $00, $00, $00, $0C
	.byte $00, $00, $00, $00, $0C, $0C, $0C, $0C
	.byte $0C, $0C, $0C, $0C, $10, $00, $0C, $08
	.byte $0C, $0C, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00

rlUnknown80932C ; 80/932C

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	sep #$20
	lda wUnknown0004F6+1,b
	clc
	adc #$03
	cmp #$09
	bcc +
	lda #$00

	+
	sta wUnknown0004F6+1,b
	lda wUnknown0004F6,b
	and #$01
	beq _9368

	lda bUnknown000516,b
	bne _936B

	lda #$01
	sta bUnknown000516,b
	rep #$20
	lda #$00D2
	jsl rlUnknown808C7D
	sep #$20
	lda wUnknown000514,b
	beq _9368

	inc a
	sta wUnknown000514,b
	bra _936B

	_9368
	stz bUnknown000516,b

	_936B
	lda wUnknown0004EA,b
	cmp wUnknown0004EC,b
	beq _93B8

	clc
	and #$40
	beq +
	sec

	+
	eor wUnknown0004EC,b
	and #$40
	beq _9394

	lda #$40
	bcc _938D

	tsb wUnknown0004EC,b
	jsl rlUnknown808D5A
	bra _9394

	_938D
	trb wUnknown0004EC,b
	jsl rlUnknown808D42

	_9394
	clc
	lda wUnknown0004EA,b
	and #$10
	beq +

	sec

	+
	eor wUnknown0004EC,b
	and #$10
	beq _93B8

	lda #$10
	bcc +

	tsb wUnknown0004EC,b
	jsl rlUnknown808D2A
	bra _93B8

	+
	trb wUnknown0004EC,b
	jsl rlUnknown808D0D

	_93B8
	rep #$30
	lda aUnknown0004BA,b
	bne +

	sta aUnknown0004C6,b
	bra ++

	+
	ldx #$0000
	jsr rsUnknown809400

	+
	lda aUnknown0004BA+2,b
	bne +

	sta aUnknown0004C6+2,b
	bra ++

	+
	ldx #$0002
	jsr rsUnknown809400

	+
	plb
	plp
	rtl

rlUnknown8093DD ; 80/93DD

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$30
	pha
	phx
	phy
	lda aUnknown0004BA,b
	bne +

	sta aUnknown0004C6,b
	bra ++

	+
	ldx #$0000
	jsr rsUnknown809400
	jsl rlUnknown8096B3

	+
	ply
	plx
	pla
	plb
	plp
	rtl

rsUnknown809400 ; 80/9400

	.al
	.xl
	.autsiz
	.databank ?

	ldy lR37
	phy
	ldy lR37+1
	phy
	ldy wSoundSystemBank,b
	sty lR37+1
	stx wUnknown0004EE,b
	cmp aUnknown0004C6,b,x
	beq _942E

	sta aUnknown0004C6,b,x
	and #$00FF
	dec a
	asl a
	tay
	lda #$0001
	sta aUnknown0004C2,b,x
	lda $DB8004
	sta lR37
	lda [lR37],y
	beq _947B
	bra +

	_942E
	lda aUnknown0004BE,b,x

	+
	tay
	lda aUnknown0004BA,b,x
	and #$8000
	xba
	sep #$20
	sta wUnknown0004F4+1,b
	rep #$20
	dec aUnknown0004C2,b,x
	bne _9474

	stz lR37

	_9447
	lda [lR37],y
	beq _947B

	inc y
	inc y
	sta wUnknown0004F8,b
	and #$FC00
	beq _9462

	xba
	lsr a
	lsr a
	dec a
	asl a
	tax
	lda [lR37],y
	inc y
	inc y
	jsr (aUnknown80948E,x)

	_9462
	lda wUnknown0004F8,b
	and #$03FF
	beq _9447

	ldx wUnknown0004EE,b
	sta aUnknown0004C2,b,x
	tya
	sta aUnknown0004BE,b,x

	_9474
	pla
	sta lR37+1
	pla
	sta lR37
	rts

	_947B
	ldx wUnknown0004EE,b
	pha
	lda aUnknown0004BA,b,x
	sta wUnknown000510,b,x
	pla
	sta aUnknown0004BA,b,x
	sta aUnknown0004C6,b,x
	bra _9474

aUnknown80948E ; 80/948E

	.addr rsUnknown8094B4
	.addr rsUnknown8094B4
	.addr rsUnknown8094B9
	.addr rsUnknown8094B9
	.addr rsUnknown8094E4
	.addr rsUnknown8094BE
	.addr rsUnknown8094E9
	.addr rsUnknown8094FD
	.addr rsUnknown809511
	.addr rsUnknown809525
	.addr rsUnknown80956B
	.addr rsUnknown809594
	.addr rsUnknown8095AB
	.addr rsUnknown8095C2
	.addr rsUnknown8095D9
	.addr rsUnknown8095E7
	.addr rsUnknown8095F7
	.addr rsUnknown80965B

rsUnknown8094B2 ; 80/94B2

	.al
	.xl
	.autsiz
	.databank ?

	nop
	rts

rsUnknown8094B4 ; 80/94B4

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlUnknown808C87
	rts

rsUnknown8094B9 ; 80/94B9

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlUnknown808CDD
	rts

rsUnknown8094BE ; 80/94BE

	.al
	.xl
	.autsiz
	.databank ?

	pha
	ldx wUnknown0004EE,b
	lda aUnknown0004BA,b,x
	cmp #$0100
	bcc _94DE

	and #$0F00
	cmp #$0900
	bcs _94DE

	sta wUnknown0004F0,b
	pla
	and #$80FF
	ora wUnknown0004F0,b
	bra _94DF

	_94DE
	pla

	_94DF
	jsl rlUnknown808C49
	rts

rsUnknown8094E4 ; 80/94E4

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlUnknown808C7D
	rts

rsUnknown8094E9 ; 80/94E9

	.al
	.xl
	.autsiz
	.databank ?

	tax
	lda wUnknown0004F4,b
	and #$00FF
	bne rsUnknown809539

	sep #$20
	lda #$FD
	sta wUnknown0004F4,b
	rep #$20
	bra rsUnknown809544

rsUnknown8094FD ; 80/94FD

	.al
	.xl
	.autsiz
	.databank ?

	tax
	lda wUnknown0004F4,b
	and #$00FF
	bne rsUnknown809539

	sep #$20
	lda #$FC
	sta wUnknown0004F4,b
	rep #$20
	bra rsUnknown809544

rsUnknown809511 ; 80/9511

	.al
	.xl
	.autsiz
	.databank ?

	tax
	lda wUnknown0004F4,b
	and #$00FF
	bne rsUnknown809539

	sep #$20
	lda #$FB
	sta wUnknown0004F4,b
	rep #$20
	bra rsUnknown809544

rsUnknown809525 ; 80/9525

	.al
	.xl
	.autsiz
	.databank ?

	tax
	lda wUnknown0004F4,b
	and #$00FF
	bne rsUnknown809539

	sep #$20
	lda #$FA
	sta wUnknown0004F4,b
	rep #$20
	bra rsUnknown809544

rsUnknown809539 ; 80/9539

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	sta wUnknown0004F8,b
	dec y
	dec y
	dec y
	dec y
	rts

rsUnknown809544 ; 80/9544

	.al
	.xl
	.autsiz
	.databank ?

	txa
	phy
	ldy lR38
	phy
	ldy lR38+1
	phy
	ldy lR37
	phy
	ldy lR37+1
	phy
	ldy wSoundSystemBank,b
	sty lR38+1
	sta lR38
	jsl rlUnknown808ED7
	ply
	sty lR37+1
	ply
	sty lR37
	ply
	sty lR38+1
	ply
	sty lR38
	ply
	rts

rsUnknown80956B ; 80/956B

	.al
	.xl
	.autsiz
	.databank ?

	tax
	lda wUnknown0004F6,b
	and #$0010
	bne _9589

	lda wUnknown0004F4,b
	and #$00FF
	bne _9589

	sep #$20
	lda #$FD

	_9580
	sta bUnknown0004FC,b
	stx wUnknown0004FA,b
	rep #$20
	rts

	_9589

	.al
	.autsiz

	lda #$0001
	sta wUnknown0004F8,b
	dec y
	dec y
	dec y
	dec y
	rts

rsUnknown809594 ; 80/9594

	.al
	.xl
	.autsiz
	.databank ?

	tax
	lda wUnknown0004F6,b
	and #$0010
	bne rsUnknown80956B._9589

	lda wUnknown0004F4,b
	and #$00FF
	bne rsUnknown80956B._9589

	sep #$20
	lda #$FC
	bra rsUnknown80956B._9580

rsUnknown8095AB ; 80/95AB

	.al
	.xl
	.autsiz
	.databank ?

	tax
	lda wUnknown0004F6,b
	and #$0010
	bne rsUnknown80956B._9589

	lda wUnknown0004F4,b
	and #$00FF
	bne rsUnknown80956B._9589

	sep #$20
	lda #$FB
	bra rsUnknown80956B._9580

rsUnknown8095C2 ; 80/95C2

	.al
	.xl
	.autsiz
	.databank ?

	tax
	lda wUnknown0004F6,b
	and #$0010
	bne rsUnknown80956B._9589

	lda wUnknown0004F4,b
	and #$00FF
	bne rsUnknown80956B._9589

	sep #$20
	lda #$FA
	bra rsUnknown80956B._9580

rsUnknown8095D9 ; 80/95D9

	.al
	.xl
	.autsiz
	.databank ?

	php
	sep #$20
	and wUnknown0004F6,b
	bne +

	dec y
	dec y
	dec y
	dec y

	+
	plp
	rts

rsUnknown8095E7 ; 80/95E7

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown0004FA,b
	beq +

	lda #$0001
	sta wUnknown0004F8,b
	dec y
	dec y
	dec y
	dec y

	+
	rts

rsUnknown8095F7 ; 80/95F7

	.al
	.xl
	.autsiz
	.databank ?

	tax
	lda wUnknown000508,b
	bne _9602

	lda wUnknown0004FA,b
	beq _960D

	_9602
	lda #$0001
	sta wUnknown0004F8,b
	dec y
	dec y
	dec y
	dec y
	rts

	_960D
	cpx #$00CB
	bcc +

	cpx #$00CE
	bcc _9621

	+
	txa
	ora wUnknown00050A,b
	stz wUnknown00050A,b
	jmp rsUnknown8094BE

	_9621
	sep #$20
	lda wUnknown000506+1,b
	beq _9650

	cmp wUnknown000506,b
	bne _9650

	rep #$20
	lda wUnknown000500,b
	bne _964B

	txa
	sep #$20
	sta wUnknown0004EA+1,b
	rep #$20
	lda wUnknown000506+1,b
	and #$00FF
	xba
	ora #$00F1
	jsl rlUnknown808C7D
	rts

	_964B
	sep #$20
	stz wUnknown000506+1,b

	_9650
	rep #$20
	stz wUnknown000500,b
	txa
	jsl rlUnknown808C49
	rts

rsUnknown80965B ; 80/965B

	.al
	.xl
	.autsiz
	.databank ?

	rep #$20
	ldx wUnknown0004FA,b
	bne rsUnknown8095F7._9602

	dec a
	bne _9670
	lda $7E41AD
	and #$0001
	bne _967F
	bra _9679

	_9670
	lda $7E41AD
	and #$0001
	beq _967F

	_9679
	lda $7E41C6
	bra _9683

	_967F
	lda $7E4226

	_9683
	and #$003F
	cmp #$0002
	beq _969A

	cmp #$0005
	beq _969A

	cmp #$0017
	beq _969A

	lda #$00C1
	bra _96AE

	_969A
	lda #$8000
	sta wUnknown00050A,b
	lda #$80C2
	bra _96AE

	_96A5
	lda #$8000
	sta wUnknown00050A,b
	lda #$80C3

	_96AE
	jsl rlUnknown808C49
	rts

rlUnknown8096B3 ; 80/96B3

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	sep #$10
	rep #$20
	lda wUnknown0004FA,b
	beq +

	ldx wUnknown0004F4,b
	bne +

	ldx #$00
	stx wUnknown0004F4+1,b
	ldx bUnknown0004FC,b
	stx wUnknown0004F4,b
	rep #$10
	ldx wSoundSystemBank,b
	stx lR38+1
	sta lR38
	jsl rlUnknown808ED7
	stz wUnknown0004FA,b

	+
	plb
	plp
	rtl

rlUnknown8096E3 ; 80/96E3

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	rep #$30
	lda #$00D3
	jsl rlUnknown808C7D
	lda #$0001
	sta wUnknown000500,b
	sep #$20
	stz wUnknown000506+1,b
	plb
	plp
	rtl

rlUnknown8096FE ; 80/96FE

	.autsiz
	.databank ?

	php
	phb
	phk
	plb

	.databank `*

	sep #$20
	lda aUnknown0004CA,b,x
	beq _9750

	cmp aUnknown0004D0,b,x
	beq _9728

	cmp #$10
	bne _9717

	stz aUnknown0004CA,b,x
	bra _9741

	_9717
	sta aUnknown0004D0,b,x
	xba
	lda aUnknown0004CA+1,b,x
	lsr a
	lsr a
	lsr a
	cmp #$10
	bcs _973D

	inc a
	bra _973D

	_9728
	cpx wUnknown0004F6+1,b
	bne _9750

	lda #$01
	xba
	lda aUnknown0004CA+1,b,x
	lsr a
	lsr a
	lsr a
	cmp #$10
	bcs _973B

	inc a

	_973B
	ora #$80

	_973D
	ora aUnknown0004CA+2,b,x
	xba

	_9741
	rep #$20
	cpx #$0000
	beq _974C

	clc
	adc #$0010

	_974C
	jsl rlUnknown808CB7

	_9750
	plb
	plp
	rtl
