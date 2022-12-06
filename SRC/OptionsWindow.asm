
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_OPTIONS_WINDOW :?= false
.if (!GUARD_FE5_OPTIONS_WINDOW)
  GUARD_FE5_OPTIONS_WINDOW := true

  ; Definitions

    .weak

      rlPushToOAMBuffer                          :?= address($808881)
      rlPlaySoundEffectForced                    :?= address($808C7D)
      rlPlaySoundEffect                          :?= address($808C87)
      rsPostBMenuWindowCallback                  :?= address($809E46)
      rlUnsignedMultiply16By16                   :?= address($80AA27)
      rlDMAByStruct                              :?= address($80AE2E)
      rlDMAByPointer                             :?= address($80AEF9)
      rlAppendDecompList                         :?= address($80B00A)
      rlBlockCopy                                :?= address($80B340)
      rlFillTilemapByWord                        :?= address($80E89F)
      rlFillTilemapRectByWord                    :?= address($80E91F)
      rlGetSaveSlotOffset                        :?= address($81C8B6)
      rlProcEngineCreateProc                     :?= address($829BF1)
      rlProcEngineFreeProc                       :?= address($829D11)
      rlHDMAArrayEngineCreateEntryByIndex        :?= address($82A470)
      rlClearJoypadInputs                        :?= address($839B7F)
      rlMenuTryScrollDown                        :?= address($83C8BF)
      rlMenuTryScrollUp                          :?= address($83C8EE)
      rlSetUpScrollingArrowSpeed                 :?= address($83CCB1)
      rlSetDownScrollingArrowSpeed               :?= address($83CCC9)
      rlToggleDownwardsSpinningArrow             :?= address($83CCE1)
      rlToggleUpwardsSpinningArrow               :?= address($83CCF9)
      rlDrawTilemapPackedRect                    :?= address($84A3FF)
      rlCreateDownwardsSpinningArrow             :?= address($83CB26)
      rlCreateUpwardsSpinningArrow               :?= address($83CB53)
      rlDrawRightFacingCursor                    :?= address($859013)
      rlDrawRightFacingStaticCursorHighPrio      :?= address($8590CF)
      rlUnknown859132                            :?= address($859132)
      rsUnknown859166                            :?= address($859166)
      rsUnknown859273                            :?= address($859273)
      rlUnknown8593A6                            :?= address($8593A6)
      rlUnknown8593AD                            :?= address($8593AD)
      rlGetDefaultColorSetting                   :?= address($8594EC)
      rlGetCurrentColorSetting                   :?= address($859532)
      rlCheckColorSettingModified                :?= address($85959A)
      rlSaveCurrentColorSetting                  :?= address($859566)
      rlGetCurrentBackgroundSetting              :?= address($85968D)
      rlCopyDarkMenuBackgroundGraphicsAndPalette :?= address($8597D4)
      rlDrawWindowBackgroundFromTilemapInfo      :?= address($87D6FC)
      rlDrawWindowBordersFromTilemapInfo         :?= address($87D7FD)
      rlDrawMenuText                             :?= address($87E728)
      rlGetMenuTextWidth                         :?= address($87E873)

      procFadeWithCallback  :?= address($82A1BB)

      aGenericBG1TilemapInfo :?= address($83C0FF)

      g4bppDarkMenuBackgroundTiles :?= address($F4B000)
      aDarkMenuBackgroundPalette   :?= address($F4FEC0)

      TextWhite :?= 0
      TextBrown :?= 1
      TextBlue  :?= 2
      TextGray  :?= 3

    .endweak

    structOptionsWindowOptionsText .struct OptionsList
      .if !(\OptionsList === ?)
        .enc "SJIS"
        _Count = len(\OptionsList)
        _OptionsInfoTemp := []
        _Position := 0
        .for _Option in \OptionsList
          _OptionsInfoTemp ..= [(_Position, len(_Option))]
          _Position += len(_Option) + 2
        .endfor
        .text zstr.join(\OptionsList, "　　") .. "\n"
        _OptionsInfo = _OptionsInfoTemp
      .endif ; !(\OptionsList === ?)
    .endstruct

    structOptionsWindowTintTextLine .struct Coordinates, BaseTile, TextPointer
      .if (\Coordinates === ?)
        Coordinates .word ?
        BaseTile    .word ?
        TextPointer .word ?
      .else ; (\Coordinates === ?)
        .word pack(\Coordinates)
        .word \BaseTile
        .addr \TextPointer
      .endif
    .endstruct

    OptionsWindowConfig .namespace

      OAMBase = $0000
      BG1Base = $4000
      BG2Base = BG1Base
      BG3Base = $A000

      BG1TilemapPosition = $E000
      BG2TilemapPosition = $F000
      ; BG3TilemapPosition = $A000 ; See below

      BG12TilesPosition := BG1Base
      BG12Allocate .function Size
        Return := OptionsWindowConfig.BG12TilesPosition
        OptionsWindowConfig.BG12TilesPosition += Size
      .endfunction Return

      BG3TilesPosition := BG3Base
      BG3Allocate .function Size
        Return := OptionsWindowConfig.BG3TilesPosition
        OptionsWindowConfig.BG3TilesPosition += Size
      .endfunction Return

      _ := BG12Allocate(16 * 4 * size(Tile4bpp))

      MenuBackgroundTilesPosition = BG12Allocate(16 * 4 * size(Tile4bpp))
      ColorSliderTilesPosition    = BG12Allocate(16 * 2 * size(Tile4bpp))

      ; This is a bad way of doing this, but we're going to define the
      ; option icon tile positions by allocating the upper row, then
      ; allocating a gap for the lower row, doing this for both
      ; rows of icons and the `Configuration` label.

      AnimationIconTilesPosition     = BG12Allocate(2 * size(Tile4bpp))
      TerrainWindowIconTilesPosition = BG12Allocate(2 * size(Tile4bpp))
      UnitWindowIconTilesPosition    = BG12Allocate(2 * size(Tile4bpp))
      AutocursorIconTilesPosition    = BG12Allocate(2 * size(Tile4bpp))
      TextSpeedIconTilesPosition     = BG12Allocate(2 * size(Tile4bpp))
      UnitSpeedIconTilesPosition     = BG12Allocate(2 * size(Tile4bpp))
      AudioIconTilesPosition         = BG12Allocate(2 * size(Tile4bpp))
      BGMIconTilesPosition           = BG12Allocate(2 * size(Tile4bpp))

      _ := BG12Allocate(16 * size(Tile4bpp))

      VolumeIconTilesPosition        = BG12Allocate(2 * size(Tile4bpp))
      BackgroundIconTilesPosition    = BG12Allocate(2 * size(Tile4bpp))
      TintIconTilesPosition          = BG12Allocate(2 * size(Tile4bpp))

      ConfigurationLabelTilesPosition = BG12Allocate(10 * size(Tile4bpp))

      _ := BG12Allocate(16 * size(Tile4bpp))

      _ := BG12Allocate(16 * 2 * size(Tile4bpp))

      DarkMenuBackgroundTilesPosition = BG12Allocate(16 * 4 * size(Tile4bpp))

      BG3TilemapPosition = BG3Allocate(64 * 32 * size(word))

      _ := BG3Allocate(16 * 8 * size(Tile2bpp))

      BG3MenuTilesPosition = BG3Allocate(16 * 40 * size(Tile2bpp))

      ; Because this gets used so often, we'll calculate
      ; it ahead of time.

      BG3MenuTilesBaseTile = VRAMToTile(BG3MenuTilesPosition, BG3Base, size(Tile2bpp))

      TopRegion .namespace

        Position = (0, 0)
        Size     = (32, 4)

      .endnamespace

      MiddleRegion .namespace

        Position = (0, 4)
        Size     = (32, 20)

        LineCount  = 11
        LineHeight = 3

        Base = (3, 5)

        RowBases = iter.map(iter.reversed, iter.zip_single(range(LineCount + 1) * LineHeight, 0))

        IconOffset   = Base + ( 0, 0)
        NameOffset   = Base + ( 2, 0)
        OptionOffset = Base + (13, 0)

        OptionsWidth = 32 - 2 - iter.fst(OptionOffset)

        ; Helper function
        _AddOffset .sfunction Offset, iter.starmap(op.add, iter.zip_single(RowBases, Offset))

        IconPositions   = _AddOffset(IconOffset)
        NamePositions   = _AddOffset(NameOffset)
        OptionPositions = _AddOffset(OptionOffset)

        ; TODO: figure out the math for this

        LowerOffset = (0, 32) + (0, 3)

        TintIconPosition = (3, 35) - LowerOffset

        TintNamePosition    = ( 5, 35) - LowerOffset
        UpperTextPosition   = ( 7, 37) - LowerOffset
        LowerTextPosition   = ( 7, 40) - LowerOffset
        DefaultTextPosition = (16, 43) - LowerOffset

      .endnamespace

      BottomRegion .namespace

        Position = (0, 24)
        Size     = (32, 4)

        SubtitleOffset = (1, 1)

      .endnamespace

    .endnamespace

  ; Freespace inclusions

    .section OptionsWindowSection

      .with OptionsWindowConfig

      startCode

        ; Thanks FE5, the action table for this menu's closing action
        ; doesn't have a NextAction, so we use a union to overlap the table
        ; with the code that follows.

        .union

          endCode
          startData

            .struct

            aOptionsWindowActions .binclude "../TABLES/OptionsWindowActions.csv.asm" ; 85/CE84

            .endstruct

          endData
          startCode

            .struct

            .fill (11 * size(word))

            rsOptionsWindowUpdate ; 85/CE9A

              .al
              .xl
              .autsiz
              .databank `wOptionsWindowActionIndex

              ; Handles updating the options window.

              ; Inputs:
              ; None
              
              ; Outputs:
              ; None

              ; Update where we're scrolled to.

              lda wOptionsWindowScrollPixels
              sta aOptionsWindowScrollPositionsHDMA + 4
              sta aOptionsWindowScrollPositionsHDMA + 7

              ; Display the appropriate scrolling arrows and
              ; make sure that the `Default` window color
              ; option has the right state.

              jsr rsOptionsWindowToggleScrollingArrows
              jsr rsOptionsWindowUpdateColorDefaultTextColor

              ; Run the handler for the selected action.

              lda wOptionsWindowActionIndex
              and #$00FF
              asl a
              asl a
              tax
              lda aOptionsWindowActions,x
              sta wR0
              pea #<>(+)-1
              jmp (wR0)

              +
              rts

              .databank 0

            .endstruct

        .endunion

        rsOptionsWindowGetNextAction ; 85/CEBF

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Gets the next action for the options window

          ; Inputs:
          ; wOptionsWindowActionIndex: current index into aOptionsWindowActions
          
          ; Outputs:
          ; wOptionsWindowActionIndex: next action index

          lda wOptionsWindowActionIndex
          and #$00FF
          asl a
          asl a

          .rept size(addr)
            inc a
          .endrept

          tax
          lda aOptionsWindowActions,x
          sta wOptionsWindowActionIndex
          rts

          .databank 0

      endCode
      startData

        aOptionsWindowLinePointers .block ; 85/CED2
          wAnimation     .addr aOptionsWindowLines.aAnimation
          wTerrainWindow .addr aOptionsWindowLines.aTerrainWindow
          wUnitWindow    .addr aOptionsWindowLines.aUnitWindow
          wAutocursor    .addr aOptionsWindowLines.aAutocursor
          wTextSpeed     .addr aOptionsWindowLines.aTextSpeed
          wUnitSpeed     .addr aOptionsWindowLines.aUnitSpeed
          wAudio         .addr aOptionsWindowLines.aAudio
          wBGM           .addr aOptionsWindowLines.aBGM
          wVolume        .addr aOptionsWindowLines.aVolume
          wBackground    .addr aOptionsWindowLines.aBackground
          .word 0
        .endblock

        aOptionsWindowLines .block ; 85/CEE8

          _TME .sfunction Tile, TilemapEntry(VRAMToTile(Tile, BG2Base, size(Tile4bpp)), 6, true, false, false)

          aAnimation     .structOptionsWindowLine None, menutextOptionsWindowAnimationName,     menutextOptionsWindowAnimationOptions,  menutextOptionsWindowAnimationSubtitle,     rsOptionsWindowGetAnimationSetting,     rsOptionsWindowSetAnimationSetting,     aOptionsWindowLines._TME(AnimationIconTilesPosition)     ; 85/CEE8
          aTerrainWindow .structOptionsWindowLine None, menutextOptionsWindowTerrainWindowName, menutextOptionsWindowOnOffOptions,      menutextOptionsWindowTerrainWindowSubtitle, rsOptionsWindowGetTerrainWindowSetting, rsOptionsWindowSetTerrainWindowSetting, aOptionsWindowLines._TME(TerrainWindowIconTilesPosition) ; 85/CF04
          aUnitWindow    .structOptionsWindowLine None, menutextOptionsWindowUnitWindowName,    menutextOptionsWindowOnOffOptions,      menutextOptionsWindowUnitWindowSubtitle,    rsOptionsWindowGetBurstWindowSetting,   rsOptionsWindowSetBurstWindowSetting,   aOptionsWindowLines._TME(UnitWindowIconTilesPosition)    ; 85/CF1C
          aAutocursor    .structOptionsWindowLine None, menutextOptionsWindowAutocursorName,    menutextOptionsWindowOnOffOptions,      menutextOptionsWindowAutocursorSubtitle,    rsOptionsWindowGetAutocursorSetting,    rsOptionsWindowSetAutocursorSetting,    aOptionsWindowLines._TME(AutocursorIconTilesPosition)    ; 85/CF34
          aTextSpeed     .structOptionsWindowLine None, menutextOptionsWindowTextSpeedName,     menutextOptionsWindowTextSpeedOptions,  menutextOptionsWindowTextSpeedSubtitle,     rsOptionsWindowGetTextSpeedSetting,     rsOptionsWindowSetTextSpeedSetting,     aOptionsWindowLines._TME(TextSpeedIconTilesPosition)     ; 85/CF4C
          aUnitSpeed     .structOptionsWindowLine None, menutextOptionsWindowUnitSpeedName,     menutextOptionsWindowUnitSpeedOptions,  menutextOptionsWindowUnitSpeedSubtitle,     rsOptionsWindowGetUnitSpeedSetting,     rsOptionsWindowSetUnitSpeedSetting,     aOptionsWindowLines._TME(UnitSpeedIconTilesPosition)     ; 85/CF68
          aAudio         .structOptionsWindowLine None, menutextOptionsWindowAudioName,         menutextOptionsWindowAudioOptions,      menutextOptionsWindowAudioSubtitle,         rsOptionsWindowGetSoundSetting,         rsOptionsWindowSetSoundSetting,         aOptionsWindowLines._TME(AudioIconTilesPosition)         ; 85/CF80
          aBGM           .structOptionsWindowLine None, menutextOptionsWindowBGMName,           menutextOptionsWindowOnOffOptions,      menutextOptionsWindowBGMSubtitle,           rsOptionsWindowGetBGMSetting,           rsOptionsWindowSetBGMSetting,           aOptionsWindowLines._TME(BGMIconTilesPosition)           ; 85/CF98
          aVolume        .structOptionsWindowLine None, menutextOptionsWindowVolumeName,        menutextOptionsWindowVolumeOptions,     menutextOptionsWindowVolumeSubtitle,        rsOptionsWindowGetVolumeSetting,        rsOptionsWindowSetVolumeSetting,        aOptionsWindowLines._TME(VolumeIconTilesPosition)        ; 85/CFB0
          aBackground    .structOptionsWindowLine None, menutextOptionsWindowBackgroundName,    menutextOptionsWindowBackgroundOptions, menutextOptionsWindowBackgroundSubtitle,    rsOptionsWindowGetWindowSetting,        rsOptionsWindowSetWindowSetting,        aOptionsWindowLines._TME(BackgroundIconTilesPosition)    ; 85/CFD4
        .endblock

      endData
      startMenuText

        .enc "SJIS"

        menutextOptionsWindowAnimationName     .text "アニメ設定\n" ; 85/CFF4
        menutextOptionsWindowTerrainWindowName .text "ちけいウィンドウ\n" ; 85/D000
        menutextOptionsWindowUnitWindowName    .text "ユニットウィンドウ\n" ; 85/D012
        menutextOptionsWindowTextSpeedName     .text "メッセージスピード\n" ; 85/D026
        menutextOptionsWindowUnitSpeedName     .text "ゲームスピード\n" ; 85/D03A
        menutextOptionsWindowAudioName         .text "サウンド設定\n" ; 85/D04A
        menutextOptionsWindowBGMName           .text "ＢＧＭ\n" ; 85/D058
        menutextOptionsWindowVolumeName        .text "こうかおん\n" ; 85/D060
        menutextOptionsWindowAutocursorName    .text "オートカーソル\n" ; 85/D06C
        menutextOptionsWindowAIName            .text "てきのあたまのよさ\n" ; 85/D07C
        menutextOptionsWindowBackgroundName    .text "タイル設定\n" ; 85/D090

        menutextOptionsWindowAnimationOptions  .structOptionsWindowOptionsText ["リアル", "マップ", "こべつ"] ; 85/D09C
        menutextOptionsWindowOnOffOptions      .structOptionsWindowOptionsText ["オン", "オフ"] ; 85/D0B8
        menutextOptionsWindowTextSpeedOptions  .structOptionsWindowOptionsText ["おそい", "ふつう", "はやい"] ; 85/D0C6
        menutextOptionsWindowUnitSpeedOptions  .structOptionsWindowOptionsText ["ふつう", "はやい"] ; 85/D0E2
        menutextOptionsWindowAudioOptions      .structOptionsWindowOptionsText ["ステレオ", "モノラル"] ; 85/D0F4
        menutextOptionsWindowAIOptions         .structOptionsWindowOptionsText ["ふつう", "かしこい"] ; 85/D105
        menutextOptionsWindowBackgroundOptions .structOptionsWindowOptionsText ["１", "２", "３", "４", "５"] ; 85/D11E
        menutextOptionsWindowVolumeOptions     .structOptionsWindowOptionsText ["＞＞＞", "＞＞", "＞", "オフ"] ; 85/D13A

        menutextOptionsWindowAnimationSubtitle     .text "せんとうアニメーションの設定\n" ; 85/D158
        menutextOptionsWindowTerrainWindowSubtitle .text "ちけいウィンドウのひょうじ\n" ; 85/D176
        menutextOptionsWindowUnitWindowSubtitle    .text "ユニットウィンドウのひょうじ\n" ; 85/D192
        menutextOptionsWindowTextSpeedSubtitle     .text "メッセージをひょうじするはやさ\n" ; 85/D1B0
        menutextOptionsWindowUnitSpeedSubtitle     .text "ユニットの移動するスピード\n" ; 85/D1D0
        menutextOptionsWindowAudioSubtitle         .text "サウンドの設定\n" ; 85/D1EC
        menutextOptionsWindowBGMSubtitle           .text "ＢＧＭの設定\n" ; 85/D1FC
        menutextOptionsWindowVolumeSubtitle        .text "こうかおんのおんりょう\n" ; 82/D20A
        menutextOptionsWindowAutocursorSubtitle    .text "ターンのはじめにしゅじんこうにカーソルをあわせる\n" ; 82/D222
        menutextOptionsWindowAISubtitle            .text "てきのあたまのよさ\n" ; 85/D254
        menutextOptionsWindowBackgroundSubtitle    .text "ウィンドウタイルの設定\n" ; 85/D258

      endMenuText
      startData

        aOptionsWindowColorSubtitlePointers .block ; 85/D280
          .addr menutextOptionsWindowUpperRedSubtitle
          .addr menutextOptionsWindowUpperGreenSubtitle
          .addr menutextOptionsWindowUpperBlueSubtitle
          .addr menutextOptionsWindowLowerRedSubtitle
          .addr menutextOptionsWindowLowerGreenSubtitle
          .addr menutextOptionsWindowLowerBlueSubtitle
          .addr menutextOptionsWindowDefaultSubtitle
        .endblock

      endData
      startMenuText

        menutextOptionsWindowUpperRedSubtitle   .text "上のあかせいぶん\n" ; 85/D28E
        menutextOptionsWindowUpperGreenSubtitle .text "上のみどりせいぶん\n" ; 85/D2A0
        menutextOptionsWindowUpperBlueSubtitle  .text "上のあおせいぶん\n" ; 85/D2B4
        menutextOptionsWindowLowerRedSubtitle   .text "下のあかせいぶん\n" ; 85/D2C6
        menutextOptionsWindowLowerGreenSubtitle .text "下のみどりせいぶん\n" ; 85/D2D8
        menutextOptionsWindowLowerBlueSubtitle  .text "下のあおせいぶん\n" ; 85/D2EC
        menutextOptionsWindowDefaultSubtitle    .text "ひょうじゅんカラーにもどす\n" ; 85/D2FE

      endMenuText
      startData

        aUnknown85D31ATilemapInfo .structTilemapInfo (32, 64), None, aBG3TilemapBuffer ; 85/D31A

      endData
      startCode

        rlCreateOptionsWindow ; 85/D323

          .xl
          .autsiz
          .databank ?

          ; This creates the options window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          php
          phb

          sep #$20

          lda #`wOptionsWindowActionIndex
          pha

          rep #$20

          plb

          .databank `wOptionsWindowActionIndex

          jsr rsOptionsWindowClearTilemaps
          jsr rsOptionsWindowResetPositions
          jsr rsOptionsWindowSetShading
          jsr rsOptionsWindowDrawBackground
          jsr rsOptionsWindowCopyMenuLinePointers
          lda #<>aOptionsWindowTempMenuLine.OnOpen
          jsr rsOptionsWindowRunAllOptionsCopiers
          jsr rsOptionsWindowDrawLines
          jsr rsOptionsWindowDrawTintLines
          jsr rsOptionsWindowDrawBorders
          jsr rsOptionsWindowSetScrollingInfo
          jsr rsOptionsWindowDrawConfigurationLabel
          jsr rsOptionsWindowDrawTintSlidersAndLabelsTilemap
          jsr rsOptionsWindowSetHDMA
          jsr rsOptionsWindowCreateScrollingArrows

          phx

          lda #(`procOptionsWindowColorSliderManager)<<8
          sta lR44+size(byte)
          lda #<>procOptionsWindowColorSliderManager
          sta lR44
          jsl rlProcEngineCreateProc

          plx

          jsr rsOptionsWindowGetMaxScrollDistance

          lda #<>g4bppDarkMenuBackgroundTiles
          sta lR18
          lda #>`g4bppDarkMenuBackgroundTiles
          sta lR18+size(byte)
          lda #DarkMenuBackgroundTilesPosition >> 1
          sta wR0
          lda #<>aDarkMenuBackgroundPalette
          sta lR19
          lda #>`aDarkMenuBackgroundPalette
          sta lR19+size(byte)
          lda #<>aBGPaletteBuffer.aPalette1
          sta wR1
          jsl rlCopyDarkMenuBackgroundGraphicsAndPalette

          lda #(`$9EED79)<<8
          sta lR18+size(byte)
          lda #<>$9EED79
          sta lR18
          lda #(`aDecompressionBuffer)<<8
          sta lR19+size(byte)
          lda #<>aDecompressionBuffer
          sta lR19
          jsl rlAppendDecompList

          lda #(`aDecompressionBuffer)<<8
          sta lR18+size(byte)
          lda #<>aDecompressionBuffer
          sta lR18
          lda #(`aBG3TilemapBuffer)<<8
          sta lR19+size(byte)
          lda #<>aBG3TilemapBuffer
          sta lR19
          lda #$0100
          sta lR20
          jsl rlBlockCopy

          lda #(`$9EF33E)<<8
          sta lR18+size(byte)
          lda #<>$9EF33E
          sta lR18
          lda #(`aBG1TilemapBuffer)<<8
          sta lR19+size(byte)
          lda #<>aBG1TilemapBuffer
          sta lR19
          jsl rlAppendDecompList

          lda #(`$9E9DA7)<<8
          sta lR18+size(byte)
          lda #<>$9E9DA7
          sta lR18
          lda #(`aDecompressionBuffer)<<8
          sta lR19+size(byte)
          lda #<>aDecompressionBuffer
          sta lR19
          jsl rlAppendDecompList

          jsl rlDMAByStruct

            .dstruct structDMAToVRAM, aDecompressionBuffer, (16 * 6 * size(Tile4bpp)), VMAIN_Setting(true), ColorSliderTilesPosition

          jsl rlDMAByStruct

            .dstruct structDMAToVRAM, aBG1TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG1TilemapPosition

          jsl rlDMAByStruct

            .dstruct structDMAToVRAM, aBG2TilemapBuffer, (32 * 64 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

          jsl rlDMAByStruct

            .dstruct structDMAToVRAM, aBG3TilemapBuffer, (32 * 64 * size(word)), VMAIN_Setting(true), BG3TilemapPosition

          plb
          plp
          rtl

          .databank ?

        rsOptionsWindowResetPositions ; 85/D42B

          .al
          .xl
          .autsiz
          .databank `aOptionsWindowTempMenuLine

          ; Resets the positions of various options window
          ; variables.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #aOptionsWindowActions.Default
          sta wOptionsWindowActionIndex

          stz wOptionsWindowMenuLineIndex
          stz wOptionsMenuMenuLineOffset
          stz wOptionsWindowScrolledLines
          stz wOptionsWindowCursorYPosition
          stz wOptionsWindowCursorXPosition
          stz wOptionsWindowScrollPixels

          lda #1
          sta wOptionsWindowColorModifiedFlag

          rts

          .databank 0

        rsOptionsWindowSetShading ; 85/D44A

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Sets the shading regions for the options window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          jsl rlUnknown8593AD
          jsl rlUnknown859132

          lda #pack([0, MiddleRegion.Position[1]])
          sta wR0
          lda #pack([0, MiddleRegion.Size[1]])
          sta wR1
          jsr rsUnknown859273

          lda #pack([0, BottomRegion.Position[1]])
          sta wR0
          lda #pack([0, BottomRegion.Size[1]])
          sta wR1
          jsr rsUnknown859273

          jsr rsUnknown859166

          jsl rlUnknown8593A6

          rts

          .databank 0

        rsOptionsWindowCreateScrollingArrows ; 85/D474

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Initializes the spinning arrows for the options window.
          ; See rsOptionsWindowToggleScrollingArrows for
          ; controlling whether they're visible.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #(256 / 2) - 8
          sta wR0
          lda #(MiddleRegion.Position[1] * 8) - 1
          sta wR1
          jsl rlCreateDownwardsSpinningArrow

          lda #(256 / 2) - 8
          sta wR0
          lda #((MiddleRegion.Position[1] + MiddleRegion.Size[1] - 1) * 8) + 1
          sta wR1
          jsl rlCreateUpwardsSpinningArrow

          rts

          .databank 0

        rsOptionsWindowGetMaxScrollDistance ; 85/D491

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Gets the maximum scrollable distance for the options window.
          ; This gets the distance from the bottom of the `Configuration` label
          ; window to the pixel to scroll to when entering the tint options.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; wOptionsWindowMaxScrollDistance: distance in pixels

          lda wOptionsMenuMenuLineOffset
          lsr a

          ; We want to display 3 lines of the normal set of options.

          sec
          sbc #3

          sta wR10
          lda #(3 * 8)
          sta wR11
          jsl rlUnsignedMultiply16By16

          ; We move down a tile so there's a tile gap between the
          ; `Default` tint setting and the subtitle window.

          lda wR12
          clc
          adc #8
          sta wOptionsWindowMaxScrollDistance

          rts

          .databank 0

        rsOptionsWindowDrawBackground ; 85/D4AE

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Draws the background of the options window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #(`$9E8500)<<8
          sta lR18+size(byte)
          lda #<>$9E8500
          sta lR18

          lda #(`aBGPaletteBuffer.aPalette3)<<8
          sta lR19+size(byte)
          lda #<>aBGPaletteBuffer.aPalette3
          sta lR19

          lda #4 * size(Palette)
          sta lR20

          jsl rlBlockCopy

          lda #<>aGenericBG1TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b
          lda #>`aGenericBG1TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

          lda lWindowBackgroundPatternPointer
          sta lR18
          lda lWindowBackgroundPatternPointer+size(byte)
          sta lR18+size(byte)

          lda #TilemapEntry(0, 2, false, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          jsl rlDrawWindowBackgroundFromTilemapInfo

          rts

          .databank 0

        rsOptionsWindowCopyMenuLinePointers ; 85/D4EC

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Builds aOptionsWindowMenuLinePointers from
          ; aOptionsWindowLinePointers.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; aOptionsWindowMenuLinePointers: filled with short pointers to lines

          lda #<>aOptionsWindowLinePointers
          sta lR25
          lda #>`aOptionsWindowLinePointers
          sta lR25+size(byte)

          stz wR17

          -
            lda lR25+size(byte)
            sta lR18+size(byte)

            ; Check if we've hit the end.

            lda [lR25]
            beq _End

              sta lR18
              jsr rsOptionsWindowCopyTempLine

              ; If the line has some kind of condition that needs
              ; to be met to be usable, check it.

              lda aOptionsWindowTempMenuLine.Usability
              beq _Usable

                sta wR0

                pea #<>(+)-1
                jmp (wR0)

                +
                bcc _Next

              _Usable
                ldx wR17
                lda [lR25]
                sta aOptionsWindowMenuLinePointers,x

                .rept size(addr)
                  inc x
                .endrept

                stx wR17

                .rept size(addr)
                  inc wOptionsMenuMenuLineOffset
                .endrept

              _Next

              .rept size(addr)
                inc lR25
              .endrept

              bra -

          _End

          ; Cap the list.

          ldx wR17

          lda #0
          sta aOptionsWindowMenuLinePointers,x

          rts

          .databank 0

        rsOptionsWindowCopyTempLine ; 85/D534

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Copies a menu line into a temp buffer.

          ; Inputs:
          ; lR18: long pointer to structOptionsWindowLine

          ; Outputs:
          ; aOptionsWindowTempMenuLine: filled with structOptionsWindowLine

          phb

          ldx lR18
          ldy #<>aOptionsWindowTempMenuLine
          lda #size(structOptionsWindowLine)-1
          mvn #`aOptionsWindowLines,#`aOptionsWindowTempMenuLine

          plb
          rts

          .databank 0

        rsOptionsWindowClearTilemaps ; 85/D542

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Clears the tilemaps for the options window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          sep #$20

          .for _Layer in [bBufferBG2SC, bBufferBG3SC]

            lda _Layer
            and #~BGSC_Size
            ora #BGSC_32x64
            sta _Layer

          .endfor

          rep #$30

          _BG3BaseTile := BG3MenuTilesBaseTile + C2I((15, 5))
          _BG2BaseTile := BG2Base + C2I((15, 47))

          .for _Buffer, _BaseTile in [(aBG3TilemapBuffer, _BG3BaseTile), (aBG2TilemapBuffer, _BG2BaseTile)]

            .for _Slice in [(0, 0), (32, 32)]

              lda #<>_Buffer + (_Slice[0] * _Slice[1] * size(word))
              sta wR0
              lda #TilemapEntry(_BaseTile, 0, false, false, false)
              jsl rlFillTilemapByWord

            .endfor

          .endfor

          stz [wBufferBG1HOFS, wBufferBG1VOFS, wBufferBG2HOFS, wBufferBG2VOFS, wBufferBG3HOFS, wBufferBG3VOFS]

          rts

          .databank 0

        rsOptionsWindowSetScrollingInfo ; 85/D593

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Sets the limits for how the options window can scroll.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #7
          sta wMenuBottomThreshold

          stz wMenuLineScrollCount
          stz wOptionsWindowMenuLineIndex

          lda #-1
          sta wOptionsWindowMenuLineFromIndex

          stz wOptionsWindowScrolledLines

          lda wOptionsMenuMenuLineOffset
          lsr a

          inc a
          inc a
          inc a
          inc a

          sta wMenuMaximumLine

          stz wMenuMinimumLine

          lda #1
          sta wMenuUpScrollThreshold

          lda #5
          sta wMenuDownScrollThreshold

          rts

          .databank 0

      endCode
      startData

        aOptionsWindowLineNamePositions .byte MiddleRegion.NamePositions ; 85/D5C3

        aOptionsWindowLineOptionsPositions .byte MiddleRegion.OptionPositions ; 85/D5DB

        aOptionsWindowUnknown85D5F3 .block ; 85/D5F3
          .for _y in iter.map(iter.snd, MiddleRegion.NamePositions)
            .word _y * 8
          .endfor
        .endblock

        aOptionsWindowIconTilemapOffsets .block ; 85/D60B
          .for _Coords in MiddleRegion.IconPositions
            .word C2I(_Coords, 32) * size(word)
          .endfor
        .endblock

      endData
      startCode

        rsOptionsWindowDrawLines ; 85/D623

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Draws a line to the option window.

          ; Inputs:
          ; aOptionsWindowMenuLinePointers: filled with short pointers to lines

          ; Outputs:
          ; A: packed coordinates of the next line
          ; wOptionsWindowTempTextCoordinates: packed coordinates of the next line

          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b
          lda #>`aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

          stz wR17

          -
            lda #>`(*)
            sta lR18+size(byte)

            ; Check if we've hit the end.

            ldx wR17
            lda aOptionsWindowMenuLinePointers,x
            beq +

              sta lR18
              jsr rsOptionsWindowCopyTempLine
              jsr rsOptionsWindowDrawLineName
              jsr rsOptionsWindowDrawLineOptions
              jsr rsOptionsWindowDrawLineIcon

              ldx wR17
              jsr rsOptionsWindowSetLineOptionsStartingColors

              .rept size(addr)
                inc wR17
              .endrept

              bra -

          +
          lda wOptionsWindowTempTextCoordinates
          and #pack((0, $FF))
          clc
          adc #pack([0, MiddleRegion.LineHeight])
          sta wOptionsWindowTempTextCoordinates

          rts

          .databank 0

        rsOptionsWindowDrawLineName ; 85/D664

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Draws a menu line's name to the options window.

          ; Inputs:
          ; aOptionsWindowTempMenuLine: filled with structOptionsWindowLine

          ; Outputs:
          ; None

          lda aOptionsWindowTempMenuLine.NameText
          sta lR18

          lda #TilemapEntry(BG3MenuTilesBaseTile, TextWhite, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          ldx wR17
          lda aOptionsWindowLineNamePositions,x
          tax
          stx wOptionsWindowTempTextCoordinates
          jsl rlDrawMenuText

          rts

          .databank 0

        rsOptionsWindowDrawLineOptions ; 85/D67E

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Draws a menu line's options to the options window.

          ; Inputs:
          ; aOptionsWindowTempMenuLine: filled with structOptionsWindowLine

          ; Outputs:
          ; None

          lda aOptionsWindowTempMenuLine.OptionText
          sta lR18

          lda #TilemapEntry(BG3MenuTilesBaseTile, TextGray, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          ldx wR17
          lda aOptionsWindowLineOptionsPositions,x
          tax
          jsl rlDrawMenuText

          rts

          .databank 0

        rsOptionsWindowDrawLineIcon ; 85/D695

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Draws a menu line's icon to the options window.

          ; Inputs:
          ; aOptionsWindowTempMenuLine: filled with structOptionsWindowLine

          ; Outputs:
          ; None

          ldx wR17
          lda aOptionsWindowIconTilemapOffsets,x
          tax
          lda aOptionsWindowTempMenuLine.IconVRAM
          jsr rsOptionsWindowDrawLineIconTilemap

          rts

          .databank 0

        rsOptionsWindowDrawLineIconTilemap ; 85/D6A3

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Writes the tilemap for a menu line's icon to the tilemap buffer.

          ; Inputs:
          ; A: base tile
          ; X: offset into aBGB2TilemapBuffer

          ; Outputs:
          ; None

          sta aBG2TilemapBuffer+(C2I((0, 0), 32) * size(word)),x
          inc a
          sta aBG2TilemapBuffer+(C2I((1, 0), 32) * size(word)),x

          clc
          adc #(16 - 1)

          sta aBG2TilemapBuffer+(C2I((0, 1), 32) * size(word)),x
          inc a
          sta aBG2TilemapBuffer+(C2I((1, 1), 32) * size(word)),x

          rts

          .databank 0

        rsOptionsWindowSetLineOptionsStartingColors ; 85/D6B6

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Sets the starting colors for a menu line's options
          ; based on their settings when you open the menu.

          ; Inputs:
          ; X: offset of line pointer in aOptionsWindowMenuLineSelections

          ; Outputs:
          ; None

          ; Helpers for dealing with the text tilemaps

            _TilemapOffset .sfunction Coords, aBG3TilemapBuffer+(C2I(Coords, 32) * size(word))
            _TME .sfunction Palette, TilemapEntry(0, Palette, false, false, false)

          php

          rep #$30

          ; Start by graying out all of the options.

          jsr _rsSetGray

          ; Get the current selected option and turn it blue.

          lda aOptionsWindowMenuLineSelections,x
          asl a
          asl a

          tay
          lda aOptionsWindowTempMenuLine.Options[0].Position,y
          sta wR0

          lda aOptionsWindowTempMenuLine.Options[0].Width,y
          sta wR1

          jsr _rsSetBlue

          plp
          rts

          .databank 0

          _rsSetGray ; 85/D6D1

            .al
            .xl
            .autsiz
            .databank `wOptionsWindowActionIndex

            ; Sets all of the options for a line as gray.

            ; Inputs:
            ; X: offset of line pointer in aOptionsWindowMenuLineSelections

            ; Outputs:
            ; None

            phx

            lda aOptionsWindowLineOptionsTilemapOffsets,x
            tay

            ldx #MiddleRegion.OptionsWidth - 1

            ; Set the color for all of the options to gray.

            -
              .for _Y in [0, 1]

                lda _TilemapOffset((0, _Y)),y
                ora #_TME(TextGray ^ TextBlue)
                sta _TilemapOffset((0, _Y)),y

              .endfor

              .rept size(word)
                inc y
              .endrept

              dec x
              bpl -

            plx
            rts

            .databank 0

          _rsSetBlue ; 85/D6F3

            .al
            .xl
            .autsiz
            .databank `wOptionsWindowActionIndex

            ; Turns a single option text blue.

            ; Inputs:
            ; X: offset of line pointer in aOptionsWindowMenuLineSelections
            ; wR0: Position in tiles
            ; wR1: Width in tiles

            ; Outputs:
            ; None

            lda wR0
            asl a

            clc
            adc aOptionsWindowLineOptionsTilemapOffsets,x

            tay

            ; Start at the next option - 1

            ldx wR1
            dec x

            -

              .for _Y in [0, 1]

                lda _TilemapOffset((0, _Y)),y
                and #~_TME(TextGray ^ TextBlue)
                sta _TilemapOffset((0, _Y)),y

              .endfor

              .rept size(word)
                inc y
              .endrept

              dec x

              bpl -

            rts

            .databank 0

      endCode
      startData

        aOptionsWindowLineOptionsTilemapOffsets .block ; 85/D717
          .for _Coords in MiddleRegion.OptionPositions
            .word C2I(_Coords, 32) * size(word)
          .endfor
        .endblock

        aOptionsWindowTintTextLines .block ; 85/D72F

          _T .sfunction Palette, TilemapEntry(BG3MenuTilesBaseTile, Palette, true, false, false)

          aName    .structOptionsWindowTintTextLine MiddleRegion.TintNamePosition,    aOptionsWindowTintTextLines._T(TextWhite), menutextOptionsWindowTintName
          aUpper   .structOptionsWindowTintTextLine MiddleRegion.UpperTextPosition,   aOptionsWindowTintTextLines._T(TextWhite), menutextOptionsWindowTintUpper
          aLower   .structOptionsWindowTintTextLine MiddleRegion.LowerTextPosition,   aOptionsWindowTintTextLines._T(TextWhite), menutextOptionsWindowTintLower
          aDefault .structOptionsWindowTintTextLine MiddleRegion.DefaultTextPosition, aOptionsWindowTintTextLines._T(TextGray),  menutextOptionsWindowTintDefault

          .word 0
        .endblock

      endData
      startMenuText

        .enc "SJIS"

        menutextOptionsWindowTintName    .text "ウィンドウカラー\n" ; 85/D749
        menutextOptionsWindowTintUpper   .text "上設定\n" ; 85/D75B
        menutextOptionsWindowTintLower   .text "下設定\n" ; 85/D763
        menutextOptionsWindowTintDefault .text "デフォルト\n" ; 85/D76B

      endMenuText
      startCode

        rsOptionsWindowDrawTintLines ; 85/D777

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Draws the icon and text for the tint options.

          ; Inputs:
          ; A: packed coordinates of next menu line

          ; Outputs:
          ; None

          ; Start by drawing the icon.

          lsr a
          lsr a

          clc
          adc #pack(MiddleRegion.TintIconPosition) * size(word)

          tax

          _BaseTile := VRAMToTile(TintIconTilesPosition, BG2Base, size(Tile4bpp))

          lda #TilemapEntry(_BaseTile, 6, true, false, false)
          jsr rsOptionsWindowDrawLineIconTilemap
          jsr rsOptionsWindowSetTintLineYCoordinates

          ; Then, draw all of the text.

          stz wR17

          -
            lda #>`aOptionsWindowTintTextLines
            sta lR18+size(byte)
            ldx wR17
            lda aOptionsWindowTintTextLines,x
            beq +

              clc
              adc wOptionsWindowTempTextCoordinates
              pha

              .rept size(structOptionsWindowTintTextLine.Coordinates)
                inc x
              .endrept

              lda aOptionsWindowTintTextLines,x
              sta aCurrentTilemapInfo.wBaseTile,b

              .rept size(structOptionsWindowTintTextLine.BaseTile)
                inc x
              .endrept

              lda aOptionsWindowTintTextLines,x
              sta lR18

              .rept size(structOptionsWindowTintTextLine.TextPointer)
                inc x
              .endrept

              stx wR17

              plx
              jsl rlDrawMenuText

              bra -

          +
          rts

          .databank 0

        rsOptionsWindowSetTintLineYCoordinates ; 85/D7B8

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Sets the Y coordinates for tint sliders and
          ; default tint text.

          ; Inputs:
          ; wOptionsWindowTempTextCoordinates: packed coordinates

          ; Outputs:
          ; None

          lda wOptionsWindowTempTextCoordinates
          xba

          sta aOptionsWindowUpperColorSliderYCoordinates.wRed

          inc a
          sta aOptionsWindowUpperColorSliderYCoordinates.wGreen

          inc a
          sta aOptionsWindowUpperColorSliderYCoordinates.wBlue

          inc a
          inc a
          sta aOptionsWindowLowerColorSliderYCoordinates.wRed

          inc a
          sta aOptionsWindowLowerColorSliderYCoordinates.wGreen

          inc a
          sta aOptionsWindowLowerColorSliderYCoordinates.wBlue

          inc a
          inc a
          sta wOptionsWindowLowerColorDefaultYCoordinate

          rts

          .databank 0

        rsOptionsWindowDrawBorders ; 85/D7DA

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; This draws the border tiles for the options window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          php

          sep #$20

          lda #32
          sta aActiveMenuTemp.BG3Info.Size.W

          ; I don't know of a good way to express this.

          lda wOptionsWindowTempTextCoordinates.Y
          clc
          adc #17
          sta aActiveMenuTemp.BG3Info.Size.H

          stz aActiveMenuTemp.BG3Info.Destination.Hi+size(byte)

          rep #$30

          lda #(`None)<<8
          sta aActiveMenuTemp.BG3Info.Destination
          lda #<>None
          sta aActiveMenuTemp.BG3Info.Destination+size(byte)

          lda #<>aBG3TilemapBuffer
          sta aActiveMenuTemp.BG3Info.Source
          lda #>`aBG3TilemapBuffer
          sta aActiveMenuTemp.BG3Info.Source+size(byte)

          lda #(`aActiveMenuTemp.BG3Info)<<8
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
          lda #<>aActiveMenuTemp.BG3Info
          sta aCurrentTilemapInfo.lInfoPointer,b

          lda #<>aStandardMenuBorders
          sta lR18
          lda #>`aStandardMenuBorders
          sta lR18+size(byte)

          lda #TilemapEntry(0, 0, false, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          jsl rlDrawWindowBordersFromTilemapInfo

          ; The bottom section, too.

          lda #<>_TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b
          lda #>`_TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

          lda #<>aStandardMenuBorders
          sta lR18
          lda #>`aStandardMenuBorders
          sta lR18+size(byte)

          lda #TilemapEntry(0, 0, false, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          jsl rlDrawWindowBordersFromTilemapInfo

          plp
          rts

          _TilemapInfo .structTilemapInfo BottomRegion.Size, None, aBG3TilemapBuffer + (C2I((0, 64 - BottomRegion.Size[1]), 32) * size(word))

          .databank 0

        rsOptionsWindowDrawConfigurationLabel ; 85/D853

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; This draws the `Configuration` graphic tilemap to the options window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          _BaseTile := VRAMToTile(ColorSliderTilesPosition, BG2Base, size(Tile4bpp))

          lda #TilemapEntry(_BaseTile, 0, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          lda #<>$F4F100 + (C2I((26, 8), 32) * size(word))
          sta lR18
          lda #>`$F4F100 + (C2I((26, 8), 32) * size(word))
          sta lR18+size(byte)
          lda #5
          sta wR0
          lda #2
          sta wR1
          lda #<>aBG2TilemapBuffer + (C2I((6, 1), 32) * size(word))
          sta lR19
          jsl rlDrawTilemapPackedRect

          lda #<>$F4F100 + (C2I((26, 10), 32) * size(word))
          sta lR18
          lda #>`$F4F100 + (C2I((26, 10), 32) * size(word))
          sta lR18+size(byte)
          lda #5
          sta wR0
          lda #2
          sta wR1
          lda #<>aBG2TilemapBuffer + (C2I((11, 1), 32) * size(word))
          sta lR19
          jsl rlDrawTilemapPackedRect

          rts

          .databank 0

        rsOptionsWindowDrawTintSlidersAndLabelsTilemap ; 85/D894

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; This draws the tilemaps for the tint sliders and
          ; their `R`, `G`, and `B` labels.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #<>$F4F100 + (C2I((26, 0), 32) * size(word))
          sta lR18
          lda #>`$F4F100 + (C2I((26, 0), 32) * size(word))
          sta lR18+size(byte)
          lda #1
          sta wR0
          lda #7
          sta wR1
          lda wOptionsWindowTempTextCoordinates

          xba

          inc a

          .rept 6
            asl a
          .endrept

          sta wOptionsWindowSliderBarTilemapBufferBase

          clc
          adc #C2I((0, 1), 32)

          clc
          adc #<>aBG2TilemapBuffer

          sta lR19

          _BaseTile := VRAMToTile(ColorSliderTilesPosition, BG2Base, size(Tile4bpp))

          lda #TilemapEntry(_BaseTile, 3, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b
          jsl rlDrawTilemapPackedRect

          jsr rsOptionsWindowDrawAllTintSliderTilemaps

          rts

          .databank 0

      endCode
      startData

        aOptionsWindowTintSliderTilemapOffsets .block ; 85/D8CE
          .for _i in iter.reversed(range(24))
            .word C2I(((_i % 2) * 13, _i / 2), 32) * size(word)
          .endfor
          .word C2I(((0 % 2) * 13, 0 / 2), 32) * size(word)
        .endblock

        aOptionsWindowTintSliderBufferOffsets .block ; 85/D900
          .for _y_base in [0, 4]
            .for _y in range(3)
              .word C2I((17, _y_base + _y), 32) * size(word)
            .endfor
          .endfor
        .endblock

        aOptionsWindowTintSliderBaseTiles .block ; 85/D90C
          _BaseTile := VRAMToTile(ColorSliderTilesPosition, BG2Base, size(Tile4bpp))
          .for _ in range(2)
            .for _Palette in range(3, 6)
              .word TilemapEntry(_BaseTile, _Palette, false, false, false)
            .endfor
          .endfor
        .endblock

      endData
      startCode

        rsOptionsWindowDrawAllTintSliderTilemaps ; 85/D918

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Draws the tilemaps for all of the tint sliders.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #>`$F4F100
          sta lR18+size(byte)
          stz wR17

          -
          jsr rsOptionsWindowDrawTintSliderTilemap

          lda wR17

          .rept size(word)
            inc a
          .endrept

          sta wR17

          cmp #6 * size(word)
          bne -

          rts

          .databank 0

        rsOptionsWindowDrawTintSliderTilemap ; 85/D92E

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Draws the tilemap for a single tint slider.

          ; Inputs:
          ; wR17: offset into aCurrentWindowColors

          ; Outputs:
          ; None

          ldx wR17
          lda aCurrentWindowColors,x
          asl a
          tax
          lda aOptionsWindowTintSliderTilemapOffsets,x
          clc
          adc #<>$F4F100
          sta lR18

          ldx wR17

          lda aOptionsWindowTintSliderBaseTiles,x
          sta aCurrentTilemapInfo.wBaseTile,b

          lda aOptionsWindowTintSliderBufferOffsets,x
          clc
          adc #<>aBG2TilemapBuffer
          clc
          adc wOptionsWindowSliderBarTilemapBufferBase
          sta lR19

          lda #13
          sta wR0

          lda #1
          sta wR1

          jsl rlDrawTilemapPackedRect

          rts

          .databank 0

        rsOptionsWindowSetHDMA ; 85/D965

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Creates the HDMA array entries for the options window.
          ; This handles BG 2 and 3 vertical scrolling
          ; along with which layers should be enabled for each scanline.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #(`aOptionsWindowBGVOFSHDMATable)<<8
          sta lR18+size(byte)
          lda #<>aOptionsWindowBGVOFSHDMATable
          sta lR18

          lda #(`aOptionsWindowScrollPositionsHDMA)<<8
          sta lR19+size(byte)
          lda #<>aOptionsWindowScrollPositionsHDMA
          sta lR19

          lda #13
          sta lR20

          jsl rlBlockCopy

          _HDMAEntries := [aOptionsWindowBG2VOFSHDMAInfo, aOptionsWindowBG3VOFSHDMAInfo, aOptionsWindowTMHDMAInfo]

          .for _i, _Entry in iter.enumerate(_HDMAEntries, 3)

            lda #<>_Entry
            sta lR44
            lda #>`_Entry
            sta lR44+size(byte)

            lda #_i
            sta wR40

            jsl rlHDMAArrayEngineCreateEntryByIndex

          .endfor

          rts

          .databank 0

      endCode
      startData

        aOptionsWindowTMHDMAInfo .structHDMADirectEntryInfo rlOptionsWindowTMHDMADummy, rlOptionsWindowTMHDMADummy, aOptionsWindowTMHDMACode, aOptionsWindowTMHDMATable, TM, DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Fixed1, DMAP_Mode0) ; 85/D9BC

      endData
      startCode

        rlOptionsWindowTMHDMADummy ; 85/D9C7

          .autsiz
          .databank ?

          rtl

          .databank 0

      endCode
      startData

        aOptionsWindowTMHDMACode .block ; 85/D9C8

          HDMA_HALT

        .endblock

        aOptionsWindowTMHDMATable .block ; 85/D9CA

          .byte NTRL_Setting(31, false)
          .byte T_Setting(true, true, true, false, true)

          .byte NTRL_Setting(1, false)
          .byte T_Setting(false, true, true, false, true)

          .byte NTRL_Setting(64, false)
          .byte T_Setting(true, true, true, false, true)

          .byte NTRL_Setting(95, false)
          .byte T_Setting(true, true, true, false, true)

          .byte NTRL_Setting(1, false)
          .byte T_Setting(false, false, true, false, true)

          .byte NTRL_Setting(32, false)
          .byte T_Setting(true, true, true, false, false)

          .byte 0

        .endblock

        aOptionsWindowBG2VOFSHDMAInfo .structHDMADirectEntryInfo rlOptionsWindowBG2VOFSHDMADummy, rlOptionsWindowBG2VOFSHDMADummy, aOptionsWindowBG2VOFSHDMACode, aOptionsWindowScrollPositionsHDMA, BG2VOFS, DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Fixed1, DMAP_Mode2) ; 85/D9D7

      endData
      startCode

        rlOptionsWindowBG2VOFSHDMADummy ; 85/D9E2

          .autsiz
          .databank ?

          rtl

          .databank 0

      endCode
      startData

        aOptionsWindowBG2VOFSHDMACode .block ; 85/D9E3

          HDMA_HALT

        .endblock

        aOptionsWindowBG3VOFSHDMAInfo .structHDMADirectEntryInfo rlOptionsWindowBG3VOFSHDMADummy, rlOptionsWindowBG3VOFSHDMADummy, aOptionsWindowBG3VOFSHDMACode, aOptionsWindowScrollPositionsHDMA, BG3VOFS, DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Fixed1, DMAP_Mode2) ; 85/D9E5

      endData
      startCode

        rlOptionsWindowBG3VOFSHDMADummy ; 85/D9F0

          .autsiz
          .databank ?

          rtl

          .databank 0

      endCode
      startData

        aOptionsWindowBG3VOFSHDMACode .block ; 85/D9F1

          HDMA_HALT

        .endblock

        aOptionsWindowBGVOFSHDMATable .block ; 85/D9F3

          .byte NTRL_Setting(32, false)
          .sint 0

          .byte NTRL_Setting(80, false)
          .sint 0

          .byte NTRL_Setting(80, false)
          .sint 0

          .byte NTRL_Setting(32, false)
          .sint 288

          .byte 0

        .endblock

      endData
      startCode

        rsOptionsWindowUpdateScrolling ; 85/DA00

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; This is the main updating routine for the
          ; options window. It handles input checking,
          ; draws the subtitle, renders cursors, and begins
          ; scrolling if needed.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          jsr rsOptionsWindowHandleInput

          ; If we moved, queue up scrolling.

          lda wMenuLineScrollCount
          cmp wOptionsWindowScrolledLines
          beq +

            lda #aOptionsWindowActions.Scroll
            sta wOptionsWindowActionIndex

            lda #$0004
            sta wOptionsWindowScrollTimer

          +

          jsr rsOptionsWindowDrawSubtitle

          lda wOptionsWindowMenuLineIndex
          sta wOptionsWindowMenuLineFromIndex

          ; If we hit the end of the normal lines, we must
          ; be scrolling onto the tint stuff.

          lda wOptionsWindowMenuLineIndex
          asl a
          tax
          lda aOptionsWindowMenuLinePointers,x
          bne +

            lda #aOptionsWindowActions.ColorScrollMain
            sta wOptionsWindowActionIndex

            stz wOptionsWindowMenuLineIndex

            jsl rlClearJoypadInputs

            jmp rsOptionsWindowDoColorScrollStep

          +

          ; Otherwise we're still on a normal line.

          jsr rsOptionsWindowRenderCursors

          lda wMenuLineScrollCount
          cmp wOptionsWindowScrolledLines
          beq +

            jmp rsOptionsWindowDoScrollStep

          +
          rts

          .databank 0

        rsOptionsWindowHandleInput ; 85/DA49

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; This handles inputs on the options window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          pea #<>_Return - 1

          lda wJoy1Repeated

          _HeldInputs  := [(JOY_Up,    _Up)]
          _HeldInputs ..= [(JOY_Down,  _Down)]
          _HeldInputs ..= [(JOY_Left,  _Left)]
          _HeldInputs ..= [(JOY_Right, _Right)]

          .for _Pressed, _Handler in _HeldInputs[:-1]

            bit #_Pressed
            bne _Handler

          .endfor

          bit #_HeldInputs[-1][0]
          beq +

            jmp _HeldInputs[-1][1]

          +

          lda wJoy1New

          _NewInputs  := [(JOY_B, _B)]
          _NewInputs ..= [(JOY_Y, rsOptionsWindowRestoreLastSaveSettings)]

          .for _Pressed, _Handler in _NewInputs

            bit #_Pressed
            beq +

              jmp _Handler

            +

          .endfor

          rts

          .databank 0

          _Return ; 85/DA78

            .al
            .xl
            .autsiz
            .databank `wOptionsWindowActionIndex

            rts

          _Up ; 85/DA79

            .al
            .xl
            .autsiz
            .databank `wOptionsWindowActionIndex

            ; Pressing up tries to scroll upward.

            lda wOptionsWindowMenuLineIndex
            cmp #1
            bne +

              stz wOptionsWindowScrollPixels

            +
            lda wOptionsWindowMenuLineIndex
            jsl rlMenuTryScrollUp
            bcc +

              sta wOptionsWindowMenuLineIndex

              lda #$0009 ; TODO: sound effects
              jsl rlPlaySoundEffect

            +
            rts

            .databank 0

          _Down ; 85/DA98

            .al
            .xl
            .autsiz
            .databank `wOptionsWindowActionIndex

            ; Pressing down tries to scroll downward.

            lda wOptionsWindowMenuLineIndex
            jsl rlMenuTryScrollDown
            bcc +

              sta wOptionsWindowMenuLineIndex

              lda #$0009 ; TODO: sound effects
              jsl rlPlaySoundEffect

            +
            rts

            .databank 0

          _Left ; 85/DAAC

            .al
            .xl
            .autsiz
            .databank `wOptionsWindowActionIndex

            ; Pressing `Left` tries to select the next option to
            ; the left.

            lda wOptionsWindowMenuLineIndex
            asl a
            tax
            lda aOptionsWindowMenuLinePointers,x
            sta lR18
            jsr rsOptionsWindowCopyTempLine

            lda wOptionsWindowMenuLineIndex
            asl a
            tax

            lda aOptionsWindowMenuLineSelections,x
            beq +

              dec aOptionsWindowMenuLineSelections,x
              bra _UpdateLineColors

            +
            rts

            .databank 0

          _Right ; 85/DAC9

            .al
            .xl
            .autsiz
            .databank `wOptionsWindowActionIndex

            ; Pressing `Right` tries to select the next option to
            ; the right.

            lda wOptionsWindowMenuLineIndex
            asl a
            tax
            lda aOptionsWindowMenuLinePointers,x
            sta lR18
            jsr rsOptionsWindowCopyTempLine

            lda wOptionsWindowMenuLineIndex
            asl a
            tax
            lda aOptionsWindowMenuLineSelections,x
            inc a
            cmp aOptionsWindowTempMenuLine.OptionCount
            bge +

              inc aOptionsWindowMenuLineSelections,x
              bra _UpdateLineColors

            +
            rts

          _UpdateLineColors ; 85/DAEA

            .al
            .xl
            .autsiz
            .databank `wOptionsWindowActionIndex

            lda aOptionsWindowMenuLineSelections,x
            pha

            jsr rsOptionsWindowSetLineOptionsStartingColors
            jsr rsOptionsWindowCopyLineTextTilemap

            pla
            jsr rsOptionWindowUpdateWindowTiles

            lda #$000A ; TODO: sound effects
            jsl rlPlaySoundEffect

            rts

            .databank 0

          _B ; 85/DB00

            .al
            .xl
            .autsiz
            .databank `wOptionsWindowActionIndex

            ; Pressing `B` closes the menu.

            jsl rlSaveCurrentColorSetting

            lda #4
            sta wJoyRepeatInterval

            phx

            lda #(`procOptionsWindowCloseCleanup)<<8
            sta lR44+size(byte)
            lda #<>procOptionsWindowCloseCleanup
            sta lR44
            jsl rlProcEngineCreateProc

            plx

            lda #$0021 ; TODO: sound effects
            jsl rlPlaySoundEffect

            lda #<>rsPostBMenuWindowCallback
            sta aProcSystem.wInput0,b

            lda #(`procFadeWithCallback)<<8
            sta lR44+size(byte)
            lda #<>procFadeWithCallback
            sta lR44
            jsl rlProcEngineCreateProc

            lda #aOptionsWindowActions.Close
            sta wOptionsWindowActionIndex

            rts

            .databank 0

        rsOptionsWindowActionClose ; 85/DB3B

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          rts

          .databank 0

      endCode
      startProcs

        procOptionsWindowCloseCleanup .structProcInfo None, rlProcOptionsWindowCloseCleanupInit, rlProcOptionsWindowCloseCleanupOnCycle, None ; 85/DB3C

      endProcs
      startCode

        rlProcOptionsWindowCloseCleanupInit ; 85/DB44

          .al
          .xl
          .autsiz
          .databank ?

          rtl

          .databank 0

        rlProcOptionsWindowCloseCleanupOnCycle ; 85/DB45

          .al
          .xl
          .autsiz
          .databank ?

          lda #<>rlProcOptionsWindowCloseCleanupOnCycle2
          sta aProcSystem.aHeaderOnCycle,b,x

          rtl

          .databank 0

        rlProcOptionsWindowCloseCleanupOnCycle2 ; 85/DB4C

          .al
          .xl
          .autsiz
          .databank ?

          ; This proc OnCycle routine handles copying all of
          ; the options from their temporary options window
          ; versions to the actual variables.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          php
          phb

          sep #$20

          lda #`aOptionsWindowTempMenuLine.OnClose
          pha

          rep #$20

          plb

          .databank `aOptionsWindowTempMenuLine.OnClose

          phx

          lda #<>aOptionsWindowTempMenuLine.OnClose
          jsr rsOptionsWindowRunAllOptionsCopiers

          plx

          jsl rlProcEngineFreeProc
          plb
          plp
          rtl

          .databank 0

        rsOptionsWindowRenderCursors ; 85/DB65

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda #112
          sta wR0

          lda wOptionsWindowActionIndex
          cmp #aOptionsWindowActions.Scroll
          beq _Moving

            lda wOptionsWindowMenuLineIndex
            asl a
            tax
            lda aOptionsWindowMenuLineSelections,x

            asl a
            asl a

            tax
            lda aOptionsWindowTempMenuLine.Options[0].Position,x

            clc
            adc #MiddleRegion.OptionOffset[0] - 2

            asl a
            asl a
            asl a
            sta wR0
            sta wOptionsWindowCursorXPosition

            lda wOptionsWindowMenuLineIndex
            asl a

            clc
            adc wOptionsWindowMenuLineIndex

            clc
            adc #MiddleRegion.OptionOffset[1]

            asl a
            asl a
            asl a

            dec a
            dec a
            sta wR1

            sec
            sbc wOptionsWindowScrollPixels
            sta wR1

            sta wOptionsWindowCursorYPosition
            jsl rlDrawRightFacingCursor

            lda #8
            sta wR0
            lda wOptionsWindowCursorYPosition
            sta wR1
            jsl rlDrawRightFacingStaticCursorHighPrio

            rts

          _Moving

            lda wOptionsWindowCursorXPosition
            sta wR0
            lda wOptionsWindowCursorYPosition
            sta wR1
            jsl rlDrawRightFacingCursor

            lda #8
            sta wR0
            lda wOptionsWindowCursorYPosition
            sta wR1
            jsl rlDrawRightFacingStaticCursorHighPrio

            rts

          .databank 0

        rsOptionsWindowSetScrollingCursorXPosition ; 85/DBD8

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; This sets the option selection cursor's X position
          ; while the screen is scrolling.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda wOptionsWindowMenuLineIndex
          asl a

          tax
          lda aOptionsWindowMenuLineSelections,x

          asl a
          asl a

          tax
          lda aOptionsWindowTempMenuLine.Options[0].Position,x

          clc
          adc #MiddleRegion.OptionOffset[0] - 2

          asl a
          asl a
          asl a

          sta wOptionsWindowCursorXPosition

          rts

          .databank 0

        rsOptionsWindowDoScrollStep ; 85/DBF1

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Handles scrolling for the main menu lines.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          jsr rsOptionsWindowSetScrollingCursorXPosition
          jsr rsOptionsWindowRenderCursors

          lda wOptionsWindowScrolledLines
          sec
          sbc wMenuLineScrollCount
          bmi _ScrollDown

            lda #4 * size(addr)
            jsl rlSetUpScrollingArrowSpeed

            lda wOptionsWindowScrollPixels
            sec
            sbc #6
            sta wOptionsWindowScrollPixels

          bra +

          _ScrollDown

            lda #4 * size(addr)
            jsl rlSetDownScrollingArrowSpeed

            lda wOptionsWindowScrollPixels
            clc
            adc #6
            sta wOptionsWindowScrollPixels

          +
          dec wOptionsWindowScrollTimer
          beq +

            rts

          +
          lda #1 * size(addr)
          jsl rlSetUpScrollingArrowSpeed

          lda #1 * size(addr)
          jsl rlSetDownScrollingArrowSpeed

          lda wMenuLineScrollCount
          sta wOptionsWindowScrolledLines

          jmp rsOptionsWindowGetNextAction

          .databank 0

        rsOptionsWindowDrawSubtitle ; 85/DC41

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Draws the subtitle text for the current option.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda wOptionsWindowMenuLineIndex
          cmp wOptionsWindowMenuLineFromIndex
          bne +

            rts

          +
          lda wOptionsWindowActionIndex
          cmp #aOptionsWindowActions.ColorDefault
          bne _Normal

            ldx wOptionsWindowMenuLineIndex
            lda aOptionsWindowColorSubtitlePointers,x
            sta aOptionsWindowTempMenuLine.SubtitleText
            bra +

          _Normal

            lda wOptionsWindowMenuLineIndex
            asl a
            tax
            lda aOptionsWindowMenuLinePointers,x
            sta lR18
            jsr rsOptionsWindowCopyTempLine

          +

          _BaseCoordinates := (0, 64) - (0, BottomRegion.Size[1]) + BottomRegion.SubtitleOffset

          lda #<>aBG3TilemapBuffer + (C2I(_BaseCoordinates, 32) * size(word))
          sta wR0
          lda #29
          sta wR1
          lda #2
          sta wR2

          lda #TilemapEntry(BG3MenuTilesBaseTile + C2I((15, 5)), 0, false, false, false)
          jsl rlFillTilemapRectByWord

          lda #<>rsOptionsWindowDrawBorders._TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b
          lda #>`rsOptionsWindowDrawBorders._TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

          lda #TilemapEntry(BG3MenuTilesBaseTile, 0, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          lda #>`(*)
          sta lR18+size(byte)
          lda aOptionsWindowTempMenuLine.SubtitleText
          sta lR18
          jsl rlGetMenuTextWidth

          sta wR0
          lda #32
          sec
          sbc wR0
          lsr a
          clc
          adc #pack([0, 1])
          tax
          jsl rlDrawMenuText

          jsl rlDMAByStruct

            .structDMAToVRAM aBG3TilemapBuffer + (C2I((0, 64) - (0, BottomRegion.Size[1]) + BottomRegion.SubtitleOffset - (1, 0), 32) * size(word)), (32 * 2 * size(word)), VMAIN_Setting(true), BG3TilemapPosition + ((29 + 32) * 32 * size(word))

          rts

          .databank 0

      endCode
      startProcs

        procOptionsWindowColorSliderManager .structProcInfo None, rlProcOptionsWindowColorSliderManagerInit, rlProcOptionsWindowColorSliderManagerOnCycle, None ; 85/DCC1

      endProcs
      startCode

        rlProcOptionsWindowColorSliderManagerInit ; 85/DCC9

          .al
          .xl
          .autsiz
          .databank ?

          ; Sets the base coordinates for the color sliders.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php
          phb

          sep #$20

          lda #`wOptionsWindowTempTextCoordinates
          pha

          rep #$20

          plb

          .databank `wOptionsWindowTempTextCoordinates

          lda wOptionsWindowTempTextCoordinates
          xba
          inc a
          asl a
          asl a
          asl a
          sta aOptionsWindowUpperColorSliderYCoordinatesPixels.wRed

          clc
          adc #8
          sta aOptionsWindowUpperColorSliderYCoordinatesPixels.wGreen

          clc
          adc #8
          sta aOptionsWindowUpperColorSliderYCoordinatesPixels.wBlue

          clc
          adc #16
          sta aOptionsWindowLowerColorSliderYCoordinatesPixels.wRed

          clc
          adc #8
          sta aOptionsWindowLowerColorSliderYCoordinatesPixels.wGreen

          clc
          adc #8
          sta aOptionsWindowLowerColorSliderYCoordinatesPixels.wBlue

          plb
          plp
          rtl

          .databank 0

        rlProcOptionsWindowColorSliderManagerOnCycle ; 85/DD04

          .al
          .xl
          .autsiz
          .databank ?

          ; Renders the color slider handles.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php
          phb

          sep #$20

          lda #`wOptionsWindowTempTextCoordinates
          pha

          rep #$20
          plb

          .databank `wOptionsWindowTempTextCoordinates

          phx

          _C     := aCurrentWindowColors
          _Upper := aOptionsWindowUpperColorSliderYCoordinatesPixels
          _Lower := aOptionsWindowLowerColorSliderYCoordinatesPixels

          _Sliders  := [(_Upper.wRed,   _C.wUpperRed)]
          _Sliders ..= [(_Upper.wGreen, _C.wUpperGreen)]
          _Sliders ..= [(_Upper.wBlue,  _C.wUpperBlue)]
          _Sliders ..= [(_Lower.wRed,   _C.wLowerRed)]
          _Sliders ..= [(_Lower.wGreen, _C.wLowerGreen)]
          _Sliders ..= [(_Lower.wBlue,  _C.wLowerBlue)]

          .for _Y, _Value in _Sliders

            lda _Y
            sta wR1
            lda _Value
            jsr rsOptionsWindowRenderColorSlider

          .endfor

          plx
          plb
          plp
          rtl

          .databank 0

        rsOptionsWindowRenderColorSlider ; 85/DD55

          .al
          .xl
          .autsiz
          .databank `aOptionsWindowUpperColorSliderYCoordinatesPixels

          ; Render a single color slider handle.

          ; Inputs:
          ; A: Intensity
          ; wR1: Y coordinate

          ; Outputs:
          ; None

          phb
          php

          phk
          plb

          .databank `*

          asl a
          tax
          lda _XOffsets,x
          sta wR0

          lda wR1
          sec
          sbc wOptionsWindowScrollPixels
          sta wR1

          stz wR4
          stz wR5
          ldy #<>_Sprite
          jsl rlPushToOAMBuffer

          plp
          plb
          rts

          _Sprite .dstruct structSpriteArray, [[(134, -1), $00, SpriteSmall, $113, 3, 4, false, false]]

          _XOffsets .word iter.reversed(range(25)) * 4

          .databank 0

        rsOptionsWindowUpdateColorBarTilemap ; 85/DDB0

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Updates the tilemap for a tint
          ; color bar.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #>`aBG2TilemapBuffer
          sta lR18+size(byte)

          ldx wOptionsWindowMenuLineIndex
          lda wOptionsWindowTempTextCoordinates

          xba
          inc a
          asl a
          asl a
          asl a
          asl a
          asl a
          sta wR1

          asl a
          clc
          adc _BufferPositions,x
          sta lR18

          lda wR1
          clc
          adc _VRAMPositions,x
          sta wR1

          lda #3 * 32 * size(word)
          sta wR0

          jsl rlDMAByPointer
          rts

          _BufferPositions .for _VerticalOffset in [0, 4] ; 85/DDDF

            .for _Color in range(3)

              .word <>aBG2TilemapBuffer + (_VerticalOffset * 32 * size(word))

            .endfor

          .endfor

          _VRAMPositions .for _VerticalOffset in [0, 4] ; 85/DDEB

            .for _Color in range(3)

              .word (BG2TilemapPosition + (_VerticalOffset * 32 * size(word))) >> 1

            .endfor

          .endfor

          .databank 0

        rsOptionsWindowUpdateColorAllBarTilemaps ; 85/DDF7

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Updates the tilemaps for all of the color sliders.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #>`aBG2TilemapBuffer
          sta lR18+size(byte)

          lda wOptionsWindowTempTextCoordinates
          xba
          inc a
          asl a
          asl a
          asl a
          asl a
          asl a

          sta wR1
          asl a
          clc
          adc #<>aBG2TilemapBuffer
          sta lR18

          lda wR1
          clc
          adc #BG2TilemapPosition >> 1
          sta wR1

          lda #7 * 32 * size(word)
          sta wR0

          jsl rlDMAByPointer

          rts

          .databank 0

        rsOptionsWindowDoColorScrollStep ; 85/DE21

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Handles scrolling onto the color slider section.
          ; If we're done scrolling, it wraps up and runs the
          ; updater.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #8
          jsl rlSetDownScrollingArrowSpeed

          jsr rsOptionsWindowRenderScrollingColorCursors

          ; Scroll until our next scroll step would be
          ; past the desired distance.

          lda wOptionsWindowScrollPixels
          clc
          adc #6
          cmp wOptionsWindowMaxScrollDistance
          beq +
          bge ++

          +
            sta wOptionsWindowScrollPixels
            rts

          +

          ; 

          lda wOptionsWindowMaxScrollDistance
          sta wOptionsWindowScrollPixels

          lda wOptionsMenuMenuLineOffset
          lsr a
          sec
          sbc #3
          sta wMenuLineScrollCount
          sta wOptionsWindowScrolledLines

          lda #aOptionsWindowActions.ColorDefault
          sta wOptionsWindowActionIndex

          _FinishedScrolling

          lda #2
          sta wJoyRepeatInterval

          lda #aOptionsWindowActions.ColorDefault
          sta wOptionsWindowActionIndex

          lda #2
          jsl rlSetDownScrollingArrowSpeed

        rsOptionsWindowDoColorUpdate ; 85/DE69

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; This handles updating the menu while in the
          ; color slider section.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsr rsOptionsWindowDrawSubtitle

          lda wOptionsWindowMenuLineIndex
          sta wOptionsWindowMenuLineFromIndex

          jsr rsOptionsWindowRenderColorCursors
          jsr rsOptionsWindowColorsHandleInput

          rts

          .databank 0

        rsOptionsWindowRenderColorCursors ; 85/DE79

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Renders the cursors while on the color slider section.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          ldx wOptionsWindowMenuLineIndex

          lda aOptionsWindowUpperColorSliderYCoordinates,x
          asl a
          asl a
          asl a
          sec
          sbc wOptionsWindowScrollPixels
          sta wR1

          lda #112
          sta wR0

          jsl rlDrawRightFacingCursor

          lda #8
          sta wR0

          lda aOptionsWindowUpperColorSliderYCoordinates
          asl a
          asl a
          asl a
          sec
          sbc wOptionsWindowScrollPixels

          dec a
          dec a
          sta wR1

          jsl rlDrawRightFacingStaticCursorHighPrio

          rts

          .databank 0

        rsOptionsWindowColorsHandleInput ; 85/DEA9

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Like rsOptionsWindowHandleInput but
          ; for when in the color slider section.

          pea #<>_End - 1

          ; Handle held inputs.

          lda wJoy1Repeated

          _RepeatedInputs  := [(JOY_Left,  _Left)]
          _RepeatedInputs ..= [(JOY_Right, _Right)]
          _RepeatedInputs ..= [(JOY_L,     _L)]
          _RepeatedInputs ..= [(JOY_R,     _R)]
          _RepeatedInputs ..= [(JOY_Down,  _Down)]
          _RepeatedInputs ..= [(JOY_Up,    _Up)]

          ; In case our handler is out of conditional branch range.

          .for _ButtonCombination, _Handler in _RepeatedInputs

            bit #_ButtonCombination

            .if (abs(_Handler - *) >= 127)

              beq +

                jmp _Handler

              +

            .else

              bne _Handler

            .endif

          .endfor

          ; And then handle strictly-new inputs.

          lda wJoy1New

          _NewInputs  := [(JOY_B, rsOptionsWindowHandleInput._B)]
          _NewInputs ..= [(JOY_A, _A)]
          _NewInputs ..= [(JOY_Y, rsOptionsWindowRestoreLastSaveSettings)]

          .for _ButtonCombination, _Handler in _NewInputs

            bit #_ButtonCombination
            beq +

              jmp _Handler

            +

          .endfor

          _End
          rts

          _Down ; 85/DEF3

            lda wOptionsWindowMenuLineIndex

            cmp #12
            beq +

              .rept size(word)
                inc a
              .endrept

              sta wOptionsWindowMenuLineIndex

              lda #$0009 ; TODO: sound definitions
              jsl rlPlaySoundEffect

            +
            rts

          _Up ; 85/DF08

            .rept size(word)
              dec wOptionsWindowMenuLineIndex
            .endrept

            bmi +

              lda #$0009 ; TODO: sound definitions
              jsl rlPlaySoundEffect

              rts

            +
            lda #4
            sta wJoyRepeatInterval

            lda wOptionsMenuMenuLineOffset
            lsr a
            dec a
            sta wOptionsWindowMenuLineIndex

            lda #aOptionsWindowActions.Default
            sta wOptionsWindowActionIndex

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect
            rts

          _A ; 85/DF33

            lda wOptionsWindowMenuLineIndex
            cmp #12
            bne +

              lda wOptionsWindowColorModifiedFlag
              beq _Default

            +
              rts

            _Default

              jsl rlGetDefaultColorSetting
              jsl rlSaveCurrentColorSetting

              jsr rsOptionsWindowDrawAllTintSliderTilemaps
              jsr rsOptionsWindowUpdateColorAllBarTilemaps
              jsr rsOptionsWindowSetShading

              lda #$000D ; TODO: sound definitions
              jsl rlPlaySoundEffect

              rts

          _Right ; 85/DF5A

            ldx wOptionsWindowMenuLineIndex
            cpx #12
            beq +

            lda aCurrentWindowColors,x
            beq +

              dec aCurrentWindowColors,x

              jsr rsOptionsWindowDrawAllTintSliderTilemaps
              jsr rsOptionsWindowUpdateColorBarTilemap
              jsr rsOptionsWindowSetShading

              lda #$000A ; TODO: sound definitions
              jsl rlPlaySoundEffect

            +
            rts

          _Left ; 85/DF7B

            ldx wOptionsWindowMenuLineIndex
            cpx #12
            beq +

            lda aCurrentWindowColors,x
            cmp #24
            beq +

              inc aCurrentWindowColors,x

              jsr rsOptionsWindowDrawAllTintSliderTilemaps
              jsr rsOptionsWindowUpdateColorBarTilemap
              jsr rsOptionsWindowSetShading

              lda #$000A ; TODO: sound definitions
              jsl rlPlaySoundEffect

            +
            rts

          _L ; 85/DF9F

            ldx wOptionsWindowMenuLineIndex
            cpx #12
            beq +

              lda #1
              sta wR0

              lda #24
              sta wR1

              jsr rsOptionsWindowShiftColorBarGroup
              jsr rsOptionsWindowDrawAllTintSliderTilemaps
              jsr rsOptionsWindowUpdateColorBarTilemap
              jsr rsOptionsWindowSetShading

              lda #$000A ; TODO: sound definitions
              jsl rlPlaySoundEffect

            +
            rts

          _R ; 85/DFC5

            ldx wOptionsWindowMenuLineIndex
            cpx #12
            beq +

              lda #-1
              sta wR0

              lda #0
              sta wR1

              jsr rsOptionsWindowShiftColorBarGroup
              jsr rsOptionsWindowDrawAllTintSliderTilemaps
              jsr rsOptionsWindowUpdateColorBarTilemap
              jsr rsOptionsWindowSetShading

              lda #$000A ; TODO: sound definitions
              jsl rlPlaySoundEffect

            +
            rts

          .databank 0

        rsOptionsWindowShiftColorBarGroup ; 85/DFEB

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Shifts all of the color sliders for a group.

          ; Inputs:
          ; wR0: increment value
          ; wR1: bound

          ; Outputs:
          ; None

          ldx wOptionsWindowMenuLineIndex
          lda _Offsets,x

          tax
          jsr rsOptionsWindowShiftColorBar
          jsr rsOptionsWindowShiftColorBar
          jsr rsOptionsWindowShiftColorBar

          rts

          _Offsets .word ([aCurrentWindowColors.wUpperRed - aCurrentWindowColors] x 3) .. ([aCurrentWindowColors.wLowerRed - aCurrentWindowColors] x 3)

          .databank 0

        rsOptionsWindowShiftColorBar ; 85/E009

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Shifts a single color bar slider.

          ; Inputs:
          ; X: offset of group from aCurrentWindowColors
          ; wR0: increment value
          ; wR1: bound

          ; Outputs:
          ; None

          ; Nothing to do if we've hit the bound.

          lda aCurrentWindowColors,x
          cmp wR1
          beq +

            ; Otherwise, increment.

            clc
            adc wR0
            sta aCurrentWindowColors,x

          +

          ; Move to the next color

          .rept size(word)
            inc x
          .endrept

          rts

          .databank 0

        rsOptionsWindowRenderScrollingColorCursors ; 85/E019

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Renders the cursors when scrolling onto the
          ; color slider section.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wOptionsMenuMenuLineOffset
          lsr a
          asl a
          asl a
          asl a
          sta wR0

          asl a
          clc
          adc wR0

          clc
          adc #40

          sec
          sbc wOptionsWindowScrollPixels

          cmp #160
          blt +

            lda #160

          +
          sta wR1
          lda #112
          sta wR0
          jsl rlDrawRightFacingCursor

          lda #8
          sta wR0
          dec wR1
          dec wR1
          jsl rlDrawRightFacingStaticCursorHighPrio

          rts

          .databank 0

        rsOptionsWindowToggleScrollingArrows ; 85/E04F

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Handles what scrolling arrows should be visible.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          ; If we're at the top of the screen, we
          ; don't want the upward arrow.

          ldx #0

          lda wOptionsWindowScrollPixels
          cmp wOptionsWindowMaxScrollDistance
          bne +

            dec x

          +
          txa
          jsl rlToggleUpwardsSpinningArrow

          ; If we're at the bottom of the screen, we don't
          ; want the downward facing arrow.

          ldx #0

          lda wOptionsWindowActionIndex

          cmp #aOptionsWindowActions.Default
          beq +

          cmp #aOptionsWindowActions.Close
          beq +

            bra ++

          +

          lda wMenuLineScrollCount
          bne +

            dec x

          +
          txa
          jsl rlToggleDownwardsSpinningArrow
          rts

          .databank 0

        rsOptionsWindowCopyLineTextTilemap ; 85/E07E

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; DMAs the tilemap for a line of text.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #>`aBG3TilemapBuffer
          sta lR18+size(byte)

          lda wOptionsWindowMenuLineIndex
          asl a
          tax
          lda aOptionsWindowLineNamePositions,x

          xba
          and #$00FF
          asl a
          asl a
          asl a
          asl a
          asl a

          pha

          asl a

          clc
          adc #<>aBG3TilemapBuffer

          sta lR18

          pla

          clc
          adc #BG3TilemapPosition >> 1
          sta wR1

          lda #2 * 32 * size(word)
          sta wR0

          jsl rlDMAByPointer

          rts

          .databank 0

        rsOptionsWindowUpdateColorDefaultTextColor ; 85/E0AE

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Tries to update the color of the `Default` color option.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsl rlCheckColorSettingModified
          bcs +

            lda #0
            bra ++

          +
            lda #-1

          +
          cmp wOptionsWindowColorModifiedFlag
          bne +

            rts

          +
          sta wOptionsWindowColorModifiedFlag

          inc a
          asl a
          tax
          lda _Palettes,x
          sta wR0

          lda wOptionsWindowTempTextCoordinates
          xba
          clc
          adc #8

          asl a
          asl a
          asl a
          asl a
          asl a
          pha

          clc
          adc #16

          asl a
          tax

          ldy #4

          -
            lda aBG3TilemapBuffer,x
            and #~TM_Palette
            ora wR0
            sta aBG3TilemapBuffer,x

            lda aBG3TilemapBuffer+(C2I((0, 1), 32) * size(word)),x
            and #~TM_Palette
            ora wR0
            sta aBG3TilemapBuffer+(C2I((0, 1), 32) * size(word)),x

            .rept size(word)
              inc x
            .endrept

            dec y

            bpl -

          lda #$01,s

          clc
          adc #BG3TilemapPosition >> 1
          sta wR1

          lda #2 * 32 * size(word)
          sta wR0

          lda #>`aBG3TilemapBuffer
          sta lR18+size(byte)

          pla
          asl a
          clc
          adc #<>aBG3TilemapBuffer
          sta lR18

          jsl rlDMAByPointer

          rts

          _TME .sfunction Palette, TilemapEntry(0, Palette, false, false, false)
          _Palettes .word _TME(3), _TME(2)

          .databank 0

        rsOptionsWindowRunAllOptionsCopiers ; 85/E123

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Runs all of either the getters or setters
          ; for all of the menu lines.

          ; Inputs:
          ; A: offset into aOptionsWindowTempMenuLine of the
          ;   getter/setter pointer

          ; Outputs:
          ; None

          sta wR16

          stz wR17

          -
            ldx wR17

            lda aOptionsWindowMenuLinePointers,x
            sta lR18

            jsr rsOptionsWindowCopyTempLine

            ldx wR16

            lda 0,b,x
            sta wR0

            ldx wR17

            pea #<>(+)-1
            jmp (wR0)

            +
            .rept size(addr)
              inc wR17
            .endrept

            lda wR17
            cmp wOptionsMenuMenuLineOffset
            bne -

          rts

          .databank 0

        ; All of the getters and setters here work the same way:

        ; The getters write their setting from aOptions into
        ; aOptionsWindowMenuLineSelections in order of their
        ; positions in aOptionsWindowLinePointers

        ; The setters do the opposite: they write from
        ; aOptionsWindowMenuLineSelections into aOptions.

        rsOptionsWindowGetAnimationSetting ; 85/E14C

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptions.wAnimation
          sta aOptionsWindowMenuLineSelections,x
          rts

          .databank 0

        rsOptionsWindowGetTerrainWindowSetting ; 85/E153

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptions.wTerrainWindow
          sta aOptionsWindowMenuLineSelections,x
          rts

          .databank 0

        rsOptionsWindowGetBurstWindowSetting ; 85/E15A

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptions.wBurstWindow
          sta aOptionsWindowMenuLineSelections,x
          rts

          .databank 0

        rsOptionsWindowGetTextSpeedSetting ; 85/E161

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptions.wTextSpeed
          sta aOptionsWindowMenuLineSelections,x
          rts

          .databank 0

        rsOptionsWindowGetUnitSpeedSetting ; 85/E168

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptions.wUnitSpeed
          sta aOptionsWindowMenuLineSelections,x
          rts

          .databank 0

        rsOptionsWindowGetSoundSetting ; 85/E16F

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptions.wSound
          sta aOptionsWindowMenuLineSelections,x
          rts

          .databank 0

        rsOptionsWindowGetBGMSetting ; 85/E176

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptions.wBGM
          sta aOptionsWindowMenuLineSelections,x
          rts

          .databank 0

        rsOptionsWindowGetVolumeSetting ; 85/E17D

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptions.wVolume
          sta aOptionsWindowMenuLineSelections,x
          rts

          .databank 0

        rsOptionsWindowGetAutocursorSetting ; 85/E184

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptions.wAutocursor
          sta aOptionsWindowMenuLineSelections,x
          rts

          .databank 0

        rsOptionsWindowGetWindowSetting ; 85/E18B

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptions.wBackground
          sta aOptionsWindowMenuLineSelections,x
          rts

          .databank 0

        rsOptionsWindowSetAnimationSetting ; 85/E192

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptionsWindowMenuLineSelections,x
          sta aOptions.wAnimation
          rts

          .databank 0

        rsOptionsWindowSetTerrainWindowSetting ; 85/E199

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptionsWindowMenuLineSelections,x
          sta aOptions.wTerrainWindow
          rts

          .databank 0

        rsOptionsWindowSetBurstWindowSetting ; 85/E1A0

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptionsWindowMenuLineSelections,x
          sta aOptions.wBurstWindow
          rts

          .databank 0

        rsOptionsWindowSetTextSpeedSetting ; 85/E1A7

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptionsWindowMenuLineSelections,x
          sta aOptions.wTextSpeed
          rts

          .databank 0

        rsOptionsWindowSetUnitSpeedSetting ; 85/E1AE

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptionsWindowMenuLineSelections,x
          sta aOptions.wUnitSpeed
          rts

          .databank 0

        rsOptionsWindowSetSoundSetting ; 85/E1B5

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptionsWindowMenuLineSelections,x
          sta aOptions.wSound
          rts

          .databank 0

        rsOptionsWindowSetBGMSetting ; 85/E1BC

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptionsWindowMenuLineSelections,x
          sta aOptions.wBGM
          rts

          .databank 0

        rsOptionsWindowSetVolumeSetting ; 85/E1C3

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptionsWindowMenuLineSelections,x
          sta aOptions.wVolume
          rts

          .databank 0

        rsOptionsWindowSetAutocursorSetting ; 85/E1CA

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptionsWindowMenuLineSelections,x
          sta aOptions.wAutocursor
          rts

          .databank 0

        rsOptionsWindowSetWindowSetting ; 85/E1D1

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          lda aOptionsWindowMenuLineSelections,x
          sta aOptions.wBackground
          rts

          .databank 0

        rlOptionsWindowUpdateSoundSystem ; 85/E1D8

          .al
          .xl
          .autsiz
          .databank ?

          ; Handles configuring the sound system's
          ; volume levels and BGM based on selected options.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php
          phb

          sep #$20

          lda #`aOptions
          pha

          rep #$20

          plb

          .databank `aOptions

          lda aOptions.wSound
          beq _SoundEnabled

            lda aSoundSystem.wStatus,b
            ora #$0040 ; TODO: sound system status
            sta aSoundSystem.wStatus,b

            bra +

          _SoundEnabled
            lda aSoundSystem.wStatus,b
            and #~$0040 ; TODO: sound system status
            sta aSoundSystem.wStatus,b

          +
          lda aOptions.wBGM
          beq _BGMEnabled

            lda aSoundSystem.wStatus,b
            ora #$0010 ; TODO: sound system status
            sta aSoundSystem.wStatus,b

            bra +

          _BGMEnabled
            lda aSoundSystem.wStatus,b
            and #~$0010 ; TODO: sound system status
            sta aSoundSystem.wStatus,b

          +
          lda aOptions.wVolume
          cmp #3
          beq _Muted

          asl a
          tax
          lda _VolumeSounds,x
          jsl rlPlaySoundEffectForced

          lda aSoundSystem.wStatus,b
          and #~($0001 | $0004) ; TODO: sound system status
          sta aSoundSystem.wStatus,b

          plb
          plp
          rtl

          _VolumeSounds .word $FFD4, $C0D4, $80D4 ; TODO: sound definitions

          _Muted

          lda aSoundSystem.wStatus,b
          ora #($0001 | $0004) ; TODO: sound system status
          sta aSoundSystem.wStatus,b

          plb
          plp
          rtl

          .databank 0

        rsOptionWindowUpdateWindowTiles ; 85/E244

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; If the current line is the background setting,
          ; update our background tiles.

          ; Inputs:
          ; aOptionsWindowTempMenuLine: current line

          ; Outputs:
          ; None

          ldx aOptionsWindowTempMenuLine.OnOpen
          cpx #<>rsOptionsWindowGetWindowSetting
          bne +

            pha

            jsl rlSaveCurrentColorSetting

            pla

            sta aOptions.wBackground

            jsl rlGetCurrentColorSetting
            jsl rlGetCurrentBackgroundSetting
            jsr rsOptionsWindowDrawAllTintSliderTilemaps
            jsr rsOptionsWindowUpdateColorAllBarTilemaps
            jsr rsOptionsWindowSetShading

          +
          rts

          .databank 0

        rsOptionsWindowGetLastSaveSettings ; 85/E267

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Fetches the options from the last saved file.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda aSRAM.aSaveDataHeader.LastFile
          and #$00FF
          jsl rlGetSaveSlotOffset

          ldx wSaveSlotOffset,b

          _SD := structSaveDataEntry.Options
          _WL := aOptionsWindowLinePointers

          _O2S .sfunction Option, aOptionsWindowMenuLineSelections + (Option - aOptionsWindowLinePointers)

          _Options  := [(_SD.AnimationSetting,  _O2S(_WL.wAnimation))]
          _Options ..= [(_SD.TerrainSetting,    _O2S(_WL.wTerrainWindow))]
          _Options ..= [(_SD.BurstSetting,      _O2S(_WL.wUnitWindow))]
          _Options ..= [(_SD.TextSpeedSetting,  _O2S(_WL.wTextSpeed))]
          _Options ..= [(_SD.UnitSpeedSetting,  _O2S(_WL.wUnitSpeed))]
          _Options ..= [(_SD.SoundSetting,      _O2S(_WL.wAudio))]
          _Options ..= [(_SD.BGMSetting,        _O2S(_WL.wBGM))]
          _Options ..= [(_SD.AutocursorSetting, _O2S(_WL.wAutocursor))]
          _Options ..= [(_SD.Volume,            _O2S(_WL.wVolume))]

          .for _SaveOffset, _Option in _Options

            lda aSRAM + _SaveOffset,x
            sta _Option

          .endfor

          rts

          .databank 0

        rsOptionsWindowRestoreLastSaveSettings ; 85/E2B5

          .al
          .xl
          .autsiz
          .databank `wOptionsWindowActionIndex

          ; Fetches the settings from the last saved game
          ; and updates all of the options to match it.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsr rsOptionsWindowGetLastSaveSettings
          jsr rsOptionsWindowDrawLines

          ; Don't change the color settings.

          lda #aOptionsWindowActions.Default
          cmp wOptionsWindowActionIndex
          bne +

            lda wOptionsWindowMenuLineIndex
            asl a
            tax
            lda aOptionsWindowMenuLinePointers,x
            sta lR18
            jsr rsOptionsWindowCopyTempLine

          +
          jsl rlDMAByStruct

            .dstruct structDMAToVRAM, (aBG3TilemapBuffer + (MiddleRegion.Base[1] * 32 * size(word))), ((MiddleRegion.LineCount - 2) * MiddleRegion.LineHeight * 32 * size(word)), VMAIN_Setting(true), (BG3TilemapPosition + MiddleRegion.Base[1] * 32 * size(word))

          lda #$0021 ; TODO: sound definitions
          jsl rlPlaySoundEffect

          ply
          rts

          .databank 0

      endCode

      .endwith

    .endsection OptionsWindowSection

.endif ; GUARD_FE5_OPTIONS_WINDOW
