
rsUnknown809B00 ; 80/9B00

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
  jsl $8E8A7D
  jsl rlCopyPPURegBuffer
  jsl rlUnknown808D9C
  jsl rlGetJoypadInput
  jsl rlUnknown80B0D1
  jsl rlClearSpriteAttributeBuffer
  jsl rlUnknown80A50F
  jsl rlGetMapScrollReturnStep
  jsl rlUnknown80A5DF
  jsl rlUpdateBGTilemapsByMapScrollAmount
  jsl rlHandleMapScrollStep
  jsl rlUpdateBGTilemaps
  jsl $83C393
  jsl $83C4CF
  jsl $888755
  jsl rlRenderObjectiveMarkers
  jsl rlHideSprites
  jsl rlUnknown80932C
  jsl rlButtonCombinationResetCheck
  rts

rsUnknown809B6F ; 80/9B6F

  .autsiz
  .databank ?

  jsl rlDecompressByList
  jsl rlUnknown8096B3
  jsl $8D8000
  jsl rlUnknown8C936B
  rts

rsUnknown809B80 ; 80/9B80

  .al
  .autsiz
  .databank ?

  php
  jsl rlUnknown80A6CA
  jsl rlUnknown80A711
  lda #(`$7EA2DC)<<8
  sta lR18+1
  lda #<>$7EA2DC
  sta lR18
  lda #$0001
  sta wUnknown000DA6,b
  lda #$5A23
  jsl rlUnknown82B26A
  lda #(`$7EA2DC)<<8
  sta lR18+1
  lda #<>$7EA2DC
  sta lR18
  lda #$0001
  sta wUnknown000DA6,b
  lda #$0200
  jsl rlUnknown82B26A
  lda #$000A
  sta wJoyLongTime
  lda #$0004
  sta wJoyShortTime
  lda #<>aBG1TilemapBuffer
  sta wR0
  lda #$02FF
  jsl rlFillTilemapByWord
  lda #<>aBG2TilemapBuffer
  sta wR0
  lda #$0024
  jsl rlFillTilemapByWord
  lda #<>aBG3TilemapBuffer
  sta wR0
  lda #$01DF
  jsl rlFillTilemapByWord
  lda #$2000
  sta wR1
  lda #$2000
  sta wR2
  lda #$5000
  sta wR3
  lda #$5000
  sta wR4
  lda #$0000
  sta wR5
  lda #$7000
  sta wR6
  lda #$7800
  sta wR7
  lda #$5000
  sta wR8
  jsl rlUnknown80A883
  jsl rlProcEngineResetProcEngine
  jsl rlActiveSpriteEngineReset
  jsl rlEnableActiveSpriteEngine
  jsl rlActiveSpriteEngineRenderOnScreenOnly
  jsl rlResetHDMAArrayEngine
  jsl rlUnknown82A6AE
  jsl $87C851
  jsl rlResetRNTable
  sep #$20
  lda #TM_Setting(True, True, True, False, True)
  sta bBuf_TM
  lda #BGMODE_Setting(1, True)
  sta bBuf_BGMODE
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
  plp
  rts

rsUnknown809C55 ; 80/9C55

  .autsiz
  .databank ?

  php
  rep #$30
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $F3CC80, $2800, VMAIN_Setting(True), $B800

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $F1F080, $800, VMAIN_Setting(True), $2000

  lda #$0000
  sta $7E4FC4
  sta $7E4FC6
  sta $7E4FC2
  jsl $848952
  jsl $8489BC
  jsl $8489E8
  jsl $85968D
  jsl $848A20
  jsl rlUnknown809C9B
  plp
  rts

rlUnknown809C9B ; 80/9C9B

  .al
  .autsiz
  .databank ?

  lda #(`$9E8200)<<8
  sta lR18+1
  lda #<>$9E8200
  sta lR18
  lda #(`aOAMPal4)<<8
  sta lR19+1
  lda #<>aOAMPal4
  sta lR19
  lda #$0060
  sta wR20
  jsl rlBlockCopy
  lda #(`$9E8260)<<8
  sta lR18+1
  lda #<>$9E8260
  sta lR18
  lda #(`aBGPal0)<<8
  sta lR19+1
  lda #<>aBGPal0
  sta lR19
  lda #$0020
  sta wR20
  jsl rlBlockCopy
  lda #(`$F4FF80)<<8
  sta lR18+1
  lda #<>$F4FF80
  sta lR18
  lda #(`aOAMPal0)<<8
  sta lR19+1
  lda #<>aOAMPal0
  sta lR19
  lda #$0080
  sta wR20
  jsl rlBlockCopy
  rtl

rsUnknown809CF3 ; 80/9CF3

  .autsiz
  .databank ?

  rep #$20
  lda #$0001
  sta wUnknown000300,b
  lda #$0002
  sta wUnknown000302,b
  stz wUnknown000304,b
  lda #<>rsUnknown809B00
  sta wUnknown0000D3
  lda #<>rsUnknown809B6F
  sta wUnknown0000D7
  rts

rsUnknown809D0F ; 80/9D0F

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
  jsl $83B399
  jsl $83B267
  jsr rsUnknown809C55
  jsr rsUnknown809CF3
  jsl $848E1D
  jsl $85E1D8
  jsl $8A8CD4
  jsl $8A927D
  jsl $8488FA
  jsl rlUnknown8C9689
  jsl $83808F
  jsl $83F4D5
  jsl $83A74E
  jsl $8885D1
  lda #$0003
  cmp $7E4FB8
  bne _9D85

  sep #$20
  lda aSRAM.aSaveDataHeader.LastSuspend
  sta $7E4FB8
  rep #$20
  stz wCurrentMapMusic,b
  jsl $83A5A4
  lda #$0003
  jsl rlGetSaveSlotOffset
  ldx wSaveSlotOffset,b
  lda #$0000
  sta aSRAM,x

  _9D85
  jsl $85910B
  jsl rlUpdateVisibilityMap
  jsl rlUpdateUnitMapsAndFog
  jsr rsUnknown80A139
  stz wUnknown000E6D,b
  lda #$0001
  sta wUnknown00033F,b
  lda #(`procFadeIn2)<<8
  sta lR43+1
  lda #<>procFadeIn2
  sta lR43
  jsl rlProcEngineCreateProc
  sep #$20
  stz bBuf_INIDISP
  lda #TM_Setting(True, True, True, False, True)
  sta bBuf_TM
  jsl rlEnableVBlank
  plp
  cli
  rts

rsUnknown809DBA ; 80/9DBA

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
  jsr rsUnknown809CF3
  jsr rsUnknown809C55
  jsl $84A17D
  jsl $8A8CD4
  stz wCurrentMapMusic,b
  lda #$000E
  cmp wUnknown000E25,b
  beq _9DEA

  jsl $83A5A4

  _9DEA
  jsl $85910B
  jsl rlUnknown81C466
  jsl $848E1D
  jsl $83A74E
  lda #aSelectedCharacterBuffer
  sta wR1
  jsl $8390AD
  lda wCurrentTurn,b
  bne _9E0C

  jsl rlUnknown81C525

  _9E0C
  jsl rlUpdateUnitMapsAndFog
  jsr rsUnknown80A139
  lda #$0000
  sta $7E4FBC
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $7F2614, $2000, VMAIN_Setting(True), $0000

  phx
  lda #(`procFadeInClearJoypad)<<8
  sta lR43+1
  lda #<>procFadeInClearJoypad
  sta lR43
  jsl rlProcEngineCreateProc
  plx
  sep #$20
  stz bBuf_INIDISP
  lda #TM_Setting(True, True, True, False, True)
  sta bBuf_TM
  jsl rlEnableVBlank
  plp
  cli
  rts

rsUnknown809E46 ; 80/9E46

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
  jsr rsUnknown809CF3
  jsr rsUnknown809C55
  jsl $8A8CD4
  jsl rlUpdateUnitMapsAndFog
  jsr rsUnknown80A139
  jsl $85910B
  jsl $85E1D8
  lda #$0001
  sta wUnknown00033F,b
  lda #(`procFadeIn2)<<8
  sta lR43+1
  lda #<>procFadeIn2
  sta lR43
  jsl rlProcEngineCreateProc
  sep #$20
  stz bBuf_INIDISP
  lda #TM_Setting(True, True, True, False, True)
  sta bBuf_TM
  jsl rlEnableVBlank
  plp
  cli
  rts

rsUnknown809E95 ; 80/9E95

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
  jsr rsUnknown809CF3
  jsr rsUnknown809C55
  jsl $8A8CD4
  jsl rlUpdateUnitMapsAndFog
  jsr rsUnknown80A139
  jsl $85910B
  jsl $85E1D8
  jsl $848E1D
  jsl $83A74E
  jsl $8885D1
  lda #$0001
  sta wUnknown00033F,b
  lda #(`procFadeIn2)<<8
  sta lR43+1
  lda #<>procFadeIn2
  sta lR43
  jsl rlProcEngineCreateProc
  sep #$20
  stz bBuf_INIDISP
  lda #TM_Setting(True, True, True, False, True)
  sta bBuf_TM
  jsl rlEnableVBlank
  plp
  cli
  rts

rsUnknown809EF0 ; 80/9EF0

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
  jsr rsUnknown809CF3
  jsr rsUnknown809C55
  jsl $8A8CD4
  jsl $8A927D
  jsl rlUpdateUnitMapsAndFog
  jsr rsUnknown80A139
  jsl $85910B
  jsl rlHideAllSprites
  lda #$0000
  sta wUnknown000E25,b
  lda #$0000
  sta wBGUpdateFlags
  sta $7E4FBC
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG1TilemapBuffer, $0700, VMAIN_Setting(True), $E000

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG2TilemapBuffer, $0700, VMAIN_Setting(True), $F000

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer, $0700, VMAIN_Setting(True), $A000

  lda wPrepScreenFlag,b
  beq +

  lda #$0001
  sta wPrepScreenFlag,b

  +
  sep #$20
  lda #INIDISP_Setting(False, 15)
  sta bBuf_INIDISP
  lda #TM_Setting(True, True, True, False, True)
  sta bBuf_TM
  jsl rlEnableVBlank
  plp
  cli
  rts

rsUnknown809F74 ; 80/9F74

  .autsiz
  .databank ?

  php
  sep #$20
  lda #INIDISP_Setting(True)
  sta INIDISP,b
  sta bBuf_INIDISP
  rep #$20
  jsl rlDisableVBlank
  lda #<>aBG1TilemapBuffer
  sta wR0
  lda #$02FF
  jsl rlFillTilemapByWord
  lda #<>aBG3TilemapBuffer
  sta wR0
  lda #$01DF
  jsl rlFillTilemapByWord
  jsr rsUnknown809CF3
  jsl rlUpdateUnitMapsAndFog
  jsr rsUnknown80A139
  jsl rlUnknown809FE5
  jsl $8489BC
  jsl rlUnknown809C9B
  jsl $84A17D
  jsl $85968D
  jsl $85910B
  jsl $8A927D
  lda #$0001
  sta wUnknown00033F,b
  lda #(`procFadeIn2)<<8
  sta lR43+1
  lda #<>procFadeIn2
  sta lR43
  jsl rlProcEngineCreateProc
  sep #$20
  stz bBuf_INIDISP
  lda #TM_Setting(True, True, True, False, True)
  sta bBuf_TM
  jsl rlEnableVBlank
  plp
  cli
  rts

rlUnknown809FE5 ; 80/9FE5

  .autsiz
  .databank ?

  rep #$30
  ldy #$0007

  -
  tya
  jsl rlHDMAArrayEngineFreeEntryByIndex
  dec y
  bpl -
  ldy #$000F

  -
  tya
  jsl rlProcEngineDeleteProcByIndex
  dec y
  bpl -

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
  rep #$30
  rtl

rlUnknown80A01A ; 80/A01A

  .al
  .xl
  .autsiz
  .databank ?

  lda #<>rsUnknown809D0F
  sta wProcInput0,b
  lda #(`procUnknown82A1BB)<<8
  sta lR43+1
  lda #<>procUnknown82A1BB
  sta lR43
  jsl rlProcEngineCreateProc
  rtl

rlUnknown80A02F ; 80/A02F

  .al
  .xl
  .autsiz
  .databank ?

  lda #<>rsUnknown80A059
  sta wProcInput0,b
  lda #(`procUnknown82A1BB)<<8
  sta lR43+1
  lda #<>procUnknown82A1BB
  sta lR43
  jsl rlProcEngineCreateProc
  rtl

rlUnknown80A044 ; 80/A044

  .al
  .xl
  .autsiz
  .databank ?

  lda #<>rsUnknown809F74
  sta wProcInput0,b
  lda #(`procUnknown82A1BB)<<8
  sta lR43+1
  lda #<>procUnknown82A1BB
  sta lR43
  jsl rlProcEngineCreateProc
  rtl

rsUnknown80A059 ; 80/A059

  .al
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
  jsr rsUnknown809CF3
  jsr rsUnknown809C55
  jsl $8A8CD4
  lda #aSelectedCharacterBuffer
  sta wR1
  jsl $83A89D
  jsl $8A8D9C
  jsl $84A17D
  jsl rlUpdateUnitMapsAndFog
  jsr rsUnknown80A139
  jsl $85910B
  lda #$0001
  sta wUnknown00033F,b
  lda #(`procFadeIn2)<<8
  sta lR43+1
  lda #<>procFadeIn2
  sta lR43
  jsl rlProcEngineCreateProc
  sep #$20
  stz bBuf_INIDISP
  lda #TM_Setting(True, True, True, False, True)
  sta bBuf_TM
  jsl rlEnableVBlank
  plp
  cli
  rts

rsUnknown80A0B5 ; 80/A0B5

  .al
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
  jsr rsUnknown809CF3
  jsr rsUnknown809C55
  jsl $84A17D
  stz wCurrentMapMusic,b
  jsl $83A5A4
  jsl $85910B
  jsl $848E1D
  jsl $83A74E
  lda #aSelectedCharacterBuffer
  sta wR1
  jsl $8390AD
  jsl $8A8CD4
  lda #aSelectedCharacterBuffer
  sta wR1
  jsl $83A89D
  jsl $8A8D9C
  jsl rlUpdateUnitMapsAndFog
  jsr rsUnknown80A139
  lda #$0000
  sta $7E4FBC
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $7F2614, $2000, VMAIN_Setting(True), $0000

  phx
  lda #(`procFadeInAfterSound)<<8
  sta lR43+1
  lda #<>procFadeInAfterSound
  sta lR43
  jsl rlProcEngineCreateProc
  plx
  sep #$20
  stz bBuf_INIDISP
  lda #TM_Setting(True, True, True, False, True)
  sta bBuf_TM
  jsl rlEnableVBlank
  plp
  cli
  rts

rsUnknown80A139 ; 80/A139

  .al
  .xl
  .autsiz
  .databank ?

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG1TilemapBuffer, $0700, VMAIN_Setting(True), $E000

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG2TilemapBuffer, $0700, VMAIN_Setting(True), $F000

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer, $0700, VMAIN_Setting(True), $A000

  rts

rsUnknown80A161 ; 80/A161

  .al
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
  jsl $83B399
  jsl $83B267
  jsr rsUnknown809C55
  jsr rsUnknown809CF3
  jsl $848E1D
  jsl $85E1D8
  jsl $8A8CD4
  jsl $8A927D
  jsl $8488FA
  jsl rlUnknown8C9689
  jsl $83808F
  jsl $83F4D5
  jsl $888550
  jsl rlUnknown8C9DFC
  jsl $83A74E
  jsl $85910B
  jsl rlUpdateVisibilityMap
  jsl rlUpdateUnitMapsAndFog
  jsr rsUnknown80A139

  lda #$0001
  sta wUnknown00033F,b

  lda #(`procFadeIn2)<<8
  sta lR43+1
  lda #<>procFadeIn2
  sta lR43
  jsl rlProcEngineCreateProc

  sep #$20
  stz bBuf_INIDISP

  lda #TM_Setting(True, True, True, False, True)
  sta bBuf_TM

  jsl rlEnableVBlank
  plp
  cli
  rts

rsUnknown80A1E0 ; 80/A1E0

  .al
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
  jsr rsUnknown809CF3
  jsr rsUnknown809C55
  jsl $8A8CD4
  jsl $8A927D
  jsl $85910B
  jsl rlHideAllSprites
  jsl $848E1D
  jsl $83A74E
  jsl rlUpdateUnitMapsAndFog
  jsr rsUnknown80A139

  lda #$0000
  sta wUnknown000E25,b

  lda #$0000
  sta wBGUpdateFlags
  sta $7E4FBC

  sep #$20
  lda #INIDISP_Setting(False, 15)
  sta bBuf_INIDISP
  lda #TM_Setting(True, True, True, False, True)
  sta bBuf_TM

  jsl rlEnableVBlank
  plp
  cli
  rts

rsUnknown80A23A ; 80/A23A

  .al
  .xl
  .autsiz
  .databank ?

  phb
  php
  phk
  plb

  .databank `*

  sep #$20
  lda #INIDISP_Setting(True)
  sta INIDISP,b
  sta bBuf_INIDISP

  lda #BGSC_Setting(BGSize32x32, $0000)
  sta bBuf_BG1SC
  sta bBuf_BG2SC
  sta bBuf_BG3SC
  rep #$20

  jsl rlDisableVBlank
  jsl rlUnknown80A6CA
  jsl rlUnknown80A711

  lda #16
  sta wJoyLongTime
  lda #4
  sta wJoyShortTime
  lda #$2000
  sta wR1
  lda #$2000
  sta wR2
  lda #$5000
  sta wR3
  lda #$5000
  sta wR4
  lda #$0000
  sta wR5
  lda #$7800
  sta wR6
  lda #$7C00
  sta wR7
  lda #$6800
  sta wR8
  jsl rlUnknown80A883
  jsl rlProcEngineResetProcEngine
  jsl rlUnknown82A989
  jsl rlActiveSpriteEngineReset
  jsl rlEnableActiveSpriteEngine
  jsl rlResetHDMAArrayEngine
  jsl rlUnknown82A6AE
  jsl $87C851
  jsl rlResetRNTable

  lda #(`aBG1TilemapBuffer)<<8
  sta lR18+1
  lda #<>aBG1TilemapBuffer
  sta lR18
  lda #$0800
  sta lR19
  lda #$01FF
  jsl rlBlockFillWord

  lda #(`aBG2TilemapBuffer)<<8
  sta lR18+1
  lda #<>aBG2TilemapBuffer
  sta lR18
  lda #$0800
  sta lR19
  lda #$01FF
  jsl rlBlockFillWord

  jsl rlUnknown8CC669
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $7FB0F5, $2000, VMAIN_Setting(True), $6000

  jsl rlUnknown8CC670
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $7FB0F5, $2000, VMAIN_Setting(True), $8000

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, g4bppBlank80A43E, size(g4bppBlank80A43E), VMAIN_Setting(True), $7FE0

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, g4bppBlank80A43E, size(g4bppBlank80A43E), VMAIN_Setting(True), $9FE0

  jsl rlUnknown8CC677
  lda #(`aBG1TilemapBuffer)<<8
  sta lR18+1
  lda #<>aBG1TilemapBuffer
  sta lR18
  lda #$0800
  sta lR19
  lda #$0100
  jsl rlBlockAddWord
  jsl rlUnknown8CC68C
  lda #(`$7ED9BC)<<8
  sta lR18+1
  lda #<>$7ED9BC
  sta lR18
  lda #$02C0
  sta lR19
  lda #$0200
  jsl rlBlockAddWord
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG2TilemapBuffer, $0800, VMAIN_Setting(True), $F800

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, g2bppBlank80A43E, size(g2bppBlank80A43E), VMAIN_Setting(True), $BFF0

  lda #(`aBG1TilemapBuffer)<<8
  sta lR18+1
  lda #<>aBG3TilemapBuffer
  sta lR18
  lda #$0800
  sta lR19
  lda #$01FF
  jsl rlBlockFillWord
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer, $0800, VMAIN_Setting(True), $D000

  jsl rlUnknown8CC6A1
  lda #(`$7FB135)<<8
  sta lR18+1
  lda #<>$7EB135
  sta lR18
  lda #(`aBGPal2)<<8
  sta lR19+1
  lda #<>aBGPal2
  sta lR19
  lda #$0080
  sta wR20
  jsl rlBlockCopy
  jsl rlLoadDialogueBGDialogueBoxGraphicsAndPalette
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG1TilemapBuffer, $0800, VMAIN_Setting(True), $F000

  jsl rlGetDialogueBoxGraphicsPointer
  lda #(`$7FB0F5)<<8
  sta lR19+1
  lda #<>$7FB0F5
  sta lR19
  jsl rlAppendDecompList
  lda #$0400
  sta wR0
  lda #(`$7FB4F5)<<8
  sta lR18+1
  lda #<>$7FB4F5
  sta lR18
  lda #$0200
  sta wR1
  jsl rlDMAByPointer
  lda #(`aBGPal0)<<8
  sta lR18+1
  lda #<>aBGPal0
  sta lR18
  lda #(`aOAMPal7)<<8
  sta lR19+1
  lda #<>aOAMPal7
  sta lR19
  lda #size(aBGPal0)
  sta wR20
  jsl rlBlockCopy

  lda #$0000
  sta wBuf_BG1VOFS
  sta wBuf_BG1HOFS
  sta wBuf_BG2VOFS
  sta wBuf_BG2HOFS
  sta wBuf_BG3VOFS
  sta wBuf_BG3HOFS
  sep #$20
  lda #TM_Setting(True, False, False, False, False)
  sta bBuf_TM
  lda #INIDISP_Setting(False)
  sta bBuf_INIDISP
  rep #$20
  lda #$0007
  sta wUnknown000300,b
  lda #$0008
  sta wUnknown000302,b
  lda #<>rsUnknown80A488
  sta wUnknown0000D3
  lda #<>rsUnknown80A47B
  sta wUnknown0000D7
  jsl rlEnableVBlank
  plp
  plb
  cli
  rts

.union
  g4bppBlank80A43E .fill $20, $00
  g2bppBlank80A43E .fill $10, $00
.endu

rlUnknown80A45E ; 80/A45E

  .al
  .xl
  .autsiz
  .databank ?

  lda #(`rsUnknown80A23A)<<8
  sta wProcInput0+1,b
  lda #<>rsUnknown80A23A
  sta wProcInput0,b
  phx
  lda #(`procUnknown82A1BB)<<8
  sta lR43+1
  lda #<>procUnknown82A1BB
  sta lR43
  jsl rlProcEngineCreateProc
  plx
  rtl

rsUnknown80A47B ; 80/A47B

  .al
  .xl
  .autsiz
  .databank ?

  jsl rlButtonCombinationResetCheck
  jsl rlDecompressByList
  jsl rlUnknown8096B3
  rts

rsUnknown80A488 ; 80/A488

  .al
  .xl
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
  jsl rlGetJoypadInput
  jsl rlUnknown80B0D1
  jsl rlClearSpriteAttributeBuffer
  jsl rlUnknown80A50F
  jsl rlUnknown80A5DF
  jsl rlDialogueBGDrawDialogueBoxTails
  jsl rlHideSprites
  jsl rlUnknown80932C
  jsl rlButtonCombinationResetCheck
  rts

rsUnknown80A4D0 ; 80/A4D0

  .al
  .xl
  .autsiz
  .databank ?

  jsl rlUnknown82A88C
  rts

rlUnknown80A4D5 ; 80/A4D5

  .al
  .xl
  .autsiz
  .databank ?

  rtl

aUnknown80A4D6 ; 80/A4D6
  .long rlUnknown80A4D5
  .long $838000
  .long $838001
  .long $838008
  .long $859813
  .long $859814
  .long $85981B
  .long rlUnknown8CD50E
  .long rlUnknown8CD50F
  .long rlUnknown8CD516
  .long $9BE4D7
  .long $9BE4C5
  .long $9BE4D8
  .long $83FAF1
  .long $83FAF2
  .long $83FAF9
  .long $90B74D
  .long $90B6F3
  .long $90B720

rlUnknown80A50F ; 80/A50F

  .al
  .xl
  .autsiz
  .databank ?

  phb
  lda wUnknown000302,b
  asl a
  adc wUnknown000302,b
  jsr rsUnknown80A526

  lda wUnknown000300,b
  asl a
  adc wUnknown000300,b
  jsr rsUnknown80A526
  plb
  rtl

rsUnknown80A526 ; 80/A526

  .al
  .xl
  .autsiz
  .databank ?

  tax
  sep #$20
  lda aUnknown80A4D6+2,x
  cmp #$7D
  beq +

  sta lR18+2
  pha
  plb
  rep #$20
  lda aUnknown80A4D6,x
  sta lR18
  jsl _Goto

  -
  rep #$30
  rts

  +
  rep #$20
  lda aUnknown80A4D6,x
  sta wUnknown000302,b
  jmp -

  _Goto
  jmp [lR18]

rlUnknown80A553 ; 80/A553

  .al
  .xl
  .autsiz
  .databank ?

  php
  phb
  phk
  plb

  .databank `*

  sep #$20
  ldx #size(aUnknown000309) - 1
  lda #$00

  -
  sta aUnknown000309,b,x
  dec x
  bpl -

  rep #$20
  plb
  plp
  rtl

rlUnknown80A569 ; 80/A569

  .al
  .xl
  .autsiz
  .databank ?

  phb
  phk
  plb

  .databank `*

  phx
  phy
  ldx #size(aUnknown000309) - 3

  -
  lda aUnknown000309,b,x
  beq +

  dec x
  dec x
  dec x
  bpl -

  ply
  plx
  plb
  sec
  rtl

  +
  ldy #$0000
  lda lR43+1
  sta aUnknown000309+1,b,x
  sta lUnknown000306+1,b
  lda [lR43],y
  sta lUnknown000306,b
  inc y
  inc y
  lda [lR43],y
  sta aUnknown000309,b,x
  jsl _Goto

  ply
  plx
  plb
  clc
  rtl

  _Goto
  jmp [lUnknown000306]

rlUnknown80A5A3 ; 80/A5A3

  .al
  .xl
  .autsiz
  .databank ?

  phb
  phk
  plb

  .databank `*

  ldy #$0002
  lda lR43+1
  sta lUnknown000306+1,b
  lda [lR43],y
  sta lUnknown000306,b
  ldx #size(aUnknown000309) - 3

  -
  lda aUnknown000309+1,b,x
  cmp lUnknown000306+1,b
  bne +

  lda aUnknown000309,b,x
  cmp lUnknown000306,b
  beq ++

  +
  dec x
  dec x
  dec x
  bpl -

  plb
  sec
  rtl

  +
  ldy #$0004
  lda [lR43],y
  sta lUnknown000306,b
  jsl _Goto
  clc
  rtl

  _Goto
  jmp [lUnknown000306]

rlUnknown80A5DF ; 80/A5DF

  .al
  .xl
  .autsiz
  .databank ?

  php
  phb
  phk
  plb

  .databank `*

  ldx #size(aUnknown000309) - 3

  -
  phx
  lda aUnknown000309,b,x
  beq +

  sta lUnknown000306,b
  lda aUnknown000309+1,b,x
  sta lUnknown000306+1,b
  jsl _Goto

  +
  plx
  dec x
  dec x
  dec x
  bpl -

  plb
  plp
  rtl

  _Goto
  jmp [lUnknown000306]

rsUnknown80A605 ; 80/A605

  .al
  .xl
  .autsiz
  .databank ?

  sep #$20
  lda #INIDISP_Setting(True)
  sta INIDISP,b
  rep #$20
  jsl rlProcessDMAStructArray
  jsl rlDMAPaletteAndOAMBuffer
  jsl rlCopyPPURegBuffer
  jsl rlUnknown808D9C
  jsl rlGetJoypadInput
  jsl rlUnknown80B0D1
  jsl rlClearSpriteAttributeBuffer
  jsl rlUnknown80A50F
  jsl rlUnknown80A5DF
  jsl rlHideSprites
  jsl rlUnknown80932C
  rts

rsUnknown80A63B ; 80/A63B

  .al
  .xl
  .autsiz
  .databank ?

  sep #$30
  stz NMITIMEN,b
  stz bBuf_NMITIMEN

  lda #INIDISP_Setting(True)
  sta INIDISP,b
  sta bBuf_INIDISP

  stz wNextFreeSpriteOffs,b
  stz wUnknown1E22,b
  jsl rlClearSpriteAttributeBuffer
  jsl rlHideSprites
  rep #$30
  jsl rlClearDecompList
  jsl rlClearSRAMHeaderIfNoFiles
  jsr rsPrepareBlockCopyRAM
  jsl rlUnknown80A553

  lda #(`aUnknown8CD529)<<8
  sta lR43+1
  lda #<>aUnknown8CD529
  sta lR43
  jsl rlUnknown80A569

  lda #(`aProcEngineMainProcActionTable)<<8
  sta lR43+1
  lda #<>aProcEngineMainProcActionTable
  sta lR43
  jsl rlUnknown80A569

  lda #(`aActiveSpriteEngineMainActionTable)<<8
  sta lR43+1
  lda #<>aActiveSpriteEngineMainActionTable
  sta lR43
  jsl rlUnknown80A569

  lda #(`aHDMAArrayEngineMainActionTable)<<8
  sta lR43+1
  lda #<>aHDMAArrayEngineMainActionTable
  sta lR43
  jsl rlUnknown80A569

  lda #(`aIRQArrayEngineMainActionTable)<<8
  sta lR43+1
  lda #<>aIRQArrayEngineMainActionTable
  sta lR43
  jsl rlUnknown80A569

  stz wUnknown000300,b
  stz wUnknown000302,b
  jmp rsUnknown80C460

rsUnknown80A6B7 ; 80/A6B7

  .al
  .xl
  .autsiz
  .databank ?

  jmp rsUnknown80C402

rsUnknown80A6BA ; 80/A6BA

  .al
  .xl
  .autsiz
  .databank ?

  jmp rsUnknown80BF58

rsUnknown80A6BD ; 80/A6BD

  .al
  .xl
  .autsiz
  .databank ?

  jsl rlButtonCombinationResetCheck
  jsl rlDecompressByList
  jsl rlUnknown8096B3
  rts

rlUnknown80A6CA ; 80/A6CA

  .al
  .xl
  .autsiz
  .databank ?

  phb
  php
  phk
  plb

  .databank `*

  sep #$30
  lda #NMITIMEN_Setting(True, False, False, False)
  sta NMITIMEN,b
  sta bBuf_NMITIMEN
  lda #WRIO_Setting(False, True)
  sta WRIO,b
  stz WRMPYA,b
  stz WRMPYB,b
  stz WRDIV,b
  stz WRDIV+1,b
  stz WRDIV+2,b
  stz HTIME,b
  stz bBuf_HTIMEL
  stz HTIME+1,b
  stz bBuf_HTIMEH
  stz VTIME,b
  stz bBuf_VTIMEL
  stz VTIME+1,b
  stz bBuf_VTIMEH
  stz MDMAEN,b
  stz HDMAEN,b
  stz bBuf_HDMAEN
  lda #MEMSEL_Setting(True)
  sta MEMSEL,b
  sta bBuf_MEMSEL
  plp
  plb
  rtl

rlUnknown80A711 ; 80/A711

  .al
  .xl
  .autsiz
  .databank ?

  phb
  php
  phk
  plb

  .databank `*

  sep #$30
  lda #INIDISP_Setting(True)
  sta INIDISP,b
  sta bBuf_INIDISP
  lda #OBSEL_Setting(ObjectSize8x8And16x16, $0000, $0000)
  sta OBSEL,b
  sta bBuf_OBSEL
  lda #OAMADDL_Setting($010)
  sta OAMADDL,b
  sta wBuf_OAMADD
  lda #OAMADDH_Setting(False, $010)
  sta OAMADDH,b
  sta wBuf_OAMADD+1
  stz OAMDATA,b
  stz OAMDATA,b
  lda #BGMODE_Setting(1, True)
  sta BGMODE,b
  sta bBuf_BGMODE
  stz MOSAIC,b
  stz bBuf_MOSAIC
  stz BG1SC,b
  stz bBuf_BG1SC
  stz BG2SC,b
  stz bBuf_BG2SC
  stz BG3SC,b
  stz bBuf_BG3SC
  stz BG4SC,b
  stz bBuf_BG4SC
  stz BG12NBA,b
  stz bBuf_BG12NBA
  stz BG34NBA,b
  stz bBuf_BG34NBA
  stz BG1HOFS,b
  stz wBuf_BG1HOFS
  stz BG1HOFS,b
  stz wBuf_BG1HOFS+1
  stz BG1VOFS,b
  stz wBuf_BG1VOFS
  stz BG1VOFS,b
  stz wBuf_BG1VOFS+1
  stz BG2HOFS,b
  stz wBuf_BG2HOFS
  stz BG2HOFS,b
  stz wBuf_BG2HOFS+1
  stz BG2VOFS,b
  stz wBuf_BG2VOFS
  stz BG2VOFS,b
  stz wBuf_BG2VOFS+1
  stz BG3HOFS,b
  stz wBuf_BG3HOFS
  stz BG3HOFS,b
  stz wBuf_BG3HOFS+1
  stz BG3VOFS,b
  stz wBuf_BG3VOFS
  stz BG3VOFS,b
  stz wBuf_BG3VOFS+1
  stz BG4HOFS,b
  stz wBuf_BG4HOFS
  stz BG4HOFS,b
  stz wBuf_BG4HOFS+1
  stz BG4VOFS,b
  stz wBuf_BG4VOFS
  stz BG4VOFS,b
  stz wBuf_BG4VOFS+1
  stz VMAIN,b
  stz M7SEL,b
  stz bBuf_M7SEL
  stz M7A,b
  stz M7B,b
  stz M7C,b
  stz M7D,b
  stz M7X,b
  stz M7Y,b
  lda #W12SEL_Setting(False, False, False, False, False, False, False, False)
  sta W12SEL,b
  sta bBuf_W12SEL
  lda #W34SEL_Setting(False, False, False, False, False, False, False, False)
  sta W34SEL,b
  sta bBuf_W34SEL
  stz WOBJSEL,b
  stz bBuf_WOBJSEL
  lda #0
  sta WH0,b
  sta bBuf_WH0
  lda #255
  sta WH1,b
  sta bBuf_WH1
  stz WH2,b
  stz bBuf_WH2
  stz WH3,b
  stz bBuf_WH3
  stz WBGLOG,b
  stz bBuf_WBGLOG
  stz WOBJLOG,b
  stz bBuf_WOBJLOG
  lda #TM_Setting(True, False, False, False, True)
  sta TM,b
  sta bBuf_TM
  sta TMW,b
  sta bBuf_TMW
  lda #TS_Setting(False, False, False, False, False)
  sta TS,b
  sta bBuf_TS
  sta TSW,b
  sta bBuf_TSW
  lda #CGWSEL_Setting(False, True, CGWSEL_MathAlways, CGWSEL_BlackNever)
  sta CGWSEL,b
  sta bBuf_CGWSEL
  lda #CGADSUB_Setting(CGADSUB_Subtract, False, True, False, False, False, False, True)
  sta CGADSUB,b
  sta bBuf_CGADSUB
  lda #COLDATA_Setting(0, True, False, False)
  sta COLDATA,b
  sta bBuf_COLDATA_1
  lda #COLDATA_Setting(0, False, True, False)
  sta COLDATA,b
  sta bBuf_COLDATA_2
  lda #COLDATA_Setting(0, False, False, True)
  sta COLDATA,b
  sta bBuf_COLDATA_3
  lda #$00
  sta SETINI,b
  sta bBuf_SETINI
  plp
  plb
  rtl

rlFillBG1Tilemap ; 80/A847

  .al
  .xl
  .autsiz
  .databank ?

  ; Fills the BG1 tilemap buffer
  ; with the word in A

  ; Inputs:
  ; A: Fill value

  ; Outputs:
  ; None

  phb
  php
  phk
  plb

  .databank `*

  phx
  ldx #size(aBG1TilemapBuffer) - 2

  -
  sta aBG1TilemapBuffer,x
  dec x
  dec x
  bpl -

  plx
  plp
  plb
  rtl

rlFillBG2Tilemap ; 80/A85B

  .al
  .xl
  .autsiz
  .databank ?

  ; Fills the BG2 tilemap buffer
  ; with the word in A

  ; Inputs:
  ; A: Fill value

  ; Outputs:
  ; None

  phb
  php
  phk
  plb

  .databank `*

  phx
  ldx #size(aBG2TilemapBuffer) - 2

  -
  sta aBG2TilemapBuffer,x
  dec x
  dec x
  bpl -

  plx
  plp
  plb
  rtl

rlFillBG3Tilemap ; 80/A86F

  ; Assembler info

  .al
  .xl
  .autsiz
  .databank ?

  ; Fills the BG3 tilemap buffer
  ; with the word in A

  ; Inputs:
  ; A: Fill value

  ; Outputs:
  ; None

  phb
  php
  phk
  plb

  .databank `*

  phx
  ldx #size(aBG3TilemapBuffer) - 2

  -
  sta aBG3TilemapBuffer,x
  dec x
  dec x
  bpl -

  plx
  plp
  plb
  rtl

rlUnknown80A883 ; 80/A883

  .al
  .xl
  .autsiz
  .databank ?

  phb
  php
  phk
  plb

  .databank `*

  sep #$20
  lda bBuf_INIDISP
  bmi +

  jmp _End

  +
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
  and #$E0
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
  sta BG1SC,b
  sta bBuf_BG1SC

  lda bBuf_BG2SC
  and #BG2SC.Size
  ora wR7
  sta BG2SC,b
  sta bBuf_BG2SC

  lda bBuf_BG3SC
  and #BG3SC.Size
  ora wR8
  sta BG3SC,b
  sta bBuf_BG3SC

  lda bBuf_BG4SC
  and #BG4SC.Size
  ora wR9
  sta BG4SC,b
  sta bBuf_BG4SC

  lda bBuf_OBSEL
  and #~OBSEL.Base
  ora wR5
  sta OBSEL,b
  sta bBuf_OBSEL

  lda wR1
  sta BG12NBA,b
  sta bBuf_BG12NBA

  lda wR3
  sta BG34NBA,b
  sta bBuf_BG34NBA

  _End
  plp
  plb
  rtl
