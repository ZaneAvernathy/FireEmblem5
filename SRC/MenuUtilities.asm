
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_MENU_UTILITIES :?= false
.if (!GUARD_FE5_MENU_UTILITIES)
  GUARD_FE5_MENU_UTILITIES := true

  ; Definitions

    .weak

      riBRK                       :?= address($808000)
      rlUnsignedMultiply16By16    :?= address($80AA27)
      rlFillTilemapByWord         :?= address($80E89F)
      rlEnableBG1Sync             :?= address($81B1FA)
      rlEnableBG3Sync             :?= address($81B212)
      rlCopyWindowToTilemap       :?= address($87D4DD)
      rlFillWindowFromTilemapInfo :?= address($87D69D)
      rlDrawPopupMenuBorders      :?= address($87D920)

      TextWhite :?= 0
      TextBrown :?= 1

    .endweak

  ; Freespace inclusions

    .section MenuUtilitiesSection

      ; TODO: VRAM position definitions?

      aPopupMenuBorders .block ; 85/8000
        _BaseTile := VRAMToTile($B800, $A000, size(Tile2bpp))

        _Corner     := C2I((14,  4))
        _Vertical   := C2I((15,  4))
        _Horizontal := C2I((14,  5))
        _Diagonal   := C2I((15, 15))
        _Blank      := C2I((15,  5))

        _BShadow    := C2I(( 9, 16))
        _TRShadow   := C2I((15, 21))
        _RShadow    := C2I((15, 22))
        _BLShadow   := C2I(( 7, 21))
        _BRShadow   := C2I((15, 23))

        _TME .sfunction Tile, XFlip, YFlip, TilemapEntry(aPopupMenuBorders._BaseTile+Tile, TextBrown, true, XFlip, YFlip)

        TopLeft     .word _TME(_Corner,     true,  true)
        Top         .word _TME(_Horizontal, false, false)
        TopRight    .word _TME(_Diagonal,   false, true)
        Unknown1    .word TilemapEntry(_Blank, TextWhite, false, false, false)
        Left        .word _TME(_Vertical,   false, false)
        Right       .word _TME(_Vertical,   true,  false)
        RShadow     .word _TME(_RShadow,    false, false)
        BottomLeft  .word _TME(_Diagonal,   true,  false)
        Bottom      .word _TME(_Horizontal, false, true)
        BottomRight .word _TME(_Corner,     false, false)
        Unknown2    .word _TME(_BRShadow,   true,  false)
        BShadow     .word _TME(_BShadow,    false, false)
        BRShadow    .word _TME(_BRShadow,   false, false)
      .endblock

      aStandardMenuBorders .block ; 85/801A
        _BaseTile := VRAMToTile($B800, $A000, size(Tile2bpp))

        _Horizontal := C2I((0, 24))
        _Corner     := C2I((1, 24))
        _Vertical   := C2I((2, 24))

        _TME .sfunction Tile, XFlip, YFlip, TilemapEntry(aStandardMenuBorders._BaseTile+Tile, TextBrown, true, XFlip, YFlip)

        TopLeft     .word _TME(_Corner,     true,  true)
        Top         .word _TME(_Horizontal, false, true)
        TopRight    .word _TME(_Corner,     false, true)
        Left        .word _TME(_Vertical,   true,  false)
        Right       .word _TME(_Vertical,   false, false)
        BottomLeft  .word _TME(_Corner,     true,  false)
        Bottom      .word _TME(_Horizontal, false, false)
        BottomRight .word _TME(_Corner,     false, false)

      .endblock

      aMenuTempTilemapBuffers .long aMenuTilemapBuffers.aBuffers ; 85/802A

      rlMenuClearActiveMenus ; 85/8033

        .autsiz
        .databank ?

        php
        phb

        sep #$20

        lda #`aActiveMenuSlots
        pha

        rep #$20

        plb

        .databank `aActiveMenuSlots

        phx
        phy

        ldx #3 * size(addr)

        -
        stz aActiveMenuSlots,x

        .rept size(addr)
          dec x
        .endrept

        bpl -

        ldx #3 * size(structActiveMenu)

        -
        stz aActiveMenuData,x

        txa
        sec
        sbc #size(structActiveMenu)
        tax

        bpl -

        ply
        plx
        plb
        plp
        rtl

        .databank 0

      rlMenuCreateActiveMenu ; 85/805C

        .autsiz
        .databank ?

        php
        phb

        sep #$20

        lda #`wActiveMenuCurrentSlot
        pha

        rep #$20

        plb

        .databank `wActiveMenuCurrentSlot

        phx

        jsr rsMenuInitializeActiveMenuStruct
        jsr rsMenuGetFreeActiveMenuSlot
        bcs +

          jsr rsMenuSetActiveMenuTilemapBufferPointers
          jsr rsMenuDrawActiveMenu
          jsl rlMenuCopyActiveMenuCopyTempToCurrentSlot

          lda wActiveMenuCurrentSlot

        +
        plx

        plb
        plp
        rtl

        .databank 0

      rsMenuGetFreeActiveMenuSlot ; 85/8080

        .al
        .xl
        .autsiz
        .databank `aActiveMenuData

        ldx #0
        ldy #0

        -
          lda aActiveMenuData+structActiveMenu.EnabledFlag,x
          and #$00FF
          beq +

            inc y
            txa
            clc
            adc #size(structActiveMenu)
            tax
            cpx #size(aActiveMenuData)
            bne -

              sec
              rts

        +
        txa
        clc
        adc #<>aActiveMenuData
        sta wActiveMenuCurrentSlot
        clc
        rts

        .databank ?

      rsMenuInitializeActiveMenuStruct ; 85/80A6

        .al
        .xl
        .autsiz
        .databank `aActiveMenuData

        sep #$20

        lda #-1
        sta aActiveMenuTemp.EnabledFlag

        lda wR0
        sta aActiveMenuTemp.Position.X

        lda wR1
        sta aActiveMenuTemp.Position.Y

        stz aActiveMenuTemp.ShadingDisabledFlag

        lda wR2
        bit #$80
        beq +

          lda #$80
          sta aActiveMenuTemp.ShadingDisabledFlag
          lda wR2
          and #~$80

        +
        sta aActiveMenuTemp.BG1Info.Size.W
        inc a
        sta aActiveMenuTemp.BG3Info.Size.W

        lda wR3
        sta aActiveMenuTemp.BG1Info.Size.H
        inc a
        sta aActiveMenuTemp.BG3Info.Size.H

        lda #$00
        sta aActiveMenuTemp.BG1Info.Destination.Hi+size(byte)
        sta aActiveMenuTemp.BG3Info.Destination.Hi+size(byte)

        lda #`aBG1TilemapBuffer
        sta aActiveMenuTemp.BG1Info.Destination.Hi
        sta aActiveMenuTemp.BG3Info.Destination.Hi

        ldx #<>aBG1TilemapBuffer
        stx aActiveMenuTemp.BG1Info.Destination
        ldx #<>aBG3TilemapBuffer
        stx aActiveMenuTemp.BG3Info.Destination

        rep #$30

        rts

        .databank 0

      rsMenuSetActiveMenuTilemapBufferPointers ; 85/80F8

        .al
        .xl
        .autsiz
        .databank `aActiveMenuData

        tya
        sta wR0

        asl a
        clc
        adc wR0

        tax
        lda aMenuTempTilemapBuffers,x
        sta lActiveMenuTempBufferPointer
        lda aMenuTempTilemapBuffers+size(byte),x
        sta lActiveMenuTempBufferPointer+size(byte)

        lda lActiveMenuTempBufferPointer
        sta aActiveMenuTemp.BG1Info.Source
        lda lActiveMenuTempBufferPointer+size(byte)
        sta aActiveMenuTemp.BG1Info.Source+size(byte)

        lda aActiveMenuTemp.BG1Info.Size.W
        and #$00FF
        sta wR10

        lda aActiveMenuTemp.BG1Info.Size.H
        and #$00FF
        asl a
        sta wR11

        jsl rlUnsignedMultiply16By16

        lda lActiveMenuTempBufferPointer
        clc
        adc wR12
        sta lActiveMenuTempBufferPointer

        lda lActiveMenuTempBufferPointer
        sta aActiveMenuTemp.BG3Info.Source
        lda lActiveMenuTempBufferPointer+size(byte)
        sta aActiveMenuTemp.BG3Info.Source+size(byte)

        rts

        .databank 0

      rsMenuDrawActiveMenu ; 85/8145

        .al
        .xl
        .autsiz
        .databank `aActiveMenuData

        lda #(`aActiveMenuTemp.BG1Info)<<8
        sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
        lda #<>aActiveMenuTemp.BG1Info
        sta aCurrentTilemapInfo.lInfoPointer,b

        lda lWindowBackgroundPatternPointer
        sta lR18
        lda lWindowBackgroundPatternPointer+size(byte)
        sta lR18+size(byte)

        _BaseTile := VRAMToTile($4000, $4000, size(Tile4bpp))

        lda #TilemapEntry(_BaseTile, 2, true, false, false)
        sta aCurrentTilemapInfo.wBaseTile,b

        jsl $85866E

        lda #(`aActiveMenuTemp.BG3Info)<<8
        sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
        lda #<>aActiveMenuTemp.BG3Info
        sta aCurrentTilemapInfo.lInfoPointer,b

        _BaseTile := VRAMToTile($B800, $A000, size(Tile2bpp))

        lda #TilemapEntry(_BaseTile + C2I((15, 5)), TextWhite, false, false, false)
        sta aCurrentTilemapInfo.wFillTile,b
        jsl rlFillWindowFromTilemapInfo

        lda #(`aActiveMenuTemp.BG3Info)<<8
        sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
        lda #<>aActiveMenuTemp.BG3Info
        sta aCurrentTilemapInfo.lInfoPointer,b

        lda #<>aPopupMenuBorders
        sta lR18
        lda #>`aPopupMenuBorders
        sta lR18+size(byte)

        lda #TilemapEntry(0, TextWhite, false, false, false)
        sta aCurrentTilemapInfo.wBaseTile,b

        jsl rlDrawPopupMenuBorders

        rts

        .databank ?

      rsMenuGetMenuBufferPosition ; 85/819C

        .al
        .xl
        .autsiz
        .databank `aActiveMenuData

        lda aActiveMenuTemp.Position.Y
        and #$00FF

        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR0

        lda aActiveMenuTemp.Position.X
        and #$00FF
        clc
        adc wR0

        asl a
        tax

        rts

        .databank 0

      rlMenuCopyActiveMenuCopyCurrentSlotToTemp ; 85/81B5

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb

        pha

        sep #$20

        lda #`aActiveMenuData
        pha

        rep #$20

        plb

        .databank `aActiveMenuData

        pla

        phx
        tax
        sta wActiveMenuCurrentSlot

        .for _i := 0, _i < size(structActiveMenu) - size(word), _i += size(word)

          lda _i,b,x
          sta aActiveMenuTemp+_i

        .endfor

        _i := size(structActiveMenu) - size(word)

        lda _i,b,x
        sta aActiveMenuTemp+_i

        plx
        plb
        plp
        rtl

        .databank 0

      rlMenuCopyActiveMenuCopyTempToCurrentSlot ; 85/8218

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb

        pha

        sep #$20

        lda #`aActiveMenuData
        pha

        rep #$20

        plb

        .databank `aActiveMenuData

        pla

        phx
        ldx wActiveMenuCurrentSlot

        .for _i := 0, _i < size(structActiveMenu) - size(word), _i += size(word)

          lda aActiveMenuTemp+_i
          sta _i,b,x

        .endfor

        _i := size(structActiveMenu) - size(word)

        lda aActiveMenuTemp+_i
        sta _i,b,x

        plx
        plb
        plp
        rtl

        .databank 0

      rlMenuSetActiveMenu ; 85/827A

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb

        pha

        sep #$20

        lda #`aActiveMenuSlots
        pha

        rep #$20

        plb

        .databank `aActiveMenuSlots

        pla

        phx

        ldx wR0
        phx

        sta wR0

        ldx #0

        -
        lda aActiveMenuSlots,x
        beq +

          .rept size(addr)
            inc x
          .endrept

          cpx #4 * size(addr)
          bne -

            jsl <>riBRK

        +
        lda wR0
        sta aActiveMenuSlots,x

        pla
        sta wR0

        plx
        plb
        plp
        rtl

        .databank 0

      rlMenuClearActiveMenuSlot ; 85/82AB

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb

        pha

        sep #$20

        lda #`aActiveMenuSlots
        pha

        rep #$20

        plb

        .databank `aActiveMenuSlots

        pla

        phx

        ldx wR0
        phx

        sta wR0

        ldx #0

        -
          cmp aActiveMenuSlots,x
          beq _ClearLoop

            .rept size(addr)
              inc x
            .endrept

            cpx #4 * size(addr)
            bne -

              bra _End

        _ClearLoop
          lda aActiveMenuSlots+size(addr),x
          sta aActiveMenuSlots,x

          .rept size(addr)
            inc x
          .endrept

          cpx #3 * size(addr)
          bne _ClearLoop

            stz aActiveMenuSlots,x

        _End
        plx
        stx wR0

        plx

        plb
        plp
        rtl

        .databank 0

      rlMenuClearActiveMenu ; 85/82E5

        .al
        .xl
        .autsiz
        .databank ?

        phx

        pha

        jsl rlMenuClearActiveMenuSlot

        plx

        lda #0
        sta aActiveMenuData & $FF0000,x

        plx
        rtl

        .databank 0

      rlMenuUnknown8582F5 ; 85/82F5

        .autsiz
        .databank ?

        php
        rep #$30

        phb

        pha
        pha

        sep #$20

        lda #`aActiveMenuData
        pha

        rep #$20

        plb

        .databank `aActiveMenuData

        pla
        jsl rlMenuClearActiveMenuSlot

        pla
        jsl rlMenuSetActiveMenu

        plb
        plp
        rtl

        .databank 0

      rlMenuDrawAllMenusFromBuffers ; 85/8310

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb

        sep #$20

        lda #`aActiveMenuData
        pha

        plb

        .databank `aActiveMenuData

        lda #`aActiveMenuData
        sta aCurrentTilemapInfo.lInfoPointer+size(word),b

        rep #$30

        phx
        phy

        lda #<>aBG1TilemapBuffer
        sta wR0

        _BaseTile := VRAMToTile($4000, $4000, size(Tile4bpp))

        lda #TilemapEntry(_BaseTile + C2I((15, 47)), 0, false, false, false)
        jsl rlFillTilemapByWord

        lda #<>aBG3TilemapBuffer
        sta wR0

        _BaseTile := VRAMToTile($B800, $A000, size(Tile2bpp))

        lda #TilemapEntry(_BaseTile + C2I((15, 5)), TextWhite, false, false, false)
        jsl rlFillTilemapByWord

        jsl $859132

        ldy #0

        -
        lda aActiveMenuSlots,y
        beq ++

        tax
        clc
        adc #structActiveMenu.BG1Info
        sta aCurrentTilemapInfo.lInfoPointer,b

        lda structActiveMenu.BG1Info,b,x
        pha

        lda structActiveMenu.Position,b,x
        pha

        jsl $8586B8

        phx
        tax
        jsl rlCopyWindowToTilemap

        plx

        pla
        sta wR0

        pla
        sta wR1

        lda structActiveMenu.ShadingDisabledFlag,b,x
        and #$00FF
        bne +

          jsr $859273

        +
        lda aActiveMenuSlots,y
        tax
        clc
        adc #structActiveMenu.BG3Info
        sta aCurrentTilemapInfo.lInfoPointer,b

        lda structActiveMenu.Position,b,x
        jsl $8586B8

        phx
        tax
        jsl rlCopyWindowToTilemap

        plx
        inc y
        inc y
        cpy #4 * size(addr)
        bne -

        +
        jsr $859166
        jsl $8593A6
        jsl rlEnableBG1Sync
        jsl rlEnableBG3Sync

        ply
        plx
        plb
        plp
        rtl

        .databank 0

      rlMenuDrawSingleMenuFromBuffer ; 85/83A5

        .al
        .xl
        .autsiz
        .databank `aActiveMenuTemp

        jsl rlMenuCopyActiveMenuCopyCurrentSlotToTemp

        lda #<>aActiveMenuTemp.BG1Info
        sta aCurrentTilemapInfo.lInfoPointer,b
        lda #>`aActiveMenuTemp.BG1Info
        sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

        lda aActiveMenuTemp.Position
        jsl $8586B8

        tax

        phx

        jsl rlCopyWindowToTilemap

        lda #<>aActiveMenuTemp.BG3Info
        sta aCurrentTilemapInfo.lInfoPointer,b
        lda #>`aActiveMenuTemp.BG3Info
        sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

        plx

        jsl rlCopyWindowToTilemap
        jsl rlEnableBG1Sync
        jsl rlEnableBG3Sync

        rtl

        .databank 0

      rsMenuUnknown8583DC ; 85/83DC

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

.comment


85/83DD:  ADFF4E    lda $4EFF
85/83E0:  38        sec
85/83E1:  EDFD4E    sbc $4EFD
85/83E4:  304D      bmi $8433

85/83E6:  A9007E    lda #$7E00
85/83E9:  8530      sta $30

85/83EB:  ADFD4E    lda $4EFD
85/83EE:  0A        asl a
85/83EF:  0A        asl a
85/83F0:  0A        asl a
85/83F1:  0A        asl a
85/83F2:  0A        asl a

85/83F3:  48        pha
85/83F4:  48        pha

85/83F5:  0A        asl a
85/83F6:  18        clc
85/83F7:  697CE7    adc #$E77C
85/83FA:  852F      sta $2F

85/83FC:  68        pla
85/83FD:  18        clc
85/83FE:  690050    adc #$5000
85/8401:  850D      sta $0D

85/8403:  ADFF4E    lda $4EFF
85/8406:  38        sec
85/8407:  EDFD4E    sbc $4EFD

85/840A:  1A        inc a
85/840B:  0A        asl a
85/840C:  0A        asl a
85/840D:  0A        asl a
85/840E:  0A        asl a
85/840F:  0A        asl a
85/8410:  0A        asl a

85/8411:  48        pha

85/8412:  850B      sta $0B
85/8414:  22F9AE80  jsl $80AEF9

85/8418:  68        pla
85/8419:  18        clc
85/841A:  694000    adc #$0040
85/841D:  850B      sta $0B

85/841F:  A301      lda $01,s
85/8421:  18        clc
85/8422:  690070    adc #$7000
85/8425:  850D      sta $0D

85/8427:  68        pla
85/8428:  0A        asl a
85/8429:  18        clc
85/842A:  697CC7    adc #$C77C
85/842D:  852F      sta $2F

85/842F:  22F9AE80  jsl $80AEF9

85/8433:  60        rts


.endcomment

    .endsection MenuUtilitiesSection

.endif ; GUARD_FE5_MENU_UTILITIES
