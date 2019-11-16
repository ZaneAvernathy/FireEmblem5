
aProcEngineMainProcActionTable ; 82/9BD5

	; Names subject to change

	.addr rlProcEngineResetProcEngine
	.addr rlProcEngineMainProcLoop
	.addr rlProcEngineStub

rlProcEngineResetProcEngine ; 82/9BDB

	.al
	.xl
	.autsiz
	.databank ?

	; Clears RAM associated with the proc system

	; Inputs:
	; None

	; Outputs:
	; None

	php
	phb

	phk
	plb

	.databank `*

	ldx #size(aProcRAM)-1

	sep #$20

	lda #$00

	-
	sta aProcRAM,b,x
	dec x
	bpl -

	rep #$20
	plb
	plp
	rtl

rlProcEngineCreateProc ; 82/9BF1

	.al
	.xl
	.autsiz
	.databank ?

	; Creates a new proc

	; Inputs:
	; lR43: Long pointer to proc info

	; Outputs:
	; Carry set if unsuccessful

	php
	phb

	phx
	phy

	sep #$20

	lda lR43+2
	pha
	rep #$20
	plb

	.databank ?

	ldy lR43

	; Find first free proc slot

	ldx #(16 - 1) * 2

	_FreeProcLoop
	lda wProcFlag,b
	bpl +

	cpx wProcIndex,b
	beq ++

	+
	lda aProcHeaderTypeOffset,b,x
	beq _InitProc

	+
	dec x
	dec x
	bpl _FreeProcLoop

	ply
	plx
	plb
	plp

	sec
	rtl

	_InitProc

	; Create a proc

	; Start by storing a pointer to the proc info

	tya
	sta aProcHeaderTypeOffset,b,x

	lda lR43+1
	and #$FF00
	sta lProcCodePointer + 1,b

	xba
	sta aProcHeaderTypeBank,b,x

	lda #$0001
	sta aProcHeaderSleepTimer,b,x

	; Clear the proc body

	lda #$0000
	sta aProcHeaderBitfield,b,x
	sta aProcHeaderUnknownTimer,b,x
	sta aProcBody0,b,x
	sta aProcBody1,b,x
	sta aProcBody2,b,x
	sta aProcBody3,b,x
	sta aProcBody4,b,x
	sta aProcBody5,b,x
	sta aProcBody6,b,x
	sta aProcBody7,b,x

	; Store parts from the proc info

	lda structProcInfo.Name,b,y
	sta aProcHeaderName,b,x

	lda structProcInfo.Init,b,y
	sta lProcCodePointer,b

	lda structProcInfo.OnCycle,b,y
	sta aProcHeaderOnCycle,b,x

	lda structProcInfo.Code,b,y
	sta aProcHeaderCodeOffset,b,x

	; Store new proc Index

	phx
	lda wProcIndex,b
	pha

	stx wProcIndex,b

	; Run init code

	jsl rlProcEngineRunProcInit

	; on cycle and code, too

	ldx wProcIndex,b
	jsr rsProcEngineRunProcOnCycleAndCode

	; Update that the proc has run this cycle

	lda aProcHeaderBitfield,b,x
	ora #$4000
	sta aProcHeaderBitfield,b,x

	pla
	sta wProcIndex,b

	pla
	ply
	plx
	plb
	plp
	clc
	rtl

rlProcEngineRunProcInit ; 82/9C90

	.al
	.xl
	.autsiz
	.databank ?

	lda lProcCodePointer,b
	bmi +
	rtl

	+
	jmp [lProcCodePointer]

rlProcEngineCreateProcByIndex ; 82/9C99

	.al
	.xl
	.autsiz
	.databank ?

	; Creates a proc with then given
	; index if no proc is in that slot

	; Inputs:
	; A: Index in proc array
	; lR43: long pointer to proc info

	; Outputs:
	; Carry set if unsuccessful

	php
	phb
	phx
	phy

	asl a
	tax
	lda lR43
	tay

	sep #$20
	lda lR43+2
	pha
	rep #$20
	plb

	.databank ?

	lda aProcHeaderTypeOffset,b,x
	beq +

	ply
	plx
	plb
	plp
	sec
	rtl

	+
	jmp rlProcEngineCreateProc._InitProc


rlProcEngineDeleteProcByIndex ; 82/9CB8

	.al
	.xl
	.autsiz
	.databank ?

	; Deletes a proc given by the index

	; Inputs:
	; A: Index of proc to delete

	; Outputs:
	; Carry set if there was no proc

	phb
	php

	phk
	plb

	.databank `*

	phx
	asl a
	tax
	lda aProcHeaderTypeOffset,b,x
	bne +

	plx
	plp
	plb
	sec

	-
	rtl

	+
	jsl rlProcEngineFreeProc
	plx
	plp
	plb
	clc
	bra -


rlProcEngineCheckUnkBitfieldByIndex ; 82/9CD3

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
	tax
	lda aProcUnknownBitfield,b,x
	bit #$2000
	beq +

	plx
	plp
	plb
	sec

	-
	rtl

	+
	plx
	plp
	plb
	clc
	bra -

rlProcEngineFindProc ; 82/9CEC

	.as
	.xl
	.autsiz
	.databank ?

	; Given a pointer to proc info, returns
	; offset in the proc array of the proc

	; Inputs:
	; lR43: long pointer to proc code

	; Outputs:
	; X: Offset of proc in array
	; Carry set if found

	phb
	php

	phk
	plb

	.databank `*

	ldx #(16 - 1) * 2

	-
	rep #$20
	lda aProcHeaderTypeOffset,b,x
	cmp lR43
	bne +

	sep #$20
	lda aProcHeaderTypeBank,b,x
	cmp lR43+2
	beq ++

	+
	dec x
	dec x
	bpl -

	plp
	plb
	clc
	rtl

	+
	plp
	plb
	sec
	rtl

rlProcEngineFreeProc ; 82/9D11

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcHeaderTypeOffset,b,x
	lda aProcHeaderBitfield,b,x
	ora #$2000
	sta aProcHeaderBitfield,b,x
	rtl

rlProcEngineMainProcLoop ; 82/9D1E

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb

	phk
	plb

	.databank `*

	lda #$8000
	tsb wProcFlag,b

	ldx #(16 - 1) * 2

	-
	stx wProcIndex,b
	lda aProcHeaderTypeOffset,b,x
	beq +

	jsr rsProcEngineRunProcOnCycleAndCode

	+
	ldx wProcIndex,b
	dec x
	dec x
	bpl -

	jsr rsProcEngineUnblockAllProcs

	lda #$8000
	trb wProcFlag,b
	plb
	plp
	rtl

rsProcEngineRunProcOnCycleAndCode ; 82/9D49

	.al
	.xl
	.autsiz
	.databank ?

	sep #$20
	lda aProcHeaderTypeBank,b,x
	pha
	rep #$20
	plb

	.databank ?

	lda aProcHeaderBitfield,b,x
	bit #$1000
	bne +

	bit #$4000
	beq ++

	+
	rts

	+
	phb
	jsl rlProcEngineRunProcOnCycle
	plb

	ldx wProcIndex,b

	dec aProcHeaderSleepTimer,b,x
	bne ++

	ldy aProcHeaderCodeOffset,b,x
	bpl ++

	_Loop
	lda $0000,b,y
	bpl +

	sta lProcCodePointer,b
	iny
	iny
	pea <>_Loop - 1
	jmp (lProcCodePointer)

	+
	sta aProcHeaderSleepTimer,b,x
	tya
	clc
	adc #$0002
	sta aProcHeaderCodeOffset,b,x

	+
	rts


rlProcEngineRunProcOnCycle ; 82/9D8F

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcHeaderTypeBank,b,x
	xba
	sta lProcCodePointer + 1,b
	lda aProcHeaderOnCycle,b,x
	bmi +

	rtl

	+
	sta lProcCodePointer,b
	jmp [lProcCodePointer]


rsProcEngineUnblockAllProcs ; 82/9DA2

	.al
	.xl
	.autsiz
	.databank ?

	ldx #(16 - 1) * 2

	_Loop
	lda aProcHeaderBitfield,b,x
	and #~$4000
	sta aProcHeaderBitfield,b,x
	sta aProcUnknownBitfield,b,x
	dec x
	dec x
	bpl _Loop

	rts

rlProcEngineStub ; 82/9DB6

	.autsiz
	.databank ?

	rtl
