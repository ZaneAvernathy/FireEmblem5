
rsPrepareBlockCopyRAM ; 80/B208

	.xl
	.autsiz
	.databank ?

	; Copies two block memory move routines to RAM.
	; Their source and destination values are modified
	; by rlBlockCopyMVNByRAM and rlBlockCopyMVPByRAM.

	; Inputs:
	; None

	; Outputs:
	; None

	phb
	php
	phk
	plb

	.databank `*

	sep #$20

	ldx #size(rsBlockCopyMVNRoutine) - 1

	-
	lda <>rsBlockCopyMVNRoutine,b,x
	sta aBlockCopyMVNRoutineSpace,b,x
	dec x
	bpl -

	ldx #size(rsBlockCopyMVPRoutine)

	-
	lda <>rsBlockCopyMVPRoutine,b,x
	sta aBlockCopyMVPRoutineSpace,b,x
	dec x
	bpl -

	plp
	plb
	rts

rsBlockCopyMVNRoutine .block ; 80/B229

	.autsiz
	.databank ?

	mvn $00,$00
	rts

.bend

rsBlockCopyMVPRoutine .block; 80/B22D

	.autsiz
	.databank ?

	mvp $00,$00
	rts

.bend
