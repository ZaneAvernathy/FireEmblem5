
procEventTest .dstruct structProcInfo, "ec", rlProcEventTestInit, None, aProcEventTestCode ; 82/8000

rlProcEventTestInit ; 82/8008

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown000302,b
	sta $7FAE3E

	lda #$0000
	sta wUnknown000302,b

	lda wUnknown000300,b
	sta $7FAE40

	rtl

aProcEventTestCode ; 82/801D

	PROC_YIELD 1

	PROC_SET_ONCYCLE rlUnknown8288AB

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_SET_ONCYCLE rlUnknown8288D1

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_SET_ONCYCLE rlUnknown8288F7

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_SET_ONCYCLE rlUnknown82891D

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_SET_ONCYCLE rlUnknown828943

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_CALL rlProcEventTestSetBG3

	PROC_CALL rlProcEventTestClearBG1Tilemap

	PROC_SET_ONCYCLE rlProcEventTestGetJoypadInput

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_CALL rlProcEventTestHandleAction

	PROC_SET_ONCYCLE rlProcEventTestWaitForEventEnd

	PROC_YIELD 1

	PROC_SET_ONCYCLE None

	PROC_YIELD 1

	PROC_JUMP aProcEventTestCode

rlProcEventTestSetBG3 ; 82/807A

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0000
	jsl rlClearWMPortraitByIndex

	lda #$0001
	jsl rlClearWMPortraitByIndex

	lda #$0000
	jsl rsUnknown829B99

	lda #$0001
	jsl rsUnknown829B99

	lda #0
	sta wBuf_BG3HOFS

	lda #0
	sta wBuf_BG3VOFS

	lda #(`aBG3TilemapBuffer)<<8
	sta lR18+1
	lda #<>aBG3TilemapBuffer
	sta lR18
	lda #$0800
	sta wR19
	lda #$0000
	jsl rlBlockFillWord

	lda #(`$83C0F6)<<8
	sta lUnknown000DDE+1,b
	lda #<>$83C0F6
	sta lUnknown000DDE,b

	lda #$2180
	sta wUnknown000DE7,b

	ldx #(5 << 8) | 6 ; (Y << 8) | X
	lda #(`menutextEventTestTitle)<<8
	sta lR18+1
	lda #<>menutextEventTestTitle
	sta lR18
	jsl $87E728
	bra +

	.include "../../TEXT/EVENTTEST/Title.asm"

	+
	jsr rsProcEventTestUpdateText
	jsl rlResetHDMAArrayEngine
	jsl rlEnableBG3Sync
	rtl


rlProcEventTestClearBG1Tilemap ; 82/80F7

	.al
	.xl
	.autsiz
	.databank ?

	lda #(`aBG1TilemapBuffer)<<8
	sta lR18+1
	lda #<>aBG1TilemapBuffer
	sta lR18
	lda #$0800
	sta wR19
	lda #$02FF
	jsl rlBlockFillWord
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG1TilemapBuffer, $0800, VMAIN_Setting(True), $E000

	rtl

rlProcEventTestGetJoypadInput ; 82/811B

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcHeaderSleepTimer,b,x

	lda wJoy1Alt
	bit #JoypadX | JoypadA | JoypadDown | JoypadUp | JoypadStart | JoypadY | JoypadB
	bne +

	; If nothing to do

	jmp _End

	+
	ldx wProcIndex,b
	bit #JoypadUp
	bne _Up

	bit #JoypadDown
	beq ++

	; aProcBody0 is which option we're hovering
	; over, 0-2

	lda aProcBody0,b,x
	inc a
	cmp #$0003
	blt +

	; Loop around back to the first option

	lda #$0000
	bra +

	_Up
	lda aProcBody0,b,x
	dec a
	bpl +

	; Loop around to the last option

	lda #$0002

	+
	sta aProcBody0,b,x
	bra _End

	+

	; If not moving up or down
	; check for changes to numbers

	; Grab which option number we're on

	jsr rsProcEventTestGetOptionNumberOffset

	lda wJoy1Alt
	bit #JoypadA
	beq +

	; Add 1 to number

	inc $0000,b,x
	jsr rsProcEventTestUpdateText
	bra _End

	+
	bit #JoypadB
	beq +

	; Sub 1 from number

	dec $0000,b,x
	jsr rsProcEventTestUpdateText
	bra _End

	+
	bit #JoypadX
	beq +

	; Add 10 to number

	lda $0000,b,x
	clc
	adc #10
	sta $0000,b,x
	jsr rsProcEventTestUpdateText
	bra _End

	+
	bit #JoypadY
	beq +

	; Sub 10 from number

	lda $0000,b,x
	sec
	sbc #10
	sta $0000,b,x
	jsr rsProcEventTestUpdateText
	bra _End

	+
	bit #JoypadStart
	beq _End

	; Sleep until start is pressed

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x
	plx

	_End
	ldx wProcIndex,b
	jsr rsProcEventTestDrawCursor
	rtl


rsProcEventTestUpdateText ; 82/81AF

	.al
	.xl
	.autsiz

	; Write option labels

	lda #(`$83C0F6)<<8
	sta lUnknown000DDE+1,b
	lda #<>$83C0F6
	sta lUnknown000DDE,b

	lda #$2180
	sta wUnknown000DE7,b

	ldx #(10 << 8) | 8 ; (Y << 8) | X
	lda #(`menutextEventTestEventLabel)<<8
	sta lR18+1
	lda #<>menutextEventTestEventLabel
	sta lR18
	jsl $87E728
	bra +

	.include "../../TEXT/EVENTTEST/EventLabel.asm"

	+
	ldx #(12 << 8) | 8 ; (Y << 8) | X
	lda #(`menutextEventTestConversationLabel)<<8
	sta lR18+1
	lda #<>menutextEventTestConversationLabel
	sta lR18
	jsl $87E728
	bra +

	.include "../../TEXT/EVENTTEST/ConversationLabel.asm"

	+
	ldx #(14 << 8) | 8 ; (Y << 8) | X
	lda #(`menutextEventTestMapSelectLabel)<<8
	sta lR18+1
	lda #<>menutextEventTestMapSelectLabel
	sta lR18
	jsl $87E728
	bra +

	.include "../../TEXT/EVENTTEST/MapSelectLabel.asm"

	+
	lda #(`$83C0F6)<<8
	sta lUnknown000DDE+1,b
	lda #<>$83C0F6
	sta lUnknown000DDE,b

	lda #$22A0
	sta wUnknown000DE7,b

	; Write event number

	ldx wProcIndex,b

	lda aProcBody1,b,x
	sta lR18
	stz lR18+2
	stz lR19+1
	jsl $85870E
	lda _aEventNumberCoordinates
	tax
	jsl $8587D0

	; write conversation number

	ldx wProcIndex,b

	lda aProcBody2,b,x
	sta lR18
	stz lR18+2
	stz lR19+1
	jsl $85870E
	lda _aConversationNumberCoordinates
	tax
	jsl $8587D0

	; clamp chapter values
	; for some reason exclude chapter 1

	ldx wProcIndex,b

	lda aProcBody3,b,x
	cmp #ChapterUnknown
	blt +

	lda #Chapter2 - 1
	sta aProcBody3,b,x

	+
	asl a
	tax
	lda #(`menutextEventTestMap01)<<8
	sta lR18+1
	lda <>aEventTestMapSelectNames,b,x
	sta lR18
	lda _aMapSelectNumberCoordinates
	tax
	lda #$2180
	sta wUnknown000DE7,b
	jsl $87E728
	jsl rlEnableBG3Sync
	rts

	_aEventNumberCoordinates ; 82/82B7
		.word (10 << 8) | 18

	_aConversationNumberCoordinates ; 82/82B9
		.word (12 << 8) | 18

	_aMapSelectNumberCoordinates ; 82/82BB
		.word (14 << 8) | 18

.include "../../TABLES/EventTestMapSelectNames.asm"

.include "../../TEXT/EVENTTEST/Map01.asm"
.include "../../TEXT/EVENTTEST/Map02.asm"
.include "../../TEXT/EVENTTEST/Map02x.asm"
.include "../../TEXT/EVENTTEST/Map03.asm"
.include "../../TEXT/EVENTTEST/Map04.asm"
.include "../../TEXT/EVENTTEST/Map04x.asm"
.include "../../TEXT/EVENTTEST/Map05.asm"
.include "../../TEXT/EVENTTEST/Map06.asm"
.include "../../TEXT/EVENTTEST/Map07.asm"
.include "../../TEXT/EVENTTEST/Map08.asm"
.include "../../TEXT/EVENTTEST/Map08x.asm"
.include "../../TEXT/EVENTTEST/Map09.asm"
.include "../../TEXT/EVENTTEST/Map10.asm"
.include "../../TEXT/EVENTTEST/Map11.asm"
.include "../../TEXT/EVENTTEST/Map11x.asm"
.include "../../TEXT/EVENTTEST/Map12.asm"
.include "../../TEXT/EVENTTEST/Map12x.asm"
.include "../../TEXT/EVENTTEST/Map13.asm"
.include "../../TEXT/EVENTTEST/Map14.asm"
.include "../../TEXT/EVENTTEST/Map14x.asm"
.include "../../TEXT/EVENTTEST/Map15.asm"
.include "../../TEXT/EVENTTEST/Map16A.asm"
.include "../../TEXT/EVENTTEST/Map17A.asm"
.include "../../TEXT/EVENTTEST/Map16B.asm"
.include "../../TEXT/EVENTTEST/Map17B.asm"
.include "../../TEXT/EVENTTEST/Map18.asm"
.include "../../TEXT/EVENTTEST/Map19.asm"
.include "../../TEXT/EVENTTEST/Map20.asm"
.include "../../TEXT/EVENTTEST/Map21.asm"
.include "../../TEXT/EVENTTEST/Map21x.asm"
.include "../../TEXT/EVENTTEST/Map22.asm"
.include "../../TEXT/EVENTTEST/Map23.asm"
.include "../../TEXT/EVENTTEST/Map24.asm"
.include "../../TEXT/EVENTTEST/Map24x.asm"
.include "../../TEXT/EVENTTEST/Map25.asm"
.include "../../TEXT/EVENTTEST/WorldMap.asm"

rlProcEventTestHandleAction ; 82/84FD

	.al
	.xl
	.autsiz
	.databank ?

	; Figure out what to do by the option
	; we're on

	lda aProcBody0,b,x
	beq _Event

	cmp #$0001
	beq _Conversation

	cmp #$0002
	bne +

	jmp _Map

	+
	rtl

	_Event

	; Get event number

	phx
	lda aProcBody1,b,x
	cmp #$0000
	blt +

	lda #$0000

	+

	; The table ahead was probably meant to
	; be a table of long pointers to
	; chapter events but is instead
	; pointing to chapter 24's data

	sta wR0
	asl a
	clc
	adc wR0
	tax
	lda $99F2A4,x
	sta lR18
	lda $99F2A4+1,x
	sta lR18+1

	; Start events?

	jsl rlUnknown8C839F

	lda #(`aBG3TilemapBuffer)<<8
	sta lR18+1
	lda #<>aBG3TilemapBuffer
	sta lR18
	lda #$0800
	sta wR19
	lda #$01DF
	jsl rlBlockFillWord
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG3TilemapBuffer, $0800, VMAIN_Setting(True), $A000

	plx
	jsl rlProcEngineFreeProc
	rtl

	_Conversation

	phx
	jsl rlUnknown8CCA8C

	; Get pointer to dialogue

	lda aProcBody2,b,x
	cmp #$0344 ; size(aChapterDialoguePointers) / 3
	blt +

	lda #$0000

	+
	sta wR0
	asl a
	clc
	adc wR0
	tax
	lda aChapterDialoguePointers,x
	sta lR18
	lda aChapterDialoguePointers+1,x
	sta lR18+1
	jsl rlUnknown8289AE

	lda #(`aBG3TilemapBuffer)<<8
	sta lR18+1
	lda #<>aBG3TilemapBuffer
	sta lR18
	lda #$0800
	sta wR19
	lda #$01DF
	jsl rlBlockFillWord
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG3TilemapBuffer, $0800, VMAIN_Setting(True), $A000

	plx
	rtl

	_Map

	phx
	lda aProcBody3,b,x
	sta wCurrentChapter,b
	phx
	lda #(`procMapSwitch)<<8
	sta lR43+1
	lda #<>procMapSwitch
	sta lR43
	jsl rlProcEngineCreateProc

	plx
	plx
	jsl rlProcEngineFreeProc
	rtl

rlProcEventTestWaitForEventEnd ; 82/85C5

	.al
	.xl
	.autsiz
	.databank ?

	stz aProcHeaderSleepTimer,b,x
	phx
	jsl rlUnknown828965
	plx
	lda wEventEngineStatus,b
	bne +

	lda wUnknown0017E9,b
	bne +

	phx
	ldx wProcIndex,b
	lda #$0001
	sta aProcHeaderSleepTimer,b,x
	plx

	+
	rtl

rsProcEventTestGetOptionNumberOffset ; 82/85E4

	.al
	.xl
	.autsiz
	.databank ?

	lda aProcBody0,b,x
	asl a
	tax
	lda _aOptionOffsets,x
	clc
	adc wProcIndex,b
	tax
	rts

	_aOptionOffsets ; 82/85F3
		.word aProcBody1
		.word aProcBody2
		.word aProcBody3


rsProcEventTestDrawCursor ; 82/85F9

	.al
	.xl
	.autsiz
	.databank ?

	phx
	lda aProcBody0,b,x
	asl a
	asl a
	tax
	lda <>_aCursorCoordinateTable,b,x
	sta wR0
	lda <>_aCursorCoordinateTable+2,b,x
	sta wR1
	jsl $859013
	plx
	rts

	_aCursorCoordinateTable ; 82/8610
		.word 48, 80
		.word 48, 96
		.word 48, 112
