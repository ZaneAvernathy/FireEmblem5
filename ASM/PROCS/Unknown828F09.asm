
procUnknown828F09 .dstruct structProcInfo, "CC", rlProcUnknown828F09Init, rlProcUnknown828F09OnCycle, aProcUnknown828F09Code ; 82/8F09

aUnknown828F11 ; 82/8F11
	.word $0000

rlProcUnknown828F09Init ; 82/8F13

	.al
	.xl
	.autsiz
	.databank ?

	ldy wEventExecutionOffset,b
	lda [lR22],y
	sta aProcBody0,b,x
	inc y

	lda [lR22],y
	and #$FF00
	sta aProcBody2,b,x
	inc y
	inc y

	lda [lR22],y
	sta lR19
	inc y
	inc y

	sep #$20
	lda [lR22],y
	sta aProcBody2,b,x
	sta lR19+2
	rep #$20

	lda [lR19]
	and #$00FF
	asl a
	sta aProcBody5,b,x
	inc lR19

	lda [lR19]
	and #$00FF
	asl a
	sta aProcBody6,b,x

	lda lR19
	inc a
	sta aProcBody1,b,x

	stz aProcBody3,b,x
	lda #$0001
	sta aProcBody4,b,x
	ldx wProcIndex,b
	rtl

rlProcUnknown828F09OnCycle ; 82/8F5E

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcBody4,b,x
	dec a
	beq +

	sta aProcBody4,b,x
	rtl

	+
	lda aProcBody2,b,x
	sta lR18+1
	xba
	sta lR19+1
	lda aProcBody0,b,x
	sta lR18
	lda aProcBody1,b,x
	sta lR19
	lda aProcBody3,b,x
	inc a
	inc a

	-
	sta aProcBody3,b,x
	tay
	lda [lR19],y
	bit #$FF00
	bne +

	lda #$0000
	bra -

	+
	phx
	sep #$20
	xba
	sta aProcBody4,b,x
	rep #$20
	xba
	and #$00FF
	asl a
	clc
	adc lR18
	sta lR18
	lda #$0000
	sta lR20+1
	lda #$0100
	clc
	adc aProcBody5,b,x
	sta lR20
	lda aProcBody6,b,x
	tay

	-
	lda [lR18],y
	sta [lR20],y
	dec y
	dec y
	bne -

	plx
	rtl

aProcUnknown828F09Code ; 82/8FBE

	PROC_HALT






