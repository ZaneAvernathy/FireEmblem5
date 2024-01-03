
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_CONVOY_WINDOW :?= false
.if (!GUARD_FE5_CONVOY_WINDOW)
  GUARD_FE5_CONVOY_WINDOW := true

  ; Definitions

    .weak

      rlPlaySoundEffect                     :?= address($808C87)
      rsPostBMenuWindowCallback             :?= address($809E46)
      rlDMAByStruct                         :?= address($80AE2E)
      rlDMAByPointer                        :?= address($80AEF9)
      rlAppendDecompList                    :?= address($80B00A)
      rlGetRandomNumber100                  :?= address($80B0E6)
      rlBlockCopy                           :?= address($80B340)
      rlFillMapByWord                       :?= address($80E849)
      rlFillTilemapByWord                   :?= address($80E89F)
      rlFillTilemapRectByWord               :?= address($80E91F)
      rlEnableBG3Sync                       :?= address($81B212)
      rlGetLeastValuableConvoyItemOffset    :?= address($81BC6F)
      rlInventoryDrawMapSpriteCheckGrayed   :?= address($81D489)
      rlPrepItemsDrawDiscardCursor          :?= address($81F307)
      rlDrawItemInfo                        :?= address($81F590)
      rlCloseItemInfo                       :?= address($81F873)
      rlCopyWindowTilemapRect               :?= address($81FA24)
      rlRevertWindowTilemapRect             :?= address($81FA59)
      rlProcEngineCreateProc                :?= address($829BF1)
      rlProcEngineFindProc                  :?= address($829CEC)
      rlProcEngineFreeProc                  :?= address($829D11)
      rlHDMAArrayEngineCreateEntryByIndex   :?= address($82A470)
      rlHDMAEngineFreeEntryByIndex          :?= address($82A495)
      rlCopyCharacterDataFromBuffer         :?= address($839041)
      rlGetItemNamePointer                  :?= address($83931A)
      rlGetCharacterNamePointer             :?= address($839334)
      rlGetClassNamePointer                 :?= address($839351)
      rlCheckItemEquippable                 :?= address($83965E)
      rlPushToQueue                         :?= address($8397E8)
      rlPopFromQueue                        :?= address($839808)
      rlTryGiveCharacterItemFromBuffer      :?= address($83A443)
      rlFillInventoryHoles                  :?= address($83A49C)
      rlCopyItemDataToBuffer                :?= address($83B00D)
      rlMenuTryScrollDown                   :?= address($83C8BF)
      rlMenuTryScrollUp                     :?= address($83C8EE)
      rlCreateUpwardsSpinningArrow          :?= address($83CB26)
      rlCreateDownwardsSpinningArrow        :?= address($83CB53)
      rlSetUpScrollingArrowSpeed            :?= address($83CCB1)
      rlSetDownScrollingArrowSpeed          :?= address($83CCC9)
      rlToggleUpwardsSpinningArrow          :?= address($83CCE1)
      rlToggleDownwardsSpinningArrow        :?= address($83CCF9)
      rlDrawTilemapPackedRect               :?= address($84A3FF)
      rlDrawNumberMenuText                  :?= address($858859)
      rlDrawNumberMenuTextOrDoubleDash      :?= address($858884)
      rlDrawMultilineMenuText               :?= address($8588E4)
      rlDrawItemCurrentDurability           :?= address($858921)
      rlDrawRightFacingCursor               :?= address($859013)
      rlDrawRightFacingStaticCursorHighPrio :?= address($8590CF)
      rlUnknown8591F0                       :?= address($8591F0)
      rlUnknown859205                       :?= address($859205)
      rlUnknown859219                       :?= address($859219)
      rlGetCurrentBackgroundTiles           :?= address($85979B)
      rlShopWindowCheckPrepOnOpen           :?= address($859ADB)
      rlGetConvoyItemCount                  :?= address($85C700)
      rlDrawWindowBackgroundFromTilemapInfo :?= address($87D6FC)
      rlDrawMenuText                        :?= address($87E728)
      rlClearIconArray                      :?= address($8A8060)
      rlRenderSheetIconSprites              :?= address($8A8126)
      rlDrawIconTilemap                     :?= address($8A821B)
      rlClearSheetIcon                      :?= address($8A8253)
      rlDrawItemInfoWindowBackground        :?= address($8AB273)
      rlRevertItemInfoWindowBackground      :?= address($8AB334)
      rlApplyCurrentConvoySort              :?= address($8AC361)
      rlRenderConvoyItemCount               :?= address($8AC39C)
      rlPlayMenuCloseSound                  :?= address($8AC48E)
      rlDrawPortraitWithDirection           :?= address($8CBF73)

      aGenericBG3TilemapInfo :?= address($83C0F6)
      aGenericBG1TilemapInfo :?= address($83C0FF)

      aShopWindowTextColors :?= address($859BC4)

      acConvoyWindowBG3Tilemap :?= address($9E9C45)
      acConvoyWindowBG2Tilemap :?= address($9EA288)

      acMapConvoyWindowBG3Tilemap :?= address($9EEEB6)

      aConvoyWindowCenterTilesPalette :?= address($9E8766)
      g4bppcConvoyWindowCenterTiles :?= address($9EA35D)

      g4bppConvoyNumberTiles :?= address($F1F880)
      IconSheet :?= address($F28000)

      procItemListPostShuffleCopyTilemaps :?= address($8AC36D)

      procFadeWithCallback :?= address($82A1BB)

      aItemData :?= address($B080AB)
      aItemKanaSortTable :?= address($B0992F)

      procUpArrow   :?= address($83CB4B)
      procDownArrow :?= address($83CB78)

    .endweak

    ConvoyWindowConfig .namespace

      ; Palette Usage

        ; Helper to get the address of a palette buffer slot
        ; given an index
        BGPalette .sfunction Index, (aBGPaletteBuffer + (Index * size(Palette)))
        OAMPalette .sfunction Index, (aOAMPaletteBuffer + (Index * size(Palette)))

        ; BG Palettes

          TextPalettes           = enum.enum(0)
          _                     := enum.enum()
          MenuBackgroundPalette  = enum.enum()
          ItemIconPalette        = enum.enum()
          CenterTilesPalette     = enum.enum()

        ; Object Palettes

          MapSpritePalette     = enum.enum(0)
          _                   := enum.enum()
          PortraitPalette      = enum.enum()
          _                   := enum.enum()
          ConvoyNumberPalette  = enum.enum()
          OldItemIconPalette   = enum.enum()

      ; VRAM Allocation

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
            Return := ConvoyWindowConfig.OAMTilesPosition
            ConvoyWindowConfig.OAMTilesPosition += Size
          .endfunction Return

          BG12TilesPosition := BG1Base
          BG12Allocate .function Size
            Return := ConvoyWindowConfig.BG12TilesPosition
            ConvoyWindowConfig.BG12TilesPosition += Size
          .endfunction Return

          BG3TilesPosition := BG3Base
          BG3Allocate .function Size
            Return := ConvoyWindowConfig.BG3TilesPosition
            ConvoyWindowConfig.BG3TilesPosition += Size
          .endfunction Return

        ; OAM allocations

          StandingMapSpriteTilesPosition = OAMAllocate(64 * (2 * 2 * size(Tile4bpp)))
          SystemIconTilesPosition        = OAMAllocate(16 * 4 * size(Tile4bpp))
          WeaponRankIconTilesPosition    = OAMAllocate(4 * (4 * size(Tile4bpp)))
          ConvoyNumberTilesPosition      = OAMAllocate(12 * size(Tile4bpp))

        ; BG1/2 allocations

          CenterWindowTilesSize = 16 * 4 * size(Tile4bpp)
          CenterWindowTilesPosition = BG12Allocate(CenterWindowTilesSize)

          ItemIconTilesSize = BG3Base - BG12TilesPosition
          ItemIconTilesPosition = BG12Allocate(ItemIconTilesSize)

        ; BG3 allocations

          ; Going to split this into its two pages.

          TilemapPageSize = 32 * 32 * size(word)
          BG3TilemapPage0Position = BG3Allocate(TilemapPageSize)
          BG3TilemapPage1Position = BG3Allocate(TilemapPageSize)

          ; Annoyingly the (BG1) background tiles are here.

          BackgroundTilesSize = 16 * 4 * size(Tile4bpp)
          BackgroundTilesPosition = BG3Allocate(BackgroundTilesSize)

          MenuTilesSize = 16 * 40 * size(Tile2bpp) ; TODO: menu tiles
          MenuTilesPosition = BG3Allocate(MenuTilesSize)

        ; Precalculated helpers

          MenuTilesBaseTile = VRAMToTile(MenuTilesPosition, BG3Base, size(Tile2bpp))
          NumberTilesBaseTile = MenuTilesBaseTile + C2I((0, 18), 16) ; TODO: menu tiles

          BG2FillTile = TilemapEntry(VRAMToTile(BG2Base, BG2Base, size(Tile4bpp)) + C2I((15, 47), 16), 0, 0, false, false)

          BG3BlankTile = TilemapEntry(MenuTilesBaseTile + C2I((15, 5), 16), 0, 0, false, false) ; TODO: menu tiles

      ShadingRegions .namespace

        Upper .namespace

          Position = (0, 0)
          Size     = (32, 16)

        .endnamespace ; Upper

        Lower .namespace

          Position = (0, 16)
          Size     = (32, 12)

        .endnamespace ; Lower

      .endnamespace ; ShadingRegions

      MapConvoyShadingRegions .namespace

        Upper .namespace

          Position = (0, 0)
          Size     = (32, 4)

        .endnamespace ; Upper

        Lower .namespace

          Position = (0, 4)
          Size     = (32, 24)

        .endnamespace ; Lower

      .endnamespace ; MapConvoyShadingRegions

      MapConvoyLowerBox .namespace

        Origin = (0, 4)
        Size   = (32, 24)

        Interior = Origin + (1, 1)

        LineCount = 11

        UpArrowPosition = (Origin * 8) + (128, 3) ; In pixels
        DownArrowPosition = (Origin * 8) + (128, 180) ; In pixels

        LeftRowBases = iter.map(iter.reversed, iter.zip_single(range(16) * 2, 3))
        RightRowBases = iter.map(iter.reversed, iter.zip_single(range(16) * 2, 19))

        ; Cursor positions based on the screen

        CursorOffset     = (-2, 0)
        IconOffset       = (0, 0)
        NameOffset       = (2, 0)
        DurabilityOffset = (11, 0) ; Right-aligned

        ; Helper function
        _AddLeftOffset .sfunction Offset, iter.starmap(op.add, iter.zip_single(LeftRowBases, Offset))
        _AddRightOffset .sfunction Offset, iter.starmap(op.add, iter.zip_single(RightRowBases, Offset))

        LeftCursorPositions      = iter.starmap(op.mul, iter.zip_single(_AddLeftOffset(CursorOffset), (8, 8))) ; In pixels
        LeftIconPositions        = _AddLeftOffset(IconOffset)
        LeftNamePositions        = _AddLeftOffset(NameOffset)
        LeftDurabilityPositions  = _AddLeftOffset(DurabilityOffset)

        RightCursorPositions     = iter.starmap(op.mul, iter.zip_single(_AddRightOffset(CursorOffset), (8, 8))) ; In pixels
        RightIconPositions       = _AddRightOffset(IconOffset)
        RightNamePositions       = _AddRightOffset(NameOffset)
        RightDurabilityPositions = _AddRightOffset(DurabilityOffset)

      .endnamespace ; MapConvoyLowerBox

      UnitInfoBox .namespace

        Origin = (0, 0)
        Size   = (16, 10)

        MapSpritePosition = (Origin * 8) + (8, 8) ; In pixels

        PortraitPosition   = Origin + (9, 1)
        NamePosition       = Origin + (3, 1)
        ClassPosition      = Origin + (1, 3)
        ExperiencePosition = Origin + (7, 5)
        LevelPosition      = Origin + (4, 5)
        CurrentHPPosition  = Origin + (4, 7)
        MaxHPPosition      = Origin + (7, 7)

      .endnamespace ; UnitInfoBox

      UnitItemBox .namespace

        Origin = (16, 0)
        Size   = (16, 16)

        Interior = Origin + (1, 1)

        ItemCount = 7

        RowBases = iter.map(iter.reversed, iter.zip_single(range(ItemCount + 1) * 2, 0))

        CursorOffset     = Interior + (0, 0)
        IconOffset       = Interior + (2, 0)
        NameOffset       = Interior + (4, 0)
        DurabilityOffset = Interior + (13, 0) ; Right-aligned

        ; Helper function
        _AddOffset .sfunction Offset, iter.starmap(op.add, iter.zip_single(RowBases, Offset))

        CursorPositions = iter.starmap(op.mul, iter.zip_single(_AddOffset(CursorOffset), (8, 8))) ; In pixels
        IconPositions = _AddOffset(IconOffset)
        NamePositions = _AddOffset(NameOffset)
        DurabilityPositions = _AddOffset(DurabilityOffset)

      .endnamespace ; UnitItemBox

      SelectionBox .namespace

        Origin = (0, 10)
        Size   = (16, 6)

        ; For clearing the text tilemap when discarding
        Interior = Origin + (2, 1)
        InteriorSize = Size - (4, 2)

        TakeCursorPosition    = ( 8,  88)
        GiveCursorPosition    = (64,  88)
        DiscardCursorPosition = ( 8, 104)

        SortTextPosition = Interior + (6, 2)

      .endnamespace ; SelectionBox

      ConvoyItemBox .namespace

        Origin = (0, 16)
        Size   = (32, 12)

        Interior = Origin + (1, 1)
        InteriorSize = Size - (2, 2)

        ListOrigin = (0, 0) ; From the second page
        SliceOrigin = Origin + (0, 1) ; From the first page

        UpArrowPosition = (Origin * 8) + (128, 3) ; In pixels
        DownArrowPosition = (Origin * 8) + (128, 84) ; In pixels

        RowCount = 5

        LeftRowBases = iter.map(iter.reversed, iter.zip_single(range(16) * 2, 3))
        RightRowBases = iter.map(iter.reversed, iter.zip_single(range(16) * 2, 19))

        ; Cursor positions based on the screen

        CursorOffset     = (-2, 0)
        IconOffset       = (0, 0)
        NameOffset       = (2, 0)
        DurabilityOffset = (11, 0) ; Right-aligned

        ; Helper function
        _AddLeftOffset .sfunction Offset, iter.starmap(op.add, iter.zip_single(LeftRowBases, Offset))
        _AddRightOffset .sfunction Offset, iter.starmap(op.add, iter.zip_single(RightRowBases, Offset))

        LeftCursorPositions      = iter.starmap(op.mul, iter.zip_single(_AddLeftOffset(CursorOffset), (8, 8))) ; In pixels
        LeftIconPositions        = _AddLeftOffset(IconOffset)
        LeftNamePositions        = _AddLeftOffset(NameOffset)
        LeftDurabilityPositions  = _AddLeftOffset(DurabilityOffset)

        RightCursorPositions     = iter.starmap(op.mul, iter.zip_single(_AddRightOffset(CursorOffset), (8, 8))) ; In pixels
        RightIconPositions       = _AddRightOffset(IconOffset)
        RightNamePositions       = _AddRightOffset(NameOffset)
        RightDurabilityPositions = _AddRightOffset(DurabilityOffset)

      .endnamespace ; ConvoyItemBox

      ItemInfoBox .namespace

        Origin = (18, 1)
        Size   = (12, 18)

        Interior = Origin + (2, 1)

      .endnamespace ; ItemInfoBox

    .endnamespace ; ConvoyWindowConfig

  ; Freespace inclusions

    .section ConvoyWindowSection

      .with ConvoyWindowConfig

      startData

        aConvoyWindowActions .binclude "../TABLES/ConvoyWindowActions.csv.asm" ; 85/B313

      endData
      startCode

        rsConvoyWindowActionLeave ; 85/B347

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles leaving the convoy window. The actual work
          ; is handled by the post-fade callback.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsr rsConvoyWindowRenderSourceSelectionCursor
          rts

          .databank 0

        rsConvoyWindowUpdate ; 85/B34B

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; This is the main updater for the convoy window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with UnitInfoBox

          lda wBufferBG3VOFS
          sta aConvoyWindowOFSHDMATable.Entries[2].VOFS

          jsr rsConvoyWindowUpdateScrollingArrows
          jsl rlRenderSheetIconSprites
          jsl rlRenderConvoyItemCount

          lda wConvoyWindowActionIndex
          and #$00FF
          asl a
          asl a
          tax 
          lda aConvoyWindowActions,x
          sta wR0

          pea <>(+)-1
          jmp (wR0)

          +

          .cwarn MapSpritePosition[0] != MapSpritePosition[1]

          lda #MapSpritePosition[0]
          sta wR0
          sta wR1
          ldy #<>aSelectedCharacterBuffer
          jsl rlInventoryDrawMapSpriteCheckGrayed

          rts

          .endwith ; UnitInfoBox

          .databank 0

        rsConvoyWindowGetNextAction ; 85/B37F

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Sets the convoy window's next action.

          ; Inputs:
          ; wConvoyWindowActionIndex: current action

          ; Outputs:
          ; wConvoyWindowActionIndex: next action

          lda wConvoyWindowActionIndex
          and #$00FF
          asl a
          asl a

          .rept size(word)
            inc a
          .endrept

          tax
          lda aConvoyWindowActions,x
          sta wConvoyWindowActionIndex
          rts

          .databank 0

      endCode
      startData

        aConvoyWindowItemListTilemapInfo .structTilemapInfo (32, 32), None, aBG3TilemapBuffer.Page1 ; 85/B392

      endData
      startCode

        rlConvoyWindowSetupWindow ; 85/B39B

          .al
          .xl
          .autsiz
          .databank ?

          ; Handles setting up the convoy window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php
          phb

          sep #$20

          lda #`aBG2TilemapBuffer
          pha

          rep #$20

          plb

          .databank `aBG2TilemapBuffer

          lda #<>aBG2TilemapBuffer
          sta wR0
          lda #BG2FillTile
          jsl rlFillTilemapByWord

          lda #<>aBG2TilemapBuffer.Page1
          sta wR0
          lda #BG2FillTile
          jsl rlFillTilemapByWord

          jsl rlClearIconArray
          jsl rlConvoyWindowFillItemListFromConvoy
          jsl rlApplyCurrentConvoySort

          lda #<>aGenericBG1TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b
          lda #>`aGenericBG1TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

          lda lWindowBackgroundPatternPointer
          sta lR18
          lda lWindowBackgroundPatternPointer+size(byte)
          sta lR18+size(byte)

          ; I don't know why this acts like it starts 64 tiles sooner.

          _BaseTile := VRAMToTile(BackgroundTilesPosition, BG1Base, size(Tile4bpp)) - (16 * 4)

          lda #TilemapEntry(_BaseTile, MenuBackgroundPalette, 0, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          jsl rlDrawWindowBackgroundFromTilemapInfo
          jsl rlGetCurrentBackgroundTiles

          lda #(`acConvoyWindowBG3Tilemap)<<8
          sta lR18+size(byte)
          lda #<>acConvoyWindowBG3Tilemap
          sta lR18
          lda #(`aBG3TilemapBuffer)<<8
          sta lR19+size(byte)
          lda #<>aBG3TilemapBuffer
          sta lR19
          jsl rlAppendDecompList

          lda #(`acConvoyWindowBG2Tilemap)<<8
          sta lR18+size(byte)
          lda #<>acConvoyWindowBG2Tilemap
          sta lR18
          lda #(`aBG2TilemapBuffer)<<8
          sta lR19+size(byte)
          lda #<>aBG2TilemapBuffer
          sta lR19
          jsl rlAppendDecompList

          lda #(`g4bppcConvoyWindowCenterTiles)<<8
          sta lR18+size(byte)
          lda #<>g4bppcConvoyWindowCenterTiles
          sta lR18
          lda #(`aDecompressionBuffer)<<8
          sta lR19+size(byte)
          lda #<>aDecompressionBuffer
          sta lR19
          jsl rlAppendDecompList

          jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, CenterWindowTilesSize, VMAIN_Setting(true), CenterWindowTilesPosition

          stz wConvoyWindowItemListScrolledRowOffset
          jsr rsConvoyWindowDrawUnitText
          jsl rlConvoyWindowDrawUnitInventory
          jsl rlConvoyWindowSetMenuShading
          jsl rlConvoyWindowCopyOFSHDMATable
          jsl rlConvoyWindowCreateHOFSHDMA
          jsr rsConvoyWindowCreateTMHDMA
          jsl rlConvoyWindowSetLineVariables

          lda wPrepItemsActionIndex
          cmp #$000D ; TODO: prep items actions
          bne +

            lda wTradeWindowCursorStartingOffset
            jsr rsConvoyWindowSetPositionFromPrepItems

          +
          jsl rlConvoyWindowDrawVisibleItemListSlice
          jsl rlConvoyWindowUpdateBG3VOFS
          jsr rsConvoyWindowDrawPortrait
          jsl rlConvoyWindowCopyPalettes

          phx

          lda #(`procConvoyWindowScrollingArrows)<<8
          sta lR44+size(byte)
          lda #<>procConvoyWindowScrollingArrows
          sta lR44
          jsl rlProcEngineCreateProc

          plx

          jsl rlConvoyWindowDrawSortTypeText
          jsl rlShopWindowCheckPrepOnOpen
          jsl rlDMAByStruct

            .structDMAToVRAM IconSheet, ItemIconTilesSize, VMAIN_Setting(true), ItemIconTilesPosition

          jsl rlDMAByStruct

            .structDMAToVRAM aBG1TilemapBuffer, (TilemapPageSize - (32 * 4 * size(word))), VMAIN_Setting(true), BG1TilemapPosition

          jsl rlDMAByStruct

            .structDMAToVRAM aBG2TilemapBuffer, (2 * TilemapPageSize), VMAIN_Setting(true), BG2TilemapPosition

          jsl rlDMAByStruct

            .structDMAToVRAM aBG3TilemapBuffer, (2 * TilemapPageSize), VMAIN_Setting(true), BG3TilemapPage0Position

          jsl rlDMAByStruct

            ; TODO: g4bppConvoyNumberTiles

            .structDMAToVRAM g4bppConvoyNumberTiles, (16 * 1 * size(Tile4bpp)), VMAIN_Setting(true), ConvoyNumberTilesPosition

          jsl rlRenderConvoyItemCount

          plb
          plp
          rtl

          .databank 0

        rsConvoyWindowCreateSpinningArrows ; 85/B4DC

          .al
          .xl
          .autsiz
          .databank ?

          ; Creates the spinning arrows in the convoy
          ; item box.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with ConvoyItemBox

          lda #DownArrowPosition[0]
          sta wR0
          lda #DownArrowPosition[1]
          sta wR1
          jsl rlCreateDownwardsSpinningArrow

          lda #UpArrowPosition[0]
          sta wR0
          lda #UpArrowPosition[1]
          sta wR1
          jsl rlCreateUpwardsSpinningArrow

          rts

          .endwith ; ConvoyItemBox

          .databank 0

        rlConvoyWindowCopyPalettes ; 85/B4F9

          .al
          .xl
          .autsiz
          .databank ?

          ; Copies the palettes for the center and the
          ; item icons.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #(`aConvoyWindowCenterTilesPalette)<<8
          sta lR18+size(byte)
          lda #<>aConvoyWindowCenterTilesPalette
          sta lR18
          lda #(`BGPalette(CenterTilesPalette))<<8
          sta lR19+size(byte)
          lda #<>BGPalette(CenterTilesPalette)
          sta lR19
          lda #size(Palette)
          sta lR20
          jsl rlBlockCopy

          lda #(`OAMPalette(OldItemIconPalette))<<8
          sta lR18+size(byte)
          lda #<>OAMPalette(OldItemIconPalette)
          sta lR18
          lda #(`BGPalette(ItemIconPalette))<<8
          sta lR19+size(byte)
          lda #<>BGPalette(ItemIconPalette)
          sta lR19
          lda #size(Palette)
          sta lR20
          jsl rlBlockCopy

          rtl

          .databank 0

        rsConvoyWindowDrawPortrait ; 85/B534

          .al
          .xl
          .autsiz
          .databank ?

          ; Draws the selected unit's portrait.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with UnitInfoBox

          lda #pack(PortraitPosition)
          sta wR0
          lda aSelectedCharacterBuffer.Character,b
          ldx #int(false)
          jsl rlDrawPortraitWithDirection
          rts

          .endwith ; UnitInfoBox

          .databank 0

        rlConvoyWindowSetLineVariables ; 85/B544

          .al
          .xl
          .autsiz
          .databank `wMenuLineScrollCount

          ; Sets various default values.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          stz wMenuLineScrollCount
          stz wMenuMinimumLine

          lda #1
          sta wMenuUpScrollThreshold

          lda #3
          sta wMenuDownScrollThreshold

          lda #ConvoyItemBox.RowCount
          sta wMenuBottomThreshold

          jsr rsConvoyWindowGetMaximumItemListRow

          stz wConvoyWindowItemListSelectedSide
          stz wConvoyWindowItemListSelectedRow

          lda #aConvoyWindowActions.SourceSelectionUpdate
          sta wConvoyWindowActionIndex

          stz wConvoyWindowUnitItemOffset

          rtl

          .databank 0

        rsConvoyWindowDrawUnitText ; 85/B56F

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws unit-related text.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with UnitInfoBox

          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b
          lda #>`aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

          lda #TilemapEntry(MenuTilesBaseTile, TextWhite, 1, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          lda aSelectedCharacterBuffer.Character,b
          jsl rlGetCharacterNamePointer

          ldx #pack(NamePosition)
          jsl rlDrawMenuText

          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          jsl rlGetClassNamePointer

          ldx #pack(ClassPosition)
          jsl rlDrawMenuText

          lda #TilemapEntry(NumberTilesBaseTile, TextWhite, 1, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          lda aSelectedCharacterBuffer.Experience,b
          sta lR18
          stz lR18+size(byte)
          ldx #pack(ExperiencePosition)
          jsl rlDrawNumberMenuTextOrDoubleDash

          lda aSelectedCharacterBuffer.Level,b
          sta lR18
          stz lR18+size(byte)
          ldx #pack(LevelPosition)
          jsl rlDrawNumberMenuText

          lda aSelectedCharacterBuffer.CurrentHP,b
          sta lR18
          stz lR18+size(byte)
          ldx #pack(CurrentHPPosition)
          jsl rlDrawNumberMenuText

          lda aSelectedCharacterBuffer.MaxHP,b
          sta lR18
          stz lR18+size(byte)
          ldx #pack(MaxHPPosition)
          jsl rlDrawNumberMenuText

          sep #$20

          lda #T_Setting(true, true, true , false, true)
          sta bBufferTM

          rep #$20

          rts

          .endwith ; UnitInfoBox

          .databank 0

      endCode
      startData

        .with UnitItemBox

        aConvoyWindowUnitItemPositions .word iter.map(pack, NamePositions) ; 85/B5E7

        aConvoyWindowUnitItemTilemapBufferPositions .for _Coords in NamePositions[:-1] ; 85/B5F7

          .word <>aBG3TilemapBuffer + (C2I(_Coords, 32) * size(word))

        .endfor

        aConvoyWindowUnitItemCursorYPositions .word NamePositions[:, 1] * 8 ; 85/B605

        .endwith ; UnitItemBox

      endData
      startCode

        rlConvoyWindowDrawUnitInventory ; 85/B615

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws the selected unit's items.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with UnitItemBox

          _Box = (Origin + Size - (1, 1)) - (Interior + (1, 0))

          lda #<>aBG3TilemapBuffer + (C2I(Interior + (1, 0), 32) * size(word))
          sta wR0
          lda #_Box[0]
          sta wR1
          lda #_Box[1]
          sta wR2
          lda #BG3BlankTile
          jsl rlFillTilemapRectByWord

          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b
          lda #>`aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

          lda #((ItemCount - 1) * size(word))
          sta wR17

          _Loop
            ldx wR17
            lda aSelectedCharacterBuffer.Items,b,x
            beq _NoItem

              jsl rlCopyItemDataToBuffer

              stz wR16

              lda #<>aSelectedCharacterBuffer
              sta wR1
              jsl rlCheckItemEquippable
              bcs +

                lda #size(word)
                sta wR16

              +
              jsl rlConvoyWindowDrawUnitItemName
              jsl rlConvoyWindowDrawUnitItemDurability
              jsl rlConvoyWindowDrawUnitItemIcon
              bra _Next

            _NoItem

              ; In case there previously was an icon in
              ; an item slot that is now blank, clear the tilemap.

              lda aConvoyWindowUnitItemPositions,x
              tax

              ; This is the number of tiles to the left of the
              ; item name that the icon occupies.

              .rept (NameOffset - IconOffset)[0]
                dec x
              .endrept

              lda #<>aBG2TilemapBuffer
              sta wR0
              lda #BG2FillTile
              sta wR1
              stz aCurrentTilemapInfo.wBaseTile,b
              jsl rlClearSheetIcon

            _Next
            dec wR17
            dec wR17

            bpl _Loop

          rtl

          .endwith ; UnitItemBox

          .databank 0

        rlConvoyWindowDrawUnitItemName ; 85/B686

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws an item name to the unit item box.

          ; Inputs:
          ; wR16: size(word) if unequipable else 0
          ; wR17: offset of item in inventory

          ; Outputs:
          ; None

          ldx wR16
          lda aShopWindowTextColors,x
          sta aCurrentTilemapInfo.wBaseTile,b
          jsl rlGetItemNamePointer

          ldx wR17
          lda aConvoyWindowUnitItemPositions,x
          tax
          jsl rlDrawMenuText
          rtl

          .databank 0

        rlConvoyWindowDrawUnitItemDurability ; 85/B69F

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws an item durability to the unit item box.

          ; Inputs:
          ; wR16: size(word) if unequipable else 0
          ; wR17: offset of item in inventory

          ; Outputs:
          ; None

          .with UnitItemBox

          lda wR16
          sta aCurrentTilemapInfo.wBaseTile,b

          ldx wR17
          lda aConvoyWindowUnitItemPositions,x
          clc
          adc #(DurabilityOffset - NameOffset)[0]
          tax
          jsl rlDrawItemCurrentDurability
          rtl

          .endwith ; UnitItemBox

          .databank 0

        rlConvoyWindowDrawUnitItemIcon ; 85/B6B4

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws an item icon to the unit item box.

          ; Inputs:
          ; wR17: offset of item in inventory

          ; Outputs:
          ; None

          _BaseTile := VRAMToTile(ItemIconTilesPosition, BG2Base, size(Tile4bpp))

          lda #TilemapEntry(_BaseTile, ItemIconPalette, 1, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          lda #<>aBG2TilemapBuffer
          sta wR0
          lda aItemDataBuffer.Icon,b
          and #$00FF
          sta wR1
          ldx wR17
          lda aConvoyWindowUnitItemPositions,x

          dec a
          dec a

          tax
          jsl rlDrawIconTilemap

          rtl

          .databank 0

      endCode
      startData

        .with ConvoyItemBox

        aConvoyWindowItemListPositions .rept 14 ; 85/B6D5

          .for _Left, _Right in iter.zip(LeftNamePositions, RightNamePositions)

            .word pack(_Left), pack(_Right)

          .endfor

        .endrept

        aConvoyWindowItemListTilemapPositions .rept 14 ; 85/BA55

          .word TilemapPageSize + C2I((0, LeftNamePositions[:,1]), 32) * size(word)

        .endrept

        .endwith ; ConvoyItemBox

      endData
      startCode

        rlConvoyWindowDrawVisibleItemListSlice ; 85/BC15

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws the currently-visible slice of the items
          ; in the convoy.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with ConvoyItemBox

          lda #<>aSelectedCharacterBuffer
          sta wR1
          lda wConvoyWindowItemListScrolledRowOffset
          jsr rsConvoyWindowDrawItemListSliceRow

          .for _i in range(1, RowCount)

            lda #<>aSelectedCharacterBuffer
            sta wR1
            lda wConvoyWindowItemListScrolledRowOffset
            clc
            adc #(_i * 2 * size(word))
            jsr rsConvoyWindowDrawItemListSliceRow

          .endfor

          jsr rsConvoyWindowGetMaximumItemListRow

          rtl

          .endwith ; ConvoyItemBox

          .databank 0

        rsConvoyWindowGetMaximumItemListRow ; 85/BC60

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Gets the max row of the convoy item list.

          ; Inputs:
          ; None

          ; Outputs:
          ; wMenuMaximumLine: max line

          ; The value of wMenuMaximumLine will be one less
          ; than you'd expect due to 0-indexing, and this
          ; uses a weird method to do floored division without
          ; messing up 0.

          jsl rlGetConvoyItemCount
          dec a
          lsr a
          cmp #(narrow(-1, size(word)) >> 1) & $F000
          blt +

            lda #0

          +
          sta wMenuMaximumLine
          rts

          .databank 0

        rsConvoyWindowDrawItemListSliceRow ; 85/BC72

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws a row of the convoy item list.

          ; Inputs:
          ; A: Offset of left-column item into aPrepItemsListItemArray

          ; Outputs:
          ; None

          pha

          lda #<>aConvoyWindowItemListTilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b
          lda #>`aConvoyWindowItemListTilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

          plx

          jsr rsConvoyWindowClearItemListSliceRow

          lda aPrepItemsListItemArray,x
          jsr rsConvoyWindowDrawItemListSliceItem

          .rept size(word)
            inc x
          .endrept

          lda aPrepItemsListItemArray,x
          jsr rsConvoyWindowDrawItemListSliceItem
          rts

          .databank 0

        rsConvoyWindowDrawItemListSliceItem ; 85/BC92

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws a single item on the convoy item list.

          ; Inputs:
          ; A: item ID or 0 for no item

          ; Outputs:
          ; None

          .with ConvoyItemBox

          and #$FFFF
          beq _End

            phx

            stx wR16
            jsl rlCopyItemDataToBuffer

            stz wR17
            lda #<>aSelectedCharacterBuffer
            sta wR1
            jsl rlCheckItemEquippable
            bcs +

              lda #size(word)
              sta wR17

            +
            lda wR17
            sta aCurrentTilemapInfo.wBaseTile,b

            ldx wR16
            lda aConvoyWindowItemListPositions,x
            clc
            adc #(DurabilityOffset - NameOffset)[0]
            tax
            jsl rlDrawItemCurrentDurability

            ldx wR17
            lda aShopWindowTextColors,x
            sta aCurrentTilemapInfo.wBaseTile,b
            jsl rlGetItemNamePointer

            ldx wR16
            lda aConvoyWindowItemListPositions,x
            tax
            jsl rlDrawMenuText

            _BaseTile := VRAMToTile(ItemIconTilesPosition, BG2Base, size(Tile4bpp))

            lda #TilemapEntry(_BaseTile, ItemIconPalette, 1, false, false)
            sta aCurrentTilemapInfo.wBaseTile,b

            ldx wR16
            lda aConvoyWindowItemListPositions,x
            dec a
            dec a
            tax
            lda #<>aBG2TilemapBuffer.Page1
            sta wR0
            lda aItemDataBuffer.Icon,b
            and #$00FF
            sta wR1
            jsl rlDrawIconTilemap

            plx

          _End
          rts

          .endwith ; ConvoyItemBox

          .databank 0

        rsConvoyWindowClearItemListSliceRow ; 85/BCFE

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Clears a row of the convoy item list tilemaps.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          phx

          lda aConvoyWindowItemListPositions,x
          xba
          and #$00FF
          asl a
          asl a
          asl a
          asl a
          asl a
          inc a
          asl a
          tax

          ldy #ConvoyItemBox.InteriorSize[0] - 1

          _Position .sfunction Coordinates, Tilemap, Tilemap + (C2I(Coordinates, 32) * size(word))

          -
            lda #BG3BlankTile
            sta _Position((0, 0), aBG3TilemapBuffer.Page1),x
            sta _Position((0, 1), aBG3TilemapBuffer.Page1),x

            lda #BG2FillTile
            sta _Position((0, 0), aBG2TilemapBuffer.Page1),x
            sta _Position((0, 1), aBG2TilemapBuffer.Page1),x

            .rept size(word)
              inc x
            .endrept

            dec y

            bpl -

          plx

          rts

          .databank 0

        rsConvoyWindowCopyItemListSliceRowTilemap ; 85/BD2B

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Copies a convoy item list row tilemap to VRAM.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lsr a
          tax

          lda #>`aBG3TilemapBuffer
          sta lR18+size(byte)
          lda aConvoyWindowItemListTilemapPositions,x
          pha
          clc
          adc #<>aBG3TilemapBuffer
          sta lR18
          lda aConvoyWindowItemListTilemapPositions,x
          lsr a
          pha
          clc
          adc #BG3TilemapPage0Position >> 1
          sta wR1
          lda #(32 * 2 * size(word))
          sta wR0
          jsl rlDMAByPointer

          lda #>`aBG2TilemapBuffer
          sta lR18+size(byte)
          pla
          clc
          adc #BG2TilemapPosition >> 1
          sta wR1
          pla
          clc
          adc #<>aBG2TilemapBuffer
          sta lR18
          lda #(32 * 2 * size(word))
          sta wR0
          jsl rlDMAByPointer

          rts

          .databank 0

        rlConvoyWindowCreateHOFSHDMA ; 85/BD6F

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Creates the HDMA that shifts HOFS onto the
          ; convoy item list when rendering reaches where it goes.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #<>aConvoyWindowBG3HOFSHDMAEntry
          sta lR44
          lda #>`aConvoyWindowBG3HOFSHDMAEntry
          sta lR44+size(byte)
          lda #3
          sta wR40
          jsl rlHDMAArrayEngineCreateEntryByIndex

          lda #<>aConvoyWindowBG2HOFSHDMAEntry
          sta lR44
          lda #>`aConvoyWindowBG2HOFSHDMAEntry
          sta lR44+size(byte)
          lda #4
          sta wR40
          jsl rlHDMAArrayEngineCreateEntryByIndex

          rtl

          .databank 0

      endCode
      startData

        aConvoyWindowBG3HOFSHDMAEntry .structHDMADirectEntryInfo rlConvoyWindowBG3HOFSHDMAEntryDummy, rlConvoyWindowBG3HOFSHDMAEntryDummy, aConvoyWindowBG3HOFSHDMAEntryCode, $7EA945, BG3HOFS, DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Fixed1, DMAP_Mode3) ; 85/BD96

      endData
      startCode

        rlConvoyWindowBG3HOFSHDMAEntryDummy ; 85/BDA1

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          rtl

          .databank 0

      endCode
      startData

        aConvoyWindowBG3HOFSHDMAEntryCode .block ; 85/BDA2

          HDMA_HALT

        .endblock

        aConvoyWindowBG2HOFSHDMAEntry .structHDMADirectEntryInfo rlConvoyWindowBG2HOFSHDMAEntryDummy, rlConvoyWindowBG2HOFSHDMAEntryDummy, aConvoyWindowBG2HOFSHDMAEntryCode, $7EA945, BG2HOFS, DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Fixed1, DMAP_Mode3) ; 85/BDA4

      endData
      startCode

        rlConvoyWindowBG2HOFSHDMAEntryDummy ; 85/BDAF

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          rtl

          .databank 0

      endCode
      startData

        aConvoyWindowBG2HOFSHDMAEntryCode .block ; 85/BDB0

          HDMA_HALT

        .endblock

      endData
      startCode

        rlConvoyWindowSetMenuShading ; 85/BDB2

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Initializes scrolling positions and creates
          ; background shading for the window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          stz wBufferBG2HOFS
          stz wBufferBG3HOFS

          lda #1
          sta wBufferBG1VOFS
          sta wBufferBG2VOFS
          sta wBufferBG3VOFS

          jsl rlUnknown8591F0

          ; lda #ShadingRegions.Upper.Position[1]
          ; sta wR0
          stz wR0
          lda #ShadingRegions.Upper.Size[1]
          sta wR1
          jsl rlUnknown859219

          lda #ShadingRegions.Lower.Position[1]
          sta wR0
          lda #ShadingRegions.Lower.Size[1]
          sta wR1
          jsl rlUnknown859219

          jsl rlUnknown859205

          rtl

          .databank 0

        rlConvoyWindowCopyOFSHDMATable ; 85/BDE1

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Copies the initial tilemap offset table to WRAM
          ; so it can be updated when displaying the info window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #(`aConvoyWindowInitialOFSHDMATable)<<8
          sta lR18+size(byte)
          lda #<>aConvoyWindowInitialOFSHDMATable
          sta lR18
          lda #(`aConvoyWindowOFSHDMATable)<<8
          sta lR19+size(byte)
          lda #<>aConvoyWindowOFSHDMATable
          sta lR19
          lda #size(aConvoyWindowInitialOFSHDMATable)
          sta lR20
          jsl rlBlockCopy

          rtl

          .databank 0

      endCode
      startData

        aConvoyWindowInitialOFSHDMATable .block ; 85/BDFF

          ; This covers both VOFS and HOFS.

          .byte NTRL_Setting(120)
          .word 0
          .word 0

          .byte NTRL_Setting(15)
          .word 0
          .word 0

          .byte NTRL_Setting(80)
          .word 256
          .word 0

          .byte NTRL_Setting(9)
          .word 0
          .word 0

          .byte 0

        .endblock

      endData
      startCode

        rlConvoyWindowUpdateBG3VOFS ; 85/BE14

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Updates the BG3 vertical position to reflect our current
          ; scrolled-to point in the convoy item list.

          ; Inputs:
          ; wConvoyWindowItemListScrolledRowOffset: row

          ; Outputs:
          ; wBufferBG3VOFS: new position

          ldx wConvoyWindowItemListScrolledRowOffset
          lda aConvoyWindowItemListPositions,x
          xba
          and #$00FF
          asl a
          asl a
          asl a
          clc

          ; This shifts the scrolled position down such that the top of the
          ; list tilemap starts at the height of the item box interior.

          adc #(32 - ConvoyItemBox.Interior[1]) * 8
          and #$00FF
          sta wBufferBG3VOFS
          rtl

          .databank 0

        rsConvoyWindowActionItemList ; 85/BE2C

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles updating the convoy item list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsr rsConvoyWindowRenderSourceSelectionCursor
          lda aPrepItemsListItemArray
          bne +

            jmp rsConvoyWindowGetNextAction

          +

          lda wMenuLineScrollCount
          sta wConvoyWindowItemListScrolledRow

          stz wPrepUnitListMovingFlag

          jsl rlConvoyWindowHandleItemListDirectionInputs

          lda wPrepUnitListMovingFlag
          bne +

            jsl rlConvoyWindowHandleItemListOtherInputs

          +

          jsl rlConvoyWindowDrawItemListCursor

          lda wConvoyWindowItemListScrolledRow
          sec
          sbc wMenuLineScrollCount
          beq +

            asl a
            asl a

            jsr rsConvoyWindowSetupItemListScrollStep
            lda wConvoyWindowItemListScrolledRow
            jsl rlConvoyWindowScrollItemList

          +
          rts

          .databank 0

        rlConvoyWindowHandleItemListDirectionInputs ; 85/BE67

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles directional inputs when navigating the
          ; convoy item list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          pea <>(_Return)-1

          lda wJoy1Input
          bit #JOY_Y
          bne +

            lda wJoy1Repeated

          +
          bit #JOY_Up
          bne _Up

          bit #JOY_Down
          bne _Down

          bit #JOY_Left
          beq +

            jmp _Left

          +
          bit #JOY_Right
          beq _End

            jmp _Right

          _End
            rts

          .databank 0

          _Return ; 85/BE8E

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            rtl

          _Up ; 85/BE8F

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda wConvoyWindowItemListSelectedRow
            jsl rlMenuTryScrollUp
            bcc +

              sta wConvoyWindowItemListSelectedRow

              dec wPrepUnitListMovingFlag

              lda #$0009 ; TODO: sound definitions
              jsl rlPlaySoundEffect

            +
            rts

          _Down ; 85/BEA6

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            inc wConvoyWindowItemListSelectedRow
            jsl rlConvoyWindowGetSelectedItemListOffset

            dec wConvoyWindowItemListSelectedRow
            tax
            lda aPrepItemsListItemArray,x
            beq +

            lda wConvoyWindowItemListSelectedRow
            jsl rlMenuTryScrollDown
            bcc +

              sta wConvoyWindowItemListSelectedRow

              dec wPrepUnitListMovingFlag

              lda #$0009 ; TODO: sound definitions
              jsl rlPlaySoundEffect

            +
            rts

          _Left ; 85/BECD

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            stz wConvoyWindowItemListSelectedSide

            dec wPrepUnitListMovingFlag

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rts

            .databank 0

          _Right ; 85/BEDB

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda wConvoyWindowItemListSelectedSide
            bne +

            jsl rlConvoyWindowGetSelectedItemListOffset

            inc a
            inc a
            tax
            lda aPrepItemsListItemArray,x
            beq +

              lda #size(word)
              sta wConvoyWindowItemListSelectedSide

              dec wPrepUnitListMovingFlag

              lda #$0009 ; TODO: sound definitions
              jsl rlPlaySoundEffect

            +
            rts

            .databank 0

        rsConvoyWindowSwapItemListSortStyle ; 85/BEFD

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; This swaps the sort style and updates the convoy item
          ; list slice to match.

          ; Inputs:
          ; wConvoyWindowItemListSortSetting: current sort

          ; Outputs:
          ; wConvoyWindowItemListSortSetting: new sort

          lda wConvoyWindowItemListSortSetting
          eor #size(word)
          sta wConvoyWindowItemListSortSetting

          jsl rlApplyCurrentConvoySort
          jsl rlConvoyWindowDrawSortTypeText
          jsl rlConvoyWindowDrawVisibleItemListSlice

          phx

          lda #(`procItemListPostShuffleCopyTilemaps)<<8
          sta lR44+size(byte)
          lda #<>procItemListPostShuffleCopyTilemaps
          sta lR44
          jsl rlProcEngineCreateProc

          plx

          lda #$000B ; TODO: sound definitions
          jsl rlPlaySoundEffect

          rts

          .databank 0

        rlConvoyWindowHandleItemListOtherInputs ; 85/BF2A

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles non-directional inputs on the convoy item list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          pea <>(_Return)-1

          lda wJoy1New

          bit #JOY_B
          bne _B

          bit #JOY_R
          beq +

            jmp rsConvoyWindowHandleRPress

          +
          bit #JOY_A
          beq +

            jmp rsConvoyWindowHandleConvoyItemListAPress

          +
          bit #JOY_Select
          beq +

            jmp rsConvoyWindowSwapItemListSortStyle

          +
          bit #JOY_X
          beq +

            jmp _X

          +
          rts

          _Return ; 85/BF55

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            rtl

            .databank 0

          _B ; 85/BF56

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda #$0021 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            jmp rsConvoyWindowGetNextAction

            .databank 0

          _X ; 85/BF60

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            jsl rlConvoyWindowGetSelectedItemListOffset
            tax
            lda aPrepItemsListItemArray,x
            jsl rlConvoyWindowDisplayInfoWindow

            lda wConvoyWindowActionIndex
            cmp #aConvoyWindowActions.ItemList

            phx

            lda #(`procConvoyWindowRenderItemListCursor)<<8
            sta lR44+size(byte)
            lda #<>procConvoyWindowRenderItemListCursor
            sta lR44
            jsl rlProcEngineCreateProc

            plx

            rts

            .databank 0

        rsConvoyWindowUpdateScrollingArrows ; 85/BF83

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Toggles the spinning arrows in the convoy item list
          ; when scrolling reaches the ends of the list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wMenuLineScrollCount
          beq _Top

            lda #0
            bra +

          _Top
            lda #-1

          +
          jsl rlToggleUpwardsSpinningArrow

          lda wMenuMaximumLine
          sec
          sbc wMenuBottomThreshold
          inc a
          bpl +

            lda #0

          +
          cmp wMenuLineScrollCount
          beq _Bottom
          blt _Bottom

            lda #0
            bra +

          _Bottom
            lda #-1

          +
          jsl rlToggleDownwardsSpinningArrow

          rts

          .databank 0

        rlConvoyWindowScrollItemListDown ; 85/BFB5

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Scrolls the convoy item list down.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #<>aSelectedCharacterBuffer
          sta wR1
          lda wConvoyWindowItemListScrolledRowOffset
          clc
          adc #ConvoyItemBox.RowCount * 2 * size(word)
          pha

          jsr rsConvoyWindowDrawItemListSliceRow

          pla
          jsr rsConvoyWindowCopyItemListSliceRowTilemap

          lda wConvoyWindowItemListScrolledRowOffset
          clc
          adc #2 * size(word)
          sta wConvoyWindowItemListScrolledRowOffset

          rtl

          .databank 0

        rlConvoyWindowScrollItemListUp ; 85/BFD4

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Scrolls the convoy item list up.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #<>aSelectedCharacterBuffer
          sta wR1
          lda wConvoyWindowItemListScrolledRowOffset
          sec
          sbc #2 * size(word)
          pha

          jsr rsConvoyWindowDrawItemListSliceRow

          pla
          jsr rsConvoyWindowCopyItemListSliceRowTilemap

          lda wConvoyWindowItemListScrolledRowOffset
          sec
          sbc #2 * size(word)
          sta wConvoyWindowItemListScrolledRowOffset

          rtl

          .databank 0

        rlConvoyWindowScrollItemList ; 85/BFF3

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Scrolls the convoy item list up or down, based
          ; on wMenuLineScrollCount.

          ; Inputs:
          ; A: current line
          ; wMenuLineScrollCount: target line

          ; Outputs:
          ; None

          cmp wMenuLineScrollCount
          blt _Down

            jsl rlConvoyWindowScrollItemListUp
            bra +

          _Down
            jsl rlConvoyWindowScrollItemListDown

          +
          rtl

          .databank 0

        rlConvoyWindowDrawItemListCursor ; 85/C003

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws the cursor on the convoy item list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with ConvoyItemBox

          lda #LeftCursorPositions[0][0]
          sta wR0
          sta wPrepListCursorXCoordinate

          lda wConvoyWindowItemListSelectedSide
          beq +

            lda #RightCursorPositions[0][0]
            sta wR0
            sta wPrepListCursorXCoordinate

          +
          lda wConvoyWindowItemListSelectedRow
          sec
          sbc wMenuLineScrollCount
          asl a
          asl a
          asl a
          asl a
          clc
          adc #(Interior * 8)[1] - 2
          sta wR1
          sta wPrepListCursorYCoordinate
          jsl rlDrawRightFacingCursor

          rtl

          .endwith ; ConvoyItemBox

          .databank 0

        rlConvoyWindowDrawItemListDiscardItemCursor ; 85/C031

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws the cursor when discarding an item
          ; from the convoy item list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with ConvoyItemBox

          lda #LeftCursorPositions[0][0]
          sta wR0

          lda wConvoyWindowItemListSelectedSide
          beq +

            lda #RightCursorPositions[0][0]
            sta wR0

          +
          lda wConvoyWindowItemListSelectedRow
          sec
          sbc wMenuLineScrollCount
          asl a
          asl a
          asl a
          asl a
          clc
          adc #(Interior * 8)[1] - 2
          sta wR1
          jsl rlDrawRightFacingStaticCursorHighPrio

          rtl

          .endwith ; ConvoyItemBox

          .databank 0

        rsConvoyWindowActionSourceSelectionUpdate ; 85/C056

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles inputs when selecting what we're doing on
          ; the convoy.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsr rsConvoyWindowHandleSourceSelectionInputs
          jsr rsConvoyWindowRenderSourceSelectionCursor
          rts

          .databank 0

        rsConvoyWindowHandleSourceSelectionInputs ; 85/C05D

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles inputs on the selection window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          pea <>_Return-1

          lda wJoy1New

          bit #JOY_Up
          bne _Up

          bit #JOY_Down
          beq +

            jmp _Down

          +
          bit #JOY_Left
          beq +

            jmp _Left

          +
          bit #JOY_Right
          beq +

            jmp _Right

          +
          bit #JOY_A
          beq +

            jmp _A

          +
          bit #JOY_B
          bne _B

          bit #JOY_R
          beq +

            jmp rsConvoyWindowHandleRPress

          +
          bit #JOY_L
          beq +

            jmp rsConvoyWindowHandleLPress

          +
          bit #JOY_Select
          beq _Return

            jmp rsConvoyWindowSwapItemListSortStyle

          _Return
          rts

          _B ; 85/C0A5

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            jsl rlConvoyWindowFillConvoyFromItemList
            lda wPrepScreenFlag,b
            beq +

              lda #<>aSelectedCharacterBuffer
              sta wR1
              jsl rlCopyCharacterDataFromBuffer

            +
            lda lUnknown7EA4EC
            sta lR18
            lda lUnknown7EA4EC+size(byte)
            sta lR18+size(byte)

            phk
            pea <>(+)-1
            jmp [lR18]

            +
            lda #$0021 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            jsl rlPlayMenuCloseSound
            lda #aConvoyWindowActions.Leave
            sta wConvoyWindowActionIndex
            rts

            .databank 0

          _Up ; 85/C0DA

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda wConvoyWindowSourceSelectionSetting
            cmp #4 * size(word)
            bne _End

            lda #0 * size(word)
            sta wConvoyWindowSourceSelectionSetting

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rts

            .databank 0

          _Down ; 85/C0F0

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda wConvoyWindowSourceSelectionSetting
            cmp #4 * size(word)
            beq _End

            lda #4 * size(word)
            sta wConvoyWindowSourceSelectionSetting

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

          _End
            rts

            .databank 0

          _Right ; 85/C106

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda wConvoyWindowSourceSelectionSetting
            cmp #2 * size(word)
            beq _End

            lda #2 * size(word)
            sta wConvoyWindowSourceSelectionSetting

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rts

            .databank 0

          _Left ; 85/C11C

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda wConvoyWindowSourceSelectionSetting
            cmp #2 * size(word)
            bne _End

            lda #0 * size(word)
            sta wConvoyWindowSourceSelectionSetting

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rts

            .databank 0

          _A ; 85/C132

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda #$000D ; TODO: sound definitions
            jsl rlPlaySoundEffect

            ldx wConvoyWindowSourceSelectionSetting
            lda _Actions,x
            sta wConvoyWindowActionIndex
            rts

            .databank 0

          endCode
          startData

            _Actions .block ; 85/C144

              .word aConvoyWindowActions.ItemList
              .word 0
              .word aConvoyWindowActions.UnitItemList
              .word 0
              .word aConvoyWindowActions.Discard

            .endblock

          endData
          startCode

        rsConvoyWindowRenderSourceSelectionCursor ; 85/C14E

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Renders the cursor when selecting
          ; which action to do.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          ldx wConvoyWindowSourceSelectionSetting

          lda _Coordinates,x
          sta wR0

          lda _Coordinates+size(word),x
          dec a
          dec a
          sta wR1

          lda wConvoyWindowActionIndex
          cmp #aConvoyWindowActions.SourceSelectionUpdate
          beq +

            jsl rlDrawRightFacingStaticCursorHighPrio
            rts

          +
          jsl rlDrawRightFacingCursor
          rts

          .databank 0

          endCode
          startData

            .with SelectionBox

            _Coordinates .block ; 85/C171

              .word TakeCursorPosition, GiveCursorPosition, DiscardCursorPosition

            .endblock

            .endwith ; SelectionBox

          endData
          startCode

        rsConvoyWindowActionUnitItemList ; 85/C17D

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles updating the menu when selecting from
          ; the unit's items.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsr rsConvoyWindowRenderSourceSelectionCursor
          lda aSelectedCharacterBuffer.Item1ID,b
          bne +

            jmp rsConvoyWindowGetNextAction

          +
          jsr rsConvoyWindowGetLastUnitListItem
          jsr rsConvoyWindowHandleUnitItemListInputs
          jsr rsConvoyWindowRenderUnitItemListCursor
          rts

          .databank 0

        rsConvoyWindowHandleUnitItemListInputs ; 85/C192

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles inputs when on the unit item list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          pea <>_Return-1

          lda wJoy1Repeated

          bit #JOY_Up
          bne _Up

          bit #JOY_Down
          bne _Down

          lda wJoy1New

          bit #JOY_A
          bne _A

          bit #(JOY_B | JOY_Left)
          beq +

            jmp rlConvoyWindowHandleItemListOtherInputs._B

          +
          bit #JOY_L
          beq +

            jmp rsConvoyWindowHandleLPress

          +
          bit #JOY_X
          bne _X

          bit #JOY_Select
          beq _Return

          jmp rsConvoyWindowSwapItemListSortStyle

          _Return
          rts

          .databank 0

          _X

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            ldx wConvoyWindowUnitItemOffset
            lda aSelectedCharacterBuffer.Items,b,x
            jsl rlConvoyWindowDisplayInfoWindow

            phx

            lda #(`procConvoyWindowRenderUnitItemListCursor)<<8
            sta lR44+size(byte)
            lda #<>procConvoyWindowRenderUnitItemListCursor
            sta lR44
            jsl rlProcEngineCreateProc

            plx

            rts

            .databank 0

          _Up ; 85/C1E1

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda wConvoyWindowUnitItemOffset

            .rept size(word)
              dec a
            .endrept

            bpl +

            lda wJoy1New
            cmp wJoy1Repeated
            bne _End

            lda wConvoyWindowUnitMaxItemOffset

            +
            sta wConvoyWindowUnitItemOffset

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            _End ; 85/C1FB
            rts

            .databank 0

          _Down ; 85/C1FC

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda wConvoyWindowUnitItemOffset
            cmp wConvoyWindowUnitMaxItemOffset
            bne +

            lda wJoy1New
            cmp wJoy1Repeated
            bne _End

            lda #+(-size(word))

            +
            .rept size(word)
              inc a
            .endrept

            sta wConvoyWindowUnitItemOffset

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rts

            .databank 0

          _A ; 85/C21A

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            jsl rlGetConvoyItemCount
            cpx #len(aConvoy.Items) * size(word)
            beq _FullConvoy

            lda #-1
            sta wUnknown7E4F96

            ldy wConvoyWindowUnitItemOffset
            lda aSelectedCharacterBuffer.Items,b,y
            sta aPlayerVisibleUnitMap,x

            lda #0
            sta aSelectedCharacterBuffer.Items,b,y

            lda #<>aSelectedCharacterBuffer
            sta wR1
            jsl rlFillInventoryHoles
            jsl rlApplyCurrentConvoySort
            jsl rlConvoyWindowDrawVisibleItemListSlice
            jsl rlConvoyWindowDrawUnitInventory

            ; Check if we still have items left afterwards.

            ldy wConvoyWindowUnitItemOffset
            lda aSelectedCharacterBuffer.Items,b,y
            bne _Continue

            cpy #0
            bne +

            lda #aConvoyWindowActions.SourceSelectionUpdate
            sta wConvoyWindowActionIndex

            bra _Continue

            +

            .rept size(word)
              dec wConvoyWindowUnitItemOffset
            .endrept

            _Continue
            jsr rsConvoyWindowRefreshItemListPostAction

            lda #$000C ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rts

            _FullConvoy
            lda #$0022 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rts

            .databank 0

        rsConvoyWindowRenderUnitItemListCursor ; 85/C27B

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws the cursor when hovering over a unit's
          ; items.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with UnitItemBox

          lda #CursorPositions[0][0] - 2
          sta wR0
          ldx wConvoyWindowUnitItemOffset
          lda aConvoyWindowUnitItemCursorYPositions,x
          sta wR1
          jsl rlDrawRightFacingCursor
          rts

          .endwith ; UnitItemBox

          .databank 0

        rsConvoyWindowGetLastUnitListItem ; 85/C28E

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Gets the offset of the last item in the
          ; selected unit's inventory.

          ; Inputs:
          ; aSelectedCharacterBuffer: unit

          ; Outputs:
          ; X: offset
          ; wConvoyWindowUnitMaxItemOffset: offset

          ldx #size(aSelectedCharacterBuffer.Items) - size(word)

          -
          lda aSelectedCharacterBuffer.Items,b,x
          bne +

          .rept size(word)
            dec x
          .endrept

          bra -

          +
          stx wConvoyWindowUnitMaxItemOffset
          rts

          .databank 0

        rsConvoyWindowHandleRPress ; 85/C29E

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Swaps over to the unit's inventory.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #2 * size(word)
          sta wConvoyWindowSourceSelectionSetting

          lda #aConvoyWindowActions.UnitItemList
          sta wConvoyWindowActionIndex

          lda #$000C ; TODO: sound definitons
          jsl rlPlaySoundEffect

          rts

          .databank 0

        rsConvoyWindowHandleLPress ; 85/C2B2

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Swaps over to the convoy item list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #0 * size(word)
          sta wConvoyWindowSourceSelectionSetting

          lda #aConvoyWindowActions.ItemList
          sta wConvoyWindowActionIndex

          lda #$000C ; TODO: sound definitons
          jsl rlPlaySoundEffect

          rts

          .databank 0

        rsConvoyWindowHandleConvoyItemListAPress ; 85/C2C6

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles trying to move an item from the
          ; convoy item list to the unit's inventory.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsl rlConvoyWindowGetSelectedItemListOffset

          sta wConvoyWindowDiscardOffset
          tax
          lda aPrepItemsListItemArray,x
          jsl rlCopyItemDataToBuffer
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlTryGiveCharacterItemFromBuffer
          bcs _Unable

          lda #-1
          sta wUnknown7E4F96

          ldx wConvoyWindowDiscardOffset
          stz aPrepItemsListItemArray,x
          jsl rlApplyCurrentConvoySort
          jsl rlConvoyWindowDrawVisibleItemListSlice
          jsl rlConvoyWindowDrawUnitInventory

          ldx wConvoyWindowDiscardOffset
          lda aPrepItemsListItemArray,x
          bne _Continue

            .rept size(word)
              dec wConvoyWindowDiscardOffset
            .endrept

            bpl +

              stz wConvoyWindowDiscardOffset

              lda #aConvoyWindowActions.SourceSelectionUpdate
              sta wConvoyWindowActionIndex

            +
            lda wConvoyWindowDiscardOffset
            jsr rsConvoyWindowTryScrollItemListUp

          _Continue
          jsl rlConvoyWindowUpdateBG3VOFS

          lda wBufferBG3VOFS
          sta aConvoyWindowOFSHDMATable.Entries[2].VOFS

          lda #$000C ; TODO: sound definitions
          jsl rlPlaySoundEffect

          jsr rsConvoyWindowRefreshItemListPostAction

          rts

          _Unable
          lda #$0022 ; TODO: sound definitions
          jsl rlPlaySoundEffect

          jsr rsConvoyWindowRefreshItemListPostAction

          rts

          .databank 0

        rsConvoyWindowTryScrollItemListUp ; 85/C336

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Tries to scroll the convoy item list up.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          pha

          and #size(word)
          sta wConvoyWindowItemListSelectedSide

          pla

          lsr a
          lsr a

          cmp wConvoyWindowItemListSelectedRow
          beq +

          lda wConvoyWindowItemListSelectedRow
          jsl rlMenuTryScrollUp
          bcc +

            sta wConvoyWindowItemListSelectedRow

          +
          rts

          .databank 0

        rlConvoyWindowGetSelectedItemListOffset ; 85/C352

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Gets the exact position of the selected item
          ; in the convoy item list.

          ; Inputs:
          ; None

          ; Outputs:
          ; A: offset

          lda wConvoyWindowItemListSelectedRow
          asl a
          asl a
          clc
          adc wConvoyWindowItemListSelectedSide
          rtl

          .databank 0

        rsConvoyWindowRefreshItemListPostAction ; 85/C35C

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Queues up refreshing the convoy item list tilemap
          ; after taking an item.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wConvoyWindowActionIndex

          jsl rlPushToQueue

          lda #aConvoyWindowActions.RefreshItemListBG3Tilemap
          sta wConvoyWindowActionIndex

          jsr rsConvoyWindowRenderSourceSelectionCursor

          rts

          .databank 0

        rsConvoyWindowActionRefreshItemListBG3Tilemap ; 83/C36D

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Copies the convoy item list text tilemap to VRAM.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsr rsConvoyWindowRenderSourceSelectionCursor
          jsr rsConvoyWindowRenderCurrentMenuCursor
          jsl rlDMAByStruct

            .structDMAToVRAM aBG3TilemapBuffer.Page1, TilemapPageSize, VMAIN_Setting(true), BG3TilemapPage1Position

          jmp rsConvoyWindowGetNextAction

          .databank 0

        rsConvoyWindowActionRefreshItemListBG2Tilemap ; 83/C383

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Copies the convoy item list icon tilemap to VRAM.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsr rsConvoyWindowRenderSourceSelectionCursor
          jsr rsConvoyWindowRenderCurrentMenuCursor
          jsl rlDMAByStruct

            .structDMAToVRAM aBG2TilemapBuffer.Page1, TilemapPageSize, VMAIN_Setting(true), BG2TilemapPosition+TilemapPageSize

          jmp rsConvoyWindowGetNextAction

          .databank 0

        rsConvoyWindowActionRefreshMainScreenTilemaps ; 83/C399

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Copies the main screen tilemaps back to VRAM.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsr rsConvoyWindowRenderSourceSelectionCursor
          jsr rsConvoyWindowRenderCurrentMenuCursor
          jsl rlDMAByStruct

            .structDMAToVRAM aBG3TilemapBuffer, (32 * 16 * size(word)), VMAIN_Setting(true), BG3TilemapPage0Position

          jsl rlDMAByStruct

            .structDMAToVRAM aBG2TilemapBuffer, (32 * 16 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

          jsl rlPopFromQueue
          sta wConvoyWindowActionIndex
          rts

          .databank 0

        rsConvoyWindowRenderCurrentMenuCursor ; 85/C3C1

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Picks which cursor to render.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wConvoyWindowSourceSelectionSetting
          cmp #2 * size(word)
          beq +

          jsl rlConvoyWindowDrawItemListCursor
          rts

          +
          jsr rsConvoyWindowRenderUnitItemListCursor
          rts

          .databank 0

        rlMapConvoyWindowSetupWindow ; 85/C3D2

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Creates the (unused) map convoy window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php
          phb

          sep #$20

          lda #`aBG2TilemapBuffer
          pha

          rep #$20

          plb

          .databank `aBG2TilemapBuffer

          lda #<>aBG2TilemapBuffer
          sta wR0
          lda #BG2FillTile
          jsl rlFillTilemapByWord

          lda #<>aGenericBG1TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b
          lda #>`aGenericBG1TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

          lda lWindowBackgroundPatternPointer
          sta lR18
          lda lWindowBackgroundPatternPointer+size(byte)
          sta lR18+size(byte)

          _BaseTile := VRAMToTile(BackgroundTilesPosition, BG1Base, size(Tile4bpp))

          lda #TilemapEntry(_BaseTile - 64, MenuBackgroundPalette, 0, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b
          jsl rlDrawWindowBackgroundFromTilemapInfo

          jsl rlGetCurrentBackgroundTiles

          lda #(`acMapConvoyWindowBG3Tilemap)<<8
          sta lR18+size(byte)
          lda #<>acMapConvoyWindowBG3Tilemap
          sta lR18
          lda #(`aBG3TilemapBuffer)<<8
          sta lR19+size(byte)
          lda #<>aBG3TilemapBuffer
          sta lR19
          jsl rlAppendDecompList

          stz wConvoyWindowItemListScrolledRowOffset

          jsr rsMapConvoyWindowDrawItemListRows
          jsr rsMapConvoyWindowSetWindowShading
          jsr rsMapConvoyWindowCopyHDMATable
          jsl rlConvoyWindowCreateHOFSHDMA
          jsr rsConvoyWindowCreateTMHDMA

          lda #<>aMapConvoyBG1VOFSHDMAEntry
          sta lR44
          lda #>`aMapConvoyBG1VOFSHDMAEntry
          sta lR44+size(byte)
          lda #5
          sta wR40
          jsl rlHDMAArrayEngineCreateEntryByIndex

          jsr rsMapConvoyWindowSetLineVariables
          jsr rsMapConvoyWindowUpdateBG3VOFS
          jsl rlConvoyWindowCopyPalettes
          jsr rsMapConvoyWindowCreateSpinningArrows

          lda wMenuLineScrollCount
          sta wConvoyWindowItemListScrolledRow

          jsl rlDMAByStruct

            .structDMAToVRAM IconSheet, ItemIconTilesSize, VMAIN_Setting(true), ItemIconTilesPosition

          jsl rlDMAByStruct

            .structDMAToVRAM aBG1TilemapBuffer, TilemapPageSize, VMAIN_Setting(true), BG1TilemapPosition

          jsl rlDMAByStruct

            .structDMAToVRAM aBG2TilemapBuffer, (2 * TilemapPageSize), VMAIN_Setting(true), BG2TilemapPosition

          jsl rlDMAByStruct

            .structDMAToVRAM aBG3TilemapBuffer, (2 * TilemapPageSize), VMAIN_Setting(true), BG3TilemapPage0Position

          plb
          plp
          rtl

          .databank 0

        rsMapConvoyWindowSetWindowShading ; 85/C494

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Creates the shading for the map convoy window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with MapConvoyShadingRegions

          jsl rlUnknown8591F0

          lda #Upper.Position[1]
          sta wR0
          lda #Upper.Size[1]
          sta wR1
          jsl rlUnknown859219

          lda #Lower.Position[1]
          sta wR0
          lda #Lower.Size[1]
          sta wR1
          jsl rlUnknown859219

          jsl rlUnknown859205

          rts

          .endwith ; MapConvoyShadingRegions

          .databank 0

        rsMapConvoyWindowDrawItemListRows ; 85/C4B9

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws the convoy item list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with MapConvoyLowerBox

          -
            lda #<>aSelectedCharacterBuffer
            sta wR1
            lda wConvoyWindowItemListScrolledRowOffset
            jsr rsConvoyWindowDrawItemListSliceRow

            lda wConvoyWindowItemListScrolledRowOffset
            clc
            adc #2 * size(word)
            sta wConvoyWindowItemListScrolledRowOffset

            cmp #LineCount * 2 * size(word)
            bne -

          rts

          .endwith ; MapConvoyLowerBox

          .databank 0

        rsMapConvoyWindowCopyHDMATable ; 85/C4D4

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Creates the tilemap position HDMA for the map convoy
          ; window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #(`aMapConvoyWindowInitialHOFSHDMATable)<<8
          sta lR18+size(byte)
          lda #<>aMapConvoyWindowInitialHOFSHDMATable
          sta lR18
          lda #(`aConvoyWindowOFSHDMATable)<<8
          sta lR19+size(byte)
          lda #<>aConvoyWindowOFSHDMATable
          sta lR19
          lda #size(aMapConvoyWindowInitialHOFSHDMATable)
          sta lR20
          jsl rlBlockCopy

          lda #(`aMapConvoyWindowInitialVOFSHDMATable)<<8
          sta lR18+size(byte)
          lda #<>aMapConvoyWindowInitialVOFSHDMATable
          sta lR18
          lda #(`aMapConvoyWindowBG1VOFSHDMATable)<<8
          sta lR19+size(byte)
          lda #<>aMapConvoyWindowBG1VOFSHDMATable
          sta lR19
          lda #size(aMapConvoyWindowInitialVOFSHDMATable)
          sta lR20
          jsl rlBlockCopy

          rts

          .databank 0

      endCode
      startData

        aMapConvoyWindowInitialHOFSHDMATable .block ; 85/C50F

          .byte NTRL_Setting(40)
          .word 0
          .word 0

          .byte NTRL_Setting(88)
          .word 256
          .word 0

          .byte NTRL_Setting(88)
          .word 256
          .word 0

          .byte NTRL_Setting(8)
          .word 0
          .word 0

          .byte 0

        .endblock

        aMapConvoyWindowInitialVOFSHDMATable .block ; 85/C524

          .byte NTRL_Setting(32)
          .sint 0

          .byte NTRL_Setting(96)
          .sint -1

          .byte NTRL_Setting(96)
          .sint -1

          .byte 0

        .endblock

        aMapConvoyBG1VOFSHDMAEntry .structHDMADirectEntryInfo rlMapConvoyBG1VOFSHDMADummy, rlMapConvoyBG1VOFSHDMADummy, aMapConvoyBG1VOFSHDMACode, $7EA95E, BG1VOFS, DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Fixed1, DMAP_Mode2) ; 85/C52E

      endData
      startCode

        rlMapConvoyBG1VOFSHDMADummy ; 85/C539

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          rtl

          .databank 0

      endCode
      startData

        aMapConvoyBG1VOFSHDMACode .block ; 84/C53A

          HDMA_HALT

        .endblock

      endData
      startCode

        rsMapConvoyWindowUpdateBG3VOFS ; 85/C53C

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Updates the BG3 vertical position to reflect our current
          ; scrolled-to point in the map convoy item list.

          ; Inputs:
          ; wConvoyWindowItemListScrolledRowOffset: row

          ; Outputs:
          ; wBufferBG3VOFS: new position

          .with MapConvoyLowerBox

          ldx wConvoyWindowItemListScrolledRowOffset
          lda aConvoyWindowItemListPositions,x
          xba
          and #$00FF
          asl a
          asl a
          asl a
          sec
          sbc #Interior[1] * 8
          and #$00FF
          sta wBufferBG3VOFS
          rts

          .endwith ; MapConvoyLowerBox

          .databank 0

        rsMapConvoyWindowSetLineVariables ; 85/C554

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Sets various default values.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          stz wMenuLineScrollCount
          stz wMenuMinimumLine

          lda #2
          sta wMenuUpScrollThreshold

          lda #8
          sta wMenuDownScrollThreshold

          lda #MapConvoyLowerBox.LineCount
          sta wMenuBottomThreshold

          jsr rsConvoyWindowGetMaximumItemListRow

          stz wConvoyWindowItemListScrolledRowOffset
          stz wConvoyWindowItemListSelectedSide
          stz wConvoyWindowItemListSelectedRow

          rts

          .databank 0

        rsMapConvoyWindowUpdate ; 85/C579

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Picks actions to run on the map convoy window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wBufferBG3VOFS
          sta aConvoyWindowOFSHDMATable.Entries[1].VOFS
          sta aConvoyWindowOFSHDMATable.Entries[2].VOFS

          lda wConvoyWindowActionIndex
          and #$00FF
          asl a
          asl a
          tax
          lda aConvoyWindowActions,x
          sta wR0
          pea <>(+)-1
          jmp (wR0)

          +
          rts

          .databank 0

        rsMapConvoyWindowActionUpdate ; 85/C597

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles updating the map convoy window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsr rsMapConvoyWindowHandleInputs
          jsr rsMapConvoyWindowRenderCursor

          lda wConvoyWindowItemListScrolledRow
          cmp wMenuLineScrollCount
          beq +

            jsr rsMapConvoyWindowScrollItemList

            lda #aConvoyWindowActions.MapConvoyScroll
            sta wConvoyWindowActionIndex

            lda #aConvoyWindowActions.MapConvoyUpdate
            jsl rlPushToQueue

            jmp rsMapConvoyWindowActionScroll

          +
          rts

          .databank 0

        rsMapConvoyWindowHandleInputs ; 85/C5B9

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles inputs on the map convoy window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          pea <>(_End)-1

          lda wJoy1Repeated

          bit #JOY_Up
          bne _Up

          bit #JOY_Down
          bne _Down

          bit #JOY_Left
          bne _Left

          bit #JOY_Right
          bne _Right

          lda wJoy1New

          bit #JOY_B
          beq _End

          jmp _B

          _End
          rts

          _B ; 85/C5DD

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda #<>rsPostBMenuWindowCallback
            sta aProcSystem.wInput0,b

            lda #(`procFadeWithCallback)<<8
            sta lR44+size(byte)
            lda #<>procFadeWithCallback
            sta lR44
            jsl rlProcEngineCreateProc

            lda #aConvoyWindowActions.Leave
            sta wConvoyWindowActionIndex

            rts

            .databank 0

          _Up ; 85/C5F8

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda wConvoyWindowItemListSelectedRow
            jsl rlMenuTryScrollUp
            bcc +

              sta wConvoyWindowItemListSelectedRow

            +
            rts

            .databank 0

          _Down ; 85/C605

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            inc wConvoyWindowItemListSelectedRow
            jsl rlConvoyWindowGetSelectedItemListOffset
            dec wConvoyWindowItemListSelectedRow
            tax
            lda aPrepItemsListItemArray,x
            beq +

            lda wConvoyWindowItemListSelectedRow
            jsl rlMenuTryScrollDown
            bcc +

              sta wConvoyWindowItemListSelectedRow

            +
            rts

            .databank 0

          _Left ; 85/C622

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            stz wConvoyWindowItemListSelectedSide
            rts

            .databank 0

          _Right ; 85/C626

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda wConvoyWindowItemListSelectedSide
            bne +

            jsl rlConvoyWindowGetSelectedItemListOffset

            .rept size(word)
              inc a
            .endrept

            tax
            lda aPrepItemsListItemArray,x
            beq +

              lda #size(word)
              sta wConvoyWindowItemListSelectedSide

            +
            rts

            .databank 0

        rsMapConvoyWindowRenderCursor ; 85/C63E

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Renders the cursor on the map convoy window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with MapConvoyLowerBox

          lda #LeftCursorPositions[0][0]
          sta wR0

          lda wConvoyWindowItemListSelectedSide
          beq +

            lda #RightCursorPositions[0][0]
            sta wR0

          +
          lda wConvoyWindowItemListSelectedRow
          sec
          sbc wMenuLineScrollCount

          asl a
          asl a
          asl a
          asl a
          clc
          adc #Interior[1] * 8
          sta wR1
          jsl rlDrawRightFacingCursor

          rts

          .endwith ; MapConvoyLowerBox

          .databank 0

        rsMapConvoyWindowScrollItemListDown ; 85/C663

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Scrolls the map convoy item list down.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with MapConvoyLowerBox

          lda #<>aSelectedCharacterBuffer
          sta wR1
          lda wConvoyWindowItemListScrolledRowOffset
          clc
          adc #LineCount * 2 * size(word)
          pha
          jsr rsConvoyWindowDrawItemListSliceRow
          pla
          jsr rsConvoyWindowCopyItemListSliceRowTilemap

          lda wConvoyWindowItemListScrolledRowOffset
          clc
          adc #2 * size(word)
          sta wConvoyWindowItemListScrolledRowOffset

          rts

          .endwith ; MapConvoyLowerBox

          .databank 0

        rsMapConvoyWindowScrollItemList ; 85/C682

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles choosing which direction the map
          ; convoy item list is scrolling.

          ; Inputs:
          ; A: current line
          ; wMenuLineScrollCount: target line

          ; Outputs:
          ; None

          cmp wMenuLineScrollCount
          bcc +

            jsl rlConvoyWindowScrollItemListUp
            bra _End

          +
            jsr rsMapConvoyWindowScrollItemListDown

          _End
          rts

          .databank 0

        rsMapConvoyWindowActionScroll ; 85/C691

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Scrolls the map convoy window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsr rsMapConvoyWindowRenderCursor

          lda wConvoyWindowItemListScrolledRow
          sec
          sbc wMenuLineScrollCount
          bmi _Down

            lda #8
            jsl rlSetUpScrollingArrowSpeed

            lda wBufferBG3VOFS
            sec
            sbc #4
            sta wBufferBG3VOFS
            bra +

          _Down
            lda #8
            jsl rlSetDownScrollingArrowSpeed

            lda wBufferBG3VOFS
            clc
            adc #4
            sta wBufferBG3VOFS

          +
          clc
          adc #8
          and #$000F
          beq +

          rts

          +
          lda #2
          jsl rlSetUpScrollingArrowSpeed

          lda #2
          jsl rlSetDownScrollingArrowSpeed

          lda wMenuLineScrollCount
          sta wConvoyWindowItemListScrolledRow

          jsl rlPopFromQueue

          sta wConvoyWindowActionIndex

          rts

          .databank 0

        rsMapConvoyWindowCreateSpinningArrows ; 85/C6E3

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Creates the spinning arrows on the map convoy window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with MapConvoyLowerBox

          lda #DownArrowPosition[0]
          sta wR0
          lda #DownArrowPosition[1]
          sta wR1
          jsl rlCreateDownwardsSpinningArrow

          lda #UpArrowPosition[0]
          sta wR0
          lda #UpArrowPosition[1]
          sta wR1
          jsl rlCreateUpwardsSpinningArrow

          rts

          .endwith ; MapConvoyLowerBox

          .databank 0

        rlConvoyWindowGetItemListCount ; 85/C700

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Counts the number of items in the
          ; convoy.

          ; Inputs:
          ; None

          ; Outputs:
          ; A: item count

          ldx #0

          -
          lda aPrepItemsListItemArray,x
          beq +

          .rept size(word)
            inc x
          .endrept

          bra -

          +
          txa
          lsr a

          rtl

          .databank 0

        rlConvoyWindowGetSourceConvoyItemCount ; 85/C70F

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Counts the number of items in aConvoy.

          ; Inputs:
          ; None

          ; Outputs:
          ; A: item count
          ; X: offset of first free slot in convoy

          ldx #0

          -
          lda aConvoy,x
          beq +

          .rept size(word)
            inc x
          .endrept

          bra -

          +
          txa
          lsr a

          rtl

          .databank 0

        rlConvoyWindowFillConvoyWithRandomNumbers ; 85/C71E

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Fills aConvoy with random numbers.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          stz wR17

          -
          lda #100
          jsl rlGetRandomNumber100
          inc a

          sep #$20

          sta wR0
          xba
          lda wR0

          rep #$30

          ldx wR17
          sta aConvoy,x

          .rept size(word)
            inc x
          .endrept

          stx wR17
          cpx #120 * size(word)
          bne -

          rtl

          .databank 0

        rsConvoyWindowCreateTMHDMA ; 85/C740

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Creates HDMA which handles which layers
          ; are active at certain points.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #<>aConvoyWindowTMHDMAEntry
          sta lR44
          lda #>`aConvoyWindowTMHDMAEntry
          sta lR44+size(byte)
          lda #6
          sta wR40
          jsl rlHDMAArrayEngineCreateEntryByIndex

          rts

          .databank 0

      endCode
      startData

        ; The table bank byte is missing, leading to this
        ; ugly union.

        .union

        .struct

          aConvoyWindowTMHDMAEntry .block ; 85/C754
            .structHDMAIndirectEntryInfo rlConvoyWindowTMHDMADummy, rlConvoyWindowTMHDMADummy, aConvoyWindowTMHDMACode, aConvoyWindowTMHDMATable, TM, DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Increment, DMAP_Mode0), ?
          .endblock

        .endstruct

        .struct

          .fill size(structHDMAIndirectEntryInfo) - size(byte), ?

          rlConvoyWindowTMHDMADummy ; 85/C75F

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            rtl

            .databank 0

        .endstruct

        .endunion

        aConvoyWindowTMHDMACode .block ; 85/C760

          HDMA_HALT

        .endblock

        aConvoyWindowTMHDMATable .block ; 85/C762

          .byte NTRL_Setting(124)
          .byte T_Setting(true, true, true, false, true)

          .byte NTRL_Setting(99)
          .byte T_Setting(true, true, true, false, true)

          .byte NTRL_Setting(1)
          .byte T_Setting(false, false, false, false, false)

          .byte 0

        .endblock

      endData
      startCode

        rlConvoyWindowClearConvoy ; 85/C769

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Clears aConvoy.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          ldx #(len(aConvoy.Items) - 1) * size(word)

          -
          stz aConvoy,x

          .rept size(word)
            dec x
          .endrept

          bpl -

          rtl

          .databank 0

        rlConvoyWindowFillItemListFromConvoy ; 85/C774

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Fills in aPrepItemsListItemArray with items
          ; from aConvoy.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #<>aPrepItemsListItemArray
          sta lR18
          lda #>`aPrepItemsListItemArray
          sta lR18+size(byte)
          lda #0
          jsl rlFillMapByWord

          ldx #(len(aConvoy.Items) - 1) * size(word)

          -
          lda aConvoy,x
          sta aPrepItemsListItemArray,x

          .rept size(word)
            dec x
          .endrept

          bpl -

          rtl

          .databank 0

        rlConvoyWindowFillConvoyFromItemList ; 85/C793

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Fills aConvoy with items from aPrepItemsListItemArray.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          ldx #(len(aConvoy.Items) - 1) * size(word)

          -
          lda aPrepItemsListItemArray,x
          sta aConvoy,x

          .rept size(word)
            dec x
          .endrept

          bpl -

          rtl

          .databank 0

        rlConvoyWindowUnknown85C7A1 ; 85/C7A1

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Unused. Sorts based on aConvoyWindowSortWeightList.

          ; Inputs:
          ; wR17: size of aConvoyWindowSortWeightList
          ; lR18: long pointer to list to sort

          ; Outputs:
          ; None

          lda lR18
          dec a
          dec a
          sta lR19

          .rept size(word)
            dec wR17
          .endrept

          beq _End
          bmi _End

          ldy wR17

          -
            lda aConvoyWindowSortWeightList,y
            cmp aConvoyWindowSortWeightList-size(word),y
            bge _Next

              tax

              lda aConvoyWindowSortWeightList-size(word),y
              sta aConvoyWindowSortWeightList,y

              txa
              sta aConvoyWindowSortWeightList-size(word),y

              lda (lR19),y
              tax

              lda (lR18),y
              sta (lR19),y

              txa
              sta (lR18),y

              cpy wR17
              beq +

                .rept size(word)
                  inc y
                .endrept

              +
              bra -

            _Next

              .rept size(word)
                dec y
              .endrept

              bne -

          _End
          rtl

          .databank 0

        rlConvoyWindowShuffleItems ; 85/C7DB

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Sorts aPrepItemsListItemArray and
          ; aPrepItemsListOwnerArray using the weights
          ; in aConvoyWindowSortWeightList.

          ; Inputs:
          ; wR17: size of aConvoyWindowSortWeightList

          ; Outputs:
          ; None

          .rept size(word)
            dec wR17
          .endrept

          ldy wR17
          beq _End
          bmi _End

          -
          lda aConvoyWindowSortWeightList,y
          cmp aConvoyWindowSortWeightList-size(word),y
          bge _Next

            tax

            lda aConvoyWindowSortWeightList-size(word),y
            sta aConvoyWindowSortWeightList,y

            txa
            sta aConvoyWindowSortWeightList-size(word),y

            lda aPrepItemsListItemArray-size(word),y
            tax

            lda aPrepItemsListItemArray,y
            sta aPrepItemsListItemArray-size(word),y

            txa
            sta aPrepItemsListItemArray,y

            lda aPrepItemsListOwnerArray-size(word),y
            tax

            lda aPrepItemsListOwnerArray,y
            sta aPrepItemsListOwnerArray-size(word),y

            txa
            sta aPrepItemsListOwnerArray,y

            cpy wR17
            beq +

              .rept size(word)
                inc y
              .endrept

            +
            bra -

          _Next

            .rept size(word)
              dec y
            .endrept

            bne -

          _End
          rtl

          .databank 0

        rsConvoyWindowSetNameSortValues ; 85/C821

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Fills aConvoyWindowSortWeightList with
          ; weights according to the item's (Japanese)
          ; name. Uses the base item's name if the item
          ; is broken.

          ; Inputs:
          ; None

          ; Outputs:
          ; aConvoyWindowSortWeightList: filled with weights

          sep #$20

          lda #size(structItemDataEntry)
          sta @l WRMPYA

          rep #$20

          ldy #0

          -
            lda aPrepItemsListItemArray,y
            bne +

              lda aPrepItemsListItemArray+size(word),y
              beq _End

              ; This caps the list with -1.

              lda #-1
              bra _Next

            +
            sta @l WRMPYB
            nop
            nop
            nop
            nop
            lda @l RDMPY
            tax
            lda aItemData+structItemDataEntry.Traits,x

            bit #TraitBroken
            beq _NotBroken

              lda aPrepItemsListItemArray,y
              xba
              bra +

            _NotBroken
              lda aPrepItemsListItemArray,y

            +
            and #$00FF
            tax
            lda aItemKanaSortTable-size(byte),x
            and #$00FF

            _Next
            sta aConvoyWindowSortWeightList,y

            .rept size(word)
              inc y
            .endrept

            bra -

          _End
          sty wR17
          rts

          .databank 0

        rsConvoyWindowSetOwnerSortValues ; 85/C871

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Fills aConvoyWindowSortWeightList based
          ; on character ID.

          ; Inputs:
          ; None

          ; Outputs:
          ; aConvoyWindowSortWeightList: filled with weights

          ldy #0

          -
            lda aPrepItemsListOwnerArray,y
            bne +

              lda aPrepItemsListOwnerArray+size(word),y
              beq _End

                lda #0

            +
            sta aConvoyWindowSortWeightList,y

            .rept size(word)
              inc y
            .endrept

            bra -

          _End
          sty wR17
          rts

          .databank 0

        rsConvoyWindowSetTypeSortValues ; 85/C88B

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Fills aConvoyWindowSortWeightList based
          ; on item type. This actually sorts by lowest -> highest
          ; item ID and sorts by lowest -> highest durability
          ; within an item ID.

          ; Inputs:
          ; None

          ; Outputs:
          ; aConvoyWindowSortWeightList: filled with weights

          ldy #0

          -
            lda aPrepItemsListItemArray,y
            bne +

              lda aPrepItemsListItemArray+size(word),y
              beq _End

                lda #-1

            +
            xba
            sta aConvoyWindowSortWeightList,y

            .rept size(word)
              inc y
            .endrept

            bra -

          _End
          sty wR17
          rts

          .databank 0

        rlConvoyWindowSortItems ; 85/C8A6

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Sorts the convoy item list based on
          ; a passed-in sort type.

          ; Inputs:
          ; A: sort type offset

          ; Outputs:
          ; None

          tax
          lda aConvoyWindowSortHandlers,x
          sta wR0
          pea <>(+)-size(byte)
          jmp (wR0)

          +
          rtl

          .databank 0

      endCode
      startData

        aConvoyWindowSortHandlers .block ; 85/C8B4
          .addr rsConvoyWindowSetTypeSortValues
          .addr rsConvoyWindowSetNameSortValues
          .addr rsConvoyWindowSetOwnerSortValues
        .endblock

      endData
      startProcs

        ; This proc handles creating and updating the scolling arrows.

        procConvoyWindowScrollingArrows .structProcInfo None, rlProcConvoyWindowScrollingArrowsInit, rlProcConvoyWindowScrollingArrowsOnCycle, None ; 85/C8BA

        rlProcConvoyWindowScrollingArrowsInit ; 85/C8C2

          .al
          .xl
          .autsiz
          .databank ?

          php
          phb

          sep #$20

          lda #`wConvoyWindowActionIndex
          pha

          rep #$20

          plb

          .databank `wConvoyWindowActionIndex

          jsr rsConvoyWindowCreateSpinningArrows
          plb
          plp
          rtl

          .databank 0

        rlProcConvoyWindowScrollingArrowsOnCycle ; 85/C8D2

          .al
          .xl
          .autsiz
          .databank ?

          php
          phb

          sep #$20

          lda #`wConvoyWindowActionIndex
          pha

          rep #$20

          plb

          .databank `wConvoyWindowActionIndex

          jsr rsConvoyWindowUpdateScrollingArrows
          plb
          plp
          rtl

          .databank 0

      endProcs
      startCode

        rlConvoyWindowKillScrollingArrows ; 85/C8E2

          .al
          .xl
          .autsiz
          .databank ?

          ; Kills the scpiining arrow procs.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .for _Proc in [procUpArrow, procDownArrow, procConvoyWindowScrollingArrows]

            lda #(`_Proc)<<8
            sta lR44+size(byte)
            lda #<>_Proc
            sta lR44
            jsl rlProcEngineFindProc
            bcc +

              stz aProcSystem.aHeaderTypeOffset,b,x

            +

          .endfor

          rtl

          .databank 0

        rsConvoyWindowSetupItemListScrollStep ; 85/C91C

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Begins scrolling the convoy item list.

          ; Inputs:
          ; A: scroll amount per step, signed

          ; Outputs:
          ; None

          sta wPrepScrollDirectionIncrement

          lda wJoy1Input
          bit #JOY_Y
          bne _Fast

            lda #4
            sta wPrepScrollDirectionStep
            lda #8
            sta wR17
            bra +

          _Fast
            lda wPrepScrollDirectionIncrement
            asl a
            sta wPrepScrollDirectionIncrement
            lda #2
            sta wPrepScrollDirectionStep
            lda #16
            sta wR17

          +
          lda wConvoyWindowActionIndex
          jsl rlPushToQueue

          lda #aConvoyWindowActions.ItemListScroll
          sta wConvoyWindowActionIndex

          lda wPrepScrollDirectionIncrement
          bmi _Down

            lda wR17
            jsl rlSetUpScrollingArrowSpeed
            bra rsConvoyWindowActionItemListScrollStep

          _Down
            lda wR17
            jsl rlSetDownScrollingArrowSpeed
            bra rsConvoyWindowActionItemListScrollStep

          .databank 0

        rsConvoyWindowActionItemListScrollStep ; 85/C967

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Actually does the scrolling.

          ; Inputs:
          ; wPrepScrollDirectionIncrement: scroll amount per step, signed
          ; wPrepScrollDirectionStep: number of steps to scroll

          ; Outputs:
          ; None

          lda wBufferBG3VOFS
          sec
          sbc wPrepScrollDirectionIncrement
          sta wBufferBG3VOFS

          dec wPrepScrollDirectionStep
          bne +

            jsl rlPopFromQueue
            sta wConvoyWindowActionIndex

            lda #2
            jsl rlSetUpScrollingArrowSpeed

            lda #2
            jsl rlSetDownScrollingArrowSpeed

          +
          lda wPrepListCursorXCoordinate
          sta wR0
          lda wPrepListCursorYCoordinate
          sta wR1
          jsl rlDrawRightFacingCursor

          jsr rsConvoyWindowRenderSourceSelectionCursor

          rts

          .databank 0

        rsConvoyWindowSetPositionFromPrepItems ; 85/C99B

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Sets the convoy item list scroll position
          ; when entering the convoy when picking
          ; an item owned by the convoy from the prep items
          ; list.

          ; Inputs:
          ; A: item offset

          ; Outputs:
          ; wMenuLineScrollCount: number of rows scrolled
          ; wConvoyWindowItemListScrolledRowOffset: offset
          ; wConvoyWindowItemListSelectedSide: side
          ; wConvoyWindowItemListSelectedRow: item's row
          ; wConvoyWindowActionIndex: aConvoyWindowActions.ItemList

          sta wR0
          lsr a
          lsr a
          inc a
          inc a
          cmp wMenuMaximumLine
          blt +

            lda wMenuMaximumLine

          +
          sta wR2
          sec
          sbc #2 * size(word)
          bpl +

            lda #0

          +
          sta wR1
          sta wMenuLineScrollCount
          asl a
          asl a
          sta wConvoyWindowItemListScrolledRowOffset
          lda wR0
          and #$0002
          sta wConvoyWindowItemListSelectedSide
          lda wR0
          lsr a
          lsr a
          sta wConvoyWindowItemListSelectedRow

          lda #aConvoyWindowActions.ItemList
          sta wConvoyWindowActionIndex

          rts

          .databank 0

        rsConvoyWindowActionDiscard ; 85/C9D4

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles trying to discard an item from the convoy item list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          ; Wait while we're in the middle of discarding
          ; an item.

          phx

          lda #(`procConvoyWindowDiscard)<<8
          sta lR44+size(byte)
          lda #<>procConvoyWindowDiscard
          sta lR44
          jsl rlProcEngineFindProc

          plx
          bcs _End

            jsr rsConvoyWindowRenderSourceSelectionCursor

            ; If we run out of items in the convoy, switch to
            ; selecting an action.

            lda aPrepItemsListItemArray
            bne +

              jmp rsConvoyWindowGetNextAction

            +
            lda wMenuLineScrollCount
            sta wConvoyWindowItemListScrolledRow

            jsl rlConvoyWindowHandleItemListDirectionInputs
            jsr rsConvoyWindowHandleDiscardOtherInputs
            jsr rsConvoyWindowHandleDiscardInputs
            jsl rlConvoyWindowDrawItemListCursor

            ; Scroll if we need to.

            lda wConvoyWindowItemListScrolledRow
            sec
            sbc wMenuLineScrollCount
            beq _End

              asl a
              asl a
              jsr rsConvoyWindowSetupItemListScrollStep

              lda wConvoyWindowItemListScrolledRow
              jsl rlConvoyWindowScrollItemList

          _End
          rts

          .databank 0

        rsConvoyWindowHandleDiscardInputs ; 85/CA1B

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles pressing `A` or `B` when discarding.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          pea <>(_Return)-1

          lda wJoy1New

          _NewInputs  := [(JOY_B, rlConvoyWindowHandleItemListOtherInputs._B)]
          _NewInputs ..= [(JOY_A, _A)]

          .for _Pressed, _Handler in _NewInputs

            bit #_Pressed
            beq +

              jmp _Handler

            +

          .endfor

          rts

          _Return
          rts

          .databank 0

          _A ; 85/CA32

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            ; Discards the currently-selected item.

            jsl rlConvoyWindowGetSelectedItemListOffset
            tax
            lda aPrepItemsListItemArray,x
            jsl rlCopyItemDataToBuffer

            lda aItemDataBuffer.Traits,b
            bit #TraitUnsellable
            bne _CannotDiscard

              lda #$000C ; TODO: sound definitions
              jsl rlPlaySoundEffect

              lda #$0002
              sta wActiveTileUnitParameter1

              jsr rsConvoyWindowDrawDiscardPrompt
              jsl rlEnableBG3Sync

              lda #aConvoyWindowActions.DiscardConfirm
              sta wConvoyWindowActionIndex

              rts

            _CannotDiscard
            lda #$0022 ; TODO: sound definitions
            jsl rlPlaySoundEffect
            rts

            .databank 0

        rsConvoyWindowDrawDiscardPrompt ; 85/CA69

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws the discard prompt to the selection window
          ; and saves the overwritten part of the tilemap.

          ; Inputs:
          ; None

          ; Outputs:
          ; aMenuTilemapBuffers.aBuffers[2]: old tilemap slice

          .with SelectionBox

          lda #>`aBG3TilemapBuffer
          sta lR18+size(byte)
          lda #<>aBG3TilemapBuffer + (C2I(Interior, 32) * size(word))
          sta lR18
          lda #<>aMenuTilemapBuffers.aBuffers[2]
          sta lR19
          lda #>`aMenuTilemapBuffers.aBuffers[2]
          sta lR19+size(byte)
          lda #InteriorSize[0]
          sta wR0
          lda #InteriorSize[1]
          sta wR1
          jsl rlCopyWindowTilemapRect

          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b
          lda #>`aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

          lda #TilemapEntry(MenuTilesBaseTile, TextWhite, 1, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          lda #<>_menutextDiscardText
          sta lR18
          lda #>`_menutextDiscardText
          sta lR18+size(byte)
          ldx #pack(Interior)
          jsl rlDrawMultilineMenuText
          rts

          .endwith ; SelectionBox

          .databank 0

          endCode
          startMenuText

            _menutextDiscardText .block ; 85/CAAF
              .enc "SJIS"
              .text "ほんとうにすてますか　　\n"
              .text "　　はい　　　いいえ　　\n"
              .text "\n"
            .endblock

          endMenuText
          startCode

        rsConvoyWindowRestoreDiscardTilemap ; 85/CAE5

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Restores the saved tilemap slice from the selection box.

          ; Inputs:
          ; aMenuTilemapBuffers.aBuffers[2]: tilemap slice

          ; Outputs:
          ; None

          .with SelectionBox

          lda #>`aBG3TilemapBuffer
          sta lR19+size(byte)
          lda #<>aBG3TilemapBuffer + (C2I(Interior, 32) * size(word))
          sta lR19
          lda #<>aMenuTilemapBuffers.aBuffers[2]
          sta lR18
          lda #>`aMenuTilemapBuffers.aBuffers[2]
          sta lR18+size(byte)
          lda #InteriorSize[0]
          sta wR0
          lda #InteriorSize[1]
          sta wR1
          jsl rlRevertWindowTilemapRect
          rts

          .endwith ; SelectionBox

          .databank 0

        rsConvoyWindowActionDiscardConfirm ; 85/CB08

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles the yes/no prompt when discarding.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsr rsConvoyWindowHandleDiscardConfirmInputs
          jsl rlPrepItemsDrawDiscardCursor
          jsl rlConvoyWindowDrawItemListDiscardItemCursor
          rts

          .databank 0

        rsConvoyWindowHandleDiscardConfirmInputs ; 85/CB14

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Handles inputs when confirming to discard.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wJoy1New

          _NewInputs  := [(JOY_Left,  _Left)]
          _NewInputs ..= [(JOY_Right, _Right)]
          _NewInputs ..= [(JOY_B,     _B)]
          _NewInputs ..= [(JOY_A,     _A)]

          .for _Pressed, _Handler in _NewInputs

            bit #_Pressed
            bne _Handler

          .endfor

          rts

          _Left ; 85/CB2B

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            stz wActiveTileUnitParameter1

            rts

            .databank 0

          _Right ; 85/CB36

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            lda #$0002
            sta wActiveTileUnitParameter1

            rts

            .databank 0

          _B ; 85/CB44

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda #$0021 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            jsr rsConvoyWindowRestoreDiscardTilemap
            jsl rlEnableBG3Sync

            lda #aConvoyWindowActions.Discard
            sta wConvoyWindowActionIndex

            rts

            .databank 0

          _A ; 85/CB59

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            lda wActiveTileUnitParameter1
            bne _B

              lda #$000C ; TODO: sound definitions
              jsl rlPlaySoundEffect

              jsr rsConvoyWindowRestoreDiscardTilemap
              jsl rlEnableBG3Sync

              lda #aConvoyWindowActions.Discard
              sta wConvoyWindowActionIndex

              phx

              lda #(`procConvoyWindowDiscard)<<8
              sta lR44+size(byte)
              lda #<>procConvoyWindowDiscard
              sta lR44
              jsl rlProcEngineCreateProc

              plx

              rts

            .databank 0

      endCode
      startProcs

        ; This handles actually getting rid of the item and updates
        ; the list and tilemaps.

        procConvoyWindowDiscard .structProcInfo None, rlProcConvoyWindowDiscardInit, rlProcConvoyWindowDiscardOnCycle, None, ; 85/CB83

        rlProcConvoyWindowDiscardInit ; 85/CB8B

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          rtl

          .databank 0

        rlProcConvoyWindowDiscardOnCycle ; 85/CB8C

          .al
          .xl
          .autsiz
          .databank ?

          ; This deletes the currently-selected item
          ; and reorganizes the convoy item list to
          ; reflect that.

          php
          phb

          sep #$20

          lda #`wConvoyWindowDiscardOffset
          pha

          rep #$20

          plb

          .databank `wConvoyWindowDiscardOffset

          phx

          jsl rlConvoyWindowGetSelectedItemListOffset
          sta wConvoyWindowDiscardOffset
          tax
          stz aPrepItemsListItemArray,x

          lda wConvoyWindowItemListSortSetting
          jsl rlConvoyWindowSortItems
          jsl rlConvoyWindowShuffleItems
          jsl rlConvoyWindowDrawVisibleItemListSlice

          plx

          lda #<>rlProcConvoyWindowDiscardOnCycle2
          sta aProcSystem.aHeaderOnCycle,b,x

          plb
          plp
          rtl

          .databank 0

        rlProcConvoyWindowDiscardOnCycle2 ; 85/CBBB

          .al
          .xl
          .autsiz
          .databank ?

          ; This updates the BG3 tilemap.

          lda bDMAArrayFlag,b
          and #$00FF
          bne +

          lda #<>rlProcConvoyWindowDiscardOnCycle3
          sta aProcSystem.aHeaderOnCycle,b,x
          jsl rlDMAByStruct

            .structDMAToVRAM aBG3TilemapBuffer.Page1, TilemapPageSize, VMAIN_Setting(true), BG3TilemapPage1Position

          +
          rtl

          .databank 0

        rlProcConvoyWindowDiscardOnCycle3 ; 85/CBD7

          .al
          .xl
          .autsiz
          .databank ?

          ; This updates the BG2 tilemap.

          lda bDMAArrayFlag,b
          and #$00FF
          bne +

          lda #<>rlProcConvoyWindowDiscardOnCycle4
          sta aProcSystem.aHeaderOnCycle,b,x
          jsl rlDMAByStruct

            .structDMAToVRAM aBG2TilemapBuffer.Page1, TilemapPageSize, VMAIN_Setting(true), BG2TilemapPosition+TilemapPageSize

          +
          rtl

          .databank 0

        rlProcConvoyWindowDiscardOnCycle4 ; 85/CBF3

          .al
          .xl
          .autsiz
          .databank ?

          ; This handles possibly scrolling the convoy item list up
          ; after discarding the last item.

          php
          phb

          sep #$20

          lda #`wConvoyWindowDiscardOffset
          pha

          rep #$20

          plb

          .databank `wConvoyWindowDiscardOffset

          phx
          ldy wConvoyWindowDiscardOffset
          lda aPrepItemsListItemArray,y
          bne +

            lda wMenuLineScrollCount
            pha
            dec y
            dec y
            tya
            jsr rsConvoyWindowTryScrollItemListUp
            pla
            cmp wMenuLineScrollCount
            beq +

              plx
              jsl rlProcEngineFreeProc

              lda #4
              jsr rsConvoyWindowSetupItemListScrollStep
              lda wMenuLineScrollCount
              inc a
              jsl rlConvoyWindowScrollItemList
              plb
              plp
              rtl

          +
          plx
          jsl rlProcEngineFreeProc
          plb
          plp
          rtl

          .databank 0

      endProcs
      startCode

        rlAddItemToConvoy ; 85/CC34

          .al
          .xl
          .autsiz
          .databank ?

          ; Adds an item to the convoy, overwriting
          ; the least-valuable item in it if it is full.

          ; Inputs:
          ; A: packed item
          ; aConvoy: filled with items

          ; Outputs:
          ; None

          php
          phb

          pha

          sep #$20

          lda #`aConvoy
          pha

          rep #$20

          plb

          .databank `aConvoy

          lda aConvoy.Items[-1]
          bne _Full

            jsl rlConvoyWindowGetSourceConvoyItemCount

            pla

            sta aConvoy,x
            bra _End

          _Full
            jsl rlGetLeastValuableConvoyItemOffset
            pla
            sta aConvoy,x

          _End
          plb
          plp
          rtl

          .databank 0

        rlConvoyWindowDisplayInfoWindow ; 85/CC59

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws the item info window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          .with ItemInfoBox

          pha

          lda wConvoyWindowActionIndex
          jsl rlPushToQueue
          lda wPrepItemsActionIndex
          jsl rlPushToQueue
          lda wBufferBG3VOFS
          jsl rlPushToQueue

          jsl rlConvoyWindowInfoWindowCopyVisibleItemListRows
          jsr rsConvoyWindowInfoWindowClearScrollAndHDMA
          jsl rlDrawItemInfoWindowBackground

          lda #Interior[0]
          sta wR0
          lda #Interior[1]
          sta wR1
          lda #int(true)
          sta wR2
          jsl rlDrawItemInfo

          pla
          sta wInfoWindowTarget

          lda #aConvoyWindowActions.ItemList
          cmp wConvoyWindowActionIndex
          bne +

            phx

            lda #(`procConvoyWindowRenderSourceSelectionCursor)<<8
            sta lR44+size(byte)
            lda #<>procConvoyWindowRenderSourceSelectionCursor
            sta lR44
            jsl rlProcEngineCreateProc

            plx

          +
          lda #aConvoyWindowActions.InfoWindow
          sta wConvoyWindowActionIndex

          lda #$0015 ; TODO: prep items actions
          sta wPrepItemsActionIndex

          rtl

          .endwith ; ItemInfoBox

          .databank 0

        rsConvoyWindowInfoWindowClearScrollAndHDMA ; 85/CCB5

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Resets the vertical scroll positions and
          ; kills the convoy item list HDMA so that a static
          ; slice of the item list can be drawn and the item
          ; info window then drawn over it.

          lda #1
          sta wBufferBG3VOFS
          sta wBufferBG2VOFS

          lda #3
          jsl rlHDMAEngineFreeEntryByIndex

          lda #4
          jsl rlHDMAEngineFreeEntryByIndex

          rts

          .databank 0

        rlConvoyWindowInfoWindowCopyVisibleItemListRows ; 85/CCCB

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Copies the visile convoy item list rows
          ; into the first tilemap page so that we
          ; can draw the item info box.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wConvoyWindowItemListScrolledRowOffset
          sta wR16
          stz wR17

          .rept ConvoyItemBox.RowCount
            jsr _CopyRow
          .endrept

          rtl

          .databank 0

          _CopyRow ; 85/CCE2

            .al
            .xl
            .autsiz
            .databank `wConvoyWindowActionIndex

            ; Copies a single convoy item list row.

            ; Inputs:
            ; wR16: row offset
            ; wR17: convoy item offset

            ; Outputs:
            ; None

            ldx wR17

            lda _TilemapPositions,x
            pha

            clc
            adc #<>aBG3TilemapBuffer
            sta lR19

            lda #>`aBG3TilemapBuffer
            sta lR18+size(byte)

            ldx wR16
            lda aConvoyWindowItemListPositions,x
            and #$FF00
            lsr a
            lsr a
            pha

            clc
            adc #<>aBG3TilemapBuffer.Page1
            sta lR18

            lda #32
            sta wR0
            lda #2
            sta wR1
            stz aCurrentTilemapInfo.wBaseTile,b
            jsl rlDrawTilemapPackedRect

            pla
            clc
            adc #<>aBG2TilemapBuffer.Page1
            sta lR18

            pla
            clc
            adc #<>aBG2TilemapBuffer
            sta lR19

            lda #32
            sta wR0
            lda #2
            sta wR1
            stz aCurrentTilemapInfo.wBaseTile,b
            jsl rlDrawTilemapPackedRect

            .rept size(word)
              inc wR17
            .endrept

            .rept 2 * size(word)
              inc wR16
            .endrept

            rts

            .databank 0

          endCode
          startData

            _TilemapPositions .block ; 85/CD43

              .with ConvoyItemBox

              .for _YOffset in range(0, RowCount * 2, 2)

                .word C2I(SliceOrigin + (0, _YOffset), 32) * size(word)

              .endfor

              .endwith ; ConvoyItemBox

            .endblock

          endData
          startCode

        rlConvoyWindowCloseInfoWindow ; 85/CD4D

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Closes the item info window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsl rlPopFromQueue
          sta wBufferBG2VOFS
          sta wBufferBG3VOFS

          jsl rlPopFromQueue
          sta wPrepItemsActionIndex

          jsl rlPopFromQueue
          sta wConvoyWindowActionIndex

          lda #(`procConvoyWindowRenderSourceSelectionCursor)<<8
          sta lR44+size(byte)
          lda #<>procConvoyWindowRenderSourceSelectionCursor
          sta lR44
          jsl rlProcEngineFindProc
          bcc +

            stz aProcSystem.aHeaderTypeOffset,b,x

          +
          lda #(`procConvoyWindowRenderItemListCursor)<<8
          sta lR44+size(byte)
          lda #<>procConvoyWindowRenderItemListCursor
          sta lR44
          jsl rlProcEngineFindProc
          bcc +

            stz aProcSystem.aHeaderTypeOffset,b,x

          +
          lda #(`procConvoyWindowRenderUnitItemListCursor)<<8
          sta lR44+size(byte)
          lda #<>procConvoyWindowRenderUnitItemListCursor
          sta lR44
          jsl rlProcEngineFindProc
          bcc +

            stz aProcSystem.aHeaderTypeOffset,b,x

          +
          jsl rlRevertItemInfoWindowBackground
          jsl rlCloseItemInfo
          jsl rlConvoyWindowCreateHOFSHDMA
          rtl

          .databank 0

        rsConvoyWindowActionHandleInfoWindowInputs ; 85/CDA9

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Closes the item info window if any button
          ; is pressed.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wJoy1New
          and #JOY_All
          beq +

            jsl rlConvoyWindowCloseInfoWindow

          +
          rts

          .databank 0

        rlConvoyWindowGetSortTypeText ; 85/CDB5

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Gets a pointer to the current sort type's text.

          ; Inputs:
          ; A: sort type offset

          ; Outputs:
          ; lR18: long pointer to menu text

          tax
          lda #>`menutextSortByType
          sta lR18+size(byte)
          lda _TextPointers,x
          sta lR18
          rtl

          .databank 0

          endCode
          startData

            _TextPointers .block ; 85/CDC2

              .addr menutextSortByType
              .addr menutextSortByKana
              .addr menutextSortByOwner

            .endblock

          endData
          startCode

      endCode
      startMenuText

        menutextSortByType .block ; 85/CDC8
          .enc "SJIS"
          .text "ＸＹＺ種類順\n"

        .endblock

        menutextSortByKana .block ; 85/CDD6
          .enc "SJIS"
          .text "ＸＹＺかな順\n"

        .endblock

        menutextSortByOwner .block ; 85/CDE4
          .enc "SJIS"
          .text "ＸＹＺ所持順\n"

        .endblock

      endMenuText
      startCode

        rlConvoyWindowDrawSortTypeText ; 85/CDF2

          .al
          .xl
          .autsiz
          .databank `wConvoyWindowActionIndex

          ; Draws the current sort setting's text.

          ; Inputs:
          ; wConvoyWindowItemListSortSetting: sort type

          ; Outputs:
          ; None

          .with SelectionBox

          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b
          lda #>`aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b

          lda #TilemapEntry(MenuTilesBaseTile, TextBlue, 1, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          lda wConvoyWindowItemListSortSetting
          jsl rlConvoyWindowGetSortTypeText
          ldx #pack(SortTextPosition)
          jsl rlDrawMenuText
          jsl rlDMAByStruct

            .structDMAToVRAM aBG3TilemapBuffer + (C2I((0, SortTextPosition[1]), 32) * size(word)), 2 * 32 * size(word), VMAIN_Setting(true), BG3TilemapPage0Position + (C2I((0, SortTextPosition[1]), 32) * size(word))

          rtl

          .endwith ; SelectionBox

          .databank 0

      endCode
      startProcs

        ; Renders the cursor in the selection window.

        procConvoyWindowRenderSourceSelectionCursor .structProcInfo None, rlProcConvoyWindowRenderSourceSelectionCursorOnCycle._End, rlProcConvoyWindowRenderSourceSelectionCursorOnCycle, None ; 85/CE20

        rlProcConvoyWindowRenderSourceSelectionCursorOnCycle ; 85/CE28

          .al
          .xl
          .autsiz
          .databank ?

          php
          phb

          sep #$20

          lda #`wConvoyWindowActionIndex
          pha

          rep #$20

          plb

          .databank `wConvoyWindowActionIndex

          jsr rsConvoyWindowRenderSourceSelectionCursor

          plb
          plp

          _End
          rtl

          .databank 0

        ; Renders the cursor in the convoy item list.

        procConvoyWindowRenderItemListCursor .structProcInfo None, rlProcConvoyWindowRenderSourceSelectionCursorOnCycle._End, rlProcConvoyWindowRenderItemListCursorOnCycle, None ; 85/CE38

        rlProcConvoyWindowRenderItemListCursorOnCycle ; 85/CE40

          .al
          .xl
          .autsiz
          .databank ?

          php
          phb

          sep #$20

          lda #`wConvoyWindowActionIndex
          pha

          rep #$20

          plb

          .databank `wConvoyWindowActionIndex

          jsl rlConvoyWindowDrawItemListCursor

          plb
          plp
          rtl

          .databank 0

        ; Renders the cursor in the unit item list.

        procConvoyWindowRenderUnitItemListCursor .structProcInfo None, rlProcConvoyWindowRenderSourceSelectionCursorOnCycle._End, rlProcConvoyWindowRenderUnitItemListCursorOnCycle, None ; 85/CE51

        rlProcConvoyWindowRenderUnitItemListCursorOnCycle ; 85/CE59

          .al
          .xl
          .autsiz
          .databank ?

          php
          phb

          sep #$20

          lda #`wConvoyWindowActionIndex
          pha

          rep #$20

          plb

          .databank `wConvoyWindowActionIndex

          jsr rsConvoyWindowRenderUnitItemListCursor

          plb
          plp
          rtl

          .databank 0

      endProcs
      startCode

        rsConvoyWindowHandleDiscardOtherInputs ; 85/CE69

          .al
          .xl
          .autsiz
          .databank ?

          ; Handles other inputs when discarding.
          ; It seems like pressing `L` is supposed
          ; to work the same as pressing `L` on the other
          ; actions, but instead checks against `R` again,
          ; and is never reached.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wJoy1New

          _NewInputs  := [(JOY_R,      rsConvoyWindowHandleRPress)]
          _NewInputs ..= [(JOY_R,      rsConvoyWindowHandleLPress)]
          _NewInputs ..= [(JOY_Select, rsConvoyWindowSwapItemListSortStyle)]

          .for _Pressed, _Handler in _NewInputs

            bit #_Pressed
            beq +

              jmp _Handler

            +

          .endfor

          rts

          .databank 0

      endCode

      .endwith ; ConvoyWindowConfig

    .endsection ConvoyWindowSection

.endif ; GUARD_FE5_CONVOY_WINDOW
