
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_STATUS_WINDOW :?= false
.if (!GUARD_FE5_STATUS_WINDOW)
  GUARD_FE5_STATUS_WINDOW := true

  ; Definitions

    .weak

      rlPushToOAMBuffer                             :?= address($808881)
      rlPlaySoundEffect                             :?= address($808C87)
      rsPostStatusWindowCallback                    :?= address($809E46)
      rlDMAByStruct                                 :?= address($80AE2E)
      rlDMAByPointer                                :?= address($80AEF9)
      rlAppendDecompList                            :?= address($80B00A)
      rlBlockCopy                                   :?= address($80B340)
      rlFillTilemapByWord                           :?= address($80E89F)
      rlEnableBG2Sync                               :?= address($81B206)
      rlEnableBG3Sync                               :?= address($81B212)
      rlGetFactionNamePointer                       :?= address($81E115)
      rlProcEngineCreateProc                        :?= address($829BF1)
      rlCopyCharacterDataToBufferByDeploymentNumber :?= address($83901C)
      rlGetCharacterNamePointer                     :?= address($839334)
      rlGetClassNamePointer                         :?= address($839351)
      rlDrawNumberMenuText                          :?= address($858859)
      rlUnknown8591F0                               :?= address($8591F0)
      rlUnknown859205                               :?= address($859205)
      rlUnknown859219                               :?= address($859219)
      rlSearchForUnitAndWriteTargetToBuffer         :?= address($83976E)
      rlCopyDarkMenuBackgroundGraphicsAndPalette    :?= address($8597D4)
      rlGetMapFactions                              :?= address($859A5F)
      rlDrawWindowBackgroundFromTilemapInfo         :?= address($87D6FC)
      rlDrawMenuText                                :?= address($87E728)
      rlGetPortraitGraphicsPointerByCharacter       :?= address($8CBFAD)
      rlGetPortraitPalettePointerByCharacter        :?= address($8CBFC7)
      rlCopyPackedTilemapSlice                      :?= address($8E8D79)
      rlGetChapterName                              :?= address($8FE55C)
      rlDrawDialogueText                            :?= address($94CC3D)
      rlDialogueGetStringWidthPixels                :?= address($958461)
      rlMenuTextStripLeadingSpace                   :?= address($9A98AA)

      acStatusWindowBG1Tilemap     :?= address($9EEC9B)
      acStatusWindowBG3Tilemap     :?= address($9EED79)
      acLeftFacingPortraitTilemap  :?= address($BEEAC9)
      g4bppDarkMenuBackgroundTiles :?= address($F4B000)
      aDarkMenuBackgroundPalette   :?= address($F4FEC0)

      aGenericBG3TilemapInfo :?= address($83C0F6)
      aGenericBG1TilemapInfo :?= address($83C0FF)

      procFadeWithCallback  :?= address($82A1BB)
      procRightFacingCursor :?= address($8EB06F)
      ; TODO: give this a better name?
      proclm                :?= address($94CCDF)

      TextWhite :?= 0
      TextBrown :?= 1
      TextBlue  :?= 2

    .endweak

    StatusWindowConfig .namespace

      OAMBase = $0000
      BG1Base = $4000
      BG2Base = BG1Base
      BG3Base = $A000

      BG1TilemapPosition = $E000
      BG2TilemapPosition = $F000
      ; BG3TilemapPosition = $A000 ; See below

      BG12TilesPosition := BG1Base
      BG12Allocate .function Size
        Return := StatusWindowConfig.BG12TilesPosition
        StatusWindowConfig.BG12TilesPosition += Size
      .endfunction Return

      BG3TilesPosition := BG3Base
      BG3Allocate .function Size
        Return := StatusWindowConfig.BG3TilesPosition
        StatusWindowConfig.BG3TilesPosition += Size
      .endfunction Return

      DarkMenuBackgroundTilesPosition = BG12Allocate(16 * 4 * size(Tile4bpp))
      MenuBackgroundTilesPosition     = BG12Allocate(16 * 4 * size(Tile4bpp))

      _ := BG12Allocate($9800 - BG12TilesPosition)

      PortraitTilesPosition = BG12Allocate(16 * 4 * size(Tile4bpp))

      BG3TilemapPosition     = BG3Allocate(32 * 32 * size(word))
      ChapterNamePosition    = BG3Allocate(32 * 2 * size(Tile2bpp))
      ObjectiveLine1Position = BG3Allocate(32 * 2 * size(Tile2bpp))
      ObjectiveLine2Position = BG3Allocate(32 * 2 * size(Tile2bpp))

      _ := BG3Allocate($B800 - BG3TilesPosition)

      BG3MenuTilesPosition = BG3Allocate(16 * 40 * size(Tile2bpp))

      ; Because this gets used so often, we'll calculate
      ; it ahead of time.

      BG3MenuTilesBaseTile = VRAMToTile(BG3MenuTilesPosition, BG3Base, size(Tile2bpp))

      ChapterNameWindow .namespace

        Position = ( 0, 0)
        Size     = (32, 4)

      .endnamespace

      ObjectiveWindow .namespace

        Position = ( 0, 4)
        Size     = (32, 9)

        ObjectiveLine1Position = Position + ( 7, 0)
        ObjectiveLine2Position = Position + ( 7, 2)

        CapturesNumberPosition = Position + (12, 4)
        WinsNumberPosition     = Position + (17, 4)

        TurnNumberPosition     = Position + (10, 6)
        FundsNumberPosition    = Position + (26, 6)

      .endnamespace

      CombatantsLabelWindow .namespace

        Position = ( 0, 13)
        Size     = (15,  4)

      .endnamespace

      CombatantsWindow .namespace

        Position = ( 0, 17)
        Size     = (15, 11)

        RowBases = iter.map(iter.reversed, iter.zip_single(range(5) * 2, 0))

        CursorOffset = Position + ( 1, 0) ; Needs to be turned into pixels
        NameOffset   = Position + ( 3, 0)
        CountOffset  = Position + (12, 0)

        ; Helper function
        _AddOffset .sfunction Offset, iter.starmap(op.add, iter.zip_single(RowBases, Offset))

        CursorPositions = iter.starmap(op.mul, iter.zip_single(_AddOffset(CursorOffset), (8, 8)))
        NamePositions   = _AddOffset(NameOffset)
        CountPositions  = _AddOffset(CountOffset)

      .endnamespace

      LeaderLabelWindow .namespace

        Position = (15, 13)
        Size     = (17,  4)

      .endnamespace

      LeaderWindow .namespace

        Position = (15, 17)
        Size     = (13, 11)

        NameWidth       =  8
        ClassWidth      =  9
        LevelLineWidth  =  8
        HPLineWidth     =  8
        LeaderlessWidth = 14

        NamePosition  = Position + (3, 1)
        ClassPosition = Position + (1, 3)

        LevelLabelPosition = Position + (1, 5)
        HPLabelPosition    = Position + (1, 7)

        LevelNumberPosition = LevelLabelPosition + (7, 0)

        CurrentHPNumberPosition = HPLabelPosition + (4, 0)
        MaxHPNumberPosition     = HPLabelPosition + (7, 0)

        LeaderlessPosition = Position + (2, 4)

        MapSpritePosition = (Position + (1, 1)) * (8, 8)

        PortraitPosition = Position + (10, 1)

      .endnamespace

    .endnamespace

  ; Freespace inclusions

    .section StatusWindowSection

      .with StatusWindowConfig

      startDialogue

        dialogueChapter01ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER01/ObjectiveLine1.dialogue.txt"       ; 8A/B645
        dialogueChapter02ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER02/ObjectiveLine1.dialogue.txt"       ; 8A/B650
        dialogueChapter02ObjectiveLine2Unused .include "../TEXT/DIALOGUE/CHAPTER02/ObjectiveLine2Unused.dialogue.txt" ; 8A/B65B
        dialogueChapter02xObjectiveLine1      .include "../TEXT/DIALOGUE/CHAPTER02x/ObjectiveLine1.dialogue.txt"      ; 8A/B66B
        dialogueChapter03ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER03/ObjectiveLine1.dialogue.txt"       ; 8A/B675
        dialogueChapter04ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER04/ObjectiveLine1.dialogue.txt"       ; 8A/B67E
        dialogueChapter04ObjectiveLine2Unused .include "../TEXT/DIALOGUE/CHAPTER04/ObjectiveLine2Unused.dialogue.txt" ; 8A/B68D
        dialogueChapter04xObjectiveLine1      .include "../TEXT/DIALOGUE/CHAPTER04x/ObjectiveLine1.dialogue.txt"      ; 8A/B69C
        dialogueChapter05ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER05/ObjectiveLine1.dialogue.txt"       ; 8A/B6AB
        dialogueChapter06ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER06/ObjectiveLine1.dialogue.txt"       ; 8A/B6BA
        dialogueChapter07ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER07/ObjectiveLine1.dialogue.txt"       ; 8A/B6C9
        dialogueChapter08ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER08/ObjectiveLine1.dialogue.txt"       ; 8A/B6D8
        dialogueChapter08ObjectiveLine2Unused .include "../TEXT/DIALOGUE/CHAPTER08/ObjectiveLine2Unused.dialogue.txt" ; 8A/B6E3
        dialogueChapter08xObjectiveLine1      .include "../TEXT/DIALOGUE/CHAPTER08x/ObjectiveLine1.dialogue.txt"      ; 8A/B6F1
        dialogueChapter09ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER09/ObjectiveLine1.dialogue.txt"       ; 8A/B6FA
        dialogueChapter10ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER10/ObjectiveLine1.dialogue.txt"       ; 8A/B715
        dialogueChapter11ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER11/ObjectiveLine1.dialogue.txt"       ; 8A/B71D
        dialogueChapter11ObjectiveLine2Unused .include "../TEXT/DIALOGUE/CHAPTER11/ObjectiveLine2Unused.dialogue.txt" ; 8A/B726
        dialogueChapter11xObjectiveLine1      .include "../TEXT/DIALOGUE/CHAPTER11x/ObjectiveLine1.dialogue.txt"      ; 8A/B741
        dialogueChapter12ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER12/ObjectiveLine1.dialogue.txt"       ; 8A/B74A
        dialogueChapter12ObjectiveLine2Unused .include "../TEXT/DIALOGUE/CHAPTER12/ObjectiveLine2Unused.dialogue.txt" ; 8A/B755
        dialogueChapter12xObjectiveLine1      .include "../TEXT/DIALOGUE/CHAPTER12x/ObjectiveLine1.dialogue.txt"      ; 8A/B765
        dialogueChapter13ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER13/ObjectiveLine1.dialogue.txt"       ; 8A/B76E
        dialogueChapter14ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER14/ObjectiveLine1.dialogue.txt"       ; 8A/B787
        dialogueChapter14ObjectiveLine2Unused .include "../TEXT/DIALOGUE/CHAPTER14/ObjectiveLine2Unused.dialogue.txt" ; 8A/B794
        dialogueChapter14xObjectiveLine1      .include "../TEXT/DIALOGUE/CHAPTER14x/ObjectiveLine1.dialogue.txt"      ; 8A/B7A6
        dialogueChapter15ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER15/ObjectiveLine1.dialogue.txt"       ; 8A/B7B5
        dialogueChapter15ObjectiveLine2       .include "../TEXT/DIALOGUE/CHAPTER15/ObjectiveLine2.dialogue.txt"       ; 8A/B7CA
        dialogueChapter16AObjectiveLine1      .include "../TEXT/DIALOGUE/CHAPTER16A/ObjectiveLine1.dialogue.txt"      ; 8A/B7DB
        dialogueChapter17AObjectiveLine1      .include "../TEXT/DIALOGUE/CHAPTER17A/ObjectiveLine1.dialogue.txt"      ; 8A/B7E3
        dialogueChapter16BObjectiveLine1      .include "../TEXT/DIALOGUE/CHAPTER16B/ObjectiveLine1.dialogue.txt"      ; 8A/B7EC
        dialogueChapter17BObjectiveLine1      .include "../TEXT/DIALOGUE/CHAPTER17B/ObjectiveLine1.dialogue.txt"      ; 8A/B7FB
        dialogueChapter18ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER18/ObjectiveLine1.dialogue.txt"       ; 8A/B804
        dialogueChapter19ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER19/ObjectiveLine1.dialogue.txt"       ; 8A/B80D
        dialogueChapter20ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER20/ObjectiveLine1.dialogue.txt"       ; 8A/B81C
        dialogueChapter21ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER21/ObjectiveLine1.dialogue.txt"       ; 8A/B833
        dialogueChapter21xObjectiveLine1      .include "../TEXT/DIALOGUE/CHAPTER21x/ObjectiveLine1.dialogue.txt"      ; 8A/B83B
        dialogueChapter22ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER22/ObjectiveLine1.dialogue.txt"       ; 8A/B84A
        dialogueChapter23ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER23/ObjectiveLine1.dialogue.txt"       ; 8A/B852
        dialogueChapter24ObjectiveLine1       .include "../TEXT/DIALOGUE/CHAPTER24/ObjectiveLine1.dialogue.txt"       ; 8A/B85A
        dialogueChapter24ObjectiveLine2Unused .include "../TEXT/DIALOGUE/CHAPTER24/ObjectiveLine2Unused.dialogue.txt" ; 8A/B863
        dialogueChapter24xObjectiveLine1      .include "../TEXT/DIALOGUE/CHAPTER24x/ObjectiveLine1.dialogue.txt"      ; 8A/B874
        dialogueChapterFinalObjectiveLine1    .include "../TEXT/DIALOGUE/CHAPTERFINAL/ObjectiveLine1.dialogue.txt"    ; 8A/B883

      endDialogue
      startCode

        rlCreateStatusWindow ; 8A/B88C

          .al
          .xl
          .autsiz
          .databank ?

          ; Handles building the status window.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          php
          phb

          sep #$20

          lda #`lWindowBackgroundPatternPointer
          pha

          rep #$20

          plb

          .databank `lWindowBackgroundPatternPointer

          stz wBufferBG1VOFS
          stz wBufferBG1HOFS
          stz wBufferBG2VOFS
          stz wBufferBG2HOFS
          stz wBufferBG3VOFS
          stz wBufferBG3HOFS

          jsl rlUnknown8591F0

          lda #ObjectiveWindow.Position[1]
          sta wR0
          lda #ObjectiveWindow.Size[1]
          sta wR1
          jsl rlUnknown859219

          ; Unknown, some previous iteration?

          lda #14
          sta wR0
          lda #4
          sta wR1
          ; jsl rlUnknown859219

          lda #CombatantsWindow.Position[1]
          sta wR0
          lda #CombatantsWindow.Size[1]
          sta wR1
          jsl rlUnknown859219

          jsl rlUnknown859205

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

          lda #<>aBG2TilemapBuffer
          sta wR0

          _BaseTile := VRAMToTile(DarkMenuBackgroundTilesPosition, BG1Base, size(Tile4bpp))

          lda #TilemapEntry(_BaseTile + C2I((15, 47)), 0, false, false, false)
          jsl rlFillTilemapByWord

          lda #(`acStatusWindowBG1Tilemap)<<8
          sta lR18+size(byte)
          lda #<>acStatusWindowBG1Tilemap
          sta lR18

          lda #(`aBG1TilemapBuffer)<<8
          sta lR19+size(byte)
          lda #<>aBG1TilemapBuffer
          sta lR19

          jsl rlAppendDecompList

          lda #(`acStatusWindowBG3Tilemap)<<8
          sta lR18+size(byte)
          lda #<>acStatusWindowBG3Tilemap
          sta lR18

          lda #(`aBG3TilemapBuffer)<<8
          sta lR19+size(byte)
          lda #<>aBG3TilemapBuffer
          sta lR19

          jsl rlAppendDecompList

          jsl rlBuildStatusWindow

          jsl rlDMAByStruct

            .dstruct structDMAToVRAM, aBG1TilemapBuffer, (28 * 32 * size(word)), VMAIN_Setting(true), BG1TilemapPosition

          jsl rlDMAByStruct

            .dstruct structDMAToVRAM, aBG2TilemapBuffer, (28 * 32 * size(word)), VMAIN_Setting(true), BG2TilemapPosition

          jsl rlDMAByStruct

            .dstruct structDMAToVRAM, aBG3TilemapBuffer, (28 * 32 * size(word)), VMAIN_Setting(true), BG3TilemapPosition

          plb
          plp
          rtl

          .databank 0

        rsStatusWindowClearLeaderText ; 8A/B97C

          .al
          .xl
          .autsiz
          .databank ?

          ; This clears the parts of the BG3 tilemap
          ; that are used for leader-related text on the
          ; status window. It's used when switching leaders.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #(`aGenericBG3TilemapInfo)<<8
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b

          lda #TilemapEntry(BG3MenuTilesBaseTile, TextWhite, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          .with LeaderWindow

          _ClearLines  := [(NamePosition,       NameWidth)]
          _ClearLines ..= [(ClassPosition,      ClassWidth)]
          _ClearLines ..= [(LevelLabelPosition, LevelLineWidth)]
          _ClearLines ..= [(HPLabelPosition,    HPLineWidth)]
          _ClearLines ..= [(LeaderlessPosition, LeaderlessWidth)]

          .for _Position, _Width in _ClearLines

            ldx #pack(_Position)

            lda #(`(+))<<8
            sta lR18+size(byte)
            lda #<>(+)
            sta lR18

            jsl rlDrawMenuText

            bra ++

              endCode
              startMenuText

              .enc "SJIS"
              + .text ("　" x _Width) .. "\n"

              endMenuText
              startCode

            +

          .endfor

          .endwith

          rts

          .databank 0

      endCode
      startProcs

        procStatusWindowMapSprite .structProcInfo "xx", None, rlProcStatusWindowMapSpriteOnCycle, None ; 8A/BA56

      endProcs
      startCode

        rlProcStatusWindowMapSpriteOnCycle ; 8A/BA5E

          .al
          .xl
          .autsiz
          .databank ?

          ; This is a long-return wrapper for the
          ; sprite renderer.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          jsr rsProcStatusWindowMapSpriteRenderSprite
          rtl

          .databank 0

        rsProcStatusWindowMapSpriteRenderSprite ; 8A/BA62

          .al
          .xl
          .autsiz
          .databank ?

          ; This renders the leader's map sprite on
          ; the status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          phb
          php

          sep #$20

          lda #`wStatusWindowIndex
          pha

          rep #$20

          plb

          .databank `wStatusWindowIndex

          ; Don't display a map sprite if the
          ; faction doesn't have a leader on the field.

          lda wStatusWindowIndex
          asl a
          tax
          lda aStatusWindowLeaders,x
          bmi _End

            sta wR0
            lda #<>aSelectedCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            ; Get their palette based on allegiance and
            ; whether they're petrified or not.

            lda aSelectedCharacterBuffer.DeploymentNumber,b
            and #$00FF
            and #AllAllegiances
            asl a
            asl a
            asl a
            sta wR5

            lda aSelectedCharacterBuffer.Status,b
            and #$00FF
            cmp #StatusPetrify
            bne +

              lda #OAMTileAndAttr(0, 3, 0, false, false)
              sta wR5

            +
            lda aSelectedCharacterBuffer.SpriteInfo2,b
            sta wR4

            lda #LeaderWindow.MapSpritePosition[0]
            sta wR0

            lda #LeaderWindow.MapSpritePosition[1]
            sta wR1

            ; Determine whether they're a short of tall map sprite.

            lda aSelectedCharacterBuffer.SpriteInfo1,b
            and #$00FF
            bit #$0080
            bne _Tall

              ldy #<>_ShortSprite
              bra +

            _Tall

              ldy #<>_TallSprite
              ; bra +

            +
            phb
            php

            phk
            plb

            .databank `*

            jsl rlPushToOAMBuffer

            plp
            plb

            .databank `wStatusWindowIndex

          _End

          plp
          plb
          rts

          _ShortSprite .dstruct structSpriteArray, [[[0, 0], $21, SpriteLarge, C2I((0,  0)), 3, 0, false, false]]
          _TallSprite  .dstruct structSpriteArray, [[[0, -16], $21, SpriteLarge, C2I((2, 0)), 3, 0, false, false], [[0, 0], $21, SpriteLarge, C2I((0,  0)), 3, 0, false, false]]

          .databank 0

      endCode
      startProcs

        procStatusWindow .block
          .structProcInfo "st", None, None, aProcStatusWindowCode ; 8A/BAE1

          aCursorProcOffset = aProcSystem.aBody0

        .endblock

      endProcs
      startCode

        rlBuildStatusWindow ; 8A/BAE9

          .al
          .xl
          .autsiz
          .databank ?

          ; Handles populating the status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          phb
          php

          sep #$20

          lda #`wStatusWindowIndex
          pha

          rep #$20

          plb

          .databank `wStatusWindowIndex

          ; Clear some initial data.

          ldx #size(word) * (5 - 1)

          -
          stz aStatusWindowFactionCount,x
          stz aStatusWindowLeaderCharacters,x

          .rept size(word)
            dec x
          .endrept

          bpl -

          stz wStatusWindowIndex

          jsl rlGetMapFactions

          jsr rsStatusWindowDrawTurnNumber
          jsr rsStatusWindowDrawFunds
          jsr rsStatusWindowDrawCaptures
          jsr rsStatusWindowDrawWins
          jsr rsStatusWindowGetLeaderDeploymentNumbers
          jsr rsStatusWindowGetFactionCountAndDrawTurn
          jsr rsStatusWindowDrawFactionText
          jsr rsStatusWindowGetLeaderPortraitsAndTilemap
          jsr rsStatusWindowUpdateLeader

          plp
          plb
          rtl

          .databank 0

      endCode
      startProcs

        aProcStatusWindowCode .block ; 8A/BB25

          PROC_YIELD 1
          PROC_CREATE_PROC procStatusWindowMapSprite

          PROC_CALL rlStatusWindowDrawChapterName
          PROC_HALT_WHILE proclm

          PROC_CALL rlStatusWindowDrawObjectiveLine1
          PROC_HALT_WHILE proclm

          PROC_CALL rlStatusWindowDrawObjectiveLine2
          PROC_HALT_WHILE proclm

          PROC_CALL rlStatusWindowCreateCursor

          PROC_CALL_ARGS $94DA10, size(_Args1)
          _Args1 .block
            .byte 1
          .endblock

          -
          PROC_YIELD 1
          PROC_JUMP_IF_ROUTINE_FALSE -, $94DA22

          PROC_SET_ONCYCLE rlStatusWindowHandleInput
          PROC_YIELD 1

          PROC_SET_ONCYCLE None
          PROC_HALT

        .endblock

      endProcs
      startCode

        rlStatusWindowGetChapterNameCentering ; 8A/BB6B

          .autsiz
          .databank ?

          ; This figures out how many tiles the chapter
          ; name needs to be shifted by to be centered.

          ; Inputs:
          ; lR18: long pointer to chapter name dialogue text

          ; Outputs:
          ; A: offset in tiles

          php
          rep #$30
          phx
          phy

          lda lR18+size(byte)
          sta lDialogueEngineTextPointer+size(byte),b
          lda lR18
          sta lDialogueEngineTextPointer,b

          lda lR18
          pha
          lda lR18+size(byte)
          pha

          jsl rlDialogueGetStringWidthPixels

          pla
          sta lR18+size(byte)
          pla
          sta lR18

          lda #256
          sec
          sbc wDialogueEngineTotalPixelWidth,b

          clc
          adc #4

          lsr a
          lsr a
          lsr a
          lsr a

          ply
          plx
          plp
          rtl

          .databank 0

        rlStatusWindowGetDialogueTextWidthTiles ; 8A/BB9D

          .autsiz
          .databank ?

          ; Gets the width of a piece of dialogue text
          ; in tiles.

          ; Inputs:
          ; lR18: long pointer to dialogue text

          ; Outputs:
          ; A: width in tiles

          php
          rep #$30
          phx
          phy

          lda lR18+size(byte)
          sta lDialogueEngineTextPointer+size(byte),b
          lda lR18
          sta lDialogueEngineTextPointer,b

          lda lR18
          pha
          lda lR18+size(byte)
          pha

          jsl rlDialogueGetStringWidthPixels

          pla
          sta lR18+size(byte)
          pla
          sta lR18

          lda wDialogueEngineTotalPixelWidth,b

          clc
          adc #7

          lsr a
          lsr a
          lsr a

          ply
          plx
          plp
          rtl

          .databank 0

        rlStatusWindowDrawChapterName ; 8A/BBCA

          .al
          .xl
          .autsiz
          .databank ?

          ; Draws the chapter name on the status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda wCurrentChapter,b
          jsl rlGetChapterName

          jsl rlStatusWindowGetChapterNameCentering
          ora #pack([None, 1])
          pha

          ; TODO: figure these out

          lda #(ChapterNamePosition - BG3Base) >> 1
          sta wR0

          lda #int(true)
          sta wR1

          lda #$0000
          sta wR2

          lda #$0000
          sta wR3

          plx
          jsl rlDrawDialogueText
          rtl

          .databank 0

        rsStatusWindowDrawWins ; 8A/BBF3

          .al
          .xl
          .autsiz
          .databank ?

          ; Draws the player's total wins on
          ; the status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #(`aGenericBG3TilemapInfo)<<8
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b

          lda #TilemapEntry(BG3MenuTilesBaseTile + C2I((0, 18)), TextWhite, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          ; The game keeps tracks of normal wins separately,
          ; but displays a combined wins+captures.

          ; Have to check for overflow before we check against
          ; a cap.

          lda wWinCounter,b
          clc
          adc wCaptureCounter,b
          bcs _Cap

          cmp #9999
          beq +
          blt +

          _Cap
            lda #9999

          +
          sta lR18
          stz lR18+size(word)
          ldx #pack(ObjectiveWindow.WinsNumberPosition)
          jsl rlDrawNumberMenuText

          rts

          .databank 0

        rsStatusWindowDrawCaptures ; 8A/BC24

          .al
          .xl
          .autsiz
          .databank ?

          ; Draws the player's captures on
          ; the status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #(`aGenericBG3TilemapInfo)<<8
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b

          lda #TilemapEntry(BG3MenuTilesBaseTile + C2I((0, 18)), TextWhite, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          ; Have to check for overflow before we check against
          ; a cap.

          lda wCaptureCounter,b
          cmp #9999
          beq +
          blt +

            lda #9999

          +
          sta lR18
          stz lR18+size(word)
          ldx #pack(ObjectiveWindow.CapturesNumberPosition)
          jsl rlDrawNumberMenuText

          rts

          .databank 0

        rlStatusWindowDrawObjectiveLine1 ; 8A/BC4F

          .al
          .xl
          .autsiz
          .databank ?

          ; Draws the first line of the chapter's
          ; objective on the status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda wCurrentChapter,b
          jsl rlGetChapterObjectiveLine1

          lda #(ObjectiveLine1Position - BG3Base) >> 1
          sta wR0

          lda #int(true)
          sta wR1

          lda #$0000
          sta wR2

          lda #$0000
          sta wR3

          ldx #pack(ObjectiveWindow.ObjectiveLine1Position)
          jsl rlDrawDialogueText
          rtl

          .databank 0

        rlStatusWindowDrawObjectiveLine2 ; 8A/BC72

          .al
          .xl
          .autsiz
          .databank ?

          ; Draws the second line of the chapter's
          ; objective on the status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda wCurrentChapter,b
          jsl rlGetChapterObjectiveLine2

          ; Only chapter 15 in vanilla gets a second
          ; line, all other chapters get a null pointer,
          ; which means we need to skip them.

          lda lR18
          beq +

            lda #(ObjectiveLine2Position - BG3Base) >> 1
            sta wR0

            lda #int(true)
            sta wR1

            lda #$0000
            sta wR2

            lda #$0000
            sta wR3

            ldx #pack(ObjectiveWindow.ObjectiveLine2Position)
            jsl rlDrawDialogueText

          +
          rtl

          .databank 0

        rlStatusWindowHandleInput ; 8A/BC99

          .al
          .xl
          .autsiz
          .databank ?

          ; Handles inptu on the status window.

          ; Inputs:
          ; X: offset of proc in aProcSystem

          ; Outputs:
          ; aProcSystem
          ;   aHeaderSleepTimer,b,x: 1 if `B` was pressed else 0

          phb
          php

          sep #$20

          lda #`wStatusWindowIndex
          pha

          rep #$20

          plb

          .databank `wStatusWindowIndex

          stz aProcSystem.aHeaderSleepTimer,b,x

          lda wStatusWindowIndex
          pha

          ; Up/Down scrolls through the faction list.
          ; Held presses stop at the top/bottom while new
          ; presses can loop.

          lda wJoy1Repeated
          bit #JOY_Up
          beq _CheckDown

            lda wStatusWindowIndex
            beq +

              dec a
              sta wStatusWindowIndex
              bra _UpdatePosition

            +
            lda wJoy1New
            bit #JOY_Up
            beq _UpdatePosition

              lda wStatusWindowCount
              dec a
              sta wStatusWindowIndex
              bra _UpdatePosition

          _CheckDown
            lda wJoy1Repeated
            bit #JOY_Down
            beq _AfterDirection

              lda wStatusWindowIndex
              inc a
              cmp wStatusWindowCount
              beq +

                sta wStatusWindowIndex
                bra _UpdatePosition

              +
              lda wJoy1New
              bit #JOY_Down
              beq _UpdatePosition

                stz wStatusWindowIndex
                ; bra _UpdatePosition

          _UpdatePosition

            ; Set the new cursor position and update the leader.

            ldx aProcSystem.wOffset,b
            lda procStatusWindow.aCursorProcOffset,b,x
            tax

            lda wStatusWindowIndex
            jsr rsStatusWindowGetCursorPosition

            ; TODO: proc defs for the cursor

            lda wR0
            sta aProcSystem.aBody0,b,x
            lda wR1
            sta aProcSystem.aBody1,b,x

            jsr rsStatusWindowUpdateLeader

          _AfterDirection

          ; This is the index before updating.
          ; If it changed, play a moving sound.

          pla

          cmp wStatusWindowIndex
          beq +

            lda #$0009 ; TODO: sound definitions
            jsl rlPlaySoundEffect

          +

          ; Next, check if we need to close the menu.

          lda wJoy1New
          bit #JOY_B
          beq +

            ldx aProcSystem.wOffset,b
            lda #1
            sta aProcSystem.aHeaderSleepTimer,b,x

            lda #$0021 ; TODO: sound definitions
            jsl rlPlaySoundEffect

            lda #<>rsPostStatusWindowCallback
            sta aProcSystem.wInput0,b

            lda #(`procFadeWithCallback)<<8
            sta lR44+size(byte)
            lda #<>procFadeWithCallback
            sta lR44
            jsl rlProcEngineCreateProc

          +
          plp
          plb
          rtl

          .databank 0

        rsStatusWindowUpdateLeader ; 8A/BD40

          .al
          .xl
          .autsiz
          .databank ?

          ; Updates which leader is being displayed
          ; on the status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          phb
          php

          sep #$20

          lda #`wStatusWindowIndex
          pha

          rep #$20

          plb

          .databank `wStatusWindowIndex

          ; Start by clearing everything so that
          ; we're prepared for shorter names or
          ; leaderless factions.

          jsr rsStatusWindowClearLeaderText

          lda wStatusWindowIndex
          asl a
          tax

          lda aStatusWindowLeaderCharacters,x
          sta wStatusWindowCurrentLeader
          beq _NoLeader

          lda aStatusWindowLeaders,x
          bmi _NoLeader

            ; We have a leader, draw their text and get their
            ; portrait graphics. Reenable BG layer 2 (the portrait layer).

            sta wR0
            lda #<>aSelectedCharacterBuffer
            sta wR1
            jsl rlCopyCharacterDataToBufferByDeploymentNumber

            jsr rsStatusWindowDrawLeaderText
            jsr rsStatusWindowPickLeaderPortrait

            jsl rlEnableBG3Sync

            sep #$20

            lda #T_Setting(true, true, true, false, true)
            sta bBufferTM

            rep #$20

            plp
            plb
            rts

          _NoLeader

            stz wStatusWindowCurrentLeader

            ; We just disable BG layer 2 to hide the portrait.

            sep #$20

            lda #T_Setting(true, false, true, false, true)
            sta bBufferTM

            rep #$20

            ; Draw the leaderless text.

            lda #(`aGenericBG3TilemapInfo)<<8
            sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
            lda #<>aGenericBG3TilemapInfo
            sta aCurrentTilemapInfo.lInfoPointer,b

            lda #TilemapEntry(BG3MenuTilesBaseTile, TextWhite, true, false, false)
            sta aCurrentTilemapInfo.wBaseTile,b

            ldx #pack(LeaderWindow.LeaderlessPosition)

            lda #(`(+))<<8
            sta lR18+size(byte)
            lda #<>(+)
            sta lR18

            jsl rlDrawMenuText
            bra ++

              endCode
              startMenuText

              .enc "SJIS"
              + .text "この軍にリーダーはいません\n"

              endMenuText
              startCode

            +

            jsl rlEnableBG3Sync

            plp
            plb
            rts

          .databank 0

        rsStatusWindowDrawLeaderText ; 8A/BDD2

          .al
          .xl
          .autsiz
          .databank ?

          ; Draws the labels and text for a leader
          ; on the status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #(`aGenericBG3TilemapInfo)<<8
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b

          lda #TilemapEntry(BG3MenuTilesBaseTile, TextBrown, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          .with LeaderWindow

          .enc "SJIS"

          .for _Position, _Text in [(LevelLabelPosition, "ＬＶ\n"), (HPLabelPosition, "ＨＰ　　　／\n")]

            ldx #pack(_Position)

            lda #(`(+))<<8
            sta lR18+size(byte)
            lda #<>(+)
            sta lR18

            jsl rlDrawMenuText
            bra ++

              endCode
              startMenuText

              .enc "SJIS"
              + .text _Text

              endMenuText
              startCode

            +

          .endfor

          .endwith

          lda #TilemapEntry(BG3MenuTilesBaseTile, TextWhite, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          lda aSelectedCharacterBuffer.Character,b
          jsl rlGetCharacterNamePointer
          ldx #pack(LeaderWindow.NamePosition)
          jsl rlDrawMenuText

          lda aSelectedCharacterBuffer.Class,b
          and #$00FF
          jsl rlGetClassNamePointer
          ldx #pack(LeaderWindow.ClassPosition)
          jsl rlDrawMenuText

          lda #TilemapEntry(BG3MenuTilesBaseTile + C2I((0, 18)), TextWhite, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          .with LeaderWindow

          _LeaderStats  := [(LevelNumberPosition, aSelectedCharacterBuffer.Level)]
          _LeaderStats ..= [(CurrentHPNumberPosition, aSelectedCharacterBuffer.CurrentHP)]
          _LeaderStats ..= [(MaxHPNumberPosition, aSelectedCharacterBuffer.MaxHP)]

          .for _Position, _Stat in _LeaderStats

            lda _Stat,b
            and #$00FF
            sta lR18
            stz lR18+size(word)

            ldx #pack(_Position)

            jsl rlDrawNumberMenuText

          .endfor

          .endwith

          rts

          .databank 0

        rlStatusWindowCreateCursor ; 8A/BE7D

          .al
          .xl
          .autsiz
          .databank ?

          ; Creates the cursor proc for the status window.

          ; Inputs:
          ; None

          ; Outputs:
          ; procRightFacingCursor

          lda wStatusWindowIndex
          jsr rsStatusWindowGetCursorPosition

          lda wR0
          sta aProcSystem.wInput0,b

          lda wR1
          sta aProcSystem.wInput1,b

          lda #(`procRightFacingCursor)<<8
          sta lR44+size(byte)
          lda #<>procRightFacingCursor
          sta lR44

          jsl rlProcEngineCreateProc

          ; Offset of cursor proc in aProcSystem

          ldx aProcSystem.wOffset,b
          sta procStatusWindow.aCursorProcOffset,b,x

          rtl

          .databank 0

        rsStatusWindowGetCursorPosition ; 8A/BEA3

          .al
          .xl
          .autsiz
          .databank ?

          ; Gets the cursor position for the status window.

          ; Inputs:
          ; A: line index
          
          ; Outputs:
          ; wR0: X coordinate in pixels
          ; wR1: Y coordinate in pixels

          phx
          asl a
          tax
          lda _Coordinates,x
          and #$00FF
          sta wR0
          lda _Coordinates+size(byte),x
          and #$00FF
          sta wR1
          plx
          rts

          _Coordinates .for _Coords in CombatantsWindow.CursorPositions

            .word pack(_Coords)

          .endfor

          .databank 0

        rsStatusWindowDrawFactionText ; 8A/BEC4

          .al
          .xl
          .autsiz
          .databank ?

          ; Draws all of the factions on the
          ; status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          phb
          php

          sep #$20

          lda #`wStatusWindowIndex
          pha

          rep #$20

          plb

          .databank `wStatusWindowIndex

          ldy #0
          ldx #0

          ; For each faction slot, draw a line if there
          ; are members of the faction on the map.

          -
          lda aStatusWindowFactionCount,x
          beq +

            jsr rsStatusWindowDrawFactionTextLine
            inc y
            inc y

          +
          inc x
          inc x
          cpx #5 * size(word)
          bne -

          plp
          plb
          rts

          .databank 0

        rsStatusWindowDrawFactionTextLine ; 8A/BEE8

          .al
          .xl
          .autsiz
          .databank ?

          ; Draws a single faction's name and
          ; member count to the status window.

          ; Inputs:
          ; A: Faction member count
          ; Y: Row offset

          ; Outputs:
          ; None

          phx
          phy

          ; Store members and row.

          sta wR15
          tya

          xba
          sta wR14

          lda aStatusWindowLeaderCharacters,x
          jsl rlGetFactionNamePointer
          jsl rlMenuTextStripLeadingSpace

          lda #pack(CombatantsWindow.NameOffset)
          clc
          adc wR14
          tax

          lda #(`aGenericBG3TilemapInfo)<<8
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b

          lda #TilemapEntry(BG3MenuTilesBaseTile, TextWhite, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          jsl rlDrawMenuText

          lda #(`aGenericBG3TilemapInfo)<<8
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b

          lda #TilemapEntry(BG3MenuTilesBaseTile + C2I((0, 18)), TextBlue, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          lda #pack(CombatantsWindow.CountOffset)
          clc
          adc wR14
          tax

          ; I don't know why this strips off the allegiance
          ; bits, because they're not set by the counting
          ; function.

          lda wR15
          and #~AllAllegiances
          sta lR18
          stz lR18+size(word)
          jsl rlDrawNumberMenuText

          plx
          ply
          rts

          .databank 0

      endCode
      startData

        ; Presumably some previous version (debugging version?)
        ; of the status window showed which allegiance a faction
        ; belonged to.

        aUnknown8ABF42 .block ; 8A/BF42
          .addr menutextUnknown8ABF4A
          .addr menutextUnknown8ABF58
          .addr menutextUnknown8ABF64
          .addr menutextUnknown8ABF6C
        .endblock

      endData
      startMenuText

        .enc "SJIS"

        menutextUnknown8ABF4A .text "ＰＬＡＹＥＲ\n"
        menutextUnknown8ABF58 .text "ＥＮＥＭＹ\n"
        menutextUnknown8ABF64 .text "３ＲＤ\n"
        menutextUnknown8ABF6C .text "４ＴＨ\n"

      endMenuText
      startCode

        rsStatusWindowGetLeaderDeploymentNumbers ; 8A/BF74

          .al
          .xl
          .autsiz
          .databank `wStatusWindowIndex

          ; This builds a list of leaders for the
          ; status window.

          ; Inputs:
          ; aStatusWindowTempLeaderList: filled with leader
          ;   character ID words.

          ; Outputs:
          ; aStatusWindowLeaderCharacters: filled with leader
          ;   character ID words.
          ; aStatusWindowLeaders: filled with leader deployment
          ;   number words, -1 if there is no leader on the field
          ;   for the given faction.

          .for _i in range(0, 5 * size(word), size(word))

            lda @l aStatusWindowTempLeaderList+_i
            sta @l aStatusWindowLeaderCharacters+_i

          .endfor

          ldx #size(word) * (5 - 1)

          -
          lda #-1
          sta aStatusWindowLeaders,x

          lda aStatusWindowLeaderCharacters,x
          sta wR0
          lda #<>aSelectedCharacterBuffer
          sta wR1
          jsl rlSearchForUnitAndWriteTargetToBuffer
          ora #0
          bne +

            lda aSelectedCharacterBuffer.DeploymentNumber,b
            and #$00FF
            sta aStatusWindowLeaders,x

          +
          .rept size(word)
            dec x
          .endrept

          bpl -

          rts

          .databank 0

        rsStatusWindowGetFactionCountAndDrawTurn ; 8A/BFC6

          .al
          .xl
          .autsiz
          .databank ?

          ; Gets the total number of factions and
          ; (accidentally?) draws the turn count to
          ; the status window.

          ; Inputs:
          ; aStatusWindowTempCountList: list of faction count words

          ; Outputs:
          ; wStatusWindowCount: number of factions
          ; aStatusWindowFactionCount: list of faction count words

          ldx #0

          -
          lda aStatusWindowTempCountList,x
          beq +

            sta aStatusWindowFactionCount,x
            inc x
            inc x
            cpx #5 * size(word)
            bne -

          +
          txa
          lsr a
          sta wStatusWindowCount

          ; I feel like this is missing its `rts`.

          .databank 0

        rsStatusWindowDrawTurnNumber ; 8A/BFE0

          .al
          .xl
          .autsiz
          .databank ?

          ; Draws the turn count to the status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #(`aGenericBG3TilemapInfo)<<8
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b

          lda #TilemapEntry(BG3MenuTilesBaseTile + C2I((0, 18)), TextWhite, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          stz lR18+size(word)

          lda wCurrentTurn,b
          sta lR18
          ldx #pack(ObjectiveWindow.TurnNumberPosition)
          jsl rlDrawNumberMenuText

          rts

          .databank 0

      endCode
      startMenuText

        .enc "SJIS"

        menutextUnknown8AC001 .text "ターン\n" ; 8A/C001

      endMenuText
      startCode

        rsStatusWindowDrawFunds ; 8A/C009

          .al
          .xl
          .autsiz
          .databank `wStatusWindowIndex

          ; Draws the player's gold to the status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; None

          lda #(`aGenericBG3TilemapInfo)<<8
          sta aCurrentTilemapInfo.lInfoPointer+size(byte),b
          lda #<>aGenericBG3TilemapInfo
          sta aCurrentTilemapInfo.lInfoPointer,b

          lda #TilemapEntry(BG3MenuTilesBaseTile + C2I((0, 18)), TextWhite, true, false, false)
          sta aCurrentTilemapInfo.wBaseTile,b

          lda lGold+size(byte)
          sta lR18+size(byte)
          lda lGold
          sta lR18

          ldx #pack(ObjectiveWindow.FundsNumberPosition)
          jsl rlDrawNumberMenuText

          rts

          .databank 0

        rsStatusWindowGetLeaderPortraitsAndTilemap ; 8A/C02D

          .al
          .xl
          .autsiz
          .databank ?

          ; Decompresses all factions' leaders' portraits
          ; and draws the first (Leif's) onto the status window.

          ; Inputs:
          ; None
          
          ; Outputs:
          ; aDecompressionBuffer: filled with leader portraits

          phb
          php

          sep #$20

          lda #`wStatusWindowIndex
          pha

          rep #$20

          plb

          .databank `wStatusWindowIndex

          ldx #0

          ; For each faction, decompress the leader's portrait
          ; to WRAM.

          -
            lda aStatusWindowLeaderCharacters,x
            beq +

              phx
              pha

              jsr rsStatusWindowGetPortraitDecompressionSlot

              lda lR18+size(byte)
              sta lR19+size(byte)
              lda lR18
              sta lR19

              pla

              jsl rlGetPortraitGraphicsPointerByCharacter
              jsl rlAppendDecompList

              plx

            +

            .rept size(word)
              inc x
            .endrept

            cpx #size(word) * 5
            bne -

          ; Get a tilemap and draw the first portrait.

          lda #(`acLeftFacingPortraitTilemap)<<8
          sta lR18+size(byte)
          lda #<>acLeftFacingPortraitTilemap
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

          lda #(`aBG2TilemapBuffer)<<8
          sta lR19+size(byte)
          lda #<>aBG2TilemapBuffer
          sta lR19

          lda #LeaderWindow.PortraitPosition[0]
          sta wR0
          lda #LeaderWindow.PortraitPosition[1]
          sta wR1
          lda #6
          sta wR2
          lda #8
          sta wR3

          jsl rlCopyPackedTilemapSlice

          jsl rlEnableBG2Sync

          plp
          plb
          rts

          .databank 0

        rsStatusWindowPickLeaderPortrait ; 8A/C0A8

          .al
          .xl
          .autsiz
          .databank ?

          ; Copies a pre-decompressed portrait from
          ; the decompression buffer to VRAM and copies their
          ; palette.

          ; Inputs:
          ; wStatusWindowIndex: faction index
          ; aDecompressionBuffer: filled with leader portraits

          ; Outputs:
          ; None

          phb
          php

          sep #$20

          lda #`wStatusWindowIndex
          pha

          rep #$20

          plb

          .databank `wStatusWindowIndex

          lda wStatusWindowIndex
          asl a
          tax
          jsr rsStatusWindowGetPortraitDecompressionSlot

          lda #4 * 16 * size(Tile4bpp)
          sta wR0
          lda #PortraitTilesPosition >> 1
          sta wR1
          jsl rlDMAByPointer

          lda wStatusWindowCurrentLeader
          jsl rlGetPortraitPalettePointerByCharacter

          lda #(`aBGPaletteBuffer.aPalette7)<<8
          sta lR19+size(byte)
          lda #<>aBGPaletteBuffer.aPalette7
          sta lR19

          lda #size(Palette)
          sta lR20

          jsl rlBlockCopy

          plp
          plb
          rts

          .databank 0

        rsStatusWindowGetPortraitDecompressionSlot ; 8A/C0E5

          .al
          .xl
          .autsiz
          .databank ?

          ; Given a row offset, return a long
          ; pointer to the leader's portrait in
          ; the decompression buffer.

          ; Inputs:
          ; X: leader row offset
          
          ; Outputs:
          ; lR18: long pointer to portrait in decompression buffer

          phx

          lda #(`aDecompressionBuffer+$200)<<8
          sta lR18+size(byte)

          txa
          xba

          asl a
          asl a

          clc
          adc #<>(aDecompressionBuffer+$200)

          sta lR18

          plx
          rts

          endCode
          startData

            ; I'd assume that a previous implementation fetched pointers
            ; by table, while the current solution recognizes how easy the
            ; math for it is.

            _UnusedTable .word <>range(aDecompressionBuffer + $200, aDecompressionBuffer + $200 + (5 * (4 * 16 * size(Tile4bpp))), 4 * 16 * size(Tile4bpp)) ; 8A/C0F7

          endData
          startCode

          .databank 0

      endCode
      startData

        ; Some kind of past/unused faction stuff?

        aUnknown8AC101 .block ; 8A/C101

          .addr menutextUnknown8AC10F
          .addr menutextUnknown8AC119
          .addr menutextUnknown8AC127
          .addr menutextUnknown8AC133
          .addr menutextUnknown8AC143
          .addr menutextUnknown8AC153
          .addr menutextUnknown8AC161

        .endblock

      endData
      startMenuText

        .enc "SJIS"

        menutextUnknown8AC10F .text "リーフ軍\n" ; 8A/C10F
        menutextUnknown8AC119 .text "マンスター軍\n" ; 8A/C119
        menutextUnknown8AC127 .text "ていこく軍\n" ; 8A/C127
        menutextUnknown8AC133 .text "リーフどうめい\n" ; 8A/C133
        menutextUnknown8AC143 .text "リーフてきたい\n" ; 8A/C143
        menutextUnknown8AC153 .text "イシュタル軍\n" ; 8A/C153
        menutextUnknown8AC161 .text "リフィス団\n" ; 8A/C161

      endMenuText
      startData

        aUnknown8AC16D .block ; 8A/C16D

          ; Unknown, unreferenced?

          .word $0001, $0136, $0000
          .word $0001, $0638, $0000
          .word $0001, $0620, $0000
          .word $0001, $013d, $0000
          .word $0001, $0100, $0000
          .word $0001, $0100, $0546
          .word $0001, $0100, $0000
          .word $0001, $0155, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000
          .word $0001, $0136, $0000

        .endblock

      endData
      startCode

        rlGetChapterObjectiveLine1 ; 8A/C263

          .al
          .xl
          .autsiz
          .databank ?

          ; Given a chapter number, return a long
          ; pointer to the first line of the chapter's
          ; objective dialogue text.

          ; Inputs:
          ; A: chapter number
          
          ; Outputs:
          ; lR18: long pointer to dialogue text

          phx

          sta lR18
          asl a
          clc
          adc lR18
          tax

          lda _Line1Table,x
          sta lR18
          lda _Line1Table+size(byte),x
          sta lR18+size(byte)

          plx
          rtl

          endCode
          startData

            _Line1Table .block ; 8A/AC79

              .long dialogueChapter01ObjectiveLine1
              .long dialogueChapter02ObjectiveLine1
              .long dialogueChapter02xObjectiveLine1
              .long dialogueChapter03ObjectiveLine1
              .long dialogueChapter04ObjectiveLine1
              .long dialogueChapter04xObjectiveLine1
              .long dialogueChapter05ObjectiveLine1
              .long dialogueChapter06ObjectiveLine1
              .long dialogueChapter07ObjectiveLine1
              .long dialogueChapter08ObjectiveLine1
              .long dialogueChapter08xObjectiveLine1
              .long dialogueChapter09ObjectiveLine1
              .long dialogueChapter10ObjectiveLine1
              .long dialogueChapter11ObjectiveLine1
              .long dialogueChapter11xObjectiveLine1
              .long dialogueChapter12ObjectiveLine1
              .long dialogueChapter12xObjectiveLine1
              .long dialogueChapter13ObjectiveLine1
              .long dialogueChapter14ObjectiveLine1
              .long dialogueChapter14xObjectiveLine1
              .long dialogueChapter15ObjectiveLine1
              .long dialogueChapter16AObjectiveLine1
              .long dialogueChapter17AObjectiveLine1
              .long dialogueChapter16BObjectiveLine1
              .long dialogueChapter17BObjectiveLine1
              .long dialogueChapter18ObjectiveLine1
              .long dialogueChapter19ObjectiveLine1
              .long dialogueChapter20ObjectiveLine1
              .long dialogueChapter21ObjectiveLine1
              .long dialogueChapter21xObjectiveLine1
              .long dialogueChapter22ObjectiveLine1
              .long dialogueChapter23ObjectiveLine1
              .long dialogueChapter24ObjectiveLine1
              .long dialogueChapter24xObjectiveLine1
              .long dialogueChapterFinalObjectiveLine1

            .endblock

          endData
          startCode

          .databank 0

        rlGetChapterObjectiveLine2 ; 8A/C2E2

          .al
          .xl
          .autsiz
          .databank ?

          ; Given a chapter number, return a long
          ; pointer to the second line of the chapter's
          ; objective dialogue text.

          ; Inputs:
          ; A: chapter number
          
          ; Outputs:
          ; lR18: long pointer to dialogue text if second
          ;   line else None

          phx

          sta lR18
          asl a
          clc
          adc lR18
          tax

          lda _Line2Table,x
          sta lR18
          lda _Line2Table+size(byte),x
          sta lR18+size(byte)

          plx
          rtl

          endCode
          startData

            _Line2Table .block ; 8A/C2F8

              .long None; Chapter01
              .long None; Chapter02
              .long None; Chapter02x
              .long None; Chapter03
              .long None; Chapter04
              .long None; Chapter04x
              .long None; Chapter05
              .long None; Chapter06
              .long None; Chapter07
              .long None; Chapter08
              .long None; Chapter08x
              .long None; Chapter09
              .long None; Chapter10
              .long None; Chapter11
              .long None; Chapter11x
              .long None; Chapter12
              .long None; Chapter12x
              .long None; Chapter13
              .long None; Chapter14
              .long None; Chapter14x
              .long dialogueChapter15ObjectiveLine2
              .long None; Chapter16A
              .long None; Chapter17A
              .long None; Chapter16B
              .long None; Chapter17B
              .long None; Chapter18
              .long None; Chapter19
              .long None; Chapter20
              .long None; Chapter21
              .long None; Chapter21x
              .long None; Chapter22
              .long None; Chapter23
              .long None; Chapter24
              .long None; Chapter24x
              .long None; ChapterFinal

            .endblock

          endData
          startCode

          .databank 0

      endCode

      .endwith

    .endsection StatusWindowSection

.endif ; GUARD_FE5_STATUS_WINDOW
