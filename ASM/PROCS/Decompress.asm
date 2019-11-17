
procDecompress .dstruct structProcInfo, "De", rlProcDecompressInit, rlProcDecompressOnCycle, aProcDecompressCode ; 82/A312

rlProcDecompressInit ; 82/A31A

	.al
	.xl
	.autsiz
	.databank ?

	lda lR43
	sta lR18
	lda lR43+1
	sta lR18+1
	lda #(`$7FB0F5)<<8
	sta lR19+1
	lda #<>$7FB0F5
	sta lR19
	jsl rlAppendDecompList
	rtl

rlProcDecompressOnCycle ; 82/A339

	.al
	.xl
	.autsiz
	.databank ?

	lda bDecompListFlag,b
	and #$00FF
	bne +

	jsl rlProcEngineFreeProc

	+
	rtl

aProcDecompressCode ; 82/A346

	PROC_HALT
