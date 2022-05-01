
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_PPU_BUFFERS :?= false
.if (!GUARD_FE5_PPU_BUFFERS)
  GUARD_FE5_PPU_BUFFERS := true

  ; Freespace inclusions

    .section DMAPaletteAndOAMBufferSection

      startCode

        rlDMAPaletteAndOAMBuffer ; 80/807C

          .autsiz
          .databank ?

          ; Copies the palette and OAM buffers
          ; to CGRAM and OAM respectively every
          ; frame.

          ; You shouldn't call this yourself.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php

          sep #$10
          rep #$20

          ; Mode, destination

          lda #pack([DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Increment, DMAP_Mode0), narrow(OAMDATA - PPU_REG_BASE, 1)])
          sta DMA_IO[0].DMAP,b

          ; Source

          lda #<>aSpriteBuffer
          sta DMA_IO[0].A1,b

          ldx #`aSpriteBuffer
          stx DMA_IO[0].A1+2,b

          ; Size

          lda #size(aSpriteBuffer)+size(aSpriteExtBuffer)
          sta DMA_IO[0].DAS,b

          ; Reset position of writes/reads

          stz OAMADD,b

          ; Mode, destination

          lda #pack([DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Increment, DMAP_Mode0), narrow(CGDATA - PPU_REG_BASE, 1)])
          sta DMA_IO[1].DMAP,b

          ; Source

          lda #<>aBGPaletteBuffer
          sta DMA_IO[1].A1,b

          ldx #`aBGPaletteBuffer
          stx DMA_IO[1].A1+2,b

          ; Size

          lda #size(aBGPaletteBuffer)+size(aOAMPaletteBuffer)
          sta DMA_IO[1].DAS,b

          ; Reset position of writes/reads

          ldx #0
          stx CGADD,b

          ; Start DMA

          ldx #MDMAEN_Setting([0, 1])
          stx MDMAEN,b

          ; Restore OAM position

          lda wBufferOAMADD
          sta OAMADD,b

          plp

          rtl

          .databank 0

      endCode

    .endsection DMAPaletteAndOAMBufferSection

    .section CopyPPURegisterBufferSection

      startCode

        rlCopyPPURegisterBuffer ; 80/80C3

          .autsiz
          .databank ?

          ; Copies buffers for PPU registers
          ; to their actual registers.

          ; You shouldn't call this yourself.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php
          phb

          phk
          plb

          .databank `*

          sep #$20

          lda bBufferINIDISP
          sta INIDISP,b

          lda bBufferOBSEL
          sta OBSEL,b

          lda bBufferBGMODE
          sta BGMODE,b

          lda bBufferMOSAIC
          sta MOSAIC,b

          lda bBufferBG1SC
          sta BG1SC,b

          lda bBufferBG2SC
          sta BG2SC,b

          lda bBufferBG3SC
          sta BG3SC,b

          lda bBufferBG4SC
          sta BG4SC,b

          lda bBufferBG12NBA
          sta BG12NBA,b

          lda bBufferBG34NBA
          sta BG34NBA,b

          lda bBufferW12SEL
          sta W12SEL,b

          lda bBufferW34SEL
          sta W34SEL,b

          lda bBufferWOBJSEL
          sta WOBJSEL,b

          lda bBufferWH0
          sta WH0,b

          lda bBufferWH1
          sta WH1,b

          lda bBufferWH2
          sta WH2,b

          lda bBufferWH3
          sta WH3,b

          lda bBufferWBGLOG
          sta WBGLOG,b

          lda bBufferWOBJLOG
          sta WOBJLOG,b

          lda bBufferTM
          sta TM,b

          lda bBufferTMW
          sta TMW,b

          lda bBufferTS
          sta TS,b

          lda bBufferTSW
          sta TSW,b

          lda bBufferCGWSEL
          sta CGWSEL,b

          lda bBufferCGADSUB
          sta CGADSUB,b

          lda bBufferCOLDATA_1
          sta COLDATA,b

          lda bBufferCOLDATA_2
          sta COLDATA,b

          lda bBufferCOLDATA_3
          sta COLDATA,b

          lda bBufferSETINI
          sta SETINI,b

          lda wBufferBG1HOFS
          sta BG1HOFS,b
          lda wBufferBG1HOFS+size(byte)
          sta BG1HOFS,b

          lda wBufferBG1VOFS
          sec
          sbc #1
          sta BG1VOFS,b
          lda wBufferBG1VOFS+size(byte)
          sbc #0
          sta BG1VOFS,b

          lda wBufferBG2HOFS
          sta BG2HOFS,b
          lda wBufferBG2HOFS+size(byte)
          sta BG2HOFS,b

          lda wBufferBG2VOFS
          sec
          sbc #1
          sta BG2VOFS,b
          lda wBufferBG2VOFS+size(byte)
          sbc #0
          sta BG2VOFS,b

          lda wBufferBG3HOFS
          sta BG3HOFS,b
          lda wBufferBG3HOFS+size(byte)
          sta BG3HOFS,b

          lda wBufferBG3VOFS
          sec
          sbc #1
          sta BG3VOFS,b
          lda wBufferBG3VOFS+size(byte)
          sbc #0
          sta BG3VOFS,b

          plb
          plp

          rtl

          .databank 0

      endCode

    .endsection CopyPPURegisterBufferSection

    .section CopyINIDISPBufferSection

      startCode

        rlCopyINIDISPBuffer ; 80/81A8

          .autsiz
          .databank ?

          ; Copies INIDISP from buffer to register

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php
          phb

          phk
          plb

          .databank `*

          sep #$20

          lda bBufferINIDISP
          sta INIDISP,b

          plb
          plp

          rtl

          .databank 0

      endCode

    .endsection CopyINIDISPBufferSection

.endif ; GUARD_FE5_PPU_BUFFERS
