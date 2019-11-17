
procSoundByte .dstruct structProcInfo, "SB", rlProcSoundByteInit, rlProcSoundByteOnCycle, aProcSoundByteCode ; 82/A348

rlProcSoundByteInit ; 82/A350

	.al
	.xl
	.autsiz
	.databank ?

	lda wProcInput0,b
	sta aProcBody0,b,x

	lda wProcInput1,b

	jsl rlUnknown808C7D
	rtl

rlProcSoundByteOnCycle ; 82/A35E

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlProcSoundByteOnCycle2 ; 81/A35F

	.al
	.xl
	.autsiz
	.databank ?

	lda aUnknown0004BA,b
	bne ++

	lda wUnknown0004F6,b
	bit #$0030
	bne ++

	lda aProcBody0,b,x
	cmp wUnknown000510,b
	beq +

	sta aUnknown0004BA,b

	lda #<>rlProcSoundByteOnCycle3
	sta aProcHeaderOnCycle,b,x
	bra ++

	+
	jsl rlProcEngineFreeProc

	+
	rtl

rlProcSoundByteOnCycle3 ; 81/A384

	.al
	.xl
	.autsiz
	.databank ?

	lda aUnknown0004BA,b
	bne +

	jsl rlProcEngineFreeProc

	+
	rtl

aProcSoundByteCode ; 82/A38E

	PROC_YIELD 3

	PROC_SET_ONCYCLE rlProcSoundByteOnCycle2

	PROC_HALT
