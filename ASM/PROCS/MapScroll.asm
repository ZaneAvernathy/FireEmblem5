
procMapScroll .dstruct structProcInfo, "MS", rlProcMapScrollInit, rlProcMapScrollOnCycle, aProcMapScrollCode

rlProcMapScrollInit ; 82/8FC8

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlProcMapScrollOnCycle ; 82/8FC9

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda wUnknown000E6D,b
	bne +

	jsl rlEventEngineDeleteProcAndClearActive

	+
	plp
	rtl

aProcMapScrollCode ; 82/8FD5

	PROC_HALT

procMapScrollUnknown .dstruct structProcInfo, "MS", rlProcMapScrollInitUnknown, rlProcMapScrollOnCycleUnknown, aProcMapScrollCodeUnknown

rlProcMapScrollInitUnknown ; 82/8FDF

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlProcMapScrollOnCycleUnknown ; 82/8FE0

	.al
	.xl
	.autsiz
	.databank ?

	php
	lda wUnknown000E6D,b
	bne +

	jsl rlEventEngineDeleteProcAndClearActive

	+
	plp
	rtl

aProcMapScrollCodeUnknown ; 82/8FEC

	PROC_HALT
