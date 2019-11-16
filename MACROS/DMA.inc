
structDMAToCGRAM .struct Source, Count, StartIndex
	.if type(\Source) == type(?)
		; Assume all fields are holes
		.fill 7
	.else
		.byte 1 ; Type: To CGRAM
		.long \Source
		.if \Count == $10000
			.word 0
		.else
			.word \Count
		.endif
		.byte \StartIndex
	.endif
	.ends

structDMAToVRAM .struct Source, Count, Mode, Dest
	.if type(\Source) == type(?)
		; Assume all fields are holes
		.fill 9
	.else
		.byte 2 ; Type: To VRAM
		.long \Source
		.if \Count == $10000
			.word 0
		.else
			.word \Count
		.endif
		.byte \Mode
		.word \Dest / 2
	.endif
	.ends

structDMAFromVRAM .struct Dest, Count, Mode, Source
	.if type(\Dest) == type(?)
		; Assume all fields are holes
		.fill 9
	.else
		.byte 3 ; Type: From VRAM
		.long \Dest
		.if \Count == $10000
			.word 0
		.else
			.word \Count
		.endif
		.byte \Mode
		.word \Source / 2
	.endif
	.ends

structDMAInputDest .struct Source, Count, Param, Port, Mode, Dest
	.if type(\Source) == type(?)
		; Assume all fields are holes
		.fill 11
	.else
		.byte 4 ; Type: Input Dest
		.long \Source
		.if \Count == $10000
			.word 0
		.else
			.word \Count
		.endif
		.byte \Param
		.byte \Port
		.byte \Mode
		.word \Dest / 2
	.endif
	.ends

; RAM versions for pulling struct parts

structDMAToCGRAMEntry .struct
	Type	.byte ?
	Source	.long ?
	Count	.word ?
	Start	.byte ?
	.ends

structDMAToVRAMEntry .struct
	Type	.byte ?
	Source	.long ?
	Count	.word ?
	Mode	.byte ?
	Dest	.word ?
	.ends

structDMAFromVRAMEntry .struct
	Type	.byte ?
	Dest	.long ?
	Count	.word ?
	Mode	.byte ?
	Source	.word ?
	.ends

structDMAInputDestEntry .struct
	Type	.byte ?
	Source	.long ?
	Count	.word ?
	Param	.byte ?
	Port	.byte ?
	Mode	.byte ?
	Dest	.word ?
	.ends

; DMA by struct

.virtual #$03,s

lDMAByStructReturnLocation .long ?

.endv

