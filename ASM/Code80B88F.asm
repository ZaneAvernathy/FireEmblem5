
rsUnknown80B88F ; 80/B88F

	.autsiz
	.databank ?

	sep #$30
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	stz bUnknown000F54,b
	lda #HDMAEN_Setting(False, False, False, False, False, False, False, False)
	sta @l HDMAEN
	rep #$30
	jsl rlDMAPaletteAndOAMBuffer
	jsl rlProcessDMAStructArray
	jsl rlHandlePossibleHDMA
	jsl $859352
	jsl rlCopyPPURegBuffer
	jsl rlUnknown808D9C
	jsl rlGetJoypadInput
	jsl rlUnknown80B0D1
	jsl rlClearSpriteAttributeBuffer
	jsl rlUnknown80A50F
	jsl rlUnknown80A5DF
	jsl rlUpdateBGTilemaps
	jsl $83C393
	jsl rlHideSprites
	jsl rlUnknown80932C
	jsl rlButtonCombinationResetCheck
	rts

rsUnknown80B8E2 ; 80/B8E2

	.autsiz
	.databank ?

	rep #$20
	lda #$0004
	sta wUnknown000300,b
	lda #$0005
	sta wUnknown000302,b
	stz wUnknown000304,b
	lda #<>rsUnknown80B88F
	sta wUnknown0000D3
	lda #<>rsUnknown80B8FE
	sta wUnknown0000D7
	rts

rsUnknown80B8FE ; 80/B8FE

	.autsiz
	.databank ?

	jsl rlDecompressByList
	jsl rlUnknown8096B3
	rts

rlUnknown80B907 ; 80/B907

	.al
	.autsiz
	.databank `$7EAD50

	stz $7EAD50
	lda #<>rsUnknown80B948
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	lda #$0000
	sta wMenuType,b
	rtl

rlUnknown80B925 ; 80/B925

	.al
	.autsiz
	.databank ?

	sep #$20
	lda #INIDISP_Setting(False)
	sta bBuf_INIDISP
	rep #$20
	lda #<>rsUnknown80B948
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	lda #$000D
	sta wMenuType,b
	rtl

rsUnknown80B948 ; 80/B948

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsl $8A9297
	jsr rsUnknown80B8E2
	jsl $85A898
	lda #$0001
	sta wUnknown00033F,b
	lda #(`procFadeIn2)<<8
	sta lR43+1
	lda #<>procFadeIn2
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	rts

rlUnknown80B981 ; 80/B981

	.autsiz
	.databank ?

	sep #$20
	lda #INIDISP_Setting(False)
	sta bBuf_INIDISP
	rep #$20
	lda #<>rsUnknown80B9C1
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rlUnknown80B99E ; 80/B99E

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown809F74
	sta lUnknown7EA4EC
	lda #(rsUnknown809F74)>>8
	sta lUnknown7EA4EC+1
	lda #<>rsUnknown80B9C1
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80B9C1 ; 80/B9C1

	.al
	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80B8E2
	jsl $859D16
	phx
	lda #(`$859AF9)<<8
	sta lR43+1
	lda #<>$859AF9
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	lda #$0001
	sta wMenuType,b
	lda wPrepScreenFlag,b
	beq +

	lda #$000F
	sta wMenuType,b
	lda #$0001
	sta wUnknown00033F,b
	lda #(`procFadeIn2)<<8
	sta lR43+1
	lda #<>procFadeIn2
	sta lR43
	jsl rlProcEngineCreateProc

	+
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	rts

rlUnknown80BA1F ; 80/BA1F

	.al
	.autsiz
	.databank ?

	lda #$0004
	sta $7EA95C
	lda #$0002
	sta wMenuType,b
	lda #<>rsUnknown80BA6B
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rlUnknown80BA41 ; 80/BA41

	.al
	.autsiz
	.databank ?

	lda #$0004
	sta $7EA95C
	lda #$000E
	sta wMenuType,b
	sep #$20
	lda #INIDISP_Setting(False)
	sta bBuf_INIDISP
	rep #$20
	lda #<>rsUnknown80BA6B
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80BA6B ; 80/BA6B

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsl rlUnknown809FE5
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80B8E2
	jsl $85B39B
	lda #$0001
	sta wUnknown00033F,b
	lda #(`procFadeIn2)<<8
	sta lR43+1
	lda #<>procFadeIn2
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	rts

rlUnknown80BAAC ; 80/BAAC

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80BAC1
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80BAC1 ; 80/BAC1

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80B8E2
	lda #$0003
	sta wMenuType,b
	jsl $85D323
	lda #$0001
	sta wUnknown00033F,b
	lda #(`procFadeIn2)<<8
	sta lR43+1
	lda #<>procFadeIn2
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	rts

rlUnknown80BB04 ; 80/BB04

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80BB19
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80BB19 ; 80/BB19

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80B8E2
	lda #$0004
	sta wMenuType,b
	jsl $8AB88C
	phx
	lda #(`procFadeOut1)<<8
	sta lR43+1
	lda #<>procFadeOut1
	sta lR43
	jsl rlProcEngineFindProc
	bcc +

	stz aProcHeaderSleepTimer,b,x
	jsl rlProcEngineFreeProc
	clc
	bra ++

	+
	sec

	+
	plx
	lda #(`$8ABAE1)<<8
	sta lR43+1
	lda #<>$8ABAE1
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	rts

rlUnknown80BB73 ; 80/BB73

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80BB88
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80BB88 ; 80/BB88

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80B8E2
	lda #$0005
	sta wMenuType,b
	lda #$0000
	sta $7E4E04
	jsl $85E321
	lda #$0001
	sta wUnknown00033F,b
	lda #(`procFadeIn2)<<8
	sta lR43+1
	lda #<>procFadeIn2
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	rts

rlUnknown80BBD2 ; 80/BBD2

	.al
	.autsiz
	.databank ?

	pha
	lda #$0000
	sta $7E4E12
	lda #$000D
	jsl rlUnknown808C87
	pla

rlUnknown80BBE2 ; 80/BBE2

	.al
	.autsiz
	.databank ?

	sta wR0
	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $83901C
	jsl rlUnknown809C9B
	lda #<>rsUnknown80BC0E
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	lda #INIDISP_Setting(False)
	sta bBuf_INIDISP
	rep #$20
	rtl

rsUnknown80BC0E ; 80/BC0E

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsl $8593EB
	jsl $8A9297
	jsl $83CD2B
	jsr rsUnknown80B8E2
	lda #$0007
	sta wMenuType,b
	jsl rlBuildInventoryWindow
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	rts

rlUnknown80BC41 ; 80/BC41

	.al
	.autsiz
	.databank ?

	sta wR0
	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $83901C
	jsr rsUnknown809B80
	jsr rsUnknown809C55
	jsr rsUnknown809CF3
	lda #$FFFF
	sta $7E4E12
	lda wPrepScreenFlag,b
	bne +

	lda #<>rlUnknown80C690
	sta lUnknown7EA4EC
	lda #(rlUnknown80C690)>>8
	sta lUnknown7EA4EC+1
	bra ++

	+
	lda #<>rlUnknown80C6B1
	sta lUnknown7EA4EC
	lda #(rlUnknown80C6B1)>>8
	sta lUnknown7EA4EC+1

	+
	lda #<>rsUnknown80BC0E
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	lda #INIDISP_Setting(False)
	sta bBuf_INIDISP
	rep #$20
	rtl

rlUnknown80BC9C ; 80/BC9C

	.al
	.autsiz
	.databank ?

	lda #$FFFF
	sta $7E4E12
	lda #<>rsUnknown80BC0E
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	lda #INIDISP_Setting(False)
	sta bBuf_INIDISP
	rep #$20
	lda #$000D
	jsl rlUnknown808C87
	rtl

rlUnknown80BCC7 ; 80/BCC7

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80BCDC
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80BCDC ; 80/BCDC

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsr rsUnknown809C55
	jsr rsUnknown80B8E2
	lda #$0005
	sta wMenuType,b
	lda #$0003
	sta $7E4E04
	jsl $85E321
	jsl $85EC3C
	lda #$0001
	sta wUnknown00033F,b
	lda #(`procFadeIn2)<<8
	sta lR43+1
	lda #<>procFadeIn2
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	rts

rlUnknown80BD28 ; 80/BD28

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80BD3D
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80BD3D ; 80/BD3D

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80B8E2
	lda #$0008
	sta wMenuType,b
	lda #$0009
	sta $7E4DFE
	jsl $85C3D2
	lda #$0001
	sta wUnknown00033F,b
	lda #(`procFadeIn2)<<8
	sta lR43+1
	lda #<>procFadeIn2
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	rts

rlUnknown80BD87 ; 80/BD87

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80BDA4
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	lda #INIDISP_Setting(False)
	sta bBuf_INIDISP
	rep #$20
	rtl

rsUnknown80BDA4 ; 80/BDA4

	.al
	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80B8E2
	lda #$0009
	sta wMenuType,b
	jsl $85F385
	lda #$0001
	sta wUnknown00033F,b
	lda #(`procFadeIn2)<<8
	sta lR43+1
	lda #<>procFadeIn2
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	rts

rlUnknown80BDE7 ; 80/BDE7

	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`wPrepItemsSelectedOption
	pha
	rep #$20
	plb

	.databank `wPrepItemsSelectedOption

	stz wPrepItemsSelectedOption
	stz $7EA1ED
	stz $7E4E0A
	lda #$0078
	sta @l wPrepUnitListLastScrollOffset
	lda #<>rsUnknown80BE77
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	lda #INIDISP_Setting(False)
	sta bBuf_INIDISP
	rep #$20
	plb
	plp
	rtl

rlUnknown80BE20 ; 80/BE20

	.al
	.autsiz
	.databank ?

	lda #$0002
	sta wPrepItemsActionIndex

rlUnknown80BE27 ; 80/BE27

	.al
	.autsiz
	.databank ?

	php
	phb
	sep #$20
	lda #`wPrepUnitListLastScrolledMenuLine
	pha
	rep #$20
	plb

	.databank `wPrepUnitListLastScrolledMenuLine

	lda @l wPrepUnitListLastScrolledMenuLine
	sta @l $7EA1ED
	lda @l wPrepUnitListLastSelectedColumn
	sta @l wPrepUnitListColumn
	lda @l wPrepUnitListLastSelectedRow
	sta @l wPrepUnitListRow
	jsl $85FABE
	sta wR0
	lda #aSelectedCharacterBuffer
	sta wR1
	jsl $839086
	lda #<>rsUnknown80BE77
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	lda #INIDISP_Setting(False)
	sta bBuf_INIDISP
	rep #$20
	plb
	plp
	rtl

rsUnknown80BE77 ; 80/BE77

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsl rlUnknown809FE5
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80B8E2
	lda #$000B
	sta wMenuType,b
	jsl rlUnknown81E25B
	lda $7E4E0A
	cmp #$0005
	bne +

	phx
	lda #(`procPrepItemsTradeInitiatorCursor)<<8
	sta lR43+1
	lda #<>procPrepItemsTradeInitiatorCursor
	sta lR43
	jsl rlProcEngineCreateProc
	plx

	+
	lda #$0001
	sta wUnknown00033F,b
	lda #(`procFadeIn2)<<8
	sta lR43+1
	lda #<>procFadeIn2
	sta lR43
	jsl rlProcEngineCreateProc
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	rts

rsUnknown80BED7 ; 80/BED7

	.autsiz
	.databank ?

	sep #$30
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	lda #HDMAEN_Setting(False, False, False, False, False, False, False, False)
	sta @l HDMAEN
	rep #$30
	jsl rlDMAPaletteAndOAMBuffer
	jsl rlProcessDMAStructArray
	jsl rlHandlePossibleHDMA
	jsl rlCopyPPURegBuffer
	jsl rlUnknown808D9C
	jsl $9A843F
	jsl rlGetJoypadInput
	jsl rlUnknown80B0D1
	jsl rlClearSpriteAttributeBuffer
	jsl rlUnknown80A50F
	jsl rlGetMapScrollReturnStep
	jsl rlUnknown80A5DF
	jsl rlUpdateBGTilemapsByMapScrollAmount
	jsl rlHandleMapScrollStep
	jsl rlUpdateBGTilemaps
	jsl rlUnknown8CCB51
	jsl rlHideSprites
	jsl rlUnknown80932C
	jsl rlButtonCombinationResetCheck
	rts

rsUnknown80BF33 ; 80/BF33

	.autsiz
	.databank ?

	jsl rlDecompressByList
	jsl rlUnknown8096B3
	rts

rsUnknown80BF3C ; 80/BF3C

	.al
	.autsiz
	.databank ?

	rep #$20
	lda #$000D
	sta wUnknown000300,b
	lda #$000E
	sta wUnknown000302,b
	stz wUnknown000304,b
	lda #<>rsUnknown80BED7
	sta wUnknown0000D3
	lda #<>rsUnknown80BF33
	sta wUnknown0000D7
	rts

rsUnknown80BF58 ; 80/BF58

	.xl
	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	lda wCurrentChapter,b
	pha
	lda #ChapterWorldMap
	sta wCurrentChapter,b
	jsl rlProcEngineResetProcEngine
	jsl rlUnknown82A989
	jsl rlActiveSpriteEngineReset
	jsl rlEnableActiveSpriteEngine
	jsl rlResetHDMAArrayEngine
	jsl rlUnknown82A6AE
	jsl $87C851
	jsr rsUnknown809B80
	jsr rsUnknown809C55
	jsr rsUnknown80BF3C
	lda #$0000
	sta @l wMapScrollWidthPixels
	lda #$0000
	sta @l wMapScrollHeightPixels
	lda #$0000
	sta @l wUnknown000E6D
	jsl rlUnknown80C082
	jsl $83A73C
	jsl rlUpdateUnitMapsAndFog
	lda #<>$83C0F6
	sta lUnknown000DDE,b
	lda #($83C0F6)>>8
	sta lUnknown000DDE+1,b
	sep #$20
	lda #W12SEL_Setting(False, False, False, False, True, True, False, False)
	sta bBuf_W12SEL
	lda #W12SEL_Setting(False, False, False, False, False, False, False, False)
	sta bBuf_W34SEL
	lda #WOBJSEL_Setting(False, False, False, False, False, False, False, False)
	sta bBuf_WOBJSEL
	lda #WBGLOG_Setting(WLOG_ORR, WLOG_ORR, WLOG_ORR, WLOG_ORR)
	sta bBuf_WBGLOG
	lda #WOBJLOG_Setting(WLOG_ORR, WLOG_ORR)
	sta bBuf_WOBJLOG
	lda #TM_Setting(True, True, True, False, True)
	sta bBuf_TM
	lda #TS_Setting(False, False, True, False, False)
	sta bBuf_TS
	lda #TMW_Setting(False, True, False, False, False)
	sta bBuf_TMW
	lda #TSW_Setting(False, False, False, False, False)
	sta bBuf_TSW
	lda #CGADSUB_Setting(CGADSUB_Add, True, False, True, False, False, False, False)
	sta bBuf_CGADSUB
	lda #CGWSEL_Setting(False, True, CGWSEL_MathAlways, CGWSEL_BlackNever)
	sta bBuf_CGWSEL
	rep #$20
	lda #(`$9A83A1)<<8
	sta lR43+1
	lda #<>$9A83A1
	sta lR43
	jsl rlHDMAArrayEngineCreateEntry
	lda #(`aBG3TilemapBuffer)<<8
	sta lR18+1
	lda #<>aBG3TilemapBuffer
	sta lR18
	lda #$0800
	sta wR19
	lda #$02D0
	jsl rlBlockFillWord
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG3TilemapBuffer, $0800, VMAIN_Setting(True), $A000

	lda #$5000
	sta wR0
	lda #$02D0
	ldx #$0000
	jsl $94DA2A
	lda #(`$9A83B8)<<8
	sta lR43+1
	lda #<>$9A83B8
	sta lR43
	lda #$0005
	sta wR39
	jsl rlHDMAArrayEngineCreateEntryByIndex
	pla
	sta wCurrentChapter,b
	jsl rlGetWorldMapEventPointer
	jsl rlUnknown8C839F
	jsl $91C9E1
	lda #(`$9A9040)<<8
	sta lR43+1
	lda #<>$9A9040
	sta lR43
	jsl rlUnknown82A701
	lda #(`$9A9230)<<8
	sta lR43+1
	lda #<>$9A9230
	sta lR43
	jsl rlUnknown82A701
	jsl rlUnknown82A6C8
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rlUnknown80C082 ; 80/C082

	.al
	.autsiz
	.databank ?

	lda #$0101
	sta wDefaultVisibilityFill,b
	lda #$000F
	sta lR18
	lda wCurrentChapter,b
	jsl $848933
	lda #<>$7FB0F5
	sta wR19
	lda #>`$7FB0F5
	sta wR19+1
	jsl rlAppendDecompList
	lda #<>$7FB0F5
	sta lR18
	lda #>`$7FB0F5
	sta lR18+1
	jsl $848AC3
	jsl $848B23
	jsl $83B476
	jsl $848B79
	rtl

rlUnknown80C0BD ; 80/C0BD

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80C0D2
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C0D2 ; 80/C0D2

	.xl
	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80C2F0
	phx
	lda #(`$94ADE9)<<8
	sta lR43+1
	lda #<>$94ADE9
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rlUnknown80C10B ; 80/C10B

	.al
	.autsiz
	.databank ?

	jsr rsUnknown80C2F0
	phx
	lda #(`$94BE5F)<<8
	sta lR43+1
	lda #<>$94BE5F
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	rtl

rlUnknown80C11F ; 80/C11F

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80C134
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C134 ; 80/C134

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80C2F0
	phx
	lda #(`$94AE11)<<8
	sta lR43+1
	lda #<>$94AE11
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rlUnknown80C16D ; 80/C16D

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80C182
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C182 ; 80/C182

	.al
	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80C2F0
	phx
	lda #(`$94AE19)<<8
	sta lR43+1
	lda #<>$94AE19
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rlUnknown80C1BB ; 80/C1BB

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80C1D0
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C1D0 ; 80/C1D0

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80C2F0
	phx
	lda #(`$94AE21)<<8
	sta lR43+1
	lda #<>$94AE21
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rlUnknown80C209 ; 80/C209

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80C21E
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C21E ; 80/C21E

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80C2F0
	phx
	lda #(`$94AE29)<<8
	sta lR43+1
	lda #<>$94AE29
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rlUnknown80C257 ; 80/C257

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80C26C
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C26C ; 80/C26C

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsr rsUnknown80C2F0
	phx
	lda #(`$8EEA3D)<<8
	sta lR43+1
	lda #<>$8EEA3D
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rlUnknown80C29D ; 80/C29D

	.al
	.autsiz
	.databank ?

	lda #$0001
	jsl $9A833C
	lda #$0004
	sta wUnknown00033F,b
	lda #<>rsUnknown80C2BF
	sta wProcInput0,b
	lda #(`procUnknown82A272)<<8
	sta lR43+1
	lda #<>procUnknown82A272
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C2BF ; 80/C2BF

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsr rsUnknown80C2F0
	phx
	lda #(`$8EE664)<<8
	sta lR43+1
	lda #<>$8EE664
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rsUnknown80C2F0 ; 80/C2F0

	.autsiz
	.databank ?

	rep #$20
	lda #$0004
	sta wUnknown000300,b
	lda #$0004
	sta wUnknown000302,b
	stz wUnknown000304,b
	lda #<>rsUnknown80C30C
	sta wUnknown0000D3
	lda #<>rsUnknown80B8FE
	sta wUnknown0000D7
	rts

rsUnknown80C30C ; 80/C30C

	.autsiz
	.databank ?

	sep #$30
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	rep #$30
	jsl rlDMAPaletteAndOAMBuffer
	jsl rlProcessDMAStructArray
	jsl rlHandlePossibleHDMA
	jsl $859352
	jsl $8E8A7D
	jsl rlCopyPPURegBuffer
	jsl rlUnknown808D9C
	jsl rlGetJoypadInput
	jsl rlUnknown80B0D1
	jsl rlClearSpriteAttributeBuffer
	jsl rlUnknown80A50F
	jsl rlUnknown80A5DF
	jsl rlUpdateBGTilemaps
	jsl rlHideSprites
	jsl rlUnknown80932C
	jsl rlButtonCombinationResetCheck
	rts

rlUnknown80C356 ; 80/C356

	.al
	.autsiz
	.databank ?

	phb
	php
	phk
	plb

	.databank `*

	sep #$20
	lda wR1+1
	and #BG12NBA.BG1Base << 4
	lsr a
	lsr a
	lsr a
	lsr a
	sta wR1+1
	lda wR2+1
	and #BG12NBA.BG2Base
	ora wR1+1
	sta wR1
	lda wR3+1
	and #BG34NBA.BG3Base << 4
	lsr a
	lsr a
	lsr a
	lsr a
	sta wR3+1
	lda wR4+1
	and #BG34NBA.BG4Base
	ora wR3+1
	sta wR3
	lda wR5+1
	and #OBSEL.Base << 5
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	sta wR5
	lda wR6+1
	and #BG1SC.Address
	sta wR6
	lda wR7+1
	and #BG2SC.Address
	sta wR7
	lda wR8+1
	and #BG3SC.Address
	sta wR8
	lda wR9+1
	and #BG4SC.Address
	sta wR9
	lda bBuf_BG1SC
	and #BG1SC.Size
	ora wR6
	sta bBuf_BG1SC
	lda bBuf_BG2SC
	and #BG2SC.Size
	ora wR7
	sta bBuf_BG2SC
	lda bBuf_BG3SC
	and #BG3SC.Size
	ora wR8
	sta bBuf_BG3SC
	lda bBuf_BG4SC
	and #BG4SC.Size
	ora wR9
	sta bBuf_BG4SC
	lda bBuf_OBSEL
	and #~OBSEL.Base
	ora wR5
	sta bBuf_OBSEL
	lda wR1
	sta bBuf_BG12NBA
	lda wR3
	sta bBuf_BG34NBA
	plp
	plb
	rtl

rlUnknown80C3D6 ; 80/C3D6

	.al
	.autsiz
	.databank ?

	lda #$0000
	sta @l wUnknown000E6D
	lda #$0000
	sta wMapScrollWidthPixels,b
	lda #$0000
	sta wMapScrollHeightPixels,b
	jsl rlEventEngineClearActiveProcs
	lda #<>rsUnknown80C402
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C402 ; 80/C402

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80C2F0
	jsl $B9D544
	lda #$0004
	sta wUnknown000300,b
	lda #$0004
	sta wUnknown000302,b
	phx
	lda #(`$B9D634)<<8
	sta lR43+1
	lda #<>$B9D634
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rlUnknown80C44B ; 80/C44B

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80C460
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C460 ; 80/C460

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80C2F0
	jsl rlUnknown8096E3
	jsl $B9D544
	lda #$0004
	sta wUnknown000300,b
	lda #$0004
	sta wUnknown000302,b
	phx
	lda #(`$B9E2E3)<<8
	sta lR43+1
	lda #<>$B9E2E3
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rlUnknown80C4AD ; 80/C4AD

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80C4C2
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C4C2 ; 80/C4C2

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80C2F0
	lda #$0004
	sta wUnknown000300,b
	lda #$0004
	sta wUnknown000302,b
	phx
	lda #(`$94DD75)<<8
	sta lR43+1
	lda #<>$94DD75
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rlUnknown80C507 ; 80/C507

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80C51C
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C51C ; 80/C51C

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80C2F0
	lda #$0004
	sta wUnknown000300,b
	lda #$0004
	sta wUnknown000302,b
	phx
	lda #(`$94E574)<<8
	sta lR43+1
	lda #<>$94E574
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rlUnknown80C561 ; 80/C561

	.al
	.autsiz
	.databank ?

	lda #<>rsUnknown80C576
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C576 ; 80/C576

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80C2F0
	lda #$0004
	sta wUnknown000300,b
	lda #$0004
	sta wUnknown000302,b
	phx
	lda #(`$918012)<<8
	sta lR43+1
	lda #<>$918012
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rlUnknown80C5BB ; 80/C5BB

	.al
	.autsiz
	.databank ?

	lda #$000D
	jsl rlUnknown808C87
	lda #$0000
	jsl $9A833C
	lda #<>rsUnknown80C5DE
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	rtl

rsUnknown80C5DE ; 80/C5DE

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	jsl rlDisableVBlank
	jsr rsUnknown809B80
	jsl $8593EB
	jsl $8A9297
	jsr rsUnknown80C2F0
	lda #$0004
	sta wUnknown000300,b
	lda #$0004
	sta wUnknown000302,b
	phx
	lda #(`$8FE5DB)<<8
	sta lR43+1
	lda #<>$8FE5DB
	sta lR43
	jsl rlProcEngineCreateProc
	plx
	sep #$20
	stz bBuf_INIDISP
	jsl rlEnableVBlank
	plp
	cli
	rts

rsUnknown80C623 ; 80/C623

	.autsiz
	.databank ?

	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	lda #HDMAEN_Setting(False, False, False, False, False, False, False, False)
	sta @l HDMAEN
	rep #$20
	jsl rlProcessDMAStructArray
	jsl rlDMAPaletteAndOAMBuffer
	jsl rlHandlePossibleHDMA
	jsl $859352
	jsl $8E8A7D
	jsl rlCopyPPURegBuffer
	jsl rlUnknown808D9C
	jsl rlGetJoypadInput
	jsl rlUnknown80B0D1
	jsl rlClearSpriteAttributeBuffer
	jsl rlUnknown80A5DF
	jsl rlUnknown80A50F
	jsl $83C393
	jsl rlHideSprites
	jsl rlUnknown80932C
	rts

rlUnknown80C66F ; 80/C66F

	.al
	.autsiz
	.databank ?

	lda #$0000
	sta $7FAFC9
	stz wUnknown000302,b
	lda #$0000
	sta $7FB10D
	lda #<>rsUnknown80C6FC
	sta wUnknown0000D7
	lda $7FAFC9
	sta wR0
	jsl $90EF7C
	rtl

rlUnknown80C690 ; 80/C690

	.al
	.autsiz
	.databank ?

	lda #$0000
	sta $7FAFC9
	stz wUnknown000302,b
	lda #$0001
	sta $7FB10D
	lda #<>rsUnknown80C6FC
	sta wUnknown0000D7
	lda $7E454D
	bne +

	jsl $90EF63

	+
	rtl

rlUnknown80C6B1 ; 80/C6B1

	.al
	.autsiz
	.databank ?

	lda #$0000
	sta $7FAFC9
	stz wUnknown000302,b
	lda #$0002
	sta $7FB10D
	lda #<>rsUnknown80C6FC
	sta wUnknown0000D7
	lda $7E454D
	bne +

	jsl $90EF2C

	+
	rtl

rlUnknown80C6D2 ; 80/C6D2

	.al
	.autsiz
	.databank ?

	lda #$0000
	sta $7FAFC9
	stz wUnknown000302,b
	lda #$0003
	sta $7FB10D
	lda #<>rsUnknown80C6FC
	sta wUnknown0000D7
	lda $7E454D
	bne +

	jsl $90EF2C

	+
	rtl

aUnknown80C6F3 ; 80/C6F3
	.byte $20, $40, $00
	.long $000000
	.long aBG3TilemapBuffer

rsUnknown80C6FC ; 80/C6FC

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	sta bBuf_INIDISP
	rep #$20
	lda #<>rsUnknown80C623
	sta wUnknown0000D3
	jsl rlHaltUntilVBlank
	jsl rlDisableVBlank
	jsl rlUnknown80A6CA
	jsl rlUnknown80A711
	lda #$2000
	sta wR1
	lda #$2000
	sta wR2
	lda #$6000
	sta wR3
	lda #$0000
	sta wR5
	lda #$4800
	sta wR6
	lda #$3000
	sta wR7
	lda #$7800
	sta wR8
	jsl rlUnknown80A883
	jsl rlProcEngineResetProcEngine
	jsl rlActiveSpriteEngineReset
	jsl rlResetHDMAArrayEngine
	jsl rlUnknown82A6AE
	lda $7FB10D
	bit #$0002
	beq +

	phb
	php
	sep #$20
	lda #$7E
	pha
	rep #$20
	plb

	.databank $7E

	jsl $85F717
	plp
	plb

	+
	lda $7FB10D
	bit #$0001
	bne +

	jsr rsUnknown80C83B

	+
	jsr rsUnknown80C7BB
	jsr rsUnknown80C86F
	jsr rlUnknown80CC11
	jsl rlUnknown80C897
	jsl $9AFD0E
	sep #$20
	lda #$0A
	sta wJoyLongTime
	lda #$04
	sta wJoyShortTime
	rep #$20
	lda #(`$9AECCF)<<8
	sta lR43+1
	lda #<>$9AECCF
	sta lR43
	jsl rlProcEngineCreateProc
	lda #$0011
	sta wUnknown000302,b
	lda #$0010
	sta wUnknown000300,b
	lda #<>rsUnknown80A6BD
	sta wUnknown0000D7
	jsl rlEnableVBlank
	plp
	rts

rsUnknown80C7BB ; 80/C7BB

	.al
	.autsiz
	.databank ?

	lda $7E450A
	sta wUnknown000304,b
	lda #$0000
	sta $7FB2A9
	sta $7FB2AB
	sta $7FB2AD
	sta $7FB2AF
	sta $7FB2B1
	sta $7FB2B3
	sta $7FB2B5
	sta $7FB2B7
	sta $7FB2B9

	sta $7FB11B
	sta $7FB11D
	sta $7FB11F

	sta $7FB123

	sta $7FB13F

	sta $7FB127
	sta $7FB129
	sta $7FB12B

	sta $7FB131
	sta $7FB133
	sta $7FB135
	lda #$0000
	tax

	-
	sta $7FB1D9,x
	inc a
	inc x
	inc x
	cmp #$0033
	bne -

	lda #$0000
	ldx #$0000

	-
	sta $7FB2BB,x
	inc x
	inc x
	cpx #$0066
	bne -

	jsl $90DF02
	rts

rsUnknown80C83B ; 80/C83B

	.al
	.autsiz
	.databank ?

	lda #$0000
	sta $7FAFCB
	sta $7FB111
	sta $7FB113
	sta $7FB125
	sta $7FB12F
	lda #$0001
	sta $7FB10F
	lda #$003A
	sta $7FB121
	lda #$0000
	sta $7FB13D
	lda #$00E8
	sta $7FB141
	rts

rsUnknown80C86F ; 80/C86F

	.autsiz
	.databank ?

	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $F3CC80, $2800, VMAIN_Setting(True), $C000

	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $9F81C0, $0C00, VMAIN_Setting(True), $A000

	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $F2D380, $0500, VMAIN_Setting(True), $2800

	rts

rlUnknown80C897 ; 80/C897

	.autsiz
	.databank ?

	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $9F8000, $01C0, VMAIN_Setting(True), $9000

	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $F1F080, $0400, VMAIN_Setting(True), $2000

	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $9F8DC0, $0600, VMAIN_Setting(True), $4000

	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $9FB1C0, $0800, VMAIN_Setting(True), $E800

	lda #(`$F48000)<<8
	sta lR18+1
	lda #<>$F48000
	sta lR18
	lda $7E4E18
	asl a
	tax
	lda aUnknown80CA87,x
	clc
	adc lR18
	sta lR18
	lda #$0800
	sta wR0
	lda #$2300
	sta wR1
	jsl rlDMAByPointer
	lda #(`$9F93C0)<<8
	sta lR18+1
	lda #<>$9F93C0
	sta lR18
	lda #(`aBG1TilemapBuffer)<<8
	sta lR19+1
	lda #<>aBG1TilemapBuffer
	sta lR19
	lda #$01C0
	sta wR20
	jsl rlBlockCopy
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG1TilemapBuffer, $01C0, VMAIN_Setting(True), $9000

	lda #(`$9FA2C0)<<8
	sta lR18+1
	lda #<>$9FA2C0
	sta lR18
	lda #(`aBG2TilemapBuffer)<<8
	sta lR19+1
	lda #<>aBG2TilemapBuffer
	sta lR19
	lda #$0400
	sta wR20
	jsl rlBlockCopy
	lda #(`$9FA4C0)<<8
	sta lR18+1
	lda #<>$9FA4C0
	sta lR18
	lda #(`aBG2TilemapBuffer + $400)<<8
	sta lR19+1
	lda #<>aBG2TilemapBuffer + $400
	sta lR19
	lda #$0400
	sta wR20
	jsl rlBlockCopy
	lda #(`$9FA4C0)<<8
	sta lR18+1
	lda #<>$9FA4C0
	sta lR18
	lda #(`aBG2TilemapBuffer + $800)<<8
	sta lR19+1
	lda #<>aBG2TilemapBuffer + $800
	sta lR19
	lda #$0400
	sta wR20
	jsl rlBlockCopy
	lda #(`$9FA4C0)<<8
	sta lR18+1
	lda #<>$9FA4C0
	sta lR18
	lda #(`aBG2TilemapBuffer + $C00)<<8
	sta lR19+1
	lda #<>aBG2TilemapBuffer + $C00
	sta lR19
	lda #$0400
	sta wR20
	jsl rlBlockCopy
	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, aBG2TilemapBuffer, $1000, VMAIN_Setting(True), $6000

	lda #(`$F4FE00)<<8
	sta lR18+1
	lda #<>$F4FE00
	sta lR18
	lda $7E4E18
	asl a
	tax
	lda aUnknown80CA91,x
	clc
	adc lR18
	sta lR18
	lda #(`aBGPal4)<<8
	sta lR19+1
	lda #<>aBGPal4
	sta lR19
	lda #size(aBGPal4)
	sta wR20
	jsl rlBlockCopy
	lda #(`$9FAA00)<<8
	sta lR18+1
	lda #<>$9FAA00
	sta lR18
	lda #(`aBGPal0)<<8
	sta lR19+1
	lda #<>aBGPal0
	sta lR19
	lda #size(aBGPal0) + size(aBGPal1)
	sta wR20
	jsl rlBlockCopy
	lda #(`$9FA9C0)<<8
	sta lR18+1
	lda #<>$9FA9C0
	sta lR18
	lda #(`aBGPal2)<<8
	sta lR19+1
	lda #<>aBGPal2
	sta lR19
	lda #size(aBGPal2) + size(aBGPal3)
	sta wR20
	jsl rlBlockCopy
	lda #(`$9E8240)<<8
	sta lR18+1
	lda #<>$9E8240
	sta lR18
	lda #(`aOAMPal5)<<8
	sta lR19+1
	lda #<>aOAMPal5
	sta lR19
	lda #size(aOAMPal5)
	sta wR20
	jsl rlBlockCopy
	lda #(`$9E8220)<<8
	sta lR18+1
	lda #<>$9E8220
	sta lR18
	lda #(`aOAMPal7)<<8
	sta lR19+1
	lda #<>aOAMPal7
	sta lR19
	lda #size(aOAMPal7)
	sta wR20
	jsl rlBlockCopy
	jsl $8591F0
	lda #30
	sta wR0
	lda #20
	sta wR1
	jsl $859233
	lda #52
	sta wR0
	lda #172
	sta wR1
	jsl $859233
	jsl $859205
	lda #CGADSUB_Setting(CGADSUB_Subtract, False, False, True, False, False, False, False)
	sta bBuf_CGADSUB
	lda #7
	sta wR0
	lda #54
	sta wR1
	jsl $83CB26
	lda #7
	sta wR0
	lda #213
	sta wR1
	jsl $83CB53
	jsl $90E23D
	rtl

aUnknown80CA87 ; 80/CA87
	.word $0000
	.word $0800
	.word $1000
	.word $1800
	.word $2000

aUnknown80CA91 ; 80/CA91
	.word $0000
	.word $0020
	.word $0040
	.word $0060
	.word $0080

rlUnknown80CA9B ; 80/CA9B

	.al
	.xl
	.autsiz
	.databank ?

	ldx #100

	-
	lda $7E44A0,x
	beq +

	jsr rsUnknown80CAAC

	+
	dec x
	dec x
	bpl -
	rtl

rsUnknown80CAAC ; 80/CAAC

	.al
	.autsiz
	.databank ?

	phx
	sta wUnknown001AD1,b
	jsl $90D44C
	ora #$0000
	bne +

	lda #(`g4bppBlank80CB0A)<<8
	sta lR18+1
	lda #<>g4bppBlank80CB0A
	sta lR18
	bra ++

	+
	lda @l aItemDataBuffer.Icon
	and #$00FF
	asl a
	asl a
	asl a
	asl a
	asl a
	asl a
	asl a
	clc
	adc #<>$F28000
	sta lR18
	sep #$20
	lda #`$F28000
	sta lR18+2
	rep #$20

	+
	lda aUnknown80CB8A,x
	clc
	adc #$3800
	sta wR1
	lda #$0040
	sta wR0
	jsl rlDMAByPointer
	lda lR18
	clc
	adc #$0040
	sta lR18
	lda wR1
	clc
	adc #$0100
	sta wR1
	jsl rlDMAByPointer
	plx
	rts

g4bppBlank80CB0A .fill $80, $00

aUnknown80CB8A ; 80/CB8A
	.word $0000
	.word $0020
	.word $0040
	.word $0060
	.word $0080
	.word $00A0
	.word $00C0
	.word $00E0
	.word $0200
	.word $0220
	.word $0240
	.word $0260
	.word $0280
	.word $02A0
	.word $02C0
	.word $02E0
	.word $0400
	.word $0420
	.word $0440
	.word $0460
	.word $0480
	.word $04A0
	.word $04C0
	.word $04E0
	.word $0600
	.word $0620
	.word $0640
	.word $0660
	.word $0680
	.word $06A0
	.word $06C0
	.word $06E0
	.word $0800
	.word $0820
	.word $0840
	.word $0860
	.word $0880
	.word $08A0
	.word $08C0
	.word $08E0

rlUnknown80CBDA ; 80/CBDA

	.al
	.autsiz
	.databank ?

	lda #$0000

	-
	sta $7FB2B9
	asl a
	tax
	lda $7E44A0,x
	beq ++

	sta wUnknown001AD1,b
	jsl $90D44C
	pha
	lda $7FB2B9
	asl a
	tax
	lda $90E1BD,x
	tax
	pla
	bne +

	lda #$FFFF

	+
	jsl $90CE6B
	lda $7FB2B9
	inc a
	cmp #$0033
	bne -

	+
	rtl

rlUnknown80CC11 ; 80/CC11

	.autsiz
	.databank ?

	sep #$20
	lda bBuf_BG1SC
	and #~BG1SC.Size
	ora #BGSC_Setting(BGSize64x32)
	sta bBuf_BG1SC
	lda bBuf_BG2SC
	and #~BG2SC.Size
	ora #BGSC_Setting(BGSize64x32)
	sta bBuf_BG2SC
	lda bBuf_BG3SC
	and #~BG3SC.Size
	ora #BGSC_Setting(BGSize64x32)
	sta bBuf_BG3SC
	lda #TM_Setting(True, True, True, False, True)
	sta bBuf_TM
	lda #TS_Setting(False, False, False, False, False)
	sta bBuf_TS
	lda #TMW_Setting(False, False, False, False, False)
	sta bBuf_TMW
	lda #TSW_Setting(False, False, False, False, False)
	sta bBuf_TSW
	lda #W12SEL_Setting(False, False, False, False, False, False, False, False)
	sta bBuf_W12SEL
	lda #W34SEL_Setting(False, False, False, False, False, False, False, False)
	sta bBuf_W34SEL
	lda #WOBJSEL_Setting(False, False, False, False, False, False, False, False)
	sta bBuf_WOBJSEL
	lda #0
	sta bBuf_WH0
	lda #255
	sta bBuf_WH1
	lda #0
	sta bBuf_WH2
	sta bBuf_WH3
	lda #WBGLOG_Setting(WLOG_ORR, WLOG_ORR, WLOG_ORR, WLOG_ORR)
	sta bBuf_WBGLOG
	sta bBuf_WOBJLOG
	lda #CGWSEL_Setting(False, False, CGWSEL_MathAlways, CGWSEL_BlackNever)
	sta bBuf_CGWSEL
	lda #CGADSUB_Setting(CGADSUB_Subtract, False, False, True, False, False, False, False)
	sta bBuf_CGADSUB
	lda #COLDATA_Setting(0, True, True, True)
	sta bBuf_COLDATA_1
	sta bBuf_COLDATA_2
	sta bBuf_COLDATA_3
	rep #$20
	stz wBuf_BG1HOFS
	stz wBuf_BG3HOFS
	stz wBuf_BG2HOFS
	stz wBuf_BG2VOFS
	lda #$0000
	sta wBuf_BG1VOFS
	sta wBuf_BG3VOFS
	rts

rlUnknown80CC7D ; 80/CC7D

	.al
	.autsiz
	.databank ?

	lda #(`aUnknown80CCC6)<<8
	sta lR43+1
	lda #<>aUnknown80CCC6
	sta lR43
	lda #$0003
	sta wR39
	jsl rlHDMAArrayEngineCreateEntryByIndex
	lda #(`aUnknown80CD11)<<8
	sta lR43+1
	lda #<>aUnknown80CD11
	sta lR43
	lda #$0004
	sta wR39
	jsl rlHDMAArrayEngineCreateEntryByIndex
	lda #(`aUnknown80CD5B)<<8
	sta lR43+1
	lda #<>aUnknown80CD5B
	sta lR43
	lda #$0005
	sta wR39
	lda #(`aUnknown80CE84)<<8
	sta lR43+1
	lda #<>aUnknown80CE84
	sta lR43
	lda #$0006
	sta wR39
	jsl rlHDMAArrayEngineCreateEntryByIndex
	rts

aUnknown80CCC6 ; 80/CCC6
	.addr rlUnknown80CCD1
	.addr rlUnknown80CCD2
	.addr aUnknown80CD0F

aUnknown80CCCC ; 80/CCCC
	.long $7FDF22
	.byte $12, $02

rlUnknown80CCD1 ; 80/CCD1

	.autsiz
	.databank ?

	rtl

rlUnknown80CCD2 ; 80/CCD2

	.al
	.autsiz
	.databank ?

	lda $7FB127
	bne +

	sep #$20
	lda #$35
	sta $7FDF22
	rep #$20
	lda #$0000
	sta $7FDF23
	sep #$20
	lda #$01
	sta $7FDF25
	rep #$20
	lda $7FB125
	inc a
	inc a
	sta $7FDF26
	sep #$20
	lda #$00
	sta $7FDF28
	rep #$20
	lda #$0000
	sta $7FDF29

	+
	rtl

aUnknown80CD0F ; 80/CD0F
	.dstruct structHDMAArrayCodeHalt

aUnknown80CD11 ; 80/CD11
	.addr rlUnknown80CD1C
	.addr rlUnknown80CD1D
	.addr aUnknown80CD59

aUnknown80CD17 ; 80/CD17
	.long $7FDF0A
	.byte $0E, $02

rlUnknown80CD1C ; 80/CD1C

	.autsiz
	.databank ?

	rtl

rlUnknown80CD1D ; 80/CD1D

	.al
	.xl
	.autsiz
	.databank ?

	lda $7FB127
	bne +

	sep #$20
	lda #$35
	sta $7FDF0A
	rep #$20
	lda #$FFFF
	sta $7FDF0B
	sep #$20
	lda #$01
	sta $7FDF0D
	rep #$20
	lda $7FB125
	dec a
	sta $7FDF0E
	sep #$20
	lda #$00
	sta $7FDF10
	rep #$20
	lda #$0000
	sta $7FDF11

	+
	rtl

aUnknown80CD59 ; 80/CD59
	.dstruct structHDMAArrayCodeHalt

aUnknown80CD5B ; 80/CD5B
	.addr rlUnknown80CD66
	.addr rlUnknown80CD67
	.addr aUnknown80CE82

aUnknown80CD61 ; 80/CD61
	.long $7FDFA0
	.byte $31, $03

rlUnknown80CD66 ; 80/CD66

	.autsiz
	.databank ?

	rtl

rlUnknown80CD67 ; 80/CD67

	.al
	.xl
	.autsiz
	.databank ?

	lda $7FB127
	beq +

	jmp _End

	+
	ldx #$0000
	sep #$20
	lda #$08
	sta $7FDFA0
	rep #$20
	lda #$0000
	sta $7FDFA1
	lda #$E000
	sta $7FDFA3
	inc x
	inc x
	inc x
	inc x
	inc x
	sep #$20
	lda #$10
	sta $7FDFA0,x
	rep #$20
	lda #$8181
	sta $7FDFA1,x
	lda #$E000
	sta $7FDFA3,x
	inc x
	inc x
	inc x
	inc x
	inc x
	sep #$20
	lda #$0A
	sta $7FDFA0,x
	rep #$20
	lda #$8181
	sta $7FDFA1,x
	lda #$E100
	sta $7FDFA3,x
	inc x
	inc x
	inc x
	inc x
	inc x
	sep #$20
	lda #$10
	sta $7FDFA0,x
	rep #$20
	lda #$8181
	sta $7FDFA1,x
	lda #$E100
	sta $7FDFA3,x
	inc x
	inc x
	inc x
	inc x
	inc x
	sep #$20
	lda #$05
	sta $7FDFA0,x
	rep #$20
	lda #$8181
	sta $7FDFA1,x
	lda #$E200
	sta $7FDFA3,x
	inc x
	inc x
	inc x
	inc x
	inc x
	lda #$0000
	sta $7FB2AF
	lda #$0000
	sta $7FB2B1

	-
	phx
	lda $7FB2AF
	tax
	lda $7FDF2E,x
	sta wR0
	inc x
	txa
	sta $7FB2AF
	plx
	lda wR0
	and #$00FF
	sep #$20
	sta $7FDFA0,x
	rep #$20
	phx
	lda $7FB2B1
	tax
	tay
	lda $7FDF4C,x
	plx
	sep #$20
	sta $7FDFA1,x
	sta $7FDFA2,x
	rep #$20
	phx
	tyx
	lda $7FDF4D,x
	sta @l wR0
	txa
	clc
	adc #$0003
	sta $7FB2B1
	plx
	lda @l wR0
	sta $7FDFA3,x
	inc x
	inc x
	inc x
	inc x
	inc x
	cpx #$00A0
	bne -

	sep #$20
	lda #$00
	sta $7FDFA0,x
	rep #$20
	lda #$0000
	sta $7FDFA1,x

	_End
	rtl

aUnknown80CE82 ;80/CE82
	.dstruct structHDMAArrayCodeHalt

aUnknown80CE84 ; 80/CE84
	.addr rlUnknown80CE8F
	.addr rlUnknown80CE90
	.addr aUnknown80CECB

aUnknown80CE8A
	.long $7FDF16
	.byte $10, $02

rlUnknown80CE8F ; 80/CE8F

	.autsiz
	.databank ?

	rtl

rlUnknown80CE90 ; 80/CE90

	.al
	.autsiz
	.databank ?

	lda $7FB127
	bne +

	sep #$20
	lda #$35
	sta $7FDF16
	rep #$20
	lda #$FFFF
	sta $7FDF17
	sep #$20
	lda #$01
	sta $7FDF19
	rep #$20
	lda $7FB125
	sta $7FDF1A
	sep #$20
	lda #$00
	sta $7FDF1C
	rep #$20
	lda #$0000
	sta $7FDF1D

	+
	rtl

aUnknown80CECB ; 80/CECB
	.dstruct structHDMAArrayCodeHalt

rsUnknown80CECD ; 80/CECD

	.al
	.xl
	.autsiz
	.databank ?

	lda #$0000
	sta wR0
	sta wR1
	lda wR0
	pha
	lda wR1
	pha
	jsl $90E8D1
	sta $7E4508
	pla
	sta wR1
	pla
	sta wR0
	lda #$0001
	sta wUnknown001AD6,b

	-
	lda #$0000
	jsl $90EA37
	lda wUnknown001AD1,b
	beq +++

	jsl $90E86C
	cmp #$0003
	beq +

	jsl $90E868
	bit #$0200
	beq ++

	+
	inc wR1
	bra ++

	+
	lda wR0
	asl a
	tax
	lda wUnknown001AD1,b
	sta $7E44A0,x
	inc wR0

	+
	lda wUnknown001AD6,b
	inc a
	sta wUnknown001AD6,b
	cmp #$0019
	bne -

	lda wR1
	sta $7FB115
	lda $7E4508
	sec
	sbc wR1
	sta $7E4508
	sec
	sbc #$000A
	bpl +
	lda #$0000

	+
	sta $7FB117
	lda $7E4508
	asl a
	tax
	lda #$0000
	sta $7E44A0,x
	rts

rsUnknown80CF55 ; 80/CF55

	.al
	.autsiz
	.databank ?

	jsl rlDMAByStruct

	.dstruct structDMAToVRAM, $9F8000, $01C0, VMAIN_Setting(True), $9000

	lda $7E454D
	and #$00FF
	beq +

	lda $7FB10D
	bit #$0003
	bne _End

	+
	jsl $90DB56
	lda $7E450C
	bne +

	jsl $90D503
	bra ++

	+
	jsl $90D548

	+
	jsl $90DF02

	_End
	rts

rlUnknown80CF55 ; 80/CF8D

	.al
	.autsiz
	.databank ?

	phk
	plb

	.databank `*

	lda #(`aUnknown80C6F3)<<8
	sta lUnknown000DDE+1,b
	lda #<>aUnknown80C6F3
	sta lUnknown000DDE,b
	lda #$0000

	-
	sta $7FB2A9
	tax
	lda $7E44A0,x
	beq _End

	sta wUnknown001AD1,b
	jsl $90E3F7
	lda #$2000
	sta wUnknown000DE7,b
	jsl $90E868
	lda #$8000
	bit #$4000
	bne +

	jsl $90E86C
	cmp #$0005
	bne ++

	+
	lda #$2400
	sta wUnknown000DE7,b

	+
	lda $7FB2A9
	tay
	ldx aUnknown80CFF0,y
	lda lUnknown001AD3,b
	sta lR18
	lda lUnknown001AD3+1,b
	sta lR18+1
	jsl $87E728
	lda $7FB2A9
	inc a
	inc a
	bra -

	_End
	rtl

aUnknown80CFF0 ; 80/CFF0
	.word 4 | (7  << 8)
	.word 4 | (9  << 8)
	.word 4 | (11 << 8)
	.word 4 | (13 << 8)
	.word 4 | (15 << 8)
	.word 4 | (17 << 8)
	.word 4 | (19 << 8)
	.word 4 | (21 << 8)
	.word 4 | (23 << 8)
	.word 4 | (25 << 8)
	.word 4 | (27 << 8)
	.word 4 | (29 << 8)
	.word 4 | (31 << 8)
	.word 4 | (33 << 8)
	.word 4 | (35 << 8)
	.word 4 | (37 << 8)
	.word 4 | (39 << 8)
	.word 4 | (41 << 8)
	.word 4 | (43 << 8)
	.word 4 | (45 << 8)
	.word 4 | (47 << 8)
	.word 4 | (49 << 8)
	.word 4 | (51 << 8)
	.word 4 | (53 << 8)

rlUnknown80D020 ; 80/D020

	.al
	.xl
	.autsiz
	.databank ?

	phy
	lda #$002F
	ldx #$1000

	-
	sta $7EA943,x
	dec x
	dec x
	bne -
	lda #$0000

	_MainLoop
	sta wR15
	asl a
	tax
	lda $7E44A0,x
	bne +
	jmp _End

	+
	sta wUnknown001AD1,b
	jsl $90E92E
	lda wUnknown001ADE,b
	beq ++

	asl a
	tax
	lda aUnknown80D0C5,x
	sta lR25
	sep #$20
	lda #`aUnknown80D0FF
	sta lR25+2
	rep #$20
	lda #$0000
	sta wR12

	-
	sta wR14
	tax
	lda aUnknown001AE0,b,x
	and #$00FF
	sta wR13
	beq +

	txa
	asl a
	tax
	lda $90E183,x
	beq +

	sta wR13
	lda wR12
	asl a
	tay
	lda [lR25],y
	sta wR0
	lda wR15
	asl a
	tax
	lda aUnknown80D1D7,x
	ora wR0
	sta wR0
	lda wR13
	ldx wR0
	sta $7EA945,x
	inc a
	sta $7EA947,x
	txa
	clc
	adc #$0040
	tax
	lda wR13
	clc
	adc #$0010
	sta $7EA945,x
	inc a
	sta $7EA947,x
	inc wR12

	+
	lda wR14
	inc a
	cmp #$0015
	bne -

	+
	lda wR15
	inc a
	cmp #$0033
	beq _End

	jmp _MainLoop

	_End
	ply
	rtl

aUnknown80D0C5 ; 80/D0C5
	.addr aUnknown80D0FF
	.addr aUnknown80D0FF
	.addr aUnknown80D0FF
	.addr aUnknown80D0FF
	.addr aUnknown80D0FF
	.addr aUnknown80D0FF
	.addr aUnknown80D0FF
	.addr aUnknown80D0FF
	.addr aUnknown80D0FF
	.addr aUnknown80D0FF
	.addr aUnknown80D0FF
	.addr aUnknown80D113
	.addr aUnknown80D129
	.addr aUnknown80D141
	.addr aUnknown80D15B
	.addr aUnknown80D177
	.addr aUnknown80D195
	.addr aUnknown80D1B5
	.addr aUnknown80D1B5
	.addr aUnknown80D1B5
	.addr aUnknown80D1B5
	.addr aUnknown80D1B5
	.addr aUnknown80D1B5
	.addr aUnknown80D1B5
	.addr aUnknown80D1B5
	.addr aUnknown80D1B5
	.addr aUnknown80D1B5
	.addr aUnknown80D1B5
	.addr aUnknown80D1B5

aUnknown80D0FF ; 80/D0FF
	.word $0014
	.word $0018
	.word $001C
	.word $0020
	.word $0024
	.word $0028
	.word $002C
	.word $0030
	.word $0034
	.word $0038

aUnknown80D113 ; 80/D113
	.word $003A
	.word $0038
	.word $0014
	.word $0018
	.word $001C
	.word $0020
	.word $0024
	.word $0028
	.word $002C
	.word $0030
	.word $0034

aUnknown80D129 ; 80/D129
	.word $003A
	.word $0038
	.word $0036
	.word $0034
	.word $0014
	.word $0018
	.word $001C
	.word $0020
	.word $0024
	.word $0028
	.word $002C
	.word $0030

aUnknown80D141 ; 80/D141
	.word $003A
	.word $0038
	.word $0036
	.word $0034
	.word $0032
	.word $0030
	.word $0014
	.word $0018
	.word $001C
	.word $0020
	.word $0024
	.word $0028
	.word $002C

aUnknown80D15B ; 80/D15B
	.word $003A
	.word $0038
	.word $0036
	.word $0034
	.word $0032
	.word $0030
	.word $002E
	.word $002C
	.word $0014
	.word $0018
	.word $001C
	.word $0020
	.word $0024
	.word $0028

aUnknown80D177 ; 80/D177
	.word $003A
	.word $0038
	.word $0036
	.word $0034
	.word $0032
	.word $0030
	.word $002E
	.word $002C
	.word $002A
	.word $0028
	.word $0014
	.word $0018
	.word $001C
	.word $0020
	.word $0024

aUnknown80D195 ; 80/D195
	.word $003A
	.word $0038
	.word $0036
	.word $0034
	.word $0032
	.word $0030
	.word $002E
	.word $002C
	.word $002A
	.word $0028
	.word $0026
	.word $0024
	.word $0014
	.word $0018
	.word $001C
	.word $0020

aUnknown80D1B5 ; 80/D1B5
	.word $003A
	.word $0038
	.word $0036
	.word $0034
	.word $0032
	.word $0030
	.word $002E
	.word $002C
	.word $002A
	.word $0028
	.word $0026
	.word $0024
	.word $0022
	.word $0020
	.word $0014
	.word $0018
	.word $001C

aUnknown80D1D7 ; 80/D1D7
	.word $01C0
	.word $0240
	.word $02C0
	.word $0340
	.word $03C0
	.word $0440
	.word $04C0
	.word $0540
	.word $05C0
	.word $0640
	.word $06C0
	.word $0740
	.word $07C0
	.word $0840
	.word $08C0
	.word $0940
	.word $09C0
	.word $0A40
	.word $0AC0
	.word $0B40
	.word $0BC0
	.word $0C40
	.word $0CC0
	.word $0D40

rsUnknown80D207 ; 80/D207

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	lda #HDMAEN_Setting(False, False, False, False, False, False, False, False)
	sta @l HDMAEN
	rep #$20
	jsl $9BC26F
	jsl $9C9F78
	jsl $9CD58C
	jsl $9BA09A
	jsl $9CEAC3
	jsl rlProcessDMAStructArray
	jsl rlDMAPaletteAndOAMBuffer
	jsl rlHandlePossibleHDMA
	jsl rlCopyPPURegBuffer
	jsl rlUnknown808D9C
	jsl rlGetJoypadInput
	jsl rlUnknown82A783
	lda $7FFC78
	bit #$0001
	beq +

	jsl $9C9F8C
	bra ++

	+
	jsl rlClearSpriteAttributeBuffer

	+
	sep #$20
	lda #$00
	sta $7FE1D0
	rep #$20
	jsl rlUnknown80A50F
	jsl rlUnknown80A5DF
	jsl rlHideSprites
	jsl rlUnknown80932C
	plp
	rts

rsUnknown80D276 ; 80/D276

	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta INIDISP,b
	lda #HDMAEN_Setting(False, False, False, False, False, False, False, False)
	sta @l HDMAEN
	rep #$20
	jsl $9BC26F
	jsl $9CD58C
	jsl $8BE713
	jsl rlProcessDMAStructArray
	jsl rlDMAPaletteAndOAMBuffer
	jsl rlHandlePossibleHDMA
	jsl rlCopyPPURegBuffer
	jsl rlUnknown808D9C
	jsl rlGetJoypadInput
	jsl rlUnknown82A783
	jsl rlClearSpriteAttributeBuffer
	sep #$20
	lda #$00
	sta $7FE1D0
	rep #$20
	jsl rlUnknown80A50F
	jsl rlUnknown80A5DF
	jsl rlHideSprites
	jsl rlUnknown80932C
	plp
	rts

rlUnknown80D2CE ; 80/D2CE

	.al
	.autsiz
	.databank ?

	lda #$0001
	sta $7FAA14

	lda $7EA67F
	cmp #$0002
	beq +

	lda $7EA67F
	cmp #$0007
	beq ++

	lda #$0000
	sta $7E41AC
	jsr rsUnknown80D30E
	jsr rsUnknown80D461
	bra +++

	+
	lda #$0000
	sta $7E41AC
	jsl $9681BE
	jsr rsUnknown80D30E
	bra ++

	+
	jsl rlUnknown80DC51
	jsr rsUnknown80D30E

	+
	rtl

rsUnknown80D30E ; 80/D30E

	.al
	.autsiz
	.databank ?

	lda #(`$9A8A2D)<<8
	sta lR43+1
	lda #<>$9A8A2D
	sta lR43
	jsl rlHDMAArrayEngineCreateEntry
	rts

rlUnknown80D31D ; 80/D31D

	.al
	.autsiz
	.databank ?

	lda #$0001
	sta $7E41AC
	lda #$0001
	sta $7FAA14
	lda #<>rsUnknown80D369
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	jsr rsUnknown80D461
	rtl

rlUnknown80D343 ; 80/D343

	.al
	.autsiz
	.databank ?

	lda #$00FF
	sta $7E41AC
	lda #$0001
	sta $7FAA14
	lda #<>rsUnknown80D369
	sta wProcInput0,b
	lda #(`procUnknown82A1BB)<<8
	sta lR43+1
	lda #<>procUnknown82A1BB
	sta lR43
	jsl rlProcEngineCreateProc
	jsr rsUnknown80D461
	rtl

rsUnknown80D369 ; 80/D369

	.al
	.autsiz
	.databank ?

	php
	sep #$20
	lda #INIDISP_Setting(True)
	sta bBuf_INIDISP
	sta INIDISP,b
	rep #$20
	jsr rsUnknown80D44A
	jsl rlDisableVBlank
	jsl rlProcEngineResetProcEngine
	jsl rlActiveSpriteEngineReset
	jsl rlEnableActiveSpriteEngine
	jsl rlActiveSpriteEngineRenderOnScreenOnly
	jsl rlResetHDMAArrayEngine
	jsl rlUnknown82A6AE
	jsl $87C851
	jsl $9BB8BC
	jsl $9B8B45
	jsl $9BA10B
	lda #$0000
	sta wUnknown001846,b
	lda #$0043
	sta wUnknown001848,b
	sep #$20
	lda #$18
	sta bUnknown001863,b
	sta bUnknown0018A6,b
	rep #$20
	jsl $9B8000
	lda #(`$9C8095)<<8
	sta lR43+1
	lda #<>$9C8095
	sta lR43
	jsl rlUnknown82A701
	lda #(`$9C8000)<<8
	sta lR43+1
	lda #<>$9C8000
	sta lR43
	jsl rlUnknown82A701
	lda #(`$9C800F)<<8
	sta lR43+1
	lda #<>$9C800F
	sta lR43
	jsl rlUnknown82A701
	lda #(`$9C8050)<<8
	sta lR43+1
	lda #<>$9C8050
	sta lR43
	jsl rlUnknown82A701
	lda #(`$9C8078)<<8
	sta lR43+1
	lda #<>$9C8078
	sta lR43
	jsl rlUnknown82A701
	jsl rlUnknown82A6C8
	lda #$000B
	sta wUnknown000302,b
	lda #<>rsUnknown80D207
	sta wUnknown0000D3
	lda #<>rsUnknown80DC33
	sta wUnknown0000D7
	stz wUnknown000300,b
	jsl rlEnableVBlank
	sep #$20
	lda #$00
	sta bBuf_INIDISP
	sta INIDISP,b
	rep #$20
	plp
	jsl $9C8958
	cli
	rts

rlUnknown80D433 ; 80/D433

	.al
	.autsiz
	.databank ?

	lda #(`$7EB000)<<8
	sta lR18+1
	lda #<>$7EB000
	sta lR18
	lda #$4000
	sta wR19
	lda #$0000
	jsl rlBlockFillWord
	rtl

rsUnknown80D44A ; 80/D44A

	.al
	.autsiz
	.databank ?

	lda #(`$7FE000)<<8
	sta lR18+1
	lda #<>$7FE000
	sta lR18
	lda #$2000
	sta wR19
	lda #$0000
	jsl rlBlockFillWord
	rts

rsUnknown80D461 ; 80/D461

	.autsiz
	.databank ?

	jsl rlUnknown80D474
	jsl rlUnknown80D7B8
	jsr rsUnknown80D8A1
	jsl rlUnknown80D511
	jsr rsUnknown80D4D4
	rts

rlUnknown80D474 ; 80/D474

	.al
	.autsiz
	.databank ?

	lda aActionStructUnit1.DeploymentNumber
	and #Player | Enemy | NPC
	xba
	sta wR0
	lda aActionStructUnit2.DeploymentNumber
	and #Player | Enemy | NPC
	ora wR0
	pha
	lda #(`aUnknown80D49C)<<8
	sta lR18+1
	lda #<>aUnknown80D49C
	sta lR18
	pla
	jsl rlFindWordCharTableEntry
	sta $7E448C
	rtl

aUnknown80D49C ; 80/D49C
	.word (Player << 8) | Player
	.word $0100

	.word (Enemy << 8) | Enemy
	.word $0100

	.word (NPC << 8) | NPC
	.word $0100

	.word (Player << 8) | Enemy
	.word $0100

	.word (Enemy << 8) | Player
	.word $0001

	.word (Player << 8) | NPC
	.word $0001

	.word (NPC << 8) | Player
	.word $0100

	.word (NPC << 8) | Enemy
	.word $0100

	.word (Enemy << 8) | NPC
	.word $0001

.word $0000, $0000

aUnknown80D4C4 ; 80/D4C4
	.word $0100
	.word $0100
	.word $0100
	.word $0000
	.word $0000
	.word $0100
	.word $0100
	.word $0100

rsUnknown80D4D4 ; 80/D4D4

	.al
	.xl
	.autsiz
	.databank ?

	lda aActionStructUnit1.EquippedItemID1
	and #$00FF
	cmp #Fortify
	bne _End

	lda aActionStructUnit1.DeploymentNumber
	bit #Player
	bne +

	bit #Enemy
	bne ++

	+
	ldx #<>$7E41B8
	ldy #<>$7E4218
	bra ++

	+
	lda $7E41AD
	ora #$0001
	sta $7E41AD
	ldx #<>$7E4218
	ldy #<>$7E41B8

	+
	lda #$0000
	sta $0008,b,y
	sta $0016,b,y

	_End
	rts

rlUnknown80D511 ; 80/D511

	.al
	.xl
	.autsiz
	.databank ?

	lda $7EA4DE
	sta $7E41AE
	lda $7E41AC
	cmp #$00FF
	bne +

	jmp ++

	+
	lda #$0000
	sta $7E41B0
	sta $7E41B3
	lda aActionStructUnit1.Character
	jsl $968236
	sta wR0
	lda aActionStructUnit2.Character
	jsl $968236
	sta wR1
	jsl rlUnknown8C9CED
	lda @l lEventEngineLongParameter+1
	sta $7E41B1
	lda @l lEventEngineLongParameter
	sta $7E41B0
	lda $7E4596
	sta $7E4278

	+
	jsl $96835B
	phb
	php
	sep #$20
	lda #`aActionStructUnit1
	pha
	rep #$20
	plb

	.databank `aActionStructUnit1

	lda @l aActionStructUnit1.DeploymentNumber
	bit #Player
	bne +

	bit #Enemy
	bne ++

	+
	ldx #<>$7E41B8
	ldy #<>$7E4218
	bra ++

	+
	lda @l $7E41AD
	ora #$0001
	sta @l $7E41AD
	ldx #<>$7E4218
	ldy #<>$7E41B8

	+
	phx
	phy
	lda @l aActionStructUnit1.Character
	jsl $968236
	jsl $83941A
	ply
	plx
	lda @l $7E5132
	and #$00FF
	sta $000C,b,x
	phx
	phy
	lda @l aActionStructUnit2.Character
	jsl $968236
	jsl $83941A
	ply
	plx
	lda @l $7E5132
	and #$00FF
	sta $000C,b,y
	lda @l $7E41AC
	cmp #$00FF
	beq +

	phx
	phy
	lda #(`aBattleBannerTable)<<8
	sta lR18+1
	lda #<>aBattleBannerTable
	sta lR18
	lda @l aActionStructUnit1.Leader
	jsl rlFindByteCharTableEntry
	ply
	plx
	and #$00FF
	sta $0002,b,x
	phx
	phy
	lda #(`aBattleBannerTable)<<8
	sta lR18+1
	lda #<>aBattleBannerTable
	sta lR18
	lda @l aActionStructUnit2.Leader
	jsl rlFindByteCharTableEntry
	ply
	plx
	and #$00FF
	sta $0002,b,y
	lda @l aActionStructUnit1.DeploymentNumber
	and #$00FF
	sta $0006,b,x
	lda @l aActionStructUnit2.DeploymentNumber
	and #$00FF
	sta $0006,b,y

	+
	lda @l aActionStructUnit2.Character
	jsl $968236
	sta $0008,b,y
	lda @l aActionStructUnit1.Character
	jsl $968236
	sta $0008,b,x
	lda @l aActionStructUnit1.StartingClass
	and #$00FF
	sta $000A,b,x
	lda @l aActionStructUnit2.StartingClass
	and #$00FF
	sta $000A,b,y
	jsr rsUnknown80D768
	lda @l aActionStructUnit1.TerrainType
	phx
	phy
	jsl $968054
	ply
	plx
	sta $000E,b,x
	lda @l aActionStructUnit2.TerrainType
	phx
	phy
	jsl $968054
	ply
	plx
	sta $000E,b,y
	lda @l aActionStructUnit1.StartingCurrentHP
	and #$00FF
	sta $0010,b,x
	lda @l aActionStructUnit2.StartingCurrentHP
	and #$00FF
	sta $0010,b,y
	lda @l aActionStructUnit1.StartingMaxHP
	and #$00FF
	sta $0012,b,x
	lda @l aActionStructUnit2.StartingMaxHP
	and #$00FF
	sta $0012,b,y
	lda @l aActionStructUnit1.StartingLevel
	and #$00FF
	sta $0014,b,x
	lda @l aActionStructUnit2.StartingLevel
	and #$00FF
	sta $0014,b,y
	lda @l aActionStructUnit1.StartingExperience
	and #$00FF
	sta $0018,b,x
	lda @l aActionStructUnit2.StartingExperience
	and #$00FF
	sta $0018,b,y
	lda @l aActionStructUnit1.GainedExperience
	and #$00FF
	sta $001A,b,x
	lda @l aActionStructUnit2.GainedExperience
	and #$00FF
	sta $001A,b,y
	rep #$20
	lda #$FFFF
	sta $001C,b,x
	lda #$FFFF
	sta $001C,b,y
	lda #$0000
	sta $001E,b,x
	lda #$0000
	sta $001E,b,y
	lda #$0000
	sta $0020,b,x
	lda #$0000
	sta $0020,b,y
	lda #$0000
	sta $0022,b,x
	lda #$0000
	sta $0022,b,y
	lda #$0000
	sta $0026,b,x
	lda #$0000
	sta $0026,b,y
	sep #$20
	lda @l aActionStructUnit1.EquippedItemMaxDurability
	xba
	lda @l aActionStructUnit1.EquippedItemID1
	rep #$30
	sta $0028,b,x
	sep #$20
	lda @l aActionStructUnit2.EquippedItemMaxDurability
	xba
	lda @l aActionStructUnit2.EquippedItemID1
	rep #$30
	sta $0028,b,y
	sep #$20
	lda @l aActionStructUnit1.BattleAdjustedHit
	and #$FF
	sta $0032,b,x
	lda @l aActionStructUnit2.BattleAdjustedHit
	and #$FF
	sta $0032,b,y
	lda @l aActionStructUnit1.BattleMight
	and #$FF
	sta $003A,b,x
	lda @l aActionStructUnit2.BattleMight
	and #$FF
	sta $003A,b,y
	lda @l aActionStructUnit1.BattleDefense
	and #$FF
	sta $003C,b,x
	lda @l aActionStructUnit2.BattleDefense
	and #$FF
	sta $003C,b,y
	plp
	plb
	rep #$20
	rtl

rsUnknown80D768 ; 80/D768

	.autsiz
	.databank ?

	rts

rlUnknown80D769 ; 80/D769

	.al
	.autsiz
	.databank ?

	lda $7FFCA1
	bne _End

	lda $7EA4EA
	bne _End

	lda aActionStructUnit1.CurrentHP
	and #$00FF
	bne +

	lda aActionStructUnit1.Character
	jsl $968236
	bra ++

	+
	lda aActionStructUnit2.CurrentHP
	and #$00FF
	bne _End

	lda aActionStructUnit2
	jsl $968236

	+
	sta wR0
	jsl rlUnknown8C9D3F
	lda @l lEventEngineLongParameter+1
	sta $7E41B4
	lda @l lEventEngineLongParameter
	sta $7E41B3
	lda $7E4596
	sta $7E427A

	_End
	rtl

rlUnknown80D7B8 ; 80/D7B8

	.al
	.autsiz
	.databank ?

	lda aActionStructUnit1.DeploymentNumber
	bit #NPC
	bne +

	bit #Enemy
	bne ++

	+
	ldx #<>aActionStructUnit1
	bra ++

	+
	ldx #<>aActionStructUnit2

	+
	phb
	php
	sep #$20
	lda #`aActionStructUnit1
	pha
	rep #$20
	plb

	.databank `aActionStructUnit1

	lda #$0000
	sta @l $7E41CE
	sep #$20
	lda structActionStructEntry.Level,b,x
	sec
	sbc structActionStructEntry.StartingLevel,b,x
	rep #$20
	and #$00FF
	bne +

	jmp _End

	+
	sta @l $7E41CE
	sep #$20
	lda structActionStructEntry.MaxHP,b,x
	rep #$20
	sta @l $7E41F8
	lda structActionStructEntry.LevelUpHPGain,b,x
	and #$00FF
	sta @l $7E4208
	sep #$20
	lda structActionStructEntry.Strength,b,x
	rep #$20
	sta @l $7E41FA
	lda structActionStructEntry.LevelUpStrengthGain,b,x
	and #$00FF
	sta @l $7E420A
	sep #$20
	lda structActionStructEntry.Skill,b,x
	rep #$20
	sta @l $7E41FE
	lda structActionStructEntry.LevelUpSkillGain,b,x
	and #$00FF
	sta @l $7E420E
	sep #$20
	lda structActionStructEntry.Speed,b,x
	rep #$20
	sta @l $7E4200
	lda structActionStructEntry.LevelUpSpeedGain,b,x
	and #$00FF
	sta @l $7E4210
	sep #$20
	lda structActionStructEntry.Defense,b,x
	rep #$20
	sta @l $7E4202
	lda structActionStructEntry.LevelUpDefenseGain,b,x
	and #$00FF
	sta @l $7E4212
	sep #$20
	lda structActionStructEntry.Luck,b,x
	rep #$20
	sta @l $7E4206
	lda structActionStructEntry.LevelUpLuckGain,b,x
	and #$00FF
	sta @l $7E4216
	sep #$20
	lda structActionStructEntry.Magic,b,x
	rep #$20
	sta @l $7E41FC
	lda structActionStructEntry.LevelUpMagicGain,b,x
	and #$00FF
	sta @l $7E420C
	sep #$20
	lda structActionStructEntry.Constitution,b,x
	rep #$20
	sta @l $7E4204
	lda structActionStructEntry.LevelUpConstitutionGain,b,x
	and #$00FF
	sta @l $7E4214

	_End
	plp
	plb
	rtl

rsUnknown80D8A1 ; 80/D8A1

	.al
	.autsiz
	.databank ?

	lda aActionStructUnit1.EquippedItemID1
	jsl rlCopyItemDataToBuffer
	lda aItemDataBuffer.Type,b
	and #$00FF
	cmp #TypeStaff
	beq +

	jsr rsUnknown80D936
	bra ++

	+
	jsr rsUnknown80D8BD

	+
	rts

rsUnknown80D8BD ; 80/D8BD

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php
	sep #$20
	lda #`$7EA5D1
	pha
	rep #$20
	plb

	.databank `$7EA5D1

	phx
	lda #$0000
	tax
	tay

	-
	lda $7EA5D1,x
	and #$00FF
	cmp #$00FF
	beq +

	phx
	lda $7EA5D1,x
	and #$0002
	tax
	lda aUnknownActionStructSlotTable,x
	tax
	lda structActionStructEntry.DeploymentNumber,b,x
	and #$00FF
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	lsr a
	plx
	sep #$20
	sta $7E428C,y
	rep #$20
	phx
	jsr rsUnknown80DA7B
	sta wR0
	plx
	jsr rsUnknown80DB1C
	ora wR0
	sta wR0
	jsr rsUnknown80DAA5
	ora wR0
	sta wR0
	sep #$20
	lda $7E428C,y
	ora wR0
	sta $7E428C,y
	lda $7EA5D4,x
	eor #$FF
	inc a
	sta $7E428D,y
	rep #$20
	inc x
	inc x
	inc x
	inc x
	inc y
	inc y
	brl -

	+
	lda #$FFFF
	sta $7E428C,y
	plx
	plp
	plb
	rts

rsUnknown80D936 ; 80/D936

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php
	sep #$20
	lda #`$7E41AC
	pha
	rep #$20
	plb

	.databank `$7E41AC

	phx
	lda #$0000
	sta wR0
	sta wR1
	lda @l $7E41AC
	cmp #$0001
	bne +

	sep #$20
	lda #Enemy
	sta @l aActionStructUnit2.DeploymentNumber
	rep #$20

	+
	lda #$0000
	tax
	tay

	-
	lda $7EA5D2,x
	bit #$0400
	beq +

	inc x
	inc x

	+
	lda $7EA5D1,x
	and #$00FF
	cmp #$00FF
	bne +

	jmp _End

	+
	bit #$0080
	beq +

	lda @l $7E41AC
	cmp #$0001
	bne +

	tya
	beq +

	lda #$FEFF
	sta $7E428C,y
	inc y
	inc y

	+
	jsr rsUnknown80DA3C
	phx
	lda $7EA5D1,x
	and #$0002
	beq +

	lda @l $7E448C
	xba
	and #$00FF
	bra ++

	+
	lda @l $7E448C
	and #$00FF

	+
	plx
	sep #$20
	sta $7E428C,y
	rep #$20
	phx
	jsr rsUnknown80DA7B
	sta wR0
	plx
	lda $7EA5D1,x
	and #$0010
	ora wR0
	sta wR0
	jsr rsUnknown80DB1C
	ora wR0
	sta wR0
	jsr rsUnknown80DAA5
	ora wR0
	sta wR0
	jsr rsUnknown80DA0C
	sep #$20
	lda $7E428C,y
	ora wR0
	sta $7E428C,y
	phy
	phx
	plx
	lda $7EA5D4,x
	bra +

	plx
	lda $7EA5D4,x
	eor #$FF
	inc a

	+
	ply
	ora wR1
	sta $7E428D,y
	rep #$20
	inc x
	inc x
	inc x
	inc x
	inc y
	inc y
	brl -

	_End
	lda #$FFFF
	sta $7E428C,y
	plx
	plp
	plb
	rts

rsUnknown80DA0C ; 80/DA0C

	.al
	.xl
	.autsiz
	.databank ?

	phx
	pha
	lda <>$7EA5D2,b,x
	bit #$0080
	beq ++

	lda <>$7EA5D1,b,x
	and #$0002
	tax
	lda aUnknownActionStructSlotTable,x
	tax
	lda structActionStructEntry.EquippedItemID1,b,x
	and #$00FF
	cmp #DevilAxe
	beq +
	bra ++

	+
	lda #$0080
	bra ++

	+
	lda #$0000

	+
	sta wR1
	pla
	plx
	rts

rsUnknown80DA3C ; 80/DA3C

	.al
	.xl
	.autsiz
	.databank ?

	phb
	php
	phk
	plb

	.databank `*

	phx
	lda $7EA5D2,x
	ldx #$0000

	-
	phx
	pha
	bit aUnknown80DA6B,x
	beq +

	lda aUnknown80DA73,x
	tyx
	xba
	ora #$00FE
	sta $7E428C,x
	txy
	inc y
	inc y

	+
	pla
	plx
	inc x
	inc x
	cpx #$0008
	bne -

	plx
	plp
	plb
	rts

aUnknown80DA6B ; 80/DA6B
	.word $0010
	.word $0020
	.word $0040
	.word $0004

aUnknown80DA73 ; 80/DA73
	.word $0013
	.word $0014
	.word $0015
	.word $0002

rsUnknown80DA7B ; 80/DA7B

	.al
	.xl
	.autsiz
	.databank `$7EA67F

	phx
	phy
	lda #$0042
	ldy $7EA67F
	cpy #$0003
	beq +

	lda $7EA5D2,x
	and #$0002
	asl a
	asl a
	sta wR0
	lda $7EA5D2,x
	and #$0001
	asl a
	asl a
	ora wR0
	sta wR0

	+
	ply
	plx
	rts

aUnknownActionStructSlotTable ; 80/DAA1
	.word <>aActionStructUnit1
	.word <>aActionStructUnit2

rsUnknown80DAA5 ; 80/DAA5

	.al
	.xl
	.autsiz
	.databank `$7EA5D1

	phx
	phy
	ldy wR0
	phy
	lda $7EA5D1,x
	and #$0002
	tax
	lda aUnknownActionStructSlotTable,x
	tax
	lda structActionStructEntry.EquippedItemID1,b,x
	pha
	lda @l $7EA4DE
	and #$00FF
	cmp #$0002
	bcc +

	pla
	and #$00FF
	cmp #EarthSword
	beq +++

	cmp #LightBrand
	beq +++

	cmp #WindSword
	beq +++

	cmp #FireBrand
	beq +++

	cmp #VoltEdge
	beq +++

	bra ++

	+
	pla

	+
	jsl rlCopyItemDataToBuffer
	lda aItemDataBuffer.Type,b
	and #$00FF
	cmp #TypeFire
	beq +

	cmp #TypeThunder
	beq +

	cmp #TypeWind
	beq +

	cmp #TypeLight
	beq +

	cmp #TypeDark
	beq +

	bra ++

	+
	lda #$0040
	and #$00FF
	bra ++

	+
	lda #$0000

	+
	ply
	sty wR0
	ply
	plx
	rts

rsUnknown80DB1C ; 80/DB1C

	.al
	.xl
	.autsiz
	.databank `$7EA5D1

	lda @l $7EA4DE
	and #$00FF
	cmp #$0002
	blt +

	phx
	phy
	ldy wR0
	phy
	lda $7EA5D1,x
	and #$0002
	tax
	lda aUnknownActionStructSlotTable,x
	tax
	lda structActionStructEntry.EquippedItemID1,b,x
	and #$00FF
	cmp #EarthSword
	beq ++

	cmp #LightBrand
	beq ++

	cmp #WindSword
	beq ++

	cmp #FireBrand
	beq ++

	cmp #VoltEdge
	beq ++

	cmp #DarkLance
	beq ++

	cmp #Javelin
	beq ++

	cmp #MasterLance
	beq ++

	cmp #HandAxe
	beq ++

	cmp #KillerAxe
	beq ++

	cmp #Pugi
	beq ++

	cmp #MasterAxe
	beq ++

	jsl rlCopyItemDataToBuffer
	lda aItemDataBuffer.Type,b
	and #$00FF
	ply
	sty wR0
	ply
	plx
	cmp #TypeBow
	beq _True

	lda #$0000
	bra _End

	+
	dec a
	beq _End

	_True
	lda #$0020
	and #$00FF

	_End
	rts

	+
	ply
	sty wR0
	ply
	plx
	bra _True

rsUnknown80DBA5 ; 80/DBA5

	.al
	.autsiz
	.databank ?

	php
	lda #$0000
	bra rsUnknown80DBAF

rsUnknown80DBAB ; 80/DBAB

	.al
	.autsiz
	.databank ?

	php
	lda #$0001

rsUnknown80DBAF ; 80/DBAF

	.al
	.autsiz
	.databank ?

	sep #$20
	sta $7FD8B9
	rep #$20
	sep #$20
	lda #INIDISP_Setting(True)
	sta bBuf_INIDISP
	sta INIDISP,b
	rep #$20
	jsl rlDisableVBlank
	jsl $9BF024
	bcc +

	sep #$20
	lda #$01
	sta $7FD8B9
	rep #$20

	+
	jsl rlProcEngineResetProcEngine
	jsl rlActiveSpriteEngineReset
	jsl rlResetHDMAArrayEngine
	jsl rlUnknown82A6AE
	jsl $9BEE3B
	jsl $9BEFD1
	lda #(`$9C80A4)<<8
	sta lR43+1
	lda #<>$9C80A4
	sta lR43
	jsl rlUnknown82A701
	lda #(`$9C80B3)<<8
	sta lR43+1
	lda #<>$9C80B3
	sta lR43
	jsl rlUnknown82A701
	jsl rlUnknown82A6C8
	lda #$0000
	sta wUnknown000302,b
	lda #<>rsUnknown80D276
	sta wUnknown0000D3
	lda #<>rsUnknown80DC44
	sta wUnknown0000D7
	stz wUnknown000300,b
	jsl rlEnableVBlank
	sep #$20
	lda #INIDISP_Setting(True)
	sta bBuf_INIDISP
	sta INIDISP,b
	rep #$20
	plp
	cli
	rts

rsUnknown80DC33 ; 80/DC33

	.autsiz
	.databank ?

	jsl rlButtonCombinationResetCheck
	jsl rlDecompressByList
	jsl rlUnknown8096B3
	jsl $9C9822
	rts

rsUnknown80DC44 ; 80/DC44

	.autsiz
	.databank ?

	jsl rlButtonCombinationResetCheck
	jsl rlDecompressByList
	jsl rlUnknown8096B3
	rts

rlUnknown80DC51 ; 80/DC51

	.al
	.autsiz
	.databank ?

	lda #$0002
	sta $7E41AC
	jsl $968237
	jsl rlUnknown80D511
	lda #$FFFF
	sta $7E428C
	lda #$0016
	sta $7E41B6
	lda #$0000
	sta $7E41CE
	lda aActionStructUnit1.Character
	jsl $968236
	sta $7E41C0
	sta $7E4220
	lda aActionStructUnit1.Character
	jsl $968236
	jsl $83941A
	lda $7E5132
	and #$00FF
	sta $7E4224
	sta $7E41C4
	lda aActionStructUnit2.StartingClass
	and #$00FF
	sta $7E41C2
	lda aActionStructUnit1.Class
	and #$00FF
	sta $7E4222
	lda #(`aBattleBannerTable)<<8
	sta lR18+1
	lda #<>aBattleBannerTable
	sta lR18
	lda aActionStructUnit1.Leader
	jsl rlFindByteCharTableEntry
	sta $7E41BA
	sta $7E421A
	lda aActionStructUnit1.DeploymentNumber
	and #$00FF
	sta $7E41BE
	sta $7E421E
	lda aActionStructUnit1.TerrainType
	and #$00FF
	sta $7E41C6
	sta $7E4226
	lda aActionStructUnit1.CurrentHP
	and #$00FF
	sta $7E41C8
	sta $7E4228
	lda aActionStructUnit2.MaxHP
	and #$00FF
	sta $7E41CA
	lda aActionStructUnit1.MaxHP
	and #$00FF
	sta $7E422A
	lda #$0001
	sta $7E41CC
	lda #$0001
	sta $7E422C
	lda #$0000
	sta $7E41D0
	sta $7E4230
	sta $7E41D2
	sta $7E4232
	sep #$20
	lda aActionStructUnit1.EquippedItemMaxDurability
	xba
	lda aActionStructUnit1.EquippedItemID1
	rep #$30
	sta $7E41E0
	sta $7E4240
	lda aActionStructUnit1.BattleAdjustedHit
	and #$00FF
	sta $7E41EA
	sta $7E424A
	lda aActionStructUnit1.BattleMight
	and #$00FF
	sta $7E41F2
	sta $7E4252
	lda aActionStructUnit1.BattleDefense
	and #$00FF
	sta $7E41F4
	sta $7E4254
	rtl
