
PPU_REG_BASE	= $002100
APU_REG_BASE	= $002140
WRAM_REG_BASE	= $002180
JOY_REG_BASE	= $004016
CPU_W_REG_BASE	= $004200
CPU_R_REG_BASE	= $004210
DMA_REG_BASE	= $004300

.virtual PPU_REG_BASE

	; $002100
	INIDISP							.byte ?
		INIDISP.ForcedBlank			= %10000000
		INIDISP.Unused				= %01110000
		INIDISP.Brightness			= %00001111

		INIDISP_Setting .function ForcedBlank=False, Brightness=0
			.endf bits((ForcedBlank << 7) | (Brightness & INIDISP.Brightness))

	; $002101
	OBSEL							.byte ?
		OBSEL.Size					= %11100000
		OBSEL.Gap					= %00011000
		OBSEL.Base					= %00000111

		ObjectSize8x8And16x16		= 0
		ObjectSize8x8And32x32		= 1
		ObjectSize8x8And64x64		= 2
		ObjectSize16x16And32x32		= 3
		ObjectSize16x16And64x64		= 4
		ObjectSize32x32And64x64		= 5
		ObjectSize16x32And32x64		= 6
		ObjectSize16x32And32x32		= 7

		OBSEL_Setting .function Size=ObjectSize8x8And16x16, Gap=$0000, Base=$0000
			.endf bits((Size << 5) | ((Gap >> 15) << 3) | (Base >> 14))

	; $002102
	.union
	OAMADD							.word ?
	.struct
	OAMADDL							.byte ?
	OAMADDH							.byte ?
	.ends
	.endu
		OAMADDL.PriorityObject		= %11111110
		OAMADDL.Address				= %11111111

		OAMADDH.Priority			= %10000000
		OAMADDH.Unused				= %01111110
		OAMADDH.PriorityObject		= %00000000
		OAMADDH.Address				= %00000001

		OAMADD.Priority				= (OAMADDH.Priority << 8)
		OAMADD.Unused				= (OAMADDH.Unused << 8)
		OAMADD.PriorityObject		= (OAMADDH.PriorityObject << 8) | OAMADDL.PriorityObject
		OAMADD.Address				= (OAMADDH.Address << 8) | OAMADDL.Address

		OAMADDL_Setting .function Address=$000, PriorityObject=$000
			.endf bits(((Address & OAMADDL.Address) | (PriorityObject & OAMADDL.PriorityObject)) & $FF)

		OAMADDH_Setting .function Priority=False, Address=$000
			.endf bits(((Priority << 7) | (Address >> 8)) & $FF)

		OAMADD_Setting .function Priority=False, Address=$000, PriorityObject=$000
			.endf bits((Priority << 15) | (Address) | (PriorityObject & OAMADDL.PriorityObject))

	; $002104
	OAMDATA							.byte ?

	; $002105
	BGMODE							.byte ?
		BGMODE.BG4TileSize			= %10000000
		BGMODE.BG3TileSize			= %01000000
		BGMODE.BG2TileSize			= %00100000
		BGMODE.BG1TileSize			= %00010000
		BGMODE.BG3Priority			= %00001000
		BGMODE.Mode					= %00000111

		BGMODE_Setting .function Mode, BG3Priority=False, BG1TileSize=False, BG2TileSize=False, BG3TileSize=False, BG4TileSize=False
			.endf bits((BG4TileSize << 7) | (BG3TileSize << 6) | (BG2TileSize << 5) | (BG1TileSize << 4) | (BG3Priority << 3) | Mode)

	; $002106
	MOSAIC							.byte ?
		MOSAIC.Size					= %11110000
		MOSAIC.BG4Enable			= %00001000
		MOSAIC.BG3Enable			= %00000100
		MOSAIC.BG2Enable			= %00000010
		MOSAIC.BG1Enable			= %00000001

		MOSAIC_Setting .function Size, BG1Enable=False, BG2Enable=False, BG3Enable=False, BG4Enable=False
			.endf bits(((Size - 1) << 4) | (BG4Enable << 3) | (BG3Enable << 2) | (BG2Enable << 1) | BG1Enable)

	; $002107
	BG1SC							.byte ?
		BG1SC.Address				= %11111100
		BG1SC.Size					= %00000011

	; $002108
	BG2SC							.byte ?
		BG2SC.Address				= %11111100
		BG2SC.Size					= %00000011

	; $002109
	BG3SC							.byte ?
		BG3SC.Address				= %11111100
		BG3SC.Size					= %00000011

	; $00210A
	BG4SC							.byte ?
		BG4SC.Address				= %11111100
		BG4SC.Size					= %00000011

		BGSize32x32					= 0
		BGSize64x32					= 1
		BGSize32x64					= 2
		BGSize64x64					= 3

		BGSC_Setting .function Size=BGSize32x32, Address=$0000
			.endf bits(((Address >> 10) << 2) | Size)

	; $00210B
	BG12NBA							.byte ?
		BG12NBA.BG2Base				= %11110000
		BG12NBA.BG1Base				= %00001111

		BG12NBA_Setting .function BG1Base=$0000, BG2Base=$0000
			.endf bits(((BG2Base >> 13) << 4) | (BG1Base >> 13))

	; $00210C
	BG34NBA							.byte ?
		BG34NBA.BG4Base				= %11110000
		BG34NBA.BG3Base				= %00001111

		BG34NBA_Setting .function BG3Base=$0000, BG4Base=$0000
			.endf bits(((BG4Base >> 13) << 4) | (BG3Base >> 13))

	; $00210D
	BG1HOFS							.byte ?

	; $00210E
	BG1VOFS							.byte ?

	; $00210F
	BG2HOFS							.byte ?

	; $002110
	BG2VOFS							.byte ?

	; $002111
	BG3HOFS							.byte ?

	; $002112
	BG3VOFS							.byte ?

	; $002113
	BG4HOFS							.byte ?

	; $002114
	BG4VOFS							.byte ?

	; $002115
	VMAIN							.byte ?
		VMAIN.IncrementMode			= %10000000
		VMAIN.Unused				= %01110000
		VMAIN.Translation			= %00001100
		VMAIN.IncrementStep			= %00000011

		VMAIN_TranslationNone		= 0
		VMAIN_Translation8Bit		= 1
		VMAIN_Translation9Bit		= 2
		VMAIN_Translation10Bit		= 3

		VMAIN_Step1					= 0
		VMAIN_Step32				= 1
		VMAIN_Step128_1				= 2
		VMAIN_Step128_2				= 3

		VMAIN_Setting .function IncrementMode=False, Translation=VMAIN_TranslationNone, IncrementStep=VMAIN_Step1
			.endf bits((IncrementMode << 7) | (Translation << 2) | IncrementStep)

	; $002116
	VMADD							.word ?

	; $002118
	VMDATA							.word ?

	; $00211A
	M7SEL							.byte ?

	; $00211B
	M7A								.byte ?

	; $00211C
	M7B								.byte ?

	; $00211D
	M7C								.byte ?

	; $00211E
	M7D								.byte ?

	; $00211F
	M7X								.byte ?

	; $002120
	M7Y								.byte ?

	; $002121
	CGADD							.byte ?

	; $002122
	CGDATA							.byte ?

	; $002123
	W12SEL							.byte ?
		W12SEL.BG2Window2Enable		= %10000000
		W12SEL.BG2Window2Invert		= %01000000
		W12SEL.BG2Window1Enable		= %00100000
		W12SEL.BG2Window1Invert		= %00010000
		W12SEL.BG1Window2Enable		= %00001000
		W12SEL.BG1Window2Invert		= %00000100
		W12SEL.BG1Window1Enable		= %00000010
		W12SEL.BG1Window1Invert		= %00000001

		W12SEL_Setting .function BG1Window1Enable=False, BG1Window1Invert=False, BG1Window2Enable=False, BG1Window2Invert=False, BG2Window1Enable=False, BG2Window1Invert=False, BG2Window2Enable=False, BG2Window2Invert=False
			.endf bits((BG2Window2Enable << 7) | (BG2Window2Invert << 6) | (BG2Window1Enable << 5) | (BG2Window1Invert << 4) | (BG1Window2Enable << 3) | (BG1Window2Invert << 2) | (BG1Window1Enable << 1) | BG1Window1Invert)

	; $002124
	W34SEL							.byte ?
		W34SEL.BG4Window2Enable		= %10000000
		W34SEL.BG4Window2Invert		= %01000000
		W34SEL.BG4Window1Enable		= %00100000
		W34SEL.BG4Window1Invert		= %00010000
		W34SEL.BG3Window2Enable		= %00001000
		W34SEL.BG3Window2Invert		= %00000100
		W34SEL.BG3Window1Enable		= %00000010
		W34SEL.BG3Window1Invert		= %00000001

		W34SEL_Setting .function BG3Window1Enable=False, BG3Window1Invert=False, BG3Window2Enable=False, BG3Window2Invert=False, BG4Window1Enable=False, BG4Window1Invert=False, BG4Window2Enable=False, BG4Window2Invert=False
			.endf bits((BG4Window2Enable << 7) | (BG4Window2Invert << 6) | (BG4Window1Enable << 5) | (BG4Window1Invert << 4) | (BG3Window2Enable << 3) | (BG3Window2Invert << 2) | (BG3Window1Enable << 1) | BG3Window1Invert)

	; $002125
	WOBJSEL							.byte ?
		WOBJSEL.BGMathWindow2Enable	= %10000000
		WOBJSEL.BGMathWindow2Invert	= %01000000
		WOBJSEL.BGMathWindow1Enable	= %00100000
		WOBJSEL.BGMathWindow1Invert	= %00010000
		WOBJSEL.BGOBJWindow2Enable	= %00001000
		WOBJSEL.BGOBJWindow2Invert	= %00000100
		WOBJSEL.BGOBJWindow1Enable	= %00000010
		WOBJSEL.BGOBJWindow1Invert	= %00000001

		WOBJSEL_Setting .function OBJWindow1Enable=False, OBJWindow1Invert=False, OBJWindow2Enable=False, OBJWindow2Invert=False, MathWindow1Enable=False, MathWindow1Invert=False, MathWindow2Enable=False, MathWindow2Invert=False
			.endf bits((MathWindow2Enable << 7) | (MathWindow2Invert << 6) | (MathWindow1Enable << 5) | (MathWindow1Invert << 4) | (OBJWindow2Enable << 3) | (OBJWindow2Invert << 2) | (OBJWindow1Enable << 1) | OBJWindow1Invert)

	; $002126
	WH0								.byte ?

	; $002127
	WH1								.byte ?

	; $002128
	WH2								.byte ?

	; $002129
	WH3								.byte ?

	; $00212A
	WBGLOG							.byte ?
		WBGLOG.BG4Logic				= %11000000
		WBGLOG.BG3Logic				= %00110000
		WBGLOG.BG2Logic				= %00001100
		WBGLOG.BG1Logic				= %00000011

		WLOG_ORR					= 0
		WLOG_AND					= 1
		WLOG_XOR					= 2
		WLOG_XNOR					= 3

		WBGLOG_Setting .function BG1Logic=WLOG_ORR, BG2Logic=WLOG_ORR, BG3Logic=WLOG_ORR, BG4Logic=WLOG_ORR
			.endf bits((BG4Logic << 6) | (BG3Logic << 4) | (BG2Logic << 2) | BG1Logic)

	; $00212B
	WOBJLOG							.byte ?
		WOBJLOG.Unused				= %11110000
		WOBJLOG.MathLogic			= %00001100
		WOBJLOG.OBJLogic			= %00000011

		WOBJLOG_Setting .function OBJLogic=WLOG_ORR, MathLogic=WLOG_ORR
			.endf bits((MathLogic << 2) | OBJLogic)

	; $00212C
	TM								.byte ?
		TM.Unused					= %11100000
		TM.OBJEnable				= %00010000
		TM.BG4Enable				= %00001000
		TM.BG3Enable				= %00000100
		TM.BG2Enable				= %00000010
		TM.BG1Enable				= %00000001

		TM_Setting .function BG1Enable=False, BG2Enable=False, BG3Enable=False, BG4Enable=False, OBJEnable=False
			.endf bits((OBJEnable << 4) | (BG4Enable << 3) | (BG3Enable << 2) | (BG2Enable << 1) | BG1Enable)

	; $00212D
	TS								.byte ?
		TS.Unused					= %11100000
		TS.OBJEnable				= %00010000
		TS.BG4Enable				= %00001000
		TS.BG3Enable				= %00000100
		TS.BG2Enable				= %00000010
		TS.BG1Enable				= %00000001

		TS_Setting .function BG1Enable=False, BG2Enable=False, BG3Enable=False, BG4Enable=False, OBJEnable=False
			.endf bits((OBJEnable << 4) | (BG4Enable << 3) | (BG3Enable << 2) | (BG2Enable << 1) | BG1Enable)

	; $00212E
	TMW								.byte ?
		TMW.Unused					= %11100000
		TMW.OBJEnable				= %00010000
		TMW.BG4Enable				= %00001000
		TMW.BG3Enable				= %00000100
		TMW.BG2Enable				= %00000010
		TMW.BG1Enable				= %00000001

		TMW_Setting .function BG1Enable=False, BG2Enable=False, BG3Enable=False, BG4Enable=False, OBJEnable=False
			.endf bits((OBJEnable << 4) | (BG4Enable << 3) | (BG3Enable << 2) | (BG2Enable << 1) | BG1Enable)

	; $00212F
	TSW								.byte ?
		TSW.Unused					= %11100000
		TSW.OBJEnable				= %00010000
		TSW.BG4Enable				= %00001000
		TSW.BG3Enable				= %00000100
		TSW.BG2Enable				= %00000010
		TSW.BG1Enable				= %00000001

		TSW_Setting .function BG1Enable=False, BG2Enable=False, BG3Enable=False, BG4Enable=False, OBJEnable=False
			.endf bits((OBJEnable << 4) | (BG4Enable << 3) | (BG3Enable << 2) | (BG2Enable << 1) | BG1Enable)

	; $002130
	CGWSEL							.byte ?
		CGWSEL.ForceBlack			= %11000000
		CGWSEL.MathEnable			= %00110000
		CGWSEL.Unused				= %00001100
		CGWSEL.SubScreen			= %00000010
		CGWSEL.DirectColor			= %00000001

		CGWSEL_BlackNever			= 0
		CGWSEL_BlackOutside			= 1
		CGWSEL_BlackInside			= 2
		CGWSEL_BlackAlways			= 3

		CGWSEL_MathAlways			= 0
		CGWSEL_MathInside			= 1
		CGWSEL_MathOutside			= 2
		CGWSEL_MathNever			= 3

		CGWSEL_Setting .function DirectColor=False, SubScreen=False, MathEnable=CGWSEL_MathAlways, ForceBlack=CGWSEL_BlackNever
			.endf bits((ForceBlack << 6) | (MathEnable << 4) | (SubScreen << 1) | DirectColor)

	; $002131
	CGADSUB							.byte ?
		CGADSUB.Operation			= %10000000
		CGADSUB.Divide				= %01000000
		CGADSUB.BackdropEnable		= %00100000
		CGADSUB.OBJEnable			= %00010000
		CGADSUB.BG4Enable			= %00001000
		CGADSUB.BG3Enable			= %00000100
		CGADSUB.BG2Enable			= %00000010
		CGADSUB.BG1Enable			= %00000001

		CGADSUB_Add					= 0
		CGADSUB_Subtract			= 1

		CGADSUB_Setting .function Operation=CGADSUB_Add, Divide=False, BG1Enable=False, BG2Enable=False, BG3Enable=False, BG4Enable=False, OBJEnable=False, BackdropEnable=False
			.endf bits((Operation << 7) | (Divide << 6) | (BackdropEnable << 5) | (OBJEnable << 4) | (BG4Enable << 3) | (BG3Enable << 2) | (BG2Enable << 1) | BG1Enable)

	; $002132
	COLDATA							.byte ?
		COLDATA.ApplyBlue			= %10000000
		COLDATA.ApplyGreen			= %01000000
		COLDATA.ApplyRed			= %00100000
		COLDATA.Intensity			= %00011111

		COLDATA_Setting .function Intensity=0, ApplyRed=False, ApplyGreen=False, ApplyBlue=False
			.endf bits((ApplyBlue << 7) | (ApplyGreen << 6) | (ApplyRed << 5) | Intensity)

	; $002133
	SETINI							.byte ?
		SETINI.EXTSync				= %10000000
		SETINI.EXTBG				= %01000000
		SETINI.Unused				= %00110000
		SETINI.PseudoHires			= %00001000
		SETINI.Overscan				= %00000100
		SETINI.OAMInterlace			= %00000010
		SETINI.Interlace			= %00000001

	; $002134
	MPY								.long ?

	; $002137
	SLHV							.byte ?

	; $002138
	RDOAM							.byte ?

	; $002139
	RDVRAM							.word ?

	; $00213B
	RDCGRAM							.byte ?

	; $00213C
	OPHCT							.byte ?

	; $00213D
	OPVCT							.byte ?

	; $00213E
	STAT77							.byte ?

	; $00213F
	STAT78							.byte ?

.endv

.virtual APU_REG_BASE

	; $002140
	APU00							.byte ?

	; $002141
	APU01							.byte ?

	; $002142
	APU02							.byte ?

	; $002143
	APU03							.byte ?

	; $002144
	APU00M1							.byte ?

	; $002145
	APU01M1							.byte ?

	; $002146
	APU02M1							.byte ?

	; $002147
	APU03M1							.byte ?

	; $002148
	APU00M2							.byte ?

	; $002149
	APU01M2							.byte ?

	; $00214A
	APU02M2							.byte ?

	; $00214B
	APU03M2							.byte ?

	; $00214C
	APU00M3							.byte ?

	; $00214D
	APU01M3							.byte ?

	; $00214E
	APU02M3							.byte ?

	; $00214F
	APU03M3							.byte ?

	; $002150
	APU00M4							.byte ?

	; $002151
	APU01M4							.byte ?

	; $002152
	APU02M4							.byte ?

	; $002153
	APU03M4							.byte ?

	; $002154
	APU00M5							.byte ?

	; $002155
	APU01M5							.byte ?

	; $002156
	APU02M5							.byte ?

	; $002157
	APU03M5							.byte ?

	; $002158
	APU00M6							.byte ?

	; $002159
	APU01M6							.byte ?

	; $00215A
	APU02M6							.byte ?

	; $00215B
	APU03M6							.byte ?

	; $00215C
	APU00M7							.byte ?

	; $00215D
	APU01M7							.byte ?

	; $00215E
	APU02M7							.byte ?

	; $00215F
	APU03M7							.byte ?

	; $002160
	APU00M8							.byte ?

	; $002161
	APU01M8							.byte ?

	; $002162
	APU02M8							.byte ?

	; $002163
	APU03M8							.byte ?

	; $002164
	APU00M9							.byte ?

	; $002165
	APU01M9							.byte ?

	; $002166
	APU02M9							.byte ?

	; $002167
	APU03M9							.byte ?

	; $002168
	APU00MA							.byte ?

	; $002169
	APU01MA							.byte ?

	; $00216A
	APU02MA							.byte ?

	; $00216B
	APU03MA							.byte ?

	; $00216C
	APU00MB							.byte ?

	; $00216D
	APU01MB							.byte ?

	; $00216E
	APU02MB							.byte ?

	; $00216F
	APU03MB							.byte ?

	; $002170
	APU00MC							.byte ?

	; $002171
	APU01MC							.byte ?

	; $002172
	APU02MC							.byte ?

	; $002173
	APU03MC							.byte ?

	; $002174
	APU00MD							.byte ?

	; $002175
	APU01MD							.byte ?

	; $002176
	APU02MD							.byte ?

	; $002177
	APU03MD							.byte ?

	; $002178
	APU00ME							.byte ?

	; $002179
	APU01ME							.byte ?

	; $00217A
	APU02ME							.byte ?

	; $00217B
	APU03ME							.byte ?

	; $00217C
	APU00MF							.byte ?

	; $00217D
	APU01MF							.byte ?

	; $00217E
	APU02MF							.byte ?

	; $00217F
	APU03MF							.byte ?

.endv

.virtual WRAM_REG_BASE

	; $002180
	WMDATA							.byte ?

	; $002181
	WMADD							.long ?

.endv

.virtual JOY_REG_BASE

	; $004016
	.union
	JOYWR							.byte ?
	JOYA							.byte ?
	.endu

	; $004017
	JOYB							.byte ?

.endv

.virtual CPU_W_REG_BASE

	; $004200
	NMITIMEN						.byte ?
		NMITIMEN.VBlankEnable		= %10000000
		NMITIMEN.Unused2			= %01000000
		NMITIMEN.VCountIRQEnable	= %00100000
		NMITIMEN.HCountIRQEnable	= %00010000
		NMITIMEN.Unused1			= %00001110
		NMITIMEN.JoypadEnable		= %00000001

		NMITIMEN_Setting .function JoypadEnable=False, HCountIRQEnable=False, VCountIRQEnable=False, VBlankEnable=False
			.endf bits((VBlankEnable << 7) | (VCountIRQEnable << 5) | (HCountIRQEnable << 4) | JoypadEnable)

	; $004201
	WRIO							.byte ?
		WRIO.IO						= %11111111
		WRIO.Joypad2Pin6			= %10000000
		WRIO.Joypad1Pin6			= %01000000

		WRIO_Setting .function Joypad1Pin6=False, Joypad2Pin6, IO=$00
			.endf bits((Joypad2Pin6 << 7) | (Joypad1Pin6 << 6) | IO)

	; $004202
	WRMPYA							.byte ?

	; $004203
	WRMPYB							.byte ?

	; $004204
	WRDIV							.word ?

	; $004206
	WRDIVB							.byte ?

	; $004207
	HTIME							.word ?

	; $004209
	VTIME							.word ?

	; $00420B
	MDMAEN							.byte ?
		MDMAEN.Channel7Enable		= %10000000
		MDMAEN.Channel6Enable		= %01000000
		MDMAEN.Channel5Enable		= %00100000
		MDMAEN.Channel4Enable		= %00010000
		MDMAEN.Channel3Enable		= %00001000
		MDMAEN.Channel2Enable		= %00000100
		MDMAEN.Channel1Enable		= %00000010
		MDMAEN.Channel0Enable		= %00000001

		MDMAEN_Setting .function Channel0Enable=False, Channel1Enable=False, Channel2Enable=False, Channel3Enable=False, Channel4Enable=False, Channel5Enable=False, Channel6Enable=False, Channel7Enable=False
			.endf bits ((Channel7Enable << 7) | (Channel6Enable << 6) | (Channel5Enable << 5) | (Channel4Enable << 4) | (Channel3Enable << 3) | (Channel2Enable << 2) | (Channel1Enable << 1) | Channel0Enable)

	; $00420C
	HDMAEN							.byte ?
	HDMAEN.Channel7Enable			= %10000000
	HDMAEN.Channel6Enable			= %01000000
	HDMAEN.Channel5Enable			= %00100000
	HDMAEN.Channel4Enable			= %00010000
	HDMAEN.Channel3Enable			= %00001000
	HDMAEN.Channel2Enable			= %00000100
	HDMAEN.Channel1Enable			= %00000010
	HDMAEN.Channel0Enable			= %00000001

	HDMAEN_Setting .function Channel0Enable=False, Channel1Enable=False, Channel2Enable=False, Channel3Enable=False, Channel4Enable=False, Channel5Enable=False, Channel6Enable=False, Channel7Enable=False
		.endf bits ((Channel7Enable << 7) | (Channel6Enable << 6) | (Channel5Enable << 5) | (Channel4Enable << 4) | (Channel3Enable << 3) | (Channel2Enable << 2) | (Channel1Enable << 1) | Channel0Enable)

	; $00420D
	MEMSEL							.byte ?
		MEMSEL.Unused				= %11111110
		MEMSEL.FastROMEnable		= %00000001

		MEMSEL_Setting .function FastROMEnable=False
			.endf bits(FastROMEnable)

.endv

.virtual CPU_R_REG_BASE

	; $004210
	RDNMI							.byte ?

	; $004211
	TIMEUP							.byte ?
		TIMEUP.IRQFlag				= %10000000
		TIMEUP.Unused				= %01111111

	; $004212
	HVBJOY							.byte ?
		HVBJOY.VBLankFlag			= %10000000
		HVBJOY.HBlankFlag			= %01000000
		HVBJOY.Unused				= %00111110
		HVBJOY.AutoJoypadFlag		= %00000001

	; $004213
	RDIO							.byte ?

	; $004214
	RDDIV							.word ?

	; $004216
	RDMPY							.word ?

	; $004218
	JOY1							.word ?

	; $00421A
	JOY2							.word ?

	; $00421C
	JOY3							.word ?

	; $00421E
	JOY4							.word ?

.endv

.virtual DMA_REG_BASE + (0 * $10)

	; $004300
	DMAP0							.byte ?
		DMAP0.TransferDirection		= %10000000
		DMAP0.AddressingMode		= %01000000
		DMAP0.Unused				= %00100000
		DMAP0.ABusStep				= %00011000
		DMAP0.TransferMode			= %00000111

		DMAPx_TransferCPUToIO		= 0
		DMAPx_TransferIOToCPU		= 1

		DMAPx_ABusIncrement			= 0
		DMAPx_ABusFixed1			= 1
		DMAPx_ABusDecrement			= 2
		DMAPx_ABusFixed2			= 3

		DMAPx_Direct				= 0
		DMAPx_Indirect				= 1

		DMAPx_Mode0					= 0 ; XX
		DMAPx_Mode1					= 1 ; XX   XX+1
		DMAPx_Mode2					= 2 ; XX   XX
		DMAPx_Mode3					= 3 ; XX   XX   XX+1 XX+1
		DMAPx_Mode4					= 4 ; XX   XX+1 XX+2 XX+3
		DMAPx_Mode5					= 5 ; XX   XX+1 XX   XX+1
		DMAPx_Mode6					= 6 ; Mode2
		DMAPx_Mode7					= 7 ; Mode3

		HDMA_DirectTableSetting .function Repeat=False, Count=0
			.endf bits((Repeat << 7) | Count)

		DMAPx_Setting .function TransferDirection=DMAPx_TransferCPUToIO, TransferMode=DMAPx_Mode0, ABusStep=DMAPx_ABusIncrement, AddressingMode=DMAPx_Direct
			.endf bits((TransferDirection << 7) | (AddressingMode << 6) | (ABusStep << 3) | TransferMode)


	; $004301
	BBAD0							.byte ?

	; $004302
	A1T0							.long ?

	; $004305
	DAS0							.long ?

	; $004308
	A2A0							.word ?

	; $00430A
	NTRL0							.byte ?

	; $00430B
	UNUSED0							.byte ?

	.fill 4

	; $00430F
	MIRR0							.byte ?

.endv

.virtual DMA_REG_BASE + (1 * $10)

	; $004310
	DMAP1							.byte ?
		DMAP1.TransferDirection		= %10000000
		DMAP1.AddressingMode		= %01000000
		DMAP1.Unused				= %00100000
		DMAP1.ABusStep				= %00011000
		DMAP1.TransferMode			= %00000111

	; $004311
	BBAD1							.byte ?

	; $004312
	A1T1							.long ?

	; $004315
	DAS1							.long ?

	; $004318
	A2A1							.word ?

	; $00431A
	NTRL1							.byte ?

	; $00431B
	UNUSED1							.byte ?

	.fill 4

	; $00431F
	MIRR1							.byte ?

.endv

.virtual DMA_REG_BASE + (2 * $10)

	; $004320
	DMAP2							.byte ?
		DMAP2.TransferDirection		= %10000000
		DMAP2.AddressingMode		= %01000000
		DMAP2.Unused				= %00100000
		DMAP2.ABusStep				= %00011000
		DMAP2.TransferMode			= %00000111

	; $004321
	BBAD2							.byte ?

	; $004322
	A1T2							.long ?

	; $004325
	DAS2							.long ?

	; $004328
	A2A2							.word ?

	; $00432A
	NTRL2							.byte ?

	; $00432B
	UNUSED2							.byte ?

	.fill 4

	; $00432F
	MIRR2							.byte ?

.endv

.virtual DMA_REG_BASE + (3 * $10)

	; $004330
	DMAP3							.byte ?
		DMAP3.TransferDirection		= %10000000
		DMAP3.AddressingMode		= %01000000
		DMAP3.Unused				= %00100000
		DMAP3.ABusStep				= %00011000
		DMAP3.TransferMode			= %00000111

	; $004331
	BBAD3							.byte ?

	; $004332
	A1T3							.long ?

	; $004335
	DAS3							.long ?

	; $004338
	A2A3							.word ?

	; $00433A
	NTRL3							.byte ?

	; $00433B
	UNUSED3							.byte ?

	.fill 4

	; $00433F
	MIRR3							.byte ?

.endv

.virtual DMA_REG_BASE + (4 * $10)

	; $004340
	DMAP4							.byte ?
		DMAP4.TransferDirection		= %10000000
		DMAP4.AddressingMode		= %01000000
		DMAP4.Unused				= %00100000
		DMAP4.ABusStep				= %00011000
		DMAP4.TransferMode			= %00000111

	; $004341
	BBAD4							.byte ?

	; $004342
	A1T4							.long ?

	; $004345
	DAS4							.long ?

	; $004348
	A2A4							.word ?

	; $00434A
	NTRL4							.byte ?

	; $00434B
	UNUSED4							.byte ?

	.fill 4

	; $00434F
	MIRR4							.byte ?

.endv

.virtual DMA_REG_BASE + (5 * $10)

	; $004350
	DMAP5							.byte ?
		DMAP5.TransferDirection		= %10000000
		DMAP5.AddressingMode		= %01000000
		DMAP5.Unused				= %00100000
		DMAP5.ABusStep				= %00011000
		DMAP5.TransferMode			= %00000111

	; $004351
	BBAD5							.byte ?

	; $004352
	A1T5							.long ?

	; $004355
	DAS5							.long ?

	; $004358
	A2A5							.word ?

	; $00435A
	NTRL5							.byte ?

	; $00435B
	UNUSED5							.byte ?

	.fill 4

	; $00435F
	MIRR5							.byte ?

.endv

.virtual DMA_REG_BASE + (6 * $10)

	; $004360
	DMAP6							.byte ?
		DMAP6.TransferDirection		= %10000000
		DMAP6.AddressingMode		= %01000000
		DMAP6.Unused				= %00100000
		DMAP6.ABusStep				= %00011000
		DMAP6.TransferMode			= %00000111

	; $004361
	BBAD6							.byte ?

	; $004362
	A1T6							.long ?

	; $004365
	DAS6							.long ?

	; $004368
	A2A6							.word ?

	; $00436A
	NTRL6							.byte ?

	; $00436B
	UNUSED6							.byte ?

	.fill 4

	; $00436F
	MIRR6							.byte ?

.endv

.virtual DMA_REG_BASE + (7 * $10)

	; $004370
	DMAP7							.byte ?
		DMAP7.TransferDirection		= %10000000
		DMAP7.AddressingMode		= %01000000
		DMAP7.Unused				= %00100000
		DMAP7.ABusStep				= %00011000
		DMAP7.TransferMode			= %00000111

	; $004371
	BBAD7							.byte ?

	; $004372
	A1T7							.long ?

	; $004375
	DAS7							.long ?

	; $004378
	A2A7							.word ?

	; $00437A
	NTRL7							.byte ?

	; $00437B
	UNUSED7							.byte ?

	.fill 4

	; $00437F
	MIRR7							.byte ?

.endv
