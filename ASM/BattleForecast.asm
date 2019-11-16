
rlGetBattleForecastBGTiles ; 81/BF00

	.autsiz
	.databank ?

	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $F4C000, $0800, VMAIN_Setting(True), $4000

	rtl

rlSetBattleForecastWindowShading ; 81/BF0E

	.al
	.xl
	.autsiz
	.databank ?

	jsl $8591F0
	lda #$0008
	sta wR0
	lda #$0010
	sta wR1
	jsl $859219
	jsl $859205
	lda #$0040
	sta wR1
	lda #$0080
	sta wR2
	jsl $85946B
	rtl

rlBuildBattleForecastWindow ; 81/BF33

	.al
	.xl
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`aBG1TilemapBuffer
	pha
	rep #$20
	plb

	.databank `aBG1TilemapBuffer

	; 0 for left, 2 for right side

	stx wR17

	; Clear tilemaps

	lda #<>aBG1TilemapBuffer
	sta wR0
	lda #$02FF
	jsl rlFillTilemapByWord

	lda #<>aBG3TilemapBuffer
	sta wR0
	lda #$01DF
	jsl rlFillTilemapByWord

	; This does the bulk of populating the window

	jsr rsBuildBattleForecastWindowTilemap
	jsr rsColorBattleForecastWindowCenter
	jsr rsDrawBattleForecastUnitText
	jsr rsDrawBattleForecastNumbers
	jsr rsBattleForecastCopyAllegiancePalette

	; Setup horizontal shading boundaries

	lda wR17
	sta wProcInput0,b
	phx
	lda #(`procBattleForecastCenterShadingHBounds)<<8
	sta lR43+1
	lda #<>procBattleForecastCenterShadingHBounds
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	jsl rlEnableBG1Sync
	jsl rlEnableBG3Sync
	plb
	plp
	rtl

rsBuildBattleForecastWindowTilemap ; 81/BF86

	.al
	.xl
	.autsiz
	.databank `aBG1TilemapBuffer

	stz wUnknown000DE7,b

	; Copy segments of the window's tilemap
	; Starting with the BG1 tiles

	; Uppermost tilemap segment

	; Tilemap

	lda #<>$F4F9C0
	sta lR18
	lda #>`$F4F9C0
	sta lR18+1

	; Width

	lda #10
	sta wR0

	; Height

	lda #9
	sta wR1

	; Get buffer position based on side

	ldx wR17
	lda aBattleForecastWindowTilemapSegmentOffsets,x
	sta wR19
	jsl $84A3FF

	; Middle tilemap segment

	lda #<>$F4F9D6
	sta lR18
	lda #>`$F4F9D6
	sta lR18+1
	lda #10
	sta wR0
	lda #9
	sta wR1
	ldx wR17
	lda aBattleForecastWindowTilemapSegmentOffsets+4,x
	sta wR19
	jsl $84A3FF

	; Lower tilemap segment

	lda #<>$F4F9EC
	sta lR18
	lda #>`$F4F9EC
	sta lR18+1
	lda #10
	sta wR0
	lda #8
	sta wR1
	ldx wR17
	lda aBattleForecastWindowTilemapSegmentOffsets+8,x
	sta wR19
	jsl $84A3FF

	; Now for the BG3 tiles

	; Upper segment

	lda #<>$F1FA80
	sta lR18
	lda #>`$F1FA80
	sta lR18+1
	lda #11
	sta wR0
	lda #14
	sta wR1
	ldx wR17
	lda aBattleForecastWindowTilemapSegmentOffsets+12,x
	sta wR19
	jsl $84A3FF

	; Lower segment

	lda #<>$F1FA96
	sta lR18
	lda #>`$F1FA96
	sta lR18+1
	lda #11
	sta wR0
	lda #14
	sta wR1
	ldx wR17
	lda aBattleForecastWindowTilemapSegmentOffsets+16,x
	sta wR19
	jsl $84A3FF

	rts

aBattleForecastWindowTilemapSegmentOffsets ; 81/C02A

	.word <>aBG1TilemapBuffer + ( 1 * 2) + ( 1 * $40) ; (X * 2) | (Y * $40)
	.word <>aBG1TilemapBuffer + (21 * 2) + ( 1 * $40)

	.word <>aBG1TilemapBuffer + ( 1 * 2) + (10 * $40)
	.word <>aBG1TilemapBuffer + (21 * 2) + (10 * $40)

	.word <>aBG1TilemapBuffer + ( 1 * 2) + (19 * $40)
	.word <>aBG1TilemapBuffer + (21 * 2) + (19 * $40)

	.word <>aBG3TilemapBuffer + ( 1 * 2) + ( 1 * $40)
	.word <>aBG3TilemapBuffer + (21 * 2) + ( 1 * $40)

	.word <>aBG3TilemapBuffer + ( 1 * 2) + (14 * $40)
	.word <>aBG3TilemapBuffer + (21 * 2) + (14 * $40)

rsDrawBattleForecastUnitText ; 81/C03E

	.al
	.xl
	.autsiz
	.databank `aBG1TilemapBuffer

	; Fetch side

	ldx wR17
	lda aBattleForecastUnitInfoSideTable,x
	sta wR16

	; Text info

	lda #<>$83C0F6
	sta lUnknown000DDE,b
	lda #>`$83C0F6
	sta lUnknown000DDE+1,b
	lda #$2180
	sta wUnknown000DE7,b

	; Draw labels

	lda aActionStructUnit2.Character
	jsl $839334

	lda #1 | (1 << 8) ; X | (Y << 8)
	clc
	adc wR16
	tax
	jsl $87E728

	lda aActionStructUnit2.Class
	jsl $839351
	lda #1 | (3 << 8)
	clc
	adc wR16
	tax
	jsl $87E728

	sep #$20
	lda aActionStructUnit2.EquippedItemMaxDurability
	xba
	lda aActionStructUnit2.EquippedItemID1
	rep #$30
	jsl rlCopyItemDataToBuffer
	jsl $83931A
	lda #1 | (5 << 8)
	clc
	adc wR16
	tax
	jsl $87E728

	lda aActionStructUnit1.Character
	jsl $839334
	jsl $87E873

	sta wR0
	lda #9 | (23 << 8)
	sec
	sbc wR0
	clc
	adc wR16
	tax
	jsl $87E728

	rts

aBattleForecastUnitInfoSideTable ; 81/C0B6

	.byte 1, 1
	.byte 21, 1

rsDrawBattleForecastNumbers ; 81/C0BA

	.al
	.xl
	.autsiz
	.databank `aBG1TilemapBuffer

	lda #$2AA0
	sta wUnknown000DE7,b

	; Loop counter

	stz wR15

	; Loop through all stats to be shown

	-
	ldx wR15

	; First we check this stat to see if the number
	; is applicable, i.e. you need a weapon to show might

	; If there's no pointer then skip

	lda aBattleForecastNumberInfo,x
	beq +

	; End of table

	cmp #-1
	beq _End

	; If the required stat is FF, mark shown stat as --

	tay
	lda $0000,b,y
	and #$00FF
	beq _StatDashed

	+
	stz lR18+1

	; Get stat to show, mark as -- if not applicable

	lda aBattleForecastNumberInfo+2,x
	tay
	lda $0000,b,y
	and #$00FF
	cmp #$00FF
	beq _StatDashed

	sta lR18

	; Get the coordinates and draw

	lda aBattleForecastNumberInfo+4,x
	clc
	adc wR16
	tax
	jsl $858859

	_Next
	lda wR15
	clc
	adc #$0006
	sta wR15
	bra -

	_End
	rts

	_StatDashed
	lda #$2980
	sta wUnknown000DE7,b

	; Get coords and move left a tile
	; to account for -- being two tiles

	lda aBattleForecastNumberInfo+4,x
	dec a
	clc
	adc wR16
	tax

	; Draw -- string

	lda #<>menutextDoubleDash
	sta lR18
	lda #>`menutextDoubleDash
	sta lR18+1
	jsl $87E728
	lda #$2AA0
	sta wUnknown000DE7,b
	bra _Next

aBattleForecastNumberInfo ; 81/C128

	.word None
	.word <>aActionStructUnit2.StartingLevel
	.byte 2, 8

	.word None
	.word <>aActionStructUnit2.StartingCurrentHP
	.byte 2, 10

	.word <>aActionStructUnit2.EquippedItemID2
	.word <>aActionStructUnit2.BattleMight
	.byte 2, 12

	.word None
	.word <>aActionStructUnit2.BattleDefense
	.byte 2, 14

	.word <>aActionStructUnit2.EquippedItemID2
	.word <>aActionStructUnit2.BattleAdjustedHit
	.byte 2, 16

	.word <>aActionStructUnit2.EquippedItemID2
	.word <>aActionStructUnit2.BattleAdjustedCrit
	.byte 2, 18

	.word None
	.word <>aActionStructUnit2.BattleAttackSpeed
	.byte 2, 20

	.word None
	.word <>aActionStructUnit1.StartingLevel
	.byte 8, 8

	.word None
	.word <>aActionStructUnit1.StartingCurrentHP
	.byte 8, 10

	.word None
	.word <>aActionStructUnit1.BattleMight
	.byte 8, 12

	.word None
	.word <>aActionStructUnit1.BattleDefense
	.byte 8, 14

	.word None
	.word <>aActionStructUnit1.BattleAdjustedHit
	.byte 8, 16

	.word None
	.word <>aActionStructUnit1.BattleAdjustedCrit
	.byte 8, 18

	.word None
	.word <>aActionStructUnit1.BattleAttackSpeed
	.byte 8, 20

	.sint -1

rsColorBattleForecastWindowCenter ; 81/C17E

	.al
	.xl
	.autsiz
	.databank `aBG1TilemapBuffer

	lda $7E4E6B
	sta lR18
	lda $7E4E6B+1
	sta lR18+1
	lda #$2800
	sta wUnknown000DE7,b
	lda #<>aUnknown81C1AF
	sta lUnknown000DDE,b
	lda #>`aUnknown81C1AF
	sta lUnknown000DDE+1,b
	jsl $87D6FC

	; Get coordinates by side

	lda wR17
	beq _Left

	ldx #(24 * 2) | (8 * $40)
	bra +

	_Left
	ldx #(4 * 2) | (8 * $40)

	+
	jsl $87D4DD
	rts

aUnknown81C1AF ; 81/C1AF

	.byte 4, 16 ; width, height
	.long aBG1TilemapBuffer
	.byte 0
	.long $7F8614

.include "PROCS/BattleForecastCenterShadingHBounds.asm"

rsBattleForecastCopyAllegiancePalette ; 81/C1E3

	.al
	.xl
	.autsiz
	.databank `aBG1TilemapBuffer

	; Copy the right palette based on allegiances

	ldy #<>aBGPal1 + (2 * 2)
	lda aActionStructUnit1.DeploymentNumber
	jsr rsBattleForecastCopyAllegiancePalettePart

	ldy #<>aBGPal1 + (9 * 2)
	lda aActionStructUnit2.DeploymentNumber
	jsr rsBattleForecastCopyAllegiancePalettePart

	rts

rsBattleForecastCopyAllegiancePalettePart ; 81/C1F6

	.al
	.xl
	.autsiz
	.databank `aBG1TilemapBuffer

	and #Player | Enemy | NPC
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	tax
	lda aBattleForecastBGPaletteTable,x
	tax
	lda #(7 * 2) - 1
	phb
	mvn #`$F4FF24,#$7E ; Actually palette bank
	plb
	rts

aBattleForecastBGPaletteTable ; 81/C20D

	.word <>$F4FF24
	.word <>$F4FF32
	.word <>$F4FF44
