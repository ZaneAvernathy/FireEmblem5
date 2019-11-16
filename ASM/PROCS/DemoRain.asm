
rlDemoRain ; 9A/E53D

	.al
	.xl
	.autsiz
	.databank ?

	jsl rlDisableVBlank

	sep #$20
	lda #INIDISP_Setting(True)
	sta bBuf_INIDISP
	rep #$20

	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	rep #$20

	lda #(`$A0EA58)<<8
	sta lR18+1
	lda #<>$A0EA58
	sta lR18
	lda #(`$7FB0F5)<<8
	sta lR19+1
	lda #<>$7FB0F5
	sta lR19
	jsl rlAppendDecompList
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $7FB0F5, $0400, VMAIN_Setting(True), $4000

	lda #(`$9FB9C0)<<8
	sta lR18+1
	lda #<>$9FB9C0
	sta lR18
	lda #(`$7FB0F5)<<8
	sta lR19+1
	lda #<>$7EB0F5
	sta lR19
	jsl rlAppendDecompList
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $7FB0F5, $0200, VMAIN_Setting(True), $B000

	lda #(`$9FB9F9)<<8
	sta lR18+1
	lda #<>$9FB9F9
	sta lR18
	lda #(`aBG1TilemapBuffer)<<8
	sta lR19+1
	lda #<>aBG1TilemapBuffer
	sta lR19
	jsl rlAppendDecompList
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG1TilemapBuffer, $0800, VMAIN_Setting(True), $E000

	lda #(`$9FBA75)<<8
	sta lR18+1
	lda #<>$9FBA75
	sta lR18
	lda #(`aBG3TilemapBuffer)<<8
	sta lR19+1
	lda #<>aBG3TilemapBuffer
	sta lR19
	jsl rlAppendDecompList
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG3TilemapBuffer, $0800, VMAIN_Setting(True), $A000

	lda #(`DemoRainPalette)<<8
	sta lR18+1
	lda #<>DemoRainPalette
	sta lR18
	lda #(`aBGPal1)<<8
	sta lR19+1
	lda #<>aBGPal1
	sta lR19
	lda #size(aBGPal1)+size(aBGPal2)
	sta wR20
	jsl rlBlockCopy

	lda #(`aDemoRainLightningColorTable)<<8
	sta wProcInput0+1,b
	lda #<>aDemoRainLightningColorTable
	sta wProcInput0,b

	lda #(`$949F97)<<8
	sta lR43+1
	lda #<>$949F97
	sta lR43
	jsl rlProcEngineCreateProc

	lda #(`procDemoRain)<<8
	sta lR43+1
	lda #<>procDemoRain
	sta lR43
	jsl rlProcEngineCreateProc

	sep #$20

	lda #TM_Setting(True, False, True, False, False)
	sta bBuf_TM

	lda #TS_Setting(False, True, False, False, True)
	sta bBuf_TS

	lda #CGWSEL_Setting(False, True, CGWSEL_MathAlways, CGWSEL_BlackNever)
	sta bBuf_CGWSEL

	lda #CGADSUB_Setting(CGADSUB_Add, True, True, False, True, False, False, True)
	sta bBuf_CGADSUB

	lda bBuf_BG1SC
	and #~BG1SC.Size
	sta bBuf_BG1SC

	lda bBuf_BG3SC
	and #~BG3SC.Size
	sta bBuf_BG3SC

	rep #$20

	sep #$20
	lda #INIDISP_Setting(False, 0)
	sta bBuf_INIDISP
	rep #$20

	sep #$20
	lda #INIDISP_Setting(False, 0)
	sta INIDISP,b
	rep #$20

	jsl rlEnableVBlank
	rtl

DemoRainPalette ; 9A/E661
	.word $3000, $0000, $5EF7, $7BFF, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4
	.word $0843, $2108, $39CE, $5EF7, $7BFF, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4, $57D4

aDemoRainLightningColorTable ; 9A/E6A1

	; Starting position in palette buffer
	.byte (aBGPal1 + 2 - aBGPaletteBuffer) / 2

	; Color count
	.byte $01

	; Short pointer to palettes
	.addr _Palettes

	; Palette table entry index
	.byte (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2
	.byte (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal01 - _Palettes)/2, (_Pal01 - _Palettes)/2, (_Pal01 - _Palettes)/2, (_Pal02 - _Palettes)/2, (_Pal02 - _Palettes)/2, (_Pal02 - _Palettes)/2, (_Pal03 - _Palettes)/2, (_Pal03 - _Palettes)/2, (_Pal03 - _Palettes)/2
	.byte (_Pal04 - _Palettes)/2, (_Pal04 - _Palettes)/2, (_Pal04 - _Palettes)/2, (_Pal05 - _Palettes)/2, (_Pal05 - _Palettes)/2, (_Pal05 - _Palettes)/2, (_Pal06 - _Palettes)/2, (_Pal06 - _Palettes)/2, (_Pal07 - _Palettes)/2, (_Pal07 - _Palettes)/2, (_Pal08 - _Palettes)/2, (_Pal08 - _Palettes)/2, (_Pal09 - _Palettes)/2, (_Pal09 - _Palettes)/2, (_Pal0A - _Palettes)/2, (_Pal0A - _Palettes)/2
	.byte (_Pal0B - _Palettes)/2, (_Pal0C - _Palettes)/2, (_Pal0D - _Palettes)/2, (_Pal0E - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2
	.byte (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2
	.byte (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2
	.byte (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2
	.byte (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2
	.byte (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2
	.byte (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2
	.byte (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2
	.byte (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2
	.byte (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2
	.byte (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal00 - _Palettes)/2, (_Pal02 - _Palettes)/2, (_Pal02 - _Palettes)/2, (_Pal04 - _Palettes)/2, (_Pal04 - _Palettes)/2, (_Pal06 - _Palettes)/2, (_Pal06 - _Palettes)/2, (_Pal08 - _Palettes)/2, (_Pal0A - _Palettes)/2, (_Pal0C - _Palettes)/2, (_Pal0D - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2
	.byte (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2
	.byte (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, (_Pal0F - _Palettes)/2, $FE

	_Palettes

	_Pal00 .word $7C00
	_Pal01 .word $7400
	_Pal02 .word $6C00
	_Pal03 .word $6000
	_Pal04 .word $5800
	_Pal05 .word $5000
	_Pal06 .word $4800
	_Pal07 .word $4000
	_Pal08 .word $3400
	_Pal09 .word $2C00
	_Pal0A .word $2400
	_Pal0B .word $1C00
	_Pal0C .word $1400
	_Pal0D .word $0800
	_Pal0E .word $0000
	_Pal0F .word $0000

procDemoRain .dstruct structProcInfo, "xx", None, rlProcDemoRainOnCycle, None ; 9A/E7C4

rlProcDemoRainOnCycle ; 9A/E7CC

	.al
	.xl
	.autsiz
	.databank ?

	inc aProcBody0,b,x

	lda aProcBody0,b,x
	clc
	adc wMapScrollWidthPixels,b
	sta wBuf_BG1HOFS

	lda aProcBody0,b,x
	eor #-1
	inc a
	clc
	adc wMapScrollHeightPixels,b
	sta wBuf_BG1VOFS

	inc aProcBody1,b,x
	inc aProcBody1,b,x

	lda aProcBody1,b,x
	clc
	adc wMapScrollWidthPixels,b
	sta wBuf_BG3HOFS

	lda aProcBody1,b,x
	eor #-1
	inc a
	clc
	adc wMapScrollHeightPixels,b
	sta wBuf_BG3VOFS

	rtl
