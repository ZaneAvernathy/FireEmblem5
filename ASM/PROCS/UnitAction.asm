
procUnitAction .dstruct structProcInfo, "UA", rlProcUnitActionInit, rlProcUnitActionOnCycle, aProcUnitActionCode ; 82/8FEE

rlProcUnitActionInit ; 82/8FF6

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlProcUnitActionOnCycle ; 82/8FF7

	.al
	.xl
	.autsiz
	.databank ?

	lda #<>rlProcUnitActionOnCycle2
	sta aProcHeaderOnCycle,b,x
	rtl

rlProcUnitActionOnCycle2 ; 82/8FFE

	.al
	.xl
	.autsiz
	.databank ?

	jsl $84EA72
	bcs _End

	phx
	ldx #size(aUnknown0017BF) - 2

	-
	lda @l aUnknown0017BF,x
	beq +

	bit #$1000
	bne ++

	lda $7FAA1A,x
	cmp #$FFFF
	bne ++

	+
	dec x
	dec x
	bpl -

	plx

	jsl rlEventEngineDeleteProcAndClearActive

	_End
	rtl

	+
	plx
	bra _End

aProcUnitActionCode ; 82/9029

	PROC_HALT
