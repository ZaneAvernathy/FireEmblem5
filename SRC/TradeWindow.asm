
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_TRADE_WINDOW :?= false
.if (!GUARD_FE5_TRADE_WINDOW)
  GUARD_FE5_TRADE_WINDOW := true

  ; Definitions

    .weak

      rlPushToOAMBuffer                         :?= address($808881)
      rlPlaySoundEffect                         :?= address($808C87)
      rlUnknown809FE5                           :?= address($809FE5)
      rlDMAByStruct                             :?= address($80AE2E)
      rlAppendDecompList                        :?= address($80B00A)
      rlBlockCopy                               :?= address($80B340)
      rlFillTilemapByWord                       :?= address($80E89F)
      rlEnableBG1Sync                           :?= address($81B1FA)
      rlEnableBG2Sync                           :?= address($81B206)
      rlEnableBG3Sync                           :?= address($81B212)
      rlDrawItemInfo                            :?= address($81F590)
      rlUpdateItemInfoProcCoordinates           :?= address($81F5B4)
      rlProcEngineCreateProc                    :?= address($829BF1)
      rlProcEngineFindProc                      :?= address($829CEC)
      rlCopyCharacterDataFromBuffer             :?= address($839041)
      rlCopyExpandedCharacterDataBufferToBuffer :?= address($83905C)
      rlCombineCharacterDataAndClassBases       :?= address($8390BE)
      rlGetItemNamePointer                      :?= address($83931A)
      rlGetCharacterNamePointer                 :?= address($839334)
      rlGetClassNamePointer                     :?= address($839351)
      rlCheckItemEquippable                     :?= address($83965E)
      rlCopyItemDataToBuffer                    :?= address($83B00D)
      rlGetTransformedItem                      :?= address($83B1A9)
      rlDMASheetIconByTileIndex                 :?= address($83C63F)
      rsRenderSheetIconByTileIndex              :?= address($83C671)
      rlUnknownClearVRAM9FE0                    :?= address($848A20)
      rlConvertNumberToBCD                      :?= address($85870E)
      rlDrawNumberMenuTextFromBCD               :?= address($8587D0)
      rlDrawNumberMenuTextOrDoubleDash          :?= address($858884)
      rlDrawItemCurrentDurability               :?= address($858921)
      rlDrawRightFacingCursor                   :?= address($859013)
      rlDrawRightFacingStaticCursor             :?= address($8590E8)
      rlUnknown8591F0                           :?= address($8591F0)
      rlUnknown859205                           :?= address($859205)
      rlUnknown859219                           :?= address($859219)
      rlUnknown85968D                           :?= address($85968D)
      rlDrawWindowBackgroundFromTilemapInfo     :?= address($87D6FC)
      rlDrawMenuText                            :?= address($87E728)
      rlClearIconArray                          :?= address($8A8060)
      rlRenderSheetIconSprites                  :?= address($8A8126)
      rlGetTransformedItemWithIcon              :?= address($8AB384)
      rlDrawBGPortraitByCharacter               :?= address($8CC137)
      rlDrawPortraitSlot1Tilemap                :?= address($8CC1B1)
      rlDrawPortraitSlot0Tilemap                :?= address($8CC1BB)

      procItemInfo                              :?= address($81F5D1)
      procTradeItemInfoWindow                   :?= address($81FD0D)

      aInfoWindowPalette                        :?= address($F4FF60)

      aGenericBG3TilemapInfo                    :?= address($83C0F6)
      aGenericBG1TilemapInfo                    :?= address($83C0FF)

      ; TODO: define these elsewhere

      TextWhite :?= 0
      TextBrown :?= 1
      TextBlue  :?= 2
      TextGray  :?= 3

      TradeTypeSteal :?= 1
      TradeTypeTrade :?= 2

    .endweak

    ; Menu configuration

      TradeWindowConfig .namespace

        ; I feel like I'm going to regret treating
        ; the items subwindow as vertically-overlapping
        ; the info subwindow by a tile.

        LeftInfoBoxPosition  = ( 0, 0)
        RightInfoBoxPosition = (16, 0)

        LeftItemBoxPosition  = ( 0, 9)
        RightItemBoxPosition = (16, 9)

        ; Possibly confusing, but the info window
        ; is on the right side for items on the left
        ; and vice versa.

        LeftItemInfoWindowX  = 20
        RightItemInfoWindowX =  4

        ItemInfoWindowY = 11

        ; For shading vertical regions

        UpperBound = (LeftInfoBoxPosition[1], InfoBox.Size[1])
        LowerBound = (InfoBox.Size[1], ItemBox.Size[1] - (InfoBox.Size[1] - LeftItemBoxPosition[1]))

        OAMBase = $0000
        BG1Base = $4000
        BG2Base = BG1Base
        BG3Base = $A000

        BG1TilemapPosition = $E000
        BG2TilemapPosition = $F000
        ; BG3TilemapPosition = $A000 ; See below

        OAMTilesPosition := OAMBase + $2D00
        OAMAllocate .function Size
          Return := TradeWindowConfig.OAMTilesPosition
          TradeWindowConfig.OAMTilesPosition += Size
        .endfunction Return

        BG12TilesPosition := BG1Base
        BG12Allocate .function Size
          Return := TradeWindowConfig.BG12TilesPosition
          TradeWindowConfig.BG12TilesPosition += Size
        .endfunction Return

        BG3TilesPosition := BG3Base
        BG3Allocate .function Size
          Return := TradeWindowConfig.BG3TilesPosition
          TradeWindowConfig.BG3TilesPosition += Size
        .endfunction Return

        LeftIconGraphicsPosition  = OAMAllocate(4 * size(Tile4bpp) * ItemBox.ItemCount)
        RightIconGraphicsPosition = OAMAllocate(4 * size(Tile4bpp) * ItemBox.ItemCount)

        ; Gap?

        _ := OAMAllocate($3800 - OAMTilesPosition)

        PossessionItemGraphicsPosition = OAMAllocate(16 * 2 * size(Tile4bpp))

        RightPortraitGraphicsPosition  = BG12Allocate(16 * 4 * size(Tile4bpp))
        MenuBackgroundGraphicsPosition = BG12Allocate(16 * 4 * size(Tile4bpp))

        BG3TilemapPosition           = BG3Allocate(64 * 32 * size(word))
        ; Yes, this is BG2 graphics. Thanks portrait system.
        LeftPortraitGraphicsPosition = BG3Allocate(16 * 4 * size(Tile4bpp))
        BG3MenuTilesPosition         = BG3Allocate(16 * 40 * size(Tile2bpp))

        ; Because this gets used so often, we'll calculate
        ; it ahead of time.

        BG3MenuTilesBaseTile = VRAMToTile(BG3MenuTilesPosition, BG3Base, size(Tile2bpp))

        InfoBox .namespace

          Size     = (16, 10)

          Tilemap .namespace

            TL = (0, 0)
            TR = (Size[0] - 1, 0)
            BL = (0, Size[1] - 1)
            BR = (Size[0] - 1, Size[1] - 1)

          .endnamespace

          NamePosition     = (1, 1)
          ClassPosition    = (1, 3)
          PortraitPosition = (9, 1)

          Level .namespace

            Base = (1, 5)

            LabelPositions = [Base + (0, 0), Base + (1, 0)]
            LabelTiles     = [(14, 24), (15, 24)] ; TODO: menu text tile defs?

            NumberPosition = Base + (3, 0) ; Right-justified

          .endnamespace

          Experience .namespace

            Base = (5, 5)

            LabelPosition = Base + (0, 1)
            LabelTile     = (0, 25) ; TODO: menu text tile defs?

            NumberPosition = Base + (2, 0) ; Right-justified

          .endnamespace

          HP .namespace

            Base = (1, 7)

            LabelPositions = [Base + (0, 0), Base + (1, 0)]
            LabelTiles     = [(0, 26), (1, 26)] ; TODO: menu text tile defs?

            SlashPosition = Base + (4, 0)
            SlashTile     = (13, 12) ; TODO: menu text tile defs?

            CurrentNumberPosition = Base + (3, 0)
            MaxNumberPosition     = Base + (6, 0)

          .endnamespace

        .endnamespace

        ItemBox .namespace

          Size = (16, 19)

          Tilemap .namespace

            TL = (0, 0)
            TR = (Size[0] - 1, 0)
            BL = (0, Size[1] - 1)
            BR = (Size[0] - 1, Size[1] - 1)

          .endnamespace

          ItemCount = 7

          Base = (1, 3)

          RowBases = iter.map(iter.reversed, iter.zip_single(range(ItemCount + 1) * 2, 0))

          CursorOffset     = Base + ( 0,  0) ; Needs to be turned into pixels
          IconOffset       = Base + ( 2,  0)
          NameOffset       = Base + ( 4,  0)
          DurabilityOffset = Base + (13,  0) ; Right-justified

          ; Helper function
          _AddOffset .sfunction Offset, iter.starmap(op.add, iter.zip_single(RowBases, Offset))

          CursorPositions     = iter.starmap(op.mul, iter.zip_single(_AddOffset(CursorOffset), (8, 8)))
          IconPositions       = _AddOffset(IconOffset)
          NamePositions       = _AddOffset(NameOffset)
          DurabilityPositions = _AddOffset(DurabilityOffset)

          PossessionItemOffset = (2, 1) ; Needs to be turned into pixels

          PossessionItemPositions = iter.starmap(op.add, iter.zip_single(iter.zip_single(range(6) * 2, 0), PossessionItemOffset))

          PossessionItemSpriteTiles = VRAMToTile(PossessionItemGraphicsPosition, OAMBase) + (range(6) * 2)

        .endnamespace

      .endnamespace

  ; Freespace inclusions

    .section TradeWindowSection

      .with TradeWindowConfig

      startData

        aTradeWindowActions .binclude "../TABLES/TradeWindowActions.csv.asm" ; 85/A7A3

      endData
      startCode

        rsTradeWindowUpdate ; 85/A7AF

          .al
          .xl
          .autsiz
          .databank `wInfoWindowTarget

          ; Handles updating the trade window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsl rlRenderSheetIconSprites
          jsl rlTradeWindowRenderLabelSprites
          jsl rlTradeWindowRenderItemIcons

          ; Try updating the selected item.

          lda wInfoWindowTarget
          beq ++

            ldx wTradeWindowCursorOffset

            lda aInventoryBuffers,x
            cmp #-1
            bne +

              tdc

            +
            sta wInfoWindowTarget

          +

          ; Run the handler for the selected action.

          lda wTradeWindowActionIndex
          and #$00FF
          asl a
          asl a
          tax
          lda aTradeWindowActions,x
          sta wR0

          pea #<>(+)-1
          jmp (wR0)

          +
          rts

          .databank 0

        rsTradeWindowSelectNextAction ; 85/A7E5

          .al
          .xl
          .autsiz
          .databank `wInfoWindowTarget

          ; Gets the next action for the trade window.

          ; Inputs:
          ; wTradeWindowActionIndex: current action index

          ; Outputs:
          ; wTradeWindowActionIndex: new action index

          lda wTradeWindowActionIndex
          and #$00FF
          asl a
          asl a

          .rept size(addr)
            inc a
          .endrept

          tax
          lda aTradeWindowActions,x
          sta wTradeWindowActionIndex
          rts

          .databank 0

      endCode
      startData

        aTradeWindowItemNameCoordinates .block ; 85/A7F8

          _Coords := []
          .for _Side in [LeftItemBoxPosition, RightItemBoxPosition]
            _Coords ..= iter.starmap(op.add, iter.zip_single(ItemBox.NamePositions, _Side))
          .endfor

          .for _X, _Y in _Coords
            .word pack([_X, _Y])
          .endfor

        .endblock

        aTradeWindowItemDurabilityCoordinates .block ; 85/A818

          _Coords := []
          .for _Side in [LeftItemBoxPosition, RightItemBoxPosition]
            _Coords ..= iter.starmap(op.add, iter.zip_single(ItemBox.DurabilityPositions, _Side))
          .endfor

          .for _X, _Y in _Coords
            .word pack([_X, _Y])
          .endfor

        .endblock

        aTradeWindowItemIconCoordinates .block ; 85/A838

          _Coords := []
          .for _Side in [LeftItemBoxPosition, RightItemBoxPosition]
            _Coords ..= iter.starmap(op.add, iter.zip_single(ItemBox.IconPositions, _Side))
          .endfor

          .for _X, _Y in _Coords
            .word pack([_X, _Y])
          .endfor

        .endblock

        aTradeWindowCursorCoordinates .block ; 85/A858

          _Coords := []
          .for _Side in iter.starmap(op.mul, iter.zip_single([LeftItemBoxPosition, RightItemBoxPosition], (8, 8)))
            _Coords ..= iter.starmap(op.add, iter.zip_single(ItemBox.CursorPositions, _Side))
          .endfor

          .for _X, _Y in _Coords
            .word pack([_X, _Y])
          .endfor

        .endblock

        aTradeWindowIconTileIndexTable .block ; 85/A878

          .for _Start, _Buffer in [(LeftIconGraphicsPosition, aInventoryBuffers.Buffers[0]), (RightIconGraphicsPosition, aInventoryBuffers.Buffers[1])]

            .for _i in range(0, (len(structInventoryBuffer.Slots) - 1) * 4, 4)

              .word VRAMToTile(_Start, TradeWindowConfig.OAMBase) + _i

            .endfor

            .word 0

          .endfor

        .endblock

      endData
      startCode

        rlCreateTradeWindow ; 85/A898

          .autsiz
          .databank ?

          ; Handles populating the trade window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php
          phb

          sep #$20

          lda #`aBG3TilemapBuffer
          pha

          rep #$20

          plb

          .databank `aBG3TilemapBuffer

          lda #<>aBG3TilemapBuffer
          sta wR0

          lda #TilemapEntry(BG3MenuTilesBaseTile+C2I((15, 5)), 0, false, false, false)
          jsl rlFillTilemapByWord

          stz wBufferBG1HOFS
          stz wBufferBG1VOFS
          stz wBufferBG2HOFS
          stz wBufferBG2VOFS
          stz wBufferBG3HOFS
          stz wBufferBG3VOFS

          stz wTradeWindowActionIndex

          jsl rlUnknown809FE5
          jsl rlUnknownClearVRAM9FE0
          jsl rlUnknown85968D

          jsr rsTradeWindowGetInitiatorData
          jsr rsTradeWindowCopyPalettes
          jsr rsTradeWindowCopyItems

          jsl rlClearIconArray

          phx

          lda #(`procTradeItemInfoWindow)<<8
          sta lR44+size(byte)
          lda #<>procTradeItemInfoWindow
          sta lR44
          jsl rlProcEngineCreateProc

          plx

          stz wR0
          stz wR1

          lda #int(true)
          sta wR2

          stz wInfoWindowTarget

          jsl rlDrawItemInfo

          lda #(`procItemInfo)<<8
          sta lR44+size(byte)
          lda #<>procItemInfo
          sta lR44
          jsl rlProcEngineFindProc
          stz aProcSystem.aHeaderOnCycle,b,x

          jsr rsTradeWindowCopyItemIcons
          jsr rsTradeWindowDrawBordersAndLabels
          jsr rsTradeWindowDrawCharacterText
          jsr rsTradeWindowDrawBackground
          jsr rsTradeWindowCopyLabelGraphics

          jsl rlEnableBG1Sync
          jsl rlEnableBG2Sync

          jsr rsTradeWindowDrawItemText
          jsl rlEnableBG3Sync

          jsr rsTradeWindowDrawPortraits
          jsl rlUnknown8591F0

          ; Set shading regions

          ; lda #UpperBound[0]
          ; sta wR0
          stz wR0
          lda #UpperBound[1]
          sta wR1
          jsl rlUnknown859219

          lda #LowerBound[0]
          sta wR0
          lda #LowerBound[1]
          sta wR1
          jsl rlUnknown859219

          jsl rlUnknown859205

          lda #aTradeWindowActions.Default
          sta wTradeWindowActionIndex

          jsr rsTradeWindowGetInitialPosition

          plb
          plp
          rtl

          .databank 0

        rsTradeWindowGetInitiatorData ; 85/A955

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Fills out aTemporaryActionStruct
          ; with the unit and fetches their constitution, too.

          ; Inputs:
          ; None

          ; Outputs:
          ; aTemporaryActionStruct: filled with unit
          ; aBurstWindowCharacterBuffer: filled with unit+class data
          ; wTradeWindowInitiatorConstitution: unit's con

          lda #<>aSelectedCharacterBuffer
          sta wR0
          lda #<>aTemporaryActionStruct
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBuffer

          lda #<>aSelectedCharacterBuffer
          sta wR0
          lda #<>aBurstWindowCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBuffer
          jsl rlCombineCharacterDataAndClassBases

          lda aBurstWindowCharacterBuffer.Constitution,b
          and #$00FF
          sta wTradeWindowInitiatorConstitution

          rts

          .databank 0

        rsTradeWindowCopyPalettes ; 85/A97F

          .autsiz
          .databank `aBG3TilemapBuffer

          ; Copies the palettes for the trade window.
          ; Saves BG palette 3 (the menu background)
          ; into a temp location to restore later.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php

          rep #$30

          ; TODO:
          ; Add aInfoWindowPalette to properly get size

          _PaletteInfo  := [(aBGPaletteBuffer.aPalette3, aTradeWindowSavedPalette, size(aBGPaletteBuffer.aPalette3))]
          _PaletteInfo ..= [(aBGPaletteBuffer.aPalette2, aBGPaletteBuffer.aPalette3, size(aBGPaletteBuffer.aPalette2))]
          _PaletteInfo ..= [(aInfoWindowPalette, aBGPaletteBuffer.aPalette7, size(Palette))]

          .for _Source, _Dest, _Size in _PaletteInfo

            lda #(`_Source)<<8
            sta lR18+size(byte)
            lda #<>_Source
            sta lR18

            lda #(`_Dest)<<8
            sta lR19+size(byte)
            lda #<>_Dest
            sta lR19

            lda #_Size
            sta lR20

            jsl rlBlockCopy

          .endfor

          stz aBGPaletteBuffer.aPalette0.Colors[0],b

          plp
          rts

          .databank 0

        rsTradeWindowRestorePalette ; 85/A9DE

          .autsiz
          .databank `aBG3TilemapBuffer

          ; Restores BG palette 3 (the menu background) after the trade window.

          ; Inputs:
          ; aTradeWindowSavedPalette: filled with aBGPaletteBuffer.aPalette3

          ; Outputs:
          ; aBGPaletteBuffer.aPalette3: restored

          php

          rep #$30

          ; TODO:

          _PaletteInfo  := [(aTradeWindowSavedPalette, aBGPaletteBuffer.aPalette3, size(aTradeWindowSavedPalette))]

          .for _Source, _Dest, _Size in _PaletteInfo

            lda #(`_Source)<<8
            sta lR18+size(byte)
            lda #<>_Source
            sta lR18

            lda #(`_Dest)<<8
            sta lR19+size(byte)
            lda #<>_Dest
            sta lR19

            lda #_Size
            sta lR20

            jsl rlBlockCopy

          .endfor

          plp
          rts

          .databank 0

        rsTradeWindowCopyItems ; 85/AA00

          .al
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Copies the inventories of the trade window units into
          ; a buffer. The last slot (there are 8 slots, but units get
          ; up to 7 items) is filled with 0.

          ; Inputs:
          ; aSelectedCharacterBuffer: filled with initiator
          ; aItemSkillCharacterBuffer: filled with target

          ; Outputs:
          ; aInventoryBuffers[0]: filled with initiator's items
          ; aInventoryBuffers[1]: filled with target's items

          ; TODO: maybe use .brept for items?

          _InventorySlots := range(0, size(structCharacterDataRAM.Items), size(word))

          _InitiatorSlots := aSelectedCharacterBuffer.Items + _InventorySlots
          _TargetSlots    := aItemSkillCharacterBuffer.Items + _InventorySlots

          .for _Source, _Dest in [(_InitiatorSlots, aInventoryBuffers.Buffers[0]), (_TargetSlots, aInventoryBuffers.Buffers[1])]

            .for _SourceSlot, _DestSlot in iter.zip(_Source, _Dest.Slots)

              lda _SourceSlot,b
              sta _DestSlot

            .endfor

            stz _Dest.Slots[-1]

          .endfor

          rts

          .databank 0

        rsTradeWindowCopyItemIcons ; 85/AA5B

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Copies the icons for the trade window
          ; units' items into VRAM. Also fills out
          ; aTradeWindowIconIndexes with the items' icon indices.

          ; Inputs:
          ; aInventoryBuffers: filled with items

          ; Outputs:
          ; aTradeWindowIconIndexes: filled with indexes

          lda #size(aTradeWindowIconIndexes) - size(word)
          sta wTradeWindowInventoryOffset

          _Loop

            ldx wTradeWindowInventoryOffset

            ; Skip the capping 0 at the end of items.

            cpx #size(structExpandedCharacterDataRAM.Items)
            beq _NoIcon

            lda aInventoryBuffers,x
            beq _NoIcon

              jsl rlCopyItemDataToBuffer

              lda aItemDataBuffer.Icon,b
              and #$00FF
              sta wR0

              lda aTradeWindowIconTileIndexTable,x
              sta aTradeWindowIconIndexes,x
              sta wR1

              jsl rlDMASheetIconByTileIndex

            _Next

              .rept size(word)
                dec wTradeWindowInventoryOffset
              .endrept

              bpl _Loop

          rts

          _NoIcon

            stz aTradeWindowIconIndexes,x
            bra _Next

          .databank 0

        rsTradeWindowDrawBordersAndLabels ; 85/AA95

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Draws the trade window's window tiles
          ; and stat labels.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          ; Going to hash out the border tile defs
          ; first.

          _BaseTile := BG3MenuTilesBaseTile

          _TL     := TilemapEntry(_BaseTile + C2I((1, 24)), TextBrown, true, true, true)
          _Top    := TilemapEntry(_BaseTile + C2I((0, 24)), TextBrown, true, false, true)
          _TR     := TilemapEntry(_BaseTile + C2I((1, 24)), TextBrown, true, false, true)
          _Left   := TilemapEntry(_BaseTile + C2I((2, 24)), TextBrown, true, true, false)
          _Right  := TilemapEntry(_BaseTile + C2I((2, 24)), TextBrown, true, false, false)
          _BL     := TilemapEntry(_BaseTile + C2I((1, 24)), TextBrown, true, true, false)
          _Bottom := TilemapEntry(_BaseTile + C2I((0, 24)), TextBrown, true, false, false)
          _BR     := TilemapEntry(_BaseTile + C2I((1, 24)), TextBrown, true, false, false)

          ; Helpers for BG3 tilemaps

          _TMPosition .sfunction Coords, aBG3TilemapBuffer + (C2I(Coords, 32) * size(word))
          _TME .sfunction Coords, TilemapEntry(BG3MenuTilesBaseTile + C2I(Coords), TextBrown, true, false, false)

          ldx #((InfoBox.Size[0] - 2) - 1) * size(word)

          -
          lda #_Bottom

          sta _TMPosition(LeftInfoBoxPosition  + InfoBox.Tilemap.BL + (1, 0)),x
          sta _TMPosition(RightInfoBoxPosition + InfoBox.Tilemap.BL + (1, 0)),x

          sta _TMPosition(LeftItemBoxPosition  + ItemBox.Tilemap.BL + (1, 0)),x
          sta _TMPosition(RightItemBoxPosition + ItemBox.Tilemap.BL + (1, 0)),x

          lda #_Top

          sta _TMPosition(LeftInfoBoxPosition  + InfoBox.Tilemap.TL + (1, 0)),x
          sta _TMPosition(RightInfoBoxPosition + InfoBox.Tilemap.TL + (1, 0)),x

          dec x
          dec x
          bpl -

          ldx #(LeftItemBoxPosition[1] + ItemBox.Size[1] - 2 - 1) * (32 * size(word))

          -
          lda #_Right
          sta _TMPosition(LeftInfoBoxPosition  + InfoBox.Tilemap.TR + (0, 1)),x
          sta _TMPosition(RightInfoBoxPosition + InfoBox.Tilemap.TR + (0, 1)),x

          lda #_Left
          sta _TMPosition(LeftInfoBoxPosition  + InfoBox.Tilemap.TL + (0, 1)),x
          sta _TMPosition(RightInfoBoxPosition + InfoBox.Tilemap.TL + (0, 1)),x

          txa
          sec
          sbc #32 * size(word)
          tax
          bpl -

          lda #_BR
          sta _TMPosition(RightItemBoxPosition + ItemBox.Tilemap.BR)
          sta _TMPosition(LeftItemBoxPosition  + ItemBox.Tilemap.BR)
          sta _TMPosition(RightInfoBoxPosition + InfoBox.Tilemap.BR)
          sta _TMPosition(LeftInfoBoxPosition  + InfoBox.Tilemap.BR)

          lda #_BL
          sta _TMPosition(LeftItemBoxPosition  + ItemBox.Tilemap.BL)
          sta _TMPosition(RightItemBoxPosition + ItemBox.Tilemap.BL)
          sta _TMPosition(LeftInfoBoxPosition  + InfoBox.Tilemap.BL)
          sta _TMPosition(RightInfoBoxPosition + InfoBox.Tilemap.BL)

          lda #_TL
          sta _TMPosition(LeftInfoBoxPosition  + InfoBox.Tilemap.TL)
          sta _TMPosition(RightInfoBoxPosition + InfoBox.Tilemap.TL)

          lda #_TR
          sta _TMPosition(LeftInfoBoxPosition  + InfoBox.Tilemap.TR)
          sta _TMPosition(RightInfoBoxPosition + InfoBox.Tilemap.TR)

          _LabelTiles  := [(InfoBox.HP.SlashTile, InfoBox.HP.SlashPosition)]
          _LabelTiles ..= [(InfoBox.HP.LabelTiles[0], InfoBox.HP.LabelPositions[0])]
          _LabelTiles ..= [(InfoBox.HP.LabelTiles[1], InfoBox.HP.LabelPositions[1])]
          _LabelTiles ..= [(InfoBox.Level.LabelTiles[0], InfoBox.Level.LabelPositions[0])]
          _LabelTiles ..= [(InfoBox.Level.LabelTiles[1], InfoBox.Level.LabelPositions[1])]

          .for _GraphicsCoords, _TilemapCoords in _LabelTiles

            lda #_TME(_GraphicsCoords)
            ldx #C2I(_TilemapCoords, 32) * size(word)
            jsr _WriteTextTilemapBothSides

          .endfor

          lda #_TME(InfoBox.Experience.LabelTile)
          ldx #C2I(InfoBox.Experience.LabelPosition - (0, 1), 32) * size(word)
          sta _TMPosition(LeftInfoBoxPosition  + (0, 1)),x
          sta _TMPosition(RightInfoBoxPosition + (0, 1)),x

          rts

          _WriteTextTilemapBothSides ; 85/AB3B

            ; This is a helper to write blocky text tiles.

            ; Inputs:
            ; A: Upper tile's tilemap entry

            ; Outputs:
            ; None

            sta _TMPosition(LeftInfoBoxPosition  + (0, 0)),x
            sta _TMPosition(RightInfoBoxPosition + (0, 0)),x

            clc
            adc #TilemapEntry(C2I((0, 1)), 0, false, false, false)

            sta _TMPosition(LeftInfoBoxPosition  + (0, 1)),x
            sta _TMPosition(RightInfoBoxPosition + (0, 1)),x

            rts

          .databank 0

        rsTradeWindowDrawBackground ; 85/AB4C

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Draws the background for the trade window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php

          rep #$30

          stz wBufferBG1HOFS
          stz wBufferBG1VOFS
          stz wBufferBG2HOFS
          stz wBufferBG2VOFS

          lda #<>aGenericBG1TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b
          lda #>`aGenericBG1TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

          lda lWindowBackgroundPatternPointer
          sta lR18
          lda lWindowBackgroundPatternPointer+size(byte)
          sta lR18+size(byte)

          lda #TilemapEntry(0, 3, false, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          jsl rlDrawWindowBackgroundFromTilemapInfo

          ; BG2 gets filled with a special blank tile.

          ; TODO: actual def for this?

          lda #<>aBG2TilemapBuffer
          sta wR0
          lda #TilemapEntry(C2I((15, 47)), 0, false, false, false)
          jsl rlFillTilemapByWord

          plp
          rts

          .databank 0

        rsTradeWindowCopyLabelGraphics ; 85/AB85

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Copies the `possession item` graphics
          ; to VRAM.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          ; TODO:
          ; `Possession Item` label graphics, size, palette
          ; $7FB0F5

          lda #(`$9EF0AC)<<8
          sta lR18+size(byte)
          lda #<>$9EF0AC
          sta lR18
          lda #(`$7FB0F5)<<8
          sta lR19+size(byte)
          lda #<>$7FB0F5
          sta lR19
          jsl rlAppendDecompList

          jsl rlDMAByStruct

            .dstruct structDMAToVRAM, $7FB0F5, $0400, VMAIN_Setting(true), PossessionItemGraphicsPosition

          lda #(`$9E8686)<<8
          sta lR18+size(byte)
          lda #<>$9E8686
          sta lR18
          lda #(`aOAMPaletteBuffer.aPalette7)<<8
          sta lR19+size(byte)
          lda #<>aOAMPaletteBuffer.aPalette7
          sta lR19
          lda #size(Palette)
          sta lR20
          jsl rlBlockCopy

          rts

          .databank 0

        rlTradeWindowRenderLabelSprites ; 85/ABC8

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Renders the `possession item` graphics as sprites.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          phb
          php

          phk
          plb

          .databank `*

          stz wR0
          stz wR1
          stz wR4
          stz wR5
          ldy #<>_Sprites
          jsl rlPushToOAMBuffer

          plp
          plb
          rtl

          _SpriteList := []

          _SpriteCoordsTiles  := iter.starmap(op.add, iter.zip_single(ItemBox.PossessionItemPositions, LeftItemBoxPosition))
          _SpriteCoordsTiles ..= iter.starmap(op.add, iter.zip_single(ItemBox.PossessionItemPositions, RightItemBoxPosition))

          .for _i, _Coords in iter.enumerate(iter.starmap(op.mul, iter.zip_single(_SpriteCoordsTiles, (8, 8))))

            _SpriteList ..= [[_Coords, $21, SpriteLarge, ItemBox.PossessionItemSpriteTiles[_i % 6], 2, 7, false, false]]

          .endfor

          _Sprites .dstruct structSpriteArray, rlTradeWindowRenderLabelSprites._SpriteList

          .databank 0

        rsTradeWindowDrawCharacterText ; 85/AC1C

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Draws the trade window's numbers and
          ; unit text.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda aTemporaryActionStruct.Character,b
          jsl rlGetCharacterNamePointer
          ldx #pack(LeftInfoBoxPosition + InfoBox.NamePosition)
          jsr _rsDrawText

          lda aItemSkillCharacterBuffer.Character,b
          jsl rlGetCharacterNamePointer
          ldx #pack(RightInfoBoxPosition + InfoBox.NamePosition)
          jsr _rsDrawText

          lda aTemporaryActionStruct.Class,b
          jsl rlGetClassNamePointer
          ldx #pack(LeftInfoBoxPosition + InfoBox.ClassPosition)
          jsr _rsDrawText

          lda aItemSkillCharacterBuffer.Class,b
          jsl rlGetClassNamePointer
          ldx #pack(RightInfoBoxPosition + InfoBox.ClassPosition)
          jsr _rsDrawText

          lda aTemporaryActionStruct.Level,b
          ldx #pack(LeftInfoBoxPosition + InfoBox.Level.NumberPosition)
          jsr _rsDrawNumber

          lda aItemSkillCharacterBuffer.Level,b
          ldx #pack(RightInfoBoxPosition + InfoBox.Level.NumberPosition)
          jsr _rsDrawNumber

          lda aTemporaryActionStruct.CurrentHP,b
          ldx #pack(LeftInfoBoxPosition + InfoBox.HP.CurrentNumberPosition)
          jsr _rsDrawNumber

          lda aItemSkillCharacterBuffer.CurrentHP,b
          ldx #pack(RightInfoBoxPosition + InfoBox.HP.CurrentNumberPosition)
          jsr _rsDrawNumber

          lda aTemporaryActionStruct.MaxHP,b
          ldx #pack(LeftInfoBoxPosition + InfoBox.HP.MaxNumberPosition)
          jsr _rsDrawNumber

          lda aItemSkillCharacterBuffer.MaxHP,b
          ldx #pack(RightInfoBoxPosition + InfoBox.HP.MaxNumberPosition)
          jsr _rsDrawNumber

          lda aTemporaryActionStruct.Experience,b
          ldx #pack(LeftInfoBoxPosition + InfoBox.Experience.NumberPosition)
          jsr _rsDrawNumberOrDoubleDash

          lda aItemSkillCharacterBuffer.Experience,b
          ldx #pack(RightInfoBoxPosition + InfoBox.Experience.NumberPosition)
          jsr _rsDrawNumberOrDoubleDash

          rts

          _rsDrawText ; 85/AC99

            ; This helper function draws normal menu text.

            ; Inputs:
            ; X: packed coordinates
            ; lR18: long pointer to text

            ; Outputs:
            ; None

            lda #<>aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer,b
            lda #>`aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

            lda #TilemapEntry(BG3MenuTilesBaseTile, TextWhite, true, false, false)
            sta aCurrentTilemapInfo.wBaseTile,b

            jsl rlDrawMenuText

            rts

          _rsDrawNumber

            ; This helper function draws a number.

            ; Inputs:
            ; A: 8-bit number:
            ; X: packed coordinates

            ; Outputs:
            ; None

            phx

            sta lR18
            stz lR18+size(byte)
            jsl rlConvertNumberToBCD

            plx

            lda #<>aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer,b
            lda #>`aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

            lda #TilemapEntry(BG3MenuTilesBaseTile + C2I((0, 18)), TextWhite, true, false, false)
            sta aCurrentTilemapInfo.wBaseTile,b

            jsl rlDrawNumberMenuTextFromBCD

            rts

          _rsDrawNumberOrDoubleDash

            ; This helpers draws a number or a `--` if the
            ; number is $FF.

            ; Inputs:
            ; A: 8-bit number
            ; X: packed coordinates

            ; Outputs:
            ; None

            sta lR18
            stz lR18+size(byte)
            jsl rlDrawNumberMenuTextOrDoubleDash

            rts

          .databank 0

        rsTradeWindowDrawItemText ; 85/ACDA

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Draws the trade window items' names and
          ; durabilities. Also fills out an array of
          ; usability/stealability markers.

          ; Inputs:
          ; aInventoryBuffers: filled with items
          
          ; Outputs:
          ; aTradeWindowItemTypes: filled with values denoting
          ;   either stealability or usability:
          ;   0 if able, size(word) if not.

          lda #size(aTradeWindowIconIndexes) - size(word)
          sta wTradeWindowInventoryOffset

          _Loop

            ldx wTradeWindowInventoryOffset

            ; Skip the capping 0 at the end of the first
            ; set of icons.

            cpx #size(structExpandedCharacterDataRAM.Items)
            beq _Next

              lda aInventoryBuffers,x
              jsl rlCopyItemDataToBuffer

              jsr _rsGetTextColor

              ldx wTradeWindowInventoryOffset
              sta aTradeWindowItemTypes,x

              jsr _rsDrawText

            _Next

              .rept size(word)
                dec wTradeWindowInventoryOffset
              .endrept

              bpl _Loop

          rts

          _rsGetTextColor ; 85/AD04

            .al
            .xl
            .autsiz
            .databank `aBG3TilemapBuffer

            ; This helper function gets the base tile for
            ; text and also if the item is usable/stealable

            ; Inputs:
            ; aItemDataBuffer: filled with item

            ; Outputs:
            ; wTradeWindowTempTextType: 0 if able, size(word) if not

            ; If we're stealing, then the color denotes if the
            ; initiator has enough Constitution to move the item.

            ; If we're trading, we need to know if the unit holding
            ; the item is able to use it.

            lda wTradeWindowType
            cmp #TradeTypeSteal
            beq _CheckCon

              lda #<>aTemporaryActionStruct
              sta wR1

              lda wTradeWindowInventoryOffset
              and #size(structInventoryBuffer)
              beq +

                lda #<>aItemSkillCharacterBuffer
                sta wR1

              +
              jsl rlCheckItemEquippable
              bcs _White

            _Gray

              lda #TilemapEntry(BG3MenuTilesBaseTile, TextGray, true, false, false)
              sta wTradeWindowTempTextBaseTile

              lda #size(word)
              sta wTradeWindowTempTextType

              rts

            _White

              lda #TilemapEntry(BG3MenuTilesBaseTile, TextWhite, true, false, false)
              sta wTradeWindowTempTextBaseTile

              lda #0
              sta wTradeWindowTempTextType

              rts

            _CheckCon

              lda aItemDataBuffer.Weight,b
              and #$00FF
              cmp wTradeWindowInitiatorConstitution
              blt _White

                bra _Gray

          _rsDrawText ; 85/AD4B

            .al
            .xl
            .autsiz
            .databank `aBG3TilemapBuffer

            ; This helper function handles actually drawing
            ; item's name and durability.

            lda #<>aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer,b
            lda #>`aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

            lda wTradeWindowTempTextBaseTile
            sta aCurrentTilemapInfo.wBaseTile,b

            ldx wTradeWindowInventoryOffset
            lda aTradeWindowItemNameCoordinates,x
            tax

            ; Before we draw the text, ensure that the
            ; area is clear by drawing a blank string.

            lda #<>_ClearString
            sta lR18
            lda #>`_ClearString
            sta lR18+size(byte)

            jsl rlDrawMenuText

            ; If we have an item in this slot, draw its name
            ; and durability.

            lda aItemDataBuffer.DisplayedWeapon,b
            and #$00FF
            beq +

              jsl rlGetItemNamePointer

              ldx wTradeWindowInventoryOffset
              lda aTradeWindowItemNameCoordinates,x
              tax
              jsl rlDrawMenuText

              lda wTradeWindowTempTextType
              sta aCurrentTilemapInfo.wBaseTile,b

              ldx wTradeWindowInventoryOffset
              lda aTradeWindowItemDurabilityCoordinates,x
              tax
              jsl rlDrawItemCurrentDurability

            +
            rts

            _ClearString
              .enc "SJIS"
              .text ("　" x 10) .. "\n"

          .databank 0

        rsTradeWindowActionDefault ; 85/ADB4

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Handles trade window functionality
          ; before an item is selected.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; lMenuAPressCallback: short pointer to
          ;   rsTradeWindowTrySelectItemCallback
          ; lMenuBPressCallback: short pointer to
          ;   rsTradeWindowCloseMenuCallback

          ; If we've just stolen an item, immediately go to
          ; close the menu.

          lda wUnknown7E4F98
          bit #$0004 ; TODO: 7E4F98 bits
          beq +

            jmp rsTradeWindowCloseMenuCallback

          +

          jsl rlTradeWindowRenderCursor
          jsr rsTradeWindowUpdateUnknownPosition

          lda #<>rsTradeWindowTrySelectItemCallback
          sta lMenuAPressCallback

          lda #<>rsTradeWindowCloseMenuCallback
          sta lMenuBPressCallback

          jsr rsTradeWindowHandleInput
          rts

          .databank 0

        rsTradeWindowActionItemSelected ; 85/ADD6

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Handles trade window functionality
          ; once an item is selected.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; lMenuAPressCallback: short pointer to
          ;   rsTradeWindowTrySelectItemCallback
          ; lMenuBPressCallback: short pointer to
          ;   rsTradeWindowCloseMenuCallback

          ; I don't know what the significance of this $27
          ; is, because this value is in range(0, $20, 2).

          ; It gets either 0 or $10, for left or right side.

          lda wTradeWindowCursorOffset
          and #pack([size(structInventoryBuffer), $27])
          sta wTradeWindowSelectedSideOffset

          jsl rlTradeWindowRenderCursor
          jsr rsTradeWindowRenderSelectedItemCursor

          lda #<>rsTradeWindowTryMoveItemCallback
          sta lMenuAPressCallback

          lda #<>rsTradeWindowUnselectItemCallback
          sta lMenuBPressCallback

          jsr rsTradeWindowHandleInput
          rts

          .databank 0

        rsTradeWindowUnselectItemCallback ; 85/ADF6

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Handles unselecting an item.

          ; Inputs:
          ; None:

          ; Outputs:
          ; None

          ; During item selection, a -1 is inserted into
          ; the next free slot of the target. We need to clear
          ; it when unselecting.

          jsr rsTradeWindowTryUnmarkFreeSlot

          lda #$0021 ; TODO: sound definitions
          jsl rlPlaySoundEffect

          lda wTradeWindowSelectedItemOffset
          sta wTradeWindowCursorOffset

          jsr rsTradeWindowSelectNextAction

          rts

          .databank 0

        rsTradeWindowCloseMenuCallback ; 85/AE0A

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Handles closing the trade window.
          ; It copies the changes to the units'
          ; inventories back to their buffers, and
          ; also writes the buffers back to their
          ; deployment slots (unless on the prep screen,
          ; where the initiator is copied by a separate thing).

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          ; Copy the items back.

          ; TODO: maybe use .brept for items?

          _InventorySlots := range(0, size(structCharacterDataRAM.Items), size(word))

          _InitiatorSlots := aSelectedCharacterBuffer.Items + _InventorySlots
          _TargetSlots    := aItemSkillCharacterBuffer.Items + _InventorySlots

          .for _Source, _Dest in [(aInventoryBuffers.Buffers[0], _InitiatorSlots), (aInventoryBuffers.Buffers[1], _TargetSlots)]

            .for _SourceSlot, _DestSlot in iter.zip(_Source.Slots, _Dest)

              lda _SourceSlot
              sta _DestSlot,b

            .endfor

          .endfor

          lda #<>aItemSkillCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataFromBuffer

          lda wPrepScreenFlag,b
          beq +

            lda #<>aSelectedCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataFromBuffer

          +

          ; Run a callback, this is
          ; normally to fade out. On the
          ; prep screen the callback handles
          ; copying the initiator back to their
          ; deployment slot.

          lda lUnknown7EA4EC
          sta lR18
          lda lUnknown7EA4EC+size(byte)
          sta lR18+size(byte)
          phk
          pea #<>(+)-1
          jmp [lR18]

          +

          lda #aTradeWindowActions.Close
          sta wTradeWindowActionIndex

          lda #$0021 ; TODO: sound definitions
          jsl rlPlaySoundEffect

          ; Flag whether we've stolen or not.

          lda wUnknown7E4F98
          bit #$0004 ; TODO: 7E4F98 bits
          bne +

            lda #$0005 ; TODO: these action indices
            sta wUnknown000E25,b
            rts

          +
          lda #$001D ; TODO: these action indices
          sta wUnknown000E25,b
          rts

          .databank 0

        rsTradeWindowUnknownHandleInput ; 85/AEA9

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; This is rsTradeWindowHandleInput
          ; except that it doesn't set
          ; wTradeWindowSelectedSideOffset.
          ; I don't think this is referenced?

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          pea #<>_End-1

          lda wJoy1Repeated
          bit #JOY_Up
          beq +

            jmp rsTradeWindowHandleInput._Up_Press

          +
          bit #JOY_Down
          beq +

            jmp rsTradeWindowHandleInput._Down_Press

          +
          lda wJoy1New
          bit #JOY_A
          beq +

            jmp rsTradeWindowHandleInput._A_Press

          +
          bit #JOY_B
          beq +

            jmp rsTradeWindowHandleInput._B_Press

          +
          bit #JOY_X
          beq _End

            jmp rsTradeWindowHandleInput._X_Press

          _End
          rts

          .databank 0

        rsTradeWindow85AED9 ; 85/AED9

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Unreferenced?

          ldx wTradeWindowSelectedItemOffset

          inc x
          inc x

          lda aInventoryBuffers,x
          beq +

            stx wTradeWindowSelectedItemOffset
            rts

          +

          ; 0 or 8, but the significance is
          ; unknown, considering that's only
          ; 5 items.

          lda wTradeWindowCursorOffset
          and #$0008
          eor #$0008
          sta wTradeWindowCursorOffset

          rts

          .databank 0

        rsTradeWindow85AEF9 ; 85/AEF9

          .al
          .xl
          .autsiz
          .databank `aBG3TilemapBuffer

          ; Unreferenced?

          -
            lda wTradeWindowSelectedItemOffset

            dec a
            dec a

            sta wTradeWindowSelectedItemOffset

            and #size(word) * (8 - 1)
            cmp #size(word) * (8 - 1)
            beq +

              ldx wTradeWindowSelectedItemOffset
              lda aInventoryBuffers,x
              beq -

                rts

          +
          lda wTradeWindowSelectedSideOffset
          clc
          adc #size(word) * (8 - 1)
          tax

          -
            dec x
            dec x

            lda aInventoryBuffers,x
            beq -

          stx wTradeWindowSelectedItemOffset
          rts

          .databank 0

        rsTradeWindowActionClose ; 85/AF20

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; This is a dummy routine that is run
          ; when the trade window closes.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          rts

          .databank 0

        rlTradeWindowRenderItemIcons ; 85/AF21

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Renders the trade window's item icons.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #size(aTradeWindowIconIndexes) - size(word)
          sta wTradeWindowInventoryOffset

          -
            ldx wTradeWindowInventoryOffset

            lda aTradeWindowIconIndexes,x
            beq +

              sta wR2

              lda aTradeWindowItemIconCoordinates,x
              sta wR1
              and #$00FF
              sta wR0

              lda wR1
              xba
              and #$00FF
              sta wR1
              jsl rsRenderSheetIconByTileIndex

            +
            dec wTradeWindowInventoryOffset
            dec wTradeWindowInventoryOffset
            bpl -

          rtl

          .databank 0

        rlTradeWindowRenderCursor ; 85/AF51

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Renders the trade window's main cursor.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          ldx wTradeWindowCursorOffset

          lda aTradeWindowCursorCoordinates,x
          and #$00FF
          sta wR0

          lda aTradeWindowCursorCoordinates+size(byte),x
          and #$00FF
          sta wR1
          jsl rlDrawRightFacingCursor

          rtl

          .databank 0

        rsTradeWindowRenderSelectedItemCursor ; 85/AF6B

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Renders the trade window's secondary
          ; curstor, which is used for the selected item.

          ldx wTradeWindowSelectedItemOffset

          lda aTradeWindowCursorCoordinates,x
          and #$00FF
          sta wR0

          lda aTradeWindowCursorCoordinates+size(byte),x
          and #$00FF
          sta wR1

          jsl rlDrawRightFacingStaticCursor

          rts

        rsTradeWindowUpdateUnknownPosition ; 85/AF85

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; This sets wTradeWindowCursorUnknownOffset
          ; but the value is never read.

          ; Inputs:
          ; wTradeWindowCursorOffset
          
          ; Outputs:
          ; wTradeWindowCursorUnknownOffset

          lda wTradeWindowCursorOffset

          lsr a
          lsr a
          lsr a

          and #$0002
          tax

          lda _Table,x
          sta wTradeWindowCursorUnknownOffset

          rts

          _Table .word 8, 12

          .databank 0

        rsTradeWindowGetNextFreeSlot ; 85/AF9B

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Tries to get the next free inventory
          ; slot.

          ; Inputs:
          ; X: offset into aInventoryBuffers

          ; Outputs:
          ; X: offset of free slot
          ; Carry clear if slot found else set

          ldy #6

          -
            lda aInventoryBuffers,x
            beq +

              .rept size(word)
                inc x
              .endrept

              dec y
              bpl -

                sec
                rts

            +
            clc
            rts

          .databank 0

        rsTradeWindowMoveTakenItemToEmptySlot ; 85/AFAC

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Moves a (transformed) item from one
          ; slot to another. Also marks that an item
          ; was stolen, if stealing, and marks that an
          ; item was traded.

          ; Inputs:
          ; wR0: offset of source slot into aInventoryBuffers
          ; wR1: offset of dest slot into aInventoryBuffers

          ; Outputs:
          ; wUnknown7E4F96: -1
          ; wUnknown7E4F98: bit $0004 set if stealing

          phx
          phy

          ldx wR0
          jsl rlGetTransformedItem

          ldy wR1

          ; Move the item.

          lda aInventoryBuffers,x
          sta aInventoryBuffers,y

          stz aInventoryBuffers,x

          lda aTradeWindowIconIndexes,x
          sta aTradeWindowIconIndexes,y

          stz aTradeWindowIconIndexes,x

          ; Mark that an item was traded

          lda #-1
          sta wUnknown7E4F96

          lda #TradeTypeSteal
          cmp wTradeWindowType
          bne +

            lda wUnknown7E4F98
            ora #$0004 ; TODO: 7E4F98 bits
            sta wUnknown7E4F98

          +
          ply
          plx
          rts

          .databank 0

        rsTradeWindowSwapTakenItemWithSlot ; 85/AFE2

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Moves two (transformed) items between slots.
          ; Also marks that an item
          ; was stolen, if stealing, and marks that an
          ; item was traded.

          ; Inputs:
          ; wR0: offset of source slot into aInventoryBuffers
          ; wR1: offset of dest slot into aInventoryBuffers

          ; Outputs:
          ; wUnknown7E4F96: -1
          ; wUnknown7E4F98: bit $0004 set if stealing

          phx
          phy

          ldx wR0
          jsl rlGetTransformedItemWithIcon

          ldx wR1
          jsl rlGetTransformedItemWithIcon

          ldx wR0

          ldy wR1

          ; We use wR0 as a temp variable during the swap.

          lda aInventoryBuffers,x
          sta wR0

          lda aInventoryBuffers,y
          sta aInventoryBuffers,x

          lda wR0
          sta aInventoryBuffers,y

          lda aTradeWindowIconIndexes,x
          sta wR0

          lda aTradeWindowIconIndexes,y
          sta aTradeWindowIconIndexes,x

          lda wR0
          sta aTradeWindowIconIndexes,y

          ; Mark that an item was traded

          lda #-1
          sta wUnknown7E4F96

          lda #TradeTypeSteal
          cmp wTradeWindowType
          bne +

            lda wUnknown7E4F98
            ora #$0004
            sta wUnknown7E4F98

          +
          ply
          plx
          rts

          .databank 0

        rsTradeWindowFillInventoryGaps ; 85/B02E

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; This function shifts the items in an
          ; inventory up such that there are no gaps.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          ldy #(7 - 1) ; Loop counter

          ; Get the offset of the last possible
          ; item in the unit's inventory.

          txa
          clc
          adc #size(word) * (7 - 1)
          tax

          ; Scary magic time: We push a 0 terminator
          ; and then we push all of the items in their
          ; inventory onto the stack (and icons), skipping empty item
          ; slots. Once we've gone through all of the slots,
          ; we go through the stacked items, popping and
          ; storing into the inventory until we hit that
          ; 0 that we pushed first.

          lda #0
          pha

          -
            lda aInventoryBuffers,x
            beq +

              lda aTradeWindowIconIndexes,x
              pha

              lda aInventoryBuffers,x
              pha

              stz aInventoryBuffers,x
              stz aTradeWindowIconIndexes,x

            +
            dec x
            dec x
            dec y
            bpl -

          -
            pla
            ora #0
            beq +

              inc x
              inc x

              sta aInventoryBuffers,x

              pla
              sta aTradeWindowIconIndexes,x

              bra -

          +
          rts

          .databank 0

        rsTradeWindowTrySelectItemCallback ; 85/B065

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Called after selecting an item.
          ; Sets up the cursor positions for
          ; selecting the other unit's slot.

          ; Inputs:
          ; wTradeWindowCursorOffset: offset into aInventoryBuffers
          ;  of selected item

          ; Outputs:
          ; wTradeWindowSelectedItemOffset: offset into
          ;   aInventoryBuffers of selected item
          ; wTradeWindowCursorOffset: offset into aInventoryBuffers
          ;   of target slot
          ; wTradeWindowTargetEmptySlotOffset: -1 if target's
          ;   inventory is full else wTradeWindowCursorOffset

          ; If stealing, we need to check if the
          ; item was flagged as stealable.

          lda wTradeWindowType
          cmp #TradeTypeSteal
          bne _Trade

          ldx wTradeWindowCursorOffset
          lda aTradeWindowItemTypes,x
          beq _Trade

            lda #$0022 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rts

          _Trade
          lda #$000D ; TODO: sound definitions
          jsl rlPlaySoundEffect

          lda wTradeWindowCursorOffset
          sta wTradeWindowSelectedItemOffset

          ; Figure out where to put the cursor on the
          ; other side.

          ; Get the offset of the start
          ; of the opposite side.

          eor #size(structInventoryBuffer)
          and #size(structInventoryBuffer)
          tax

          lda #(7 - 1)
          sta wR0

          -
            lda aInventoryBuffers,x
            beq _HasSpace

              .rept size(word)
                inc x
              .endrept

              dec wR0
              bpl -

          ; Otherwise the other unit's inventory
          ; is full and we should put the cursor on
          ; the slot opposite our selected item.

          lda wTradeWindowSelectedItemOffset
          eor #size(structInventoryBuffer)
          sta wTradeWindowCursorOffset

          lda #-1
          sta wTradeWindowTargetEmptySlotOffset

          bra +

          _HasSpace

            stx wTradeWindowCursorOffset

            lda #-1
            sta aInventoryBuffers,x

            stx wTradeWindowTargetEmptySlotOffset

          +
          jmp rsTradeWindowSelectNextAction

          .databank 0

        rsTradeWindowTryMoveItemCallback ; 85/B0C1

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Called after a target inventory slot
          ; is selected. Handles updating the
          ; inventories.

          ; Inputs:
          ; wTradeWindowCursorOffset: offset into aInventoryBuffer
          ;   of dest slot
          ; wTradeWindowSelectedItemOffset: offset into aInventoryBuffer
          ;   of source slot

          ; Outputs:
          ; None

          ; If stealing, we need to check if the
          ; item was flagged as stealable.

          lda wTradeWindowType
          cmp #TradeTypeSteal
          bne +

          ldx wTradeWindowCursorOffset
          lda aTradeWindowItemTypes,x
          beq +

            lda #$0022 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rts

          +
          jsr rsTradeWindowTryUnmarkFreeSlot

          lda #$000D ; TODO: sound definitions
          jsl rlPlaySoundEffect

          ; These are swapped but that doesn't really matter?

          lda wTradeWindowCursorOffset
          sta wR0
          lda wTradeWindowSelectedItemOffset
          sta wR1
          jsr rsTradeWindowSwapTakenItemWithSlot

          ldx #(aInventoryBuffers.Buffers[0] - aInventoryBuffers)
          jsr rsTradeWindowFillInventoryGaps

          ldx #(aInventoryBuffers.Buffers[1] - aInventoryBuffers)
          jsr rsTradeWindowFillInventoryGaps

          jsr rsTradeWindowUpdateCursorAfterTransfer
          jsr rsTradeWindowDrawItemText
          jsl rlEnableBG3Sync

          jmp rsTradeWindowSelectNextAction

          .databank 0

        rsTradeWindowUpdateCursorAfterTransfer ; 85/B109

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Gets the new position of the cursor after
          ; moving an item, in case our source slot is now
          ; empty.

          ; Inputs:
          ; wTradeWindowSelectedItemOffset: offset of source
          ;   slot in aInventoryBuffers

          ; Outputs:
          ; wTradeWindowCursorOffset: new cursor offset

          ; This occurs after the transfer, so the
          ; inventory slot will have the new item or
          ; be empty.

          ldx wTradeWindowSelectedItemOffset
          lda aInventoryBuffers,x
          bne _HasItem

          ; Check if we've moved the last item out
          ; of the unit's inventory.

          txa
          and #narrowbits(~1, 4)
          beq _LastItem

            ; They still have items, move the cursor
            ; up a slot.

            lda wTradeWindowSelectedItemOffset

            .rept size(word)
              dec a
            .endrept

            sta wTradeWindowCursorOffset
            rts

          _HasItem

            ; Unit still has an item in the slot, don't
            ; change the cursor.

            lda wTradeWindowSelectedItemOffset
            sta wTradeWindowCursorOffset
            rts

          _LastItem

            ; Unit has no more items on that side, move to
            ; the first slot on the opposite side.

            lda wTradeWindowSelectedItemOffset
            eor #size(structInventoryBuffer)
            sta wTradeWindowCursorOffset

            rts

          .databank 0

        rsTradeWindowHandleInput ; 85/B131

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Handles inputs on the trade window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          ; I don't know what the significance of this $27
          ; is, because this value is in range(0, $20, 2).

          ; It gets either 0 or $10, for left or right side.

          lda wTradeWindowCursorOffset
          and #pack([size(structInventoryBuffer), $27])
          sta wTradeWindowSelectedSideOffset

          pea #<>_Return-1

          lda wJoy1Repeated

          bit #JOY_Up
          beq +

          jmp _Up_Press

          +
          bit #JOY_Down
          beq +

          jmp _Down_Press

          +
          lda wJoy1New

          bit #JOY_Left
          beq +

          jmp _Left_Press

          +
          bit #JOY_Right
          beq +

          jmp _Right_Press

          +
          bit #JOY_A
          beq +

          jmp _A_Press

          +
          bit #JOY_B
          beq +

          jmp _B_Press

          +
          bit #JOY_X
          bne _X_Press

          rts

          _Return
          rts

          _A_Press

            ; Pressing `A` selects an item to
            ; move or moves a selected item.

            lda wInfoWindowTarget
            beq +

              stz wInfoWindowTarget

              -
              rts

            +
            lda #(`procTradeItemInfoWindow)<<8
            sta lR44+size(byte)
            lda #<>procTradeItemInfoWindow
            sta lR44
            jsl rlProcEngineFindProc

            lda aProcSystem.aHeaderOnCycle,b,x ; TODO: procTradeItemInfoWindow
            cmp #<>$81FD16
            bne -

            lda lMenuAPressCallback
            bra _A_B_Goto

          _B_Press

            ; Pressing `B` unselects an item
            ; or closes the menu.

            lda wInfoWindowTarget
            beq +

              stz wInfoWindowTarget
              rts

            +
            lda lMenuBPressCallback

          _A_B_Goto
            sta wR0
            pea #<>(+)-1
            jmp (wR0)

            +
            rts

          _X_Press

            ; Pressing `X` opens or closes the item info window.

            lda wInfoWindowTarget
            beq +

              stz wInfoWindowTarget
              rts

            +
            ldx wTradeWindowCursorOffset
            lda aInventoryBuffers,x

            cmp #-1
            beq _X_End

              sta wInfoWindowTarget

              lda wTradeWindowSelectedSideOffset
              bne _Right

                lda #LeftItemInfoWindowX
                sta wR0
                bra +

              _Right
                lda #RightItemInfoWindowX
                sta wR0

              +
              lda #ItemInfoWindowY
              sta wR1

              jsl rlUpdateItemInfoProcCoordinates

            _X_End
            rts

          _Down_Press

            ; Pressing `Down` moves the cursor
            ; down, wrapping if at the bottom and
            ; if not held. It also updates the info window
            ; if it is open.

            ldx wTradeWindowCursorOffset
            inc x
            inc x
            lda aInventoryBuffers,x
            beq +

              stx wTradeWindowCursorOffset

              lda #$0009 ; TODO: sound definitions
              jsl rlPlaySoundEffect

              rts

            +
            lda wJoy1New
            cmp wJoy1Repeated
            bne +

              lda wTradeWindowCursorOffset
              and #size(structInventoryBuffer)
              sta wTradeWindowCursorOffset

              lda #$0009 ; TODO: sound definitions
              jsl rlPlaySoundEffect

            +
            rts

          _Up_Press

            ; Pressing `Up` moves the cursor
            ; up, wrapping if at the top and
            ; if not held. It also updates the info window
            ; if it is open.

            lda wTradeWindowCursorOffset
            and #(7 * size(word))
            beq +

              dec wTradeWindowCursorOffset
              dec wTradeWindowCursorOffset

              lda #$0009 ; TODO: sound definitions
              jsl rlPlaySoundEffect

              -
              rts

            +
            lda wJoy1New
            cmp wJoy1Repeated
            bne -

            lda wTradeWindowCursorOffset
            clc
            adc #(7 * size(word))
            tax

            -
            dec x
            dec x

            lda aInventoryBuffers,x
            beq -

            stx wTradeWindowCursorOffset

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rts

          _Left_Press

            ; Pressing `Left` switches which side
            ; of the window the cursor is on, if on the
            ; right side.

            lda wTradeWindowSelectedSideOffset
            beq +

              stz wInfoWindowTarget

              lda wTradeWindowCursorOffset
              and #narrowbits(~size(structInventoryBuffer), 4)
              jsr rsTradeWindowGetOccupiedSlot
              bcs +

                sta wTradeWindowCursorOffset

                lda #$000A ; TODO: sound definitions
                jsl rlPlaySoundEffect

            +
            rts

          _Right_Press

            ; Pressing `Right` switches which side
            ; of the window the cursor is on, if on the
            ; left side.

            lda wTradeWindowSelectedSideOffset
            bne +

              stz wInfoWindowTarget
              lda wTradeWindowCursorOffset
              ora #size(structInventoryBuffer)
              jsr rsTradeWindowGetOccupiedSlot
              bcs +

                sta wTradeWindowCursorOffset

                lda #$000A ; TODO: sound definitions
                jsl rlPlaySoundEffect

            +
            rts

          .databank 0

        rsTradeWindowGetOccupiedSlot ; 85/B281

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Given an offset into one of aInventoryBuffers,
          ; return the offset of the next (going upwards)
          ; slot that has an item.

          ; Inputs:
          ; A: offset into aInventoryBuffers

          ; Outputs:
          ; A: offset into aInventoryBuffers
          ; Carry clear if side has at least one item else set

          tax

          -

          ; Get the next slot.

          lda aInventoryBuffers,x
          bne _Found

            .rept size(word)
              dec x
            .endrept

            ; If we've hit the start of aInventoryBuffers[0]
            ; or [1], we have no items.

            bmi _NoItems

            cpx #(7 * size(word))
            beq _NoItems

              ; If we still have slots to check, loop.

              bra -

          _Found
          txa
          clc
          rts

          _NoItems
          sec
          rts

          .databank 0

        rsTradeWindow85B297 ; 85/B297

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Unknown.

          -
            lda aInventoryBuffers,x
            bne +

            .rept size(word)
              dec x
            .endrept

            txa
            and #(3 * size(word))
            cmp #(3 * size(word))
            bne -

              clc
              rts

          +
          stx wTradeWindowCursorOffset
          sec
          rts

          .databank 0

        rsTradeWindowDrawPortraits ; 85/B2AE

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Draws the units' portraits to the trade window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda aTemporaryActionStruct.Character,b
          sta wR0
          lda #0
          jsl rlDrawBGPortraitByCharacter

          lda aItemSkillCharacterBuffer.Character,b
          sta wR0
          lda #1
          jsl rlDrawBGPortraitByCharacter

          ; Helper for BG2 tilemaps
          _TMPosition .sfunction Coords, aBG2TilemapBuffer + (C2I(Coords, 32) * size(word))

          lda #<>_TMPosition(LeftInfoBoxPosition + InfoBox.PortraitPosition)
          sta wR0
          jsl rlDrawPortraitSlot0Tilemap

          lda #<>_TMPosition(RightInfoBoxPosition + InfoBox.PortraitPosition)
          sta wR0
          jsl rlDrawPortraitSlot1Tilemap

          jsl rlEnableBG2Sync

          rts

          .databank 0

        rsTradeWindowGetInitialPosition ; 85/B2DD

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Sets the starting cursor position for
          ; the trade window.

          ; Inputs:
          ; wTradeWindowCursorStartingOffset: offset into aInventoryBuffers

          ; Outputs:
          ; wTradeWindowCursorOffset: offset into aInventoryBuffers

          ; If we passed in a specific place, use that.
          ; If we're stealing, put the cursor over the
          ; target's first item slot, unless their inventory
          ; is empty. Otherwise, we put the cursor
          ; over the initiator's first item.

          lda wTradeWindowCursorStartingOffset
          bne _ByInput

          lda aInventoryBuffers.Buffers[1].Slots[0]
          beq +

            lda wTradeWindowType
            cmp #TradeTypeSteal
            beq _Steal

          +
          ldx #aInventoryBuffers.Buffers[0].Slots[0] - aInventoryBuffers

          -
          lda aInventoryBuffers,x
          bne +

            .rept size(word)
              inc x
            .endrept

            bra -

          +
          stx wTradeWindowCursorOffset
          rts

          _Steal

            lda #size(structInventoryBuffer)
            sta wTradeWindowCursorOffset
            rts

          _ByInput

            sta wTradeWindowCursorOffset
            rts

          .databank 0

        rsTradeWindowTryUnmarkFreeSlot ; 85/B30A

          .al
          .xl
          .autsiz
          .databank `wTradeWindowInventoryOffset

          ; Some operations mark the next open slot
          ; in an inventory buffer with -1, but we
          ; need to return that to being 0 after the
          ; operation.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          ldx wTradeWindowTargetEmptySlotOffset
          bmi +

            stz aInventoryBuffers,x

          +
          rts

          .databank 0

        .endwith ; TradeWindowConfig

      endCode

    .endsection TradeWindowSection

.endif ; GUARD_FE5_TRADE_WINDOW
