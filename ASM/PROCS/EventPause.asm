
procEventPause .dstruct structProcInfo, "e0", rlProcEventPauseInit, rlProcEventPauseOnCycle, aProcEventPauseCode

aUnknown828E4D ; 82/8E4D
	.word $0002

rlProcEventPauseInit ; 82/8E4F

	.al
	.xl
	.autsiz
	.databank ?

	ldy wEventExecutionOffset,b
	lda [lR22],y
	cmp #2
	bge +

	lda #2

	+
	sta aProcBody0,b,x
	rtl

rlProcEventPauseOnCycle ; 82/8E60

	.al
	.xl
	.autsiz
	.databank ?

	dec aProcBody0,b,x
	bne +

	jsl rlEventEngineDeleteProcAndClearActive

	+
	rtl

aProcEventPauseCode ; 82/8E6A

	PROC_HALT

procEventPauseUntilButton .dstruct structProcInfo, "e0", rlProcEventPauseUntilButtonInit, rlProcEventPauseUntilButtonOnCycle, aProcEventPauseUntilButtonCode

aUnknown828E74 ; 82/8E74
	.word $0002

rlProcEventPauseUntilButtonInit ; 82/8E76

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlProcEventPauseUntilButtonOnCycle ; 82/8E77

	.al
	.xl
	.autsiz
	.databank ?

	lda wJoy1New
	bit #JoypadX | JoypadA | JoypadY | JoypadB
	beq +

	jsl rlEventEngineDeleteProcAndClearActive

	+
	rtl

aProcEventPauseUntilButtonCode ; 82/8E83

	PROC_HALT

procEventPauseUntilTimeOrButton .dstruct structProcInfo, "e0", rlProcEventPauseUntilTimeOrButtonInit, rlProcEventPauseUntilTimeOrButtonOnCycle, aProcEventPauseUntilTimeOrButtonCode

aUnknown828E8D ; 82/8E8D
	.word $0002

rlProcEventPauseUntilTimeOrButtonInit ; 82/8E8F

	.al
	.xl
	.autsiz
	.databank ?

	ldy wEventExecutionOffset,b
	lda [lR22],y
	sta aProcBody0,b,x
	rtl

rlProcEventPauseUntilTimeOrButtonOnCycle ; 82/8E98

	.al
	.xl
	.autsiz
	.databank ?

	dec aProcBody0,b,x
	beq +

	lda wJoy1New
	bit #JoypadX | JoypadA | JoypadY | JoypadB
	bne +

	rtl

	+
	jsl rlEventEngineDeleteProcAndClearActive
	rtl

aProcEventPauseUntilTimeOrButtonCode ; 82/8EAA

	PROC_HALT
