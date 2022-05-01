
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_WM_MARKERS :?= false
.if (!GUARD_FE5_WM_MARKERS)
  GUARD_FE5_WM_MARKERS := true

  ; Definitions

    .weak

      rlEnableBG1Sync        :?= address($81B1FA)
      rlEnableBG2Sync        :?= address($81B206)
      rlProcEngineCreateProc :?= address($829BF1)

      ; TODO: Proc definitions in VoltEdge

      rsProcCodeEnd  :?= address($829DB7)
      rsProcCodeJump :?= address($829E2B)

      PROC_END .segment
        ; 92/9DB7
        .word <>rsProcCodeEnd
      .endsegment

      PROC_JUMP .segment Position
        ; 82/9E2B
        .word <>rsProcCodeJump
        .word <>\Position
      .endsegment

      ; TODO: Active sprite script commands

      AS_ASMC .segment RoutinePointer
        .byte $17
        .addr \RoutinePointer
      .endsegment

      AS_Sprite .segment Duration, SpriteData
        .byte $00
        .byte \Duration
        .addr \SpriteData
      .endsegment

      AS_Loop .segment Pointer
        .byte $15
        .addr \Pointer
      .endsegment

    .endweak

  ; Freespace inclusions

    .section AS_ASMCDrawSpecialMarkerSection

      ; TODO: active sprite definitions

      startData

        AS_ASMCDrawSpecialMarker ; 91/CCEA
          .word <>rlAS_ASMCDrawSpecialMarkerInit
          .word <>rlAS_ASMCDrawSpecialMarkerOnCycle
          .word <>None

      endData
      startCode

        rlAS_ASMCDrawSpecialMarkerInit ; 91/CCF0

          .al
          .xl
          .autsiz
          .databank `*

          ; TODO: label these

          lda $7EA937
          sta aActiveSpriteSystem.aUnknown000944,b,x

          lda $7EA939
          sta  aActiveSpriteSystem.aUnknown000964,b,x

          lda $7EA93B
          sta  aActiveSpriteSystem.aUnknown000984,b,x

          asl a
          asl a
          tax
          lda @l WMMarkerTable,x

          phx

          ldx aActiveSpriteSystem.wOffset,b

          sta aActiveSpriteSystem.aCodeOffset,b,x

          lda #$0005
          sta aActiveSpriteSystem.aPalette,b,x

          lda #$0080
          sta aActiveSpriteSystem.aSpriteBase,b,x

          pla
          inc a
          inc a

          tax
          lda WMMarkerTable,x
          beq +

          jsr (WMMarkerTable,x)

          +
          rtl

          .databank 0

      endCode
      startData

        WMMarkerTable .binclude "../TABLES/WMMarkers.csv.asm"

      endData
      startCode

        rlAS_ASMCDrawSpecialMarkerOnCycle ; 91/CD6C

          .al
          .xl
          .autsiz
          .databank `*

          lda aActiveSpriteSystem.aUnknown000944,b,x
          sec
          sbc wMapScrollXPixels,b
          sta aActiveSpriteSystem.aXCoordinate,b,x

          lda aActiveSpriteSystem.aUnknown000964,b,x
          sec
          sbc wMapScrollYPixels,b
          sta aActiveSpriteSystem.aYCoordinate,b,x

          rtl

          .databank 0

        rlASMCWMClearSpecialMarker ; 91/CD81

          .al
          .xl
          .autsiz
          .databank `*

          lda $7EA93D
          asl a
          tax

          stz aActiveSpriteSystem.aTypeOffset,b,x

          lda aActiveSpriteSystem.aUnknown000984,b,x

          cmp #WMMarkerTable.Circle
          beq +

          cmp #WMMarkerTable.Crown
          beq +

          rtl

          +
          jsr $91CE4C

          phb
          php

          sep #$20

          lda lR18+size(word)
          pha

          rep #$20

          plb

          .databank ?

          ldx lR18
          lda #TilemapEntry((47 * 16) + 15, 0, false, false, false)
          sta ((0 * 32) + 0) * size(word),b,x

          lda #TilemapEntry((47 * 16) + 15, 0, false, false, false)
          sta ((0 * 32) + 1) * size(word),b,x

          lda #TilemapEntry((47 * 16) + 15, 0, false, false, false)
          sta ((1 * 32) + 0) * size(word),b,x

          lda #TilemapEntry((47 * 16) + 15, 0, false, false, false)
          sta ((1 * 32) + 1) * size(word),b,x

          jsl rlEnableBG1Sync

          plp
          plb
          rtl

          .databank 0

        rsWMSpecialMarkerCircleInit ; 91/CDC6

          .al
          .xl
          .autsiz
          .databank `*

          ldx aActiveSpriteSystem.wOffset,b

          lda $7EA937
          sec
          sbc #4
          sta aActiveSpriteSystem.aUnknown000944,b,x

          lda $7EA939
          sec
          sbc #4
          sta aActiveSpriteSystem.aUnknown000964,b,x

          jsr rsWMSpecialMarkerSetOffsets

          phb
          php

          sep #$20

          lda lR18+size(word)
          pha

          rep #$20

          plb

          .databank ?

          ldx lR18

          lda #TilemapEntry((6 * 16) + 1, 6, true, false, false)
          sta ((0 * 32) + 0) * size(word),b,x

          lda #TilemapEntry((6 * 16) + 1, 6, true, true, false)
          sta ((0 * 32) + 1) * size(word),b,x

          lda #TilemapEntry((6 * 16) + 1, 6, true, false, true)
          sta ((1 * 32) + 0) * size(word),b,x

          lda #TilemapEntry((6 * 16) + 1, 6, true, true, true)
          sta ((1 * 32) + 1) * size(word),b,x

          jsl rlEnableBG1Sync

          plp
          plb
          rts

          .databank 0

        rsWMSpecialMarkerCrownInit ; 91/CE0D

          .al
          .xl
          .autsiz
          .databank `*

          ldx aActiveSpriteSystem.wOffset,b

          lda $7EA937
          sta aActiveSpriteSystem.aUnknown000944,b,x

          lda $7EA939
          sta aActiveSpriteSystem.aUnknown000964,b,x

          jsr rsWMSpecialMarkerSetOffsets

          phb
          php

          sep #$20

          lda lR18+size(word)
          pha

          rep #$20

          plb

          .databank ?

          ldx lR18

          lda #TilemapEntry((5 * 16) + 2, 6, true, false, false)
          sta ((0 * 32) + 0) * size(word),b,x

          lda #TilemapEntry((5 * 16) + 3, 6, true, false, false)
          sta ((0 * 32) + 1) * size(word),b,x

          lda #TilemapEntry((6 * 16) + 2, 6, true, false, false)
          sta ((1 * 32) + 0) * size(word),b,x

          lda #TilemapEntry((6 * 16) + 3, 6, true, false, false)
          sta ((1 * 32) + 1) * size(word),b,x

          jsl rlEnableBG1Sync

          plp
          plb
          rts

          .databank 0

        rsWMSpecialMarkerSetOffsets ; 91/CE4C

          .al
          .xl
          .autsiz
          .databank `*

          lda aActiveSpriteSystem.aUnknown000944,b,x
          and #%111
          eor #-1
          inc a
          sta wBufferBG1HOFS

          lda aActiveSpriteSystem.aUnknown000964,b,x
          and #%111
          eor #-1
          inc a
          sta wBufferBG1VOFS

          lda aActiveSpriteSystem.aUnknown000944,b,x
          and #narrow(~%111, 1)
          lsr a
          lsr a
          sta wR0

          lda aActiveSpriteSystem.aUnknown000964,b,x
          and #narrow(~%111, 1)
          asl a
          asl a
          asl a

          clc
          adc wR0

          clc
          adc #<>aBG1TilemapBuffer

          sta lR18

          sep #$20

          lda #`aBG1TilemapBuffer
          sta lR18+size(word)

          rep #$20

          rts

          .databank 0

        rsWMSpecialMarkerTrailInit ; 91/CE89

          .al
          .xl
          .autsiz
          .databank `*

          ldx aActiveSpriteSystem.wOffset,b

          lda $7EA93F

          sec
          sbc #$0100

          lsr a
          lsr a
          lsr a
          lsr a
          lsr a

          sta aActiveSpriteSystem.aPalette,b,x

          rts

          .databank 0

        rsWMSpecialMarkerUnknown91CE9D ; 91/CE9D

          .al
          .xl
          .autsiz
          .databank `*

          ldx aActiveSpriteSystem.wOffset,b
          lda #$0005
          sta aActiveSpriteSystem.aPalette,b,x
          rts

          .databank 0

        rsWMSpecialMarkerUnknown91A7 ; 91/CEA7

          .al
          .xl
          .autsiz
          .databank `*

          ldx aActiveSpriteSystem.wOffset,b

          lda $7EA93F
          clc
          adc #$0004
          sta aActiveSpriteSystem.aPalette,b,x
          rts

          .databank 0

      endCode
      startData

        aWMSpecialMarkerUnknownScript91CEB6 ; 91/CEB6

          AS_ASMC rlWMSpecialMarkerUnknownASMC91CEB9

      endData
      startCode

        rlWMSpecialMarkerUnknownASMC91CEB9 ; 91/CEB9

          .al
          .xl
          .autsiz
          .databank `*

          lda #(`$7FB0F5)<<8
          sta lR18+size(byte)
          lda #<>$7FB0F5
          sta lR18

          lda #(`aBG2TilemapBuffer)<<8
          sta lR19+size(byte)
          lda #<>aBG2TilemapBuffer
          sta lR19

          lda $7EA937
          lsr a
          lsr a
          lsr a
          sta wR0

          lda $7EA939
          lsr a
          lsr a
          lsr a
          sta wR1

          jsl $8E8D79 ; TODO
          jsl rlEnableBG2Sync

          lda #<>aWMSpecialMarker0CScript
          sta aProcSystem.wInput0,b

          lda #$0091
          sta aProcSystem.wInput1,b

          lda #(`$8EEC55)<<8
          sta lR44+size(byte)
          lda #<>$8EEC55
          sta lR44

          jsl rlProcEngineCreateProc

          ldx aActiveSpriteSystem.wOffset,b

          stz aActiveSpriteSystem.aCodeOffset,b,x
          stz aActiveSpriteSystem.aFrameTimer,b,x

          pla
          rtl

          .databank 0

      endCode

    .endsection AS_ASMCDrawSpecialMarkerSection

    .section AS_ASMCDrawSpecialMarkerDataSection

      startData

        aWMSpecialMarker0CScript ; 91/CF0C

          AS_Sprite 9, aWMSpecialMarkerSprite91CF35
          AS_Sprite 9, aWMSpecialMarkerSprite91CF3C
          AS_Sprite 9, aWMSpecialMarkerSprite91CF43
          AS_Sprite 9, aWMSpecialMarkerSprite91CF4A
          AS_Sprite 9, aWMSpecialMarkerSprite91CF51
          AS_Sprite 9, aWMSpecialMarkerSprite91CF58

          AS_Loop aWMSpecialMarker0CScript

        aWMSpecialMarkerUnknownScript91CF27 ; 91/CF27

          AS_Sprite 1, aWMSpecialMarkerSprite91CF5F

          AS_Loop aWMSpecialMarkerUnknownScript91CF27

        aWMSpecialMarkerUnknownScript91CF2E ; 91/CF2E

          AS_Sprite 1, aWMSpecialMarkerSprite91CF66

          AS_Loop aWMSpecialMarkerUnknownScript91CF2E

        aWMSpecialMarkerSprite91CF35 .dstruct structSpriteArray, [[[-8, -8], $21, SpriteLarge, (1 * 16) +  4, 3, 0, false, false]]
        aWMSpecialMarkerSprite91CF3C .dstruct structSpriteArray, [[[-8, -8], $21, SpriteLarge, (1 * 16) +  6, 3, 0, false, false]]
        aWMSpecialMarkerSprite91CF43 .dstruct structSpriteArray, [[[-8, -8], $21, SpriteLarge, (1 * 16) +  8, 3, 0, false, false]]
        aWMSpecialMarkerSprite91CF4A .dstruct structSpriteArray, [[[-8, -8], $21, SpriteLarge, (1 * 16) + 10, 3, 0, false, false]]
        aWMSpecialMarkerSprite91CF51 .dstruct structSpriteArray, [[[-8, -8], $21, SpriteLarge, (1 * 16) + 12, 3, 0, false, false]]
        aWMSpecialMarkerSprite91CF58 .dstruct structSpriteArray, [[[-8, -8], $21, SpriteLarge, (1 * 16) + 14, 3, 0, false, false]]
        aWMSpecialMarkerSprite91CF5F .dstruct structSpriteArray, [[[-20, -4], $00, SpriteSmall, (1 * 16) + 1, 3, 0, false, false]]
        aWMSpecialMarkerSprite91CF66 .dstruct structSpriteArray, [[[-24, -8], $21, SpriteLarge, (1 * 16) + 2, 3, 0, false, false]]

        aWMSpecialMarker00Script ; 91/CF6D

          WMSpecialMarker00Coordinates  := [( -7, -126)]
          WMSpecialMarker00Coordinates ..= [( -7, -118)]
          WMSpecialMarker00Coordinates ..= [( -8, -110)]
          WMSpecialMarker00Coordinates ..= [(-12, -103)]
          WMSpecialMarker00Coordinates ..= [(-16,  -96)]
          WMSpecialMarker00Coordinates ..= [(-19,  -89)]
          WMSpecialMarker00Coordinates ..= [(-19,  -81)]
          WMSpecialMarker00Coordinates ..= [(-18,  -73)]
          WMSpecialMarker00Coordinates ..= [(-18,  -65)]
          WMSpecialMarker00Coordinates ..= [(-20,  -57)]
          WMSpecialMarker00Coordinates ..= [(-23,  -50)]

          WMSpecialMarker00Sprites := []
          .for _Coords in WMSpecialMarker00Coordinates
            WMSpecialMarker00Sprites ..= [[_Coords, $00, SpriteSmall, $00, 3, 0, false, false]]
          .endfor

          _SpritePos := aWMSpecialMarker00Sprites[0]

          .for i, _ in iter.enumerate(WMSpecialMarker00Sprites)

            -
            AS_Sprite 16, aWMSpecialMarker00Sprites[i]

            _SpritePos += size(word) + ((i + 1) * size(structSpriteEntry))

          .endfor

          AS_Loop -

          ; I guess they forgot what they were doing here?

          PROC_END

          aWMSpecialMarker00Sprites .bfor i, _ in iter.enumerate(WMSpecialMarker00Sprites)
            SL := WMSpecialMarker00Sprites[:i+1][::-1]
            .dstruct structSpriteArray, SL
          .endfor

        aWMSpecialMarker01Script ; 91/D0FE

          WMSpecialMarker01Coordinates  := [( -7, -128)]
          WMSpecialMarker01Coordinates ..= [( -9, -121)]
          WMSpecialMarker01Coordinates ..= [(-13, -115)]
          WMSpecialMarker01Coordinates ..= [(-17, -109)]
          WMSpecialMarker01Coordinates ..= [(-22, -103)]
          WMSpecialMarker01Coordinates ..= [(-27,  -98)]
          WMSpecialMarker01Coordinates ..= [(-32,  -93)]
          WMSpecialMarker01Coordinates ..= [(-38,  -88)]
          WMSpecialMarker01Coordinates ..= [(-44,  -84)]
          WMSpecialMarker01Coordinates ..= [(-50,  -80)]
          WMSpecialMarker01Coordinates ..= [(-57,  -77)]
          WMSpecialMarker01Coordinates ..= [(-64,  -76)]
          WMSpecialMarker01Coordinates ..= [(-71,  -75)]
          WMSpecialMarker01Coordinates ..= [(-78,  -73)]

          WMSpecialMarker01Sprites := []
          .for _Coords in WMSpecialMarker01Coordinates
            WMSpecialMarker01Sprites ..= [[_Coords, $00, SpriteSmall, $00, 3, 0, false, false]]
          .endfor

          _SpritePos := aWMSpecialMarker01Sprites[0]

          .for i, _ in iter.enumerate(WMSpecialMarker01Sprites)

            -
            AS_Sprite 16, aWMSpecialMarker01Sprites[i]

            _SpritePos += size(word) + ((i + 1) * size(structSpriteEntry))

          .endfor

          AS_Loop -

          aWMSpecialMarker01Sprites .bfor i, _ in iter.enumerate(WMSpecialMarker01Sprites)
            SL := WMSpecialMarker01Sprites[:i+1][::-1]
            .dstruct structSpriteArray, SL
          .endfor

        aWMSpecialMarker02Script ; 91/D362

          ; Broken, crashes

          ; This one doesn't follow the normal pattern.

          WMSpecialMarker02Coordinates  := [(-8, -127)]
          WMSpecialMarker02Coordinates ..= [(-4, -121)]
          WMSpecialMarker02Coordinates ..= [( 2, -118)]
          WMSpecialMarker02Coordinates ..= [(15, -115)]
          WMSpecialMarker02Coordinates ..= [(19, -109)]
          WMSpecialMarker02Coordinates ..= [(22, -102)]
          WMSpecialMarker02Coordinates ..= [( 9, -118)]

          WMSpecialMarker02RepeatedSprite := [[( 9, -118), $00, SpriteSmall, $00, 3, 0, false, false]]

          WMSpecialMarker02Sprite91D382List := [[(-8, -127), $00, SpriteSmall, $00, 3, 0, false, false]]
          WMSpecialMarker02Sprite91D389List := [[(-4, -121), $00, SpriteSmall, $00, 3, 0, false, false]] .. WMSpecialMarker02Sprite91D382List
          WMSpecialMarker02Sprite91D395List := [[( 2, -118), $00, SpriteSmall, $00, 3, 0, false, false]] .. WMSpecialMarker02Sprite91D389List
          WMSpecialMarker02Sprite91D3A6List := WMSpecialMarker02RepeatedSprite .. WMSpecialMarker02Sprite91D395List
          WMSpecialMarker02Sprite91D3BCList := WMSpecialMarker02RepeatedSprite .. [[(15, -115), $00, SpriteSmall, $00, 3, 0, false, false]] .. WMSpecialMarker02Sprite91D3A6List[1:]
          WMSpecialMarker02Sprite91D3D7List := WMSpecialMarker02RepeatedSprite .. [[(19, -109), $00, SpriteSmall, $00, 3, 0, false, false]] .. WMSpecialMarker02Sprite91D3BCList[1:]
          WMSpecialMarker02Sprite91D3F7List := WMSpecialMarker02RepeatedSprite .. [[(22, -102), $00, SpriteSmall, $00, 3, 0, false, false]] .. WMSpecialMarker02Sprite91D3D7List[1:]

          AS_Sprite 16, aWMSpecialMarkerSprite91D382
          AS_Sprite 16, aWMSpecialMarkerSprite91D389
          AS_Sprite 16, aWMSpecialMarkerSprite91D395
          AS_Sprite 16, aWMSpecialMarkerSprite91D3A6
          AS_Sprite 16, aWMSpecialMarkerSprite91D3BC
          AS_Sprite 16, aWMSpecialMarkerSprite91D3D7

          -
          AS_Sprite 16, aWMSpecialMarkerSprite91D3F7

          ; Once again, whomever wrote these thought that
          ; it used the same scripting system as procs, and so:

          PROC_JUMP -

          ; This crashes, of course.

          aWMSpecialMarkerSprite91D382 .dstruct structSpriteArray, WMSpecialMarker02Sprite91D382List
          aWMSpecialMarkerSprite91D389 .dstruct structSpriteArray, WMSpecialMarker02Sprite91D389List
          aWMSpecialMarkerSprite91D395 .dstruct structSpriteArray, WMSpecialMarker02Sprite91D395List
          aWMSpecialMarkerSprite91D3A6 .dstruct structSpriteArray, WMSpecialMarker02Sprite91D3A6List
          aWMSpecialMarkerSprite91D3BC .dstruct structSpriteArray, WMSpecialMarker02Sprite91D3BCList
          aWMSpecialMarkerSprite91D3D7 .dstruct structSpriteArray, WMSpecialMarker02Sprite91D3D7List
          aWMSpecialMarkerSprite91D3F7 .dstruct structSpriteArray, WMSpecialMarker02Sprite91D3F7List

        aWMSpecialMarker03Script ; 91/D41C

          WMSpecialMarker03Coordinates0  := [(-128,   0)]
          WMSpecialMarker03Coordinates0 ..= [(-121,  -2)]
          WMSpecialMarker03Coordinates0 ..= [(-116,  -7)]
          WMSpecialMarker03Coordinates0 ..= [(-112, -13)]
          WMSpecialMarker03Coordinates0 ..= [(-112, -21)]
          WMSpecialMarker03Coordinates0 ..= [(-110, -29)]
          WMSpecialMarker03Coordinates0 ..= [(-104, -33)]
          WMSpecialMarker03Coordinates0 ..= [( -97, -34)]
          WMSpecialMarker03Coordinates0 ..= [( -90, -38)]
          WMSpecialMarker03Coordinates0 ..= [( -84, -43)]
          WMSpecialMarker03Coordinates0 ..= [( -78, -47)]
          WMSpecialMarker03Coordinates0 ..= [( -71, -49)]
          WMSpecialMarker03Coordinates0 ..= [( -64, -50)]
          WMSpecialMarker03Coordinates0 ..= [( -57, -52)]
          WMSpecialMarker03Coordinates0 ..= [( -50, -54)]
          WMSpecialMarker03Coordinates0 ..= [( -43, -57)]
          WMSpecialMarker03Coordinates0 ..= [( -37, -62)]
          WMSpecialMarker03Coordinates0 ..= [( -31, -67)]
          WMSpecialMarker03Coordinates0 ..= [( -25, -72)]
          WMSpecialMarker03Coordinates0 ..= [( -19, -77)]
          WMSpecialMarker03Coordinates0 ..= [( -13, -82)]
          WMSpecialMarker03Coordinates0 ..= [(  -7, -87)]
          WMSpecialMarker03Coordinates0 ..= [(  -1, -87)]
          WMSpecialMarker03Coordinates0 ..= [(   6, -84)]
          WMSpecialMarker03Coordinates0 ..= [(  12, -80)]
          WMSpecialMarker03Coordinates0 ..= [(  18, -76)]
          WMSpecialMarker03Coordinates0 ..= [(  24, -72)]
          WMSpecialMarker03Coordinates0 ..= [(  30, -69)]
          WMSpecialMarker03Coordinates0 ..= [(  37, -68)]
          WMSpecialMarker03Coordinates0 ..= [(  44, -66)]
          WMSpecialMarker03Coordinates0 ..= [(  51, -64)]
          WMSpecialMarker03Coordinates0 ..= [(  58, -60)]

          WMSpecialMarker03Coordinates1  := [(-8, -8)]
          WMSpecialMarker03Coordinates1 ..= [(-1, -4)]
          WMSpecialMarker03Coordinates1 ..= [( 4,  2)]
          WMSpecialMarker03Coordinates1 ..= [( 4, 10)]
          WMSpecialMarker03Coordinates1 ..= [( 0, 17)]
          WMSpecialMarker03Coordinates1 ..= [(-7, 21)]

          WMSpecialMarker03Sprites0 := []
          .for _Coords in WMSpecialMarker03Coordinates0
            WMSpecialMarker03Sprites0 ..= [[_Coords, $00, SpriteSmall, $00, 3, 0, false, false]]
          .endfor

          _SpritePos := aWMSpecialMarker03Sprites0[0]

          .for i, _ in iter.enumerate(WMSpecialMarker03Sprites0)

            AS_Sprite 16, aWMSpecialMarker03Sprites0[i]

            _SpritePos += size(word) + ((i + 1) * size(structSpriteEntry))

          .endfor

          WMSpecialMarker03Sprites1 := []
          .for _Coords in WMSpecialMarker03Coordinates1
            WMSpecialMarker03Sprites1 ..= [[_Coords, $00, SpriteSmall, $00, 3, 0, false, false]]
          .endfor

          _SpritePos := aWMSpecialMarker03Sprites1[0]

          .for i, _ in iter.enumerate(WMSpecialMarker03Sprites1)

            -
            AS_Sprite 16, aWMSpecialMarker03Sprites1[i]

            _SpritePos += size(word) + ((i + 1) * size(structSpriteEntry))

          .endfor

          AS_Loop -

          aWMSpecialMarker03Sprites0 .bfor i, _ in iter.enumerate(WMSpecialMarker03Sprites0)
            SL := WMSpecialMarker03Sprites0[:i+1][::-1]
            .dstruct structSpriteArray, SL
          .endfor

          aWMSpecialMarker03Sprites1 .bfor i, _ in iter.enumerate(WMSpecialMarker03Sprites1)
            SL := WMSpecialMarker03Sprites1[:i+1][::-1]
            .dstruct structSpriteArray, SL
          .endfor

        aWMSpecialMarker04Script ; 91/DFBC

          WMSpecialMarker04Coordinates  := [( 0,   0)]
          WMSpecialMarker04Coordinates ..= [( 5,  -6)]
          WMSpecialMarker04Coordinates ..= [(15, -18)]
          WMSpecialMarker04Coordinates ..= [(11, -11)]
          WMSpecialMarker04Coordinates ..= [(18, -26)]
          WMSpecialMarker04Coordinates ..= [(21, -34)]
          WMSpecialMarker04Coordinates ..= [(25, -41)]
          WMSpecialMarker04Coordinates ..= [(28, -49)]
          WMSpecialMarker04Coordinates ..= [(29, -57)]

          WMSpecialMarker04Sprites := []
          .for _Coords in WMSpecialMarker04Coordinates
            WMSpecialMarker04Sprites ..= [[_Coords, $00, SpriteSmall, $01, 3, 0, false, false]]
          .endfor

          _SpritePos := aWMSpecialMarker04Sprites[0]

          .for i, _ in iter.enumerate(WMSpecialMarker04Sprites)

            -
            AS_Sprite 16, aWMSpecialMarker04Sprites[i]

            _SpritePos += size(word) + ((i + 1) * size(structSpriteEntry))

          .endfor

          AS_Loop -

          aWMSpecialMarker04Sprites .bfor i, _ in iter.enumerate(WMSpecialMarker04Sprites)
            SL := WMSpecialMarker04Sprites[:i+1][::-1]

            ; This one has a random difference.

            .if (i == 2)

              SL := [WMSpecialMarker04Sprites[3]] .. SL[1:]

            .endif

            .dstruct structSpriteArray, SL
          .endfor

        aWMSpecialMarker05Script ; 91/E0D6

          WMSpecialMarker05Coordinates  := [(120,  -8)]
          WMSpecialMarker05Coordinates ..= [(115, -14)]
          WMSpecialMarker05Coordinates ..= [(110, -20)]
          WMSpecialMarker05Coordinates ..= [(105, -26)]
          WMSpecialMarker05Coordinates ..= [(100, -33)]
          WMSpecialMarker05Coordinates ..= [( 95, -39)]
          WMSpecialMarker05Coordinates ..= [( 90, -45)]
          WMSpecialMarker05Coordinates ..= [( 83, -46)]
          WMSpecialMarker05Coordinates ..= [( 76, -47)]
          WMSpecialMarker05Coordinates ..= [( 69, -50)]
          WMSpecialMarker05Coordinates ..= [( 63, -55)]
          WMSpecialMarker05Coordinates ..= [( 58, -61)]
          WMSpecialMarker05Coordinates ..= [( 51, -63)]
          WMSpecialMarker05Coordinates ..= [( 44, -67)]
          WMSpecialMarker05Coordinates ..= [( 37, -71)]
          WMSpecialMarker05Coordinates ..= [( 32, -77)]

          WMSpecialMarker05Sprites := []
          .for _Coords in WMSpecialMarker05Coordinates
            WMSpecialMarker05Sprites ..= [[_Coords, $00, SpriteSmall, $01, 3, 0, false, false]]
          .endfor

          _SpritePos := aWMSpecialMarker05Sprites[0]

          .for i, _ in iter.enumerate(WMSpecialMarker05Sprites)

            -
            AS_Sprite 16, aWMSpecialMarker05Sprites[i]

            _SpritePos += size(word) + ((i + 1) * size(structSpriteEntry))

          .endfor

          AS_Loop -

          aWMSpecialMarker05Sprites .bfor i, _ in iter.enumerate(WMSpecialMarker05Sprites)
            SL := WMSpecialMarker05Sprites[:i+1][::-1]
            .dstruct structSpriteArray, SL
          .endfor

        aWMSpecialMarker06Script ; 91/E3E1

          WMSpecialMarker06Coordinates  := [(-10, -126)]
          WMSpecialMarker06Coordinates ..= [(-17, -128)]
          WMSpecialMarker06Coordinates ..= [(-24, -127)]
          WMSpecialMarker06Coordinates ..= [(-30, -124)]
          WMSpecialMarker06Coordinates ..= [(-35, -119)]
          WMSpecialMarker06Coordinates ..= [(-41, -115)]
          WMSpecialMarker06Coordinates ..= [(-48, -111)]
          WMSpecialMarker06Coordinates ..= [(-52, -104)]
          WMSpecialMarker06Coordinates ..= [(-53,  -96)]
          WMSpecialMarker06Coordinates ..= [(-53,  -88)]
          WMSpecialMarker06Coordinates ..= [(-53,  -80)]
          WMSpecialMarker06Coordinates ..= [(-53,  -72)]
          WMSpecialMarker06Coordinates ..= [(-53,  -64)]
          WMSpecialMarker06Coordinates ..= [(-53,  -56)]
          WMSpecialMarker06Coordinates ..= [(-53,  -48)]
          WMSpecialMarker06Coordinates ..= [(-58,  -41)]
          WMSpecialMarker06Coordinates ..= [(-64,  -36)]

          WMSpecialMarker06Sprites := []
          .for _Coords in WMSpecialMarker06Coordinates
            WMSpecialMarker06Sprites ..= [[_Coords, $00, SpriteSmall, $01, 3, 0, false, false]]
          .endfor

          _SpritePos := aWMSpecialMarker06Sprites[0]

          .for i, _ in iter.enumerate(WMSpecialMarker06Sprites)

            -
            AS_Sprite 16, aWMSpecialMarker06Sprites[i]

            _SpritePos += size(word) + ((i + 1) * size(structSpriteEntry))

          .endfor

          AS_Loop -

          aWMSpecialMarker06Sprites .bfor i, _ in iter.enumerate(WMSpecialMarker06Sprites)
            SL := WMSpecialMarker06Sprites[:i+1][::-1]
            .dstruct structSpriteArray, SL
          .endfor

        aWMSpecialMarker07Script ; 91/E747

          WMSpecialMarker07Coordinates  := [(-128, -125)]
          WMSpecialMarker07Coordinates ..= [(-125, -118)]
          WMSpecialMarker07Coordinates ..= [(-118, -115)]
          WMSpecialMarker07Coordinates ..= [(-111, -112)]
          WMSpecialMarker07Coordinates ..= [(-104, -109)]
          WMSpecialMarker07Coordinates ..= [( -97, -106)]
          WMSpecialMarker07Coordinates ..= [( -90, -103)]
          WMSpecialMarker07Coordinates ..= [( -83, -100)]
          WMSpecialMarker07Coordinates ..= [( -76,  -96)]
          WMSpecialMarker07Coordinates ..= [( -72,  -89)]
          WMSpecialMarker07Coordinates ..= [( -72,  -81)]
          WMSpecialMarker07Coordinates ..= [( -72,  -73)]
          WMSpecialMarker07Coordinates ..= [( -69,  -65)]
          WMSpecialMarker07Coordinates ..= [( -65,  -58)]
          WMSpecialMarker07Coordinates ..= [( -64,  -50)]
          WMSpecialMarker07Coordinates ..= [( -64,  -42)]
          WMSpecialMarker07Coordinates ..= [( -64,  -34)]
          WMSpecialMarker07Coordinates ..= [( -64,  -26)]
          WMSpecialMarker07Coordinates ..= [( -64,  -18)]
          WMSpecialMarker07Coordinates ..= [( -64,  -10)]
          WMSpecialMarker07Coordinates ..= [( -60,   -3)]
          WMSpecialMarker07Coordinates ..= [( -55,    3)]
          WMSpecialMarker07Coordinates ..= [( -49,    8)]
          WMSpecialMarker07Coordinates ..= [( -44,   14)]
          WMSpecialMarker07Coordinates ..= [( -40,   21)]
          WMSpecialMarker07Coordinates ..= [( -40,   29)]
          WMSpecialMarker07Coordinates ..= [( -35,   35)]

          WMSpecialMarker07Sprites := []
          .for _Coords in WMSpecialMarker07Coordinates
            WMSpecialMarker07Sprites ..= [[_Coords, $00, SpriteSmall, $02, 3, 0, false, false]]
          .endfor

          _SpritePos := aWMSpecialMarker07Sprites[0]

          .for i, _ in iter.enumerate(WMSpecialMarker07Sprites)

            -
            AS_Sprite 16, aWMSpecialMarker07Sprites[i]

            _SpritePos += size(word) + ((i + 1) * size(structSpriteEntry))

          .endfor

          AS_Loop -

          aWMSpecialMarker07Sprites .bfor i, _ in iter.enumerate(WMSpecialMarker07Sprites)
            SL := WMSpecialMarker07Sprites[:i+1][::-1]
            .dstruct structSpriteArray, SL
          .endfor

        aWMSpecialMarker08Script ; 91/EF4E

          WMSpecialMarker08Coordinates  := [( 0,  -8)]
          WMSpecialMarker08Coordinates ..= [( 8, -10)]
          WMSpecialMarker08Coordinates ..= [(16, -11)]
          WMSpecialMarker08Coordinates ..= [(22, -16)]
          WMSpecialMarker08Coordinates ..= [(27, -22)]

          WMSpecialMarker08Sprites := []
          .for _Coords in WMSpecialMarker08Coordinates
            WMSpecialMarker08Sprites ..= [[_Coords, $00, SpriteSmall, $02, 3, 0, false, false]]
          .endfor

          _SpritePos := aWMSpecialMarker08Sprites[0]

          .for i, _ in iter.enumerate(WMSpecialMarker08Sprites)

            -
            AS_Sprite 16, aWMSpecialMarker08Sprites[i]

            _SpritePos += size(word) + ((i + 1) * size(structSpriteEntry))

          .endfor

          AS_Loop -

          aWMSpecialMarker08Sprites .bfor i, _ in iter.enumerate(WMSpecialMarker08Sprites)
            SL := WMSpecialMarker08Sprites[:i+1][::-1]
            .dstruct structSpriteArray, SL
          .endfor

        aWMSpecialMarker0BScript ; 91/EFBA

          ; This one isn't a trail and doesn't follow a pattern.

          AS_Sprite 2, aWMSpecialMarkerSprite91EFED
          AS_Sprite 2, aWMSpecialMarkerSprite91F02F
          AS_Sprite 2, aWMSpecialMarkerSprite91F071
          AS_Sprite 2, aWMSpecialMarkerSprite91F0AF
          AS_Sprite 2, aWMSpecialMarkerSprite91F101
          AS_Sprite 1, aWMSpecialMarkerSprite91F17B
          AS_Sprite 1, aWMSpecialMarkerSprite91F21D
          AS_Sprite 1, aWMSpecialMarkerSprite91F2BF
          AS_Sprite 1, aWMSpecialMarkerSprite91F361
          AS_Sprite 1, aWMSpecialMarkerSprite91F403
          AS_Sprite 1, aWMSpecialMarkerSprite91F4A5

          -
          AS_Sprite 49, aWMSpecialMarkerSprite91F547

          AS_Loop -

          WMSpecialMarker0BSprite0  := [[(  0,   0), $00, SpriteSmall, $008, 3, 0, true, true]]
          WMSpecialMarker0BSprite0 ..= [[( -8,   0), $00, SpriteSmall, $008, 3, 0, false, true]]
          WMSpecialMarker0BSprite0 ..= [[(  0,  -8), $00, SpriteSmall, $008, 3, 0, true, false]]
          WMSpecialMarker0BSprite0 ..= [[( -8,  -8), $00, SpriteSmall, $008, 3, 0, false, false]]

          aWMSpecialMarkerSprite91EFED .dstruct structSpriteArray, WMSpecialMarker0BSprite0

          WMSpecialMarker0BSprite1  := [[(  0,   0), $00, SpriteSmall, $009, 3, 0, true, true]]
          WMSpecialMarker0BSprite1 ..= [[( -8,   0), $00, SpriteSmall, $009, 3, 0, false, true]]
          WMSpecialMarker0BSprite1 ..= [[(  0,  -8), $00, SpriteSmall, $009, 3, 0, true, false]]
          WMSpecialMarker0BSprite1 ..= [[( -8,  -8), $00, SpriteSmall, $009, 3, 0, false, false]]

          aWMSpecialMarkerSprite91F003 .dstruct structSpriteArray, WMSpecialMarker0BSprite1

          WMSpecialMarker0BSprite2  := [[(  0,   0), $00, SpriteSmall, $00A, 3, 0, true, true]]
          WMSpecialMarker0BSprite2 ..= [[( -8,   0), $00, SpriteSmall, $00A, 3, 0, false, true]]
          WMSpecialMarker0BSprite2 ..= [[(  0,  -8), $00, SpriteSmall, $00A, 3, 0, true, false]]
          WMSpecialMarker0BSprite2 ..= [[( -8,  -8), $00, SpriteSmall, $00A, 3, 0, false, false]]

          aWMSpecialMarkerSprite91F019 .dstruct structSpriteArray, WMSpecialMarker0BSprite2

          WMSpecialMarker0BSprite3  := [[(  0,   0), $00, SpriteSmall, $00C, 3, 0, true, true]]
          WMSpecialMarker0BSprite3 ..= [[(  0,  -8), $00, SpriteSmall, $00C, 3, 0, true, false]]
          WMSpecialMarker0BSprite3 ..= [[( -8,   0), $00, SpriteSmall, $00C, 3, 0, false, true]]
          WMSpecialMarker0BSprite3 ..= [[( -8,  -8), $00, SpriteSmall, $00C, 3, 0, false, false]]

          aWMSpecialMarkerSprite91F02F .dstruct structSpriteArray, WMSpecialMarker0BSprite3

          WMSpecialMarker0BSprite4  := [[(  0,  -8), $00, SpriteSmall, $00D, 3, 0, true, false]]
          WMSpecialMarker0BSprite4 ..= [[(  0,   0), $00, SpriteSmall, $00D, 3, 0, true, true]]
          WMSpecialMarker0BSprite4 ..= [[( -8,   0), $00, SpriteSmall, $00D, 3, 0, false, true]]
          WMSpecialMarker0BSprite4 ..= [[( -8,  -8), $00, SpriteSmall, $00D, 3, 0, false, false]]

          aWMSpecialMarkerSprite91F045 .dstruct structSpriteArray, WMSpecialMarker0BSprite4

          WMSpecialMarker0BSprite5  := [[(  0,   0), $00, SpriteSmall, $00E, 3, 0, true, true]]
          WMSpecialMarker0BSprite5 ..= [[( -8,   0), $00, SpriteSmall, $00E, 3, 0, false, true]]
          WMSpecialMarker0BSprite5 ..= [[(  0,  -8), $00, SpriteSmall, $00E, 3, 0, true, false]]
          WMSpecialMarker0BSprite5 ..= [[( -8,  -8), $00, SpriteSmall, $00E, 3, 0, false, false]]

          aWMSpecialMarkerSprite91F05B .dstruct structSpriteArray, WMSpecialMarker0BSprite5

          WMSpecialMarker0BSprite6  := [[(  0,   4), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite6 ..= [[( -8,   4), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite6 ..= [[(  0, -12), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite6 ..= [[( -8, -12), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite6 ..= [[(-16,  -4), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite6 ..= [[(-16,  -4), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite6 ..= [[(  8,  -4), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite6 ..= [[(  8,  -4), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite6 ..= [[(  8,   4), $00, SpriteSmall, $00E, 3, 0, true, true]]
          WMSpecialMarker0BSprite6 ..= [[(-16,   4), $00, SpriteSmall, $00E, 3, 0, false, true]]
          WMSpecialMarker0BSprite6 ..= [[(  8, -12), $00, SpriteSmall, $00E, 3, 0, true, false]]
          WMSpecialMarker0BSprite6 ..= [[(-16, -12), $00, SpriteSmall, $00E, 3, 0, false, false]]

          aWMSpecialMarkerSprite91F071 .dstruct structSpriteArray, WMSpecialMarker0BSprite6

          WMSpecialMarker0BSprite7  := [[(-24,   0), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite7 ..= [[(-24,  -8), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite7 ..= [[( 16,   0), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite7 ..= [[( 16,  -8), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite7 ..= [[(  8, -16), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite7 ..= [[(  0, -16), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite7 ..= [[( -8, -16), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite7 ..= [[(-16, -16), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite7 ..= [[(  8,   8), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite7 ..= [[(  0,   8), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite7 ..= [[( -8,   8), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite7 ..= [[(-16,   8), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite7 ..= [[(-24, -16), $00, SpriteSmall, $00E, 3, 0, false, false]]
          WMSpecialMarker0BSprite7 ..= [[( 16, -16), $00, SpriteSmall, $00E, 3, 0, true, false]]
          WMSpecialMarker0BSprite7 ..= [[( 16,   8), $00, SpriteSmall, $00E, 3, 0, true, true]]
          WMSpecialMarker0BSprite7 ..= [[(-24,   8), $00, SpriteSmall, $00E, 3, 0, false, true]]

          aWMSpecialMarkerSprite91F0AF .dstruct structSpriteArray, WMSpecialMarker0BSprite7

          WMSpecialMarker0BSprite8  := [[(-24, -24), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[(-16, -24), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[( -8, -24), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[(  0, -24), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[(  8, -24), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[( 16, -24), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[( 16,  23), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[(  8,  23), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[(  0,  23), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[( -8,  23), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[(-16,  23), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[(-24,  23), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[( 24,   8), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite8 ..= [[( 24,   0), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite8 ..= [[( 24,  -8), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite8 ..= [[( 24, -16), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite8 ..= [[(-32,   8), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite8 ..= [[(-32,   0), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite8 ..= [[(-32,  -8), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite8 ..= [[(-32, -16), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite8 ..= [[( 24,  16), $00, SpriteSmall, $00E, 3, 0, true, true]]
          WMSpecialMarker0BSprite8 ..= [[(-32,  16), $00, SpriteSmall, $00E, 3, 0, false, true]]
          WMSpecialMarker0BSprite8 ..= [[(-32, -24), $00, SpriteSmall, $00E, 3, 0, false, false]]
          WMSpecialMarker0BSprite8 ..= [[( 24, -24), $00, SpriteSmall, $00E, 3, 0, true, false]]

          aWMSpecialMarkerSprite91F101 .dstruct structSpriteArray, WMSpecialMarker0BSprite8

          WMSpecialMarker0BSprite9  := [[( 32,  24), $00, SpriteSmall, $008, 3, 0, true, true]]
          WMSpecialMarker0BSprite9 ..= [[( 32, -32), $00, SpriteSmall, $008, 3, 0, true, false]]
          WMSpecialMarker0BSprite9 ..= [[(-40,  24), $00, SpriteSmall, $008, 3, 0, false, true]]
          WMSpecialMarker0BSprite9 ..= [[(-40, -32), $00, SpriteSmall, $008, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[(  0,  18), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[( -8,  18), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[(-34,   0), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite9 ..= [[(-34,  -8), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite9 ..= [[( 26,   0), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[( 26,  -8), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[(  0, -26), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite9 ..= [[( -8, -26), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite9 ..= [[(-34,   8), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite9 ..= [[(-34,  16), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite9 ..= [[( 26,   8), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite9 ..= [[( 26,  16), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite9 ..= [[( 24,  18), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[( 16,  18), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[(  8,  18), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[(-16,  18), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[(-24,  18), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[(-32,  18), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[(-34, -16), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite9 ..= [[(-34, -24), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite9 ..= [[( 26, -16), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[( 26, -24), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite9 ..= [[( 24, -26), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite9 ..= [[( 16, -26), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite9 ..= [[(  8, -26), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite9 ..= [[(-16, -26), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite9 ..= [[(-24, -26), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite9 ..= [[(-32, -26), $00, SpriteSmall, $010, 3, 0, false, true]]

          aWMSpecialMarkerSprite91F17B .dstruct structSpriteArray, WMSpecialMarker0BSprite9

          WMSpecialMarker0BSprite10  := [[(-40,  24), $00, SpriteSmall, $009, 3, 0, false, true]]
          WMSpecialMarker0BSprite10 ..= [[( 32,  24), $00, SpriteSmall, $009, 3, 0, true, true]]
          WMSpecialMarker0BSprite10 ..= [[( 32, -32), $00, SpriteSmall, $009, 3, 0, true, false]]
          WMSpecialMarker0BSprite10 ..= [[(-40, -32), $00, SpriteSmall, $009, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[(  0,  19), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[( -8,  19), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[(-35,   0), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite10 ..= [[(-35,  -8), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite10 ..= [[( 27,   0), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[( 27,  -8), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[(  0, -27), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite10 ..= [[( -8, -27), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite10 ..= [[(-35,   8), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite10 ..= [[(-35,  16), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite10 ..= [[( 27,   8), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite10 ..= [[( 27,  16), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite10 ..= [[( 24,  19), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[( 16,  19), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[(  8,  19), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[(-16,  19), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[(-24,  19), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[(-32,  19), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[(-35, -16), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite10 ..= [[(-35, -24), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite10 ..= [[( 27, -16), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[( 27, -24), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite10 ..= [[( 24, -27), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite10 ..= [[( 16, -27), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite10 ..= [[(  8, -27), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite10 ..= [[(-16, -27), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite10 ..= [[(-24, -27), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite10 ..= [[(-32, -27), $00, SpriteSmall, $010, 3, 0, false, true]]

          aWMSpecialMarkerSprite91F21D .dstruct structSpriteArray, WMSpecialMarker0BSprite10

          WMSpecialMarker0BSprite11  := [[( 32,  24), $00, SpriteSmall, $00A, 3, 0, true, true]]
          WMSpecialMarker0BSprite11 ..= [[( 32, -32), $00, SpriteSmall, $00A, 3, 0, true, false]]
          WMSpecialMarker0BSprite11 ..= [[(-40,  24), $00, SpriteSmall, $00A, 3, 0, false, true]]
          WMSpecialMarker0BSprite11 ..= [[(-40, -32), $00, SpriteSmall, $00A, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[(  0,  20), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[( -8,  20), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[(-36,   0), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite11 ..= [[(-36,  -8), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite11 ..= [[( 28,   0), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[( 28,  -8), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[(  0, -28), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite11 ..= [[( -8, -28), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite11 ..= [[(-36,   8), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite11 ..= [[(-36,  16), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite11 ..= [[( 28,   8), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite11 ..= [[( 28,  16), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite11 ..= [[( 24,  20), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[( 16,  20), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[(  8,  20), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[(-16,  20), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[(-24,  20), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[(-32,  20), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[(-36, -16), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite11 ..= [[(-36, -24), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite11 ..= [[( 28, -16), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[( 28, -24), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite11 ..= [[( 24, -28), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite11 ..= [[( 16, -28), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite11 ..= [[(  8, -28), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite11 ..= [[(-16, -28), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite11 ..= [[(-24, -28), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite11 ..= [[(-32, -28), $00, SpriteSmall, $010, 3, 0, false, true]]

          aWMSpecialMarkerSprite91F2BF .dstruct structSpriteArray, WMSpecialMarker0BSprite11

          WMSpecialMarker0BSprite12  := [[(-40,  24), $00, SpriteSmall, $00B, 3, 0, false, true]]
          WMSpecialMarker0BSprite12 ..= [[( 32,  24), $00, SpriteSmall, $00B, 3, 0, true, true]]
          WMSpecialMarker0BSprite12 ..= [[( 32, -32), $00, SpriteSmall, $00B, 3, 0, true, false]]
          WMSpecialMarker0BSprite12 ..= [[(-40, -32), $00, SpriteSmall, $00B, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[(  0,  21), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[( -8,  21), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[(-37,   0), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite12 ..= [[(-37,  -8), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite12 ..= [[( 29,   0), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[( 29,  -8), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[(  0, -29), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite12 ..= [[( -8, -29), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite12 ..= [[(-37,   8), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite12 ..= [[(-37,  16), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite12 ..= [[( 29,   8), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite12 ..= [[( 29,  16), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite12 ..= [[( 24,  21), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[( 16,  21), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[(  8,  21), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[(-16,  21), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[(-24,  21), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[(-32,  21), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[(-37, -16), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite12 ..= [[(-37, -24), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite12 ..= [[( 29, -16), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[( 29, -24), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite12 ..= [[( 24, -29), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite12 ..= [[( 16, -29), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite12 ..= [[(  8, -29), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite12 ..= [[(-16, -29), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite12 ..= [[(-24, -29), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite12 ..= [[(-32, -29), $00, SpriteSmall, $010, 3, 0, false, true]]

          aWMSpecialMarkerSprite91F361 .dstruct structSpriteArray, WMSpecialMarker0BSprite12

          WMSpecialMarker0BSprite13  := [[(-40,  24), $00, SpriteSmall, $00C, 3, 0, false, true]]
          WMSpecialMarker0BSprite13 ..= [[( 32,  24), $00, SpriteSmall, $00C, 3, 0, true, true]]
          WMSpecialMarker0BSprite13 ..= [[( 32, -32), $00, SpriteSmall, $00C, 3, 0, true, false]]
          WMSpecialMarker0BSprite13 ..= [[(-40, -32), $00, SpriteSmall, $00C, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[(  0,  22), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[( -8,  22), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[(-38,   0), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite13 ..= [[(-38,  -8), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite13 ..= [[( 30,   0), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[( 30,  -8), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[(  0, -30), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite13 ..= [[( -8, -30), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite13 ..= [[(-38,   8), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite13 ..= [[(-38,  16), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite13 ..= [[( 30,   8), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite13 ..= [[( 30,  16), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite13 ..= [[( 24,  22), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[( 16,  22), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[(  8,  22), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[(-16,  22), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[(-24,  22), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[(-32,  22), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[(-38, -16), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite13 ..= [[(-38, -24), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite13 ..= [[( 30, -16), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[( 30, -24), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite13 ..= [[( 24, -30), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite13 ..= [[( 16, -30), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite13 ..= [[(  8, -30), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite13 ..= [[(-16, -30), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite13 ..= [[(-24, -30), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite13 ..= [[(-32, -30), $00, SpriteSmall, $010, 3, 0, false, true]]

          aWMSpecialMarkerSprite91F403 .dstruct structSpriteArray, WMSpecialMarker0BSprite13

          WMSpecialMarker0BSprite14  := [[(-40,  24), $00, SpriteSmall, $00D, 3, 0, false, true]]
          WMSpecialMarker0BSprite14 ..= [[( 32,  24), $00, SpriteSmall, $00D, 3, 0, true, true]]
          WMSpecialMarker0BSprite14 ..= [[( 32, -32), $00, SpriteSmall, $00D, 3, 0, true, false]]
          WMSpecialMarker0BSprite14 ..= [[(-40, -32), $00, SpriteSmall, $00D, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[(  0,  23), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[( -8,  23), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[(-39,   0), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite14 ..= [[(-39,  -8), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite14 ..= [[( 31,   0), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[( 31,  -8), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[(  0, -31), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite14 ..= [[( -8, -31), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite14 ..= [[(-39,   8), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite14 ..= [[(-39,  16), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite14 ..= [[( 31,   8), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite14 ..= [[( 31,  16), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite14 ..= [[( 24,  23), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[( 16,  23), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[(  8,  23), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[(-16,  23), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[(-24,  23), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[(-32,  23), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[(-39, -16), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite14 ..= [[(-39, -24), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite14 ..= [[( 31, -16), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[( 31, -24), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite14 ..= [[( 24, -31), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite14 ..= [[( 16, -31), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite14 ..= [[(  8, -31), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite14 ..= [[(-16, -31), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite14 ..= [[(-24, -31), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite14 ..= [[(-32, -31), $00, SpriteSmall, $010, 3, 0, false, true]]

          aWMSpecialMarkerSprite91F4A5 .dstruct structSpriteArray, WMSpecialMarker0BSprite14

          WMSpecialMarker0BSprite15  := [[(  0,  24), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite15 ..= [[( -8,  24), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite15 ..= [[(-40,   0), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite15 ..= [[(-40,  -8), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite15 ..= [[( 32,   0), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite15 ..= [[( 32,  -8), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite15 ..= [[(  0, -32), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite15 ..= [[( -8, -32), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite15 ..= [[(-40,   8), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite15 ..= [[(-40,  16), $00, SpriteSmall, $00F, 3, 0, true, true]]
          WMSpecialMarker0BSprite15 ..= [[( 32,   8), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite15 ..= [[( 32,  16), $00, SpriteSmall, $00F, 3, 0, false, true]]
          WMSpecialMarker0BSprite15 ..= [[( 32,  24), $00, SpriteSmall, $00E, 3, 0, true, true]]
          WMSpecialMarker0BSprite15 ..= [[( 24,  24), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite15 ..= [[( 16,  24), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite15 ..= [[(  8,  24), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite15 ..= [[(-16,  24), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite15 ..= [[(-24,  24), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite15 ..= [[(-32,  24), $00, SpriteSmall, $010, 3, 0, false, false]]
          WMSpecialMarker0BSprite15 ..= [[(-40,  24), $00, SpriteSmall, $00E, 3, 0, false, true]]
          WMSpecialMarker0BSprite15 ..= [[(-40, -16), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite15 ..= [[(-40, -24), $00, SpriteSmall, $00F, 3, 0, true, false]]
          WMSpecialMarker0BSprite15 ..= [[( 32, -16), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite15 ..= [[( 32, -24), $00, SpriteSmall, $00F, 3, 0, false, false]]
          WMSpecialMarker0BSprite15 ..= [[( 32, -32), $00, SpriteSmall, $00E, 3, 0, true, false]]
          WMSpecialMarker0BSprite15 ..= [[( 24, -32), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite15 ..= [[( 16, -32), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite15 ..= [[(  8, -32), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite15 ..= [[(-16, -32), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite15 ..= [[(-24, -32), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite15 ..= [[(-32, -32), $00, SpriteSmall, $010, 3, 0, false, true]]
          WMSpecialMarker0BSprite15 ..= [[(-40, -32), $00, SpriteSmall, $00E, 3, 0, false, false]]

          aWMSpecialMarkerSprite91F547 .dstruct structSpriteArray, WMSpecialMarker0BSprite15

        aWMSpecialMarker09Script ; 91/F5E9

          WMSpecialMarker09Coordinates  := [( -7, -11)]
          WMSpecialMarker09Coordinates ..= [(-11, -19)]
          WMSpecialMarker09Coordinates ..= [(-14, -27)]
          WMSpecialMarker09Coordinates ..= [(-15, -35)]
          WMSpecialMarker09Coordinates ..= [(-16, -43)]
          WMSpecialMarker09Coordinates ..= [(-16, -51)]
          WMSpecialMarker09Coordinates ..= [(-15, -59)]
          WMSpecialMarker09Coordinates ..= [(-12, -67)]
          WMSpecialMarker09Coordinates ..= [( -8, -75)]
          WMSpecialMarker09Coordinates ..= [( -3, -82)]
          WMSpecialMarker09Coordinates ..= [(  3, -88)]
          WMSpecialMarker09Coordinates ..= [( 10, -91)]
          WMSpecialMarker09Coordinates ..= [( 17, -90)]
          WMSpecialMarker09Coordinates ..= [( 24, -87)]

          WMSpecialMarker09Sprites := []
          .for _Coords in WMSpecialMarker09Coordinates
            WMSpecialMarker09Sprites ..= [[_Coords, $00, SpriteSmall, $00, 3, 0, false, false]]
          .endfor

          _SpritePos := aWMSpecialMarker09Sprites[0]

          .for i, _ in iter.enumerate(WMSpecialMarker09Sprites)

            -
            AS_Sprite 16, aWMSpecialMarker09Sprites[i]

            _SpritePos += size(word) + ((i + 1) * size(structSpriteEntry))

          .endfor

          AS_Loop -

          aWMSpecialMarker09Sprites .bfor i, _ in iter.enumerate(WMSpecialMarker09Sprites)
            SL := WMSpecialMarker09Sprites[:i+1][::-1]
            .dstruct structSpriteArray, SL
          .endfor

        aWMSpecialMarker0AScript ; 91/F84D

          WMSpecialMarker0ACoordinates  := [( 3,  -8)]
          WMSpecialMarker0ACoordinates ..= [( 9, -15)]
          WMSpecialMarker0ACoordinates ..= [(15, -23)]
          WMSpecialMarker0ACoordinates ..= [(19, -32)]
          WMSpecialMarker0ACoordinates ..= [(21, -42)]
          WMSpecialMarker0ACoordinates ..= [(26, -49)]
          WMSpecialMarker0ACoordinates ..= [(32, -55)]
          WMSpecialMarker0ACoordinates ..= [(35, -63)]
          WMSpecialMarker0ACoordinates ..= [(34, -72)]

          WMSpecialMarker0ASprites := []
          .for _Coords in WMSpecialMarker0ACoordinates
            WMSpecialMarker0ASprites ..= [[_Coords, $00, SpriteSmall, $00, 3, 0, false, false]]
          .endfor

          _SpritePos := aWMSpecialMarker0ASprites[0]

          .for i, _ in iter.enumerate(WMSpecialMarker0ASprites)

            -
            AS_Sprite 16, aWMSpecialMarker0ASprites[i]

            _SpritePos += size(word) + ((i + 1) * size(structSpriteEntry))

          .endfor

          AS_Loop -

          aWMSpecialMarker0ASprites .bfor i, _ in iter.enumerate(WMSpecialMarker0ASprites)
            SL := WMSpecialMarker0ASprites[:i+1][::-1]

            ; The last sprite breaks the pattern.

            .if (i == 8)

              SL := SL[1:3] .. [SL[0]] .. SL[3:]

            .endif

            .dstruct structSpriteArray, SL
          .endfor

      endData

    .endsection AS_ASMCDrawSpecialMarkerDataSection

.endif ; GUARD_FE5_WM_MARKERS
