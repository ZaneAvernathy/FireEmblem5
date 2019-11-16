
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

structProcCodeYield .struct Count
	.word \Count
	.ends

structProcCodeEnd .struct
	.word <>rsProcCodeEnd
	.ends

structProcCodeHaltSleep .struct
	.word <>rsProcCodeHaltSleep
	.ends

structProcCodeHalt .struct
	.word <>rsProcCodeHalt
	.ends

structProcCodeCall .struct Routine
	.word <>rsProcCodeCallRoutine
	.long \Routine
	.ends

structProcCodeCallArgs .struct Routine, ArgSize
	.word <>rsProcCodeCallRoutineWithArgs
	.long \Routine
	.byte \ArgSize
	.ends

structProcCodeSetOnCycle .struct Routine
	.word <>rsProcCodeSetOnCycle
	.word <>\Routine
	.ends

structProcCodeJump .struct Position
	.word <>rsProcCodeJump
	.word <>\Position
	.ends

structProcCodeSetUnknownTimer .struct Count
	.word <>rsProcCodeSetUnknownTimer
	.word \Count
	.ends

structProcCodeJumpWhileUnknownTimer .struct Position
	.word <>rsProcCodeJumpWhileUnknownTimer
	.word <>\Position
	.ends

structProcCodeJumpIfBitUnset .struct Position, Bits
	.word <>rsProcCodeJumpIfBitUnset
	.word <>\Position
	.word \Bits
	.ends

structProcCodeJumpIfBitSet .struct Position, Bits
	.word <>rsProcCodeJumpIfBitSet
	.word <>\Position
	.word \Bits
	.ends

structProcCodeJumpIfRoutineTrue .struct Position, Routine
	.word <>rsProcCodeJumpIfRoutineTrue
	.long \Routine
	.word <>\Position
	.ends

structProcCodeJumpIfRoutineFalse .struct Position, Routine
	.word <>rsProcCodeJumpIfRoutineFalse
	.long \Routine
	.word <>\Position
	.ends

structProcCodeCreateProc .struct Pointer
	.word <>rsProcCodeCreateProc
	.long \Pointer
	.ends

structProcCodeDeleteProc .struct Pointer
	.word <>rsProcCodeDeleteProc
	.long \Pointer
	.ends

structProcCodeDeleteHDMAArrayEntry .struct Pointer
	.word <>rsProcCodeDeleteHDMAArrayEntry
	.long \Pointer
	.ends

structProcCodeHaltWhile .struct Pointer
	.word <>rsProcCodeHaltWhile
	.long \Pointer
	.ends

structProcCodeCreateHDMAArrayEntry .struct Pointer
	.word <>rsProcCodeCreateHDMAArrayEntry
	.long \Pointer
	.ends

structProcCodeHaltWhileActiveSprite .struct Pointer
	.word <>rsProcCodeHaltWhileActiveSprite
	.long \Pointer
	.ends

structProcCodeHaltWhileDecompressing .struct
	.word <>rsProcCodeHaltWhileDecompressing
	.ends

structProcCodeBranchAndLink .struct Pointer
	.word <>rsProcCodeBranchAndLink
	.word <>\Pointer
	.ends

structProcCodeReturn .struct
	.word <>rsProcCodeReturn
	.ends

structProcCodeHaltUntilButtonNew .struct ButtonCombo
	.word <>rsProcCodeHaltUntilButtonNew
	.word \ButtonCombo
	.ends

structProcCodeHaltUntilButtonNewAndTime .struct Time, ButtonCombo
	.word <>rsProcCodeHaltUntilButtonNewAndTime
	.word \Time
	.word \ButtonCombo
	.ends

structProcCodeJumpIfButton .struct Position, ButtonCombo
	.word <>rsProcCodeJumpIfButton
	.word \ButtonCombo
	.word <>\Position
	.ends

structProcCodeDecompress .struct Source, Dest
	.word <>rsProcCodeDecompress
	.long \Source
	.long \Dest
	.ends

structProcCodeDMA .struct Source, Size, Dest
	.word <>rsProcCodeDMA
	.long \Source
	.word \Size
	.word \Dest
	.ends
