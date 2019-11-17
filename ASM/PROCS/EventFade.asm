
procEventFadeIn .dstruct structProcInfo, "EI", rlProcEventFadeInInit, rlProcEventFadeInOnCycle, aProcEventFadeInCode ; 82/8EAC

aUnknown828EB4 ; 82/8EB4
	.word $0000

rlProcEventFadeInInit ; 82/8EB6

	.al
	.xl
	.autsiz
	.databank ?

	php
	rep #$20
	ldy wEventExecutionOffset,b
	lda [lR22],y
	and #$00FF
	sta aProcBody0,b,x
	plp
	rtl

rlProcEventFadeInOnCycle ; 82/8EC6

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcBody0,b,x
	jsl rlFadeInByTimer
	bcc +

	jsl rlEventEngineDeleteProcAndClearActive

	+
	rtl

aProcEventFadeInCode ; 82/8ED4

	PROC_HALT

procEventFadeOut .dstruct structProcInfo, "EO", rlProcEventFadeOutInit, rlProcEventFadeOutOnCycle, aProcEventFadeOutCode ; 82/8ED6

aUnknown828EDE ; 82/8EDE
	.word $0000

rlProcEventFadeOutInit ; 82/8EE0

	.al
	.xl
	.autsiz
	.databank ?

	php
	rep #$20
	ldy wEventExecutionOffset,b
	lda [lR22],y
	and #$00FF
	sta aProcBody0,b,x
	plp
	rtl

rlProcEventFadeOutOnCycle ; 82/8EF0

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcBody0,b,x
	jsl rlFadeOutByTimer
	bcc +

	sep #$20
	lda bBuf_INIDISP
	sta INIDISP,b
	rep #$20

	jsl rlEventEngineDeleteProcAndClearActive

	+
	rtl

aProcEventFadeOutCode ; 82/8F07

	PROC_HALT

