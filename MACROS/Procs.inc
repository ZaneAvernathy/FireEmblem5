
structProcInfo .struct Name, Init, OnCycle, Code
	Name
	.union
		.word $0000
		.enc "none"
		.text \Name
	.endu
	Init .word <>\Init
	OnCycle .word <>\OnCycle
	Code .word <>\Code
	.ends

PROC_YIELD .segment Count
	.word \Count
	.endm

PROC_END .segment
	; 82/9DB7
	.word <>rsProcCodeEnd
	.endm

PROC_HALT_SLEEP .segment
	; 82/9DC5
	.word <>rsProcCodeHaltSleep
	.endm

PROC_HALT .segment
	; 82/9DCB
	.word <>rsProcCodeHalt
	.endm

PROC_CALL .segment Routine
	; 82/9DD3
	.word <>rsProcCodeCallRoutine
	.long \Routine
	.endm

PROC_CALL_ARGS .segment Routine, ArgSize
	; 82/9DEE
	.word <>rsProcCodeCallRoutineWithArgs
	.long \Routine
	.byte \ArgSize
	.endm

PROC_SET_ONCYCLE .segment Routine
	; 82/9E19
	.word <>rsProcCodeSetOnCycle
	.word <>\Routine
	.endm

PROC_JUMP .segment Position
	; 82/9E2B
	.word <>rsProcCodeJump
	.word <>\Position
	.endm

PROC_SET_UNK_TIMER .segment Count
	; 82/9E30
	.word <>rsProcCodeSetUnknownTimer
	.word \Count
	.endm

PROC_JUMP_WHILE_UNK_TIMER .segment Position
	; 82/9E39
	.word <>rsProcCodeJumpWhileUnknownTimer
	.word <>\Position
	.endm

PROC_JUMP_IF_BIT_UNSET .segment Position, Bits
	; 82/9E41
	.word <>rsProcCodeJumpIfBitUnset
	.word <>\Position
	.word \Bits
	.endm

PROC_JUMP_IF_BIT_SET .segment Position, Bits
	; 82/9E4E
	.word <>rsProcCodeJumpIfBitSet
	.word <>\Position
	.word \Bits
	.endm

PROC_JUMP_IF_ROUTINE_TRUE .segment Position, Routine
	; 82/9E77
	.word <>rsProcCodeJumpIfRoutineTrue
	.long \Routine
	.word <>\Position
	.endm

PROC_JUMP_IF_ROUTINE_FALSE .segment Position, Routine
	; 82/9E9B
	.word <>rsProcCodeJumpIfRoutineFalse
	.long \Routine
	.word <>\Position
	.endm

PROC_CREATE_PROC .segment Pointer
	; 82/9EBF
	.word <>rsProcCodeCreateProc
	.long \Pointer
	.endm

PROC_DELETE_PROC .segment Pointer
	; 82/9ED5
	.word <>rsProcCodeDeleteProc
	.long \Pointer
	.endm

PROC_DELETE_HDMA_ARRAY_ENTRY .segment Pointer
	; 82/9EF1
	.word <>rsProcCodeDeleteHDMAArrayEntry
	.long \Pointer
	.endm

PROC_HALT_WHILE .segment Pointer
	; 82/9F0D
	.word <>rsProcCodeHaltWhile
	.long \Pointer
	.endm

PROC_CREATE_HDMA_ARRAY_ENTRY .segment Pointer
	; 82/9F33
	.word <>rsProcCodeCreateHDMAArrayEntry
	.long \Pointer
	.endm

PROC_HALT_WHILE_ACTIVE_SPRITE .segment Pointer
	; 82/9F49
	.word <>rsProcCodeHaltWhileActiveSprite
	.long \Pointer
	.endm

PROC_HALT_WHILE_DECOMPRESSING .segment
	; 82/A04A
	.word <>rsProcCodeHaltWhileDecompressing
	.endm

PROC_BL .segment Pointer
	; 82/A05E
	.word <>rsProcCodeBranchAndLink
	.word <>\Pointer
	.endm

PROC_RETURN .segment
	; 82/A06B
	.word <>rsProcCodeReturn
	.endm

PROC_HALT_UNTIL_BUTTON_NEW .segment ButtonCombo
	; 82/A070
	.word <>rsProcCodeHaltUntilButtonNew
	.word \ButtonCombo
	.endm

PROC_HALT_UNTIL_BUTTON_NEW_TIME .segment Time, ButtonCombo
	; 82/A09A
	.word <>rsProcCodeHaltUntilButtonNewAndTime
	.word \Time
	.word \ButtonCombo
	.endm

PROC_JUMP_IF_BUTTON .segment Position, ButtonCombo
	; 82/A0B9
	.word <>rsProcCodeJumpIfButton
	.word \ButtonCombo
	.word <>\Position
	.endm

PROC_DECOMPRESS .segment Source, Dest
	; 82/A0CA
	.word <>rsProcCodeDecompress
	.long \Source
	.long \Dest
	.endm

PROC_DMA .segment Source, Size, Dest
	; 82/A0CA
	.word <>rsProcCodeDMA
	.long \Source
	.word \Size
	.word \Dest
	.endm
