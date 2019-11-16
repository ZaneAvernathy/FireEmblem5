
rlUnknown82A989 ; 82/A989

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	ldx #size(aUnknownArraySpace)-2
	lda #$0000

	-
	sta aUnknownArraySpace,b,x
	dec x
	dec x
	bpl -

	lda #$0010
	sta wUnknown000DC1,b
	plp
	plb
	rtl

rlUnknown82A9A3 ; 82/A9A3

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlUnknown82A9A4 ; 82/A9A4

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
	lda @l lR18
	tay

	sep #$20
	lda @l lR18+2
	pha
	rep #$20
	plb

	.databank ?

	sep #$20
	lda wR1
	beq _End

	sta $0002,b,y

	cmp #$04
	blt +

	dec wR0

	+
	lda wR0
	beq _End

	sta $0001,b,y

	lda #$00
	sta $0000,b,y

	lda wR1
	tax
	cpx #$0004
	bge +

	lda <>aUnknown82A9ED,b,x
	bra ++

	+
	lda #$03

	+
	sta $0003,b,y
	rep #$20

	_End
	ply
	plx
	plp
	plb
	rtl

aUnknown82A9ED ; 82/A9ED
	.byte $00, $00, $01, $02

rlUnknown82A9F1 ; 82/A9F1

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlUnknown82A9F2 ; 82/A9F2

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlUnknown82ACD8
	inc a
	sta wUnknown000DA6
	jsl rlUnknown82AAEB
	lda wUnknown000DA6
	rtl

rlUnknown82AA04 ; 82/AA04

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	sta wUnknown000DA6
	jsl rlUnknown82AAEB
	rtl

rlUnknown82AA10 ; 82/AA10

	.al
	.xl
	.autsiz
	.databank ?

	phb
	phk

	.databank `*

	plb
	jsl rlUnknown82AE38
	sta wUnknown000DA6,b
	jsl rlUnknown82AA20
	plb
	rtl

rlUnknown82AA20 ; 82/AA20

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
	lda lUnknown000DB2,b
	tax

	sep #$20
	lda lUnknown000DB2+2,b
	pha
	rep #$20
	plb

	.databank ?

	lda $0003,b,x
	bit #$0080
	bne _False

	lda $0002,b,x
	and #$00FF
	sta wUnknown000DAA
	sep #$20
	lda wUnknown000DA6
	beq _True

	cmp $0000,b,x
	blt +

	beq ++
	bra _True

	+
	phx
	lda $0000,b,x
	rep #$20
	and #$00FF
	sec
	sbc wUnknown000DA6
	inc a
	jsr rlUnknown82AE90
	sta wUnknown000DAC
	lda wUnknown000DA6
	jsr rlUnknown82AE90
	clc
	adc lUnknown000DB2
	tax
	clc
	adc wUnknown000DAA
	tay

	-
	sep #$20
	lda $0004,b,y
	sta $0004,b,x
	rep #$20
	inc y
	inc x
	lda wUnknown000DAC
	dec a
	sta wUnknown000DAC
	bne -

	plx

	+
	rep #$20
	lda $0000,b,x
	dec a
	sta $0000,b,x

	_False
	ply
	plx
	plp
	plb
	clc
	rtl

	_True
	rep #$20
	ply
	plx
	plp
	plb
	sec
	rtl

rlUnknown82AAAE ; 82/AAAE

	.al
	.xl
	.autsiz
	.databank ?

	phb

	phk
	plb

	.databank `*

	jsl rlUnknown82AE38
	inc a
	sta wUnknown000DA6,b
	pha
	lda aUnknown000DA0+4,b
	sta aUnknown000DA0+1,b
	lda aUnknown000DA0+3,b
	sta aUnknown000DA0,b
	jsl rlUnknown82AAEB
	pla
	plb
	rtl

rlUnknown82AACD ; 82/AACD

	.al
	.xl
	.autsiz
	.databank ?

	phb

	phk
	plb

	.databank `*

	jsl rlUnknown82AE38
	sta wUnknown000DA6,b
	pha
	lda aUnknown000DA0+4,b
	sta aUnknown000DA0+1,b
	lda aUnknown000DA0+3,b
	sta aUnknown000DA0,b
	jsl rlUnknown82AAEB
	pla
	plb
	rtl

rlUnknown82AAEB ; 82/AAEB

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

	lda lUnknown000DB2,b
	tax

	sep #$20
	lda lUnknown000DB2+2,b
	pha
	rep #$20
	plb

	.databank ?

	lda $0003,b,x
	bit #$0080
	bne _False

	lda $0002,b,x
	and #$00FF
	sta wUnknown000DAA
	sep #$20
	lda $0000,b,x
	sta wUnknown000DA8
	cmp $0001,b,x
	bcs _True

	cmp wUnknown000DA6
	bcc +

	phx
	rep #$20
	and #$00FF
	sec
	sbc wUnknown000DA6
	inc a
	inc a
	jsr rlUnknown82AE90
	sta wUnknown000DAC

	lda wUnknown000DA8
	and #$00FF
	jsr rlUnknown82AE90
	clc
	adc lUnknown000DB2
	clc
	adc wUnknown000DAA
	tay
	clc
	adc wUnknown000DAA
	tax
	sep #$20

	-
	lda $0003,b,y
	sta $0003,b,x
	dec y
	dec x
	lda wUnknown000DAC
	dec a
	sta wUnknown000DAC
	bne -

	plx
	bra ++

	+
	inc a
	sta wUnknown000DA6

	+
	rep #$20
	lda wUnknown000DA6
	jsr rsUnknown82AEDF
	lda $0000,b,x
	inc a
	sta $0000,b,x

	_False
	ply
	plx
	plp
	plb
	clc
	rtl

	_True
	rep #$20
	ply
	plx
	plp
	plb
	sec
	rtl

rlUnknown82AB8E ; 82/AB8E

	.al
	.xl
	.autsiz
	.databank ?

	phb

	phk
	plb

	.databank `*

	jsl rlUnknown82AE38
	sta wUnknown000DA6,b
	lda #$0001
	sta wUnknown000DA8,b
	jsl rlUnknown82ABF3
	plb
	rtl

rlUnknown82ABA4 ; 82/ABA4

	.al
	.xl
	.autsiz
	.databank ?

	phb

	phk
	plb

	.databank `*

	jsl rlUnknown82AE38
	sta wUnknown000DA6,b
	jsl rlUnknown82ACD8
	sta wUnknown000DA8,b
	jsl rlUnknown82ABF3
	plb
	rtl

rlUnknown82ABBB ; 82/ABBB

	.al
	.xl
	.autsiz
	.databank ?

	phb

	phk
	plb

	.databank `*

	jsl rlUnknown82AE38
	sta wUnknown000DA6,b
	dec a
	sta wUnknown000DA8,b
	jsl rlUnknown82ABF3
	plb
	rtl

rlUnknown82ABCF ; 82/ABCF

	.al
	.xl
	.autsiz
	.databank ?

	phb

	phk
	plb

	.databank `*

	jsl rlUnknown82AE38
	sta wUnknown000DA6,b
	inc a
	sta wUnknown000DA8,b
	jsl rlUnknown82ABF3
	plb
	rtl

rlUnknown82ABE3 ; 82/ABE3

	.al
	.xl
	.autsiz
	.databank ?

	phb

	phk
	plb

	.databank `*

	jsl rlUnknown82AE38
	sta wUnknown000DA6,b
	jsl rlUnknown82ABF3
	plb
	rtl

rlUnknown82ABF3 ; 82/ABF3

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

	lda wUnknown000DA6,b
	ora wUnknown000DA8,b
	bne +

	jmp _End

	+
	lda wUnknown000DA6,b
	beq _True

	lda wUnknown000DA8,b
	beq _True

	lda lUnknown000DB2
	tay

	sep #$20
	lda lUnknown000DB2+2
	pha
	rep #$20
	plb

	.databank ?

	lda $0000,b,y
	cmp wUnknown000DA6
	bcc _True

	cmp wUnknown000DA8
	bcc _True

	lda $0002,b,y
	and #$00FF
	sta wUnknown000DAA
	lda wUnknown000DA6
	jsr rsUnknown82B084
	lda wUnknown000DA6
	cmp wUnknown000DA8
	bcc ++

	bra +

	_True
	ply
	plx
	plp
	plb
	sec
	rtl

	+
	sec
	sbc wUnknown000DA8
	inc a
	jsr rlUnknown82AE90
	sta wUnknown000DAC
	lda wUnknown000DA6
	and #$00FF
	dec a
	jsr rlUnknown82AE90
	clc
	adc lUnknown000DB2
	clc
	adc wUnknown000DAA
	tay
	clc
	adc wUnknown000DAA
	tax
	sep #$20

	-
	lda $0003,b,y
	sta $0003,b,x
	dec y
	dec x
	lda wUnknown000DAC
	dec a
	sta wUnknown000DAC
	bne -

	rep #$20
	bra ++

	+
	lda wUnknown000DA8
	sec
	sbc wUnknown000DA6
	inc a
	jsr rlUnknown82AE90
	sta wUnknown000DAC,b
	lda wUnknown000DA6
	jsr rlUnknown82AE90
	clc
	adc lUnknown000DB2
	tax
	clc
	adc wUnknown000DAA
	tay
	sep #$20

	-
	lda $0004,b,y
	sta $0004,b,x
	inc y
	inc x
	lda wUnknown000DAC
	dec a
	sta wUnknown000DAC
	bne -

	rep #$20

	+
	lda wUnknown000DA8
	jsr rsUnknown82B0BB

	_End
	ply
	plx
	plp
	plb
	clc
	rtl

rlUnknown82ACD8 ; 82/ACD8

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
	lda lUnknown000DB2
	tay

	sep #$20
	lda lUnknown000DB2+2
	pha
	rep #$20
	plb

	.databank ?

	lda $0000,b,y
	and #$00FF
	ply
	plp
	plb
	rtl

rlUnknown82ACF6 ; 82/ACF6

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
	lda lUnknown000DB2
	tay

	sep #$20
	lda lUnknown000DB2+2
	pha
	rep #$20
	plb

	.databank ?

	lda $0001,b,y
	and #$00FF
	ply
	plp
	plb
	rtl

rlUnknown82AD14 ; 82/AD14

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
	pha

	lda lUnknown000DB2
	tay

	sep #$20
	lda lUnknown000DB2+2
	pha
	rep #$20
	plb

	pla
	sep #$20
	cmp $0000,b,y
	bcc _True

	sta $0001,b,y
	rep #$20
	ply
	plp
	plb
	clc
	rtl

	_True
	ply
	plp
	plb
	sec
	rtl

rlUnknown82AD40 ; 82/AD40

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	sta wUnknown000DA6
	jsl rlUnknown82AD59
	rtl

rlUnknown82AD4C ; 82/AD4C

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlUnknown82ACD8
	sta wUnknown000DA6
	jsl rlUnknown82AD59
	rtl

rlUnknown82AD59 ; 82/AD59

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
	lda lUnknown000DB2
	tay

	sep #$20
	lda lUnknown000DB2+2
	pha
	rep #$20
	plb

	.databank ?

	lda $0000,b,y
	and #$00FF
	cmp wUnknown000DA6
	bcc _True

	lda $0002,b,y
	and #$00FF
	sta wUnknown000DAA

	lda wUnknown000DA6
	jsr rsUnknown82AF64

	ply
	plp
	plb
	clc
	rtl

	_True
	ply
	plp
	plb
	sec
	rtl

rlUnknown82AD94 ; 82/AD94

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	sta wUnknown000DA6
	jsl rlUnknown82ADAD
	rtl

rlUnknown82ADA0 ; 82/ADA0

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlUnknown82ACD8
	sta wUnknown000DA6
	jsl rlUnknown82ADAD
	rtl

rlUnknown82ADAD ; 82/ADAD

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
	lda lUnknown000DB2
	tay

	sep #$20
	lda lUnknown000DB2+2
	pha
	rep #$20
	plb

	.databank ?

	lda $0000,b,y
	and #$00FF
	cmp wUnknown000DA6
	bcc _True

	lda $0002,b,y
	and #$00FF
	sta wUnknown000DAA

	lda lUnknown000DB2+1
	sta aUnknown000DA0+1

	lda wUnknown000DA6
	jsr rlUnknown82AE90
	clc
	adc #$0004
	clc
	adc lUnknown000DB2
	sta aUnknown000DA0
	ply
	plp
	plb
	clc
	rtl

	_True
	ply
	plp
	plb
	sec
	rtl

rlUnknown82ADFD ; 82/ADFD

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

	lda lUnknown000DB2
	tay

	sep #$20
	lda lUnknown000DB2+2
	pha
	rep #$20
	plb

	.databank ?

	lda $0000,b,y
	and #$00FF
	cmp wUnknown000DA6
	bcc _True

	lda $0002,b,y
	and #$00FF
	sta wUnknown000DAA
	lda wUnknown000DA6
	jsr rsUnknown82AEDF
	ply
	plp
	plb
	clc
	rtl

	_True
	ply
	plp
	plb
	sec
	rtl

rlUnknown82AE38 ; 82/AE38

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

	lda lUnknown000DB2
	tay

	sep #$20
	lda lUnknown000DB2+2
	pha
	rep #$20
	plb

	.databank ?

	lda $0000,b,y
	and #$00FF
	beq +

	tax
	lda $0002,b,y
	and #$00FF
	sta wUnknown000DAA
	lda #$0001
	sta wUnknown000DAC

	-
	jsr rsUnknown82AFE9
	beq ++

	tya
	clc
	adc wUnknown000DAA
	tay
	lda wUnknown000DAC
	inc a
	sta wUnknown000DAC
	dec x
	bne -

	+
	ply
	plx
	plp
	plb
	lda #$0000
	rtl

	+
	lda wUnknown000DAC
	ply
	plx
	plp
	plb
	rtl

rlUnknown82AE90 ; 82/AE90

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	dec a
	bmi _End
	beq _End

	cmp #$0004
	bcs _AEBD

	cmp #$0003
	beq _AEB3

	cmp #$0002
	beq _AEAD

	lda wUnknown000DAA,b
	bra _End

	_AEAD
	lda wUnknown000DAA,b
	asl a
	bra _End

	_AEB3
	lda wUnknown000DAA,b
	asl a
	clc
	adc wUnknown000DAA,b
	bra _End

	_AEBD
	phx
	xba
	sta wUnknown000DAE,b
	lda wUnknown000DAA,b
	sta wUnknown000DB0,b
	lda #$0000
	ldx #$0008

	-
	asl a
	asl wUnknown000DAE,b
	bcc +

	clc
	adc wUnknown000DB0,b

	+
	dec x
	bne -

	plx

	_End
	plp
	plb
	rts

rsUnknown82AEDF ; 82/AEDF

	.al
	.xl
	.autsiz
	.databank ?

	php
	phy
	jsr rlUnknown82AE90
	clc
	adc lUnknown000DB2
	tay
	lda wUnknown000DAA
	cmp #$0004
	bcs _AF23

	cmp #$0003
	beq _AF13

	cmp #$0002
	beq _AF0A

	sep #$20
	lda aUnknown000DA0
	sta $0004,b,y
	rep #$20
	bra _End

	_AF0A
	lda aUnknown000DA0
	sta $0004,b,y
	bra _End

	_AF13
	lda aUnknown000DA0
	sta $0004,b,y
	lda aUnknown000DA0+1
	sta $0005,b,y
	bra _End

	_AF23
	lda wUnknown000DAA
	pha
	lda lR37
	pha
	lda lR37+1
	pha
	phx
	lda aUnknown000DA0
	sta lR37
	lda aUnknown000DA0+1
	sta lR37+1
	sep #$20
	tyx
	ldy #$0000

	-
	lda [lR37],y
	sta $0004,b,x
	inc y
	inc x
	lda wUnknown000DAA
	dec a
	sta wUnknown000DAA
	bne -

	rep #$20
	plx
	pla
	sta lR37+1
	pla
	sta lR37
	pla
	sta wUnknown000DAA

	_End
	ply
	plp
	rts

rsUnknown82AF64 ; 82/AF64

	.al
	.xl
	.autsiz
	.databank ?

	php
	phx
	phy
	jsr rlUnknown82AE90
	clc
	adc lUnknown000DB2
	tay
	lda wUnknown000DAA
	cmp #$0004
	bcs _AFA9

	cmp #$0003
	beq _AF99

	cmp #$0002
	beq _AF90

	sep #$20
	lda $0004,b,y
	sta aUnknown000DA0
	rep #$20
	bra _End

	_AF90
	lda $0004,b,y
	sta aUnknown000DA0
	bra _End

	_AF99
	lda $0004,b,y
	sta aUnknown000DA0
	lda $0005,b,y
	sta aUnknown000DA0+1
	bra _End

	_AFA9
	lda wUnknown000DAA
	pha
	lda lR37
	pha
	lda lR37+1
	pha
	lda aUnknown000DA0
	sta lR37
	lda aUnknown000DA0+1
	sta lR37+1
	sep #$20
	tyx
	ldy #$0000

	-
	lda $0004,b,x
	sta [lR37],y
	inc x
	inc y
	lda wUnknown000DAA
	dec a
	sta wUnknown000DAA
	bne -

	rep #$20
	pla
	sta lR37+1
	pla
	sta lR37
	pla
	sta wUnknown000DAA

	_End
	ply
	plx
	plp
	rts

rsUnknown82AFE9 ; 82/AFE9

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown000DAA
	cmp #$0004
	bcs _B029

	cmp #$0003
	beq _B015

	cmp #$0002
	beq _B00A

	lda $0004,b,y
	and #$00FF
	cmp aUnknown000DA0
	beq _Zero

	bra _One

	_B00A
	lda $0004,b,y
	cmp aUnknown000DA0
	beq _Zero
	bra _One

	_B015
	lda $0004,b,y
	cmp aUnknown000DA0
	bne _One
	lda $0005,b,y
	cmp aUnknown000DA0+1
	beq _Zero
	bra _One

	_B029
	phx
	phy
	lda wUnknown000DAA
	pha
	lda lR37
	pha
	lda lR37+1
	pha
	lda aUnknown000DA0
	sta lR37
	lda aUnknown000DA0+1
	sta lR37+1
	sep #$20
	tyx
	ldy #$0000

	-
	lda $0004,b,x
	cmp [lR37],y
	bne _B06D

	inc x
	inc y
	lda wUnknown000DAA
	dec a
	sta wUnknown000DAA
	bne -

	rep #$20
	pla
	sta lR37+1
	pla
	sta lR37
	pla
	sta wUnknown000DAA

	ply
	plx
	bra _Zero

	_B06D
	rep #$20
	pla
	sta lR37+1
	pla
	sta lR37
	pla
	sta wUnknown000DAA
	ply
	plx

	_One
	lda #$0001
	rts

	_Zero
	lda #$0000
	rts

rsUnknown82B084 ; 82/B084

	.al
	.xl
	.autsiz
	.databank ?

	phy
	pha
	lda lUnknown000DB2
	tay
	lda $0002,b,y
	and #$00FF
	cmp #$0004
	bcc +

	lda $0001,b,y
	and #$00FF
	inc a
	jsr rlUnknown82AE90
	clc
	adc lUnknown000DB2
	sta aUnknown000DA0

	sep #$20
	lda lUnknown000DB2+1
	sta aUnknown000DA0+1
	rep #$20

	+
	pla
	jsr rsUnknown82AF64
	ply
	rts

rsUnknown82B0BB ; 82/B0BB

	.al
	.xl
	.autsiz
	.databank ?

	phy
	pha
	lda lUnknown000DB2
	tay
	lda $0002,b,y
	and #$00FF
	cmp #$0004
	bcc +

	lda $0001,b,y
	and #$00FF
	inc a
	jsr rlUnknown82AE90
	clc
	adc lUnknown000DB2
	sta aUnknown000DA0
	sep #$20
	lda lUnknown000DB2+1
	sta aUnknown000DA0+1
	rep #$20

	+
	pla
	jsr rsUnknown82AEDF
	ply
	rts

rlUnknown82B0F2 ; 82/B0F2

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	jsl rlUnknown82B221
	lda @l lR18
	tay
	sep #$20
	lda @l lR18+2
	pha
	rep #$20
	plb

	.databank ?

	lda wR1
	beq +

	and #~$E000
	ora #$8000
	sta $0002,b,y

	+
	lda wR0
	sta $0000,b,y
	inc a
	sta $0004,b,y
	plp
	plb
	rtl

rlUnknown82B122 ; 82/B122

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlUnknown82B123 ; 82/B123

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
	lda wR1
	pha
	lda lUnknown000DB5
	tay

	sep #$20
	lda lUnknown000DB5+2
	pha
	rep #$20
	plb

	.databank ?

	lda $0002,b,y
	bit #$8000
	beq +

	and #~$E000
	sta wR1

	+
	lda $0000,b,y
	cmp wR1
	bcc _True

	tax
	sec
	sbc wR1
	sta $0000,b,y
	txa
	clc
	adc lUnknown000DB5
	tax
	dec x
	ldy wR1
	dec y
	lda lR18
	ora lR18+1
	beq +

	sep #$20

	-
	lda [lR18],y
	sta $0006,b,x
	dec x
	dec y
	bpl -

	rep #$20
	bra ++

	+
	sep #$20
	lda #$00

	-
	sta $0006,b,x
	dec x
	dec y
	bpl -

	rep #$20

	+
	lda lUnknown000DB5
	tay
	lda lUnknown000DB5+1
	sta lR18+1
	lda lUnknown000DB5
	clc
	adc $0000,b,y
	clc
	adc #$0006
	sta lR18
	pla
	sta wR1
	ply
	plx
	plp
	plb
	clc
	rtl

	_True
	pla
	sta wR1
	ply
	plx
	plp
	plb
	sec
	rtl

rlUnknown82B1AE ; 82/B1AE

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
	lda wR1
	pha
	lda lUnknown000DB5
	tay

	sep #$20
	lda lUnknown000DB5+2
	pha
	rep #$20
	plb

	.databank ?

	lda $0002,b,y
	bit #$8000
	beq +

	and #~$E000
	sta wR1

	+
	lda $0000,b,y
	clc
	adc wR1
	cmp $0004,b,y
	bcs _True

	sta $0000,b,y
	clc
	adc lUnknown000DB5
	tax
	dec x
	ldy wR1
	dec y
	lda lR18
	ora lR18+1
	beq +

	sep #$20

	-
	lda $0006,b,x
	sta [lR18],y
	dec x
	dec y
	bpl -

	rep #$20

	+
	pla
	sta wR1
	ply
	plx
	plp
	plb
	clc
	rtl

	_True
	pla
	sta wR1
	ply
	plx
	plp
	plb
	sec
	rtl

rlUnknown82B210 ; 82/B210

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda lUnknown000DB5+1,b
	sta lR18+1
	lda lUnknown000DB5,b
	sta lR18
	plp
	plb
	rtl

rlUnknown82B221 ; 82/B221

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda lR18+1
	sta lUnknown000DB5+1,b
	lda lR18
	sta lUnknown000DB5,b
	plp
	plb
	rtl

rlUnknown82B232 ; 82/B232

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda lUnknown000DB5+1,b
	sta lUnknown000DB8+1,b
	lda lUnknown000DB5,b
	sta lUnknown000DB8,b

	lda lR18+1
	sta lUnknown000DB5+1,b
	lda lR18
	sta lUnknown000DB5,b
	plp
	plb
	rtl

rlUnknown82B24F ; 82/B24F

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda lUnknown000DB8,b
	ora lUnknown000DB8+1,b
	beq +

	lda lUnknown000DB8+1,b
	sta lUnknown000DB5+1,b
	lda lUnknown000DB8,b
	sta lUnknown000DB5,b

	+
	plp
	plb
	rtl

rlUnknown82B26A ; 82/B26A

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	tay
	phy
	lda @l wR0
	pha
	tya
	sta @l wR0
	jsl rlUnknown82B5C2
	lda @l lR18
	tay

	sep #$20
	lda @l lR18+2
	pha
	rep #$20
	plb

	.databank ?

	sep #$20
	lda wUnknown000DA6
	beq +

	lda #$80

	+
	sta $0000,b,y
	bne +

	lda wUnknown000DC1
	bra ++

	+
	lda #$00

	+
	sta $0005,b,y
	rep #$20
	lda @l wR0
	clc
	adc lUnknown000DBB
	sta $0001,b,y
	lda @l wR0
	sec
	sbc #$0008
	sta @l wR0
	sta $0003,b,y
	phy
	tya
	clc
	adc #$0008
	tay
	jsr rsUnknown82B64A
	jsr rsUnknown82B68D
	ply
	jsr rsUnknown82B7C4
	sta $0006,b,y
	pla
	sta @l wR0
	ply
	plp
	plb
	rtl

rlUnknown82B2E1 ; 82/B2E1

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	plp
	plb
	rtl

rlUnknown82B2E8 ; 82/B2E8

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
	tay
	lda @l wR0
	pha
	lda @l wR1
	pha
	lda @l wR2
	pha
	tya
	sta @l wR0
	lda lUnknown000DBB
	ora lUnknown000DBB+1
	bne +

	jmp _B39A

	+
	lda @l wR0
	clc
	adc #$0006
	sta @l wR0
	lda lUnknown000DBB
	tay

	sep #$20
	lda lUnknown000DBB+2
	pha
	rep #$20
	plb

	.databank ?

	jsr rsUnknown82B835
	bcs _B39F

	sta @l wR1
	sep #$20
	lda $0000,b,y
	ora #$20
	sta $0000,b,y
	rep #$20
	jsr rsUnknown82B6A1
	tay
	jsr rsUnknown82B885
	lda $0001,b,y
	sec
	sbc @l wR0
	pha
	jsr rsUnknown82B675
	jsr rsUnknown82B68D
	pla
	pha
	cmp #$0007
	bcs +

	pla
	clc
	adc $0001,b,y
	sta $0001,b,y
	bra ++

	+
	jsr rsUnknown82B6E5
	tay
	jsr rsUnknown82B64A
	pla
	sta $0001,b,y

	+
	phk
	plb

	.databank `*

	lda lUnknown000DBB+1
	sta @l lR25+1
	lda @l wR1
	sta @l lR25
	ldy #$0000

	-
	pla
	sta @l wR2
	pla
	sta @l wR1
	pla
	sta @l wR0
	tya
	ply
	plp
	plb
	rtl

	_B39A
	ldy #+(-1)
	bra -

	_B39F
	ldy #+(-2)
	bra -

rlUnknown82B3A4 ; 82/B3A4

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
	lda @l lR25
	tay

	sep #$20
	lda @l lR25+2
	pha
	rep #$20
	plb

	.databank ?

	tya
	sec
	sbc #$0000
	tay
	lda $0001,b,y
	sta @l lR25+1
	lda $0000,b,y
	sta @l lR25

	jsr rsUnknown82B8A5
	jsr rsUnknown82B6EB
	jsr rsUnknown82B762
	ply
	plp
	plb
	rtl

rlUnknown82B3D9 ; 82/B3D9

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
	tay

	lda @l wR0
	pha
	lda @l wR2
	pha

	tya
	sta @l wR0
	lda lUnknown000DBB
	ora lUnknown000DBB+1
	beq _End

	lda @l wR0
	clc
	adc #$0006
	sta @l wR0
	lda lUnknown000DBB
	tay

	sep #$20
	lda lUnknown000DBB+2
	pha
	rep #$20
	plb

	sep #$20
	lda $0000,b,y
	ora #$20
	sta $0000,b,y
	rep #$20
	jsr rsUnknown82B6A1
	tay
	lda $0001,b,y
	sec
	sbc @l wR0
	sta $0001,b,y
	cmp #$0007
	bcs +

	clc
	adc @l wR0
	sta @l wR0
	bra ++

	+
	jsr rsUnknown82B6E5
	tay

	+
	jsr rsUnknown82B65D
	jsr rsUnknown82B68D

	phk
	plb

	.databank `*

	lda lUnknown000DBB+1
	sta @l lR25+1
	tya
	clc
	adc #$0006
	sta @l lR25

	_End
	ldy #$0000
	pla
	sta @l wR2
	pla
	sta @l wR0
	tya
	ply
	plp
	plb
	rtl

rlUnknown82B36D ; 82/B36D

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	sep #$20
	lda lUnknown000DBB+2
	pha
	rep #$20
	plb

	.databank ?

	jsr rsUnknown82B6EB
	jsr rsUnknown82B762
	plp
	plb
	rtl

rlUnknown82B484 ; 82/B484

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
	dec a
	pha
	clc
	adc $0000,b,x
	pha

	sep #$20
	lda $0002,b,x
	pha
	rep #$20
	plb

	.databank ?

	plx
	ply
	sep #$20

	-
	lda $0000,b,x
	sta [lR25],y
	dec x
	dec y
	bpl -

	rep #$20
	ply
	plx
	plp
	plb
	rtl

rlUnknown82B4AE ; 82/B4AE

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

	dec a
	pha
	clc
	adc $0000,b,x
	pha

	sep #$20
	lda $0002,b,x
	pha
	rep #$20
	plb

	.databank ?

	lda [lR25]
	sta @l lR24
	lda @l lR25
	inc a
	sta @l lR25
	lda [lR25]
	sta @l lR24+1
	lda @l lR25
	dec a
	sta @l lR25
	plx
	ply
	sep #$20

	-
	lda $0000,b,x
	sta [lR24],y
	dec x
	dec y
	bpl -

	rep #$20
	ply
	plx
	plp
	plb
	rtl

rlUnknown82B4F6 ; 82/B4F6

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

	lda @l wR1
	pha
	lda @l wR2
	pha
	lda @l wR3
	pha
	lda @l wR4
	pha

	lda lUnknown000DBB
	tay

	sep #$20
	lda lUnknown000DBB+2
	pha
	rep #$20
	plb

	.databank ?

	sep #$20
	lda $0000,b,y
	ora #$40
	sta $0000,b,y
	rep #$20
	lda $0001,b,y
	sta @l wR2
	tya
	clc
	adc #$0008
	tay

	_Loop
	lda $0000,b,y
	bit #$0080
	beq _Next

	jsr rsUnknown82B6E5
	tax
	lda $0000,b,x
	bit #$0040
	bne _Next

	lda $0003,b,x
	sta @l wR1
	jsr rsUnknown82B885
	lda $0001,b,y
	sta @l wR4
	lda $0001,b,x
	sta @l wR3

	-
	sep #$20
	lda $0000,b,x
	sta $0000,b,y
	rep #$20
	inc x
	inc y
	lda @l wR3
	dec a
	sta @l wR3
	bne -

	jsr rsUnknown82B64A
	lda @l wR4
	sta $0001,b,y
	jsr rsUnknown82B762

	_Next
	jsr rsUnknown82B6E5
	cmp @l wR2
	tay
	bcc _Loop

	pla
	sta @l wR4
	pla
	sta @l wR3
	pla
	sta @l wR2
	pla
	sta @l wR1
	ply
	plx
	plp
	plb
	rtl

rlUnknown82B5AB ; 82/B5AB

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda lUnknown000DBB+1
	sta @l lR18+1
	lda lUnknown000DBB
	sta @l lR18
	plp
	plb
	rtl

rlUnknown82B5C2 ; 82/B5C2

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda @l lR18+1
	sta lUnknown000DBB+1
	lda @l lR18
	sta lUnknown000DBB
	plp
	plb
	rtl

rlUnknown82B5D9 ; 82/B5D9

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda lUnknown000DBB+1
	sta lUnknown000DBE+1
	lda lUnknown000DBB
	sta lUnknown000DBE
	lda @l lR18+1
	sta lUnknown000DBB+1
	lda @l lR18
	sta lUnknown000DBB
	plp
	plb
	rtl

rlUnknown82B600 ; 82/B600

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php

	phk
	plb

	.databank `*

	lda lUnknown000DBE
	ora lUnknown000DBE+1
	beq +

	lda lUnknown000DBE+1
	sta lUnknown000DBB+1
	lda lUnknown000DBE
	sta lUnknown000DBB

	+
	plp
	plb
	rtl

rlUnknown82B621 ; 82/B621

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
	lda lUnknown000DBB
	tay

	sep #$20
	lda lUnknown000DBB+2
	pha
	rep #$20
	plb

	.databank ?

	lda $0000,b,y
	and #$00FF
	pha
	sep #$20
	and #~$80
	sta $0000,b,y
	rep #$20
	pla
	ply
	plp
	plb
	rtl

rsUnknown82B64A ; 82/B64A

	.al
	.xl
	.autsiz
	.databank ?

	sep #$20
	lda #$80
	sta $0000,b,y
	rep #$20
	lda #$0000
	sta $0004,b,y
	sta $0003,b,y
	rts

rsUnknown82B65D ; 82/B65D

	.al
	.xl
	.autsiz
	.databank ?

	sep #$20
	lda #$40
	sta $0000,b,y
	rep #$20
	lda lUnknown000DBB+1
	sta $0004,b,y
	lda lUnknown000DBB
	sta $0003,b,y
	rts

rsUnknown82B675 ; 82/B675

	.al
	.xl
	.autsiz
	.databank ?

	sep #$20
	lda #$00
	sta $0000,b,y
	rep #$20
	lda lUnknown000DBB+1
	sta $0004,b,y
	lda @l wR1
	sta $0003,b,y
	rts

rsUnknown82B68D ; 82/B68D

	.al
	.xl
	.autsiz
	.databank ?

	lda @l wR0
	sta $0001,b,y
	rts

rsUnknown82B695 ; 82/B695

	.al
	.xl
	.autsiz
	.databank ?

	lda @l wR0
	clc
	adc #$0006
	sta $0001,b,y
	rts

rsUnknown82B6A1 ; 82/B6A1

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsUnknown82B6B3
	bcs +

	-
	rts

	+
	jsl rlUnknown82B4F6
	jsr rsUnknown82B6B3
	bcs +

	bra -

	+
	.byte $00

rsUnknown82B6B3 ; 82/B6B3

	.al
	.xl
	.autsiz
	.databank ?

	phy
	lda $0001,b,y
	sta @l wR2
	tya
	clc
	adc #$0008
	tay

	-
	lda $0000,b,y
	bit #$0080
	beq +

	lda $0001,b,y
	cmp @l wR0
	bcs ++

	+
	tya
	clc
	adc $0001,b,y
	cmp @l wR2
	tay
	bcc -

	ply
	sec
	rts

	+
	tya
	ply
	clc
	rts

rsUnknown82B6E5 ; 82/B6E5

	.al
	.xl
	.autsiz
	.databank ?

	tya
	clc
	adc $0001,b,y
	rts

rsUnknown82B6EB ; 82/B6EB

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
	lda @l wR2
	pha
	lda @l lR25
	sec
	sbc #$0006
	sta @l wR2
	lda lUnknown000DBB
	ora lUnknown000DBB+1
	beq +

	sep #$20
	lda lUnknown000DBB+2
	cmp @l lR25+2
	bne +

	rep #$20
	lda @l wR2
	cmp lUnknown000DBB
	bcc +

	lda lUnknown000DBB
	tay
	sep #$20
	lda lUnknown000DBB+2
	pha
	rep #$20
	plb 
	lda $0001,b,y
	dec a
	cmp @l wR2
	bcc +

	lda @l wR2
	tay
	jsr rsUnknown82B64A
	lda lUnknown000DBB
	tay
	sep #$20
	lda $0000,b,y
	ora #$10
	sta $0000,b,y

	+
	rep #$20
	ldy #$0000
	pla
	sta @l wR2
	tya
	ply
	plp
	plb
	rts

rsUnknown82B762 ; 82/B762

	.al
	.xl
	.autsiz
	.databank ?

	phx
	phy
	lda @l wR2
	pha
	lda lUnknown000DBB
	tay
	lda $0001,b,y
	sta @l wR2
	tya
	clc
	adc #$0008
	tay

	-
	lda $0000,b,y
	bit #$0080
	beq +

	-
	jsr rsUnknown82B6E5
	cmp @l wR2
	tax
	bcs ++

	lda $0000,b,x
	bit #$0080
	beq +

	lda $0001,b,y
	clc
	adc $0001,b,x
	sta $0001,b,y
	lda #$0000
	sta $0000,b,x
	sta $0001,b,x
	sta $0004,b,x
	sta $0003,b,x
	bra -

	+
	tya
	clc
	adc $0001,b,y
	cmp @l wR2
	tay
	bcc --

	+
	pla
	sta @l wR2
	ply
	plx
	rts

rsUnknown82B7C4 ; 82/B7C4

	.al
	.xl
	.autsiz
	.databank ?

	phy 
	lda @l wR0
	pha 
	lda @l wR3
	pha 
	lda $0005,b,y
	and #$00FF
	beq +

	sta @l wR3
	asl a
	asl a
	clc
	adc #$0003
	sta @l wR0
	jsl rlUnknown82B3D9
	lda @l lR25
	tay
	lda #$0000
	sta $0000,b,y
	sep #$20
	lda @l wR3
	sta $0002,b,y
	rep #$20
	lda @l wR3
	tax

	-
	sep #$20
	lda #$80
	sta $0006,b,y
	rep #$20
	tya
	clc
	adc #$0004
	tay
	dec x
	bne -

	pla
	sta @l wR3
	pla
	sta @l wR0
	lda @l lR25
	ply
	rts

	+
	pla
	sta @l wR3
	pla
	sta @l wR0
	lda #$0000
	ply
	rts

rsUnknown82B835 ; 82/B835

	.al
	.xl
	.autsiz
	.databank ?

	phx
	phy
	lda $0006,b,y
	beq _True

	tay

	-
	phy
	lda $0002,b,y
	and #$00FF
	beq +

	tax
	tya
	clc
	adc #$0003
	tay

	-
	lda $0003,b,y
	bit #$0080
	bne _False

	tya
	clc
	adc #$0004
	tay
	dec x
	bne -

	+
	ply 
	lda $0000,b,y
	beq +

	tay
	bra --

	+
	tyx
	lda lUnknown000DBB
	tay
	jsr rsUnknown82B7C4
	sta $0000,b,x
	clc
	adc #$0003
	ply
	plx
	clc
	rts

	_False
	tya
	ply
	ply
	plx
	clc
	rts

	_True
	ply
	plx
	sec
	rts

rsUnknown82B885 ; 82/B885

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda @l wR1
	tax
	sep #$20
	lda #$00
	sta $0003,b,x
	rep #$20
	lda lUnknown000DBB+1
	sta $0001,b,x
	tya
	clc
	adc #$0006
	sta $0000,b,x
	plx
	rts

rsUnknown82B8A5 ; 82/B8A5

	.al
	.xl
	.autsiz
	.databank ?

	sep #$20
	lda #$80
	sta $0003,b,y
	rep #$20
	rts
