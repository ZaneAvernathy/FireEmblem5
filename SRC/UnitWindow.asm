
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_UNIT_WINDOW :?= false
.if (!GUARD_FE5_UNIT_WINDOW)
  GUARD_FE5_UNIT_WINDOW := true

  ; Definitions

    .weak

      rlGetJoypadInput             :?= address($808002)
      rlDMAPaletteAndOAMBuffer     :?= address($80807C)
      rlCopyPPURegisterBuffer      :?= address($8080C3)
      rlEnableVBlank               :?= address($8082DA)
      rlDisableVBlank              :?= address($8082E8)
      rlHaltUntilVBlank            :?= address($8082F6)
      rlHideAllSprites             :?= address($808325)
      rlHideSprites                :?= address($808328)
      rlClearSpriteExtBuffer       :?= address($8083FB)
      rlPushToOAMBuffer            :?= address($808881)
      rlPlaySoundEffect            :?= address($808C87)
      rlProcessSoundQueues         :?= address($808D9C)
      rlUnknown80932C              :?= address($80932C)
      rlRunCurrentTask             :?= address($80A50F)
      rlRunTaskMainLoops           :?= address($80A5DF)
      rsUnknown80A6BD              :?= address($80A6BD)
      rlInitializeCPUWriteOnlyIORegisters :?= address($80A6CA)
      rlInitializePPUWriteOnlyIORegisters :?= address($80A711)
      rlSetLayerPositionsAndSizes  :?= address($80A883)
      rlUnsignedDivide16By16       :?= address($80AB18)
      rlHandlePossibleHDMA         :?= address($80AC95)
      rlProcessDMAStructArray      :?= address($80ACC4)
      rlDMAByStruct                :?= address($80AE2E)
      rlDMAByPointer               :?= address($80AEF9)
      rlAdvanceFrameCounters       :?= address($80B0D1)
      rlBlockCopy                  :?= address($80B340)
      rlFillTilemapByWord          :?= address($80E89F)
      rlActiveSpriteEngineReset    :?= address($8181A9)
      rlGetStatusString            :?= address($81DA0F)
      rlProcEngineReset            :?= address($829BDB)
      rlProcEngineCreateProc       :?= address($829BF1)
      rlProcEngineFindProc         :?= address($829CEC)
      rlProcEngineFreeProc         :?= address($829D11)
      rlHDMAEngineCreateEntry      :?= address($82A3ED)
      rlHDMAEngineReset            :?= address($82A3AD)
      rlHDMAEngineCreateEntryByIndex :?= address($82A470)
      rlIRQEngineReset             :?= address($82A6AE)
      rlGetEffectiveMove :?= address($8387D5)
      rlCopyCharacterDataToBufferByDeploymentNumber :?= address($83901C)
      rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot :?= address($839086)
      rlCombineCharacterDataAndClassWeaponRanks :?= address($8391B4)
      rlGetEquippableItemInventoryOffset :?= address($839705)
      rlGetItemNamePointer  :?= address($83931A)
      rlGetCharacterNamePointer :?= address($839334)
      rlGetClassNamePointer :?= address($839351)
      rlGetRankString              :?= address($839385)
      rlRunRoutineForAllUnitsInAllegiance :?= address($839825)
      rlDoRegisteredStandingMapSpriteStep :?= address($83C393)
      rlCreateUpwardsSpinningArrow   :?= address($83CB26)
      rlCreateDownwardsSpinningArrow :?= address($83CB53)
      rlActionStructSingleEntry    :?= address($83CE64)
      rlSetUpScrollingArrowSpeed   :?= address($83CCB1)
      rlSetDownScrollingArrowSpeed :?= address($83CCC9)
      rlToggleUpwardsSpinningArrow   :?= address($83CCE1)
      rlToggleDownwardsSpinningArrow :?= address($83CCF9)
      rlDrawNumberMenuText         :?= address($858859)
      rlDrawRightFacingCursor      :?= address($859013)
      rlUnknown8591F0              :?= address($8591F0)
      rlUnknown859205              :?= address($859205)
      rlUnknown859233              :?= address($859233)
      rlTryUpdateShadingBuffer     :?= address($859352)
      rlWriteCharacterBufferDeploymentInfo :?= address($85FAA0)
      rlRegisterPrepScreenStandingMapSprites :?= address($85F717)
      rlDrawMenuText               :?= address($87E728)
      rlCopyBackgroundHDMAPositionsFromBuffers :?= address($8E8A7D)

      procRightFacingCursor :?= address($8EB06F)

      aItemIconPalette       :?= address($9E8220)
      aWeaponRankIconPalette :?= address($9E8240)

      aUnitWindowUnknownUpperTilemap     :?= address($9F8000)
      g4bppUnitWindowSkillIcons          :?= address($9F81C0)
      g4bppUnitWindowBorderTiles         :?= address($9F8DC0)
      aUnitWindowUpperTilemap            :?= address($9F93C0)
      aUnitWindowBG2Tilemap              :?= address($9FA2C0)
      aUnitWindowUpperBackgroundPalettes :?= address($9FA9C0)
      aUnitWindowTextPalettes            :?= address($9FAA00)
      g2bppUnitWindowPageLabels          :?= address($9FB1C0)
      g4bppSystemIcons                   :?= address($F1F080)

      IconSheet :?= address($F28000)

      g2bppWeaponRankIcons               :?= address($F2D380)
      g2bppMenuTiles                     :?= address($F3CC80)
      g4bppMenuBackgroundTiles           :?= address($F48000)
      aMenuBackgroundPalettes            :?= address($F4FE00)

    .endweak

    UnitWindowConfig .namespace

      ; VRAM positions

        OAMBase = $0000
        BG1Base = $4000
        BG2Base = BG1Base
        BG3Base = $C000

        ; See below
        ; BG1TilemapPosition = $9000
        ; BG2TilemapPosition = $6000
        ; BG3TilemapPosition = $F000

        OAMTilesPosition := OAMBase
        OAMAllocate .function Size
          Return := UnitWindowConfig.OAMTilesPosition
          UnitWindowConfig.OAMTilesPosition += Size
        .endfunction Return

        BG12TilesPosition := BG1Base
        BG12Allocate .function Size
          Return := UnitWindowConfig.BG12TilesPosition
          UnitWindowConfig.BG12TilesPosition += Size
        .endfunction Return

        BG3TilesPosition := BG3Base
        BG3Allocate .function Size
          Return := UnitWindowConfig.BG3TilesPosition
          UnitWindowConfig.BG3TilesPosition += Size
        .endfunction Return

        StandingMapSpriteTilesPosition = OAMAllocate(64 * (2 * 2 * size(Tile4bpp)))
        SystemIconTilesPosition        = OAMAllocate(16 * 4 * size(Tile4bpp))
        WeaponRankIconTilesPosition    = OAMAllocate(16 * 4 * size(Tile4bpp))

        BorderTilesPosition         = BG12Allocate(16 * 3 * size(Tile4bpp))
        MenuBackgroundTilesPosition = BG12Allocate(16 * 4 * size(Tile4bpp))

        _ := BG12Allocate($6000 - BG12TilesPosition)
        BG2TilemapPosition = BG12Allocate(64 * 32 * size(word))

        ItemIconTilesPosition = BG12Allocate(64 * (2 * 2 * size(Tile4bpp)))

        _ := BG12Allocate($9000 - BG12TilesPosition)
        BG1TilemapPosition = BG12Allocate(64 * 32 * size(word))

        SkillIconTilesPosition = BG12Allocate(64 * (2 * 2 * size(Tile4bpp)))

        MenuTextTilesPosition  = BG3Allocate(16 * 40 * size(Tile2bpp))
        SortLabelTilesPosition = BG3Allocate(16 * 8 * size(Tile2bpp))

        BG3TilemapPosition = BG3Allocate(64 * 32 * size(word))

        MenuTilesBaseTile = VRAMToTile(MenuTextTilesPosition, BG3Base, size(Tile2bpp))

      ; Unit window types

        ; FE5 uses `wUnitWindowType` to keep track of how it
        ; entered the unit window.

        WindowTypes .namespace

          FromMap           = bits(%00)
          ReturningFromUnit = bits(%01)
          FromPrep          = bits(%10)

          ; Precomposed helpers

          FromUnitDuringMap  = (FromMap | ReturningFromUnit)
          FromUnitDuringPrep = (FromPrep | ReturningFromUnit)

        .endnamespace

      ; (Start, Stop) Y coordinates
      UpperZone = (30, 50)
      LowerZone = (52, 224)

      ; Pixel coordinates
      UpwardsArrow   = (7,  54)
      DownwardsArrow = (7, 213)

      WeaponRankSortIcon = (147, 16)
      FE4SortLabelCursor = (128, 7)
      SortDirectionArrow = (160, 11)

      WeaponRankIcons = (164, 41)

      SortSelectorCursorBase = (8, 39)

    .endnamespace ; UnitWindowConfig

  ; Freespace inclusions

    .section UnitWindow80Section

      .with UnitWindowConfig

      startCode

        rsUnitWindowVBlankUpdater ; 80/C623

          .autsiz
          .databank ?

          ; This routine is ran every VBlank while on
          ; the unit window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          sep #$20

          lda #INIDISP_Setting(true)
          sta INIDISP,b

          lda #None
          sta HDMAEN

          rep #$20

          jsl rlProcessDMAStructArray
          jsl rlDMAPaletteAndOAMBuffer
          jsl rlHandlePossibleHDMA
          jsl rlTryUpdateShadingBuffer
          jsl rlCopyBackgroundHDMAPositionsFromBuffers
          jsl rlCopyPPURegisterBuffer
          jsl rlProcessSoundQueues
          jsl rlGetJoypadInput
          jsl rlAdvanceFrameCounters
          jsl rlClearSpriteExtBuffer
          jsl rlRunTaskMainLoops
          jsl rlRunCurrentTask
          jsl rlDoRegisteredStandingMapSpriteStep
          jsl rlHideSprites
          jsl rlUnknown80932C
          rts

          .databank 0

        rlUnitWindowSetMainLoopUpdaterFromMap ; 80/C66F

          .al
          .autsiz
          .databank ?

          ; This sets the updater routine for when
          ; the unit window is opened on the map.

          ; Inputs:
          ; None

          ; Outputs:
          ; wMainLoopPointer: set to rsUnitWindowMainLoopUpdater
          ; aUnitWindowDeploymentSlots: filled with fielded/living player
          ;   unit deployment slots
          ; wUnknown000302: zero

          lda #Player
          sta wUnitWindowAllegiance

          stz wUnknown000302,b

          lda #WindowTypes.FromMap
          sta wUnitWindowType

          lda #<>rsUnitWindowMainLoopUpdater
          sta wMainLoopPointer

          lda wUnitWindowAllegiance
          sta wR0

          jsl rlUnitWindowGetDeploymentSlotsByAllegiance

          rtl

          .databank 0

        rlUnitWindowSetMainLoopUpdaterFromMapUnit ; 80/C690

          .al
          .autsiz
          .databank ?

          ; This sets the updater routine for
          ; when returning to the unit window after
          ; selecting a unit in the window.

          ; Inputs:
          ; None

          ; Outputs:
          ; wMainLoopPointer: set to rsUnitWindowMainLoopUpdater
          ; aUnitWindowDeploymentSlots: filled with fielded/living player
          ;   unit deployment slots
          ; wUnknown000302: zero

          lda #Player
          sta wUnitWindowAllegiance

          stz wUnknown000302,b

          lda #WindowTypes.FromUnitDuringMap
          sta wUnitWindowType

          lda #<>rsUnitWindowMainLoopUpdater
          sta wMainLoopPointer

          lda bUnitWindowActive
          bne +

            jsl rlUnitWindowGetPlayerDeploymentSlots

          +
          rtl

          .databank 0

        rlUnitWindowSetMainLoopUpdaterFromPrep ; 80/C6B1

          .al
          .autsiz
          .databank ?

          ; This sets the updater routine for when
          ; the unit window is opened on the prep screen.

          ; Inputs:
          ; None

          ; Outputs:
          ; wMainLoopPointer: set to rsUnitWindowMainLoopUpdater
          ; aUnitWindowDeploymentSlots: filled with living player
          ;   unit deployment slots
          ; wUnknown000302: zero

          lda #Player
          sta wUnitWindowAllegiance

          stz wUnknown000302,b

          lda #WindowTypes.FromPrep
          sta wUnitWindowType

          lda #<>rsUnitWindowMainLoopUpdater
          sta wMainLoopPointer

          lda bUnitWindowActive
          bne +

            jsl rlUnitWindowGetDeploymentSlotsFromPrepPool

          +

          rtl

          .databank 0

        rlUnitWindowSetMainLoopUpdaterFromPrepUnit ; 80/C6D2

          .al
          .autsiz
          .databank ?

          ; This sets the updater routine for
          ; when returning to the unit window after
          ; selecting a unit in the window (when the window
          ; was originally opened from the prep screen).

          ; Inputs:
          ; None

          ; Outputs:
          ; wMainLoopPointer: set to rsUnitWindowMainLoopUpdater
          ; aUnitWindowDeploymentSlots: filled with living player
          ;   unit deployment slots
          ; wUnknown000302: zero

          lda #Player
          sta wUnitWindowAllegiance

          stz wUnknown000302,b

          lda #WindowTypes.FromUnitDuringPrep
          sta wUnitWindowType

          lda #<>rsUnitWindowMainLoopUpdater
          sta wMainLoopPointer

          lda bUnitWindowActive
          bne +

            jsl rlUnitWindowGetDeploymentSlotsFromPrepPool

          +

          rtl

          .databank 0

      endCode
      startData

        aUnitWindowTilemapInfo .structTilemapInfo (32, 64), None, aBG3TilemapBuffer ; 80/C6F3

      endData
      startCode

        rsUnitWindowMainLoopUpdater ; 80/C6FC

          .autsiz
          .databank ?

          ; This handles what the game should do during
          ; the main loop while on the unit window. This
          ; only gets used for a single cycle before switching
          ; to something else.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php

          sep #$20

          lda #INIDISP_Setting(true)
          sta INIDISP,b
          sta bBufferINIDISP

          rep #$20

          lda #<>rsUnitWindowVBlankUpdater
          sta wVBlankPointer

          jsl rlHaltUntilVBlank
          jsl rlDisableVBlank
          jsl rlInitializeCPUWriteOnlyIORegisters
          jsl rlInitializePPUWriteOnlyIORegisters

          lda #BG1Base >> 1
          sta wR1
          lda #BG2Base >> 1
          sta wR2
          lda #BG3Base >> 1
          sta wR3
          lda #OAMBase >> 1
          sta wR5
          lda #BG1TilemapPosition >> 1
          sta wR6
          lda #BG2TilemapPosition >> 1
          sta wR7
          lda #BG3TilemapPosition >> 1
          sta wR8

          jsl rlSetLayerPositionsAndSizes

          jsl rlProcEngineReset
          jsl rlActiveSpriteEngineReset
          jsl rlHDMAEngineReset
          jsl rlIRQEngineReset

          lda wUnitWindowType
          bit #WindowTypes.FromPrep
          beq +

            ; Prep screen

            phb
            php

            sep #$20

            lda #$7E
            pha

            rep #$20

            plb

            .databank $7E

            jsl rlRegisterPrepScreenStandingMapSprites

            plp
            plb

            .databank ?

          +
          lda wUnitWindowType
          bit #WindowTypes.ReturningFromUnit
          bne +

            ; Not returning from a unit

            jsr rsUnitWindowInitializeFE4LineVariables

          +

          jsr rsUnitWindowInitializeVariables
          jsr rsUnitWindowCopyTextAndIconGraphics
          jsr rsUnitWindowSetBGSettings
          jsl rlUnitWindowCopyGraphics

          jsl rlUnitWindowRememberLastSortOrder

          sep #$20

          lda #10
          sta wJoyRepeatDelay

          lda #4
          sta wJoyRepeatInterval

          rep #$20

          lda #(`procUnitWindow)<<8
          sta lR44+size(byte)
          lda #<>procUnitWindow
          sta lR44
          jsl rlProcEngineCreateProc

          ; TODO: main loop

          lda #$0011
          sta wUnknown000302,b

          lda #$0010
          sta wUnknown000300,b

          lda #<>rsUnknown80A6BD
          sta wMainLoopPointer

          jsl rlEnableVBlank

          plp
          rts

          .databank 0

        rsUnitWindowInitializeVariables ; 80/C7BB

          .al
          .autsiz
          .databank ?

          ; This initializes a bunch of variables that are used in
          ; FE4, but are untouched in FE5 after initialization.

          ; There might be a few here that actually matter.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wUnitWindowCurrentPage
          sta wUnknown000304,b

          lda #0

          sta wUnitWindowFE4CurrentNameLine
          sta wUnitWindowUnknown7FB2AB
          sta wUnitWindowUnknown7FB2AD
          sta wUnitWindowFE4ProcessingHighlightLine
          sta wUnitWindowFE4ProcessingHighlightOffset
          sta wUnitWindowFE4CurrentLineSlotOffset
          sta wUnitWindowUnknown7FB2B5
          sta wUnitWindowUnknown7FB2B7
          sta wUnitWindowFE4CurrentItemIconSlot

          sta wUnitWindowFE4LastScrolledFlag
          sta wUnitWindowUnknown7FB11D
          sta wUnitWindowFE4ScrollingStep

          sta wUnitWindowFE4ScrollingFlag

          sta wUnitWindowFE4HightlightCounter

          sta wUnitWindowFE4PageScrollFlag
          sta wUnitWindowFE4Action
          sta wUnitWindowFE4SortTypeFlag

          sta wUnitWindowFE4UnitSwapStep
          sta wUnitWindowFE4UnitSwapStartSlot
          sta wUnitWindowFE4UnitSwapStartCursorYCoordinate

          lda #0
          tax

          -
            sta aUnitWindowFE4SpriteSlots,x

            inc a

            .rept size(aUnitWindowFE4SpriteSlots._Slots[0])
              inc x
            .endrept

            cmp #len(aUnitWindowFE4SpriteSlots._Slots) - 1
            bne -

          lda #0
          ldx #0

          -
            sta aUnitWindowCurrentSortScores,x

            .rept size(aUnitWindowCurrentSortScores._Slots[0])
              inc x
            .endrept

            cpx #size(aUnitWindowCurrentSortScores)
            bne -

          jsl rlUnitWindowUnknown90DF02
          rts

          .databank 0

        rsUnitWindowInitializeFE4LineVariables ; 80/C83B

          .al
          .autsiz
          .databank ?

          ; This initializes unit list line-related
          ; variables in FE4. These values are unused
          ; in FE5.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #0

          sta wUnitWindowUnknown7FAFCB
          sta wUnitWindowFE4CurrentHighlightLine
          sta wUnitWindowFE4ScrolledLines
          sta wUnitWindowFE4ScrollPixels
          sta wUnitWindowFE4CurrentColumn

          lda #1
          sta wUnitWindowFE4CurrentLine

          lda #58
          sta wUnitWindowFE4UnitListCursorYCoordinate

          lda #0
          sta wUnitWindowFE4HightlightStep

          lda #CGADSUB_Setting(CGADSUB_Subtract, true, false, false, false, true, false, true)
          sta aUnitWindowFE4HighlightColors._Colors[0].Control

          rts

          .databank 0

        rsUnitWindowCopyTextAndIconGraphics ; 80/C86F

          .autsiz
          .databank ?

          ; Copies necessary graphics.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          ; TODO: sizes of graphics

          jsl rlDMAByStruct

          .dstruct structDMAToVRAM, g2bppMenuTiles, $2800, VMAIN_Setting(true), MenuTextTilesPosition

          jsl rlDMAByStruct

          .dstruct structDMAToVRAM, g4bppUnitWindowSkillIcons, $0C00, VMAIN_Setting(true), SkillIconTilesPosition

          jsl rlDMAByStruct

          .dstruct structDMAToVRAM, g2bppWeaponRankIcons, $0500, VMAIN_Setting(true), WeaponRankIconTilesPosition

          rts

          .databank 0

        rlUnitWindowCopyGraphics ; 80/C897

          .autsiz
          .databank ?

          ; Handles copying the tilemaps, border graphics,
          ; system icons, and palettes.
          ; Also creates the spinning arrows for the
          ; unit list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          ; TODO: size of graphics

          jsl rlDMAByStruct

          .dstruct structDMAToVRAM, aUnitWindowUnknownUpperTilemap, $01C0, VMAIN_Setting(true), BG1TilemapPosition

          jsl rlDMAByStruct

          .dstruct structDMAToVRAM, g4bppSystemIcons, $0400, VMAIN_Setting(true), SystemIconTilesPosition

          jsl rlDMAByStruct

          .dstruct structDMAToVRAM, g4bppUnitWindowBorderTiles, $0600, VMAIN_Setting(true), BorderTilesPosition

          jsl rlDMAByStruct

          .dstruct structDMAToVRAM, g2bppUnitWindowPageLabels, $0800, VMAIN_Setting(true), SortLabelTilesPosition

          lda #(`g4bppMenuBackgroundTiles)<<8
          sta lR18+size(byte)
          lda #<>g4bppMenuBackgroundTiles
          sta lR18

          lda aOptions.wBackground
          asl a
          tax
          lda _BackgroundTileOffsets,x

          clc
          adc lR18
          sta lR18

          lda #$0800 ; TODO: size(g4bppMenuBackgroundTiles._Styles[0])
          sta wR0

          lda #MenuBackgroundTilesPosition >> 1
          sta wR1

          jsl rlDMAByPointer

          lda #(`aUnitWindowUpperTilemap)<<8
          sta lR18+size(byte)
          lda #<>aUnitWindowUpperTilemap
          sta lR18

          lda #(`aBG1TilemapBuffer)<<8
          sta lR19+size(byte)
          lda #<>aBG1TilemapBuffer
          sta lR19

          lda #$01C0 ; TODO: size(aUnitWindowUpperTilemap)
          sta lR20

          jsl rlBlockCopy

          jsl rlDMAByStruct

          .dstruct structDMAToVRAM, aBG1TilemapBuffer, $01C0, VMAIN_Setting(true), BG1TilemapPosition

          lda #(`aUnitWindowBG2Tilemap)<<8
          sta lR18+size(byte)
          lda #<>aUnitWindowBG2Tilemap
          sta lR18

          lda #(`aBG2TilemapBuffer)<<8
          sta lR19+size(byte)
          lda #<>aBG2TilemapBuffer
          sta lR19

          lda #(32 * 16 * size(word))
          sta lR20

          jsl rlBlockCopy

          _TilemapOffset = aUnitWindowBG2Tilemap + (32 * 8 * size(word))

          .for _i in range(3)

            _BufferOffset := aBG2TilemapBuffer + (32 * 16 * size(word))
            _BufferOffset += (_i * (32 * 16 * size(word)))

            lda #(`_TilemapOffset)<<8
            sta lR18+size(byte)
            lda #<>_TilemapOffset
            sta lR18

            lda #(`_BufferOffset)<<8
            sta lR19+size(byte)
            lda #<>_BufferOffset
            sta lR19

            lda #(32 * 16 * size(word))
            sta lR20

            jsl rlBlockCopy

          .endfor

          jsl rlDMAByStruct

          .dstruct structDMAToVRAM, aBG2TilemapBuffer, $1000, VMAIN_Setting(true), BG2TilemapPosition

          lda #(`aMenuBackgroundPalettes)<<8
          sta lR18+size(byte)
          lda #<>aMenuBackgroundPalettes
          sta lR18

          lda aOptions.wBackground
          asl a
          tax
          lda _BackgroundPaletteOffsets,x

          clc
          adc lR18
          sta lR18

          lda #(`aBGPaletteBuffer.aPalette4)<<8
          sta lR19+size(byte)
          lda #<>aBGPaletteBuffer.aPalette4
          sta lR19

          lda #size(Palette)
          sta lR20

          jsl rlBlockCopy

          _Palettes  := [(aUnitWindowTextPalettes, aBGPaletteBuffer.aPalette0, 2)]
          _Palettes ..= [(aUnitWindowUpperBackgroundPalettes, aBGPaletteBuffer.aPalette2, 2)]
          _Palettes ..= [(aWeaponRankIconPalette, aOAMPaletteBuffer.aPalette5, 1)]
          _Palettes ..= [(aItemIconPalette, aOAMPaletteBuffer.aPalette7, 1)]

          .for _Source, _Dest, _Count in _Palettes

            lda #(`_Source)<<8
            sta lR18+size(byte)
            lda #<>_Source
            sta lR18

            lda #(`_Dest)<<8
            sta lR19+size(byte)
            lda #<>_Dest
            sta lR19

            lda #(size(Palette) * _Count)
            sta lR20

            jsl rlBlockCopy

          .endfor

          jsl rlUnknown8591F0

          .for _Start, _Stop in [UpperZone, LowerZone]

            lda #_Start
            sta wR0

            lda #_Stop - _Start
            sta wR1

            jsl rlUnknown859233

          .endfor

          jsl rlUnknown859205

          lda #CGADSUB_Setting(CGADSUB_Subtract, false, false, true, false, false, false, false)
          sta bBufferCGADSUB

          lda #UpwardsArrow[0]
          sta wR0

          lda #UpwardsArrow[1]
          sta wR1

          jsl rlCreateUpwardsSpinningArrow

          lda #DownwardsArrow[0]
          sta wR0

          lda #DownwardsArrow[1]
          sta wR1

          jsl rlCreateDownwardsSpinningArrow

          jsl rlUnitWindowToggleScrollArrows
          rtl

          _BackgroundTileOffsets .block ; 80/CA87

            ; TODO: g4bppMenuBackgroundTiles - g4bppMenuBackgroundTiles._Styles[_i]

            .for _i in range(5)

              .word ((4 * _i) * 16) * size(Tile4bpp)

            .endfor

          .endblock

          _BackgroundPaletteOffsets .block ; 80/CA91

            ; TODO: aMenuBackgroundPalettes - aMenuBackgroundPalettes._Styles[_i]

            .for _i in range(5)

              .word (_i * size(Palette))

            .endfor

          .endblock

          .databank 0

        rlUnitWindowUnknownCopyAllEquippedWeaponIcons ; 80/CA9B

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; This would copy all units' weapon icons, if
          ; they had a weapon equipped.
          ; See rlUnitWindowCopyItemIconTiles

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          ldx #len(aUnitWindowDeploymentSlots._Slots[:-2]) * size(aUnitWindowDeploymentSlots._Slots[0])

          -
            lda aUnitWindowDeploymentSlots,x
            beq +

              jsr rsUnitWindowUnknownCopyEquippedWeaponIcon

            +

            .rept size(aUnitWindowDeploymentSlots._Slots[0])
              dec x
            .endrept

            bpl -

          rtl

          .databank 0

        rsUnitWindowUnknownCopyEquippedWeaponIcon ; 80/CAAC

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; Copies equipped weapon icons to VRAM, copies
          ; a blank icon if the unit has no weapon equipped.

          ; Inputs:
          ; A: short pointer to deployment slot

          ; Outputs:
          ; None

          phx

          sta wTemporaryDeploymentInfo,b
          jsl rlUnitWindowGetEquippedWeapon
          ora #0
          bne _EquippedWeapon

            lda #(`_g4bppcBlankIcon)<<8
            sta lR18+size(byte)
            lda #<>_g4bppcBlankIcon
            sta lR18

            bra _Continue

          _EquippedWeapon

            lda @l aItemDataBuffer.Icon
            and #$00FF
            asl a
            asl a
            asl a
            asl a
            asl a
            asl a
            asl a
            clc
            adc #<>IconSheet
            sta lR18
            sep #$20
            lda #`IconSheet
            sta lR18+size(word)
            rep #$20

          _Continue

          lda _IconSlots,x
          clc
          adc #ItemIconTilesPosition >> 1
          sta wR1

          lda #size(Tile4bpp) * 2
          sta wR0
          jsl rlDMAByPointer

          lda lR18
          clc
          adc #size(Tile4bpp) * 2
          sta lR18

          lda wR1
          clc
          adc #(16 * size(Tile4bpp)) >> 1
          sta wR1
          jsl rlDMAByPointer

          plx
          rts

          _g4bppcBlankIcon .fill (4 * size(Tile4bpp)), 0 ; 80/CB0A

          _IconSlots .block ; 80/CB8A

            .for _Row, _Column in iter.product([range(5), range(8)])

              .word ((16 * _Row) + _Column) * size(Tile4bpp)

            .endfor

          .endblock

          .databank 0

        rlUnitWindowFE4CopyAllEquippedWeaponIcons ; 80/CBDA

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; In FE4, this copies units' item icons to VRAM,
          ; but the function that would copy icons here has
          ; been gutted.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #0

          -
            sta wUnitWindowFE4CurrentItemIconSlot
            asl a
            tax

            lda aUnitWindowDeploymentSlots,x
            beq _End

              sta wTemporaryDeploymentInfo,b
              jsl rlUnitWindowGetEquippedWeapon

              pha

              lda wUnitWindowFE4CurrentItemIconSlot
              asl a
              tax
              lda aUnitWindowFE4ItemIconBases,x
              tax

              pla
              bne +

                lda #-1

              +
              jsl rlUnitWindowFE4CopyItemIcon

              lda wUnitWindowFE4CurrentItemIconSlot
              inc a
              cmp #len(aUnitWindowDeploymentSlots._Slots) - 1
              bne -

          _End
          rtl

          .databank 0

        rsUnitWindowSetBGSettings ; 80/CC11

          .autsiz
          .databank ?

          ; Sets various BG-related i/o registers.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          sep #$20

          .for _Layer in [bBufferBG1SC, bBufferBG2SC, bBufferBG3SC]

            lda _Layer
            and #~BGSC_Size
            ora #BGSC_Setting(0, BGSC_64x32)
            sta _Layer

          .endfor

          lda #T_Setting(true, true, true, false, true)
          sta bBufferTM

          lda #T_Setting(false, false, false, false, false)
          sta bBufferTS

          lda #T_Setting(false, false, false, false, false)
          sta bBufferTMW

          lda #T_Setting(false, false, false, false, false)
          sta bBufferTSW

          lda #W12SEL_Setting(false, false, false, false, false, false, false, false)
          sta bBufferW12SEL

          lda #W34SEL_Setting(false, false, false, false, false, false, false, false)
          sta bBufferW34SEL

          lda #WOBJSEL_Setting(false, false, false, false, false, false, false, false)
          sta bBufferWOBJSEL

          lda #0
          sta bBufferWH0

          lda #255
          sta bBufferWH1

          lda #0
          sta bBufferWH2
          sta bBufferWH3

          lda #WBGLOG_Setting(WLOG_ORR, WLOG_ORR, WLOG_ORR, WLOG_ORR)
          sta bBufferWBGLOG
          sta bBufferWOBJLOG

          lda #CGWSEL_Setting(false, false, CGWSEL_MathAlways, CGWSEL_BlackNever)
          sta bBufferCGWSEL

          lda #CGADSUB_Setting(CGADSUB_Subtract, false, false, true, false, false, false, false)
          sta bBufferCGADSUB

          lda #COLDATA_Setting(0, true, true, true)
          sta bBufferCOLDATA_1
          sta bBufferCOLDATA_2
          sta bBufferCOLDATA_3

          rep #$20

          stz wBufferBG1HOFS
          stz wBufferBG3HOFS
          stz wBufferBG2HOFS
          stz wBufferBG2VOFS

          lda #0
          sta wBufferBG1VOFS
          sta wBufferBG3VOFS

          rts

          .databank 0

        rlUnitWindowFE4SetHDMA ; 80/CC7D

          .al
          .autsiz
          .databank ?

          ; Unused.
          ; This would set up the HDMA that handles scrolling
          ; the BG layers.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #(`aUnitWindowBG3VOFSHDMAInfo)<<8
          sta lR44+size(byte)
          lda #<>aUnitWindowBG3VOFSHDMAInfo
          sta lR44

          lda #3
          sta wR40

          jsl rlHDMAEngineCreateEntryByIndex

          lda #(`aUnitWindowBG1VOFSHDMAInfo)<<8
          sta lR44+size(byte)
          lda #<>aUnitWindowBG1VOFSHDMAInfo
          sta lR44

          lda #4
          sta wR40

          jsl rlHDMAEngineCreateEntryByIndex

          lda #(`aUnitWindowCGADSUBHDMAInfo)<<8
          sta lR44+size(byte)
          lda #<>aUnitWindowCGADSUBHDMAInfo
          sta lR44

          lda #5
          sta wR40

          ; jsl rlHDMAEngineCreateEntryByIndex

          lda #(`aUnitWindowBG2VOFSHDMAEntry)<<8
          sta lR44+size(byte)
          lda #<>aUnitWindowBG2VOFSHDMAEntry
          sta lR44

          lda #6
          sta wR40

          jsl rlHDMAEngineCreateEntryByIndex

          rts

          .databank 0

      endCode
      startData

        aUnitWindowBG3VOFSHDMAInfo .structHDMADirectEntryInfo rlUnitWindowBG3VOFSHDMAInit, rlUnitWindowBG3VOFSHDMAOnCycle, aUnitWindowBG3VOFSHDMACode, aUnitWindowFE4BG3VOFSHDMATable, BG3VOFS, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode2) ; 80/CCC6

      endData
      startCode

        rlUnitWindowBG3VOFSHDMAInit ; 80/CCD1

          .autsiz
          .databank ?

          ; Unused.

          rtl

          .databank 0

        rlUnitWindowBG3VOFSHDMAOnCycle ; 80/CCD2

          .al
          .autsiz
          .databank ?

          ; Unused.
          ; This would copy the BG3 vertical offset
          ; for the unit window every frame.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wUnitWindowFE4PageScrollFlag
          bne _End

            sep #$20

            lda #NTRL_Setting(53)
            sta aUnitWindowFE4BG3VOFSHDMATable._Entries[0]._NTRLSetting

            rep #$20

            lda #0
            sta aUnitWindowFE4BG3VOFSHDMATable._Entries[0]._BG3VOFSSetting

            sep #$20

            lda #NTRL_Setting(1)
            sta aUnitWindowFE4BG3VOFSHDMATable._Entries[1]._NTRLSetting

            rep #$20

            lda wUnitWindowFE4ScrollPixels
            inc a
            inc a
            sta aUnitWindowFE4BG3VOFSHDMATable._Entries[1]._BG3VOFSSetting

            sep #$20

            lda #NTRL_Setting(0)
            sta aUnitWindowFE4BG3VOFSHDMATable._Entries[2]._NTRLSetting

            rep #$20

            lda #0
            sta aUnitWindowFE4BG3VOFSHDMATable._Entries[2]._BG3VOFSSetting

          _End
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowBG3VOFSHDMACode .block ; 80/CD0F

          HDMA_HALT

        .endblock

        aUnitWindowBG1VOFSHDMAInfo .structHDMADirectEntryInfo rlUnitWindowBG1VOFSHDMAInit, rlUnitWindowBG1VOFSHDMAOnCycle, aUnitWindowBG1VOFSHDMACode, aUnitWindowFE4BG1VOFSHDMATable, BG1VOFS, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode2) ; 80/CD11

      endData
      startCode

        rlUnitWindowBG1VOFSHDMAInit ; 80/CD1C

          .autsiz
          .databank ?

          ; Unused.

          rtl

          .databank 0

        rlUnitWindowBG1VOFSHDMAOnCycle ; 80/CD1D

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; This would copy the BG1 vertical offset
          ; for the unit window every frame.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wUnitWindowFE4PageScrollFlag
          bne _End

            sep #$20

            lda #NTRL_Setting(53)
            sta aUnitWindowFE4BG1VOFSHDMATable._Entries[0]._NTRLSetting

            rep #$20

            lda #-1
            sta aUnitWindowFE4BG1VOFSHDMATable._Entries[0]._BG1VOFSSetting

            sep #$20

            lda #NTRL_Setting(1)
            sta aUnitWindowFE4BG1VOFSHDMATable._Entries[1]._NTRLSetting

            rep #$20

            lda wUnitWindowFE4ScrollPixels
            dec a
            sta aUnitWindowFE4BG1VOFSHDMATable._Entries[1]._BG1VOFSSetting

            sep #$20

            lda #NTRL_Setting(0)
            sta aUnitWindowFE4BG1VOFSHDMATable._Entries[2]._NTRLSetting

            rep #$20

            lda #0
            sta aUnitWindowFE4BG1VOFSHDMATable._Entries[2]._BG1VOFSSetting

          _End
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowBG1VOFSHDMACode .block ; 80/CD59

          HDMA_HALT

        .endblock

        aUnitWindowCGADSUBHDMAInfo .structHDMADirectEntryInfo rlUnitWindowCGADSUBHDMAInit, rlUnitWindowCGADSUBHDMAOnCycle, aUnitWindowCGADSUBHDMACode, aUnitWindowFE4HighlightUnpackedColors, CGADSUB, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode3) ; 80/CD5B

      endData
      startCode

        rlUnitWindowCGADSUBHDMAInit ; 80/CD66

          .autsiz
          .databank ?

          ; Unused.

          rtl

          .databank 0

        rlUnitWindowCGADSUBHDMAOnCycle ; 80/CD67

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; This builds the HDMA table for the line highlighter.

          lda wUnitWindowFE4PageScrollFlag
          beq +

            jmp _End

          +

          ldx #0

          sep #$20

          lda #8
          sta aUnitWindowFE4HighlightUnpackedColors._Entries[0].LineCount

          rep #$20

          _Setting := CGADSUB_Setting(CGADSUB_Add, false, false, false, false, false, false, false)

          lda #pack([_Setting, _Setting])
          sta aUnitWindowFE4HighlightUnpackedColors._Entries[0].CGADSUB

          lda #pack([0, COLDATA_Setting(0, true, true, true)])
          sta aUnitWindowFE4HighlightUnpackedColors._Entries[0].COLDATA

          .rept size(structUnitWindowFE4HighlightColorUnpacked)
            inc x
          .endrept

          _Regions  := [(16, CGADSUB_Setting(CGADSUB_Subtract, false, true, false, false, false, false, false), COLDATA_Setting(0, true, true, true))]
          _Regions ..= [(10, CGADSUB_Setting(CGADSUB_Subtract, false, true, false, false, false, false, false), COLDATA_Setting(1, true, true, true))]
          _Regions ..= [(16, CGADSUB_Setting(CGADSUB_Subtract, false, true, false, false, false, false, false), COLDATA_Setting(1, true, true, true))]
          _Regions ..= [( 5, CGADSUB_Setting(CGADSUB_Subtract, false, true, false, false, false, false, false), COLDATA_Setting(2, true, true, true))]

          .for _LineCount, _CGADSUB, _COLDATA in _Regions

            sep #$20

            lda #_LineCount
            sta aUnitWindowFE4HighlightUnpackedColors._Entries[0].LineCount,x

            rep #$20

            lda #pack([_CGADSUB, _CGADSUB])
            sta aUnitWindowFE4HighlightUnpackedColors._Entries[0].CGADSUB,x

            lda #pack([0, _COLDATA])
            sta aUnitWindowFE4HighlightUnpackedColors._Entries[0].COLDATA,x

            .rept size(structUnitWindowFE4HighlightColorUnpacked)
              inc x
            .endrept

          .endfor

          lda #0
          sta wUnitWindowFE4ProcessingHighlightLine

          lda #0
          sta wUnitWindowFE4ProcessingHighlightOffset

          -
            phx

            lda wUnitWindowFE4ProcessingHighlightLine
            tax

            lda aUnitWindowFE4HighlightHeights,x
            sta wR0

            inc x
            txa
            sta wUnitWindowFE4ProcessingHighlightLine

            plx

            lda wR0
            and #$00FF
            sep #$20
            sta aUnitWindowFE4HighlightUnpackedColors._Entries[0].LineCount,x
            rep #$20

            phx

            lda wUnitWindowFE4ProcessingHighlightOffset
            tax
            tay

            lda aUnitWindowFE4HighlightPackedColors._Main._Colors[0].Control,x

            plx

            sep #$20

            sta aUnitWindowFE4HighlightUnpackedColors._Entries[0].CGADSUB,x
            sta aUnitWindowFE4HighlightUnpackedColors._Entries[0].CGADSUB+size(byte),x

            rep #$20

            phx

            tyx

            lda aUnitWindowFE4HighlightPackedColors._Main._Colors[0].ColorData0,x
            sta @l wR0

            txa
            clc
            adc #size(structUnitWindowFE4HighlightColor)
            sta wUnitWindowFE4ProcessingHighlightOffset

            plx

            lda @l wR0
            sta aUnitWindowFE4HighlightUnpackedColors._Entries[0].COLDATA,x

            .rept size(structUnitWindowFE4HighlightColorUnpacked)
              inc x
            .endrept

            cpx #size(aUnitWindowFE4HighlightUnpackedColors)
            bne -

          sep #$20

          lda #0
          sta aUnitWindowFE4HighlightUnpackedColors._Entries[0].LineCount,x

          rep #$20

          lda #0
          sta aUnitWindowFE4HighlightUnpackedColors._Entries[0].CGADSUB,x

          _End
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowCGADSUBHDMACode .block ; 80/CE82

          HDMA_HALT

        .endblock

        aUnitWindowBG2VOFSHDMAEntry .structHDMADirectEntryInfo rlUnitWindowBG2VOFSHDMAInit, rlUnitWindowBG2VOFSHDMAOnCycle, aUnitWindowBG2VOFSHDMACode, aUnitWindowFE4BG2VOFSHDMATable, BG2VOFS, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode2) ; 80/CE84

      endData
      startCode

        rlUnitWindowBG2VOFSHDMAInit ; 80/CE8F

          .autsiz
          .databank ?

          ; Unused.

          rtl

          .databank 0

        rlUnitWindowBG2VOFSHDMAOnCycle ; 80/CE90

          .al
          .autsiz
          .databank ?

          ; Unused.
          ; This would copy the BG1 vertical offset
          ; for the unit window every frame.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wUnitWindowFE4PageScrollFlag
          bne _End

            sep #$20

            lda #NTRL_Setting(53)
            sta aUnitWindowFE4BG2VOFSHDMATable._Entries[0]._NTRLSetting

            rep #$20

            lda #-1
            sta aUnitWindowFE4BG2VOFSHDMATable._Entries[0]._BG2VOFSSetting

            sep #$20

            lda #NTRL_Setting(1)
            sta aUnitWindowFE4BG2VOFSHDMATable._Entries[1]._NTRLSetting

            rep #$20

            lda wUnitWindowFE4ScrollPixels
            sta aUnitWindowFE4BG2VOFSHDMATable._Entries[1]._BG2VOFSSetting

            sep #$20

            lda #NTRL_Setting(0)
            sta aUnitWindowFE4BG2VOFSHDMATable._Entries[2]._NTRLSetting

            rep #$20

            lda #0
            sta aUnitWindowFE4BG2VOFSHDMATable._Entries[2]._BG2VOFSSetting

          _End
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowBG2VOFSHDMACode .block ; 80/CECB

          HDMA_HALT

        .endblock

      endData
      startCode

        rsUnitWindowFE4GetUnits ; 80/CECD

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; In FE4, this gets the unit count and
          ; deployment slots for the unit window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda #0
          sta wR0
          sta wR1

          lda wR0
          pha

          lda wR1
          pha

          jsl rlUnitWindowUnknownGetPlayerUnitCount
          sta wUnitWindowMaxRows

          pla
          sta wR1

          pla
          sta wR0

          lda #1
          sta wTemporaryUnitWindowCounter,b

          _Loop

            lda #0
            jsl rlUnitWindowFE4GetUnitSlot ; stub, fe4 get pointer to unit
            lda wTemporaryDeploymentInfo,b
            beq _Next

            jsl rlUnitWindowFE4GetUnitStatus ; stub returns 0, fe4 get unit type
            cmp #3
            beq _Skip

            jsl rlUnitWindowFE4GetUnitState  ; stub returns $8000, fe4 unit state
            bit #$0200
            beq _ValidUnit

            _Skip
              inc wR1
              bra _Next

            _ValidUnit
              lda wR0
              asl a
              tax
              lda wTemporaryDeploymentInfo,b
              sta aUnitWindowDeploymentSlots,x
              inc wR0

            _Next

              lda wTemporaryUnitWindowCounter,b
              inc a
              sta wTemporaryUnitWindowCounter,b
              cmp #25
              bne _Loop

          lda wR1
          sta wUnitWindowFE4SkippedUnitCount

          lda wUnitWindowMaxRows
          sec
          sbc wR1
          sta wUnitWindowMaxRows
          sec
          sbc #10
          bpl +

            lda #0

          +
          sta wUnitWindowCanScrollDownFlag

          lda wUnitWindowMaxRows
          asl a
          tax
          lda #0
          sta aUnitWindowDeploymentSlots,x

          rts

          .databank 0

        rsUnitWindowUnknown80CF55 ; 80/CF55

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; This is very similar to rlUnitWindowRememberLastSortOrder.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsl rlDMAByStruct

          .dstruct structDMAToVRAM, $9F8000, $01C0, VMAIN_Setting(true), BG1TilemapPosition

          lda bUnitWindowActive
          and #$00FF
          beq +

          lda wUnitWindowType
          bit #WindowTypes.FromUnitDuringPrep
          bne _End

          +
          jsl rlUnitWindowGetSortScores
          lda wUnitWindowSortDirection
          bne _Ascending

            jsl rlUnitWindowSetSortDescending
            bra +

          _Ascending
          jsl rlUnitWindowSetSortAscending

          +
          jsl rlUnitWindowUnknown90DF02

          _End
          rts

          .databank 0

        rlUnitWindowFE4DrawUnitNames ; 80/CF8D

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; In FE4, this draws the unit names for the unit list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          phk
          plb

          .databank `*

          lda #(`aUnitWindowTilemapInfo)<<8
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
          lda #<>aUnitWindowTilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b

          lda #0

          _Loop

            sta wUnitWindowFE4CurrentNameLine
            tax
            lda aUnitWindowDeploymentSlots,x
            beq _End

              sta wTemporaryDeploymentInfo,b
              jsl rlUnitWindowGetUnitName

              lda #TilemapEntry(0, 0, true, false, false)
              sta aCurrentTilemapInfo.wBaseTile,b

              jsl rlUnitWindowFE4GetUnitState

              lda #$8000
              bit #$4000
              bne +

                jsl rlUnitWindowFE4GetUnitStatus
                cmp #$0005
                bne ++

              +
                lda #TilemapEntry(0, 1, true, false, false)
                sta aCurrentTilemapInfo.wBaseTile,b

              +
              lda wUnitWindowFE4CurrentNameLine
              tay
              ldx _LinePositions,y

              lda lTemporaryNamePointer,b
              sta lR18
              lda lTemporaryNamePointer+size(byte),b
              sta lR18+size(byte)

              jsl rlDrawMenuText

              lda wUnitWindowFE4CurrentNameLine

              .rept size(word)
                inc a
              .endrept

              bra _Loop

          _End
          rtl

          endCode
          startData

            _LinePositions .block ; 80/CFF0

              _Helper .sfunction Y, pack([4, Y])
              .word iter.map(_Helper, range(7, 55, 2))

            .endblock

          endData
          startCode

          .databank 0

        rlUnitWindowFE4DrawUnitSkills ; 80/D020

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; In FE4, this draws units' skill icons.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          phy

          _BaseTile := VRAMToTile(BorderTilesPosition, BG1Base, size(Tile4bpp))

          lda #TilemapEntry(_BaseTile+C2I((15, 2)), 0, false, false, false)
          ldx #size(aUnitWindowFE4SkillIconTilemap)

          -
            sta aUnitWindowFE4SkillIconTilemap,x

            .rept size(word)
              dec x
            .endrept

            bne -

          lda #0

          _LoopOuter

            sta wR15
            asl a
            tax

            lda aUnitWindowDeploymentSlots,x
            bne +

              jmp _End

            +
            sta wTemporaryDeploymentInfo,b
            jsl rlUnitWindowGetUnitSkillCount

            lda wTemporaryUnitWindowSkillCounter,b
            beq _NextOuter

              asl a
              tax
              lda aUnitWindowUnknownSkillIconPositionSetPointers,x
              sta lR25

              sep #$20

              lda #`aUnitWindowUnknownSkillIconPositionSetPointers
              sta lR25+size(word)

              rep #$20

              lda #0
              sta wR12

              _LoopInner

                sta wR14

                tax
                lda aTemporaryUnitWindowSkillList,b,x
                and #$00FF
                sta wR13
                beq _NextInner

                txa
                asl a
                tax
                lda aUnitWindowSkillSortSlots,x
                beq _NextInner

                  sta wR13

                  lda wR12
                  asl a
                  tay
                  lda [lR25],y
                  sta wR0

                  lda wR15
                  asl a
                  tax
                  lda aUnitWindowUnknownSkillIconOffsets,x

                  ora wR0
                  sta wR0

                  lda wR13
                  ldx wR0
                  sta aUnitWindowFE4SkillIconTilemap+size(word),x

                  inc a
                  sta aUnitWindowFE4SkillIconTilemap+(2 * size(word)),x

                  txa
                  clc
                  adc #32 * size(word)
                  tax

                  lda wR13
                  clc
                  adc #16
                  sta aUnitWindowFE4SkillIconTilemap+size(word),x

                  inc a
                  sta aUnitWindowFE4SkillIconTilemap+(2 * size(word)),x

                  inc wR12

                _NextInner

                lda wR14
                inc a
                cmp #21
                bne _LoopInner

            _NextOuter

            lda wR15
            inc a
            cmp #UnitWindowSlotCount
            beq _End

              jmp _LoopOuter

          _End

          ply
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowUnknownSkillIconPositionSetPointers .block ; 80/D0C5
          .addr aUnitWindowUnknownSkillIconPositionsFlat
          .addr aUnitWindowUnknownSkillIconPositionsFlat
          .addr aUnitWindowUnknownSkillIconPositionsFlat
          .addr aUnitWindowUnknownSkillIconPositionsFlat
          .addr aUnitWindowUnknownSkillIconPositionsFlat
          .addr aUnitWindowUnknownSkillIconPositionsFlat
          .addr aUnitWindowUnknownSkillIconPositionsFlat
          .addr aUnitWindowUnknownSkillIconPositionsFlat
          .addr aUnitWindowUnknownSkillIconPositionsFlat
          .addr aUnitWindowUnknownSkillIconPositionsFlat
          .addr aUnitWindowUnknownSkillIconPositionsFlat
          .addr aUnitWindowUnknownSkillIconPositionsOneCompressed
          .addr aUnitWindowUnknownSkillIconPositionsTwoCompressed
          .addr aUnitWindowUnknownSkillIconPositionsThreeCompressed
          .addr aUnitWindowUnknownSkillIconPositionsFourCompressed
          .addr aUnitWindowUnknownSkillIconPositionsFiveCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSixCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSevenCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSevenCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSevenCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSevenCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSevenCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSevenCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSevenCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSevenCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSevenCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSevenCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSevenCompressed
          .addr aUnitWindowUnknownSkillIconPositionsSevenCompressed
        .endblock

        aUnitWindowUnknownSkillIconPositionsFlat .block ; 80/D0FF
          .word $0014
          .word $0018
          .word $001C
          .word $0020
          .word $0024
          .word $0028
          .word $002C
          .word $0030
          .word $0034
          .word $0038
        .endblock

        aUnitWindowUnknownSkillIconPositionsOneCompressed .block ; 80/D113
          .word $003A
          .word $0038
          .word $0014
          .word $0018
          .word $001C
          .word $0020
          .word $0024
          .word $0028
          .word $002C
          .word $0030
          .word $0034
        .endblock

        aUnitWindowUnknownSkillIconPositionsTwoCompressed .block ; 80/D129
          .word $003A
          .word $0038
          .word $0036
          .word $0034
          .word $0014
          .word $0018
          .word $001C
          .word $0020
          .word $0024
          .word $0028
          .word $002C
          .word $0030
        .endblock

        aUnitWindowUnknownSkillIconPositionsThreeCompressed .block ; 80/D141
          .word $003A
          .word $0038
          .word $0036
          .word $0034
          .word $0032
          .word $0030
          .word $0014
          .word $0018
          .word $001C
          .word $0020
          .word $0024
          .word $0028
          .word $002C
        .endblock

        aUnitWindowUnknownSkillIconPositionsFourCompressed .block ; 80/D15B
          .word $003A
          .word $0038
          .word $0036
          .word $0034
          .word $0032
          .word $0030
          .word $002E
          .word $002C
          .word $0014
          .word $0018
          .word $001C
          .word $0020
          .word $0024
          .word $0028
        .endblock

        aUnitWindowUnknownSkillIconPositionsFiveCompressed .block ; 80/D177
          .word $003A
          .word $0038
          .word $0036
          .word $0034
          .word $0032
          .word $0030
          .word $002E
          .word $002C
          .word $002A
          .word $0028
          .word $0014
          .word $0018
          .word $001C
          .word $0020
          .word $0024
        .endblock

        aUnitWindowUnknownSkillIconPositionsSixCompressed .block ; 80/D195
          .word $003A
          .word $0038
          .word $0036
          .word $0034
          .word $0032
          .word $0030
          .word $002E
          .word $002C
          .word $002A
          .word $0028
          .word $0026
          .word $0024
          .word $0014
          .word $0018
          .word $001C
          .word $0020
        .endblock

        aUnitWindowUnknownSkillIconPositionsSevenCompressed .block ; 80/D1B5
          .word $003A
          .word $0038
          .word $0036
          .word $0034
          .word $0032
          .word $0030
          .word $002E
          .word $002C
          .word $002A
          .word $0028
          .word $0026
          .word $0024
          .word $0022
          .word $0020
          .word $0014
          .word $0018
          .word $001C
        .endblock

        aUnitWindowUnknownSkillIconOffsets .block ; 80/D1D7
          .word $01C0
          .word $0240
          .word $02C0
          .word $0340
          .word $03C0
          .word $0440
          .word $04C0
          .word $0540
          .word $05C0
          .word $0640
          .word $06C0
          .word $0740
          .word $07C0
          .word $0840
          .word $08C0
          .word $0940
          .word $09C0
          .word $0A40
          .word $0AC0
          .word $0B40
          .word $0BC0
          .word $0C40
          .word $0CC0
          .word $0D40
        .endblock

      endData

      .endwith ; UnitWindowConfig

    .endsection UnitWindow80Section

    .section UnitWindowTempSection

      .with UnitWindowConfig

      startCode

        rlUnitWindowUnknown90B6F3 ; 90/B6F3

          .al
          .xl
          .autsiz
          .databank ?

          inc wUnknown000302,b

          lda #$0001
          sta wUnitWindowFE4Action

          jsr rsUnitWindowFE4CopyLineHighlightColors

          lda wUnknown000304,b
          cmp #$0004
          bne +

            jsr rsUnitWindowRenderWeaponRankIcons
            bra _Continue

          +
          cmp #$0005
          bne _Continue

          lda #T_Setting(true, true, true, false, true)
          sta bBufferTM

          _Continue
          sep #$20

          lda #INIDISP_Setting(false, 15)
          sta bBufferINIDISP

          rep #$20

          rtl

          .databank 0

        rlUnitWindowUnknown90B720 ; 90/B720

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          phk
          plb

          .databank `*

          jsl rlUnitWindowToggleScrollArrows
          lda wUnitWindowFE4Action
          bne _End

          lda wUnitWindowFE4SortTypeFlag
          ora wUnitWindowFE4UnitSwapStep
          bne _End

          ; FE4 doesn't have this proc check

          jsl rlUnitWindowCheckForUnknownProcs
          bcs _End

            ; The actual functionality of this routine has
            ; been gutted. In FE4, it's:

            ; lda wUnknown000304
            ; cmp #$0006
            ; bmi +

            ;   - bra -

            ; +

            ; asl a
            ; tax
            ; jsr (_StepPointers,x)

          _End
          plp
          plb
          rtl

          .databank 0

          endCode
          startData

          _StepPointers .block ; 90/B741

            .addr $90bb74
            .addr $90bba2
            .addr $90bbe2
            .addr $90bc25
            .addr $90bc68
            .addr $90bcb3

          .endblock

          endData
          startCode

        rlUnitWindowUnknown90B74D ; 90/B74D

          .al
          .xl
          .autsiz
          .databank ?

          rtl

          .databank 0




      endCode

      .endwith ; UnitWindowConfig

    .endsection UnitWindowTempSection

    .section UnitWindow90Section

      .with UnitWindowConfig

      startCode

        rlUnitWindowFillBG3Buffer ; 90/C34E

          .al
          .xl
          .autsiz
          .databank ?

          ; Fills the BG3 tilemap buffer with a value.

          ; Inputs:
          ; A: fill value

          ; Outputs:
          ; None

          ldx #size(aBG3TilemapBuffer)

          -
            sta aBG3TilemapBuffer - size(word),x

            .rept size(word)
              dec x
            .endrept

            bne -

          rtl

          .databank 0

        rlUnitWindowFE4RenderWeaponRankWeaponRankSortIconWrapper ; 90/C35A

          .al
          .xl
          .autsiz
          .databank ?

          ; This wrapper function is bugged, it
          ; calls a long return function with a jsr.

          jsr rlUnitWindowRenderWeaponRankWeaponRankSortIcon
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowUnknown90C35E .block ; 90/C35E

          .addr aUnitWindowUnknown90C36A
          .addr aUnitWindowUnknown90C371
          .addr aUnitWindowUnknown90C371
          .addr aUnitWindowUnknown90C371
          .addr aUnitWindowUnknown90C371
          .addr aUnitWindowUnknown90C37D

        .endblock

        aUnitWindowUnknown90C36A .structSpriteArray [[(241, 33), $21, SpriteLarge, $00A, 3, 0, true, false]] ; 90/C36A
        aUnitWindowUnknown90C371 .structSpriteArray [[(  0, 33), $21, SpriteLarge, $00A, 3, 0, false, false], [(241, 33), $21, SpriteLarge, $00A, 3, 0, true, false]] ; 90/C371
        aUnitWindowUnknown90C37D .structSpriteArray [[(  0, 33), $21, SpriteLarge, $00A, 3, 0, false, false]] ; 90/C37D

        aUnitWindowUnknown90C484 .block ; 90/C484

          .addr aUnitWindowUnknown90C38A
          .addr aUnitWindowUnknown90C391
          .addr aUnitWindowUnknown90C39D

        .endblock

        aUnitWindowUnknown90C38A .structSpriteArray [[(   1,  -81), $21, SpriteLarge, $00C, 3, 0, false, true]] ; 90/C38A
        aUnitWindowUnknown90C391 .structSpriteArray [[(   1,  -81), $21, SpriteLarge, $00C, 3, 0, false, true], [(   1,   82), $21, SpriteLarge, $00C, 3, 0, false, false]] ; 90/C391
        aUnitWindowUnknown90C39D .structSpriteArray [[(   1,   82), $21, SpriteLarge, $00C, 3, 0, false, false]] ; 90/C39D

      endData
      startCode

        rlUnitWindowRenderWeaponRankWeaponRankSortIcon ; 90/C3A4

          .al
          .xl
          .autsiz
          .databank ?

          ; This renders the selected weapon type sort icon.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wUnitWindowSortType
          sec
          sbc #UnitWindowSortTypes.SwordRank
          bmi _End

          cmp #UnitWindowSortTypes.DarkRank - UnitWindowSortTypes.SwordRank + 1
          bpl _End

            asl a
            tax
            lda aUnitWindowWeaponRankSortSpriteBases,x
            clc
            adc #OAMTileAndAttr($140, 0, 0, false, false) ; TODO: system icons
            sta wR4

            lda #WeaponRankSortIcon[0]
            sta wR0

            lda #WeaponRankSortIcon[1]
            sta wR1

            stz wR5

            phk
            plb

            .databank `*

            ldy #<>aUnitWindowWeaponRankSortSprite
            jsl rlPushToOAMBuffer

          _End
          rtl

          .databank 0

        rlUnitWindowUnknown90C3D5 ; 90/C3D5

          .al
          .xl
          .autsiz
          .databank ?

          ; Bugged, calls rlUnitWindowRenderSortDirectionArrow
          ; using a jsr

          jsr rlUnitWindowRenderSortDirectionArrow
          jsr rsUnitWindowFE4RenderSortSwitchCursor
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowWeaponRankSortSprite .block ; 90/C3DC

          _Sprites  := [[(   8,    0), $00, SpriteSmall, $003, 3, 5, false, false]]
          _Sprites ..= [[(   0,    0), $00, SpriteSmall, $002, 3, 5, false, false]]
          _Sprites ..= [[(   8,   -8), $00, SpriteSmall, $001, 3, 5, false, false]]
          _Sprites ..= [[(   0,   -8), $00, SpriteSmall, $000, 3, 5, false, false]]

          .structSpriteArray aUnitWindowWeaponRankSortSprite._Sprites

        .endblock

        aUnitWindowWeaponRankSortSpriteBases .for i in range(10) ; 90/C3F2

          .word OAMTileAndAttr(i * 4, 0, 0, false, false)

        .endfor

      endData
      startCode

        rsUnitWindowFE4RenderSortSwitchCursor ; 90/C406

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused
          ; In FE4, when selecting a sort type, the game
          ; draws a cursor next to the sort label.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wUnitWindowFE4SortTypeFlag
          beq _End

            lda #FE4SortLabelCursor[0]
            sta wR0
            lda #FE4SortLabelCursor[1]
            sta wR1
            jsl rlDrawRightFacingCursor

          _End
          rts

          .databank 0

        rlUnitWindowRenderSortDirectionArrow ; 90/C41B

          .al
          .xl
          .autsiz
          .databank ?

          ; This draws the sprite for the sort direction arrow.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wVBlankEnabledFramecount
          and #$001F
          tax
          lda aUnitWindowSortDirectionArrowFrameIndices,x
          and #$00FF
          asl a
          tax

          lda aUnitWindowSortDirectionArrowFrameYPositions,x
          sta wR1

          lda #SortDirectionArrow[0]
          sta wR0

          stz wR4
          stz wR5

          phk
          plb

          ldy #<>aUnitWindowSortDirectionArrowFrameUpSprite
          lda wUnitWindowSortDirection
          bne +

            ldy #<>aUnitWindowSortDirectionArrowFrameDownSprite

          +
          jsl rlPushToOAMBuffer
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowSortDirectionArrowFrameIndices .block ; 90/C44C
          .for _Direction in [range(0, 3, 1), range(3, 0, -1)]
            .for _i, _HoldTime in iter.enumerate([7, 5, 4])
              .byte [_Direction[_i]] x _HoldTime
            .endfor
          .endfor
        .endblock

        aUnitWindowUnknown90C46C .block ; 90/C46C
          .for _Direction in [range(0, 3, 1), range(3, 0, -1)]
            .for _i, _HoldTime in iter.enumerate([4, 2, 2])
              .byte [_Direction[_i]] x _HoldTime
            .endfor
          .endfor
        .endblock

        aUnitWindowSortDirectionArrowFrameYPositions .block ; 90/C47C
          .word range(SortDirectionArrow[1], SortDirectionArrow[1] + 4)
        .endblock

        aUnitWindowSortDirectionArrowFrameUpSprite   .structSpriteArray [[(   8,    0), $00, SpriteSmall, $11D, 3, 4, false, true]] ; 90/C484
        aUnitWindowSortDirectionArrowFrameDownSprite .structSpriteArray [[(   8,    0), $00, SpriteSmall, $11D, 3, 4, false, false]] ; 90/C48B

      endData
      startCode

        rlUnitWindowFE4RenderUnitSwapCursors ; 90/C492

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; In FE4, this is used to draw the cursors used
          ; when swapping two units' positions on the unit window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wUnitWindowFE4UnitListCursorYCoordinate
          dec a
          dec a
          dec a
          sta wR1

          lda #0
          sta wR0

          lda wUnitWindowFE4SortTypeFlag

          jsl rlDrawRightFacingCursor

          lda wUnitWindowFE4UnitSwapStep
          cmp #$0001
          bne +

            lda wVBlankEnabledFramecount
            and #$0001

            lda wUnitWindowFE4UnitSwapStartCursorYCoordinate
            dec a
            sec
            sbc wUnitWindowFE4ScrollPixels
            sta wR1

            lda #0
            sta wR0

            jsl rlUnitWindowFE4RenderFlashingUnitSwapCursor

          +
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowUnknown90C4CC .structSpriteArray [[(   0,    0), $21, SpriteLarge, $002, 2, 0, false, false]] ; 90/C4CC

      endData
      startCode

        rlUnitWindowFE4MoveToLastUnit ; 90/C4D3

          .al
          .xl
          .autsiz
          .databank ?

          ; In FE4, this changes the currently-selected line to
          ; be the last unit in the list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          phk
          plb

          .databank `*

          lda wUnitWindowFE4CurrentLine
          sta wR0

          lda wUnitWindowMaxRows
          sta wUnitWindowFE4CurrentLine

          ; If we have more than one screen of units,
          ; we need to scroll.

          cmp #10
          bpl _Scrolled

            lda #0
            sta wUnitWindowFE4ScrolledLines

            lda wUnitWindowMaxRows
            dec a
            sta wUnitWindowFE4CurrentHighlightLine

            asl a
            tax
            lda aUnitWindowFE4LineCursorYPositions,x
            sta wUnitWindowFE4UnitListCursorYCoordinate

            lda wUnitWindowFE4ScrolledLines
            asl a
            tax
            lda aUnitWindowFE4LineScrollYPositions,x
            sta wUnitWindowFE4ScrollPixels

            lda wR0
            cmp wUnitWindowMaxRows
            beq +

              lda #$0009 ; TODO: sound definitions
              jsl rlPlaySoundEffect

            +
            rts

          _Scrolled
          lda wUnitWindowMaxRows
          sec
          sbc #10
          sta wUnitWindowFE4ScrolledLines

          lda #9
          sta wUnitWindowFE4CurrentHighlightLine

          lda #202
          sta wUnitWindowFE4UnitListCursorYCoordinate

          lda wUnitWindowFE4ScrolledLines
          asl a
          tax
          lda aUnitWindowFE4LineScrollYPositions,x
          sta wUnitWindowFE4ScrollPixels

          lda wR0
          cmp wUnitWindowMaxRows
          beq +

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

          +
          rts

          .databank 0

      endCode
      startData

        aUnitWindowFE4LineScrollYPositions .block ; 90/C555

          .word range(0, 256, 16)

        .endblock

      endData
      startCode

        rsUnitWindowFE4MoveToNextPage ; 90/C575

          .al
          .xl
          .autsiz
          .databank `*

          ; In FE4, this changes the currently-selected line to
          ; be the first unit on the next page. If there's less
          ; than a full page remaining, try to fill the page
          ; with as many units as possible. If on the last
          ; page already, select the last unit.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wUnitWindowFE4CurrentLine
          sta wR0

          ; If we can display a full page, move the full 10 rows.
          ; If not, figure out how many to move down.

          lda wUnitWindowFE4ScrolledLines
          clc
          adc #10
          cmp wUnitWindowCanScrollDownFlag
          beq +
          blt +

          jmp _PartialPage

          +
          jmp _FullPage

          _PartialPage

          ; If we're already at the last page, select
          ; the last unit.

          lda wUnitWindowFE4ScrolledLines
          cmp wUnitWindowCanScrollDownFlag
          beq _LastUnit

            lda wUnitWindowCanScrollDownFlag
            sta wUnitWindowFE4ScrolledLines

            lda wUnitWindowFE4ScrolledLines
            clc
            adc wUnitWindowFE4CurrentHighlightLine
            inc a
            sta wUnitWindowFE4CurrentLine

            lda wUnitWindowFE4ScrolledLines
            asl a
            tax
            lda aUnitWindowFE4LineScrollYPositions,x
            sta wUnitWindowFE4ScrollPixels

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rts

          _LastUnit
          lda wUnitWindowMaxRows
          sta wUnitWindowFE4CurrentLine

          ; If we don't need to scroll because there's
          ; only one page, do that.

          lda wUnitWindowMaxRows
          cmp #11
          bmi _SinglePage

          lda #9
          sta wUnitWindowFE4CurrentHighlightLine

          lda #202
          sta wUnitWindowFE4UnitListCursorYCoordinate

          lda wR0
          cmp wUnitWindowMaxRows
          beq +

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

          +
          rts

          _SinglePage

          lda wUnitWindowMaxRows
          dec a
          sta wUnitWindowFE4CurrentHighlightLine

          asl a
          tax
          lda aUnitWindowFE4LineCursorYPositions,x
          sta wUnitWindowFE4UnitListCursorYCoordinate

          lda wR0
          cmp wUnitWindowMaxRows
          beq +

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

          +
          rts

          _FullPage
          lda wUnitWindowFE4CurrentLine
          clc
          adc #10
          sta wUnitWindowFE4CurrentLine

          lda wUnitWindowFE4ScrolledLines
          clc
          adc #10
          sta wUnitWindowFE4ScrolledLines

          asl a
          tax
          lda aUnitWindowFE4LineScrollYPositions,x
          sta wUnitWindowFE4ScrollPixels

          lda #$0009 ; TODO: sound definitions
          jsl rlPlaySoundEffect

          rts

          .databank 0

      endCode
      startData

        aUnitWindowFE4LineCursorYPositions .block ; 90/C640

          .word 58 + range(0, 160, 16)

        .endblock

      endData
      startCode

        rsUnitWindowFE4MoveToFirstUnit ; 90/C654

          .al
          .xl
          .autsiz
          .databank ?

          ; In FE4, this changes the currently-selected line to
          ; be the first unit in the list.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wUnitWindowFE4CurrentLine
          sta wR0

          lda #0
          sta wUnitWindowFE4ScrolledLines
          sta wUnitWindowFE4CurrentHighlightLine
          sta wUnitWindowFE4ScrollPixels

          lda #58
          sta wUnitWindowFE4UnitListCursorYCoordinate

          lda #1
          sta wUnitWindowFE4CurrentLine

          lda wR0
          cmp #1
          beq +

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

          +
          rts

          .databank 0

        rsUnitWindowFE4MoveToPreviousPage ; 90/C686

          .al
          .xl
          .autsiz
          .databank `*

          ; In FE4, this changes the currently-selected line to
          ; be the last unit on the previous page. If on the first
          ; page already, select the first unit.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          lda wUnitWindowFE4ScrolledLines
          sec
          sbc #10
          beq _FullPage
          bpl _FullPage

          lda wUnitWindowFE4ScrolledLines
          beq _FirstPage

            lda #0
            sta wUnitWindowFE4ScrolledLines
            sta wUnitWindowFE4ScrollPixels

            lda wUnitWindowFE4CurrentHighlightLine
            inc a
            sta wUnitWindowFE4CurrentLine

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rts

          _FirstPage
          lda wUnitWindowFE4CurrentLine
          sta wR0

          lda #1
          sta wUnitWindowFE4CurrentLine

          lda #0
          sta wUnitWindowFE4CurrentHighlightLine

          lda #58
          sta wUnitWindowFE4UnitListCursorYCoordinate

          lda wR0
          cmp #1
          beq +

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

          +
          rts

          _FullPage
          lda wUnitWindowFE4CurrentLine
          sec
          sbc #10
          sta wUnitWindowFE4CurrentLine

          lda wUnitWindowFE4ScrolledLines
          sec
          sbc #10
          sta wUnitWindowFE4ScrolledLines

          asl a
          tax
          lda aUnitWindowFE4LineScrollYPositions,x
          sta wUnitWindowFE4ScrollPixels

          lda #$0009 ; TODO: sound definitions
          jsl rlPlaySoundEffect

          rts

          .databank 0

        rsUnitWindowFE4RenderItemIcons ; 90/C707

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; In FE4, this renders units' equipped weapon icons.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          phk
          plb

          .databank `*

          stz wR15
          stz wR5
          stz wR0

          -
            lda wR15
            cmp wUnitWindowMaxRows
            beq _End

              lda wR15
              asl a
              tax
              lda @l aUnitWindowFE4ItemIconYCoordinates,x
              sec
              sbc wUnitWindowFE4ScrollPixels
              sta wR1

              lda aUnitWindowFE4SpriteSlots,x
              asl a
              tax
              lda @l aUnitWindowFE4ItemIconBases,x
              sta wR4

              ldy #<>_Sprite
              jsl rlPushToOAMBuffer

              inc wR15

              bra -

          _End
          rts

          .databank ?

      endCode
      startData

          _Sprite .structSpriteArray [[(  79,    0), $21, SpriteLarge, $000, 2, 7, false, false]] ; 90/C73E

        aUnitWindowUnknown90C745 .block ; 90/C745

          .word $00E0 + range(0, 16, 2)

        .endblock

        aUnitWindowUnknown90C755 .block ; 90/C755

          .for _Offset in [0, 32]

            .word $0100 + _Offset + range(0, 16, 2)

          .endfor

        .endblock

        aUnitWindowFE4ItemIconYCoordinates .block ; 90/C775

          .word 55 + range(0, 368+16, 16)

        .endblock

      endData
      startCode

        rlUnitWindowTryRenderWeaponRankIcons ; 90/C7A5

          .al
          .xl
          .autsiz
          .databank ?

          ; If on the 4th page, render the weapon type icons.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          phb
          php
          phk
          plb
          lda wUnitWindowCurrentPage
          cmp #4 ; TODO: pages?
          bne +

            jsr rsUnitWindowRenderWeaponRankIcons

          +
          plp
          plb
          rtl

          .databank 0

        rsUnitWindowRenderWeaponRankIcons ; 90/C7B8

          .al
          .xl
          .autsiz
          .databank `*

          ; Actually renders the icons, see rlUnitWindowTryRenderWeaponRankIcons

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsl rlUnitWindowCheckForUnknownProcs
          bcs +

            lda #WeaponRankIcons[0]
            sta wR0
            lda #WeaponRankIcons[1]
            sta wR1
            lda #OAMTileAndAttr($140, 0, 0, false, false)
            sta wR4
            stz wR5
            lda #<>aUnitWindowWeaponRankSprites
            tay
            jsl rlPushToOAMBuffer

          +
          rts

          .databank 0

      endCode
      startData

        aUnitWindowUnknown90C7D8 .block ; 90/C7D8

          _Sprites  := [[(  84,   33), $21, SpriteLarge, $000, 3, 5, false, false]]
          _Sprites ..= [[( 100,   33), $21, SpriteLarge, $002, 3, 5, false, false]]
          _Sprites ..= [[( 116,   33), $21, SpriteLarge, $004, 3, 5, false, false]]
          _Sprites ..= [[( 132,   33), $21, SpriteLarge, $006, 3, 5, false, false]]
          _Sprites ..= [[( 148,   33), $21, SpriteLarge, $008, 3, 5, false, false]]
          _Sprites ..= [[( 164,   33), $21, SpriteLarge, $00A, 3, 5, false, false]]
          _Sprites ..= [[( 180,   33), $21, SpriteLarge, $00C, 3, 5, false, false]]
          _Sprites ..= [[( 196,   33), $21, SpriteLarge, $00E, 3, 5, false, false]]
          _Sprites ..= [[( 212,   33), $21, SpriteLarge, $020, 3, 5, false, false]]
          _Sprites ..= [[( 228,   33), $21, SpriteLarge, $022, 3, 5, false, false]]

          .structSpriteArray aUnitWindowUnknown90C7D8._Sprites

        .endblock

        aUnitWindowWeaponRankSprites .block ; 90/C80C

          _Sprites  := [[(  72,    0), $00, SpriteSmall, $027, 3, 5, false, false]]
          _Sprites ..= [[(  72,   -8), $00, SpriteSmall, $025, 3, 5, false, false]]
          _Sprites ..= [[(  64,    0), $00, SpriteSmall, $026, 3, 5, false, false]]
          _Sprites ..= [[(  64,   -8), $00, SpriteSmall, $024, 3, 5, false, false]]
          _Sprites ..= [[(  56,    0), $00, SpriteSmall, $023, 3, 5, false, false]]
          _Sprites ..= [[(  56,   -8), $00, SpriteSmall, $021, 3, 5, false, false]]
          _Sprites ..= [[(  48,    0), $00, SpriteSmall, $022, 3, 5, false, false]]
          _Sprites ..= [[(  48,   -8), $00, SpriteSmall, $020, 3, 5, false, false]]
          _Sprites ..= [[(  40,    0), $00, SpriteSmall, $01F, 3, 5, false, false]]
          _Sprites ..= [[(  32,    0), $00, SpriteSmall, $01E, 3, 5, false, false]]
          _Sprites ..= [[(  40,   -8), $00, SpriteSmall, $01D, 3, 5, false, false]]
          _Sprites ..= [[(  32,   -8), $00, SpriteSmall, $01C, 3, 5, false, false]]
          _Sprites ..= [[(  24,    0), $00, SpriteSmall, $01B, 3, 5, false, false]]
          _Sprites ..= [[(  16,    0), $00, SpriteSmall, $01A, 3, 5, false, false]]
          _Sprites ..= [[(  24,   -8), $00, SpriteSmall, $019, 3, 5, false, false]]
          _Sprites ..= [[(  16,   -8), $00, SpriteSmall, $018, 3, 5, false, false]]
          _Sprites ..= [[(   8,    0), $00, SpriteSmall, $017, 3, 5, false, false]]
          _Sprites ..= [[(   0,    0), $00, SpriteSmall, $016, 3, 5, false, false]]
          _Sprites ..= [[(   8,   -8), $00, SpriteSmall, $015, 3, 5, false, false]]
          _Sprites ..= [[(   0,   -8), $00, SpriteSmall, $014, 3, 5, false, false]]
          _Sprites ..= [[(  -8,    0), $00, SpriteSmall, $013, 3, 5, false, false]]
          _Sprites ..= [[( -16,    0), $00, SpriteSmall, $012, 3, 5, false, false]]
          _Sprites ..= [[(  -8,   -8), $00, SpriteSmall, $011, 3, 5, false, false]]
          _Sprites ..= [[( -16,   -8), $00, SpriteSmall, $010, 3, 5, false, false]]
          _Sprites ..= [[( -24,    0), $00, SpriteSmall, $00F, 3, 5, false, false]]
          _Sprites ..= [[( -32,    0), $00, SpriteSmall, $00E, 3, 5, false, false]]
          _Sprites ..= [[( -24,   -8), $00, SpriteSmall, $00D, 3, 5, false, false]]
          _Sprites ..= [[( -32,   -8), $00, SpriteSmall, $00C, 3, 5, false, false]]
          _Sprites ..= [[( -40,    0), $00, SpriteSmall, $00B, 3, 5, false, false]]
          _Sprites ..= [[( -48,    0), $00, SpriteSmall, $00A, 3, 5, false, false]]
          _Sprites ..= [[( -40,   -8), $00, SpriteSmall, $009, 3, 5, false, false]]
          _Sprites ..= [[( -48,   -8), $00, SpriteSmall, $008, 3, 5, false, false]]
          _Sprites ..= [[( -56,    0), $00, SpriteSmall, $007, 3, 5, false, false]]
          _Sprites ..= [[( -64,    0), $00, SpriteSmall, $006, 3, 5, false, false]]
          _Sprites ..= [[( -56,   -8), $00, SpriteSmall, $005, 3, 5, false, false]]
          _Sprites ..= [[( -64,   -8), $00, SpriteSmall, $004, 3, 5, false, false]]
          _Sprites ..= [[( -72,    0), $00, SpriteSmall, $003, 3, 5, false, false]]
          _Sprites ..= [[( -80,    0), $00, SpriteSmall, $002, 3, 5, false, false]]
          _Sprites ..= [[( -72,   -8), $00, SpriteSmall, $001, 3, 5, false, false]]
          _Sprites ..= [[( -80,   -8), $00, SpriteSmall, $000, 3, 5, false, false]]

          .structSpriteArray aUnitWindowWeaponRankSprites._Sprites

        .endblock

      endData
      startCode

        rsUnitWindowFE4CopyLineHighlightColors ; 90/C8D6

          .al
          .xl
          .autsiz
          .databank ?

          ; In FE5, this is called once.
          ; In FE4, it is called every frame.

          ; This copies color data for the currently-selected
          ; line highlighter.

          ; Inputs:
          ; None

          ; Outputs:
          ; aUnitWindowFE4HighlightHeights: filled with heights
          ; aUnitWindowFE4HighlightPackedColors: filled with colors

          ; Temporary variables

            _CurrentLine   := wR3
            _CurrentOffset := wR4

          ; If we're selecting a sort type or swapping units, don't
          ; draw the normal line highlight.

          lda wUnitWindowFE4SortTypeFlag
          ora wUnitWindowFE4UnitSwapStep
          beq +

            jmp _NoHighlight

          +
          phk
          plb

          .databank `*

          sep #$20

          ; Reset all of the row heights to a full line.

          ldx #len(aUnitWindowFE4HighlightHeights._Rows[:-1]) * size(aUnitWindowFE4HighlightHeights._Rows[0])
          lda #16

          -
            sta aUnitWindowFE4HighlightHeights,x

            dec x

            bpl -

          rep #$20

          lda wUnitWindowFE4CurrentHighlightLine
          and #$00FF
          tax

          sep #$20

          ; Shrink all of the lines leading up to the highlighted one.

          ldy #16
          lda #1

          -
            sta aUnitWindowFE4HighlightHeights,x
            inc x
            dec y
            bne -

          rep #$20

          ; Until we get to the highlighted line, replace the disabled lines' colors.

          stz _CurrentLine
          stz _CurrentOffset

          _Loop
            lda wUnitWindowFE4CurrentHighlightLine
            cmp _CurrentLine
            beq _HighlightedLine

            lda _CurrentLine
            sta wR0

            asl a
            clc
            adc wR0
            tax

            lda aUnitWindowFE4HighlightDisabledColors._Colors[0].ColorData0,x

            phx
            pha

            lda _CurrentOffset
            tax

            pla
            sta aUnitWindowFE4HighlightPackedColors._Main._Colors[0].ColorData0,x

            txy

            plx
            lda aUnitWindowFE4HighlightDisabledColors._Colors[0].Control,x
            tyx
            sta aUnitWindowFE4HighlightPackedColors._Main._Colors[0].Control,x

            lda _CurrentOffset
            clc
            adc #size(structUnitWindowFE4HighlightColor)
            sta _CurrentOffset

            bra _Next

          ; Fill the highlighted line's colors.

          _HighlightedLine
            ldx #0

            -
              lda aUnitWindowFE4HighlightColors._Colors[0].ColorData0,x
              phx
              pha
              lda _CurrentOffset
              tax
              pla
              sta aUnitWindowFE4HighlightPackedColors._Main._Colors[0].ColorData0,x

              plx

              lda aUnitWindowFE4HighlightColors._Colors[0].Control,x

              phx
              pha

              lda _CurrentOffset
              tax

              pla
              sta aUnitWindowFE4HighlightPackedColors._Main._Colors[0].Control,x

              txa
              clc
              adc #size(structUnitWindowFE4HighlightColor)
              sta _CurrentOffset

              plx

              .rept size(structUnitWindowFE4HighlightColor)
                inc x
              .endrept

              cpx #size(aUnitWindowFE4HighlightPackedColors._Main)
              beq _Next

              jmp -

          _Next
            lda _CurrentLine
            inc a
            sta _CurrentLine
            cmp #11
            beq +

              jmp _Loop

            +

            ; After drawing the disabled lines and the highlight, get
            ; the next step and fetch its colors for next time.

            lda wUnitWindowFE4HightlightCounter
            bne _End

              lda wUnitWindowFE4HightlightStep
              sta wR0

              asl a
              clc
              adc wR0
              tax

              lda #0
              sta wR0

              ldy #16

          _GetNextHighlightColors
            phx

            lda aUnitWindowFE4HighlightEnabledColors+structUnitWindowFE4HighlightColor.ColorData0,x
            ldx wR0
            sta aUnitWindowFE4HighlightColors._Colors[0].ColorData0,x

            plx

            lda aUnitWindowFE4HighlightEnabledColors+structUnitWindowFE4HighlightColor.Control,x

            phx

            ldx wR0
            sta aUnitWindowFE4HighlightColors._Colors[0].Control,x

            .rept size(structUnitWindowFE4HighlightColor)
              inc x
            .endrept

            stx wR0

            plx

            .rept size(structUnitWindowFE4HighlightColor)
              inc x
            .endrept

            dec y
            bne _GetNextHighlightColors

              lda wUnitWindowFE4HightlightStep
              inc a
              cmp #22
              bne +

                lda #0

              +
              sta wUnitWindowFE4HightlightStep

          _End
            lda wUnitWindowFE4HightlightCounter
            inc a
            cmp #6
            bne +

              lda #0

            +
            sta wUnitWindowFE4HightlightCounter
            rts

          _NoHighlight
            sep #$20

            ldx #size(aUnitWindowFE4HighlightHeights) - size(byte)
            lda #16

            -
            sta aUnitWindowFE4HighlightHeights,x
            dec x
            bpl -

            rep #$20

            ldx #0

            -
              lda aUnitWindowFE4HighlightDisabledColors._Colors[0].ColorData0,x
              sta aUnitWindowFE4HighlightPackedColors._Main._Colors[0].ColorData0,x

              lda aUnitWindowFE4HighlightDisabledColors._Colors[0].Control,x
              sta aUnitWindowFE4HighlightPackedColors._Main._Colors[0].Control,x

              .rept size(structUnitWindowFE4HighlightColor)
                inc x
              .endrept

              cpx #size(aUnitWindowFE4HighlightDisabledColors)
              bne -

            lda #0
            sta aUnitWindowFE4HighlightPackedColors._Main._Colors[0].ColorData0,x
            sta aUnitWindowFE4HighlightPackedColors._Main._Colors[0].Control,x

            rts

          .databank 0

      endCode
      startData

        aUnitWindowFE4HighlightEnabledColors .block ; 90/CA16

          BlueIntensities     = [0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 3, 4, 4, 3, 3, 2, 1, 0, 0, 0, 0, 0]
          RedGreenIntensities = [3, 2, 2, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2]
          Operations = [CGADSUB_Add, CGADSUB_Add, CGADSUB_Add, CGADSUB_Add, CGADSUB_Add, CGADSUB_Add, CGADSUB_Add, CGADSUB_Subtract, CGADSUB_Subtract, CGADSUB_Subtract, CGADSUB_Subtract, CGADSUB_Subtract, CGADSUB_Subtract, CGADSUB_Subtract, CGADSUB_Subtract, CGADSUB_Subtract, CGADSUB_Subtract, CGADSUB_Add, CGADSUB_Add, CGADSUB_Add, CGADSUB_Add, CGADSUB_Add]

          BluePartial .sfunction Intensity, COLDATA_Setting(Intensity, false, false, true)
          RedGreenPartial .sfunction Intensity, COLDATA_Setting(Intensity, true, true, false)
          SettingPartial .sfunction Operation, CGADSUB_Setting(Operation, false, true, false, false, false, false, false)

          BlueColors     = iter.map(BluePartial, BlueIntensities)
          RedGreenColors = iter.map(RedGreenPartial, RedGreenIntensities)

          Settings = iter.map(SettingPartial, Operations)

          .for i in range(2)

            .for BlueColor, RedGreenColor, Setting in iter.zip(BlueColors, RedGreenColors, Settings)

              .structUnitWindowFE4HighlightColor BlueColor, RedGreenColor, Setting

            .endfor

          .endfor

        .endblock

        aUnitWindowFE4HighlightDisabledColors .block ; 90/CA9A

          ; 64tass doesn't seem to get the struct fields right
          ; when trying this with a .bfor, so:

          Intensity := 1

          _Colors .brept 11

            .dstruct structUnitWindowFE4HighlightColor, None, COLDATA_Setting(Intensity, true, true, true), CGADSUB_Setting(CGADSUB_Subtract, false, true, false, false, false, false, false)

            Intensity += 1

          .endrept

          .structUnitWindowFE4HighlightColor None, COLDATA_Setting(15, true, true, true), CGADSUB_Setting(CGADSUB_Add, false, true, false, false, false, false, false)

        .endblock

      endData
      startCode

        rlUnitWindowFE4GetUnitSpriteInfos ; 90/CABE

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; In FE4, this gets all units' map sprite info.

          ; Inputs:
          ; aUnitWindowDeploymentSlots: filled with deployment slots

          ; Outputs:
          ; aUnitWindowFE4MapSpriteSlots: filled with sprite info

          ldx #size(aUnitWindowFE4MapSpriteSlots) - size(sint)

          -
            lda #-1
            sta aUnitWindowFE4MapSpriteSlots,x

            .rept size(sint)
              dec x
            .endrept

            bpl -

          lda #23
          sta wTemporaryUnitWindowCounter,b

          ldx #size(aUnitWindowFE4MapSpriteSlots.aTallMapSpriteSlots) - size(sint)

          -
            phx

            lda wTemporaryUnitWindowCounter,b
            asl a
            tax
            lda aUnitWindowDeploymentSlots,x
            sta wTemporaryDeploymentInfo,b

            plx

            lda wTemporaryDeploymentInfo,b
            beq +

            jsl rlUnitWindowFE4GetUnitSpriteInfo
            bit #$8000
            bne _Tall

              sta aUnitWindowFE4MapSpriteSlots.aNormalMapSpriteSlots,x
              bra +

            _Tall
              sta aUnitWindowFE4MapSpriteSlots.aTallMapSpriteSlots,x

            +
              dec wTemporaryUnitWindowCounter,b

              .rept size(sint)
                dec x
              .endrept

              bpl -

          rtl

          .databank 0

        rsUnitWindowFE4UnknownMapSpriteRenderer ; 90/CB03

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; This is a short return wrapper for
          ; rlUnitWindowFE4RenderAllMapSprites

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          jsl rlUnitWindowFE4RenderAllMapSprites
          rts

          .databank 0

        rsUnitWindowFE4RenderSprites ; 90/CB08

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; In FE4, this renders the sort direction
          ; cursor, `ready to promote` sprites, and
          ; map sprites.

          ; Inputs:
          ; None

          ; Outputs:
          ; wTemporaryDeploymentInfo: selected line unit's
          ;   deployment slot

          ; Temporary variables

            _XBase         := wR0
            _YBase         := wR1
            _SpriteBase    := wR4
            _AttributeBase := wR5

          stz _XBase
          stz _YBase
          stz _SpriteBase
          stz _AttributeBase

          ; Start by rendering the sort order sprite.

            lda wUnitWindowSortDirection
            bne _Up

              ldy #<>_SortArrowDown
              bra +

            _Up
              ldy #<>_SortArrowUp

            +
            jsl rlPushToOAMBuffer

          ; Try to render units' `ready to promote` sprites.

            lda wVBlankEnabledFramecount
            and #$0018
            beq _PostPromoteFlag

            lda #0

            -
              sta wR15
              asl a
              tax
              lda aUnitWindowFE4ReadyToPromoteFlags,x
              beq +

                lda @l _RowYBases,x
                sec
                sbc wUnitWindowFE4ScrollPixels
                sta _YBase

                stz _XBase
                stz _SpriteBase
                stz _AttributeBase

                ldy #<>_PromoteSprite
                jsl rlPushToOAMBuffer

              +
                lda wR15
                inc a
                cmp wUnitWindowMaxRows
                bne -

          _PostPromoteFlag

          ; Next, render the selected unit's map sprite.

            jsr rsUnitWindowFE4GetCurrentLineUnit

            phk
            plb

            .databank `*

            ldx #size(aUnitWindowFE4MapSpriteSlots.aTallMapSpriteSlots) - size(sint)
            lda wUnitWindowFE4CurrentLine
            dec a
            asl a
            sta wR0

            -
              cpx wR0
              beq +

                .rept size(word)
                  dec x
                .endrept

                bra -

            +
            lda wUnitWindowFE4UnitSwapStartSlot
            dec a
            asl a
            sta wR0

            ; If over the first unit when swapping units,
            ; don't render the map sprite every other frame.

            cpx wR0
            bne +

            lda wVBlankEnabledFramecount
            and #$0001
            beq +

              jmp _PostSelectedLineMapSprite

            +
            phx
            lda aUnitWindowFE4SpriteSlots,x
            asl a
            tax
            lda aUnitWindowFE4MapSpriteSlots.aTallMapSpriteSlots,x
            cmp #-1
            beq _Normal

              lda @l aUnitWindowFE4TallMapSpriteTileIndices,x
              sta _SpriteBase
              lda #<>_TallMapSprite
              tay
              bra +

            _Normal
              lda @l aUnitWindowFE4NormalMapSpriteTileIndices,x
              sta _SpriteBase
              lda #<>_NormalMapSprite
              tay

            +

            plx
            phx
            phy

            ; The topmost mapsprite is rendered with a
            ; higher priority to avoid being cut off by the
            ; sort headers.

            ldy #OAMTileAndAttr(0, 6, 2, false, false)
            cpx #$0000 ; line offset
            bne +

              lda wUnitWindowFE4ScrollPixels
              bne +

                ldy #OAMTileAndAttr(0, 6, 3, false, false)

            +
            tya
            sta _AttributeBase

            lda wUnitWindowFE4CurrentLine
            dec a
            asl a
            tax
            lda aUnitWindowDeploymentSlots,x
            sta wTemporaryDeploymentInfo,b

            ; Gray palette

            jsl rlUnitWindowFE4GetUnitState
            bit #$4000
            bne _SelectedGray

            jsl rlUnitWindowFE4GetUnitStatus
            cmp #$0005 ; FE4 Sleep
            bne +

            _SelectedGray
              lda _AttributeBase
              and #+~OAMTileAndAttr(0, 7, 0, false, false)
              ora #OAMTileAndAttr(0, 7, 0, false, false)
              sta _AttributeBase

            +

            ply
            plx

            stz _XBase
            lda @l _RowYBases,x
            sec
            sbc wUnitWindowFE4ScrollPixels
            sta _YBase
            jsl rlPushToOAMBuffer

          _PostSelectedLineMapSprite

          ; Render tall map sprites

            lda wUnitWindowMaxRows
            dec a
            asl a
            tax

            _TallMapSpriteLoop

              phx

              ; Don't render the selected line's map sprite

              lda wUnitWindowFE4CurrentLine
              dec a
              asl a
              sta wR0

              cpx wR0
              bne +

                jmp _TallMapSpriteNext

              +

              ; Don't render the first selected unit
              ; when swapping units ever other frame.

              lda wUnitWindowFE4UnitSwapStartSlot
              dec a
              asl a
              sta wR0

              cpx wR0
              bne +

              lda wVBlankEnabledFramecount
              and #$0001
              beq +

                jmp _TallMapSpriteNext

              +

              phx

              lda aUnitWindowFE4SpriteSlots,x
              asl a
              tax
              lda aUnitWindowFE4MapSpriteSlots.aTallMapSpriteSlots,x

              plx
              cmp #-1
              beq _TallMapSpriteNext

              ; The topmost mapsprite is rendered with a
              ; higher priority to avoid being cut off by the
              ; sort headers.

              ldy #OAMTileAndAttr(0, 6, 2, false, false)
              cpx #0 ; line offset
              bne +

              lda wUnitWindowFE4ScrollPixels
              bne +

              ldy #OAMTileAndAttr(0, 6, 3, false, false)

              +
              tya
              sta _AttributeBase

              lda aUnitWindowDeploymentSlots,x
              sta wTemporaryDeploymentInfo,b

              jsl rlUnitWindowFE4GetUnitState
              bit #$4000
              bne _TallGrayed

              jsl rlUnitWindowFE4GetUnitStatus
              cmp #$0005
              bne +

              _TallGrayed
                lda _AttributeBase
                and #+~OAMTileAndAttr(0, 7, 0, false, false)
                ora #OAMTileAndAttr(0, 7, 0, false, false)
                sta _AttributeBase

              +

              plx
              phx

              lda aUnitWindowFE4SpriteSlots,x
              asl a
              tax
              lda @l aUnitWindowFE4TallMapSpriteTileIndices,x
              plx

              sta _SpriteBase
              lda #<>_TallMapSprite
              tay

              stz _XBase
              lda @l _RowYBases,x
              sec
              sbc wUnitWindowFE4ScrollPixels
              sta _YBase
              phx
              jsl rlPushToOAMBuffer

            _TallMapSpriteNext
              plx

              .rept size(word)
                dec x
              .endrept

              bmi +

                jmp _TallMapSpriteLoop

              +
              lda wUnitWindowMaxRows
              dec a
              asl a
              tax

          ; Next, render normal map sprites

            _NormalMapSpriteLoop

              ; Don't render the selected line's map sprite

              lda wUnitWindowFE4CurrentLine
              dec a
              asl a
              sta wR0
              cpx wR0
              bne +

                jmp _NormalMapSpriteNext

              +

              ; Don't render the first selected unit
              ; when swapping units ever other frame.

              lda wUnitWindowFE4UnitSwapStartSlot
              dec a
              asl a
              sta wR0
              cpx wR0
              bne +

              lda wVBlankEnabledFramecount
              and #$0001
              beq +

                jmp _NormalMapSpriteNext

              +

              phx

              lda aUnitWindowFE4SpriteSlots,x
              asl a
              tax
              lda aUnitWindowFE4MapSpriteSlots.aNormalMapSpriteSlots,x

              plx
              cmp #-1
              beq _NormalMapSpriteNext

              phy
              phx

              ; The topmost mapsprite is rendered with a
              ; higher priority to avoid being cut off by the
              ; sort headers.

              ldy #OAMTileAndAttr(0, 6, 2, false, false)
              cpx #$0000
              bne +

              lda wUnitWindowFE4ScrollPixels
              bne +

                ldy #OAMTileAndAttr(0, 6, 3, false, false)

              +
              tya
              sta _AttributeBase
              plx
              lda aUnitWindowDeploymentSlots,x
              sta wTemporaryDeploymentInfo,b
              phx
              jsl rlUnitWindowFE4GetUnitState

              bit #$4000
              bne +

              jsl rlUnitWindowFE4GetUnitStatus
              cmp #$0005
              bne ++

              +
              lda _AttributeBase
              and #+~OAMTileAndAttr(0, 7, 0, false, false)
              ora #OAMTileAndAttr(0, 7, 0, false, false)
              sta _AttributeBase

              +

              plx
              ply

              phx

              lda aUnitWindowFE4SpriteSlots,x
              asl a
              tax
              lda @l aUnitWindowFE4NormalMapSpriteTileIndices,x

              plx

              sta _SpriteBase
              lda #<>_NormalMapSprite
              tay
              stz _XBase
              lda @l _RowYBases,x
              sec
              sbc wUnitWindowFE4ScrollPixels
              sta _YBase

              phy
              phx
              jsl rlPushToOAMBuffer
              plx
              ply

            _NormalMapSpriteNext

              .rept size(word)
                dec x
              .endrept

              bmi +

              jmp _NormalMapSpriteLoop

              +

          ; Fetch the currently-selected line's
          ; unit' deployment info?

          lda wUnitWindowFE4CurrentLine
          dec a
          asl a
          tax
          lda aUnitWindowDeploymentSlots,x
          sta wTemporaryDeploymentInfo,b
          rts

          .databank 0

          endCode
          startData

            _RowYBases .word range(56, 440, 16)

            _NormalMapSprite .structSpriteArray [[(  16,    0), $21, SpriteLarge, $080, 0, 0, false, false]]
            _TallMapSprite   .structSpriteArray [[(  16,    0), $21, SpriteLarge, $140, 0, 0, false, false], [(  16,  -16), $21, SpriteLarge, $142, 0, 0, false, false]]
            _PromoteSprite   .structSpriteArray [[(  12,    6), $21, SpriteLarge, $004, 2, 4, false, false], [(  28,    6), $00, SpriteSmall, $006, 2, 4, false, false]]
            _SortArrowUp     .structSpriteArray [[(  58,    9), $00, SpriteSmall, $009, 3, 4, false, false], [(  58,   17), $00, SpriteSmall, $019, 3, 4, false, false]]
            _SortArrowDown   .structSpriteArray [[(  58,   17), $00, SpriteSmall, $009, 3, 4, false, true],  [(  58,    9), $00, SpriteSmall, $019, 3, 4, false, true]]

          endData
          startCode

        rsUnitWindowFE4GetCurrentLineUnit ; 90/CDBF

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; In FE4, this gets the selected line's unit's
          ; slot?

          ; Inputs:
          ; wUnitWindowFE4CurrentLine: current line

          ; Outputs:
          ; This is supposed to be the unit slot

          lda wUnitWindowFE4PageScrollFlag
          bne _End

          lda wUnitWindowFE4SortTypeFlag
          bne _End

          ora wUnitWindowFE4UnitSwapStep
          bne _End

            lda wUnitWindowFE4CurrentLine
            dec a
            asl a
            sta wUnitWindowFE4CurrentLineSlotOffset
            tax
            lda aUnitWindowDeploymentSlots,x
            sta wTemporaryDeploymentInfo,b

            jsl rlUnitWindowFE4GetUnitState
            bit #$4000
            bne _End

            jsl rlUnitWindowFE4GetUnitStatus
            cmp #$0005
            beq _End

              lda wUnitWindowFE4CurrentLineSlotOffset
              lda aUnitWindowFE4SpriteSlots,x
              asl a
              sta wUnitWindowFE4CurrentLineSlotOffset
              tax
              jsl rlUnitWindowFE4GetUnitSlot

          _End
          rts

          .databank 0

        rsUnitWindowUnknownDrawRankString ; 90/CE08

          .al
          .xl
          .autsiz
          .databank ?

          ; Unused.
          ; Draws a weapon rank string.

          ; Inputs:
          ; A: rank
          ; X: packed coordinates

          ; Outputs:
          ; None

          _PushedRegisters = [wR14, wR13]

          sta wR17

          phx
          phy

          .for _Register in _PushedRegisters

            lda _Register
            pha

          .endfor

          lda #TilemapEntry(0, 5, true, false, false)
          bcs +

            lda #TilemapEntry(0, 6, true, false, false)

          +
          sta aCurrentTilemapInfo.wBaseTile,b

          lda wR17

          phx
          phy
          jsl rlGetRankString
          ply
          plx

          stx wR17

          tya
          xba
          ora wR17
          tax
          jsl rlDrawMenuText

          .for _Register in iter.reversed(_PushedRegisters)

            pla
            sta _Register

          .endfor

          ply
          plx
          rts

          .databank 0

      endCode
      startData

        aUnitWindowUnknown90CE3B .block ; 90/CE3B

          ; Unused

          DashTiles = [((15,  5), (14, 13))]
          ETiles    = [(( 4, 20), ( 4, 21))]
          DTiles    = [(( 3, 20), ( 3, 21))] ; This is wrong
          CTiles    = [(( 2, 20), ( 2, 21))]
          BTiles    = [(( 1, 20), ( 1, 21))]
          ATiles    = [(( 0, 20), ( 0, 21))]

          AllTiles = DashTiles .. ETiles .. DTiles .. CTiles .. BTiles .. ATiles

          ; In FE4, these two sets are for the blue and
          ; green palettes. FE5 just has them both as
          ; the same color.

          _Green .for _Upper, _Lower in AllTiles

            .word TilemapEntry(MenuTilesBaseTile+C2I(_Upper), 6, true, false, false)
            .word TilemapEntry(MenuTilesBaseTile+C2I(_Lower), 6, true, false, false)

          .endfor

          _Blue .for _Upper, _Lower in AllTiles

            .word TilemapEntry(MenuTilesBaseTile+C2I(_Upper), 6, true, false, false)
            .word TilemapEntry(MenuTilesBaseTile+C2I(_Lower), 6, true, false, false)

          .endfor

        .endblock

      endData
      startCode

        rlUnitWindowFE4CopyItemIcon ; 90/CE6B

          .autsiz
          .databank ?

          ; Unused.
          ; In FE4, this copies an item icon into VRAM.

          ; Inputs:
          ; A: item icon

          ; Outputs:
          ; None

          rtl

          .databank 0

      endCode
      startData

        aUnitWindowFE4ItemIconSheetOffsets .block ; 90/CE6B

          ; Unused.
          ; In FE4, this is a table, indexed by
          ; item ID, for the item's offset into
          ; the item icon sheet.

          .word $0000
          .word $0040
          .word $0080
          .word $00c0
          .word $0100
          .word $0140
          .word $0180
          .word $01c0
          .word $0400
          .word $0440
          .word $0480
          .word $04c0
          .word $0500
          .word $0540
          .word $0580
          .word $05c0
          .word $0800
          .word $0840
          .word $0880
          .word $08c0
          .word $0900
          .word $0940
          .word $0980
          .word $09c0
          .word $0c00
          .word $0c40
          .word $0c40
          .word $0c40
          .word $0c80
          .word $0cc0
          .word $0d00
          .word $0d40
          .word $0d80
          .word $0dc0
          .word $1000
          .word $1040
          .word $1080
          .word $10c0
          .word $10c0
          .word $10c0
          .word $1100
          .word $1140
          .word $1180
          .word $11c0
          .word $1400
          .word $1440
          .word $1480
          .word $1480
          .word $1480
          .word $14c0
          .word $1500
          .word $1540
          .word $1580
          .word $15c0
          .word $1800
          .word $1840
          .word $1840
          .word $1840
          .word $3440
          .word $3480
          .word $34c0
          .word $3500
          .word $1880
          .word $18c0
          .word $1900
          .word $1940
          .word $1980
          .word $19c0
          .word $1c00
          .word $1c40
          .word $1c80
          .word $1cc0
          .word $1d00
          .word $1d40
          .word $1d80
          .word $1dc0
          .word $2000
          .word $2040
          .word $2080
          .word $20c0
          .word $2100
          .word $2140
          .word $2180
          .word $21c0
          .word $2400
          .word $2440
          .word $2440
          .word $2440
          .word $2480
          .word $24c0
          .word $2500
          .word $2540
          .word $2580
          .word $25c0
          .word $2800
          .word $2840
          .word $2880
          .word $28c0
          .word $3540
          .word $2900
          .word $2940
          .word $2980
          .word $29c0
          .word $2c00
          .word $2c00
          .word $2c00
          .word $2c40
          .word $2c80
          .word $2cc0
          .word $2d00
          .word $2d40
          .word $2d80
          .word $2dc0
          .word $3000
          .word $3040
          .word $3080
          .word $30c0
          .word $3100
          .word $3140
          .word $3180
          .word $31c0
          .word $3400
          .word $0c40
          .word $10c0
          .word $1840
          .word $2440
          .word $2440
          .word $2440
          .word $2440
          .word $2440
          .word $2440
          .word $2440
          .word $2440
          .word $2440
          .word $2440
          .word $2440
          .word $2c00
          .word $3580

        .endblock

        aUnitWindowFE4ItemIconVRAMBases .block ; 90/CF80

          ; Unused.
          ; In FE4, these are offsets into the
          ; object VRAM tile space that item
          ; icons begin at, indexed into by
          ; OBSEL & (OBSEL_Base | OBSEL_Gap)

          .word $0000 >> 1
          .word $0000 >> 1
          .word $0000 >> 1
          .word $4000 >> 1
          .word $8000 >> 1
          .word $C000 >> 1
          .word $0000 >> 1
          .word $4000 >> 1
          .word $8000 >> 1
          .word $C000 >> 1
          .word $1000 >> 1
          .word $5000 >> 1
          .word $9000 >> 1
          .word $D000 >> 1
          .word $1000 >> 1
          .word $5000 >> 1
          .word $9000 >> 1
          .word $D000 >> 1
          .word $2000 >> 1
          .word $6000 >> 1
          .word $A000 >> 1
          .word $E000 >> 1
          .word $2000 >> 1
          .word $6000 >> 1
          .word $A000 >> 1
          .word $E000 >> 1
          .word $3000 >> 1
          .word $7000 >> 1
          .word $B000 >> 1
          .word $F000 >> 1
          .word $3000 >> 1
          .word $7000 >> 1
          .word $B000 >> 1
          .word $F000 >> 1

        .endblock

      endData
      startCode

        rlUnitWindowFE4CopyWeaponRankIcon ; 90/CFC4

          .al
          .xl
          .autsiz
          .databank `*

          ; Unused.
          ; In FE4, this copies a weapon rank icon
          ; to VRAM.

          ; This is also bugged in FE5: the table of
          ; pointers to the icon graphics is missing, and
          ; its reference refers to the VRAM offset table.

          ; Inputs:
          ; A: rank index

          ; Outputs:
          ; None

          phx
          phy
          php

          cmp #-1
          bne +

            lda #10

          +
          tay
          txa
          asl a
          asl a
          asl a
          asl a
          sta wR0

          lda bBufferOBSEL
          and #(OBSEL_Base | OBSEL_Gap)
          asl a
          tax
          lda _IconVRAMBases,x ; Missing actual table
          clc
          adc wR0
          pha
          tya
          sta wR0

          asl a
          clc
          adc wR0
          tax
          lda _IconVRAMBases+size(byte),x
          sta lR18+size(byte)
          lda _IconVRAMBases,x
          sta lR18

          lda #(2 * size(Tile4bpp))
          sta wR0

          pla
          sta wR1
          pha
          jsl rlDMAByPointer

          lda lR18
          clc
          adc #(16 * size(Tile4bpp))
          sta lR18

          lda #(2 * size(Tile4bpp))
          sta wR0

          pla
          clc
          adc #(16 * size(Tile4bpp)) >> 1
          sta wR1
          jsl rlDMAByPointer

          plp
          ply
          plx
          rtl

          .databank 0

          endCode
          startData

            _IconVRAMBases ; 90/D020

              ; See aUnitWindowFE4ItemIconVRAMBases

              .word $0000 >> 1
              .word $4000 >> 1
              .word $8000 >> 1
              .word $C000 >> 1
              .word $0000 >> 1
              .word $4000 >> 1
              .word $8000 >> 1
              .word $C000 >> 1
              .word $1000 >> 1
              .word $5000 >> 1
              .word $9000 >> 1
              .word $D000 >> 1
              .word $1000 >> 1
              .word $5000 >> 1
              .word $9000 >> 1
              .word $D000 >> 1
              .word $2000 >> 1
              .word $6000 >> 1
              .word $A000 >> 1
              .word $E000 >> 1
              .word $2000 >> 1
              .word $6000 >> 1
              .word $A000 >> 1
              .word $E000 >> 1
              .word $3000 >> 1
              .word $7000 >> 1
              .word $B000 >> 1
              .word $F000 >> 1
              .word $3000 >> 1
              .word $7000 >> 1
              .word $B000 >> 1
              .word $F000 >> 1

          endData
          startCode

        rlUnitWindowRenderSortSelectorCursor ; 90/D060

          .al
          .xl
          .autsiz
          .databank ?

          ; Renders the cursor used when picking a sort type.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          phb
          php

          phk
          plb

          .databank `*

          lda wUnitWindowCurrentRow
          cmp #-1
          bne _End

            lda wUnitWindowCurrentColumn
            asl a
            tax
            lda aUnitWindowSortSelectorCursorColumns,x
            clc
            adc #SortSelectorCursorBase[0]
            sta wR0

            lda #SortSelectorCursorBase[1]
            sta wR1

            _BaseTile := VRAMToTile(SystemIconTilesPosition, OAMBase, size(Tile4bpp))

            lda #TilemapEntry(_BaseTile, 0, false, false, false)
            sta wR4

            stz wR5

            lda wVBlankEnabledFramecount
            sta wR13

            lda #48
            sta wR14

            jsl rlUnsignedDivide16By16

            lda wR10
            lsr a
            lsr a
            lsr a
            asl a
            tax
            lda aUnitWindowSortSelectorCursorSprites,x
            tay
            jsl rlPushToOAMBuffer

          _End
          plp
          plb
          rtl

          .databank 0

      endCode
      startData

        ; These sprites and their table are unused in FE5.

        aUnitWindowFE4SortSelectorCursorSprites .block ; 90/D0A7
          .addr aUnitWindowFE4SortSelectorCursorFrame0
          .addr aUnitWindowFE4SortSelectorCursorFrame1
          .addr aUnitWindowFE4SortSelectorCursorFrame2
          .addr aUnitWindowFE4SortSelectorCursorFrame3
        .endblock

        aUnitWindowFE4SortSelectorCursorFrame0 .structSpriteArray [[(   0,    5), $21, SpriteLarge, $00C, 3, 1, false, false], [(   0,   27), $21, SpriteLarge, $00C, 3, 1, false, true]] ; 90/D0AF
        aUnitWindowFE4SortSelectorCursorFrame1 .structSpriteArray [[(   0,    4), $21, SpriteLarge, $00C, 3, 1, false, false], [(   0,   28), $21, SpriteLarge, $00C, 3, 1, false, true]] ; 90/D0BB
        aUnitWindowFE4SortSelectorCursorFrame2 .structSpriteArray [[(   0,    5), $21, SpriteLarge, $00C, 3, 1, false, false], [(   0,   27), $21, SpriteLarge, $00C, 3, 1, false, true]] ; 90/D0C7
        aUnitWindowFE4SortSelectorCursorFrame3 .structSpriteArray [[(   0,    6), $21, SpriteLarge, $00C, 3, 1, false, false], [(   0,   26), $21, SpriteLarge, $00C, 3, 1, false, true]] ; 90/D0D3

        aUnitWindowSortSelectorCursorColumns .block ; 90/D0DF
          .word 32
          .word 100
          .word 152
          .word 176
          .word 200
          .word 228
          .word 32
          .word 104
          .word 160
          .word 188
          .word 220
          .word 32
          .word 84
          .word 104
          .word 132
          .word 152
          .word 176
          .word 200
          .word 224
          .word 32
          .word 88
          .word 112
          .word 152
          .word 204
          .word 32
          .word 85
          .word 101
          .word 117
          .word 133
          .word 149
          .word 165
          .word 181
          .word 197
          .word 213
          .word 229
          .word 32
          .word 148
        .endblock

        aUnitWindowFE4SortSelectorCursorColumns .block ; 90/D129

          ; Unused.
          ; In FE4, this is used for the sort selector cursor.

          .word 32
          .word 100
          .word 152
          .word 176
          .word 200
          .word 228
          .word 0
          .word 0
          .word 160
          .word 176
          .word 192
          .word 208
          .word 224
          .word 240
          .word 256
          .word 272
          .word 32
          .word 104
          .word 160
          .word 188
          .word 220
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 32
          .word 84
          .word 104
          .word 132
          .word 152
          .word 176
          .word 200
          .word 224
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 32
          .word 88
          .word 112
          .word 152
          .word 204
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 32
          .word 85
          .word 101
          .word 117
          .word 133
          .word 149
          .word 165
          .word 181
          .word 197
          .word 213
          .word 229
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 32
          .word 148
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
          .word 0
        .endblock

      endData
      startCode

        rsUnitWindowUnknown90D1E9 ; 90/D1E9

          .al
          .xl
          .autsiz
          .databank `*

          jsl rlUnitWindowFE4RenderWeaponRankWeaponRankSortIconWrapper

          lda wUnitWindowFE4SortTypeFlag
          cmp #$0002
          beq _D202

          cmp #$0003
          beq _D205

          cmp #$0004
          beq _D208

          bra _HandleInputs

          _D202
          jmp _D325

          _D205
          jmp _D344

          _D208
          jmp _D352

          _DoDown
          jmp _Down

          _DoB
          jmp _B

          _DoAOrX
          jmp _AOrX

          _HandleInputs
          jsl rlUnitWindowCheckForUnknownProcs
          bcc +

          jmp _Continue

          +

          _NewInputs  := [(JOY_Down, _DoDown)]
          _NewInputs ..= [(JOY_B, _DoB)]
          _NewInputs ..= [((JOY_A | JOY_X), _DoAOrX)]

          _HeldInputs  := [(JOY_Right, _Right)]
          _HeldInputs ..= [(JOY_Left, _Left)]

          .for _Inputs, _Actions in [(wJoy1New, _NewInputs), (wJoy1Repeated, _HeldInputs)]

            lda _Inputs

            .for _Pressed, _Handler in _Actions

              bit #_Pressed
              bne _Handler

            .endfor

          .endfor

          jmp _Continue

          _Right
          lda wUnitWindowFE4CurrentColumn
          inc a
          sta wUnitWindowFE4CurrentColumn

          lda wUnknown000304,b
          asl a
          tax
          lda aUnitWindowUnknown90D35C,x
          cmp wUnitWindowFE4CurrentColumn
          bge _LeftRightSound

          sta wUnitWindowFE4CurrentColumn

          lda wUnknown000304,b
          inc a
          cmp #$0006
          beq _Continue

          sta wUnknown000304,b

          lda #$0000
          sta wUnitWindowFE4CurrentColumn
          jsl $90BCF5

          lda wUnknown000304,b
          cmp #$0005
          bne +

          sep #$20

          lda #T_Setting(true, true, true, false, true)
          sta bBufferTM

          rep #$20

          +
          bra _LeftRightSound

          _Left
          lda wUnitWindowFE4CurrentColumn
          dec a
          sta wUnitWindowFE4CurrentColumn
          bpl _LeftRightSound

          lda #$0000
          sta wUnitWindowFE4CurrentColumn

          lda wUnknown000304,b
          dec a
          bmi _Continue

          sta wUnknown000304,b
          asl a
          tax
          lda $90D35C,x
          sta wUnitWindowFE4CurrentColumn

          lda wUnknown000304,b
          cmp #$0004
          bne +

            lda #(`procUnitWindowUnknown90EFFE)<<8
            sta lR44+size(byte)
            lda #<>procUnitWindowUnknown90EFFE
            sta lR44
            jsl rlProcEngineCreateProc
            bra _LeftRightSound

          +
          jsl $90BCF5

          _LeftRightSound
          lda #$000A ; TODO: sound definitions
          jsl rlPlaySoundEffect

          _Continue
          lda #$0001
          sta wR0
          lda #$000A
          sta wR1
          lda #$0000
          jsl rlUnitWindowFE4GetUnitSlot

          jsr rlUnitWindowRenderSortSelectorCursor

          _DirectionWrapUp

          lda wUnknown000304,b
          dec a
          bne +

            jsr rsUnitWindowFE4RenderItemIcons

          +
          lda wUnknown000304,b
          cmp #$0004
          bne +

            jsr rsUnitWindowRenderWeaponRankIcons

          +
          rts

          _Down

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            lda #$0000
            sta wUnitWindowFE4SortTypeFlag
            sta wUnitWindowFE4CurrentColumn
            bra _DirectionWrapUp

          _B

            lda #$0021 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            lda #$0000
            sta wUnitWindowFE4SortTypeFlag
            sta wUnitWindowFE4CurrentColumn
            bra _DirectionWrapUp

          _AOrX

            lda #$000D ; TODO: sound definitions
            jsl rlPlaySoundEffect
            jsr rlUnitWindowUpdateSort
            bra _Continue

          _D325

            ldx #$01C8
            lda #$0030
            ldy #$0006
            jsl rlUnitWindowUnknown90E35E

            jsl rlUnitWindowFE4DrawUnitNames
            jsl $90BCF5

            lda #$0003
            sta wUnitWindowFE4SortTypeFlag

            jmp _Continue

          _D344

            jsl rlUnitWindowFE4DrawUnitSkills
            lda #$0001
            sta wUnitWindowFE4SortTypeFlag
            jmp _Continue

          _D352

            lda #$0001
            sta wUnitWindowFE4SortTypeFlag
            jmp _Continue

      endCode
      startData

        aUnitWindowUnknown90D35C ; 90/D35C
          .word $0005
          .word $0004
          .word $0007
          .word $0004
          .word $000a
          .word $0001

      endData
      startCode

        rsUnitWindowUnknown90D368 ; 90/D368

          .al
          .xl
          .autsiz
          .databank ?

          lda wUnitWindowFE4UnitSwapStep
          cmp #$0002
          beq _D379

          cmp #$0003
          beq _D37C

          jmp _D37F

          _D379
          jmp _D3DD

          _D37C
          jmp _D3FC

          _D37F
          lda wJoy1New
          bit #JOY_B
          bne _B

          bit #(JOY_A | JOY_Y)
          bne _AOrY

          _End
          rts

          _AOrY
          lda wUnitWindowFE4CurrentLine
          cmp wUnitWindowFE4UnitSwapStartSlot
          beq _B

          lda #$000D ; TODO: sound definitions
          jsl rlPlaySoundEffect

          lda wUnitWindowFE4CurrentLine
          dec a
          tax
          lda wUnitWindowFE4UnitSwapStartSlot
          dec a
          jsr $90DAD8
          jsl rlUnitWindowUnknown90DF02

          lda #$0000
          sta $7E450E
          sta $7E450C

          lda #$0002
          sta wUnitWindowFE4UnitSwapStep

          jmp _End

          _B
          lda #$0021 ; TODO: sound definitions
          jsl rlPlaySoundEffect

          -
          lda #$0000
          sta wUnitWindowFE4UnitSwapStep
          sta wUnitWindowFE4UnitSwapStartCursorYCoordinate
          sta wUnitWindowFE4UnitSwapStartSlot
          jmp _End

          _D3DD
          ldx #$01C8
          lda #$0030
          ldy #$0006
          jsl $90E35E
          jsl rlUnitWindowFE4DrawUnitNames
          jsl $90BCF5

          lda #$0003
          sta wUnitWindowFE4UnitSwapStep

          jmp _End

          _D3FC
          jsl rlUnitWindowFE4DrawUnitSkills

          lda #$0000
          sta wUnitWindowFE4UnitSwapStep

          jmp -

          .databank 0

        rlUnitWindowUnknown90D40A ; 90/D40A

          .al
          .xl
          .autsiz
          .databank ?

          asl a
          tax
          lda aUnitWindowUnknownPalettes90D423,x
          tay
          ldx #size(Palette) - size(word)

          -

          .rept size(word)
            dec x
          .endrept

          phx
          tyx
          sta @l aBGPaletteBuffer.aPalette0,x

          .rept size(word)
            dec x
          .endrept

          txy
          plx
          bpl -

          rtl

          .databank 0

      endCode
      startData

        aUnitWindowUnknownPalettes90D423 .block ; 90/D423

          .for _Palette in range(aBGPaletteBuffer, aOAMPaletteBuffer, size(Palette))

            .word _Palette + (size(Palette) - size(word))

          .endfor

        .endblock

      endData
      startCode

        rlUnitWindowUnknown90D434 ; 90/D434

          .al
          .xl
          .autsiz
          .databank ?

          asl a
          tax
          lda aUnitWindowUnknownPalettes90D423,x
          tay
          ldx #size(Palette) - size(word)

          -

          .rept size(word)
            dec x
          .endrept

          phx
          tyx
          sta @l aBGPaletteBuffer.aPalette0,x

          .rept size(word)
            dec x
          .endrept

          txy
          plx
          bpl -

          rtl

          .databank 0

        rlUnitWindowGetEquippedWeapon ; 90/D44C

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          phx

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot
          jsl rlGetEquippableItemInventoryOffset

          lda aItemDataBuffer.DisplayedWeapon,b
          and #$00FF

          plx
          plp
          plb
          rtl

          .databank 0

        rlUnitWindowUnknown90D473 ; 90/D473

          .al
          .xl
          .autsiz
          .databank ?

          phx
          jsl $90E911
          tax
          lda wTemporaryUnitWindowItem,b
          beq +

          txa
          jsl $90E922
          bcs +

          clc
          plx
          rtl

          +
          lda #-1
          sec
          plx
          rtl

          .databank 0

        rlUnitWindowUpdateSort ; 90/D48E

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          phk
          plb

          .databank `*

          lda wUnitWindowCurrentColumn
          tax
          lda aUnitWindowSortColumnTypes,x
          and #$00FF
          sta wUnitWindowSortType

          ldx #0

          lda wJoy1New
          bit #JOY_X
          beq +

          inc x

          +
          txa
          sta wUnitWindowSortDirection
          jsl rlUnitWindowGetSortScores

          lda wUnitWindowSortDirection
          bne +

          jsl rlUnitWindowSetSortDescending
          bra ++

          +
          jsl rlUnitWindowSetSortAscending

          +
          jsl rlUnitWindowUnknown90DF02

          plp
          plb
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowSortColumnTypes .block ; 90/D4CC
          _Page1 .block ; 90/D4CC
            .byte $00
            .byte $01
            .byte $02
            .byte $03
            .byte $04
            .byte $05
          .endblock
          _Page2 .block ; 90/D4D2
            .byte $00
            .byte $06
            .byte $07
            .byte $08
            .byte $09
          .endblock
          _Page3 .block ; 90/D4D7
            .byte $00
            .byte $0a
            .byte $0b
            .byte $0c
            .byte $0d
            .byte $0e
            .byte $0f
            .byte $10
          .endblock
          _Page4 .block ; 90/D4DF
            .byte $00
            .byte $18
            .byte $24
            .byte $16
            .byte $25
          .endblock
          _Page5 .block ; 90/D4E4
            .byte $00
            .byte $19
            .byte $1a
            .byte $1b
            .byte $1c
            .byte $1d
            .byte $1e
            .byte $1f
            .byte $20
            .byte $21
            .byte $22
          .endblock
          _Page6 .block ; 90/D4EF
            .byte $00
            .byte $23
          .endblock
        .endblock

        aUnitWindowUnknown90D4CC .block
          .long aUnitWindowSortColumnTypes._Page1
          .long aUnitWindowSortColumnTypes._Page2
          .long aUnitWindowSortColumnTypes._Page3
          .long aUnitWindowSortColumnTypes._Page4
          .long aUnitWindowSortColumnTypes._Page5
          .long aUnitWindowSortColumnTypes._Page6
        .endblock

      endData
      startCode

        rlUnitWindowSetSortDescending ; 90/D503

          .al
          .xl
          .autsiz
          .databank ?

          lda wUnitWindowMaxRows
          cmp #1
          beq _End

            asl a
            sta wR15

            sec
            sbc #size(word)
            sta wR14

            lda #`$7FB2BB

            sep #$20

            pha

            rep #$20

            plb

            .databank `$7FB2BB

            ldy #0

            -
              tyx

              .rept size(word)
                inc x
              .endrept

              -
                lda $7FB2BB,y
                cmp @l $7FB2BB,x
                bge +

                  phx
                  phy

                  txa
                  lsr a
                  tax
                  tya
                  lsr a
                  jsr $90DE7D
                  ply
                  plx

                +

                .rept size(word)
                  inc x
                .endrept

                cpx wR15
                bne -

                  .rept size(word)
                    inc y
                  .endrept

                  cpy wR14
                  bne --

          _End
          phk
          plb

          .databank `*

          rtl

          .databank 0

        rlUnitWindowSetSortAscending ; 90/D548

          .al
          .xl
          .autsiz
          .databank ?

          lda wUnitWindowMaxRows
          cmp #1
          beq _End

            asl a
            sta wR15

            sec
            sbc #size(word)
            sta wR14

            lda #`$7FB2BB

            sep #$20

            pha

            rep #$20

            plb

            .databank `$7FB2BB

            ldy #0

            -
              tyx

              .rept size(word)
                inc x
              .endrept

              -
                lda $7FB2BB,y

                inc a

                eor #-1
                inc a

                sta wR12

                lda @l $7FB2BB,x

                inc a
                eor #-1

                inc a

                sta wR11

                lda wR12
                cmp wR11
                bcs +

                  phx
                  phy

                  txa
                  lsr a
                  tax
                  tya
                  lsr a
                  jsr $90DE7D

                  ply
                  plx

                +

                .rept size(word)
                  inc x
                .endrept

                cpx wR15
                bne -

                  .rept size(word)
                    inc y
                  .endrept

                  cpy wR14
                  bne --

          _End
          phk
          plb

          .databank `*

          rtl

          .databank 0

        rlUnitWindowDrawSortText ; 90/D59F

          .al
          .xl
          .autsiz
          .databank ?

          lda #(`$9AEC7B)<<8
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
          lda #<>$9AEC7B
          sta aCurrentTilemapInfo.lInfoPointer,b

          lda #TilemapEntry(0, 0, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          ldx #pack([18, 1])

          lda #(`_String)<<8
          sta lR18+size(byte)
          lda #<>_String
          sta lR18

          jsl rlDrawMenuText

          bra +

          endCode
          startMenuText

          _String
            .enc "SJIS"
            .text "　　　\n"

          endMenuText
          startCode

          +

          lda wUnitWindowSortType
          asl a
          tax
          lda _SortTextPointers,x
          beq +

          sta lR18

          sep #$20

          lda #`*
          sta lR18+size(word)

          rep #$20

          ldx #pack([18, 1])
          jsl rlDrawMenuText

          +
          rtl

          .databank 0

          endCode
          startData

          _SortTextPointers .block

            .addr menutextUnitWindowSortName
            .addr menutextUnitWindowSortClass
            .addr menutextUnitWindowSortLevel
            .addr menutextUnitWindowSortExperience
            .addr menutextUnitWindowSortCurrentHP
            .addr menutextUnitWindowSortMaxHP
            .addr menutextUnitWindowSortWeapon
            .addr menutextUnitWindowSortMight
            .addr menutextUnitWindowSortAccuracy
            .addr menutextUnitWindowSortAvoid
            .addr menutextUnitWindowSortStrength
            .addr menutextUnitWindowSortMagic
            .addr menutextUnitWindowSortSkill
            .addr menutextUnitWindowSortSpeed
            .addr menutextUnitWindowSortLuck
            .addr menutextUnitWindowSortDefense
            .addr menutextUnitWindowSortConstitution
            .word None
            .word None
            .word None
            .word None
            .word None
            .addr menutextUnitWindowSortStatus
            .word None
            .addr menutextUnitWindowSortMovement
            .word None
            .word None
            .word None
            .word None
            .word None
            .word None
            .word None
            .word None
            .word None
            .word None
            .addr menutextUnitWindowSortSkills
            .addr menutextUnitWindowSortFatigue
            .addr menutextUnitWindowSortTraveler
            .word None

          .endblock

          endData
          startMenuText

            .enc "SJIS"

            menutextUnitWindowSortName .text "名　前\n" ; 90/D638
            menutextUnitWindowSortClass .text "クラス\n" ; 90/D640
            menutextUnitWindowSortLevel .text "レベル\n" ; 90/D648
            menutextUnitWindowSortExperience .text "ＥｘＰ\n" ; 90/D650
            menutextUnitWindowSortCurrentHP .text "　ＨＰ\n" ; 90/D658
            menutextUnitWindowSortMaxHP .text "ＭＨＰ\n" ; 90/D660
            menutextUnitWindowSortWeapon .text "装　備\n" ; 90/D668
            menutextUnitWindowSortMight .text "攻　撃\n" ; 90/D670
            menutextUnitWindowSortAccuracy .text "命中値\n" ; 90/D678
            menutextUnitWindowSortAvoid .text "回避値\n" ; 90/D680
            menutextUnitWindowSortStrength .text "　力　\n" ; 90/D688
            menutextUnitWindowSortMagic .text "魔　力\n" ; 90/D690
            menutextUnitWindowSortSkill .text "　技　\n" ; 90/D698
            menutextUnitWindowSortSpeed .text "速　さ\n" ; 90/D6A0
            menutextUnitWindowSortLuck .text "幸　運\n" ; 90/D6A8
            menutextUnitWindowSortDefense .text "守　備\n" ; 90/D6B0
            menutextUnitWindowSortConstitution .text "体　格\n" ; 90/D6B8
            menutextUnitWindowSortMovement .text "移　動\n" ; 90/D6C0
            menutextUnitWindowSortFatigue .text "疲　労\n" ; 90/D6C8
            menutextUnitWindowSortStatus .text "状　態\n" ; 90/D6D0
            menutextUnitWindowSortTraveler .text "同　行\n" ; 90/D6D8
            menutextUnitWindowSortSkills .text "スキル\n" ; 90/D6E0

          endMenuText
          startCode

        rlUnitWindowFE4DrawSortLabels ; 90/D6E8

          .al
          .xl
          .autsiz
          .databank ?

          lda #0

          .for _y, _x in iter.product([range(2), range(5)])

            sta aBG3TilemapBuffer + (C2I((_x, _y), 32) * size(word))

          .endfor

          lda wUnitWindowSortType
          cmp #$0026
          bmi +

          - bra -

          +
          asl a
          tax
          jsr (_TypeHandlers,x)
          jsl rlDMAByStruct

            .structDMAToVRAM aBG3TilemapBuffer + (C2I((0, 0), 32) * size(word)), $000A, VMAIN_Setting(true), $F044

          jsl rlDMAByStruct

            .structDMAToVRAM aBG3TilemapBuffer + (C2I((0, 1), 32) * size(word)), $000C, VMAIN_Setting(true), $F084

          rtl

          .databank 0

          endCode
          startData

          _TypeHandlers

            .addr rsUnitWindowFE4DrawNameSortLabel
            .addr rsUnitWindowFE4DrawClassSortLabel
            .addr rsUnitWindowFE4DrawLevelSortLabel
            .addr rsUnitWindowFE4DrawExperienceSortLabel
            .addr rsUnitWindowFE4DrawCurrentHPSortLabel
            .addr rsUnitWindowFE4DrawMaxHPSortLabel
            .addr rsUnitWindowFE4DrawWeaponSortLabel
            .addr rsUnitWindowFE4DrawMightSortLabel
            .addr rsUnitWindowFE4DrawAccuracySortLabel
            .addr rsUnitWindowFE4DrawAvoidSortLabel
            .addr rsUnitWindowFE4DrawStrengthSortLabel
            .addr rsUnitWindowFE4DrawMagicSortLabel
            .addr rsUnitWindowFE4DrawSkillSortLabel
            .addr rsUnitWindowFE4DrawSpeedSortLabel
            .addr rsUnitWindowFE4DrawLuckSortLabel
            .addr rsUnitWindowFE4DrawDefenseSortLabel
            .addr rsUnitWindowFE4DrawConstitutionSortLabel
            .word None
            .word None
            .word None
            .word None
            .word None
            .addr rsUnitWindowFE4DrawStatusSortLabel
            .word None
            .addr rsUnitWindowFE4DrawMovementSortLabel
            .addr rsUnitWindowFE4DrawDummySortLabel
            .addr rsUnitWindowFE4DrawDummySortLabel
            .addr rsUnitWindowFE4DrawDummySortLabel
            .addr rsUnitWindowFE4DrawDummySortLabel
            .addr rsUnitWindowFE4DrawDummySortLabel
            .addr rsUnitWindowFE4DrawDummySortLabel
            .addr rsUnitWindowFE4DrawDummySortLabel
            .addr rsUnitWindowFE4DrawDummySortLabel
            .addr rsUnitWindowFE4DrawDummySortLabel
            .addr rsUnitWindowFE4DrawDummySortLabel
            .addr rsUnitWindowFE4DrawSkillsSortLabel
            .addr rsUnitWindowFE4DrawFatigueSortLabel
            .addr rsUnitWindowFE4DrawTravelerSortLabel

          endData
          startCode

        macroFE4DrawNameSortLabel .segment TileIndex, Width, Offset, BaseTile=TilemapEntry(0, 4, true, false, false)
          lda #+\BaseTile
          sta wR1
          lda #+\TileIndex
          sta wR2
          lda #\Width
          sta wR0
          ldx #\Offset * size(word)
          jsl rlUnitWindowUnknown90EC39
        .endsegment

        ; All of these follow the same pattern, and have no
        ; inputs or outputs, except for skills.

        rsUnitWindowFE4DrawNameSortLabel ; 90/D78A

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $024C, 4, 1

          rts

          .databank 0

        rsUnitWindowFE4DrawClassSortLabel ; 90/D7A1

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $0260, 5, 0

          rts

          .databank 0

        rsUnitWindowFE4DrawLevelSortLabel ; 90/D7B8

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $020C, 1, 1
          macroFE4DrawNameSortLabel $020D, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawExperienceSortLabel ; 90/D7E5

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $020E, 1, 1
          macroFE4DrawNameSortLabel $020F, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawCurrentHPSortLabel ; 90/D812

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $0220, 1, 1
          macroFE4DrawNameSortLabel $0221, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawMaxHPSortLabel ; 90/D83F

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $01C1, 3, 1

          rts

          .databank 0

        rsUnitWindowFE4DrawWeaponSortLabel ; 90/D856

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $01A9, 1, 1
          macroFE4DrawNameSortLabel $01AA, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawMightSortLabel ; 90/D883

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $0180, 1, 1
          macroFE4DrawNameSortLabel $0181, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawAccuracySortLabel ; 90/D8B0

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $0182, 2, 1
          macroFE4DrawNameSortLabel $0188, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawAvoidSortLabel ; 90/D8DD

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $0184, 2, 1
          macroFE4DrawNameSortLabel $0188, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawStrengthSortLabel ; 90/D90A

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $01C4, 1, 2

          rts

          .databank 0

        rsUnitWindowFE4DrawMagicSortLabel ; 90/D921

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $018D, 1, 1
          macroFE4DrawNameSortLabel $018E, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawSkillSortLabel ; 90/D94E

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $01C6, 1, 1
          macroFE4DrawNameSortLabel $01C7, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawSpeedSortLabel ; 90/D97B

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $018F, 1, 1
          macroFE4DrawNameSortLabel $01A0, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawLuckSortLabel ; 90/D9A8

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $0189, 1, 1
          macroFE4DrawNameSortLabel $018A, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawDefenseSortLabel ; 90/D9D5

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $01A1, 1, 1
          macroFE4DrawNameSortLabel $01A2, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawConstitutionSortLabel ; 90/DA02

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $018D, 1, 1
          macroFE4DrawNameSortLabel $01A3, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawStatusSortLabel ; 90/DA2F

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $01A6, 3, 1

          rts

          .databank 0

        rsUnitWindowFE4DrawMovementSortLabel ; 90/DA46

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $0186, 1, 1
          macroFE4DrawNameSortLabel $0187, 1, 3

          rts

          .databank 0

        rsUnitWindowFE4DrawDummySortLabel ; 90/DA73

          .al
          .xl
          .autsiz
          .databank ?

          rts

          .databank 0

        rsUnitWindowFE4DrawSkillsSortLabel ; 90/DA74

          .al
          .xl
          .autsiz
          .databank ?

          lda #TilemapEntry(0, 4, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          lda #(`_String)<<8
          sta lR18+size(byte)
          lda #<>_String
          sta lR18
          ldx #pack([1, 0])
          jsl rlDrawMenuText
          rts

          .databank 0

          endCode
          startMenuText

            _String

              .enc "SJIS"

              .text "スキル\n"

          endMenuText
          startCode

        rsUnitWindowFE4DrawFatigueSortLabel ; 90/DA94

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $02EC, 4, 1

          rts

          .databank 0

        rsUnitWindowFE4DrawTravelerSortLabel ; 90/DAAB

          .al
          .xl
          .autsiz
          .databank ?

          macroFE4DrawNameSortLabel $01AF, 1, 1
          macroFE4DrawNameSortLabel $01C0, 1, 3

          rts

          .databank 0

        rsUnitWindowUnknown90DAD8 ; 90/DAD8

          .al
          .xl
          .autsiz
          .databank ?

          asl a
          tay
          txa
          asl a
          tax
          sta wR1

          lda aUnitWindowDeploymentSlots,x
          sta wR0

          tyx
          lda aUnitWindowDeploymentSlots,x
          ldx wR1
          sta aUnitWindowDeploymentSlots,x

          lda wR0
          tyx
          sta aUnitWindowDeploymentSlots,x

          ldx wR1
          lda $7FB1D9,x
          sta wR0

          tyx
          lda $7FB1D9,x
          ldx wR1
          sta $7FB1D9,x

          lda wR0
          tyx
          sta $7FB1D9,x

          ldx wR1
          lda $7FB171,x
          sta wR0

          tyx
          lda $7FB171,x
          ldx wR1
          sta $7FB171,x

          lda wR0
          tyx
          sta $7FB171,x
          lda #$0001
          sta wR0

          stz wR2

          -
          lda wR2
          asl a
          tax
          lda aUnitWindowDeploymentSlots,x
          beq +

          sta wTemporaryDeploymentInfo,b

          jsl rlUnitWindowUnknown90E90C
          dec a
          tax

          sep #$20

          lda wR0
          sta aUnitWindowUnknown7E4510,x

          rep #$20

          inc wR0
          inc wR2
          bra -

          +
          rts

          .databank 0

        rlUnitWindowGetSortScores ; 90/DB56

          .al
          .xl
          .autsiz
          .databank `*

          lda wUnitWindowSortType
          bmi _End

          lda wUnitWindowSortType
          cmp #$0027
          bmi +

          - bra -

          +
          asl a
          tax
          jsr (_ScoreFunctions,x)

          _End
          rtl

          .databank 0

          endCode
          startData

            _ScoreFunctions .binclude "../TABLES/UnitWindowSortScorePointers.csv.asm" ; 90/DB6D

            ; This is a hacky way to do this.

            UnitWindowSortTypes = rlUnitWindowGetSortScores._ScoreFunctions

          endData
          startCode

        rsUnitWindowGetNameSortScores ; 90/DBBB

          .al
          .xl
          .autsiz
          .databank `*

          lda wUnitWindowMaxRows
          asl a
          sta wR15

          ldx #0

          -
            stx wR14

            lda aUnitWindowDeploymentSlots,x
            beq +

              sta wTemporaryDeploymentInfo,b
              jsl rlUnitWindowGetUnitName

              eor #-1
              inc a
              ldx wR14
              sta $7FB2BB,x

              ldx wR14

              .rept size(word)
                inc x
              .endrept

              cpx wR15
              bne -

          +
          rts

          .databank 0

        rsUnitWindowUnknownGetSortScores90DBE7 ; 90/DBE7

          .al
          .xl
          .autsiz
          .databank `*

          lda wUnitWindowMaxRows
          asl a
          sta wR15

          ldx #0

          -
            stx wR14

            lda aUnitWindowDeploymentSlots,x
            beq +

              sta wTemporaryDeploymentInfo,b
              jsl rlUnitWindowUnknown90E90C

              dec a
              tax
              lda aUnitWindowUnknown7E454E,x
              and #$00FF
              ldx wR14
              sta $7FB2BB,x

              ldx wR14

              .rept size(word)
                inc x
              .endrept

              cpx wR15
              bne -

          +
          rts

          .databank 0

        rsUnitWindowGetLevelSortScores ; 90/DC18

          .al
          .xl
          .autsiz
          .databank `*

          lda #$0003
          sta wUnitWindowSortType

          jsr rsUnitWindowGetSortScoresByType

          lda wUnitWindowSortDirection
          bne +

          jsl $90D503
          bra ++

          +
          jsl $90D548

          +
          lda #$0002
          sta wUnitWindowSortType

          jsr rsUnitWindowGetSortScoresByType

          rts

          .databank 0

        rsUnitWindowGetSortScoresByType ; 90/DC3D

          .al
          .xl
          .autsiz
          .databank `*

          lda wUnitWindowMaxRows
          asl a
          sta wR15

          ldx #0

          -
          lda aUnitWindowDeploymentSlots,x
          beq +

          sta wTemporaryDeploymentInfo,b
          lda wR15
          pha
          phx
          jsl rlUnitWindowGetSortScoreByType
          plx
          sta $7FB2BB,x
          pla
          sta wR15

          .rept size(word)
            inc x
          .endrept

          cpx wR15
          bne -

          +
          rts
          
          .databank 0

        rlUnitWindowGetSortScoreByType ; 90/DC67

          .al
          .xl
          .autsiz
          .databank `*

          lda wUnitWindowSortType
          sta wR0

          asl a
          clc
          adc wR0
          tax

          lda _RoutinePointers+size(byte),x
          sta lR18+size(byte)
          lda _RoutinePointers,x
          sta lR18

          jmp [lR18]

          .databank 0

          endCode
          startData

            _RoutinePointers ; 90/DC7F

            .long $000000
            .long $000000
            .long rlUnitWindowGetUnitLevel
            .long rlUnitWindowGetUnitExperience
            .long rlUnitWindowGetUnitCurrentHP
            .long rlUnitWindowGetUnitMaxHP
            .long $000000
            .long rlUnitWindowGetUnitMight
            .long rlUnitWindowGetUnitHit
            .long rlUnitWindowGetUnitAvoid
            .long rlUnitWindowGetUnitStrength
            .long rlUnitWindowGetUnitMagic
            .long rlUnitWindowGetUnitSkill
            .long rlUnitWindowGetUnitSpeed
            .long rlUnitWindowGetUnitLuck
            .long rlUnitWindowGetUnitDefense
            .long rlUnitWindowGetUnitConstitution
            .long $000000
            .long $000000
            .long $000000
            .long $000000
            .long $000000
            .long rlUnitWindowGetUnitStatus
            .long rlUnitWindowFE4GetUnitStatus
            .long rlUnitWindowGetUnitMove
            .long $000000
            .long $000000
            .long $000000
            .long $000000
            .long $000000
            .long $000000
            .long $000000
            .long $000000
            .long $000000
            .long $000000
            .long $000000
            .long rlUnitWindowGetUnitFatigue
            .long $000000

          endData
          startCode

        rsUnitWindowGetWeaponSortScores ; 90/DCF1

          .al
          .xl
          .autsiz
          .databank `*

          phb
          php

          phk
          plb

          .databank `*

          sep #$20

          lda #`*
          pha

          plb

          .databank `*

          rep #$20

          lda wUnitWindowMaxRows
          asl a
          sta wR15

          ldx #0

          -
            lda aUnitWindowDeploymentSlots,x
            beq _End

            sta wTemporaryDeploymentInfo,b
            jsl $90E32B
            bcc +

              lda #0
              bra _SetScore

            +
            phx

            lda aItemDataBuffer.Traits,b
            bit #TraitBroken
            beq +

              lda aItemDataBuffer.Durability,b
              and #$00FF
              bra ++

            +
            lda aItemDataBuffer.DisplayedWeapon,b
            and #$00FF

            +
            tax
            lda $B0992E,x
            and #$00FF
            and #$00FF

            plx

            and #$00FF

            _SetScore
            eor #-1
            inc a
            sta $7FB2BB,x

            .rept size(word)
              inc x
            .endrept

            cpx wR15
            bne -

          _End
          plp
          plb
          rts

          .databank 0

        rsUnitWindowGetWeaponRankSortScores ; 90/DD52

          .al
          .xl
          .autsiz
          .databank `*

          jsl $84B46A

          lda wUnitWindowMaxRows
          asl a
          sta wR15

          lda wUnitWindowSortType
          sec
          sbc #$0019
          sta wR14

          ldx #0

          -
            lda aUnitWindowDeploymentSlots,x
            beq +

              sta wTemporaryDeploymentInfo,b
              lda wR14
              jsl $90E870
              sta $7FB2BB,x

              .rept size(word)
                inc x
              .endrept

              cpx wR15
              bne -

          +
          rts

          .databank 0

        rsUnitWindowGetClassSortScores ; 90/DD84

          .al
          .xl
          .autsiz
          .databank `*

          lda wUnitWindowMaxRows
          asl a
          sta wR15

          ldx #0

          -
            lda aUnitWindowDeploymentSlots,x
            beq +

              sta wTemporaryDeploymentInfo,b
              jsl $90E77C
              phx
              tax
              lda aUnitWindowClassSortTable,x
              and #$00FF
              plx
              inc a

              eor #-1
              inc a

              sta $7FB2BB,x

              .rept size(word)
                inc x
              .endrept

              cpx wR15
              bne -

          +
          rts

          .databank 0

        rsUnitWindowGetSkillSortScores ; 90/DDB5

          .al
          .xl
          .autsiz
          .databank `*

          lda wUnitWindowMaxRows
          asl a
          sta wR15

          ldx #0

          -
            lda aUnitWindowDeploymentSlots,x
            beq _End

              sta wTemporaryDeploymentInfo,b
              jsl $90E92E

              lda wTemporaryUnitWindowSkillCounter,b
              beq _SetScore

              phx

              lda #0
              sta wR13
              sta wR14

              -
                tax
                lda aTemporaryUnitWindowSkillList,b,x
                and #$00FF
                beq +

                txa
                asl a
                tax
                lda @l $90E183,x
                beq +

                  inc wR14

                +
                inc wR13
                lda wR13
                cmp #$0015
                bne -

              lda wR14
              plx

              _SetScore
              sta $7FB2BB,x

              .rept size(word)
                inc x
              .endrept

              cpx wR15
              bne --

          _End
          rts

          .databank 0

        rsUnitWindowUnknownGetSortScores90DE04 ; 90/DE04

          .al
          .xl
          .autsiz
          .databank `*

          lda wUnitWindowMaxRows
          asl a
          sta wR15

          ldx #0

          -
            lda aUnitWindowDeploymentSlots,x
            beq +

              sta wTemporaryDeploymentInfo,b

              lda #$0000
              sta wTemporaryUnitWindowCounter,b

              jsl $90E837
              sta $7FB2BB,x

              .rept size(word)
                inc x
              .endrept

              cpx wR15
              bne -

          +
          rts

          .databank 0

        rsUnitWindowUnknownGetSortScores90DE2C ; 90/DE2C

          .al
          .xl
          .autsiz
          .databank `*

          lda wUnitWindowMaxRows
          asl a
          sta wR15

          ldx #0

          -
            lda aUnitWindowDeploymentSlots,x
            beq +

              sta wTemporaryDeploymentInfo,b
              lda #-1
              jsl rlUnitWindowGetUnitAvoid
              clc
              adc #$0080
              sta $7FB2BB,x

              .rept size(word)
                inc x
              .endrept

              cpx wR15
              bne -

          +
          rts

          .databank 0

        rsUnitWindowGetTravelerSortScores ; 90/DE55

          .al
          .xl
          .autsiz
          .databank `*

          lda wUnitWindowMaxRows
          asl a
          sta wR15

          ldx #0

          -
            lda aUnitWindowDeploymentSlots,x
            beq +

              sta wTemporaryDeploymentInfo,b
              phx
              jsl $90E668
              plx
              eor #-1
              inc a
              sta $7FB2BB,x

              .rept size(word)
                inc x
              .endrept

              cpx wR15
              bne -

          +
          rts

          .databank 0

        rsUnitWindowSwapSortSlots ; 90/DE7D

          .al
          .xl
          .autsiz
          .databank `*

          sta wR0

          cpx wR0
          bpl +

          tay
          txa
          tyx

          +
          sta wR3
          stx wR4

          asl a
          sta wR1

          txa
          asl a
          sta wR2

          .for _SortPiece in [aUnitWindowDeploymentSlots, $7FB1D9, aUnitWindowCurrentSortScores, aUnitWindowItemIconTileIndexes]

            ldx wR2
            lda _SortPiece,x
            sta wR0

            -
              lda _SortPiece-size(word),x
              sta _SortPiece,x

              .rept size(word)
                dec x
              .endrept

              cpx wR1
              bne -

            lda wR0
            sta _SortPiece,x

          .endfor

          rts

          .databank 0

        rlUnitWindowUnknown90DF02 ; 90/DF02

          .autsiz
          .databank ?

          rtl

          .databank 0

        rlUnitWindowUnknown90DF03 ; 90/DF03

          .al
          .xl
          .autsiz
          .databank ?

          ldx #0

          -
            lda aUnitWindowDeploymentSlots,x
            beq _End

            sta wTemporaryDeploymentInfo,b
            ldy #0
            jsl $90EA27

            lda $7E4547
            cmp #$0001
            bne +

              ldy #$0001

            +
            tya
            sta aUnitWindowFE4ReadyToPromoteFlags,x

            .rept size(word)
              inc x
            .endrept

            cpx #$0066
            bne -

          _End
          rtl

          .databank 0

        rlUnitWindowUnknown90DF2F ; 90/DF2F

          .al
          .xl
          .autsiz
          .databank ?

          lda #$0000
          jsl $90E8D1

          sta wR0
          jsl rlUnitWindowUnknown90E90C

          dec a
          tax
          lda wR0
          sep #$20

          sta aUnitWindowUnknown7E4510,x

          rep #$20
          rtl

          .databank 0

        rlUnitWindowUnknown90DF49 ; 90/DF49

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlUnitWindowUnknown90E90C
          dec a
          tax
          lda aUnitWindowUnknown7E4510,x
          and #$00FF
          sta wR2

          sep #$20

          lda #$00
          sta aUnitWindowUnknown7E4510,x

          rep #$20

          ldx #$0000

          -
          lda aUnitWindowUnknown7E4510,x
          and #$00FF
          cmp wR2
          blt +

          lda aUnitWindowUnknown7E4510,x
          dec a
          sta aUnitWindowUnknown7E4510,x

          +
          inc x

          cpx #$0018
          bne -

          rtl

          .databank 0

        rlUnitWindowUnknown90DF80 ; 90/DF80

          .al
          .xl
          .autsiz
          .databank ?

          lda wTemporaryDeploymentInfo,b
          sta wR1

          sep #$20

          lda #$00
          ldx #$0032

          -
          sta aUnitWindowUnknown7E454E,x

          dec x
          bne -

          rep #$20

          lda #$0001

          -
          sta wR0
          dec a
          asl a
          tax
          lda $7E44A0,x
          beq +

          sta wTemporaryDeploymentInfo,b

          jsl rlUnitWindowUnknown90E90C
          dec a
          tax

          lda wR0
          eor #-1
          inc a

          sep #$20

          sta aUnitWindowUnknown7E454E,x

          rep #$20

          lda wR0

          inc a

          cmp #$0019
          bne -

          +
          lda wR1
          sta wTemporaryDeploymentInfo,b

          rtl

          .databank 0

        rlUnitWindowUnknown90DFC8 ; 90/DFC8

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          phk
          plb

          .databank `*

          lda #0
          sta wUnitWindowCurrentPage
          sta wUnitWindowSortType
          sta wUnitWindowSortDirection
          sta wUnitWindowUnknown7E4543

          sep #$20

          lda #$00
          ldx #size(aUnitWindowUnknown7E4510)-1

          -
          sta aUnitWindowUnknown7E4510,x
          dec x
          bpl -

          lda #$00
          ldx #size(aUnitWindowUnknown7E454E)-1

          -
          sta aUnitWindowUnknown7E454E,x
          dec x
          bne -

          lda #0
          sta bUnitWindowActive

          rep #$20

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowUnknown90E004 ; 90/E004

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

          lda #$00
          sta bUnitWindowActive

          lda #$00
          ldx #size(aUnitWindowUnknown7E454E)-1

          -
          sta aUnitWindowUnknown7E454E,x
          dec x
          bne -

          rep #$20

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowUnknown90E021 ; 90/E021

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`aUnitWindowDeploymentSlots
          pha

          rep #$20

          plb

          .databank `aUnitWindowDeploymentSlots

          lda wUnitWindowType
          bit #$0001
          beq +

          jmp _End

          +
          lda wUnitWindowMaxRows
          dec a
          asl a
          tax

          _Loop
          lda aUnitWindowDeploymentSlots,x
          bne +

          jmp _Next

          +
          sta $7FAACE,x
          sta wTemporaryDeploymentInfo,b

          phx

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda #<>aSelectedCharacterBuffer
          sta wR0
          lda #-1
          sta wR17

          sep #$20

          lda #Player + 1
          sta aSelectedCharacterBuffer.DeploymentNumber,b

          rep #$20

          jsl rlActionStructSingleEntry

          lda #<>aActionStructUnit1
          sta wR1
          jsl rlCombineCharacterDataAndClassWeaponRanks

          pla

          pha

          lsr a
          tax
          sep #$20
          lda aActionStructUnit1.Strength
          sta aUnitWindowSlotsStrength,x
          lda aActionStructUnit1.Magic
          sta aUnitWindowSlotsMagic,x
          lda aActionStructUnit1.Skill
          sta aUnitWindowSlotsSkill,x
          lda aActionStructUnit1.Speed
          sta aUnitWindowSlotsSpeed,x
          lda aActionStructUnit1.Luck
          sta aUnitWindowSlotsLuck,x
          lda aActionStructUnit1.Defense
          sta aUnitWindowSlotsDefense,x
          lda aActionStructUnit1.Constitution
          sta aUnitWindowSlotsConstitution,x
          lda aActionStructUnit1.BattleMight
          sta aUnitWindowSlotsMight,x
          lda aActionStructUnit1.BattleHit
          sta aUnitWindowSlotsHit,x
          lda aActionStructUnit1.BattleAvoid
          sta aUnitWindowSlotsAvoid,x
          lda aActionStructUnit1.Skills1
          sta aUnitWindowSlotsSkills1,x
          lda aActionStructUnit1.Skills2
          sta aUnitWindowSlotsSkills2,x
          lda aActionStructUnit1.Skills3
          sta aUnitWindowSlotsSkills3,x
          lda aActionStructUnit1.SwordRank
          sta aUnitWindowSlotsSwordRank,x
          lda aActionStructUnit1.LanceRank
          sta aUnitWindowSlotsLanceRank,x
          lda aActionStructUnit1.AxeRank
          sta aUnitWindowSlotsAxeRank,x
          lda aActionStructUnit1.BowRank
          sta aUnitWindowSlotsBowRank,x
          lda aActionStructUnit1.StaffRank
          sta aUnitWindowSlotsStaffRank,x
          lda aActionStructUnit1.FireRank
          sta aUnitWindowSlotsFireRank,x
          lda aActionStructUnit1.ThunderRank
          sta aUnitWindowSlotsThunderRank,x
          lda aActionStructUnit1.WindRank
          sta aUnitWindowSlotsWindRank,x
          lda aActionStructUnit1.LightRank
          sta aUnitWindowSlotsLightRank,x
          lda aActionStructUnit1.DarkRank
          sta aUnitWindowSlotsDarkRank,x
          rep #$20
          plx

          _Next

          .rept size(word)
            dec x
          .endrept

          bmi _End
          jmp _Loop

          _End
          plp
          plb
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowSortSelectorCursorSprites .block ; 90/E12F
          .addr aUnitWindowSortSelectorCursorFrame0
          .addr aUnitWindowSortSelectorCursorFrame1
          .addr aUnitWindowSortSelectorCursorFrame2
          .addr aUnitWindowSortSelectorCursorFrame3
          .addr aUnitWindowSortSelectorCursorFrame4
          .addr aUnitWindowSortSelectorCursorFrame5
        .endblock

        aUnitWindowSortSelectorCursorFrame0 .structSpriteArray [[(  -4,  -12), $00, SpriteSmall, $00B, 3, 4, false, false], [(  -4,    8), $00, SpriteSmall, $00B, 3, 4, false, true]] ; 90/E13B
        aUnitWindowSortSelectorCursorFrame1 .structSpriteArray [[(  -4,    8), $00, SpriteSmall, $00A, 3, 4, false, true], [(  -4,  -12), $00, SpriteSmall, $00A, 3, 4, false, false]] ; 90/E147
        aUnitWindowSortSelectorCursorFrame2 .structSpriteArray [[(  -4,    8), $00, SpriteSmall, $00C, 3, 4, false, true], [(  -4,  -12), $00, SpriteSmall, $00C, 3, 4, false, false]] ; 90/E153
        aUnitWindowSortSelectorCursorFrame3 .structSpriteArray [[(  -4,    8), $00, SpriteSmall, $01A, 3, 4, false, true], [(  -4,  -12), $00, SpriteSmall, $01A, 3, 4, false, false]] ; 90/E15F
        aUnitWindowSortSelectorCursorFrame4 .structSpriteArray [[(  -4,    8), $00, SpriteSmall, $01B, 3, 4, false, true], [(  -4,  -12), $00, SpriteSmall, $01B, 3, 4, false, false]] ; 90/E16B
        aUnitWindowSortSelectorCursorFrame5 .structSpriteArray [[(  -4,    8), $00, SpriteSmall, $01C, 3, 4, false, true], [(  -4,  -12), $00, SpriteSmall, $01C, 3, 4, false, false]] ; 90/E177

        aUnitWindowSkillSortSlots .block ; 90/E183

          .word $3b46
          .word $3b44
          .word $3b0a
          .word $3b48
          .word $3b08
          .word $0000
          .word $0000
          .word $3b04
          .word $0000
          .word $0000
          .word $3b0e
          .word $3b22
          .word $3b24
          .word $3b06
          .word $3b0c
          .word $3b00
          .word $3b26
          .word $3b28
          .word $3b2a
          .word $3b42
          .word $3b40
          .word $3b08
          .word $3b08
          .word $3b08
          .word $3b08
          .word $3b08
          .word $3b08
          .word $3b08
          .word $3b08

        .endblock

        aUnitWindowFE4ItemIconBases .block ; 90/E1BD

          .word $0380
          .word $0382
          .word $0384
          .word $0386
          .word $0388
          .word $038a
          .word $038c
          .word $038e
          .word $03a0
          .word $03a2
          .word $03a4
          .word $03a6
          .word $03a8
          .word $03aa
          .word $03ac
          .word $03ae
          .word $03c0
          .word $03c2
          .word $03c4
          .word $03c6
          .word $03c8
          .word $03ca
          .word $03cc
          .word $03ce
          .word $03e0
          .word $03e2
          .word $03e4
          .word $03e6
          .word $03e8
          .word $03ea
          .word $03ec
          .word $03ee
          .word $0380
          .word $0382
          .word $0384
          .word $0386
          .word $0388
          .word $038a
          .word $038c
          .word $038e
          .word $03a0
          .word $03a2
          .word $03a4
          .word $03a6
          .word $03a8
          .word $03aa
          .word $03ac
          .word $03ae
          .word $03c0
          .word $03c2
          .word $03c4
          .word $03c6
          .word $03c8
          .word $03ca
          .word $03cc
          .word $03ce
          .word $03e0
          .word $03e2
          .word $03e4
          .word $03e6
          .word $03e8
          .word $03ea
          .word $03ec
          .word $03ee

        .endblock

      endData
      startCode

        rlUnitWindowToggleScrollArrows ; 90/E23D

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowScrollRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowScrollRows

          lda @l wUnitWindowScrollRows
          beq _Top

            lda #0
            jsl rlToggleUpwardsSpinningArrow
            bra +

          _Top
            lda #-1
            jsl rlToggleUpwardsSpinningArrow

          +
          lda @l wUnitWindowMaxRows
          sec
          sbc #10
          beq _Bottom
          blt _Bottom

          sec
          sbc @l wUnitWindowScrollRows
          beq _Bottom

            lda #0
            jsl rlToggleDownwardsSpinningArrow
            bra +

          _Bottom
            lda #-1
            jsl rlToggleDownwardsSpinningArrow

          +
          plp
          plb
          rtl

          .databank 0

        rlUnitWindowFE4RenderFlashingUnitSwapCursor ; 90/E283

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          phk
          plb

          .databank `*

          stz wR4
          stz wR5
          ldy #<>_Sprite
          jsl rlPushToOAMBuffer
          plp
          plb
          rtl

          endCode
          startData

            _Sprite .structSpriteArray [[( 2, 3), $21, SpriteLarge, $100, 2, 4, false, false]]

          endData
          startCode

          .databank 0

        rlUnitWindowUnknownRenderCursor90E29C ; 90/E29C

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          phk
          plb

          .databank `*

          stz wR4
          stz wR5
          ldy #<>_Sprite
          jsl rlPushToOAMBuffer
          plp
          plb
          rtl

          endCode
          startData

            _Sprite .structSpriteArray [[( 2, 3), $21, SpriteLarge, $100, 3, 4, false, false]]

          endData
          startCode

          .databank 0

        rlUnitWindowScrollMapToUnit ; 90/E2B5

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda @l wUnitWindowCurrentRow
          asl a
          tax
          lda @l aUnitWindowDeploymentSlots,x
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.X,b
          and #$00FF
          sta wR0
          lda aSelectedCharacterBuffer.Y,b
          and #$00FF
          sta wR1
          lda #8
          sta wR2
          lda #2
          sta wR3
          jsl $81B4AE

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowClose ; 90/E2F5

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlHideAllSprites

          lda #(`$809EF0)<<8
          sta aProcSystem.wInput0+size(byte),b
          lda #<>$809EF0
          sta aProcSystem.wInput0,b

          lda wUnitWindowType
          bit #$0002 ; TODO: unit window types
          beq +

            lda #(`$80A1E0)<<8
            sta aProcSystem.wInput0+size(byte),b
            lda #<>$80A1E0
            sta aProcSystem.wInput0,b

          +
          phx

          lda #(`$82A272)<<8
          sta lR44+size(byte)
          lda #<>$82A272
          sta lR44
          jsl rlProcEngineCreateProc

          plx
          rtl

          .databank 0

        rlUnitWindowGetUnitEquippedWeapon ; 90/E32B

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          phy
          phx

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot
          jsl rlGetEquippableItemInventoryOffset

          plx
          ply

          lda aItemDataBuffer.DisplayedWeapon,b
          and #$00FF
          sta wTemporaryUnitWindowItem,b
          beq +

          plp
          plb
          clc
          rtl

          +
          plp
          plb
          sec
          rtl

          .databank 0

        rlUnitWindowUnknown90E35E ; 90/E35E

          .al
          .xl
          .autsiz
          .databank ?

          stx wR0
          sty wR1
          sty wR3
          sta wR2

          _Loop
            lda #$00FF
            sta aBG3TilemapBuffer,x

            .rept size(word)
              inc x
            .endrept

            dec wR1
            bne _Loop

              lda wR0
              clc
              adc #(32 * size(word))
              sta wR0

              tax
              lda wR3
              sta wR1

              dec wR2
              bne _Loop

          rtl

          .databank 0

        rlUnitWindowGetUnitClassName ; 90/E385

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          jsl rlGetClassNamePointer

          lda lR18+size(byte)
          sta lTemporaryNamePointer+size(byte),b
          lda lR18
          sta lTemporaryNamePointer,b

          plp
          plb
          rtl

          .databank 0

      endCode
      startMenuText

        .enc "SJIS"

        menutextUnitWindowDefaultClassName .text "ソシアルナイト\n" ; 90/E3B4

      endMenuText
      startCode

        rlUnitWindowGetUnitEquippedWeaponName ; 90/E3C4

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot
          jsl rlGetEquippableItemInventoryOffset

          lda aItemDataBuffer.DisplayedWeapon,b
          and #$00FF
          jsl rlGetItemNamePointer

          lda lR18+size(byte)
          sta lTemporaryNamePointer+size(byte),b
          lda lR18
          sta lTemporaryNamePointer,b

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetUnitName ; 90/E3F7

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.Character,b
          pha
          jsl rlGetCharacterNamePointer

          lda lR18+size(byte)
          sta lTemporaryNamePointer+size(byte),b
          lda lR18
          sta lTemporaryNamePointer,b

          pla

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetUnitExperience ; 90/E425

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.Experience,b
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetUnitCurrentHP ; 90/E44A

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.CurrentHP,b
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetUnitMaxHP ; 90/E46F

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.MaxHP,b
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetUnitStrength ; 90/E494

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax
          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          dec x
          dec x
          bpl -

          ldx #0

          +
          txa
          lsr a
          tax
          lda aUnitWindowSlotsStrength,x
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          _Unknown

          rtl

          .databank 0

        rlUnitWindowGetUnitMagic ; 90/E4C6

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax
          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          dec x
          dec x
          bpl -

          ldx #0

          +
          txa
          lsr a
          tax
          lda aUnitWindowSlotsMagic,x
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          _Unknown

          rtl

          .databank 0

        rlUnitWindowGetUnitSkill ; 90/E4F8

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax
          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          dec x
          dec x
          bpl -

          ldx #0

          +
          txa
          lsr a
          tax
          lda aUnitWindowSlotsSkill,x
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          _Unknown

          rtl

          .databank 0

        rlUnitWindowGetUnitSpeed ; 90/E52A

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax
          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          dec x
          dec x
          bpl -

          ldx #0

          +
          txa
          lsr a
          tax
          lda aUnitWindowSlotsSpeed,x
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          _Unknown

          rtl

          .databank 0

        rlUnitWindowGetUnitLuck ; 90/E55C

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax
          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          dec x
          dec x
          bpl -

          ldx #0

          +
          txa
          lsr a
          tax
          lda aUnitWindowSlotsLuck,x
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          _Unknown

          rtl

          .databank 0

        rlUnitWindowGetUnitDefense ; 90/E58E

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax
          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          dec x
          dec x
          bpl -

          ldx #0

          +
          txa
          lsr a
          tax
          lda aUnitWindowSlotsDefense,x
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          _Unknown

          rtl

          .databank 0

        rlUnitWindowGetUnitConstitution ; 90/E5C0

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax
          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          dec x
          dec x
          bpl -

          ldx #0

          +
          txa
          lsr a
          tax
          lda aUnitWindowSlotsConstitution,x
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          _Unknown

          rtl

          .databank 0

        rlUnitWindowGetUnitFatigue ; 90/E5F2

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.Fatigue,b
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetUnitMove ; 90/E617

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda #<>aSelectedCharacterBuffer
          sta wR14
          jsl rlGetEffectiveMove
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetUnitCharacter ; 90/E63F

          .al
          .xl
          .autsiz
          .databank ?

          ; Bugged, only gets lower byte

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.Character,b
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowUnknown90E664 ; 90/E664

          .al
          .xl
          .autsiz
          .databank ?

          lda #1
          rtl

          .databank 0

        rlUnitWindowGetUnitRescueeCharacterID ; 90/E668

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlUnitWindowGetUnitRescue
          bcc +

            lda aBurstWindowCharacterBuffer.Character,b
            rtl

          +
          lda #None
          rtl

          .databank 0

        rlUnitWindowGetUnitRescueeDeploymentNumber ; 90/E676

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlUnitWindowGetUnitRescue
          bcc +

            lda aBurstWindowCharacterBuffer.DeploymentNumber,b
            and #$00FF
            rtl

          +
          lda #None
          rtl

          .databank 0

        rlUnitWindowGetUnitRescue ; 90/E687

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.Rescue,b
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb

          tax
          lda aSelectedCharacterBuffer.UnitState,b
          bit #UnitStateRescuing
          beq +

            txa
            sta wR0
            lda #<>aBurstWindowCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            sec
            rtl

          +
          clc
          rtl

          .databank 0

        rlUnitWindowGetUnitStatus ; 90/E6C4

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.Status,b
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetUnitStatusString ; 90/E6E9

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlUnitWindowGetUnitStatus
          jsl rlGetStatusString
          rtl

          .databank 0

        rlUnitWindowUnknownGetStatusString ; 90/E6F2

          .al
          .xl
          .autsiz
          .databank ?

          asl a
          tax
          lda _StatusTable,x
          sta lR18
          sep #$20
          lda #`_StatusTable
          sta lR18+size(word)
          rep #$20
          rtl

          endCode
          startData

            _StatusTable .block ; 90/E703
              .addr menutextUnitWindowStatusNone
              .addr menutextUnitWindowStatusSleep
              .addr menutextUnitWindowStatusBerserk
              .addr menutextUnitWindowStatusPoison
              .addr menutextUnitWindowStatusSilence
              .addr menutextUnitWindowStatusPetrify
            .endblock

          endData
          startCode

          .databank 0

      endCode
      startMenuText

        .enc "SJIS"

        menutextUnitWindowStatusNone    .text "ーーー　　\n" ; 90/E70F
        menutextUnitWindowStatusSleep   .text "スリープ　\n" ; 90/E71B
        menutextUnitWindowStatusBerserk .text "バサーク　\n" ; 90/E727
        menutextUnitWindowStatusPoison  .text "どく　　　\n" ; 90/E733
        menutextUnitWindowStatusSilence .text "ちんもく　\n" ; 90/E73F
        menutextUnitWindowStatusPetrify .text "ストーン　\n" ; 90/E74B

      endMenuText
      startCode

        rlUnitWindowGetUnitLevel ; 90/E757

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.Level,b
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetUnitClass ; 90/E77C

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda wTemporaryDeploymentInfo,b
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetUnitRescueeName ; 90/E7A1

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlUnitWindowGetUnitRescueeDeploymentNumber
          ora #0
          beq _NoRescuee

          sta wR0
          lda #<>aBurstWindowCharacterBuffer
          sta wR1
          jsl rlCopyCharacterDataToBufferByDeploymentNumber

          lda aBurstWindowCharacterBuffer.Character,b
          jsl rlGetCharacterNamePointer

          bra +

          _NoRescuee
          lda #(`menutextUnitWindowNoTravelerString)<<8
          sta lR18+size(byte)
          lda #<>menutextUnitWindowNoTravelerString
          sta lR18

          +
          rtl

          .databank 0

      endCode
      startMenuText

        .enc "SJIS"

        menutextUnitWindowNoTravelerString .text "ーーーーー\n" ; 90/E7C9

      endMenuText
      startCode

        rlUnitWindowGetUnitHit ; 90/E7D5

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax
          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          dec x
          dec x
          bpl -

          ldx #0

          +
          txa
          lsr a
          tax
          lda aUnitWindowSlotsHit,x
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetUnitAvoid ; 90/E806

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax
          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          dec x
          dec x
          bpl -

          ldx #0

          +
          txa
          lsr a
          tax
          lda aUnitWindowSlotsAvoid,x
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetUnitMight ; 90/E837

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax
          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          dec x
          dec x
          bpl -

          ldx #0

          +
          txa
          lsr a
          tax
          lda aUnitWindowSlotsMight,x
          and #$00FF
          sta lR18
          stz lR18+size(word)

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowFE4GetUnitState ; 90/E868

          .al
          .xl
          .autsiz
          .databank ?

          lda #$8000
          rtl

          .databank 0

        rlUnitWindowFE4GetUnitStatus ; 90/E86C

          .al
          .xl
          .autsiz
          .databank ?

          lda #$0000
          rtl

          .databank 0

        rlUnitWindowGetUnitWeaponRankByType ; 90/E870

          .al
          .xl
          .autsiz
          .databank ?

          phx
          phy

          asl a
          tax
          lda _RankOffsets,x
          sta wR0

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax
          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          .rept size(word)
            dec x
          .endrept

          bpl -

          ldx #$0000

          +
          txa
          lsr a
          tax

          plp
          plb

          txa
          clc
          adc wR0
          tax
          lda aUnitWindowSlotsSwordRank & $FF0000,x
          and #$00FF

          ply
          plx
          rtl

          endCode
          startData

            _RankOffsets .block ; 90/E8AE
              .word <>aUnitWindowSlotsSwordRank
              .word <>aUnitWindowSlotsLanceRank
              .word <>aUnitWindowSlotsAxeRank
              .word <>aUnitWindowSlotsBowRank
              .word <>aUnitWindowSlotsStaffRank
              .word <>aUnitWindowSlotsFireRank
              .word <>aUnitWindowSlotsThunderRank
              .word <>aUnitWindowSlotsWindRank
              .word <>aUnitWindowSlotsLightRank
              .word <>aUnitWindowSlotsDarkRank
            .endblock

          endData
          startCode

          .databank 0

        rlUnitWindowUnknown90E8C2 ; 90/E8C2

          .al
          .xl
          .autsiz
          .databank ?

          lda #$0000
          sec
          rtl

          .databank 0

        rlUnitWindowUnknown90E8C7 ; 90/E8C7

          .al
          .xl
          .autsiz
          .databank ?

          stz wTemporaryDeploymentInfo+size(byte),b

          lda #1
          sta wTemporaryDeploymentInfo,b

          rtl

          .databank 0

        rlUnitWindowUnknownGetPlayerUnitCount ; 90/E8D1

          .al
          .xl
          .autsiz
          .databank ?

          sta $02

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda $02

          lda #0
          sta @l wUnitWindowMaxRows

          lda #(`_Counter)<<8
          sta lR25+size(byte)
          lda #<>_Counter
          sta lR25
          lda #Player
          jsl rlRunRoutineForAllUnitsInAllegiance

          lda @l wUnitWindowMaxRows

          plp
          plb
          rtl

          .databank 0

          _Counter .block ; 90/E8FE

            .al
            .xl
            .autsiz
            .databank `wUnitWindowMaxRows

            lda @l wUnitWindowMaxRows
            inc a
            sta @l wUnitWindowMaxRows
            rtl

            .databank 0

          .endblock

        rlUnitWindowFE4GetUnitSpriteInfo ; 90/E908

          .al
          .xl
          .autsiz
          .databank ?

          lda #$0001
          rtl

          .databank 0

        rlUnitWindowUnknown90E90C ; 90/E90C

          .al
          .xl
          .autsiz
          .databank ?

          lda #$0001
          clc
          rtl

          .databank 0

        rlUnitWindowUnknown90E911 ; 90/E911

          .al
          .xl
          .autsiz
          .databank ?

          lda #$0001
          sta wTemporaryUnitWindowItem,b

          lda #$0001
          sta $7E4545

          lda #$0001
          rtl

          .databank 0

        rlUnitWindowUnknown90E922 ; 90/E922

          .al
          .xl
          .autsiz
          .databank ?

          lda #$0000
          sta $7E4545

          lda #$0001
          clc
          rtl

          .databank 0

        rlUnitWindowGetUnitSkillCount ; 90/E92E

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          _SavedRegisters := [lR18, lR18+size(byte), wR0, wR1, wR15]

          .for _Register in _SavedRegisters

            lda _Register
            pha

          .endfor

          phx
          phy

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax
          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          .rept size(word)
            dec x
          .endrept

          bpl -

          ldx #$0000

          +
          txa
          lsr a
          tax

          sep #$20

          lda aUnitWindowSlotsSkills1,x
          sta lR18
          lda aUnitWindowSlotsSkills2,x
          sta lR18+size(byte)
          lda aUnitWindowSlotsSkills3,x
          sta lR18+size(word)

          rep #$20

          jsr rsUnitWindowGetUnitSkillList

          ply
          plx

          .for _Register in iter.reversed(_SavedRegisters)

            pla
            sta _Register

          .endfor

          plp
          plb
          rtl

          .databank 0

        structUnitWindowSkillCountTarget .struct Offset, Skills1, Skills2, Skills3
          .if (\Skills1 === ?)
            Offset .byte ?
            Skills1 .byte ?
            Skills2 .byte ?
            Skills3 .byte ?
          .else
            .byte \Offset
            .byte ([None] .. \Skills1) | ...
            .byte ([None] .. \Skills2) | ...
            .byte ([None] .. \Skills3) | ...
          .endif
        .endstruct

        rsUnitWindowGetUnitSkillList ; 90/E98F

          .al
          .xl
          .autsiz
          .databank `wUnitWindowMaxRows

          phx
          phy

          sep #$20

          ldx #$0014

          -
          stz aTemporaryUnitWindowSkillList,b,x

          dec x
          bpl -

          rep #$20

          stz wTemporaryUnitWindowSkillCounter,b

          ldx #0

          -
          lda _SkillTargets+structUnitWindowSkillCountTarget.Offset,x
          and #$00FF

          cmp #narrow(-1, size(byte))
          beq _End

          tay
          lda _SkillTargets+structUnitWindowSkillCountTarget.Skills1,x
          and lR18
          bne _Skill

          lda _SkillTargets+structUnitWindowSkillCountTarget.Skills2,x
          and lR18+size(byte)
          beq _NoSkill

          _Skill
          sep #$20

          lda #$01
          sta aTemporaryUnitWindowSkillList,b,y

          rep #$20

          inc wTemporaryUnitWindowSkillCounter,b
          bra _Next

          _NoSkill
          sep #$20

          lda #$00
          sta aTemporaryUnitWindowSkillList,b,y

          rep #$20

          _Next
          inc x
          inc x
          inc x
          inc x
          bra -

          _End
          ply
          plx
          rts

          .databank 0

          endCode
          startData

            _SkillTargets .block ; 90/E9E1
              .structUnitWindowSkillCountTarget $07, [], [Skill2Adept], []
              .structUnitWindowSkillCountTarget $0A, [], [Skill2Miracle], []
              .structUnitWindowSkillCountTarget $0B, [], [Skill2Vantage], []
              .structUnitWindowSkillCountTarget $0C, [], [Skill2Assail], []
              .structUnitWindowSkillCountTarget $0D, [], [Skill2Pavise], []
              .structUnitWindowSkillCountTarget $0E, [], [Skill2Nihil], []
              .structUnitWindowSkillCountTarget $0F, [], [], [Skill3Wrath]
              .structUnitWindowSkillCountTarget $10, [], [], [Skill3Astra]
              .structUnitWindowSkillCountTarget $11, [], [], [Skill3Luna]
              .structUnitWindowSkillCountTarget $12, [], [], [Skill3Sol]
              .structUnitWindowSkillCountTarget $13, [], [], [Skill3Paragon]
              .structUnitWindowSkillCountTarget $14, [Skill1Renewal], [], []
              .structUnitWindowSkillCountTarget $00, [Skill1Dance], [], []
              .structUnitWindowSkillCountTarget $01, [Skill1Steal], [], []
              .structUnitWindowSkillCountTarget $02, [Skill1Immortal], [], []
              .structUnitWindowSkillCountTarget $03, [Skill1Bargain], [], []
              .structUnitWindowSkillCountTarget $04, [], [Skill2Charm], []
              .sint -1
            .endblock

          endData
          startCode

        rlUnitWindowUnknown90EA27 ; 90/EA27

          .al
          .xl
          .autsiz
          .databank ?

          lda #0
          sta $7E4547

          lda #1
          sta $7E4549

          clc
          rtl

          .databank 0

        rlUnitWindowFE4GetUnitSlot ; 90/EA37

          .al
          .xl
          .autsiz
          .databank ?

          rtl

          .databank 0

        rlUnitWindowUnknown90EA38 ; 90/EA38

          .al
          .xl
          .autsiz
          .databank ?

          lda #<>$809DBA
          sta aProcSystem.wInput0,b

          lda #(`$82A272)<<8
          sta lR44+size(byte)
          lda #<>$82A272
          sta lR44
          jsl rlProcEngineCreateProc

      endCode
      startData

        aUnitWindowFE4NormalMapSpriteTileIndices .block ; 90/EA4C

          .for _Y, _X in iter.product([range(6), range(8)])

            .word 2 * ((_Y * 16) + _X)

          .endfor

        .endblock

        aUnitWindowFE4UnknownMapSpriteTileIndices1 .block ; 90/EAAC

          .for _Y, _X in iter.product([range(6), range(0, 4 * 2, 2)])

            .word 2 * ((_Y * 16) + _X)

          .endfor

        .endblock

        aUnitWindowFE4UnknownMapSpriteTileIndices2 .block ; 90/EADC

          .for _I, _X in iter.product([range(6), range(8)])

            .word 2 * _X

          .endfor

        .endblock

        aUnitWindowFE4TallMapSpriteTileIndices .block ; 90/EB3C

          .for _Y, _X in iter.product([range(6), range(0, 4 * 2, 2)])

            .word 2 * ((_Y * 16) + _X)

          .endfor

        .endblock

      endData
      startCode

        rlUnitWindowFE4DrawNumberMenuText ; 90/EB6C

          .al
          .xl
          .autsiz
          .databank ?

          ; Temporary variables

            _Number := wR0

            _OnesPlace         := wR0
            _TensPlace         := wR1
            _HundredsPlace     := wR2
            _ThousandsPlace    := wR3
            _TenThousandsPlace := wR4

            _BaseTile        := wR5
            _Width           := wR6
            _WidthOffset     := wR7
            _UsedWidth       := wR8
            _UsedWidthOffset := wR9

          phb
          php

          phk
          plb

          .databank `*

          phx

          phk
          plb

          .databank `*

          sta _Number

          stz _TensPlace
          stz _HundredsPlace
          stz _ThousandsPlace
          stz _TenThousandsPlace

          ldx #6

          -
          lda _Number
          sec
          sbc _Places,x
          bcc +

          sta _Number

          inc _TensPlace,x
          bra -

          +
          dec x
          dec x

          bpl -

          lda #5

          ldx _TenThousandsPlace
          bne +

          dec a
          ldx _ThousandsPlace
          bne +

          dec a
          ldx _HundredsPlace
          bne +

          dec a
          ldx _TensPlace
          bne +

          dec a

          +
          sta _UsedWidth

          asl a
          sta _UsedWidthOffset

          lda _Width
          beq _NoPadding

          asl a
          sta _WidthOffset

          tay

          plx
          txa
          clc
          adc _DigitOffsets,y
          tax

          ldy #0

          -
          lda _Number,b,y
          clc
          adc _BaseTile

          pha

          sta aBG3TilemapBuffer,x

          pla
          clc
          adc #16
          sta aBG3TilemapBuffer+(32 * size(word)),x

          dec x
          dec x

          inc y
          inc y

          cpy _WidthOffset
          beq _EndPad

          cpy _UsedWidthOffset
          bne -

          -
          lda #TilemapEntry(255, 0, false, false, false)
          sta aBG3TilemapBuffer,x
          sta aBG3TilemapBuffer+(32 * size(word)),x

          dec x
          dec x

          inc y
          inc y

          cpy _WidthOffset
          bne -

          lda _UsedWidth

          _End
          plp
          plb
          rtl

          _EndPad
          lda _UsedWidth
          cmp _Width
          beq _End

          lda #0

          plp
          plb
          rtl

          _NoPadding
          plx
          ldy _UsedWidthOffset

          -
          lda _Number-size(word),b,y
          clc
          adc _BaseTile
          pha
          sta aBG3TilemapBuffer,x

          pla
          clc
          adc #16
          sta aBG3TilemapBuffer+(32 * size(word)),x

          inc x
          inc x
          dec y
          dec y
          bne -

          lda _UsedWidth
          bra _End

          .databank 0

          endCode
          startData

            _DigitOffsets .block ; 90/EC25

              .word 0
              .word size(word) * range(5)

            .endblock

            _Places .block ; 90/EC31

              .word pow(10, range(1, 5))

            .endblock

          endData
          startCode

        rlUnitWindowUnknown90EC39 ; 90/EC39

          .al
          .xl
          .autsiz
          .databank ?

          lda wR2
          ora wR1
          sta wR2

          -
            lda wR2
            sta aBG3TilemapBuffer,x
            lda wR2
            clc
            adc #16
            sta aBG3TilemapBuffer+(32 * size(word)),x

            .rept size(word)
              inc x
            .endrept

            inc wR2
            dec wR0

            bne -

          rtl

          .databank 0

      endCode
      startData

        aUnitWindowUnknown90EC58 .fill $1D0, $01 ; 90/EC58

      endData
      startCode

        rlUnitWindowFE4RenderAllMapSprites ; 90/EE28

          .al
          .xl
          .autsiz
          .databank ?

          phb

          lda wUnitWindowFE4CurrentLine
          dec a
          asl a
          tax
          lda aUnitWindowDeploymentSlots,x
          jsr rsUnitWindowRenderMapSprite

          ldx #size(aUnitWindowDeploymentSlots) - (2 * size(word))

          -
          lda aUnitWindowDeploymentSlots,x
          beq +

            jsr rsUnitWindowRenderMapSprite

          +

          .rept size(word)
            dec x
          .endrept

          bpl -

          plb
          rtl

          .databank 0

        rlUnitWindowRenderAllMapSprites ; 90/EE49

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowScrollRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowScrollRows

          lda wUnitWindowScrollRows
          clc
          adc #11
          cmp @l wUnitWindowMaxRows
          bcc +

          lda @l wUnitWindowMaxRows
          dec a

          +
          asl a
          tax

          -
          jsr rsUnitWindowRenderMapSpriteBySlot

          dec x
          dec x

          txa

          sec
          sbc @l wUnitWindowScrollRows
          sec
          sbc @l wUnitWindowScrollRows
          bpl -

          plp
          plb
          rtl

          .databank 0

        rsUnitWindowRenderMapSpriteBySlot ; 90/EE7C

          .al
          .xl
          .autsiz
          .databank ?

          lda aUnitWindowDeploymentSlots,x
          sta wR0
          txa
          lsr a
          sta wR15
          jsr rsUnitWindowRenderMapSprite
          rts

          .databank 0

        rsUnitWindowRenderMapSprite ; 90/EE8A

          .al
          .xl
          .autsiz
          .databank ?

          phx

          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot

          lda aSelectedCharacterBuffer.SpriteInfo2,b
          sta wR4

          lda aSelectedCharacterBuffer.SpriteInfo1,b
          and #$00FF

          bit #$0080
          bne _Tall

          ldy #<>_NormalSprite
          bra _Continue

          _Tall
          ldy #<>_TallSprite
          lda wUnitWindowScrollPixels
          bit #$000F
          bne _Continue

          lda wUnitWindowScrollRows
          cmp wR15
          bne _Continue

          ldy #<>_OffscreenTallSprite

          _Continue
          lda wR15
          asl a
          asl a
          asl a
          asl a

          clc
          adc #7 * 8

          sec
          sbc wUnitWindowScrollPixels

          sta wR1

          lda #$0010
          sta wR0

          jsr rsUnitWindowGetMapSpritePalette

          phb

          sep #$20

          lda #`_NormalSprite
          pha

          rep #$20

          plb

          .databank `_NormalSprite

          jsl rlPushToOAMBuffer

          plb
          plx
          rts

          .databank 0

          endCode
          startData

            _NormalSprite        .structSpriteArray [[(   0,    0), $21, SpriteLarge, $000, 2, 0, false, false]] ; 90/EEE9
            _TallSprite          .structSpriteArray [[(   0,    0), $21, SpriteLarge, $000, 2, 0, false, false], [(   0,  -16), $21, SpriteLarge, $002, 2, 0, false, false]] ; 90/EEF0
            _OffscreenTallSprite .structSpriteArray [[(   0,    0), $21, SpriteLarge, $000, 2, 0, false, false], [(   0,  -16), $21, SpriteLarge, $002, 3, 0, false, false]] ; 90/EEFC

          endData
          startCode

        rsUnitWindowGetMapSpritePalette ; 90/EF08

          .al
          .xl
          .autsiz
          .databank ?

          lda aSelectedCharacterBuffer.UnitState,b
          bit #UnitStateGrayed
          bne _Grayed

          lda aSelectedCharacterBuffer.Status,b
          and #$000F

          cmp #StatusPetrify
          beq _Grayed

            lda wUnitWindowAllegiance
            asl a
            asl a
            asl a
            bra +

          _Grayed
            lda #$0003
            xba
            asl a

          +
          sta wR5

          rts

          .databank 0

        rlUnitWindowGetDeploymentSlotsFromPrepPool ; 90/EF2C

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`$7EB603
          pha

          rep #$20

          plb

          .databank `$7EB603

          jsl rlUnitWindowClearDeploymentSlots

          ldx #0

          -
          lda $7EB603,x
          beq +

          sta @l aUnitWindowDeploymentSlots,x

          inc x
          inc x

          cpx #(size(aUnitWindowDeploymentSlots) - size(word))
          bne -

          +
          txa
          lsr a
          sta @l wUnitWindowMaxRows

          sec
          sbc #10
          bpl +

          lda #0

          +
          sta wUnitWindowCanScrollDownFlag

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowGetPlayerDeploymentSlots ; 90/EF63

          .al
          .xl
          .autsiz
          .databank ?

          lda #Player
          sta wR0
          jsl rlUnitWindowGetDeploymentSlotsByAllegiance
          rtl

          .databank 0

        rlUnitWindowClearDeploymentSlots ; 90/EF6D

          .al
          .xl
          .autsiz
          .databank ?

          ldx #size(aUnitWindowDeploymentSlots) - size(word)

          -
            lda #0
            sta aUnitWindowDeploymentSlots,x

            .rept size(word)
              dec x
            .endrept

            bpl -

          rtl

          .databank 0

        rlUnitWindowGetDeploymentSlotsByAllegiance ; 90/EF7C

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          jsl rlUnitWindowClearDeploymentSlots

          lda #0
          sta wR15

          lda #(`_rlUnitWindowSetSlotIfAlive)<<8
          sta lR25+size(byte)
          lda #<>_rlUnitWindowSetSlotIfAlive
          sta lR25
          lda wUnitWindowAllegiance
          jsl rlRunRoutineForAllUnitsInAllegiance

          lda wR15
          lsr a
          sta @l wUnitWindowMaxRows

          sec
          sbc #10
          bpl +

          lda #0

          +
          sta wUnitWindowCanScrollDownFlag

          plp
          plb
          rtl

          .databank 0

          _rlUnitWindowSetSlotIfAlive ; 90/EFB8

            .al
            .xl
            .autsiz
            .databank $7E

            lda aTargetingCharacterBuffer.UnitState,b
            bit #(UnitStateDead | UnitStateUnknown1 | UnitStateDisabled | UnitStateCaptured)
            bne +

            lda aTargetingCharacterBuffer.DeploymentSlot,b
            ldx wR15
            cpx #size(aUnitWindowDeploymentSlots) - size(word)
            beq +

              sta @l aUnitWindowDeploymentSlots,x

              .rept size(word)
                inc wR15
              .endrept

            +
            rtl

            .databank 0

      endCode
      startProcs

        procUnitWindowUnknown90EFD3 .structProcInfo "ss", None, None, aProcUnitWindowUnknown90EFD3Code ; 90/EFD3

        aProcUnitWindowUnknown90EFD3Code .block ; 90/EFDB

          PROC_CALL $90BCE9
          PROC_YIELD 1
          PROC_CALL $90F029
          PROC_YIELD 1
          PROC_END

        .endblock

        procUnitWindowUnknown90EFEB .structProcInfo "ss", None, None, aProcUnitWindowUnknown90EFEBCode ; 90/EFEB

        aProcUnitWindowUnknown90EFEBCode .block ; 90/EFF3

          PROC_YIELD 2
          PROC_CALL $90F029
          PROC_YIELD 1
          PROC_END

        .endblock

        procUnitWindowUnknown90EFFE .structProcInfo "cs", None, None, aProcUnitWindowUnknown90EFFECode ; 90/EFFE

        aProcUnitWindowUnknown90EFFECode .block ; 90/F006

          PROC_CALL $90F067
          PROC_YIELD 1
          PROC_CALL $90BCE9
          PROC_YIELD 1
          PROC_END

        .endblock

        procUnitWindowUnknown90F016 .structProcInfo "ss", None, None, aProcUnitWindowUnknown90F016Code ; 90/F016

        aProcUnitWindowUnknown90F016Code .block ; 90/F01E

          PROC_YIELD 1
          PROC_CALL $90F067
          PROC_YIELD 1
          PROC_END

        .endblock

      endProcs
      startCode

        rlUnitWindowUnknown90F029 ; 90/F029

          .al
          .xl
          .autsiz
          .databank ?

          lda #(`$7EAB05)<<8
          sta lR18+size(byte)
          lda #<>$7EAB05
          sta lR18
          lda #(`aBG1TilemapBuffer)<<8
          sta lR19+size(byte)
          lda #<>aBG1TilemapBuffer
          sta lR19
          lda #10
          sta wR0
          lda #7
          sta wR1
          lda #21
          sta wR2
          lda wUnitWindowMaxRows
          beq +

          asl a
          sta wR3
          jsl $8E8D30
          jsl rlDMAByStruct

          .structDMAToVRAM $7EC93C, $0C00, VMAIN_Setting(true), $91C0

          +
          rtl

          .databank 0

        rlUnitWindowUnknown90F067 ; 90/F067

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda #$01D4
          sta wR0

          lda @l wUnitWindowMaxRows
          bne +

            jmp _F11F

          +
          dec a
          xba
          lsr a
          tax

          -
          lda #$002F

          .for _j in range(2)

            .for _i in range(21)

              sta $7EC950+(((_j * 32) + _i) * size(word)),x

            .endfor

          .endfor

          txa
          sec
          sbc #64 * size(word)

          tax
          bmi +

          jmp -

          +
          jsl rlDMAByStruct

          .structDMAToVRAM $7EC93C, $0C00, VMAIN_Setting(true), $91C0

          plp
          plb
          rtl

          _F11F

          stz aProcSystem.aHeaderSleepTimer,b,x
          jsl rlProcEngineFreeProc
          rtl

          .databank 0

      endCode
      startProcs

        procUnitWindowCloseToInventory .structProcInfo "xx", None, None, aProcUnitWindowCloseToInventoryCode ; 90/F127

        aProcUnitWindowCloseToInventoryCode .block ; 90/F12F

          PROC_YIELD 1
          PROC_CALL rlUnitWindowQueueInventoryOpen
          PROC_END

        .endblock

      endProcs
      startCode

        rlUnitWindowQueueInventoryOpen ; 90/F138

          .al
          .xl
          .autsiz
          .databank ?

          lda wUnitWindowCurrentRow
          asl a
          tax
          lda aUnitWindowDeploymentSlots,x
          sta wR0

          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlWriteCharacterBufferDeploymentInfo

          lda aSelectedCharacterBuffer.DeploymentNumber,b
          and #$00FF
          jsl $80BC41
          jsr rsUnitWindowSetMainLoopUpdaterCallback
          rtl

          .databank 0

        rsUnitWindowSetMainLoopUpdaterCallback ; 90/F15B

          .al
          .xl
          .autsiz
          .databank ?

          lda wPrepScreenFlag,b
          bne _Prep

            lda #(`rlUnitWindowSetMainLoopUpdaterFromMapUnit)<<8
            sta lUnknown7EA4EC+size(byte)
            lda #<>rlUnitWindowSetMainLoopUpdaterFromMapUnit
            sta lUnknown7EA4EC

            bra _End

          _Prep
            lda #(`rlUnitWindowSetMainLoopUpdaterFromPrepUnit)<<8
            sta lUnknown7EA4EC+size(byte)
            lda #<>rlUnitWindowSetMainLoopUpdaterFromPrepUnit
            sta lUnknown7EA4EC

          _End
          rts

          .databank 0

      endCode
      startProcs

        procUnitWindowCloseToMapFromPrep .structProcInfo "xx", None, None, aProcUnitWindowCloseToMapFromPrepCode ; 90/F17F

        aProcUnitWindowCloseToMapFromPrepCode .block ; 90/F187

          PROC_YIELD 1
          PROC_CALL rlUnitWindowCloseToMapFromPrep
          PROC_END

        .endblock

      endProcs
      startCode

        rlUnitWindowCloseToMapFromPrep ; 90/F190

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlUnitWindowClose
          rtl

          .databank 0

      endCode
      startProcs

        procUnitWindowCloseToMapFromMap .structProcInfo "xx", None, None, aProcUnitWindowCloseToMapFromMapCode ; 90/F195

        aProcUnitWindowCloseToMapFromMapCode .block ; 90/F19D

          PROC_YIELD 1
          PROC_CALL rlUnitWindowCloseToMapFromMap
          PROC_END

        .endblock

      endProcs
      startCode

        rlUnitWindowCloseToMapFromMap ; 90/F1A6

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlUnitWindowScrollMapToUnit
          jsl rlUnitWindowClose
          rtl

          .databank 0

        rlUnitWindowCheckForUnknownProcs ; 90/F1AF

          .al
          .xl
          .autsiz
          .databank ?

          .for _Proc in [procUnitWindowUnknown90EFD3, procUnitWindowUnknown90EFEB, procUnitWindowUnknown90EFFE, procUnitWindowUnknown90F016]

            lda #(`_Proc)<<8
            sta lR44+size(byte)
            lda #<>_Proc
            sta lR44
            jsl rlProcEngineFindProc
            bcs _Found

          .endfor

          clc
          rtl

          _Found
          sec
          rtl

          .databank 0

      endCode

      .endwith ; UnitWindowConfig

    .endsection UnitWindow90Section

    .section UnitWindow9ASection

      .with UnitWindowConfig

      startCode

        rlUnitWindowSetDefaults ; 9A/EC8D

          .al
          .xl
          .autsiz
          .databank ?

          lda bUnitWindowActive
          and #$00FF
          bne +

          lda #$0000
          sta wUnitWindowCurrentColumn
          bra _ECA8

          +
          lda wUnitWindowType
          bit #$0003
          bne _ECBD

          _ECA8
          lda #$0000
          sta wUnitWindowScrollPixels

          lda #$0000
          sta wUnitWindowScrollRows

          lda #$0000
          sta wUnitWindowCurrentRow

          _ECBD
          lda #$0000
          sta $7EA939

          sep #$20

          lda #$01
          sta bUnitWindowActive

          rep #$20

          rtl

          .databank 0

      endCode
      startProcs

        procUnitWindow .block ; 9A/ECCF

          .structProcInfo "xx", rlProcUnitWindowInit, rlProcUnitWindowOnCycle, None

        .endblock

        rlProcUnitWindowInit ; 9A/ECD7

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`aBG3TilemapBuffer
          pha

          rep #$20

          plb

          .databank `aBG3TilemapBuffer

          lda #(`aUnitWindowBG3HOFSHDMAInfo)<<8
          sta lR44+size(byte)
          lda #<>aUnitWindowBG3HOFSHDMAInfo
          sta lR44
          jsl rlHDMAEngineCreateEntry

          lda #(`aUnitWindowBG1HOFSHDMAInfo)<<8
          sta lR44+size(byte)
          lda #<>aUnitWindowBG1HOFSHDMAInfo
          sta lR44
          jsl rlHDMAEngineCreateEntry

          lda #(`aUnitWindowTMHDMAInfo)<<8
          sta lR44+size(byte)
          lda #<>aUnitWindowTMHDMAInfo
          sta lR44
          jsl rlHDMAEngineCreateEntry

          lda #(`$9F9AC0)<<8
          sta lR18+size(byte)
          lda #<>$9F9AC0
          sta lR18
          lda #(`(aBG1TilemapBuffer+(32 * 32 * size(word))))<<8
          sta lR19+size(byte)
          lda #<>(aBG1TilemapBuffer+(32 * 32 * size(word)))
          sta lR19
          lda #(32 * 32 * size(word))
          sta lR20
          jsl rlBlockCopy

          jsl rlDMAByStruct

            .structDMAToVRAM $9F93C0, (32 * 32 * size(word)), VMAIN_Setting(true), BG1TilemapPosition

          jsl rlUnitWindowCopyItemIconTiles
          jsl rlUnitWindowCopySkillIconTiles

          lda #$00CE
          jsl rlUnitWindowFillBG3Buffer
          jsl rlDMAByStruct

            .structDMAToVRAM aBG3TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), $F000

          jsl rlUnitWindowSetDefaults
          jsl rlUnitWindowRenderPageRows
          jsl rlUnitWindowDMABG3TilemapBufferPage1
          jsl rlUnitWindowDMABG1TilemapBufferPage1
          jsl rlUnitWindowCreateCursor

          plp
          plb
          rtl

          .databank 0

        rlProcUnitWindowOnCycle ; 9A/ED68

          .al
          .xl
          .autsiz
          .databank ?

          lda wUnitWindowCurrentRow
          bmi _Upper

          lda $7EA939
          bne _AfterInputs

          jsl rlUnitWindowHandleLowerInputs
          lda bUnitWindowActive
          and #$00FF
          cmp #narrow(-1, size(byte))
          beq _AfterInputsAndScrolling

          jsl rlUnitWindowHandlePossibleLowerPageTurn
          jsl rlUnitWindowHandleLowerScrollInputs
          bra +

          _Upper
          jsl rlUnitWindowHandleUpperInputs

          +
          jsl rlUnitWindowSetCursorPosition

          _AfterInputs
          jsl rlUnitWindowHandlePossibleScroll

          jsr rsUnitWindowTryYSpeedUp

          _AfterInputsAndScrolling
          jsl rlUnitWindowRenderAllMapSprites
          jsl rlUnitWindowTryRenderWeaponRankIcons
          jsl rlUnitWindowToggleScrollArrows
          jsl rlUnitWindowRenderSortSelectorCursor
          jsl rlUnitWindowRenderWeaponRankWeaponRankSortIcon
          jsl rlUnitWindowRenderSortDirectionArrow

          rtl

          .databank 0

      endProcs
      startCode

        rsUnitWindowTryYSpeedUp ; 9A/EDB6

          .al
          .xl
          .autsiz
          .databank ?

          lda wJoy1Input
          bit #JOY_Y
          beq +

          lda #$0001
          sta wJoy1RepeatTimer

          jsl rlUnitWindowHandlePossibleScroll

          +
          rts

          .databank 0

        rlUnitWindowHandleUpperInputs ; 9A/EDC7

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`aBG3TilemapBuffer
          pha

          rep #$20

          plb

          .databank `aBG3TilemapBuffer

          jsl rlUnitWindowFindUpdater
          bcs _End

            _NewInputs  := [(JOY_A, _A_Or_X)]
            _NewInputs ..= [(JOY_X, _A_Or_X)]
            _NewInputs ..= [(JOY_Down, _Down_Or_B)]
            _NewInputs ..= [(JOY_B, _Down_Or_B)]

            _HeldInputs  := [(JOY_Right, _Right)]
            _HeldInputs ..= [(JOY_Left, _Left)]

            .for _Inputs, _Actions in [(wJoy1New, _NewInputs), (wJoy1Repeated, _HeldInputs)]

              lda _Inputs

              .for _Pressed, _Handler in _Actions

                bit #_Pressed
                bne _Handler

              .endfor

            .endfor

          _End
          plp
          plb
          rtl

          .databank 0

          _Down_Or_B

            .al
            .xl
            .autsiz
            .databank `aBG3TilemapBuffer

            jsl rlUnitWindowSetStateLower

            lda #$0021 ; TODO: sound effects
            jsl rlPlaySoundEffect

            bra _End

            .databank 0

          _A_Or_X

            .al
            .xl
            .autsiz
            .databank `aBG3TilemapBuffer

            jsl rlUnitWindowUpdateSort
            jsl rlUnitWindowUpdatePage

            lda #$000D ; TODO: sound effects
            jsl rlPlaySoundEffect

            bra _End

          _Right

            .al
            .xl
            .autsiz
            .databank `aBG3TilemapBuffer

            lda wUnitWindowCurrentColumn
            inc a
            cmp #$0025 ; TODO: sort types
            beq _End

              sta wUnitWindowCurrentColumn
              bra _Left_Right_Continue

          _Left

            .al
            .xl
            .autsiz
            .databank `aBG3TilemapBuffer

            lda wUnitWindowCurrentColumn
            dec a
            bmi _End

              sta wUnitWindowCurrentColumn

          _Left_Right_Continue

            .al
            .xl
            .autsiz
            .databank ?

            tax

            lda #$000A ; TODO: sound effects
            jsl rlPlaySoundEffect

            lda wUnitWindowCurrentPage
            sta wR0

            lda _PageTable,x
            and #$00FF
            sta wUnitWindowCurrentPage

            cmp wR0
            beq _End

            jsl rlUnitWindowUpdatePage
            bra _End

            _PageTable
              .byte 0, 0, 0, 0, 0, 0
              .byte 1, 1, 1, 1, 1
              .byte 2, 2, 2, 2, 2, 2, 2, 2
              .byte 3, 3, 3, 3, 3
              .byte 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
              .byte 5, 5

            .databank 0

        rlUnitWindowHandleLowerInputs ; 9A/EE79

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlUnitWindowFindUpdater
          bcs _End

          lda wUnitWindowCurrentRow
          bmi _End

          lda aSoundSystem.aUnknown0004BA,b
          bne _End

            lda wJoy1New

            bit #JOY_X
            bne _X

            bit #JOY_A
            bne _A

            bit #JOY_B
            bne _B

          _End
          rtl

          .databank 0

          _DoFade

            .al
            .xl
            .autsiz
            .databank ?

            sep #$20

            lda #-1
            sta bUnitWindowActive

            rep #$20
            sep #$20

            lda #INIDISP_Setting(false, 0)
            sta bBufferINIDISP

            rep #$20

            rtl

            .databank 0

          _X

            .al
            .xl
            .autsiz
            .databank ?

            lda #$000D ; TODO: sound effects
            jsl rlPlaySoundEffect

            lda #(`$90F127)<<8
            sta lR44+size(byte)
            lda #<>$90F127
            sta lR44
            jsl rlProcEngineCreateProc

            bra _DoFade

            .databank 0

          _A

            .al
            .xl
            .autsiz
            .databank ?

            lda wUnitWindowType
            bit #$0002
            bne _B

            lda #$000D ; TODO: sound effects
            jsl rlPlaySoundEffect

            lda #(`$90F195)<<8
            sta lR44+size(byte)
            lda #<>$90F195
            sta lR44
            jsl rlProcEngineCreateProc

            bra _DoFade

            .databank 0

          _B

            .al
            .xl
            .autsiz
            .databank ?

            lda #$0021 ; TODO: sound effects
            jsl rlPlaySoundEffect

            lda #(`$90F17F)<<8
            sta lR44+size(byte)
            lda #<>$90F17F
            sta lR44
            jsl rlProcEngineCreateProc

            bra _DoFade

            .databank 0

        rlUnitWindowHandlePossibleScroll ; 9A/EEFD

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #$7E
          pha

          rep #$20

          plb

          .databank $7E

          lda @l $7EA939
          beq _End

          dec a
          asl a
          tax
          jmp (_Directions,x)

          _PostScroll
          jsr rsUnitWindowPostScroll

          _End
          jsr rsUnitWindowGetScrollDistances
          plp
          plb
          rtl

          _Directions .addr _Up, _Down

          .databank 0

          _Up

            .al
            .xl
            .autsiz
            .databank ?

            lda wUnitWindowScrollPixels
            sec
            sbc #4
            sta wUnitWindowScrollPixels

            bit #$000F
            bne _End

            bra _PostScroll

            .databank 0

          _Down

            .al
            .xl
            .autsiz
            .databank ?

            lda wUnitWindowScrollPixels
            clc
            adc #4
            sta wUnitWindowScrollPixels

            bit #$000F
            bne _End
            bra _PostScroll

            .databank 0

        rsUnitWindowGetScrollDistances ; 9A/EF46

          .al
          .xl
          .autsiz
          .databank ?

          lda wUnitWindowScrollPixels
          clc
          adc #-56
          dec a
          sta $165D,b
          sta $1665,b

          lda wUnitWindowScrollPixels
          lsr a
          lsr a
          lsr a
          lsr a
          sta wUnitWindowScrollRows

          rts

          .databank 0

        rsUnitWindowPostScroll ; 9A/EF62

          .al
          .xl
          .autsiz
          .databank ?

          lda #$0000
          sta $7EA939

          lda #2
          jsl rlSetDownScrollingArrowSpeed

          lda #2
          jsl rlSetUpScrollingArrowSpeed

          rts

          .databank 0

        rlUnitWindowCreateCursor ; 9A/EF78

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`$7EA937
          pha

          rep #$20

          plb

          .databank `$7EA937

          jsl rlUnitWindowGetLowerCursorPosition

          lda #(`procRightFacingCursor)<<8
          sta lR44+size(byte)
          lda #<>procRightFacingCursor
          sta lR44
          jsl rlProcEngineCreateProc
          sta $7EA937

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowSetCursorPosition ; 9A/EF9A

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`$7EA937
          pha

          rep #$20

          plb

          .databank `$7EA937

          lda @l $7EA939
          bne +

          jsl rlUnitWindowGetLowerCursorPosition

          ldx $7EA937

          lda aProcSystem.wInput0,b
          sta aProcSystem.aBody0,b,x

          lda aProcSystem.wInput1,b
          sta aProcSystem.aBody1,b,x

          +
          plp
          plb
          rtl

          .databank 0

        rlUnitWindowHandleLowerScrollInputs ; 9A/EFC0

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`$7EA937
          pha

          rep #$20

          plb

          .databank `$7EA937

          jsl rlUnitWindowFindUpdater
          bcs _End

          lda wJoy1Repeated

          bit #JOY_Up
          bne _Up

          bit #JOY_Down
          bne _Down

          _End
          plp
          plb
          rtl

          .databank 0

          _Up

            .al
            .xl
            .autsiz
            .databank `$7EA937

            lda wUnitWindowCurrentRow
            beq _ToUpper

            pha

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            pla

            dec wUnitWindowCurrentRow
            beq _End

            sec
            sbc wUnitWindowScrollRows
            dec a
            beq _ScrollUp

            bra _End

            .databank 0

          _Down

            .al
            .xl
            .autsiz
            .databank `$7EA937

            lda wUnitWindowCurrentRow
            sta wR0

            lda wUnitWindowCurrentRow
            inc a
            sec
            sbc @l wUnitWindowMaxRows
            beq _End

            pha

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            pla

            inc wUnitWindowCurrentRow
            inc a
            beq _End

            lda wR0
            sec
            sbc wUnitWindowScrollRows

            inc a

            cmp #$0009
            beq _ScrollDown

            bra _End

            .databank 0

          _ScrollUp

            .al
            .xl
            .autsiz
            .databank ?

            lda wUnitWindowScrollRows
            dec a

            jsl rlUnitWindowDoLowerScrollStep

            lda #$0001
            sta $7EA939

            jsr rsUnitWindowGetScrollSpeed
            jsl rlSetUpScrollingArrowSpeed

            bra _End

            .databank 0

          _ScrollDown

            .al
            .xl
            .autsiz
            .databank ?

            lda wUnitWindowScrollRows
            clc
            adc #$000A

            jsl rlUnitWindowDoLowerScrollStep

            lda #$0002
            sta $7EA939

            jsr rsUnitWindowGetScrollSpeed
            jsl rlSetDownScrollingArrowSpeed

            jmp _End

            .databank 0

          _ToUpper

            .al
            .xl
            .autsiz
            .databank ?

            lda wJoy1New

            bit #JOY_Up
            bne +

              jmp _End

            +
            jsl rlUnitWindowSetStateUpper

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            jmp _End

            .databank 0

          rsUnitWindowGetScrollSpeed ; 9A/F076

            .al
            .xl
            .autsiz
            .databank ?

            lda wJoy1Input
            bit #JOY_Y
            beq +

            lda #16
            bra ++

            +
            lda #8

            +
            rts

            .databank 0

        rlUnitWindowDoLowerScrollStep ; 9A/F086

          .al
          .xl
          .autsiz
          .databank ?

          sta $7EA93B
          asl a
          tax
          lda aUnitWindowDeploymentSlots,x
          sta wTemporaryDeploymentInfo,b

          jsl rlUnitWindowRenderPageRow
          jsl rlUnitWindowCopyLineBG3Page1Tilemap
          jsl rlUnitWindowCopyLineBG1Page1Tilemap

          rtl

          .databank 0

        rlUnitWindowSetStateUpper ; 9A/F0A0

          .al
          .xl
          .autsiz
          .databank ?

          lda #-1
          sta wUnitWindowCurrentRow
          rtl

          .databank 0

        rlUnitWindowSetStateLower ; 9A/F0A8

          .al
          .xl
          .autsiz
          .databank ?

          lda #0
          sta wUnitWindowCurrentRow
          rtl

          .databank 0

        rlUnitWindowGetLowerCursorPosition ; 9A/F0B0

          .al
          .xl
          .autsiz
          .databank ?

          ldx #$0028
          lda wUnitWindowCurrentRow
          bmi +

            sec
            sbc wUnitWindowScrollRows
            asl a
            asl a
            tax

          +
          lda _Coordinates,x
          sta aProcSystem.wInput0,b
          lda _Coordinates+size(word),x
          sta aProcSystem.wInput1,b
          rtl

          _Coordinates .for _i in range(10)
            .word (0, 56 + (_i * 16))
          .endfor

          .databank 0

        aUnknown9AF0F8 .word $80, $07

        rlUnitWindowHandlePossibleLowerPageTurn ; 9A/F0FC

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlUnitWindowFindUpdater
          bcs _End

            lda wJoy1Repeated
            bit #JOY_Right
            bne _Right

            bit #JOY_Left
            bne _Left

            rtl

          _Right
            lda wUnitWindowCurrentPage
            inc a
            cmp #$0006
            beq _End

            sta wUnitWindowCurrentPage
            jsl rlUnitWindowSetLowerPageSwitchDefaultColumn
            jsl rlUnitWindowUpdatePage

            lda #$000A ; TODO: sound definitions
            jsl rlPlaySoundEffect

            rtl

          _Left
            lda wUnitWindowCurrentPage
            dec a
            bmi _End

            sta wUnitWindowCurrentPage
            jsl rlUnitWindowSetLowerPageSwitchDefaultColumn
            jsl rlUnitWindowUpdatePage

            lda #$000A ; TODO: sound definitions
            jsl rlPlaySoundEffect

          _End
          rtl

          .databank 0

        rlUnitWindowSetLowerPageSwitchDefaultColumn ; 9A/F148

          .al
          .xl
          .autsiz
          .databank ?

          lda wUnitWindowCurrentPage
          tax
          lda _Columns,x
          and #$00FF
          sta wUnitWindowCurrentColumn
          rtl

          _Columns .block
            .byte 0
            .byte 6
            .byte 11
            .byte 19
            .byte 24
            .byte 35
          .endblock

          .databank 0

        rlUnitWindowUpdatePage ; 9A/F15F

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlUnitWindowRenderPageRows
          jsl rlUnitWindowDMABG3TilemapBufferPage1
          jsl rlUnitWindowCreateUpdater
          rtl

          .databank 0

        rlUnitWindowFindUpdater ; 9A/F16C

          .al
          .xl
          .autsiz
          .databank ?

          lda #(`$9AF18A)<<8
          sta lR44+size(byte)
          lda #<>$9AF18A
          sta lR44
          jsl rlProcEngineFindProc
          rtl

          .databank 0

        rlUnitWindowCreateUpdater ; 9A/F17B

          .al
          .xl
          .autsiz
          .databank ?

          lda #(`$9AF18A)<<8
          sta lR44+size(byte)
          lda #<>$9AF18A
          sta lR44
          jsl rlProcEngineCreateProc
          rtl

          .databank 0

      endCode
      startProcs

        procUnitWindowUpdater .structProcInfo "xx", None, None, aProcUnitWindowUpdaterCode ; 9A/F18A

        aProcUnitWindowUpdaterCode .block ; 9A/F192

          PROC_YIELD 1
          PROC_CALL rlUnitWindowDMABG1TilemapBufferPage1
          PROC_END

        .endblock

      endProcs
      startData

        aUnitWindowBG3HOFSHDMAInfo .structHDMAIndirectEntryInfo rlUnitWindowBG3HOFSHDMAInit, rlUnitWindowBG3HOFSHDMAOnCycle, aUnitWindowBG3HOFSHDMACode, aUnitWindowBG3HOFSHDMATable, BG3HOFS, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), None ; 9A/F19B

        aUnitWindowBG3HOFSHDMATable .block ; 9A/F1A7

          .byte NTRL_Setting(56)

          .word $1673

          .byte NTRL_Setting(112)

          .word $1677

          .byte NTRL_Setting(48)

          .word $1677

          .byte NTRL_Setting(1)

          .word $1673

          .byte 0

        .endblock

      endData
      startCode

        rlUnitWindowBG3HOFSHDMAInit ; 9A/F1B4

          .al
          .xl
          .autsiz
          .databank ?

          lda #0
          sta wBufferBG3HOFS
          lda #-1
          sta wBufferBG3VOFS
          lda #256
          sta $165B,b
          lda #-57
          sta $165D,b
          rtl

          .databank 0

        rlUnitWindowBG3HOFSHDMAOnCycle ; 9A/F1CB

          .al
          .xl
          .autsiz
          .databank ?

          rtl

          .databank 0

      endCode
      startData

        aUnitWindowBG3HOFSHDMACode .block ; 9A/F1CC

          HDMA_HALT

        .endblock

        aUnitWindowBG1HOFSHDMAInfo .structHDMAIndirectEntryInfo rlUnitWindowBG1HOFSHDMAInit, rlUnitWindowBG1HOFSHDMAOnCycle, aUnitWindowBG1HOFSHDMACode, aUnitWindowBG1HOFSHDMATable, BG1HOFS, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), None ; 9A/F1CE

        aUnitWindowBG1HOFSHDMATable .block ; 9A/F1DA

          .byte NTRL_Setting(56)

          .word $166B

          .byte NTRL_Setting(112)

          .word $166F

          .byte NTRL_Setting(48)

          .word $166F

          .byte NTRL_Setting(1)

          .word $166B

          .byte 0

        .endblock

      endData
      startCode

        rlUnitWindowBG1HOFSHDMAInit ; 9A/F1E7

          .al
          .xl
          .autsiz
          .databank ?

          lda #0
          sta wBufferBG1HOFS
          lda #-1
          sta wBufferBG1VOFS
          lda #256
          sta $1663,b
          lda #-1
          sta $1665,b
          rtl

          .databank 0

        rlUnitWindowBG1HOFSHDMAOnCycle ; 9A/F1FE

          .al
          .xl
          .autsiz
          .databank ?

          rtl

          .databank 0

      endCode
      startData

        aUnitWindowBG1HOFSHDMACode .block ; 9A/F1FF

          HDMA_HALT

        .endblock

        aUnitWindowTMHDMAInfo .structHDMADirectEntryInfo rlUnitWindowTMHDMAInit, rlUnitWindowTMHDMAOnCycle, aUnitWindowTMHDMACode, aUnitWindowTMHDMATable, TM, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode0) ; 9A/F201

        aUnitWindowTMHDMATable .block

          .byte NTRL_Setting(53)
          .byte T_Setting(true, true, true, false, true)

          .byte NTRL_Setting(112)
          .byte T_Setting(true, true, true, false, true)

          .byte NTRL_Setting(51)
          .byte T_Setting(true, true, true, false, true)

          .byte NTRL_Setting(3)
          .byte T_Setting(true, true, false, false, true)

          .byte NTRL_Setting(1)
          .byte T_Setting(true, true, false, false, false)

          .byte 0

        .endblock

      endData
      startCode

        rlUnitWindowTMHDMAInit ; 9A/F217

          .al
          .xl
          .autsiz
          .databank ?

          rtl

          .databank 0

        rlUnitWindowTMHDMAOnCycle ; 9A/F218

          .al
          .xl
          .autsiz
          .databank ?

          rtl

          .databank 0

      endCode
      startData

        aUnitWindowTMHDMACode .block ; 9A/F219

          HDMA_HALT

        .endblock

      endData
      startCode

        rlUnitWindowRenderPageRows ; 9A/F21B

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowScrollRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowScrollRows

          jsl rlUnitWindowClearBG3Page1
          jsl rlUnitWindowClearBG1Page1
          jsl rlUnitWindowCopyPageLabelTilemap

          lda @l wUnitWindowScrollRows
          sta @l $7EA93B

          lda #10
          sta @l $7EA93F

          -
            lda @l $7EA93B
            asl a
            tax
            lda @l aUnitWindowDeploymentSlots,x
            beq _End

              sta wTemporaryDeploymentInfo,b

              jsl rlUnitWindowRenderPageRow
              dec $7EA93F
              beq _End

                inc $7EA93B

                lda @l $7EA93B
                cmp @l wUnitWindowMaxRows
                bcc -

          _End
          plp
          plb
          rtl

          .databank 0

        rlUnitWindowRenderPageRow ; 9A/F268

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`$7EA93B
          pha

          rep #$20

          plb

          .databank `$7EA93B

          lda #(`$9AEC84)<<8
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
          lda #<>$9AEC84
          sta aCurrentTilemapInfo.lInfoPointer,b

          jsr rlUnitWindowClearPageRow

          lda @l $7EA93B
          tax
          lda aUnitWindowLineRowOffsets,x
          and #$00FF
          xba
          sta @l $7EA93D

          lda @l wUnitWindowCurrentPage
          asl a
          tax
          lda aUnitWindowPages,x
          tax

          -
          lda ((`aUnitWindowPages)<<16)+structUnitWindowPageElement.XOffset,x
          beq _End

          phx

          lda ((`aUnitWindowPages)<<16)+structUnitWindowPageElement.TextGetter,x
          sta lR25
          lda ((`aUnitWindowPages)<<16)+structUnitWindowPageElement.TextGetter+size(byte),x
          sta lR25+size(byte)

          phx
          phk
          pea #<>(+)-1
          jmp [lR25]

          +
          plx

          lda ((`aUnitWindowPages)<<16)+structUnitWindowPageElement.Renderer,x
          sta lR25
          lda ((`aUnitWindowPages)<<16)+structUnitWindowPageElement.Renderer+size(byte),x
          sta lR25+size(byte)

          lda ((`aUnitWindowPages)<<16)+structUnitWindowPageElement.BaseTile,x
          sta aCurrentTilemapInfo.wBaseTile,b

          lda ((`aUnitWindowPages)<<16)+structUnitWindowPageElement.XOffset,x
          and #$00FF
          ora @l $7EA93D
          tax

          phk
          pea #<>(+)-1

          jmp [lR25]

          +
          pla
          clc
          adc #size(structUnitWindowPageElement)
          tax
          bra -

          _End
          plp
          plb
          rtl

          .databank 0

        rlUnitWindowClearPageRow ; 9A/F2EA

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`$7EA93B
          pha

          rep #$20

          plb

          .databank `$7EA93B

          lda @l $7EA93B
          tax
          lda aUnitWindowLineRowOffsets,x
          and #$00FF
          asl a
          asl a
          asl a
          asl a
          asl a
          asl a
          clc
          adc #<>(aBG3TilemapBuffer+(32 * 32 * size(word)))
          tax

          lda #$00CE

          .for _i in range(0, 64 * size(word), size(word))

            sta _i,b,x

          .endfor

          txa
          sec
          sbc #<>(aBG3TilemapBuffer+(32 * 32 * size(word)))

          clc
          adc #<>(aBG1TilemapBuffer+(32 * 32 * size(word)))
          tax

          lda #$002F

          .for _y, _x in iter.product([range(2), range(1, 31)])

            sta C2I((_x, _y), 32) * size(word),b,x

          .endfor

          plp
          plb
          rts

          .databank 0

      endCode
      startData

        aUnitWindowPages .block ; 9A/F492

          .addr aUnitWindowPage1
          .addr aUnitWindowPage2
          .addr aUnitWindowPage3
          .addr aUnitWindowPage4
          .addr aUnitWindowPage5
          .addr aUnitWindowPage6

        .endblock

        aUnitWindowPage1 .block ; 9A/F49E

          .structUnitWindowPageElement  4, rlUnitWindowGetUnitName, rlDrawMenuText, $2000
          .structUnitWindowPageElement 10, rlUnitWindowGetUnitClassName, rlDrawMenuText, $2000
          .structUnitWindowPageElement 20, rlUnitWindowGetUnitLevel, rlDrawNumberMenuText, $3520
          .structUnitWindowPageElement 23, rlUnitWindowGetUnitExperience, rlUnitWindowDrawNumberOrDoubleDash, $3800
          .structUnitWindowPageElement 26, rlUnitWindowGetUnitCurrentHP, rlUnitWindowDrawNumberWithSlash, $3520
          .structUnitWindowPageElement 29, rlUnitWindowGetUnitMaxHP, rlDrawNumberMenuText, $3920
          .word None

        .endblock

        aUnitWindowPage2 .block ; 9A/F4D6

          .structUnitWindowPageElement  4, rlUnitWindowGetUnitName, rlDrawMenuText, $2000
          .structUnitWindowPageElement 21, rlUnitWindowGetUnitMight, rlDrawNumberMenuText, $3520
          .structUnitWindowPageElement 25, rlUnitWindowGetUnitHit, rlDrawNumberMenuText, $3920
          .structUnitWindowPageElement 12, rlUnitWindowGetUnitEquippedWeaponName, $9AF64D, $2000
          .structUnitWindowPageElement 29, rlUnitWindowGetUnitAvoid, rlDrawNumberMenuText, $3520
          .word None

        .endblock

        aUnitWindowPage3 .block ; 9A/F505

          .structUnitWindowPageElement  4, rlUnitWindowGetUnitName, rlDrawMenuText, $2000
          .structUnitWindowPageElement 11, rlUnitWindowGetUnitStrength, rlDrawNumberMenuText, $3520
          .structUnitWindowPageElement 14, rlUnitWindowGetUnitMagic, rlDrawNumberMenuText, $3920
          .structUnitWindowPageElement 17, rlUnitWindowGetUnitSkill, rlDrawNumberMenuText, $3520
          .structUnitWindowPageElement 20, rlUnitWindowGetUnitSpeed, rlDrawNumberMenuText, $3920
          .structUnitWindowPageElement 23, rlUnitWindowGetUnitLuck, rlDrawNumberMenuText, $3520
          .structUnitWindowPageElement 26, rlUnitWindowGetUnitDefense, rlDrawNumberMenuText, $3920
          .structUnitWindowPageElement 29, rlUnitWindowGetUnitConstitution, rlDrawNumberMenuText, $3520
          .word None

        .endblock

        aUnitWindowPage4 .block ; 9A/F54F

          .structUnitWindowPageElement  4, rlUnitWindowGetUnitName, rlDrawMenuText, $2000
          .structUnitWindowPageElement 12, rlUnitWindowGetUnitMove, rlDrawNumberMenuText, $3520
          .structUnitWindowPageElement 15, rlUnitWindowGetUnitFatigue, rlUnitWindowDrawNumberOrDoubleDash, $3800
          .structUnitWindowPageElement 18, rlUnitWindowGetUnitStatusString, rlDrawMenuText, $3400
          .structUnitWindowPageElement 24, rlUnitWindowGetUnitRescueeName, rlDrawMenuText, $3800
          .word None

        .endblock

        aUnitWindowPage5 .block ; 9A/F57E

          .structUnitWindowPageElement  4, rlUnitWindowGetUnitName, rlDrawMenuText, $2000
          .structUnitWindowPageElement 11, $84B46A, rlUnitWindowDrawWeaponRanks, $3400
          .word None

        .endblock

        aUnitWindowPage6 .block ; 9A/F592

          .structUnitWindowPageElement  4, rlUnitWindowGetUnitName, rlDrawMenuText, $2000
          .structUnitWindowPageElement 10, rlUnitWindowGetUnitSkillCount, rlUnitWindowDrawSkillIcons, $0000
          .word None

        .endblock

      endData
      startCode

        rlUnitWindowDrawNumberWithSlash ; 9A/F5A6

          .al
          .xl
          .autsiz
          .databank ?

          phx

          jsl rlDrawNumberMenuText

          plx
          inc x

          lda #$2000
          sta aCurrentTilemapInfo.wBaseTile,b

          lda #(`_Text)<<8
          sta lR18+size(byte)
          lda #<>_Text
          sta lR18

          jsl rlDrawMenuText
          rtl

          .enc "SJIS"

          _Text .text "／\n"

          .databank 0

        rlUnitWindowDrawNumberOrDoubleDash ; 9A/F5C6

          .al
          .xl
          .autsiz
          .databank ?

          lda lR18
          cmp #$00FF
          beq +

            pha
            lda aCurrentTilemapInfo.wBaseTile,b
            ora #TilemapEntry($120, 0, false, false, false)
            sta aCurrentTilemapInfo.wBaseTile,b
            pla
            jsl rlDrawNumberMenuText
            rtl

          +
          dec x
          lda #(`menuTextUnitWindow2Dash)<<8
          sta lR18+size(byte)
          lda #<>menuTextUnitWindow2Dash
          sta lR18
          jsl rlDrawMenuText
          rtl

          .databank 0

      endCode
      startMenuText

        .enc "SJIS"

        menuTextUnitWindow1Dash .text "ー\n" ; 9A/F5ED
        menuTextUnitWindow2Dash .text "ーー\n" ; 9A/F5F1
        menuTextUnitWindow3Dash .text "ーーー\n" ; 9A/F5F7
        menuTextUnitWindow4Dash .text "ーーーー\n" ; 9A/F5FF
        menuTextUnitWindow5Dash .text "ーーーーー\n" ; 9A/F609
        menuTextUnitWindow6Dash .text "ーーーーーー\n" ; 9A/F615
        menuTextUnitWindow7Dash .text "ーーーーーーー\n" ; 9A/F623
        menuTextUnitWindow8Dash .text "ーーーーーーーー\n" ; 9A/F633
        menuTextUnitWindowSpace2Dash .text "　ーー\n" ; 9A/F645

      endMenuText
      startCode

        rlUnitWindowDrawItemText ; 9A/F64D

          .al
          .xl
          .autsiz
          .databank ?

          phx
          lda $7EA93B
          asl a
          tax
          lda aUnitWindowDeploymentSlots,x
          sta wTemporaryDeploymentInfo,b
          plx
          lda aItemDataBuffer.DisplayedWeapon,b
          and #$00FF
          beq +

          jsl rlDrawMenuText
          jsl rlUnitWindowDrawItemIconTilemap
          rtl

          +
          lda #$2000
          sta aCurrentTilemapInfo.wBaseTile,b

          lda #(`menuTextUnitWindow6Dash)<<8
          sta lR18+size(byte)
          lda #<>menuTextUnitWindow6Dash
          sta lR18
          jsl rlDrawMenuText

          txa
          clc
          adc #7
          tax

          lda #$3400
          sta aCurrentTilemapInfo.wBaseTile,b

          lda #(`menuTextUnitWindowSpace2Dash)<<8
          sta lR18+size(byte)
          lda #<>menuTextUnitWindowSpace2Dash
          sta lR18

          jsl rlDrawMenuText

          .rept 4
            inc x
          .endrept

          lda #$3800
          sta aCurrentTilemapInfo.wBaseTile,b

          lda #(`menuTextUnitWindowSpace2Dash)<<8
          sta lR18+size(byte)
          lda #<>menuTextUnitWindowSpace2Dash
          sta lR18
          jsl rlDrawMenuText

          rtl

          .databank 0

        rlUnitWindowDrawItemIconTilemap ; 9A/F6B4

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`$7EA93B
          pha

          rep #$20

          plb

          .databank `$7EA93B

          lda @l $7EA93B
          asl a
          tax
          lda $7FB171,x
          clc
          adc #$3580
          sta wR0
          lda @l $7EA93B
          tax
          lda aUnitWindowLineRowOffsets,x
          and #$00FF
          asl a
          asl a
          asl a
          asl a
          asl a
          asl a
          clc
          adc #$CF90
          tax
          lda wR0

          sta C2I((0, 0), 32) * size(word),b,x
          inc a
          sta C2I((1, 0), 32) * size(word),b,x
          inc a
          sta C2I((0, 1), 32) * size(word),b,x
          inc a
          sta C2I((1, 1), 32) * size(word),b,x

          plp
          plb
          rtl

          .databank 0

        rlUnitWindowDrawSkillIcons ; 9A/F6F9

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`$7EA93B
          pha

          rep #$20

          plb

          .databank `$7EA93B

          lda @l $7EA93B
          asl a
          tax
          lda @l aUnitWindowDeploymentSlots,x
          sta wTemporaryDeploymentInfo,b

          jsl rlUnitWindowGetUnitSkillCount

          lda wTemporaryUnitWindowSkillCounter,b
          beq _End

          asl a
          tax
          lda aUnitWindowSkillIconPositionSetPointers,x
          sta wR0
          ldy #$0000
          ldx #$0014

          -
          lda aTemporaryUnitWindowSkillList,x
          and #$00FF
          beq +

          jsr rsUnitWindowDrawSkillIcon

          inc y
          inc y

          +
          dec x

          bpl -

          _End
          plp
          plb
          rtl

          .databank 0

        rsUnitWindowDrawSkillIcon ; 9A/F73B

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          phk
          plb

          .databank `*

          phx

          lda @l $9AF787,x
          and #$00FF
          clc
          adc #$3700
          sta wR1

          lda $7EA93B
          tax

          lda @l aUnitWindowLineRowOffsets,x
          and #$00FF
          asl a
          asl a
          asl a
          asl a
          asl a
          asl a

          clc
          adc #$CF90

          clc
          adc (wR0),y

          clc
          adc (wR0),y

          tax

          sep #$20

          lda #`aBG1TilemapBuffer
          pha

          rep #$20

          plb

          .databank `aBG1TilemapBuffer

          lda wR1
          sta C2I((0, 0), 32) * size(word),b,x
          inc a
          sta C2I((1, 0), 32) * size(word),b,x
          inc a
          sta C2I((0, 1), 32) * size(word),b,x
          inc a
          sta C2I((1, 1), 32) * size(word),b,x
          plx
          plp
          plb
          rts

          .databank 0

      endCode
      startData

        aUnitWindowSkillIconBases .block ; 9A/F787

          .byte $44
          .byte $40
          .byte $14
          .byte $48
          .byte $10
          .byte $4c
          .byte $4c
          .byte $08
          .byte $4c
          .byte $4c
          .byte $1c
          .byte $24
          .byte $28
          .byte $0c
          .byte $18
          .byte $00
          .byte $2c
          .byte $30
          .byte $34
          .byte $3c
          .byte $38

        .endblock

        aUnitWindowSkillIconPositionSetPointers .block ; 9A/F79C

          .addr aUnitWindowSkillIconPositionsFlat+size(aUnitWindowSkillIconPositionsFlat)-(1 * size(word))
          .addr aUnitWindowSkillIconPositionsFlat+size(aUnitWindowSkillIconPositionsFlat)-(1 * size(word))
          .addr aUnitWindowSkillIconPositionsFlat+size(aUnitWindowSkillIconPositionsFlat)-(2 * size(word))
          .addr aUnitWindowSkillIconPositionsFlat+size(aUnitWindowSkillIconPositionsFlat)-(3 * size(word))
          .addr aUnitWindowSkillIconPositionsFlat+size(aUnitWindowSkillIconPositionsFlat)-(4 * size(word))
          .addr aUnitWindowSkillIconPositionsFlat+size(aUnitWindowSkillIconPositionsFlat)-(5 * size(word))
          .addr aUnitWindowSkillIconPositionsFlat+size(aUnitWindowSkillIconPositionsFlat)-(6 * size(word))
          .addr aUnitWindowSkillIconPositionsFlat+size(aUnitWindowSkillIconPositionsFlat)-(7 * size(word))
          .addr aUnitWindowSkillIconPositionsFlat+size(aUnitWindowSkillIconPositionsFlat)-(8 * size(word))
          .addr aUnitWindowSkillIconPositionsFlat+size(aUnitWindowSkillIconPositionsFlat)-(9 * size(word))
          .addr aUnitWindowSkillIconPositionsFlat
          .addr aUnitWindowSkillIconPositionsOneCompressed
          .addr aUnitWindowSkillIconPositionsTwoCompressed
          .addr aUnitWindowSkillIconPositionsThreeCompressed
          .addr aUnitWindowSkillIconPositionsFourCompressed
          .addr aUnitWindowSkillIconPositionsFiveCompressed
          .addr aUnitWindowSkillIconPositionsSixCompressed
          .addr aUnitWindowSkillIconPositionsSevenCompressed
          .addr aUnitWindowSkillIconPositionsEightCompressed
          .addr aUnitWindowSkillIconPositionsNineCompressed
          .addr aUnitWindowSkillIconPositionsNineCompressed
          .addr aUnitWindowSkillIconPositionsNineCompressed
          .addr aUnitWindowSkillIconPositionsNineCompressed
          .addr aUnitWindowSkillIconPositionsNineCompressed
          .addr aUnitWindowSkillIconPositionsNineCompressed
          .addr aUnitWindowSkillIconPositionsNineCompressed
          .addr aUnitWindowSkillIconPositionsNineCompressed
          .addr aUnitWindowSkillIconPositionsNineCompressed
          .addr aUnitWindowSkillIconPositionsNineCompressed
          .addr aUnitWindowSkillIconPositionsNineCompressed
          .addr aUnitWindowSkillIconPositionsNineCompressed

        .endblock

        aUnitWindowSkillIconPositionsFlat .block ; 9A/F7DA
          .word $0012
          .word $0010
          .word $000e
          .word $000c
          .word $000a
          .word $0008
          .word $0006
          .word $0004
          .word $0002
          .word $0000
        .endblock

        aUnitWindowSkillIconPositionsOneCompressed .block ; 9A/F7EE
          .word $0012
          .word $0011
          .word $0010
          .word $000e
          .word $000c
          .word $000a
          .word $0008
          .word $0006
          .word $0004
          .word $0002
          .word $0000
        .endblock

        aUnitWindowSkillIconPositionsTwoCompressed .block ; 9A/F804
          .word $0012
          .word $0011
          .word $0010
          .word $000f
          .word $000e
          .word $000c
          .word $000a
          .word $0008
          .word $0006
          .word $0004
          .word $0002
          .word $0000
        .endblock

        aUnitWindowSkillIconPositionsThreeCompressed .block ; 9A/F81C
          .word $0012
          .word $0011
          .word $0010
          .word $000f
          .word $000e
          .word $000d
          .word $000c
          .word $000a
          .word $0008
          .word $0006
          .word $0004
          .word $0002
          .word $0000
        .endblock

        aUnitWindowSkillIconPositionsFourCompressed .block ; 9A/F836
          .word $0012
          .word $0011
          .word $0010
          .word $000f
          .word $000e
          .word $000d
          .word $000c
          .word $000b
          .word $000a
          .word $0008
          .word $0006
          .word $0004
          .word $0002
          .word $0000
        .endblock

        aUnitWindowSkillIconPositionsFiveCompressed .block ; 9A/F852
          .word $0012
          .word $0011
          .word $0010
          .word $000f
          .word $000e
          .word $000d
          .word $000c
          .word $000b
          .word $000a
          .word $0009
          .word $0008
          .word $0006
          .word $0004
          .word $0002
          .word $0000
        .endblock

        aUnitWindowSkillIconPositionsSixCompressed .block ; 9A/F870
          .word $0012
          .word $0011
          .word $0010
          .word $000f
          .word $000e
          .word $000d
          .word $000c
          .word $000b
          .word $000a
          .word $0009
          .word $0008
          .word $0007
          .word $0006
          .word $0004
          .word $0002
          .word $0000
        .endblock

        aUnitWindowSkillIconPositionsSevenCompressed .block ; 9A/F890
          .word $0012
          .word $0011
          .word $0010
          .word $000f
          .word $000e
          .word $000d
          .word $000c
          .word $000b
          .word $000a
          .word $0009
          .word $0008
          .word $0007
          .word $0006
          .word $0005
          .word $0004
          .word $0002
          .word $0000
        .endblock

        aUnitWindowSkillIconPositionsEightCompressed .block ; 9A/F8B2
          .word $0012
          .word $0011
          .word $0010
          .word $000f
          .word $000e
          .word $000d
          .word $000c
          .word $000b
          .word $000a
          .word $0009
          .word $0008
          .word $0007
          .word $0006
          .word $0005
          .word $0004
          .word $0003
          .word $0002
          .word $0000
        .endblock

        aUnitWindowSkillIconPositionsNineCompressed .block ; 9A/F8D6
          .word $0012
          .word $0011
          .word $0010
          .word $000f
          .word $000e
          .word $000d
          .word $000c
          .word $000b
          .word $000a
          .word $0009
          .word $0008
          .word $0007
          .word $0006
          .word $0005
          .word $0004
          .word $0003
          .word $0002
          .word $0001
          .word $0000
        .endblock

        aUnitWindowUnknown9AF8FC .block ; 9A/F8FC
          .word $0000
          .word $0000
          .word $0000
          .word $0000
          .word $0000
          .word $0000
          .word $0000
          .word $0000
        .endblock

      endData
      startCode

        rlUnitWindowCopyPageLabelTilemap ; 9A/F90C

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`wUnitWindowCurrentPage
          pha

          rep #$20

          plb

          .databank `wUnitWindowCurrentPage

          lda @l wUnitWindowCurrentPage
          asl a
          clc
          adc @l wUnitWindowCurrentPage
          tax

          lda _PageTilemapPointers,x
          sta lR18
          lda _PageTilemapPointers+size(byte),x
          sta lR18+size(byte)
          lda #(`(aBG3TilemapBuffer+(32 * 1 * size(word))))<<8
          sta lR19+size(byte)
          lda #<>(aBG3TilemapBuffer+(32 * 1 * size(word)))
          sta lR19
          lda #$0140
          sta lR20
          jsl rlBlockCopy
          jsl rlUnitWindowDrawSortText
          jsl rlDMAByStruct

            .structDMAToVRAM (aBG3TilemapBuffer+(32 * 1 * size(word))), $01C0, VMAIN_Setting(true), BG3TilemapPosition+(32 * 1 * size(word))

          plp
          plb
          rtl

          .databank 0

          _PageTilemapPointers .block ; 9A/F954

            .long $9faa40
            .long $9fab80
            .long $9facc0
            .long $9fae00
            .long $9faf40
            .long $9fb080

          .endblock

        rlUnitWindowGetCurrentUnitSwordRankString ; 9A/F966

          .al
          .xl
          .autsiz
          .databank ?

          lda #structClassDataEntry.SwordRank - structClassDataEntry.WeaponRanks
          jsl rlUnitWindowGetCurrentUnitWeaponRankString
          rtl

          .databank 0

        rlUnitWindowGetCurrentUnitLanceRankString ; 9A/F96E

          .al
          .xl
          .autsiz
          .databank ?

          lda #structClassDataEntry.LanceRank - structClassDataEntry.WeaponRanks
          jsl rlUnitWindowGetCurrentUnitWeaponRankString
          rtl

          .databank 0

        rlUnitWindowGetCurrentUnitAxeRankString ; 9A/F976

          .al
          .xl
          .autsiz
          .databank ?

          lda #structClassDataEntry.AxeRank - structClassDataEntry.WeaponRanks
          jsl rlUnitWindowGetCurrentUnitWeaponRankString
          rtl

          .databank 0

        rlUnitWindowGetCurrentUnitBowRankString ; 9A/F97E

          .al
          .xl
          .autsiz
          .databank ?

          lda #structClassDataEntry.BowRank - structClassDataEntry.WeaponRanks
          jsl rlUnitWindowGetCurrentUnitWeaponRankString
          rtl

          .databank 0

        rlUnitWindowGetCurrentUnitStaffRankString ; 9A/F986

          .al
          .xl
          .autsiz
          .databank ?

          lda #structClassDataEntry.StaffRank - structClassDataEntry.WeaponRanks
          jsl rlUnitWindowGetCurrentUnitWeaponRankString
          rtl

          .databank 0

        rlUnitWindowGetCurrentUnitFireRankString ; 9A/F98E

          .al
          .xl
          .autsiz
          .databank ?

          lda #structClassDataEntry.FireRank - structClassDataEntry.WeaponRanks
          jsl rlUnitWindowGetCurrentUnitWeaponRankString
          rtl

          .databank 0

        rlUnitWindowGetCurrentUnitThunderRankString ; 9A/F996

          .al
          .xl
          .autsiz
          .databank ?

          lda #structClassDataEntry.ThunderRank - structClassDataEntry.WeaponRanks
          jsl rlUnitWindowGetCurrentUnitWeaponRankString
          rtl

          .databank 0

        rlUnitWindowGetCurrentUnitWindRankString ; 9A/F99E

          .al
          .xl
          .autsiz
          .databank ?

          lda #structClassDataEntry.WindRank - structClassDataEntry.WeaponRanks
          jsl rlUnitWindowGetCurrentUnitWeaponRankString
          rtl

          .databank 0

        rlUnitWindowGetCurrentUnitLightRankString ; 9A/F9A6

          .al
          .xl
          .autsiz
          .databank ?

          lda #structClassDataEntry.LightRank - structClassDataEntry.WeaponRanks
          jsl rlUnitWindowGetCurrentUnitWeaponRankString
          rtl

          .databank 0

        rlUnitWindowGetCurrentUnitDarkRankString ; 9A/F9AE

          .al
          .xl
          .autsiz
          .databank ?

          lda #structClassDataEntry.DarkRank - structClassDataEntry.WeaponRanks
          jsl rlUnitWindowGetCurrentUnitWeaponRankString
          rtl

          .databank 0

        rlUnitWindowGetCurrentUnitWeaponRankString ; 9A/F9B6

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlUnitWindowGetUnitWeaponRankByType
          jsl rlGetRankString
          rtl

          .databank 0

        rlUnitWindowDrawWeaponRanks ; 9A/F9BF

          .al
          .xl
          .autsiz
          .databank ?

          stx lR24

          phb
          php

          sep #$20

          lda #`wUnitWindowMaxRows
          pha

          rep #$20

          plb

          .databank `wUnitWindowMaxRows

          lda wUnitWindowMaxRows
          dec a
          asl a
          tax

          lda wTemporaryDeploymentInfo,b

          -
          cmp $7FAACE,x
          beq +

          dec x
          dec x
          bpl -

          ldx #$0000

          +
          txa
          lsr a
          tax

          plp
          plb

          .databank ?

          stx lR25

          _WEXPPools  := [aUnitWindowSlotsSwordRank]
          _WEXPPools ..= [aUnitWindowSlotsLanceRank]
          _WEXPPools ..= [aUnitWindowSlotsAxeRank]
          _WEXPPools ..= [aUnitWindowSlotsBowRank]
          _WEXPPools ..= [aUnitWindowSlotsStaffRank]
          _WEXPPools ..= [aUnitWindowSlotsFireRank]
          _WEXPPools ..= [aUnitWindowSlotsThunderRank]
          _WEXPPools ..= [aUnitWindowSlotsWindRank]
          _WEXPPools ..= [aUnitWindowSlotsLightRank]
          _WEXPPools ..= [aUnitWindowSlotsDarkRank]

          .for _i, _Rank in iter.enumerate(_WEXPPools)

            ldx lR25
            lda #[$3400, $3800][_i % 2]
            sta aCurrentTilemapInfo.wBaseTile,b
            lda _Rank,x
            and #$00FF
            jsl rlGetRankString

            ldx lR24
            jsl rlDrawMenuText

            inc lR24
            inc lR24

          .endfor

          rtl

          .databank 0

        rlUnitWindowDMABG3TilemapBufferPage0 ; 9A/FB0B

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlDMAByStruct

            .structDMAToVRAM aBG3TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG3TilemapPosition

          rtl

          .databank 0

        rlUnitWindowDMABG1TilemapBufferPage0 ; 9A/FB19

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlDMAByStruct

            .structDMAToVRAM aBG1TilemapBuffer, (32 * 32 * size(word)), VMAIN_Setting(true), BG1TilemapPosition

          rtl

          .databank 0

        rlUnitWindowDMABG3TilemapBufferPage1 ; 9A/FB27

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlDMAByStruct

            .structDMAToVRAM aBG3TilemapBuffer+(32 * 32 * size(word)), (32 * 32 * size(word)), VMAIN_Setting(true), (BG3TilemapPosition + (32 * 32 * size(word)))

          rtl

          .databank 0

        rlUnitWindowDMABG1TilemapBufferPage1 ; 9A/FB35

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlDMAByStruct

            .structDMAToVRAM aBG1TilemapBuffer+(32 * 32 * size(word)), (32 * 32 * size(word)), VMAIN_Setting(true), (BG1TilemapPosition + (32 * 32 * size(word)))

          rtl

          .databank 0

        rlUnitWindowCopyLineBG3Page1Tilemap ; 9A/FB43

          .al
          .xl
          .autsiz
          .databank `$7EA93B

          lda #(`(aBG3TilemapBuffer+(32 * 32 * size(word))))<<8
          sta lR18+size(byte)

          ldx $7EA93B

          lda aUnitWindowLineRowOffsets,x
          and #$00FF
          asl a
          asl a
          asl a
          asl a
          asl a
          pha

          asl a
          clc
          adc #<>(aBG3TilemapBuffer+(32 * 32 * size(word)))
          sta lR18

          pla
          clc
          adc #(BG3TilemapPosition + (32 * 32 * size(word))) >> 1
          sta wR1

          lda #32 * 2 * size(word)
          sta wR0

          jsl rlDMAByPointer

          rtl

          .databank 0

        rlUnitWindowCopyLineBG1Page1Tilemap ; 9A/FB70

          .al
          .xl
          .autsiz
          .databank `$7EA93B

          lda #(`(aBG1TilemapBuffer+(32 * 32 * size(word))))<<8
          sta lR18+size(byte)

          ldx $7EA93B

          lda aUnitWindowLineRowOffsets,x
          and #$00FF
          asl a
          asl a
          asl a
          asl a
          asl a
          pha

          asl a
          clc
          adc #<>(aBG1TilemapBuffer+(32 * 32 * size(word)))
          sta lR18

          pla
          clc
          adc #(BG1TilemapPosition + (32 * 32 * size(word))) >> 1
          sta wR1

          lda #32 * 2 * size(word)
          sta wR0

          jsl rlDMAByPointer

          rtl

          .databank 0

        rlUnitWindowClearBG3Page1 ; 9A/FB9D

          .al
          .xl
          .autsiz
          .databank ?

          lda #<>(aBG3TilemapBuffer+(32 * 32 * size(word)))
          sta wR0
          lda #$00CE
          jsl rlFillTilemapByWord
          rtl

          .databank 0

        rlUnitWindowClearBG1Page1 ; 9A/FBAA

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`(aBG1TilemapBuffer+(32 * 32 * size(word)))
          pha

          rep #$20

          plb

          .databank `(aBG1TilemapBuffer+(32 * 32 * size(word)))

          ldx #$07C0

          -
          lda #$002F

          .for _x in range(1, 31)

            sta aBG1TilemapBuffer+(32 * 32 * size(word))+(_x * size(word)),x

          .endfor

          txa
          sec
          sbc #32 * size(word)
          tax
          bpl -

          plp
          plb
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowLineRowOffsets .byte (range(64) * 2) % 32 ; 9A/FC1F

      endData
      startCode

        rlUnitWindowCopySkillIconTiles ; 9A/FC5F

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlDMAByStruct

            .structDMAToVRAM $F2D880, $0980, VMAIN_Setting(true), SkillIconTilesPosition

          rtl

          .databank 0

        rlUnitWindowCopyItemIconTiles ; 9A/FC6D

          .al
          .xl
          .autsiz
          .databank ?

          lda #(`$9E8220)<<8
          sta lR18+size(byte)
          lda #<>$9E8220
          sta lR18
          lda #(`aBGPaletteBuffer.aPalette5)<<8
          sta lR19+size(byte)
          lda #<>aBGPaletteBuffer.aPalette5
          sta lR19
          lda #2 * size(Palette)
          sta lR20
          jsl rlBlockCopy

          jsl rlUnitWindowSetDefaultItemIconTileOffset

          ldx #$0000

          -
          lda aUnitWindowDeploymentSlots,x
          sta wTemporaryDeploymentInfo,b
          beq +

          jsl rlUnitWindowCopyItemIcon
          sta aUnitWindowItemIconTileIndexes,x
          inc x
          inc x
          bra -

          +
          rtl

          .databank 0

        rlUnitWindowSetDefaultItemIconTileOffset ; 9A/FCA7

          .al
          .xl
          .autsiz
          .databank ?

          lda #$0004
          sta $7EA93D
          rtl

          .databank 0

        rlUnitWindowCopyItemIcon ; 9A/FCAF

          .al
          .xl
          .autsiz
          .databank ?

          phb
          php

          sep #$20

          lda #`$7EA93D
          pha

          rep #$20

          plb

          .databank `$7EA93D

          phx

          jsl rlUnitWindowGetUnitEquippedWeapon
          bcc +

          lda #$0000
          ldy #$0000
          bra _End

          +
          pha

          lda aItemDataBuffer.Icon,b
          and #$00FF
          asl a
          asl a
          asl a
          asl a
          asl a
          asl a
          asl a
          clc
          adc #<>IconSheet
          sta lR18

          sep #$20

          lda #`IconSheet
          sta lR18+size(word)

          rep #$20

          lda $7EA93D
          asl a
          asl a
          asl a
          asl a
          clc
          adc #ItemIconTilesPosition >> 1
          sta wR1

          lda #4 * size(Tile4bpp)
          sta wR0

          jsl rlDMAByPointer

          lda $7EA93D

          .rept 4
            inc $7EA93D
          .endrept

          ply

          _End
          plx
          plp
          plb
          rtl

          .databank 0

        rlUnitWindowRememberLastSortOrder ; 9A/FD0E

          .al
          .xl
          .autsiz
          .databank ?

          jsl rlUnitWindowUnknown90E021

          lda bUnitWindowActive
          and #$00FF
          beq +

          lda wUnitWindowType
          bit #WindowTypes.FromUnitDuringPrep
          bne _End

          +
          jsl rlUnitWindowGetSortScores
          lda wUnitWindowSortDirection
          bne +

          jsl rlUnitWindowSetSortDescending
          bra _End

          +
          jsl rlUnitWindowSetSortAscending

          _End
          rtl

          .databank 0

      endCode
      startData

        aUnitWindowClassSortTable .block ; 9A/FD39

          .byte $00 ; None
          .byte $21 ; Cavalier
          .byte $6f ; LanceKnight
          .byte $00 ; BowKnight
          .byte $07 ; AxeKnight
          .byte $4d ; SwordKnight
          .byte $36 ; Troubadour
          .byte $71 ; KnightLord
          .byte $28 ; DukeKnight
          .byte $6a ; MasterKnight
          .byte $3d ; Paladin
          .byte $3e ; PaladinF
          .byte $58 ; ArchKnight
          .byte $49 ; ForestKnight
          .byte $62 ; MageKnight
          .byte $0d ; GreatKnight
          .byte $50 ; PegasusKnight
          .byte $45 ; FalconKnight
          .byte $32 ; WyvernRider
          .byte $2a ; WyvernKnight
          .byte $2e ; WyvernMaster
          .byte $56 ; Archer
          .byte $1d ; Myrmidon
          .byte $1f ; Swordmaster
          .byte $18 ; Sniper
          .byte $47 ; HeroFE4
          .byte $14 ; General
          .byte $0b ; Emperor
          .byte $41 ; Baron
          .byte $6e ; ArmoredLance
          .byte $06 ; ArmoredAxe
          .byte $55 ; ArmoredBow
          .byte $1c ; ArmoredSword
          .byte $38 ; Berserker
          .byte $68 ; Brigand
          .byte $69 ; BrigandAlternate
          .byte $0a ; Warrior
          .byte $43 ; Hunter
          .byte $3c ; Pirate
          .byte $17 ; JuniorLord
          .byte $64 ; MageKnightDismounted
          .byte $73 ; Lord
          .byte $4f ; Prince
          .byte $65 ; MageKnightFDismounted
          .byte $42 ; BaronGlitched
          .byte $27 ; Dancer
          .byte $4b ; Priest
          .byte $5c ; Mage
          .byte $74 ; LoptyrMage
          .byte $5e ; ThunderMage
          .byte $5d ; WindMage
          .byte $3a ; HighPriest
          .byte $44 ; Bishop
          .byte $1a ; Sage
          .byte $39 ; Bard
          .byte $15 ; Sister
          .byte $26 ; DarkMage
          .byte $24 ; DarkBishop
          .byte $0f ; Thief
          .byte $12 ; Rogue
          .byte $16 ; Civilian
          .byte $76 ; Ballistician
          .byte $05 ; BallisticianIron
          .byte $0c ; BallisticianKiller
          .byte $25 ; DarkPrince
          .byte $09 ; Fighter
          .byte $22 ; CavalierDismounted
          .byte $70 ; LanceKnightDismounted
          .byte $02 ; BowKnightDismounted
          .byte $08 ; AxeKnightDismounted
          .byte $4e ; SwordKnightDismounted
          .byte $37 ; TroubadourDismounted
          .byte $72 ; KnightLordDismounted
          .byte $29 ; DukeKnightDismounted
          .byte $6c ; MasterKnightDismounted
          .byte $3f ; PaladinDismounted
          .byte $40 ; PaladinFDismounted
          .byte $5a ; ArchKnightDismounted
          .byte $4a ; ForestKnightDismounted
          .byte $0e ; GreatKnightDismounted
          .byte $51 ; PegasusKnightDismounted
          .byte $46 ; FalconKnightDismounted
          .byte $34 ; WyvernRiderDismounted
          .byte $2c ; WyvernKnightDismounted
          .byte $30 ; WyvernMasterDismounted
          .byte $01 ; BowKnightF
          .byte $03 ; BowKnightFDismounted
          .byte $59 ; ArchKnightF
          .byte $5b ; ArchKnightFDismounted
          .byte $6b ; MasterKnightF
          .byte $6d ; MasterKnightFDismounted
          .byte $33 ; WyvernRiderF
          .byte $35 ; WyvernRiderFDismounted
          .byte $2b ; WyvernKnightF
          .byte $2d ; WyvernKnightFDismounted
          .byte $2f ; WyvernMasterF
          .byte $31 ; WyvernMasterFDismounted
          .byte $54 ; BallisticianPoison
          .byte $5f ; MageF
          .byte $61 ; ThunderMageF
          .byte $75 ; LoptyrMageF
          .byte $60 ; WindMageF
          .byte $63 ; MageKnightF
          .byte $1b ; SageF
          .byte $4c ; PriestF
          .byte $3b ; HighPriestF
          .byte $1e ; MyrmidonF
          .byte $48 ; HeroFE4F
          .byte $20 ; SwordmasterF
          .byte $57 ; ArcherF
          .byte $19 ; SniperF
          .byte $10 ; ThiefF
          .byte $13 ; RogueF
          .byte $66 ; Hero
          .byte $11 ; ThiefRogueSprite
          .byte $52 ; PegasusRider
          .byte $53 ; PegasusRiderDismounted
          .byte $23 ; Soldier
          .byte $04 ; ArcherEnemy
          .byte $67 ; HeroF

        .endblock

        aUnitWindowClassSortClassTable .block ; 9A/FDB0
          .byte BowKnight
          .byte BowKnightF
          .byte BowKnightDismounted
          .byte BowKnightFDismounted
          .byte ArcherEnemy
          .byte BallisticianIron
          .byte ArmoredAxe
          .byte AxeKnight
          .byte AxeKnightDismounted
          .byte Fighter
          .byte Warrior
          .byte Emperor
          .byte BallisticianKiller
          .byte GreatKnight
          .byte GreatKnightDismounted
          .byte Thief
          .byte ThiefF
          .byte ThiefRogueSprite
          .byte Rogue
          .byte RogueF
          .byte General
          .byte Sister
          .byte Civilian
          .byte JuniorLord
          .byte Sniper
          .byte SniperF
          .byte Sage
          .byte SageF
          .byte ArmoredSword
          .byte Myrmidon
          .byte MyrmidonF
          .byte Swordmaster
          .byte SwordmasterF
          .byte Cavalier
          .byte CavalierDismounted
          .byte Soldier
          .byte DarkBishop
          .byte DarkPrince
          .byte DarkMage
          .byte Dancer
          .byte DukeKnight
          .byte DukeKnightDismounted
          .byte WyvernKnight
          .byte WyvernKnightF
          .byte WyvernKnightDismounted
          .byte WyvernKnightFDismounted
          .byte WyvernMaster
          .byte WyvernMasterF
          .byte WyvernMasterDismounted
          .byte WyvernMasterFDismounted
          .byte WyvernRider
          .byte WyvernRiderF
          .byte WyvernRiderDismounted
          .byte WyvernRiderFDismounted
          .byte Troubadour
          .byte TroubadourDismounted
          .byte Berserker
          .byte Bard
          .byte HighPriest
          .byte HighPriestF
          .byte Pirate
          .byte Paladin
          .byte PaladinF
          .byte PaladinDismounted
          .byte PaladinFDismounted
          .byte Baron
          .byte BaronGlitched
          .byte Hunter
          .byte Bishop
          .byte FalconKnight
          .byte FalconKnightDismounted
          .byte HeroFE4
          .byte HeroFE4F
          .byte ForestKnight
          .byte ForestKnightDismounted
          .byte Priest
          .byte PriestF
          .byte SwordKnight
          .byte SwordKnightDismounted
          .byte Prince
          .byte PegasusKnight
          .byte PegasusKnightDismounted
          .byte PegasusRider
          .byte PegasusRiderDismounted
          .byte BallisticianPoison
          .byte ArmoredBow
          .byte Archer
          .byte ArcherF
          .byte ArchKnight
          .byte ArchKnightF
          .byte ArchKnightDismounted
          .byte ArchKnightFDismounted
          .byte Mage
          .byte WindMage
          .byte ThunderMage
          .byte MageF
          .byte WindMageF
          .byte ThunderMageF
          .byte MageKnight
          .byte MageKnightF
          .byte MageKnightDismounted
          .byte MageKnightFDismounted
          .byte Hero
          .byte HeroF
          .byte Brigand
          .byte BrigandAlternate
          .byte MasterKnight
          .byte MasterKnightF
          .byte MasterKnightDismounted
          .byte MasterKnightFDismounted
          .byte ArmoredLance
          .byte LanceKnight
          .byte LanceKnightDismounted
          .byte KnightLord
          .byte KnightLordDismounted
          .byte Lord
          .byte LoptyrMage
          .byte LoptyrMageF
          .byte Ballistician
        .endblock

      endData

      .endwith ; UnitWindowConfig

    .endsection UnitWindow9ASection

.endif ; GUARD_FE5_UNIT_WINDOW
