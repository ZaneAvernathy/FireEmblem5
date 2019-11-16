
rlDMAPaletteAndOAMBuffer ; 80/807C

	.autsiz
	.databank ?

	; Copies the palette and sprite buffers
	; to CGRAM and OAM.

	; You shouldn't call this yourself.

	; Inputs:
	; Sprite buffer and palette buffer

	; Outputs:
	; None

	php
	sep #$10
	rep #$20

	lda #((OAMDATA - PPU_REG_BASE) << 8) | DMAPx_Setting(DMAPx_TransferCPUToIO, DMAPx_Mode0, DMAPx_ABusIncrement, DMAPx_Direct)
	sta DMAP0,b
	lda #<>aSpriteBuf
	sta A1T0,b
	ldx #`aSpriteBuf
	stx A1T0+2,b
	lda #size(aSpriteBuf) + size(aSpriteBufUpperAttributes)
	sta DAS0,b
	stz OAMADD,b

	lda #((CGDATA - PPU_REG_BASE) << 8) | DMAPx_Setting(DMAPx_TransferCPUToIO, DMAPx_Mode0, DMAPx_ABusIncrement, DMAPx_Direct)
	sta DMAP1,b
	lda #<>aBGPaletteBuffer
	sta A1T1,b
	ldx #`aBGPaletteBuffer
	stx A1T1+2,b
	lda #size(aBGPaletteBuffer)+size(aOAMPaletteBuffer)
	sta DAS1,b
	ldx #$00 ; color index 0
	stx CGADD,b

	ldx #MDMAEN_Setting(True, True, False, False, False, False, False, False)
	stx MDMAEN,b
	lda wBuf_OAMADD
	sta OAMADD,b
	plp
	rtl

rlCopyPPURegBuffer ; 80/80C3

	.autsiz
	.databank ?

	; Copies the PPU register buffer
	; to the actual registers.

	; You shouldn't call this yourself.

	; Inputs:
	; PPU register buffer

	; Outputs:
	; None

	php
	phb
	phk
	plb

	.databank `*

	sep #$20

	lda bBuf_INIDISP
	sta INIDISP,b

	lda bBuf_OBSEL
	sta OBSEL,b

	lda bBuf_BGMODE
	sta BGMODE,b

	lda bBuf_MOSAIC
	sta MOSAIC,b

	lda bBuf_BG1SC
	sta BG1SC,b

	lda bBuf_BG2SC
	sta BG2SC,b

	lda bBuf_BG3SC
	sta BG3SC,b

	lda bBuf_BG4SC
	sta BG4SC,b

	lda bBuf_BG12NBA
	sta BG12NBA,b

	lda bBuf_BG34NBA
	sta BG34NBA,b

	lda bBuf_W12SEL
	sta W12SEL,b

	lda bBuf_W34SEL
	sta W34SEL,b

	lda bBuf_WOBJSEL
	sta WOBJSEL,b

	lda bBuf_WH0
	sta WH0,b

	lda bBuf_WH1
	sta WH1,b

	lda bBuf_WH2
	sta WH2,b

	lda bBuf_WH3
	sta WH3,b

	lda bBuf_WBGLOG
	sta WBGLOG,b

	lda bBuf_WOBJLOG
	sta WOBJLOG,b

	lda bBuf_TM
	sta TM,b

	lda bBuf_TMW
	sta TMW,b

	lda bBuf_TS
	sta TS,b

	lda bBuf_TSW
	sta TSW,b

	lda bBuf_CGWSEL
	sta CGWSEL,b

	lda bBuf_CGADSUB
	sta CGADSUB,b

	lda bBuf_COLDATA_1
	sta COLDATA,b

	lda bBuf_COLDATA_2
	sta COLDATA,b

	lda bBuf_COLDATA_3
	sta COLDATA,b

	lda bBuf_SETINI
	sta SETINI,b

	lda wBuf_BG1HOFS
	sta BG1HOFS,b
	lda wBuf_BG1HOFS+1
	sta BG1HOFS,b

	lda wBuf_BG1VOFS
	sec
	sbc #$01
	sta BG1VOFS,b
	lda wBuf_BG1VOFS+1
	sbc #$00
	sta BG1VOFS,b
	lda wBuf_BG2HOFS
	sta BG2HOFS,b
	lda wBuf_BG2HOFS+1
	sta BG2HOFS,b
	lda wBuf_BG2VOFS
	sec
	sbc #$01
	sta BG2VOFS,b
	lda wBuf_BG2VOFS+1
	sbc #$00
	sta BG2VOFS,b
	lda wBuf_BG3HOFS
	sta BG3HOFS,b
	lda wBuf_BG3HOFS+1
	sta BG3HOFS,b
	lda wBuf_BG3VOFS
	sec
	sbc #$01
	sta BG3VOFS,b
	lda wBuf_BG3VOFS+1
	sbc #$00
	sta BG3VOFS,b

	plb
	plp
	rtl

rlCopyINIDISPBuffer ; 80/81A8

	.autsiz
	.databank ?

	; Copies INIDISP from buffer to register

	; Inputs:
	; bBuf_INIDISP

	; Outputs:
	; None

	php
	phb

	phk
	plb

	.databank `*

	sep #$20

	lda bBuf_INIDISP
	sta INIDISP,b

	plb
	plp
	rtl
