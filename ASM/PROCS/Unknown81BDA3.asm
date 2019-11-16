
; The following procs overlap eachother:
; The first proc's (blank) code pointer
; is used as the second proc's name, and
; the second proc's code pointer overlaps
; the init function of the first proc.

.union
.struct
procUnknown81BDA3 .dstruct structProcInfo, None, rlProcUnknown81BDA3Init, rlProcUnknown81BDA3OnCycle, None ; 81/BDA3

.fill 4

rlProcUnknown81BDA3Init ; 81/BDAF

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0004
	sta aProcBody0,b,x
	lda #$0004
	sta aProcBody1,b,x
	lda #$0020
	sta aProcBody2,b,x
	rtl

.ends
.struct

.fill 6

procUnknown81BDA9 .dstruct structProcInfo, None, rlUnknown81BDC2, rlProcUnknown81BDA3OnCycle, ? ; 81/BDA9

.ends
.endu

rlUnknown81BDC2 ; 81/BDC2

	.al
	.xl
	.autsiz
	.databank ?

	lda #size(aUnknown81BD14) - 6
	sta aProcBody0,b,x
	lda #-4
	sta aProcBody1,b,x
	lda #-4
	sta aProcBody2,b,x
	rtl

rlProcUnknown81BDA3OnCycle ; 81/BDD5

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown0000DB
	and #$0001
	bne _End

	phb
	phx
	phx
	lda aProcBody0,b,x
	tax
	lda aUnknown81BD14,x
	pha
	tax
	ldy #<>aBGPal3
	lda #(5 * $10 * 2) - 1
	mvn #`aFadingPaletteSpace,#`aFadingPaletteSpace
	pla
	clc
	adc #(5 * $10 * 2)
	tax
	ldy #<>aOAMPal0
	lda #(4 * $10 * 2) - 1
	mvn #`aFadingPaletteSpace,#`aFadingPaletteSpace
	plx
	lda aProcBody0,b,x
	clc
	adc aProcBody1,b,x
	cmp aProcBody2,b,x
	bne +

	jsl rlProcEngineFreeProc

	+
	sta aProcBody0,b,x
	plx
	plb

	_End
	rtl

