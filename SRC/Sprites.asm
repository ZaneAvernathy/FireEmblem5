
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_SPRITES :?= false
.if (!GUARD_FE5_SPRITES)
  GUARD_FE5_SPRITES := true

  ; Freespace inclusions

    .section HideSpritesSection

      rlHideAllSprites ; 80/8325

        .autsiz
        .databank ?

        ; Hides all sprites by moving
        ; all sprites in the sprite buffer
        ; offscreen.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        stz wNextFreeSpriteOffset,b

        .databank 0

      rlHideSprites ; 80/8328

        .autsiz
        .databank ?

        ; Hides unused sprites by
        ; moving them offscreen.

        phd

        sep #$30

        ; Use the upper bits of
        ; wNextFreeSpriteOffset to
        ; see if we have many sprites
        ; to clear.

        lda wNextFreeSpriteOffset+1,b
        and #$03
        asl a

        tax
        jsr (_Table,x)

        rep #$30

        stz wNextFreeSpriteOffset,b

        pld
        rtl

        _Table
          .addr _Under64Sprites
          .addr _Over64Sprites
          .addr _HideNoSprites
          .addr _HideNoSprites

        _Under64Sprites ; 80/8344

          .xs
          .autsiz
          .databank ?

          rep #$20

          ldx #240 ; Y coordinate, offscreen

          phd

          ; Clear all of the upper 64 sprites

          lda #<>aSpriteBuffer+(size(structPPUOAMEntry)*64)
          tcd

          jsr _Clearer

          pld

          ; Count number of lower 64 sprites to clear.

          ; We do this by jumping partially
          ; through the clearing routine.

          lda wNextFreeSpriteOffset,b
          lsr a
          clc
          adc #<>_Clearer
          sta wR0

          lda #<>aSpriteBuffer
          tcd

          jmp (wR0)

        _Over64Sprites ; 80/8362

          .xs
          .autsiz

          rep #$20

          ldx #240

          lda wNextFreeSpriteOffset,b
          and #$00FF
          lsr a
          clc
          adc #<>_Clearer
          sta wR0

          lda #<>aSpriteBuffer+(size(structPPUOAMEntry)*64)
          tcd

          jmp (wR0)

        _Clearer ; 80/837A

          .xs
          .autsiz

          .for i in range(0, 64*size(structPPUOAMEntry), size(structPPUOAMEntry))

            stx i+1

          .endfor

        _HideNoSprites ; 80/83FA

          .xs
          .autsiz

          rts

        .databank 0

    .endsection HideSpritesSection

    .section ClearSpriteExtBufferSection

      rlClearSpriteExtBuffer ; 80/83FB

        .autsiz
        .databank ?

        ; Clears the buffer for the
        ; upper X bit and sprite size bit.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        .for i in range(0, size(aSpriteExtBuffer), size(word))

          stz aSpriteExtBuffer+i,b

        .endfor

        rtl

        .databank 0

    .endsection ClearSpriteExtBufferSection

    .section OAMExtBitTableSection

      aOAMExtBitTable ; 80/8481

        ; For all words in the buffer

        .for i in range(size(aSpriteExtBuffer) / size(word))

          ; For all bits in the word

          .for n in range(0, (size(word) * 8), 2)

            ; First word is the bit for
            ; the upper X coordinate,
            ; the second word is the bit
            ; for the size.

            .word (1 << (n))
            .word (1 << (n + 1))

          .endfor

        .endfor

    .endsection OAMExtBitTableSection

    .section OAMExtPointerAndExtBitsTableSection

      aOAMExtPointerAndExtBitsTable ; 80/8681

        ; For each word in the buffer

        .for i in range(0, size(aSpriteExtBuffer), size(word))

          ; For all bits in the word

          .for n in range(0, (size(word) * 8), 2)

            ; First word is a short pointer to the
            ; word in the buffer that contains a
            ; sprite's extra bits. The second word
            ; contains both the upper X bit and the
            ; size bit.

            .word <>aSpriteExtBuffer+i
            .word (%11 << n)

          .endfor

        .endfor

    .endsection OAMExtPointerAndExtBitsTableSection

    .section PushToOAMBufferSection

      rlPushToOAMBuffer ; 80/8881

        .al
        .autsiz
        .databank ?

        ; Sets a sprite to be rendered.

        ; Inputs:
        ; Y: Pointer to sprite array
        ; DB: Bank of sprite array
        ; wR0: X Coordinate base in pixels
        ; wR1: Y Coordinate base in pixels
        ; wR4: Sprite base
        ; wR5: Attribute base

        ; Outputs:
        ; None

        ; Immediately return if no sprites
        ; to push.

        lda structSpriteArray.SpriteCount,b,y
        bne +

          rtl

        +
        sta wR2

        inc y
        inc y

        _Main

        phx

        ldx wNextFreeSpriteOffset,b
        clc

        _SpriteLoop

          ; Grab the X coordinate, unknown field,
          ; and size, with size being the uppermost
          ; bit.

          lda structSpriteEntry.X,b,y
          bpl _SmallSprite

            ; Large sprite, add to X base
            ; and set the upper bit if the
            ; result needs it.

            adc wR0
            sta aSpriteBuffer+structPPUOAMEntry.X,b,x

            bit #$0100
            bne _LargeSpriteXNegative

              ; Set the large size bit
              ; for the sprite in
              ; aSpriteExtBuffer.

              ; Get a pointer to the word in
              ; the aSpriteExtBuffer the size bit
              ; resides.

              lda aOAMExtPointerAndExtBitsTable,x
              sta wR3

              ; Combine with size bit.

              lda (wR3)

              ora aOAMExtBitTable+size(word),x

              bra _WriteBackBits

          _SmallSprite

            ; Small sprite, add to X base
            ; and set the upper bit if
            ; the result needs it.

            adc wR0
            sta aSpriteBuffer+structSpriteEntry.X,b,x

            bit #$0100
            beq +

              ; Get a pointer to the word in
              ; the aSpriteExtBuffer the X bit
              ; resides.

              lda aOAMExtPointerAndExtBitsTable,x
              sta wR3

              ; Combine with X bit.

              lda (wR3)

              ora aOAMExtBitTable,x

          _WriteBackBits
            sta (wR3)

          +
            ; Get the Y coordinate,
            ; add coordinate to base.

            lda structSpriteEntry.Y,b,y
            bit #$0080
            bne _YNegative

              and #$007F
              bra +

            _YNegative
              ora #~$007F ; s8 -> s16

            +
            clc
            adc wR1
            sta aSpriteBuffer+structPPUOAMEntry.Y,b,x

            adc #16
            cmp #256
            bge _Offscreen

            ; Get index, attributes and
            ; combine with base index and
            ; attributes.

            lda structSpriteEntry.Attr,b,y
            clc
            adc wR4
            ora wR5
            sta aSpriteBuffer+structPPUOAMEntry.Index,b,x

          _Next
            ; Advance an entry in both the
            ; sprite buffer and the sprite
            ; array.

            txa
            clc
            adc #size(structPPUOAMEntry)
            and #$01FF
            tax

            tya
            adc #size(structSpriteEntry)
            tay

            dec wR2
            bne _SpriteLoop

            stx wNextFreeSpriteOffset,b

            plx
            rtl

          _Offscreen
            lda #240
            sta aSpriteBuffer+structPPUOAMEntry.Y,b,x
            bra _Next

          _LargeSpriteXNegative

            ; Get a pointer to the word in
            ; the aSpriteExtBuffer the X bit
            ; and size bit reside.

            lda aOAMExtPointerAndExtBitsTable,x
            sta wR3

            lda (wR3)

            ; Combine with size and X bits.

            ora aOAMExtPointerAndExtBitsTable+size(word),x
            bra _WriteBackBits

        .databank 0

    .endsection PushToOAMBufferSection

    .section SpliceOAMBufferSection

      rlSpliceOAMBuffer ; 80/891B

        .autsiz
        .databank ?

        ; Needs research.

        ; Inputs:
        ; Y: Pointer to sprite array
        ; DB: Bank of sprite array
        ; wR0: X Coordinate base in pixels
        ; wR1: Y Coordinate base in pixels
        ; wR2: Sprite count?
        ; wR4: Sprite base
        ; wR5: Attribute base

        ; Outputs:
        ; None

        ; Immediately return if no sprites
        ; to push.

        lda wR2
        beq +

          lda structSpriteArray.SpriteCount,b,y
          bne ++

        +
        rtl

        +
        cmp wR2
        bge +

          sta wR2

        +
        inc y
        inc y
        jmp rlPushToOAMBuffer._Main

        .databank 0

    .endsection SpliceOAMBufferSection

.endif ; GUARD_FE5_SPRITES
