
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_SHOP_WINDOW :?= false
.if (!GUARD_FE5_SHOP_WINDOW)
  GUARD_FE5_SHOP_WINDOW := true

  ; Definitions

    .weak

      rlPlaySoundEffect                         :?= address($808C87)
      rlCopyExpandedCharacterDataBufferToBuffer :?= address($83905C)
      rlDMAByStruct                             :?= address($80AE2E)
      rlAppendDecompList                        :?= address($80B00A)
      rlBlockCopy                               :?= address($80B340)
      rlBlockORRWord                            :?= address($80B3D1)
      rlFillTilemapByWord                       :?= address($80E89F)
      rlEnableBG1Sync                           :?= address($81B1FA)
      rlEnableBG3Sync                           :?= address($81B212)
      rlDrawItemInfo                            :?= address($81F590)
      rlProcEngineCreateProc                    :?= address($829BF1)
      rlProcEngineFindProc                      :?= address($829CEC)
      rlHDMAArrayEngineCreateEntryByIndex       :?= address($82A470)
      rlHDMAEngineFreeEntryByIndex              :?= address($82A495)
      rlCopyCharacterDataFromBuffer             :?= address($839041)
      rlGetItemNamePointer                      :?= address($83931A)
      rlCheckItemEquippable                     :?= address($83965E)
      rlPushToQueue                             :?= address($8397E8)
      rlPopFromQueue                            :?= address($839808)
      rlTryGiveCharacterItemFromBuffer          :?= address($83A443)
      rlSellCharacterItemFromBuffer             :?= address($83A4FD)
      rlSubtractFromGold                        :?= address($83A568)
      rlCanPlayerAffordCost                     :?= address($83A58A)
      rlCopyItemDataToBuffer                    :?= address($83B00D)
      rsRenderSheetIconByTileIndex              :?= address($83C671)
      rlConvertNumberToBCD                      :?= address($85870E)
      rlDrawNumberMenuTextFromBCD               :?= address($8587D0)
      rlDrawItemCurrentDurability               :?= address($858921)
      rlDrawRightFacingCursor                   :?= address($859013)
      rlDrawRightFacingStaticCursorHighPrio     :?= address($8590CF)
      rlCopyDialogueBoxResources                :?= address($8598C1)
      rlDrawMenuText                            :?= address($87E728)
      rlClearIconArray                          :?= address($8A8060)
      rlDrawSingleIcon                          :?= address($8A8085)
      rlRenderSheetIconSprites                  :?= address($8A8126)
      rlPlayMenuCloseSound                      :?= address($8AC48E)
      rlTryGetShopInventoryPointer              :?= address($8C9D7F)
      rlDrawPortraitManual                      :?= address($8CBF25)
      rlDrawShopDialogueText                    :?= address($94CBA2)
      rlProcFadeSetStep                         :?= address($94DA10)
      rlProcFadeInByStep                        :?= address($94DA22)
      rlUnknown9592FB                           :?= address($9592FB)

      menutextQuadrupleDash :?= address($81D285)

      aShopWindowArmoryBottomPalette :?= address($9E86A6)
      aShopWindowArmoryTopPalette    :?= address($9E86C6)
      aShopWindowVendorBottomPalette :?= address($9E86E6)
      aShopWindowVendorTopPalette    :?= address($9E8706)

      g4bppcShopWindowArmoryTiles  :?= address($9E9000)
      acShopWindowArmoryBG2Tilemap :?= address($9E9443)
      g4bppcShopWindowVendorTiles  :?= address($9E9508)
      acShopWindowVendorBG2Tilemap :?= address($9E9AA0)
      acShopWindowBG3Tilemap       :?= address($9E9B36)

      aGenericBG3TilemapInfo :?= address($83C0F6)

      procFadeWithCallback :?= address($82A1BB)
      proczm               :?= address($85992D)
      procDialogue94CBC2   :?= address($94CBC2)
      procDialogue94CCDF   :?= address($94CCDF)

      dialogueShopBuySell       :?= address($8AB3D6)
      dialogueShopYesNo         :?= address($8AB3E2)
      dialogueArmoryIntro       :?= address($8AB3EC)
      dialogueVendorIntro       :?= address($8AB40B)
      dialogueShopContinue      :?= address($8AB42A)
      dialogueShopBuyIntro      :?= address($8AB438)
      dialogueShopPostBuy       :?= address($8AB443)
      dialogueShopNoItemsToSell :?= address($8AB455)
      dialogueShopSellIntro     :?= address($8AB464)
      dialogueShopPostSell      :?= address($8AB476)
      dialogueShopCannotAfford  :?= address($8AB482)
      dialogueShopBuyConfirm    :?= address($8AB490)
      dialogueShopSellConfirm   :?= address($8AB49F)
      dialogueShopLeave         :?= address($8AB4A9)
      dialogueShopUnsellable    :?= address($8AB4B7)
      dialogueShopInventoryFull :?= address($8AB4CE)

      TextWhite := 0
      TextBrown := 1
      TextBlue  := 2
      TextGray  := 3

    .endweak

    macroShopTextEnd .segment
      .word 0
    .endsegment

    macroShopText .segment TextPointer, Coordinates, VRAMPosition, Status=$0000, Instant=false, Delay=0
      .long \TextPointer
      .byte \Coordinates
      .word \VRAMPosition >> 1
      .byte int(\Instant), \Delay
      .word \Status
    .endsegment

    ShopWindowConfig .namespace

      ; VRAM allocation

        ; Base addresses

          OAMBase = $0000
          BG1Base = $4000
          BG2Base = BG1Base
          BG3Base = $A000

          BG1TilemapPosition = $E000
          BG2TilemapPosition = $F000
          ; BG3TilemapPosition = $A000 ; See below

        ; Helpers

          OAMTilesPosition := OAMBase
          OAMAllocate .function Size
            Return := ShopWindowConfig.OAMTilesPosition
            ShopWindowConfig.OAMTilesPosition += Size
          .endfunction Return

          BG12TilesPosition := BG1Base
          BG12Allocate .function Size
            Return := ShopWindowConfig.BG12TilesPosition
            ShopWindowConfig.BG12TilesPosition += Size
          .endfunction Return

          BG3TilesPosition := BG3Base
          BG3Allocate .function Size
            Return := ShopWindowConfig.BG3TilesPosition
            ShopWindowConfig.BG3TilesPosition += Size
          .endfunction Return

        ; BG1/2 allocations

          DialogueBoxSize = 16 * 4 * size(Tile4bpp)
          DialogueBoxPosition = BG12Allocate(DialogueBoxSize)

          BackgroundTilesSize = 16 * 4 * size(Tile4bpp)
          BackgroundTilesPosition = BG12Allocate(BackgroundTilesSize)

          BG1BlankTile = VRAMToTile($9FE0, BG1Base, size(Tile4bpp))

        ; BG3 allocations

          BG3TilemapPosition = BG3Allocate(32 * 32 * size(word))

          _ := BG3Allocate($B800 - BG3TilesPosition)

          BG3MenuTilesPosition = BG3Allocate(16 * 40 * size(Tile2bpp)) ; TODO: menu tiles

          ; Because this gets used so often, we'll calculate
          ; it ahead of time.

          BG3MenuTilesBaseTile = VRAMToTile(BG3MenuTilesPosition, BG3Base, size(Tile2bpp))

          BG3NumberTilesBaseTile = BG3MenuTilesBaseTile+C2I((0, 18))

          BG3BlankTile = TilemapEntry(BG3MenuTilesBaseTile + C2I((15, 5), 16), 0, 0, false, false)

      PrepArmoryItems = [IronSword, IronLance, IronAxe, IronBow]

      TopRegion .namespace

        Origin = (0, 0)
        Size   = (32, 10)

        Portrait .namespace

          Position = Origin + (2, 2)
          ID       = $0088 ; TODO: portrait definitions
          Fade     = false ; warning: `true` breaks
          Slot     = 0

        .endnamespace ; Portrait

        DialogueBox .namespace

          Position = Origin + (9, 1)
          Size     = (23, 8)

          Interior = Position + (2, 1)
          InteriorSize = Size - (3, 2)

          BuySellCursorPositions = [(144, 48), (192, 48)] ; In pixels

          LineCount = 3

          RowBases = iter.map(iter.reversed, iter.zip_single(range(LineCount + 1) * 2, 0))

          LineOffset = Interior + (0, 0)

          ; Helper function
          _AddOffset .sfunction Offset, iter.starmap(op.add, iter.zip_single(RowBases, Offset))

          LinePositions = _AddOffset(LineOffset)

        .endnamespace ; Dialogueox

      .endnamespace ; TopRegion

      BottomRegion .namespace

        Origin = (0, 10)
        Size   = (32, 18)

        ItemBox .namespace

          ItemCount = 7

          Base = Origin + (10, 0)
          Size = (22, 18)

          Interior = Base + (1, 1)

          RowBases = iter.map(iter.reversed, iter.zip_single(range(ItemCount + 1) * 2, 0))

          CursorOffset     = Interior + ( 0,  0) ; Needs to be turned into pixels
          IconOffset       = Interior + ( 2,  0)
          NameOffset       = Interior + ( 4,  0)
          DurabilityOffset = Interior + (13,  0) ; Right-justified
          PriceOffset      = Interior + (19,  0) ; Right-justified

          ; Helper function
          _AddOffset .sfunction Offset, iter.starmap(op.add, iter.zip_single(RowBases, Offset))

          CursorPositions     = _AddOffset(CursorOffset)
          IconPositions       = _AddOffset(IconOffset)
          NamePositions       = _AddOffset(NameOffset)
          DurabilityPositions = _AddOffset(DurabilityOffset)
          PricePositions      = _AddOffset(PriceOffset)

        .endnamespace ; ItemBox

        InfoBox .namespace

          Base = (0, 11)

          InfoPosition = Base + (1, 0)

        .endnamespace ; InfoBox

        GoldBox .namespace

          Base = (0, 24)

          DigitCount = 6

          GoldPosition = Base + (1, 1)

        .endnamespace ; GoldBox

      .endnamespace ; BottomRegion

    .endnamespace ; ShopWindowConfig

  ; Freespace inclusions

    .section ShopWindowSection

      .with ShopWindowConfig

        startCode

          rlShopWindowCheckPrepOnOpen ; 85/9ADB

            .al
            .xl
            .autsiz
            .databank ?

            ; Check if opening the shop from the map,
            ; playing a sound if so.

            ; Inputs:
            ; wPrepScreenFlag: nonzero if prep

            ; Outputs:
            ; carry set if not prep, clear if prep

            php
            phb

            sep #$20

            lda #$7E
            pha

            rep #$20

            plb

            .databank $7E

            lda wPrepScreenFlag,b
            bne _Prep

              lda #$0005 ; TODO: sound definitions
              jsl rlPlaySoundEffect

              plb
              plp

              sec
              rtl

            _Prep

              plb
              plp

              clc
              rtl

            .databank 0

        endCode
        startProcs

          procShopWindow .structProcInfo "sp", None, None, aProcShopWindowCode ; 85/9AF9

          aProcShopWindowCode .block ; 85/9B01

            PROC_CALL rlProcShopWindowDrawShopkeeperPortrait
            PROC_YIELD 10
            PROC_CALL rlProcShopWindowCheckIfPrepStub

            PROC_CALL_ARGS rlProcFadeSetStep, size(+)
            + .block
              .byte 1
            .endblock

            -
            PROC_YIELD 1
            PROC_JUMP_IF_ROUTINE_FALSE -, rlProcFadeInByStep

            PROC_END

          .endblock

          rlProcShopWindowCheckIfPrepStub ; 85/9B1F

            .al
            .xl
            .autsiz
            .databank ?

            ; This seems to have the body of its functionality
            ; removed, so now the only thing it does is play
            ; a sound effect when not opening the shop
            ; from the preop items menu.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            jsl rlShopWindowCheckPrepOnOpen
            bcc +

            +
            rtl

            .databank 0

          rlProcShopWindowDrawShopkeeperPortrait ; 85/9B26

            .al
            .xl
            .autsiz
            .databank ?

            ; Draws the shopkeeper portrait.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            .with TopRegion

            lda #int(Portrait.Fade)
            sta $1836,b ; TODO: this

            lda #pack(Portrait.Position)
            sta wR0

            ldx #Portrait.Slot

            lda #Portrait.ID
            jsl rlDrawPortraitManual

            rtl

            .endwith ; TopRegion

            .databank 0

        endProcs
        startCode

          rsShopWindowIsShopArmory ; 85/9B3C

            .al
            .xl
            .autsiz
            .databank ?

            ; Determines if a shop is a vendor or an
            ; armory. Prep screen shops are always
            ; armories.

            ; This is a very interesting routine, because it's
            ; specifically returning the `zero` flag for whether
            ; the shop is an armory or not.

            ; Inputs:
            ; wPrepScreenFlag: nonzero if prep
            ; wCursorTileIndex: cursor tile index

            ; Outputs:
            ; zero set if armory or prep shop, clear if vendor

            lda wPrepScreenFlag
            bne +

              ldx wCursorTileIndex,b
              lda aTerrainMap,x
              and #$00FF

              cmp #TerrainArmory
              rts

            +
            lda #0
            rts

            .databank 0

        endCode
        startData

          aShopWindowActions .binclude "../TABLES/ShopWindowActions.csv.asm" ; 85/9B54

        endData
        startCode

          rsShopWindowGetNextActionUnknown ; 85/9BA0

            .al
            .xl
            .autsiz
            .databank ?

            jmp rsShopWindowGetNextAction

            .databank 0

          rsShopWindowActionUnknown11 ; 85/9BA3

            .al
            .xl
            .autsiz
            .databank ?

            rtl

            .databank 0

        endCode
        startData

          .with BottomRegion

          aShopWindowItemLineBasePositions .word iter.map(pack, ItemBox.IconPositions) ; 85/9BA4

          aShopWindowItemCursorYPositions .word ItemBox.CursorPositions[:,1] ; 85/9BB4

          .endwith ; BottomRegion

          aShopWindowTextColors .block ; 85/9BC4

            .word TilemapEntry(BG3MenuTilesBaseTile, TextWhite, 1, false, false)
            .word TilemapEntry(BG3MenuTilesBaseTile, TextGray, 1, false, false)
            .word TilemapEntry(BG3MenuTilesBaseTile, TextBrown, 1, false, false)

          .endblock

          aShopWindowNumberColors .block ; 85/9BCA

            .word TilemapEntry(BG3NumberTilesBaseTile, TextBlue, 1, false, false)
            .word TilemapEntry(BG3NumberTilesBaseTile, TextGray, 1, false, false)
            .word TilemapEntry(BG3NumberTilesBaseTile, TextBlue, 1, false, false)

          .endblock

        endData
        startCode

          rsShopWindowCopyVendorResources ; 85/9BD0

            .al
            .xl
            .autsiz
            .databank ?

            ; Copies the palettes, tiles, and tilemaps
            ; for the shop background when the shop is
            ; a vendor.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            lda #(`aShopWindowVendorBottomPalette)<<8
            sta lR18+size(byte)
            lda #<>aShopWindowVendorBottomPalette
            sta lR18
            lda #(`aBGPaletteBuffer.aPalette5)<<8
            sta lR19+size(byte)
            lda #<>aBGPaletteBuffer.aPalette5
            sta lR19
            lda #2 * size(Palette)
            sta lR20
            jsl rlBlockCopy

            lda #(`g4bppcShopWindowVendorTiles)<<8
            sta lR18+size(byte)
            lda #<>g4bppcShopWindowVendorTiles
            sta lR18
            lda #(`aDecompressionBuffer)<<8
            sta lR19+size(byte)
            lda #<>aDecompressionBuffer
            sta lR19
            jsl rlAppendDecompList
            jsl rlDMAByStruct

              .dstruct structDMAToVRAM, aDecompressionBuffer, BackgroundTilesSize, VMAIN_Setting(true), BackgroundTilesPosition

            lda #(`acShopWindowVendorBG2Tilemap)<<8
            sta lR18+size(byte)
            lda #<>acShopWindowVendorBG2Tilemap
            sta lR18
            lda #(`aBG2TilemapBuffer)<<8
            sta lR19+size(byte)
            lda #<>aBG2TilemapBuffer
            sta lR19
            jsl rlAppendDecompList

            lda #(`aBG2TilemapBuffer)<<8
            sta lR18+size(byte)
            lda #<>aBG2TilemapBuffer
            sta lR18
            lda #(64 * 32 * size(word))
            sta lR19
            lda #TilemapEntry(VRAMToTile(BackgroundTilesPosition, BG2Base, size(Tile4bpp)), 0, 1, false, false)
            jsl rlBlockORRWord
            jsl rlDMAByStruct

              .dstruct structDMAToVRAM, aBG2TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

            lda #(`acShopWindowBG3Tilemap)<<8
            sta lR18+size(byte)
            lda #<>acShopWindowBG3Tilemap
            sta lR18
            lda #(`aBG3TilemapBuffer)<<8
            sta lR19+size(byte)
            lda #<>aBG3TilemapBuffer
            sta lR19
            jsl rlAppendDecompList
            jsl rlDMAByStruct

              .dstruct structDMAToVRAM, aBG3TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG3TilemapPosition

            rts

            .databank 0

          rsShopWindowCopyArmoryResources ; 85/9C73

            .al
            .xl
            .autsiz
            .databank ?

            ; Copies the palettes, tiles, and tilemaps
            ; for the shop background when the shop is
            ; an armory.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            lda #(`aShopWindowArmoryBottomPalette)<<8
            sta lR18+size(byte)
            lda #<>aShopWindowArmoryBottomPalette
            sta lR18
            lda #(`aBGPaletteBuffer.aPalette5)<<8
            sta lR19+size(byte)
            lda #<>aBGPaletteBuffer.aPalette5
            sta lR19
            lda #2 * size(Palette)
            sta lR20
            jsl rlBlockCopy

            lda #(`g4bppcShopWindowArmoryTiles)<<8
            sta lR18+size(byte)
            lda #<>g4bppcShopWindowArmoryTiles
            sta lR18
            lda #(`aDecompressionBuffer)<<8
            sta lR19+size(byte)
            lda #<>aDecompressionBuffer
            sta lR19
            jsl rlAppendDecompList
            jsl rlDMAByStruct

              .dstruct structDMAToVRAM, aDecompressionBuffer, BackgroundTilesSize, VMAIN_Setting(true), BackgroundTilesPosition

            lda #(`acShopWindowArmoryBG2Tilemap)<<8
            sta lR18+size(byte)
            lda #<>acShopWindowArmoryBG2Tilemap
            sta lR18
            lda #(`aBG2TilemapBuffer)<<8
            sta lR19+size(byte)
            lda #<>aBG2TilemapBuffer
            sta lR19
            jsl rlAppendDecompList

            lda #(`aBG2TilemapBuffer)<<8
            sta lR18+size(byte)
            lda #<>aBG2TilemapBuffer
            sta lR18
            lda #(64 * 32 * size(word))
            sta lR19
            lda #TilemapEntry(VRAMToTile(BackgroundTilesPosition, BG2Base, size(Tile4bpp)), 0, 1, false, false)
            jsl rlBlockORRWord
            jsl rlDMAByStruct

              .dstruct structDMAToVRAM, aBG2TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

            lda #(`acShopWindowBG3Tilemap)<<8
            sta lR18+size(byte)
            lda #<>acShopWindowBG3Tilemap
            sta lR18
            lda #(`aBG3TilemapBuffer)<<8
            sta lR19+size(byte)
            lda #<>aBG3TilemapBuffer
            sta lR19
            jsl rlAppendDecompList
            jsl rlDMAByStruct

              .dstruct structDMAToVRAM, aBG3TilemapBuffer, (32 * 28 * size(word)), VMAIN_Setting(true), BG3TilemapPosition

            rts

            .databank 0

          rlShopWindowSetupWindow ; 85/9D16

            .al
            .xl
            .autsiz
            .databank ?

            ; Does the bulk of the work assembling the
            ; shop window.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            .with BottomRegion

            php
            phb

            sep #$20

            lda #`aBG1TilemapBuffer
            pha

            rep #$20

            plb

            .databank `aBG1TilemapBuffer

            lda #aShopWindowActions.Default
            sta @l wShopWindowActionIndex

            lda #<>aSelectedCharacterBuffer
            sta wR0
            lda #<>aTemporaryActionStruct
            sta wR1
            jsl rlCopyExpandedCharacterDataBufferToBuffer

            lda #<>aBG1TilemapBuffer
            sta wR0
            lda #TilemapEntry(BG1BlankTile, 0, 0, false, false)
            jsl rlFillTilemapByWord

            jsr rsShopWindowIsShopArmory
            beq _Armory

              ; Otherwise it's a vendor.

              jsr rsShopWindowCopyVendorResources
              bra +

            _Armory

              jsr rsShopWindowCopyArmoryResources

            +
            stz wBufferBG1HOFS
            stz wBufferBG1HOFS
            stz wBufferBG2HOFS
            stz wBufferBG2HOFS

            ; I don't know why this tries to get the
            ; shop's inventory before checking if accessing
            ; the prep screen, for which this always
            ; fails.

            jsl rlTryGetShopInventoryPointer

            lda wPrepScreenFlag,b
            beq +

              lda #<>_PrepItems
              sta lR18
              lda #>`_PrepItems
              sta lR18+size(byte)
              bra +

                endCode
                startData

                _PrepItems .block ; 85/9D6B
                  .union

                    .struct

                      .fill 7 * size(word), 0
                      .word 0

                    .endstruct

                    .cerror len(PrepArmoryItems) > 7

                    .word PrepArmoryItems

                  .endunion
                .endblock

                endData
                startCode

            +
            lda lR18
            sta @l lShopWindowInventoryPointer
            lda lR18+size(byte)
            sta @l lShopWindowInventoryPointer+size(byte)

            jsr rsShopWindowSetHDMA

            lda #0
            sta wR40

            phx

            lda #(`proczm)<<8
            sta lR44+size(byte)
            lda #<>proczm
            sta lR44
            jsl rlProcEngineCreateProc

            plx

            jsl rlEnableBG1Sync
            jsl rlClearIconArray

            stz wBufferBG1VOFS
            stz wBufferBG1HOFS
            stz wBufferBG2VOFS
            stz wBufferBG2HOFS
            stz wBufferBG3VOFS
            stz wBufferBG3HOFS

            jsl rlCopyDialogueBoxResources

            lda #InfoBox.InfoPosition[0]
            sta wR0
            lda #InfoBox.InfoPosition[1]
            sta wR1

            stz wR2
            jsl rlDrawItemInfo

            lda #1
            jsl rlUnknown9592FB

            plb
            plp
            rtl

            .endwith ; BottomRegion

            .databank 0

          rsShopWindowSetHDMA ; 85/9DD1

            .al
            .xl
            .autsiz
            .databank ?

            ; Creates the color gradient for the shop window.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            lda #<>aShopWindowCOLDATAHDMA
            sta lR44
            lda #>`aShopWindowCOLDATAHDMA
            sta lR44+size(byte)

            lda #0
            sta wR40

            jsl rlHDMAArrayEngineCreateEntryByIndex

            rts

            .databank 0

          rsShopWindowClearHDMA ; 85/9DE5

            .al
            .xl
            .autsiz
            .databank ?

            ; Clears the color gradient from the shop window.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            lda #0
            jsl rlHDMAEngineFreeEntryByIndex

            rts

            .databank 0

        endCode
        startData

          aShopWindowCOLDATAHDMA .structHDMAIndirectEntryInfo rlShopWindowCOLDATAHDMAInit, rlShopWindowCOLDATAHDMAOnCycle, aShopWindowCOLDATAHDMACode, aShopWindowCOLDATAHDMATable, COLDATA, DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Fixed1, DMAP_Mode0), `aShopWindowCOLDATAHDMATable ; 85/9DED

        endData
        startCode

          rlShopWindowCOLDATAHDMAInit ; 85/9DF9

            .al
            .xl
            .autsiz
            .databank ?

            sep #$20

            lda #WOBJSEL_Setting(false, false, false, false, true, false, false, false)
            sta bBufferWOBJSEL
            lda #WBGLOG_Setting(WLOG_ORR, WLOG_ORR, WLOG_ORR, WLOG_ORR)
            sta bBufferWBGLOG
            lda #CGWSEL_Setting(false, false, CGWSEL_MathInside, CGWSEL_BlackNever)
            sta bBufferCGWSEL
            lda #CGADSUB_Setting(CGADSUB_Subtract, false, true, true, false, false, false, false)
            sta bBufferCGADSUB

            rep #$20

            lda #pack((0, 255))
            sta bBufferWH0

            rtl

            .databank 0

          rlShopWindowCOLDATAHDMAOnCycle ; 85/9E13

            .al
            .xl
            .autsiz
            .databank ?

            rtl

            .databank 0

        endCode
        startData

          aShopWindowCOLDATAHDMACode .block ; 85/9E14

            HDMA_HALT

          .endblock

          aShopWindowCOLDATAHDMATable .block ; 85/9E16

            TopCounts  := [((TopRegion.Size[1] - 1) * 8) / 6] x 6
            TopCounts ..= [8]

            .for _ScanlineCount, _Intensity in iter.zip(TopCounts, range(7))

              .byte _ScanlineCount, COLDATA_Setting(_Intensity, true, true, true)

            .endfor

            BottomCounts  := [((BottomRegion.Size[1]) * 8) / 7] x 7
            BottomCounts ..= [((BottomRegion.Size[1]) * 8) % 7]

            .for _ScanlineCount, _Intensity in iter.zip(BottomCounts, range(8))

              .byte _ScanlineCount, COLDATA_Setting(_Intensity, true, true, true)

            .endfor

            .byte 0

          .endblock

        endData
        startCode

          rsShopWindowClearDialogueBoxAndDrawGold ; 85/9E35

            .al
            .xl
            .autsiz
            .databank `wShopWindowConfirmOffset

            ; Clears the dialogue box and draws the current
            ; gold value.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            .with TopRegion
            .with BottomRegion

            stz wShopWindowConfirmOffset

            lda #TilemapEntry(BG3MenuTilesBaseTile, TextWhite, 1, false, false)
            sta aCurrentTilemapInfo.wBaseTile,b

            ldx #pack(GoldBox.GoldPosition)

            lda #(`_menutextGoldClearer)<<8
            sta lR18+size(byte)
            lda #<>_menutextGoldClearer
            sta lR18
            jsl rlDrawMenuText
            bra +

              endCode
              startMenuText

              _menutextGoldClearer .block ; 85/9E51
                .enc "SJIS"
                .text "　" x GoldBox.DigitCount .. "\n"
              .endblock

              endMenuText
              startCode

            +

            lda lGold
            sta lR18
            lda lGold+size(byte)
            sta lR18+size(byte)
            jsl rlConvertNumberToBCD

            lda #TilemapEntry(BG3NumberTilesBaseTile, TextBlue, 1, false, false)
            sta aCurrentTilemapInfo.wBaseTile,b

            lda #<>aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer,b
            lda #>`aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

            ldx #pack(GoldBox.GoldPosition + (GoldBox.DigitCount - 1, 0))
            jsl rlDrawNumberMenuTextFromBCD

            lda #TilemapEntry(BG3MenuTilesBaseTile, TextWhite, 1, false, false)
            sta aCurrentTilemapInfo.wBaseTile,b

            .bfor Line in range(DialogueBox.LineCount)

              ldx #pack(DialogueBox.LinePositions[Line])

              lda #(`_menutextLineClearer)<<8
              sta lR18+size(byte)
              lda #<>_menutextLineClearer
              sta lR18
              jsl rlDrawMenuText
              bra +

                endCode
                startMenuText

                _menutextLineClearer .block
                  .enc "SJIS"
                  .text "　" x (DialogueBox.InteriorSize[0]) .. "\n"
                .endblock

                endMenuText
                startCode

              +

            .endfor

            rts

            .databank 0

            .endwith ; BottomRegion
            .endwith ; TopRegion

          rsShopWindowUpdate ; 85/9F44

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Runs the current action and renders icons.

            ; Inputs:
            ; wShopWindowActionIndex: current action

            ; Outputs:
            ; None

            lda wShopWindowActionIndex
            and #$00FF
            asl a
            asl a
            tax
            lda aShopWindowActions,x
            sta wR0
            pea <>(+) - size(byte)

            jmp (wR0)

            +
            jsl rlRenderSheetIconSprites
            rts

            .databank 0

          rsShopWindowGetNextAction ; 85/9F5E

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Gets the next action.

            ; Inputs:
            ; wShopWindowActionIndex: current action

            ; Outputs:
            ; wShopWindowActionIndex: next action

            lda wShopWindowActionIndex
            and #$00FF
            asl a
            asl a

            .rept size(word)

              inc a

            .endrept

            tax
            lda aShopWindowActions,x
            sta wShopWindowActionIndex

            rts

            .databank 0

          rsShopWindowActionDefault ; 85/9F71

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Creates the intro text based on shop type.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            lda #0
            sta wShopWindowUnitFlag
            lda #-1
            sta wShopWindowReadyFlag

            lda #<>aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer,b
            lda #>`aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

            jsr rsShopWindowClearDialogueBoxAndDrawGold
            jsr rsShopWindowIsShopArmory
            beq _Armory

              ; Vendor

              lda #(`aShopWindowVendorDefaultOptions)<<8
              sta lR18+size(byte)
              lda #<>aShopWindowVendorDefaultOptions
              sta lR18
              bra +

            _Armory

              lda #(`aShopWindowArmoryDefaultOptions)<<8
              sta lR18+size(byte)
              lda #<>aShopWindowArmoryDefaultOptions
              sta lR18
              ; bra +

            +
            jsl rlDrawShopDialogueText
            jmp rsShopWindowGetNextAction

            .databank 0

          rsShopWindowActionContinue ; 85/9FAE

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Creates the continue text after backing out
            ; of an option.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            stz wInfoWindowTarget

            jsr rsShopWindowClearDialogueBoxAndDrawGold

            lda #(`aShopWindowContinueOptions)<<8
            sta lR18+size(byte)
            lda #<>aShopWindowContinueOptions
            sta lR18
            jsl rlDrawShopDialogueText

            jsl rlEnableBG3Sync
            jmp rsShopWindowGetNextAction

            .databank 0

          rsShopWindowDrawItemName ; 85/9FC9

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Draws an item name.

            ; Inputs:
            ; X: X coordinate offset
            ; wR17: row offset
            ; lR18: long pointer to item name
            ; aCurrentTilemapInfo.wBaseTile: base tile

            ; Outputs:
            ; None

            phx
            phy
            phx

            lda #<>aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer,b
            lda #>`aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

            ldx wR17
            pla
            clc
            adc aShopWindowItemLineBasePositions,x
            tax
            jsl rlDrawMenuText

            ply
            plx
            rts

            .databank 0

          rsShopWindowDrawItemPrice ; 85/9FE8

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Draws an item's price, drawing `----` if 
            ; the number passed in is zero.

            ; Inputs:
            ; A: number
            ; X: X coordinate offset
            ; wR17: row offset
            ; aCurrentTilemapInfo.wBaseTile: base tile

            ; Outputs:
            ; None

            phx
            phy
            phx
            ora #0
            beq _Unsellable

              stz lR18+size(byte)
              sta lR18
              jsl rlConvertNumberToBCD

              lda #<>aGenericBG3TilemapInfo
              sta aCurrentTilemapInfo.lInfoPointer,b
              lda #>`aGenericBG3TilemapInfo
              sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

              ldx wR17
              pla
              clc
              adc aShopWindowItemLineBasePositions,x
              tax
              jsl rlDrawNumberMenuTextFromBCD
              ply
              plx
              rts

            _Unsellable

              lda #<>aGenericBG3TilemapInfo
              sta aCurrentTilemapInfo.lInfoPointer,b
              lda #>`aGenericBG3TilemapInfo
              sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

              lda #TilemapEntry(BG3MenuTilesBaseTile, TextGray, 1, false, false)
              sta aCurrentTilemapInfo.wBaseTile,b

              ldx wR17
              pla
              clc
              adc aShopWindowItemLineBasePositions,x
              sec
              sbc #3
              tax
              lda #<>menutextQuadrupleDash
              sta lR18
              lda #>`menutextQuadrupleDash
              sta lR18+size(byte)
              jsl rlDrawMenuText
              ply
              plx
              rts

            .databank 0

          rsShopWindowDrawItemPriceWithColor ; 85/A044

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Draws an item's price, drawing `----` if 
            ; the number passed in is zero.

            ; If the player can afford the item, its cost is
            ; blue. If they cannot, it is gray.

            ; Inputs:
            ; A: number
            ; X: X coordinate offset
            ; wR17: row offset

            ; Outputs:
            ; None

            phx
            pha

            stz lR18+size(byte)
            sta lR18
            jsl rlCanPlayerAffordCost
            bcs _Gray

            lda #TilemapEntry(BG3NumberTilesBaseTile, TextBlue, 1, false, false)
            sta aCurrentTilemapInfo.wBaseTile,b
            bra +

            _Gray
            lda #TilemapEntry(BG3NumberTilesBaseTile, TextGray, 1, false, false)
            sta aCurrentTilemapInfo.wBaseTile,b

            +
            pla
            plx
            jmp rsShopWindowDrawItemPrice

            .databank 0

          rsShopWindowDrawItemDurability ; 85/A063

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Draws an item's durability.

            ; Inputs:
            ; X: X coordinate offset
            ; wR17: row offset
            ; aShopWindowItemDurabilityArray: filled with item durabilities
            ; aShopWindowItemTextBaseArray: filled with text bases

            ; Outputs:
            ; None

            txa
            ldx wR17
            clc
            adc aShopWindowItemLineBasePositions,x
            pha

            sep #$20

            lda aShopWindowItemDurabilityArray,x
            sta aItemDataBuffer.Durability,b

            rep #$20

            lda aShopWindowItemTextBaseArray,x
            sta aCurrentTilemapInfo.wBaseTile,b

            plx
            jsl rlDrawItemCurrentDurability

            rts

            .databank 0

          rsShopWindowDrawItemIcon ; 85/A082

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Draws an item's icon.

            ; Inputs:
            ; X: row offset
            ; aItemDataBuffer: filled with item

            ; Outputs:
            ; None

            .with BottomRegion

            phx
            phy

            txa
            clc
            adc #ItemBox.IconPositions[0][1]
            sta wR1

            lda #ItemBox.IconPositions[0][0]
            sta wR0

            lda aItemDataBuffer.Icon,b
            and #$00FF
            sta wR2

            lda #OAMTileAndAttr(0, 5, 0, false, false)
            sta wR3

            jsl rlDrawSingleIcon

            ply
            plx
            rts

            .endwith ; BottomRegion

            .databank 0

          rsShopWindowUnusedDrawItemIcons ; 85/A0A4

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Unused.
            ; Would draw all of the shop's item icons.

            ; Inputs:
            ; aShopWindowItemIconArray: filled with icons

            ; Outputs:
            ; None

            .with BottomRegion

            ldx #size(aShopWindowItemIconArray) - size(word)

            -
              lda aShopWindowItemIconArray,x
              beq +

                sta wR2
                lda #ItemBox.IconPositions[0][0]
                sta wR0
                lda aShopWindowItemCursorYPositions,x
                sta wR1
                jsl rsRenderSheetIconByTileIndex

              +

              .rept size(aShopWindowItemIconArray.Icons[0])
                dec x
              .endrept

              bpl -

            rtl

            .endwith ; BottomRegion

            .databank 0

          rlShopWindowInitialize ; 85/A0C2

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            stz wInfoWindowTarget
            jsl rlClearIconArray
            jsr rsShopWindowClearArrays
            jsr rsShopWindowClearItemTextTilemap
            lda wShopWindowUnitFlag
            cmp #0
            beq _Shop

              jsr rsShopWindowGetItemArrayInfoFromUnit
              bra +

            _Shop
              jsr rsShopWindowGetItemArrayInfoFromShopList

            +
            jsl rlShopWindowDrawItems
            jsr rsShopWindowGetMaxRowOffset

            rtl

            .databank 0

          rsShopWindowGetMaxRowOffset ; 85/A0E7

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Gets the offset of the first invalid row.

            ; Inputs:
            ; None

            ; Outputs:
            ; wShopWindowMaxRowOffset: first invalid row offset

            ldx #0

            -
              lda aShopWindowItemIDArray,x
              beq +

                .rept size(aShopWindowItemIDArray.IDs[0])
                  inc x
                .endrept

                bra -

            +
            stx wShopWindowMaxRowOffset
            rts

            .databank 0

          rsShopWindowGetItemArrayInfoFromUnit ; 85/A0F7

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Stores info for a shop's items to
            ; the various arrays.

            ; Inputs:
            ; aTemporaryActionStruct.Items: filled with items

            ; Outputs:
            ; None

            ldy #0
            ldx #0

            _Loop
              lda aTemporaryActionStruct.Items,b,y
              beq _End

              jsl rlCopyItemDataToBuffer
              lda #0
              sta aShopWindowItemTextBaseArray,x
              lda #<>aTemporaryActionStruct
              sta wR1
              jsl rlCheckItemEquippable
              bcs +

                lda #2
                sta aShopWindowItemTextBaseArray,x

              +
              lda #0
              sta aShopWindowItemSelectabilityArray,x
              lda aItemDataBuffer.Traits,b
              bit #TraitUnsellable
              beq +

                lda #2
                sta aShopWindowItemSelectabilityArray,x
                stz aItemDataBuffer.Cost,b

              +
              jsr rsShopWindowGetItemDurability
              sta aShopWindowItemDurabilityArray,x

              sep #$20

              lda aItemDataBuffer.DisplayedWeapon,b
              sta aShopWindowItemIDArray,x
              lda aItemDataBuffer.Durability,b
              sta aShopWindowItemIDArray+size(byte),x

              rep #$30

              lda aItemDataBuffer.Cost,b
              lsr a
              sta aShopWindowItemPriceArray,x
              tya
              sta aShopWindowItemOffsetArray,x
              jsr rsShopWindowDrawItemIcon

              .rept size(word)
                inc x
              .endrept

              .rept size(word)
                inc y
              .endrept

              cpy #size(aShopWindowItemIDArray) - size(word)
              bne _Loop

            _End
            rts

            .databank 0

          rsShopWindowGetItemArrayInfoFromShopList ; 85/A162

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Stores info for a shop's items to
            ; the various arrays.

            ; Inputs:
            ; lShopWindowInventoryPointer: long pointer to shop items

            ; Outputs:
            ; None

            ldy #0

            lda lShopWindowInventoryPointer
            sta lR23
            lda lShopWindowInventoryPointer+size(byte)
            sta lR23+size(byte)

            _Loop
              lda [lR23],y
              beq _Next

              ora #+pack((None, -2))
              jsl rlCopyItemDataToBuffer

              jsr rsShopWindowGetItemDurability
              sta aShopWindowItemDurabilityArray,y

              lda aItemDataBuffer.DisplayedWeapon,b
              and #$00FF
              sta aShopWindowItemIDArray,y

              jsr rsShopWindowGetItemPrice

              lda #0
              sta aShopWindowItemTextBaseArray,y

              lda #<>aTemporaryActionStruct
              sta wR1
              jsl rlCheckItemEquippable
              bcs +

                lda #2
                sta aShopWindowItemTextBaseArray,y

              +
              lda #0
              sta aShopWindowItemSelectabilityArray,y

              stz lR18+size(byte)
              lda aShopWindowItemPriceArray,y
              sta lR18
              jsl rlCanPlayerAffordCost
              bcc +

                lda #2
                sta aShopWindowItemSelectabilityArray,y

              +
              tyx
              jsr rsShopWindowDrawItemIcon

              _Next
              inc y
              inc y

              cpy #8 * size(word)
              bne _Loop

            rts

            .databank 0

          rsShopWindowGetItemDurability ; 85/A1C8

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Gets an item's durability, returning 0
            ; if unbreakable.

            ; Inputs:
            ; aItemDataBuffer: filled with item

            ; Outputs:
            ; A: durability

            phx
            phy
            lda aItemDataBuffer.Traits,b
            bit #TraitUnbreakable
            bne +

              lda aItemDataBuffer.Durability,b
              and #$00FF
              ply
              plx
              rts

            +
            lda #0
            ply
            plx
            rts

            .databank 0

          rsShopWindowGetItemPrice ; 85/A1E1

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Gets an item's price, halved if the
            ; visitor has Bargain.

            ; Inputs:
            ; Y: offset into aShopWindowItemPriceArray
            ; aItemDataBuffer: filled with item
            ; aSelectedCharacterBuffer: filled with unit

            ; Outputs:
            ; aShopWindowItemPriceArray,y: price

            lda aSelectedCharacterBuffer.Skills1,b
            bit #Skill1Bargain
            beq +

              lda aItemDataBuffer.Cost,b
              lsr a
              sta aShopWindowItemPriceArray,y
              rts

            +
            lda aItemDataBuffer.Cost,b
            sta aShopWindowItemPriceArray,y
            rts

            .databank 0

          rlShopWindowDrawItems ; 85/A1F8

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            .with BottomRegion.ItemBox

            stz wR17

            -
              ldy wR17
              lda aShopWindowItemIDArray,y
              beq +

                jsl rlCopyItemDataToBuffer
                jsl rlGetItemNamePointer

                lda aShopWindowItemTextBaseArray,y
                tax
                lda aShopWindowTextColors,x
                sta aCurrentTilemapInfo.wBaseTile,b

                ldx #2
                jsr rsShopWindowDrawItemName

                lda aShopWindowItemTextBaseArray,y
                tax
                lda aShopWindowNumberColors,x
                sta aCurrentTilemapInfo.wBaseTile,b

                ldx #(DurabilityPositions[0] - IconPositions[0])[0]
                lda aShopWindowItemDurabilityArray,y
                jsr rsShopWindowDrawItemDurability

                lda aShopWindowItemSelectabilityArray,y
                tax
                lda aShopWindowNumberColors,x
                sta aCurrentTilemapInfo.wBaseTile,b

                lda aShopWindowItemPriceArray,y
                ldx #(PricePositions[0] - IconPositions[0])[0]
                jsr rsShopWindowDrawItemPrice

              +
              lda wR17
              inc a
              inc a
              sta wR17
              cmp #size(aShopWindowItemTextBaseArray)
              bne -

            jsl rlEnableBG3Sync
            rtl

            .endwith ; BottomRegion.ItemBox

            .databank 0

          rsShopWindowClearArrays ; 85/A252

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Clears the various shop item arrays.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            ldx #size(aShopWindowItemIconArray) - size(word)
            lda #0

            -
              sta aShopWindowItemIconArray,x
              sta aShopWindowItemIDArray,x
              sta aShopWindowItemTextBaseArray,x
              sta aShopWindowItemDurabilityArray,x
              sta aShopWindowItemPriceArray,x
              sta aShopWindowItemSelectabilityArray,x
              sta aShopWindowItemOffsetArray,x

              .rept size(word)
                dec x
              .endrept

              bpl -

            rts

            .databank 0

          rsShopWindowClearItemTextTilemap ; 85/A272

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Clears the tilemap space occupied by the item
            ; names, durabilities, and costs.

            ; I don't know how this arrives at these coordinates.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            .with BottomRegion

            lda #ItemBox.Size[1] - 2 - 1
            sta wR0

            -
            lda wR0
            asl a
            asl a
            asl a
            asl a
            asl a
            asl a
            clc
            adc #22
            tax

            lda #BG3BlankTile

            sta aBG3TilemapBuffer + (C2I((4, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((5, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((6, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((7, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((8, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((9, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((10, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((11, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((12, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((13, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((14, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((15, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((16, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((17, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((18, 11), 32) * size(word)),x
            sta aBG3TilemapBuffer + (C2I((19, 11), 32) * size(word)),x

            dec wR0

            bpl -

            rts

            .endwith ; BottomRegion

            .databank 0

          rsShopWindowActionBuySellUpdate ; 85/A2BC

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Updates the shop while selecting whether
            ; to buy or sell.

            jsr rsShopWindowCheckIfDialogueActive
            bcs _End

            jsr rsShopWindowHandleBuySellInputs

            ldx wShopWindowUnitFlag
            jsr rsShopWindowRenderBuySellCursor

            lda wShopWindowUnitFlag
            eor wShopWindowReadyFlag
            beq +

              jsl rlShopWindowInitialize

            +
            lda wShopWindowUnitFlag
            sta wShopWindowReadyFlag

            _End
            rts

            .databank 0

          rsShopWindowHandleBuySellInputs ; 85/A2DD

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles inputs when selecting whether to buy or
            ; sell.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            lda wJoy1New
            bit #JOY_Left
            beq +

              lda #$000A ; TODO: sound effects
              jsl rlPlaySoundEffect

              lda #0
              sta wShopWindowUnitFlag

            +
            bit #JOY_Right
            beq +

              lda #$000A ; TODO: sound effects
              jsl rlPlaySoundEffect

              lda #size(word)
              sta wShopWindowUnitFlag

            +
            bit #JOY_A
            beq +

              lda #$000C ; TODO: sound effects
              jsl rlPlaySoundEffect

              stz wShopWindowCurrentRowOffset

              ldx wShopWindowUnitFlag
              lda _Actions,x
              sta wShopWindowActionIndex

            +
            lda wJoy1New
            bit #JOY_B
            beq +

              lda #$0021 ; TODO: sound effects
              jsl rlPlaySoundEffect
              jmp rsShopWindowGetNextAction

            +
            rts

            endCode
            startData

              _Actions .word aShopWindowActions.BuyIntro, aShopWindowActions.SellIntro

            endData
            startCode

          rsShopWindowRenderBuySellCursor ; 85/A332

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Draws the Buy/Sell select cursor.

            ; Inputs:
            ; X: 0 for buy, size(word) for sell

            ; Outputs:
            ; None

            .with TopRegion.DialogueBox

            lda #BuySellCursorPositions[0][1]
            sta wR1
            lda _XCoordinates,x
            sta wR0
            jsl rlDrawRightFacingCursor
            rts

            endCode
            startData

              _XCoordinates .word BuySellCursorPositions[:,0]

            endData
            startCode

            .endwith ; TopRegion.DialogueBox

            .databank 0

          rsShopWindowActionBuyIntro ; 85/A346

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Draws the text upon selecting `Buy`.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            jsr rsShopWindowClearDialogueBoxAndDrawGold
            lda #(`aShopWindowBuyOptions)<<8
            sta lR18+size(byte)
            lda #<>aShopWindowBuyOptions
            sta lR18
            jsl rlDrawShopDialogueText
            jsl rlEnableBG3Sync
            jmp rsShopWindowGetNextAction

            .databank 0

          rsShopWindowActionPostBuy ; 85/A35E

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Draws the text after buying something and
            ; updates the items.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            jsr rsShopWindowClearDialogueBoxAndDrawGold
            lda #(`aShopWindowPostBuyOptions)<<8
            sta lR18+size(byte)
            lda #<>aShopWindowPostBuyOptions
            sta lR18
            jsl rlDrawShopDialogueText
            jsl rlShopWindowInitialize
            jmp rsShopWindowGetNextAction

          rsShopWindowActionSellIntro ; 85/A376

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Draws text for when you select `Sell`.
            ; If you have no items, plays different text.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            jsl rlShopWindowInitialize
            lda aShopWindowItemIDArray.IDs[0]
            bne +

              ; No items remaining, switch inventories.

              jsr rsShopWindowClearDialogueBoxAndDrawGold
              lda #(`aShopWindowNoSellableItemsOptions)<<8
              sta lR18+size(byte)
              lda #<>aShopWindowNoSellableItemsOptions
              sta lR18
              jsl rlDrawShopDialogueText
              lda #aShopWindowActions.Continue
              jmp rsShopWindowPushActionToQueue

            +
            jsr rsShopWindowClearDialogueBoxAndDrawGold
            lda #(`aShopWindowSellOptions)<<8
            sta lR18+size(byte)
            lda #<>aShopWindowSellOptions
            sta lR18
            jsl rlDrawShopDialogueText
            jmp rsShopWindowGetNextAction

            .databank 0

          rsShopWindowActionPostSell ; 85/A3AA

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles when you sell an item.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            jsr rsShopWindowCheckIfDialogueActive
            bcs _End

            jsr rsShopWindowClearDialogueBoxAndDrawGold
            jsl rlShopWindowInitialize
            lda aShopWindowItemIDArray.IDs[0]
            bne +

              lda #aShopWindowActions.Continue
              sta wShopWindowActionIndex

            _End
              rts

            +
            ldx wShopWindowCurrentRowOffset
            lda aShopWindowItemIDArray,x
            bne +

              .rept size(aShopWindowItemIDArray.IDs[0])
                dec x
              .endrept

              stx wShopWindowCurrentRowOffset

            +
            lda #TilemapEntry(BG3MenuTilesBaseTile, TextWhite, 1, false, false)
            sta aCurrentTilemapInfo.wBaseTile,b

            lda #(`aShopWindowPostSellOptions)<<8
            sta lR18+size(byte)
            lda #<>aShopWindowPostSellOptions
            sta lR18

            jsl rlDrawShopDialogueText
            jmp rsShopWindowGetNextAction

            .databank 0

          rsShopWindowActionItemSelection ; 85/A3E6

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles navigating a shop item list.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            jsr rsShopWindowCheckIfDialogueActive
            bcs +

              ldx wShopWindowUnitFlag
              jsr rsShopWindowHandleSelectionInput
              jsr rsShopWindowRenderItemListCursor

              ldx wShopWindowCurrentRowOffset
              lda aShopWindowItemIDArray,x
              sta wInfoWindowTarget

            +
            rts

            .databank 0

          rsShopWindowHandleSelectionInput ; 85/A3FE

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles item selection inputs.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            lda wJoy1Repeated
            bit #JOY_Up
            beq +

              jsr rsShopWindowSelectionUp

            +
            bit #JOY_Down
            beq +

              jsr rsShopWindowSelectionDown

            +
            lda wJoy1New
            bit #JOY_B
            beq +

              stz wInfoWindowTarget

              lda #aShopWindowActions.Continue
              sta wShopWindowActionIndex

              lda #$0021 ; TODO: sound effect
              jsl rlPlaySoundEffect

              rts

            +
            bit #JOY_A
            beq +

              lda #$000C ; TODO: sound effect
              jsl rlPlaySoundEffect

              jmp rsShopWindowGetNextAction

            +
            rts

            .databank 0

          rsShopWindowSelectionUp ; 85/A438

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles pressing `Up` when selecting an item.

            ; Inputs:
            ; wShopWindowCurrentRowOffset: current position

            ; Outputs:
            ; wShopWindowCurrentRowOffset: new position

            lda wShopWindowCurrentRowOffset
            bne +

              lda wJoy1New
              cmp wJoy1Repeated
              bne _End

                lda wShopWindowMaxRowOffset

            +
            .rept size(word)
              dec a
            .endrept

            sta wShopWindowCurrentRowOffset

            lda #$0009 ; TODO: sound effects
            jsl rlPlaySoundEffect

            _End
            rts

            .databank 0

          rsShopWindowSelectionDown ; 85/A453

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles pressing `Down` when selecting an item.

            ; Inputs:
            ; wShopWindowCurrentRowOffset: current position

            ; Outputs:
            ; wShopWindowCurrentRowOffset: new position

            lda wShopWindowCurrentRowOffset

            .rept size(word)
              inc a
            .endrept

            cmp wShopWindowMaxRowOffset
            bne +

              lda wJoy1New
              cmp wJoy1Repeated
              bne _End

                lda #0

            +
            sta wShopWindowCurrentRowOffset

            lda #$0009 ; TODO: sound effects
            jsl rlPlaySoundEffect

            _End
            rts

            .databank 0

          rsShopWindowRenderItemListCursor ; 85/A471

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Draws the cursor when on the item list.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            .with BottomRegion.ItemBox

            lda #CursorPositions[0][0] * 8
            sta wR0

            ldx wShopWindowCurrentRowOffset
            lda aShopWindowItemCursorYPositions,x
            asl a
            asl a
            asl a
            sta wR1

            lda wShopWindowActionIndex
            cmp #aShopWindowActions.BuySelection
            beq _Selection

            cmp #aShopWindowActions.SellSelection
            beq _Selection

              jsl rlDrawRightFacingStaticCursorHighPrio
              rts

            _Selection
              jsl rlDrawRightFacingCursor
              rts

            .endwith ; BottomRegion.ItemBox

            .databank 0

          rsShopWindowActionBuy ; 85/A499

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles actually buying an item.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            jsr rsShopWindowClearDialogueBoxAndDrawGold
            ldx wShopWindowCurrentRowOffset
            lda aShopWindowItemSelectabilityArray,x
            bne _Unbuyable

            lda aTemporaryActionStruct.Item7ID,b
            bne _InventoryFull

              lda #(`aShopWindowBuyConfirmOptions)<<8
              sta lR18+size(byte)
              lda #<>aShopWindowBuyConfirmOptions
              sta lR18
              jsl rlDrawShopDialogueText
              jsl rlEnableBG3Sync
              jmp rsShopWindowGetNextAction

            _Unbuyable
              lda #(`aShopWindowCannotAffordOptions)<<8
              sta lR18+size(byte)
              lda #<>aShopWindowCannotAffordOptions
              sta lR18
              jsl rlDrawShopDialogueText
              jsl rlEnableBG3Sync

              lda #$0022 ; TODO: sound definitions
              jsl rlPlaySoundEffect

              lda #aShopWindowActions.PostBuy
              jmp rsShopWindowPushActionToQueue

            _InventoryFull
              lda #(`aShopWindowInventoryFullOptions)<<8
              sta lR18+size(byte)
              lda #<>aShopWindowInventoryFullOptions
              sta lR18
              jsl rlDrawShopDialogueText
              jsl rlEnableBG3Sync

              lda #$0022 ; TODO: sound definitions
              jsl rlPlaySoundEffect

              lda #aShopWindowActions.Continue
              jmp rsShopWindowPushActionToQueue

            .databank 0

          rsShopWindowPushActionToQueue ; 85/A4FC

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Pushes an action for later.

            ; Inputs:
            ; A: action

            ; Outputs:
            ; wShopWindowActionIndex: unqueue action

            jsl rlPushToQueue

            lda #aShopWindowActions.PopAction
            sta wShopWindowActionIndex

            rts

            .databank 0

          rsShopWindowActionPop ; 85/A507

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Pops the stored action and runs
            ; it when ready.

            jsr rsShopWindowCheckIfDialogueActive
            bcs +

            jsr rsShopWindowCheckAcknowledge
            bcc +

            jsl rlPopFromQueue
            sta wShopWindowActionIndex

            +
            rts

            .databank 0

          rsShopWindowCheckAcknowledge ; 85/A519

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Returns carry set once the player
            ; has pressed `A` or `B` to acknowledge
            ; some shop message.

            ; Inputs:
            ; None

            ; Outputs:
            ; carry set if pressed, else clear

            lda wJoy1New
            bit #(JOY_A | JOY_B)
            beq +

            sec
            rts

            +
            clc
            rts

            .databank 0

          rsShopWindowActionBuyConfirmSelection ; 85/A524

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles the player confirming whether
            ; to buy an item.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            jsr rsShopWindowRenderItemListCursor
            jsr rsShopWindowCheckIfDialogueActive
            bcs +

              jsr rsShopWindowHandleConfirmSelectionDirectionInputs

              ldy #aShopWindowActions.PostBuy
              jsr rsShopWindowHandleConfirmSelectionYesNoInputs

              ldx wShopWindowConfirmOffset
              jsr rsShopWindowRenderBuySellCursor

            +
            rts

            .databank 0

          rsShopWindowActionSellConfirm ; 85/A53C

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles showing text asking for confirmation
            ; or saying that an item is unsellable.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            jsr rsShopWindowClearDialogueBoxAndDrawGold
            ldx wShopWindowCurrentRowOffset
            lda aShopWindowItemSelectabilityArray,x
            bne +

              lda #(`aShopWindowSellConfirmOptions)<<8
              sta lR18+size(byte)
              lda #<>aShopWindowSellConfirmOptions
              sta lR18
              jsl rlDrawShopDialogueText
              jsl rlEnableBG3Sync
              jmp rsShopWindowGetNextAction

            +
              lda #(`aShopWindowUnsellableOptions)<<8
              sta lR18+size(byte)
              lda #<>aShopWindowUnsellableOptions
              sta lR18
              jsl rlDrawShopDialogueText
              jsl rlEnableBG3Sync

              lda #$0022 ; TODO: sound definitions
              jsl rlPlaySoundEffect

              lda #aShopWindowActions.PostSell
              jmp rsShopWindowPushActionToQueue
            
            .databank 0

          rsShopWindowActionSellConfirmSelection ; 85/A57B

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles deciding whether to sell something.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            jsr rsShopWindowRenderItemListCursor
            jsr rsShopWindowCheckIfDialogueActive
            bcs +

              jsr rsShopWindowHandleConfirmSelectionDirectionInputs

              ldy #aShopWindowActions.PostSell
              jsr rsShopWindowHandleConfirmSelectionYesNoInputs

              ldx wShopWindowConfirmOffset
              jsr rsShopWindowRenderBuySellCursor

            +
            rts

            .databank 0

          rsShopWindowHandleConfirmSelectionDirectionInputs ; 85/A593

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles left/right input when deciding
            ; whether to buy/sell an item

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            lda wJoy1New
            bit #JOY_Left
            beq +

              lda #$000A ; TODO: sound definitions
              jsl rlPlaySoundEffect

              stz wShopWindowConfirmOffset

            +
            bit #JOY_Right
            beq +

              lda #$000A ; TODO: sound definitions
              jsl rlPlaySoundEffect

              lda #size(word)
              sta wShopWindowConfirmOffset

            +
            rts

            .databank 0

          rsShopWindowHandleConfirmSelectionYesNoInputs ; 85/A57

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles A/B input when deciding
            ; whether to buy/sell an item

            ; Inputs:
            ; Y: 'No' action

            ; Outputs:
            ; None

            lda wJoy1New
            bit #JOY_A
            beq +

              lda wShopWindowConfirmOffset
              bne _No

              lda #$000C ; TODO: sound definitions
              jsl rlPlaySoundEffect

              jmp rsShopWindowGetNextAction

            +
            bit #JOY_B
            beq _End

              _No
              lda #$0021 ; TODO: sound definitions
              jsl rlPlaySoundEffect

              sty wShopWindowActionIndex

            _End
            rts

            .databank 0

          rsShopWindowActionBuyEffect ; 85/A5DD

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Actually give the unit an item and subtract gold.

            ; Inputs:
            ; aTemporaryActionStruct: filled with unit

            ; Outputs:
            ; None

            ldx wShopWindowCurrentRowOffset
            lda aShopWindowItemIDArray,x
            ora #+pack((None, -2))
            jsl rlCopyItemDataToBuffer

            lda #<>aTemporaryActionStruct
            sta wR1
            jsl rlTryGiveCharacterItemFromBuffer
            bcs +

              stz lR18+size(byte)
              ldx wShopWindowCurrentRowOffset
              lda aShopWindowItemPriceArray,x
              sta lR18
              jsl rlSubtractFromGold

              lda #$006F ; TODO: sound definitions
              jsl rlPlaySoundEffect

              lda #-1
              sta wUnknown7E4F96

            +
            jmp rsShopWindowGetNextAction

            .databank 0

          rsShopWindowActionSellEffect ; 85/A613

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Actually take an item and grant gold.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            lda #<>aTemporaryActionStruct
            sta wR1
            ldx wShopWindowCurrentRowOffset
            lda aShopWindowItemOffsetArray,x
            jsl rlSellCharacterItemFromBuffer

            lda #$006F ; TODO: sound definitions
            jsl rlPlaySoundEffect

            lda #-1
            sta wUnknown7E4F96

            jmp rsShopWindowGetNextAction

            .databank 0

          rsShopWindowActionLeave ; 85/A632

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Show text when leaving.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            lda #<>aTemporaryActionStruct
            sta wR0
            lda #<>aSelectedCharacterBuffer
            sta wR1
            jsl rlCopyExpandedCharacterDataBufferToBuffer

            jsr rsShopWindowClearDialogueBoxAndDrawGold

            lda #(`aShopWindowLeaveOptions)<<8
            sta lR18+size(byte)
            lda #<>aShopWindowLeaveOptions
            sta lR18
            jsl rlDrawShopDialogueText
            jsl rlEnableBG3Sync

            lda #aShopWindowActions.LeaveWrapUp
            jmp rsShopWindowPushActionToQueue

            .databank 0

          rsShopWindowActionLeaveWrapUp ; 85/A65B

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Handles actually leaving the menu.

            ; Inputs:
            ; None

            ; Outputs:
            ; None

            lda wPrepScreenFlag,b
            bne _Prep

            lda #<>$809F74 ; TODO: this
            sta aProcSystem.wInput0,b

            lda #(`procFadeWithCallback)<<8
            sta lR44+size(byte)
            lda #<>procFadeWithCallback
            sta lR44
            jsl rlProcEngineCreateProc
            bra +

            _Prep
            lda #<>aSelectedCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataFromBuffer

            lda lUnknown7EA4EC
            sta lR18
            lda lUnknown7EA4EC+size(byte)
            sta lR18+size(byte)
            phk
            pea <>(+)-size(byte)
            jmp [lR18]

            +
            jsl rlPlayMenuCloseSound
            rts

            .databank 0

          rsShopWindowCheckIfDialogueActive ; 85/A695

            .al
            .xl
            .autsiz
            .databank `wShopWindowActionIndex

            ; Returns carry set if dialogue is
            ; currently playing.

            ; Inputs:
            ; None

            ; Outputs:
            ; carry set if dialogue active else clear

            lda #(`procDialogue94CCDF)<<8
            sta lR44+size(byte)
            lda #<>procDialogue94CCDF
            sta lR44
            jsl rlProcEngineFindProc
            bcs +

            lda #(`procDialogue94CBC2)<<8
            sta lR44+size(byte)
            lda #<>procDialogue94CBC2
            sta lR44
            jsl rlProcEngineFindProc
            bcs +

            +
            rts

            .databank 0

        endCode
        startData

          aShopWindowArmoryDefaultOptions .block ; 85/A6B6
            macroShopText dialogueArmoryIntro, [11, 2], $0800, $00E0
            macroShopText dialogueShopBuySell, [20, 6], $1000, $0000, true
            macroShopTextEnd
          .endblock

          aShopWindowVendorDefaultOptions .block ; 85/A6CE
            macroShopText dialogueVendorIntro, [11, 2], $0800, $00E0
            macroShopText dialogueShopBuySell, [20, 6], $1000, $0000, true
            macroShopTextEnd
          .endblock

          aShopWindowContinueOptions .block ; 85/A6E6
            macroShopText dialogueShopContinue, [11, 2], $0800, $00E0
            macroShopText dialogueShopBuySell,  [20, 6], $0C00, $0000, true
            macroShopTextEnd
          .endblock

          aShopWindowBuyOptions .block ; 85/A6FE
            macroShopText dialogueShopBuyIntro, [11, 2], $0800, $00E0
            macroShopTextEnd
          .endblock

          aShopWindowPostBuyOptions .block ; 85/A70B
            macroShopText dialogueShopPostBuy, [11, 2], $0800, $00E0
            macroShopTextEnd
          .endblock

          aShopWindowNoSellableItemsOptions .block ; 85/A718
            macroShopText dialogueShopNoItemsToSell, [11, 2], $0800, $00E0
            macroShopTextEnd
          .endblock

          aShopWindowSellOptions .block ; 85/A725
            macroShopText dialogueShopSellIntro, [11, 2], $0800, $00E0
            macroShopTextEnd
          .endblock

          aShopWindowPostSellOptions .block ; 85/A732
            macroShopText dialogueShopPostSell, [11, 2], $0800, $00E0
            macroShopTextEnd
          .endblock

          aShopWindowCannotAffordOptions .block ; 85/A73F
            macroShopText dialogueShopCannotAfford, [11, 2], $0800, $00E0
            macroShopTextEnd
          .endblock

          aShopWindowBuyConfirmOptions .block ; 85/A74C
            macroShopText dialogueShopBuyConfirm, [11, 2], $0800, $00E0
            macroShopText dialogueShopYesNo,      [20, 6], $0C00, $0000, true
            macroShopTextEnd
          .endblock

          aShopWindowSellConfirmOptions .block ; 85/A764
            macroShopText dialogueShopSellConfirm, [11, 2], $0800, $00E0
            macroShopText dialogueShopYesNo,       [20, 6], $0C00, $0000, true
            macroShopTextEnd
          .endblock

          aShopWindowLeaveOptions .block ; 85/A77C
            macroShopText dialogueShopLeave, [11, 2], $0800, $00E0
            macroShopTextEnd
          .endblock

          aShopWindowUnsellableOptions .block ; 85/A789
            macroShopText dialogueShopUnsellable, [11, 2], $0800, $00E0
            macroShopTextEnd
          .endblock

          aShopWindowInventoryFullOptions .block ; 85/A796
            macroShopText dialogueShopInventoryFull, [11, 2], $0800, $00E0
            macroShopTextEnd
          .endblock

        endData

      .endwith ; ShopWindowConfig

    .endsection ShopWindowSection

.endif ; GUARD_FE5_SHOP_WINDOW
