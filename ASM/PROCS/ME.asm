
procME .dstruct structProcInfo, "ME", rlProcMEInit, rlProcMEOnCycle, aProcMECode ; 82/8CFE

aUnknown828D06 ; 82/8D06
	.word $0000

rlProcMEInit ; 82/8D08

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlUnknown828D09 ; 82/8D09

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0001
	sta wUnknown001800,b

	lda wUnknown0017E9,b
	bit #$0001
	beq +

	lda #<>rlProcMEOnCycle
	sta aProcHeaderOnCycle,b,x

	+
	rtl

rlProcMEOnCycle ; 82/8D1E

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown0017E9,b
	bit #$0001
	bne +

	jsl rlEventEngineDeleteProcAndClearActive

	+
	rtl

aProcMECode ; 82/8D2B

	PROC_HALT
