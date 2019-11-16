
structChapterEventPointers .struct Opening, Turn, Talk, Location, BeforeAction, Shop, Battle, Ending, AfterAction, PrepGroups
	OpeningEventDefinitions			.long \Opening
	TurnEventDefinitions			.long \Turn
	TalkEventDefinitions			.long \Talk
	LocationEventDefinitions		.long \Location
	BeforeActionEventDefinitions	.long \BeforeAction
	ShopEventDefinitions			.long \Shop
	BattleEventDefinitions			.long \Battle
	EndingEvent						.long \Ending
	AfterActionEventDefinitions		.long \AfterAction
	PrepGroups						.long \PrepGroups
	.ends

structEventHandlerPointer .struct Pointer
	Pointer .addr \Pointer
	.ends

; End codes

END_DEFINITION .segment
	.char -1
	.endm

END_DEFINITION_ARRAY .segment
	.sint -1
	.endm

END1 .segment
	.char -1
	.endm

END2 .segment
	.char -2
	.endm

END3 .segment
	.char -3
	.endm

; Condition codes

CHECK_CHARS1 .segment Char1, Char2
	.byte $00
	.word \Char1
	.word \Char2
	.endm

CHECK_CHARS2 .segment Char1, Char2
	.byte $01
	.word \Char1
	.word \Char2
	.endm

CHECK_SINGLE .segment Char
	.byte $02
	.word \Char
	.endm

CHECK_COORDS .segment Coords
	.byte $03
	.byte \Coords[0], \Coords[1]
	.endm

CMP_BITS .segment Address, Value
	.byte $04
	.long \Address
	.word \Value
	.endm

CMP_BYTE .segment Address, Value
	.byte $05
	.long \Address
	.byte \Value
	.endm

CMP_WORD .segment Address, Value
	.byte $06
	.long \Address
	.word \Value
	.endm

CMP_LONG .segment Address, Value
	.byte $07
	.long \Address
	.long \Value
	.endm

CMP_WORD_FALSE .segment Address, Value
	.byte $08
	.long \Address
	.word \Value
	.endm

CMP_BYTE_AT .segment Address1, Address2
	.byte $09
	.long \Address1
	.long \Address2
	.endm

CMP_WORD_AT .segment Address1, Address2
	.byte $0A
	.long \Address1
	.long \Address2
	.endm

CMP_BYTE_RANGE .segment Address, Min, Max
	.byte $0B
	.long \Address
	.byte \Min
	.byte \Max
	.endm

CMP_WORD_RANGE .segment Address, Min, Max
	.byte $0C
	.long \Address
	.word \Min
	.word \Max
	.endm

TEST_FLAG_SET .segment Flag
	.byte $0D
	.byte \Flag
	.endm

TEST_FLAG_UNSET .segment Flag
	.byte $0E
	.byte \Flag
	.endm

RUN_ASM .segment Address
	.byte $0F
	.long \Address
	.endm

CMP_STATUS_SET .segment Char, Status
	.byte $10
	.word \Char
	.word \Status
	.endm

CMP_STATUS_UNSET .segment Char, Status
	.byte $11
	.word \Char
	.word \Status
	.endm

COND_UNK_12 .segment Char
	.byte $12
	.word \Char
	.endm

COND_UNK_13 .segment Char
	.byte $13
	.word \Char
	.endm

CHECK_CARRYING .segment Char
	.byte $14
	.word \Char
	.endm

COND_UNK_15 .segment Char
	.byte $15
	.word \Char
	.endm

CHECK_NUM_UNITS_LTE .segment Char, Number
	.byte $16
	.word \Char
	.byte \Number
	.endm

CHECK_NUM_UNITS_GTE .segment Char, Number
	.byte $17
	.word \Char
	.byte \Number
	.endm

ROLL_RNG .segment Max
	.byte $18
	.byte \Max
	.endm

CHECK_IF_RANDOM_CHEST .segment
	.byte $19
	.endm

CHECK_DEAD .segment Char
	.byte $1A
	.word \Char
	.endm

KILLED_IN_BATTLE .segment Char
	.byte $1B
	.word \Char
	.endm

; Event codes

EVENT .segment Flag, Address
	.byte \Flag
	.long \Address
	.endm

YIELD_UNK .segment
	.byte YIELD_UNK_Identifier
	.endm

EVENT_NOP_01 .segment
	.byte NOP_01_Identifier
	.endm

JUMP .segment Address
	.byte JUMP_Identifier
	.addr \Address
	.endm

JUMP_TRUE .segment Address
	.byte JUMP_TRUE_Identifier
	.addr \Address
	.endm

JUMP_FALSE .segment Address
	.byte JUMP_FALSE_Identifier
	.addr \Address
	.endm

JUMP_DISTANCE .segment Distance
	.byte JUMP_DISTANCE_Identifier
	.word \Distance
	.endm

JUMP_DISTANCE_TRUE .segment Distance
	.byte JUMP_DISTANCE_TRUE_Identifier
	.word \Distance
	.endm

JUMP_DISTANCE_FALSE .segment Distance
	.byte JUMP_DISTANCE_FALSE_Identifier
	.word \Distance
	.endm

EVENT_CMP_BYTE_AT_LT .segment Address, Value
	.byte CMP_BYTE_AT_LT_Identifier
	.long \Address
	.byte \Value
	.endm

EVENT_CMP_WORD_AT_LT .segment Address, Value
	.byte CMP_WORD_AT_LT_Identifier
	.long \Address
	.word \Value
	.endm

EVENT_CMP_BYTE_AT_EQ .segment Address, Value
	.byte CMP_BYTE_AT_EQ_Identifier
	.long \Address
	.byte \Value
	.endm

EVENT_CMP_WORD_AT_EQ .segment Address, Value
	.byte CMP_WORD_AT_EQ_Identifier
	.long \Address
	.word \Value
	.endm

SET_FLAG .segment Flag
	.byte SET_FLAG_Identifier
	.byte \Flag
	.endm

UNSET_FLAG .segment Flag
	.byte UNSET_FLAG_Identifier
	.byte \Flag
	.endm

EVENT_TEST_FLAG_SET .segment Flag
	.byte TEST_FLAG_SET_Identifier
	.byte \Flag
	.endm

STORE_BYTE .segment Address, Byte
	.byte STORE_BYTE_Identifier
	.long \Address
	.byte \Byte
	.endm

STORE_WORD .segment Address, Word
	.byte STORE_WORD_Identifier
	.long \Address
	.word \Word
	.endm

STORE_LONG .segment Address, Long
	.byte STORE_LONG_Identifier
	.long \Address
	.long \Long
	.endm

STORE_BYTE_FROM .segment Address1, Address2
	.byte STORE_BYTE_FROM_Identifier
	.long \Address1
	.long \Address2
	.endm

STORE_WORD_FROM .segment Address1, Address2
	.byte STORE_WORD_FROM_Identifier
	.long \Address1
	.long \Address2
	.endm

STORE_LONG_FROM .segment Address1, Address2
	.byte STORE_LONG_FROM_Identifier
	.long \Address1
	.long \Address2
	.endm

ADD_BYTE .segment Address, Value
	.byte ADD_BYTE_Identifier
	.long \Address
	.byte \Value
	.endm

ADD_WORD .segment Address, Value
	.byte ADD_WORD_Identifier
	.long \Address
	.word \Value
	.endm

ADD_LONG .segment Address, Value
	.byte ADD_LONG_Identifier
	.long \Address
	.long \Value
	.endm

ORR_BYTE .segment Address, Value
	.byte ORR_BYTE_Identifier
	.long \Address
	.byte \Value
	.endm

ORR_WORD .segment Address, Value
	.byte ORR_WORD_Identifier
	.long \Address
	.word \Value
	.endm

ORR_LONG .segment Address, Value
	.byte ORR_LONG_Identifier
	.long \Address
	.long \Value
	.endm

CALL_ASM_SKIPPABLE .segment Address, Arg
	.byte CALL_ASM_SKIPPABLE_Identifier
	.long \Address
	.word \Arg
	.endm

CALL_ASM_LONG_SKIPPABLE .segment Address, Arg
	.byte CALL_ASM_LONG_SKIPPABLE_Identifier
	.long \Address
	.long \Arg
	.endm

CALL_ASM_LOOP .segment Address, Arg
	.byte CALL_ASM_LOOP_Identifier
	.long \Address
	.word \Arg
	.endm

PAUSE_SKIPPABLE .segment Time
	.byte PAUSE_SKIPPABLE_Identifier
	.word \Time
	.endm

PAUSE .segment Value
	.byte PAUSE_Identifier
	.word \Value
	.endm

EVENT_UNK_20 .segment
	.byte UNK_20_Identifier
	.endm

EVENT_UNK_21 .segment Value
	.byte UNK_21_Identifier
	.word \Value
	.endm

HALT_UNTIL_BYTE .segment Address, Byte
	.byte HALT_UNTIL_BYTE_Identifier
	.long \Address
	.byte \Byte
	.endm

HALT_UNTIL_WORD .segment Address, Word
	.byte HALT_UNTIL_WORD_Identifier
	.long \Address
	.word \Word
	.endm

HALT_UNTIL_BYTE_SKIPPABLE .segment Address, Byte
	.byte HALT_UNTIL_BYTE_SKIPPABLE_Identifier
	.long \Address
	.byte \Byte
	.endm

HALT_UNTIL_WORD_SKIPPABLE .segment Address, Word
	.byte HALT_UNTIL_WORD_SKIPPABLE_Identifier
	.long \Address
	.word \Word
	.endm

FADE_IN .segment Step
	.byte FADE_IN_Identifier
	.byte \Step
	.endm

FADE_OUT .segment Step
	.byte FADE_OUT_Identifier
	.byte \Step
	.endm

EVENT_UNK_28 .segment Value1, Value2
	.byte UNK_28_Identifier
	.long \Value1
	.long \Value2
	.endm

EVENT_UNK_29 .segment
	.byte UNK_29_Identifier
	.endm

EVENT_UNK_2A .segment
	.byte UNK_2A_Identifier
	.endm

DIALOGUE .segment Address
	.byte DIALOGUE_Identifier
	.long \Address
	.endm

DIALOGUE_ARRAY .segment Address
	.byte DIALOGUE_ARRAY_Identifier
	.long \Address
	.endm

EVENT_UNK_2D .segment Value1, Value2
	.byte UNK_2D_Identifier
	.long \Value1
	.word \Value2
	.endm

EVENT_UNK_2E .segment
	.byte UNK_2E_Identifier
	.endm

EVENT_UNK_2F .segment Value
	.byte UNK_2F_Identifier
	.long \Value
	.endm

EVENT_UNK_30 .segment Value
	.byte UNK_30_Identifier
	.long \Value
	.endm

SET_MUSIC .segment Song
	.byte SET_MUSIC_Identifier
	.byte \Song
	.endm

EVENT_UNK_32 .segment Value
	.byte UNK_32_Identifier
	.byte \Value
	.endm

EVENT_NOP_33 .segment Value
	.byte NOP_33_Identifier
	.byte \Value
	.endm

PLAY_SOUND_BYTE .segment Sound
	.byte PLAY_SOUND_BYTE_Identifier
	.byte \Sound
	.endm

PLAY_SOUND_WORD .segment Sound
	.byte PLAY_SOUND_WORD_Identifier
	.word \Sound
	.endm

RESET_PHASE_MUSIC .segment
	.byte RESET_PHASE_MUSIC_Identifier
	.endm

SCROLL_CAMERA_CHAR .segment Char
	.byte SCROLL_CAMERA_CHAR_Identifier
	.byte \Char
	.endm

SET_ACTIVE_COORDS .segment
	.byte SET_ACTIVE_COORDS_Identifier
	.endm

SET_CAMERA .segment Coords
	.byte SET_CAMERA_Identifier
	.byte \Coords[0], \Coords[1]
	.endm

EVENT_UNK_3A .segment Value
	.byte UNK_3A_Identifier
	.byte \Value
	.endm

EVENT_NOP_3B .segment
	.byte NOP_3B_Identifier
	.endm

EVENT_NOP_3C .segment Value
	.byte NOP_3C_Identifier
	.long \Value
	.endm

SCROLL_CAMERA_SPEED .segment Coords, Speed
	.byte SCROLL_CAMERA_SPEED_Identifier
	.byte \Coords[0], \Coords[1]
	.byte \Speed
	.endm

SET_CAMERA_SPEED .segment Speed
	.byte SET_CAMERA_SPEED_Identifier
	.byte \Speed
	.endm

MOVE_TEMPORARY .segment Char, StartCoords, Speed, Color, Movestring
	.byte MOVE_TEMPORARY_Identifier
	.word \Char
	.byte \StartCoords[0], \StartCoords[1]
	.byte \Speed
	.byte \Color
	.long \Movestring
	.endm

MOVE_TEMPORARY_UNK .segment Char, StartCoords, Speed, Color, Movestring
	.byte MOVE_TEMPORARY_UNK_Identifier
	.word \Char
	.byte \StartCoords[0], \StartCoords[1]
	.byte \Speed
	.byte \Color
	.long \Movestring
	.endm

MOVE_UNIT .segment Char, TargetCoords, MoveCoords, Speed, MoveData
	.byte MOVE_UNIT_Identifier
	.word \Char
	.byte \TargetCoords[0], \TargetCoords[1]
	.byte \MoveCoords[0], \MoveCoords[1]
	.byte \Speed
	.long \MoveData
	.endm

LOAD1 .segment UnitPointer
	.byte LOAD1_Identifier
	.long \UnitPointer
	.endm

LOAD2 .segment UnitPointer
	.byte LOAD2_Identifier
	.long \UnitPointer
	.endm

SCROLL_CAMERA_ADDRESS .segment Address
	.byte SCROLL_CAMERA_ADDRESS_Identifier
	.long \Address
	.endm

WAIT_MOVE .segment
	.byte WAIT_MOVE_Identifier
	.endm

WARP_UNIT .segment Char, TargetCoords, MoveCoords
	.byte WARP_UNIT_Identifier
	.word \Char
	.byte \TargetCoords[0], \TargetCoords[1]
	.byte \MoveCoords[0], \MoveCoords[1]
	.endm

YIELD .segment
	.char -4
	.endm

; Movement strings

MS_END .segment
	.byte $00
	.endm

MS_MOVE_DOWN .segment
	.byte $01
	.endm

MS_MOVE_LEFT .segment
	.byte $02
	.endm

MS_MOVE_UP .segment
	.byte $03
	.endm

MS_MOVE_RIGHT .segment
	.byte $04
	.endm

MS_FACE_DOWN .segment Time
	.byte $05
	.word \Time
	.endm

MS_FACE_LEFT .segment Time
	.byte $06
	.word \Time
	.endm

MS_FACE_UP .segment Time
	.byte $07
	.word \Time
	.endm

MS_FACE_RIGHT .segment Time
	.byte $08
	.word \Time
	.endm

MS_MOVE_DOWN_KEEP_DIRECTION .segment
	.byte $09
	.endm

MS_MOVE_LEFT_KEEP_DIRECTION .segment
	.byte $0A
	.endm

MS_MOVE_UP_KEEP_DIRECTION .segment
	.byte $0B
	.endm

MS_MOVE_RIGHT_KEEP_DIRECTION .segment
	.byte $0C
	.endm

MS_DEATH_EFFECT .segment
	.byte $0D
	.endm

MS_MOVESTAR_EFFECT .segment
	.byte $0E
	.endm

MS_IN_PLACE .segment
	.byte $0F
	.endm

MS_INVIS .segment
	.byte $10
	.endm

MS_SET_SPEED .segment Speed
	.byte $80 | \Speed
	.endm

; Unit code

UNIT .segment Char=None, Allegiance=None, StartCoords=None, MoveCoords=None, Leader=None, Inventory=None, Level=None, BossFlag=None, AI=None
	.if \Char == None
		.word $0000 ; End of unit block
	.else
		.word \Char
		.byte (\StartCoords[0] | \Allegiance), \StartCoords[1]
		.byte \MoveCoords[0], \MoveCoords[1]
		.word \Leader
		.for i = 0, i < 7, i += 1
			.if i < len(\Inventory)
				.byte \Inventory[i]
			.else
				.byte $00
			.endif
		.next
		.byte \Level | (\BossFlag << 7)
		.byte \AI[0], \AI[1], \AI[2], \AI[3]
	.endif
	.endm

structUNITEntry .struct
	; Less of a macro and more a description of the structure
	Character		.word ? ; $00
	.union
		StartX		.byte ? ; $02
		Allegiance	.byte ? ; $02 Uppermost 2 bits
	.endu
	StartY			.byte ? ; $03
	MoveX			.byte ? ; $04
	MoveY			.byte ? ; $05
	Leader			.word ? ; $06
	.union
	Items			.fill 7 ; $08
		.struct
			Item1	.byte ? ; $08
			Item2	.byte ? ; $09
			Item3	.byte ? ; $0A
			Item4	.byte ? ; $0B
			Item5	.byte ? ; $0C
			Item6	.byte ? ; $0D
			Item7	.byte ? ; $0E
		.ends
	.endu
	.union
		Level		.byte ? ; $0F
		BossFlag	.byte ? ; $0F Uppermost bit
	.endu
	.union
		AI			.fill 4 ; $10
		.struct
			AI1		.byte ? ; $10
			AI2		.byte ? ; $11
			AI3		.byte ? ; $12
			AI4		.byte ? ; $13
		.ends
	.endu
	.ends

; Shop code

SHOP .segment Coords, Items
	.byte \Coords[0]
	.byte \Coords[1]
	.for i = 0, i < 7, i += 1
		.if i < len(\Items)
			.word \Items[i]
		.else
			.word $0000
		.endif
	.next
	.word $0000
	.endm
