
procMusicEvent .dstruct structProcInfo, "ME", rlProcMusicEventInit, rlProcMusicEventOnCycle, aProcMusicEventCode ; 82/8E2E

aUnknown828E36 ; 82/8E36
	.word $0000

rlProcMusicEventInit ; 82/8E38

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlProcMusicEventOnCycle ; 82/8E39

	.al
	.xl
	.autsiz
	.databank ?

	lda aUnknown0004BA,b
	bne +

	jsl rlEventEngineDeleteProcAndClearActive

	+
	rtl

aProcMusicEventCode ; 82/8E43

	PROC_HALT
