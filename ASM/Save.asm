
rlUnknown81C525 ; 81/C525

  .al
  .xl
  .autsiz
  .databank ?

  lda #Leif
  sta wR0

  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl $83976E

  lda aUnknownActionStruct000F56.X,b
  and #$00FF
  sta wR0

  lda aUnknownActionStruct000F56.Y,b
  and #$00FF
  sta wR1

  jsl $83C181

  lda wCursorXCoord,b
  asl a
  asl a
  asl a
  asl a
  sta wR0

  lda wCursorYCoord,b
  asl a
  asl a
  asl a
  asl a
  sta wR1
  jsl $83C108

  lda wR2
  sta wMapScrollWidthPixels,b

  lda wR3
  sta wMapScrollHeightPixels,b
  rtl

rlSaveToSRAMSlot ; 81/C568

  .xl
  .autsiz
  .databank ?

  ; Saves the current game to a slot.

  ; Inputs:
  ; A: Save slot to write to

  ; Outputs:
  ; None

  php
  phb
  pha
  sep #$20
  lda #`lGold
  pha
  rep #$20
  plb

  .databank `lGold

  pla
  jsr rsUpdateLastSavedSlot
  jsr rsGetSaveSlotOffset

  ldx wSaveSlotOffset,b

  lda #$200A
  sta aSRAM+structSaveDataEntry.MagicNumber,x

  lda wIngameTime,b
  sta aSRAM+structSaveDataEntry.GameTime,x

  lda wMenuCounter,b
  sta aSRAM+structSaveDataEntry.MenuPressCounter,x

  lda wMapScrollWidthPixels,b
  sta aSRAM+structSaveDataEntry.HorizontalScroll,x

  lda wMapScrollHeightPixels,b
  sta aSRAM+structSaveDataEntry.VerticalScroll,x

  lda wCurrentTurn,b
  sta aSRAM+structSaveDataEntry.CurrentTurn,x

  lda lGold
  sta aSRAM+structSaveDataEntry.Gold,x

  lda wWinCounter,b
  sta aSRAM+structSaveDataEntry.Wins,x

  lda wCaptureCounter,b
  sta aSRAM+structSaveDataEntry.Captures,x

  lda wParagonModeEnable,b
  sta aSRAM+structSaveDataEntry.ParagonFlag,x

  lda wChapterBoss,b
  sta aSRAM+structSaveDataEntry.BossID,x

  sep #$20

  lda lGold+2
  sta aSRAM+structSaveDataEntry.Gold+2,x

  lda wCurrentChapter,b
  sta aSRAM+structSaveDataEntry.CurrentChapter,x

  lda wCurrentPhase,b
  sta aSRAM+structSaveDataEntry.CurrentPhase,x

  lda wCursorXCoord,b
  sta aSRAM+structSaveDataEntry.CursorX,x

  lda wCursorYCoord,b
  sta aSRAM+structSaveDataEntry.CursorY,x

  lda wDefaultVisibilityFill,b
  sta aSRAM+structSaveDataEntry.DefaultVisibility,x

  lda wVisionRange,b
  sta aSRAM+structSaveDataEntry.VisionRange,x

  rep #$30

  ldx #<>aOptions
  ldy #structSaveDataEntry.Options
  lda #size(aOptions)-1
  jsr rsWriteBlockToSaveSlot

  ldx #<>aAllegianceInfo
  ldy #structSaveDataEntry.AllegianceInfo
  lda #size(aAllegianceInfo)+size(aPhaseControllerInfo)-1
  jsr rsWriteBlockToSaveSlot

  ldx #<>aPlayerUnits
  ldy #structSaveDataEntry.AllyUnits
  lda #size(aPlayerUnits)+size(aEnemyUnits)+size(aNPCUnits)-1
  jsr rsWriteBlockToSaveSlot

  ldx #<>aPermanentEventFlags
  ldy #structSaveDataEntry.PermanentEventFlags
  lda #size(aPermanentEventFlags)+size(aTemporaryEventFlags)+size(aRandomizedItems)+size(aRandomizedNumbers)-1
  jsr rsWriteBlockToSaveSlot

  ldx #<>aConvoy
  ldy #structSaveDataEntry.Convoy
  lda #size(aConvoy)-1
  jsr rsWriteBlockToSaveSlot

  ldx #<>aLossesTable
  ldy #structSaveDataEntry.LossesTable
  lda #size(aLossesTable)+size(aWinsTable)+size(aTurncountsTable)-1
  jsr rsWriteBlockToSaveSlot

  jsl rlWriteSaveSlotChecksum

  plb
  plp
  rtl

rsUpdateLastSavedSlot ; 81/C64E

  .al
  .xl
  .autsiz
  .databank `lGold

  ; Updates which slot was saved to last

  ; Inputs:
  ; A: Save slot

  ; Outputs:
  ; None

  and #$00FF
  pha

  ; Check if suspending

  cmp #$0003
  bne +

  sep #$20
  lda @l wLastSavedSlot
  sta aSRAM.aSaveDataHeader.LastSuspend
  rep #$20

  +
  sta wLastSavedSlot
  sep #$20
  sta aSRAM.aSaveDataHeader.LastFile
  rep #$20
  pla
  rts

rlLoadSaveSlot ; 81/C670

  .xl
  .autsiz
  .databank ?

  php
  phb
  pha
  sep #$20
  lda #`aSRAM
  pha
  rep #$20
  plb

  .databank `aSRAM

  pla
  cmp #$0003
  beq +

  sep #$20
  sta @l aSRAM.aSaveDataHeader.LastFile
  rep #$20

  +
  sta wLastSavedSlot
  jsr rsGetSaveSlotOffset
  lda wSaveSlotOffset
  tax
  phx
  jsr rsCopySaveTempInfo
  plx
  inc structSaveDataEntry.Unknown,b,x
  bne +

  dec structSaveDataEntry.Unknown,b,x

  +
  lda structSaveDataEntry.GameTime,b,x
  sta wIngameTime

  lda structSaveDataEntry.MenuPressCounter,b,x
  sta wMenuCounter

  lda structSaveDataEntry.HorizontalScroll,b,x
  sta wMapScrollWidthPixels

  lda structSaveDataEntry.VerticalScroll,b,x
  sta wMapScrollHeightPixels

  lda structSaveDataEntry.CurrentTurn,b,x
  sta wCurrentTurn

  lda structSaveDataEntry.Wins,b,x
  sta wWinCounter

  lda structSaveDataEntry.Captures,b,x
  sta wCaptureCounter

  lda structSaveDataEntry.ParagonFlag,b,x
  sta wParagonModeEnable

  lda structSaveDataEntry.Gold,b,x
  sta lGold

  lda structSaveDataEntry.Gold+1,b,x
  sta lGold+1

  lda structSaveDataEntry.BossID,b,x
  sta wChapterBoss

  lda structSaveDataEntry.CurrentChapter,b,x
  and #$00FF
  sta wCurrentChapter

  lda structSaveDataEntry.CurrentPhase,b,x
  and #$00FF
  sta wCurrentPhase

  lda structSaveDataEntry.CursorX,b,x
  and #$00FF
  sta @l wR0
  sta wTurnEndXCoordinate

  lda structSaveDataEntry.CursorY,b,x
  and #$00FF
  sta @l wR1
  sta wTurnEndYCoordinate
  jsl $83C181

  lda structSaveDataEntry.DefaultVisibility,b,x
  and #$00FF
  beq +

  lda #$0101
  sta wDefaultVisibilityFill
  bra ++

  +
  tdc
  sta wDefaultVisibilityFill

  +
  lda structSaveDataEntry.VisionRange,b,x
  and #$00FF
  sta wVisionRange

  ldx #structSaveDataEntry.Options
  ldy #<>aOptions
  lda #size(aOptions)-1
  jsr rsWriteBlockFromSaveSlot

  ldx #structSaveDataEntry.AllegianceInfo
  ldy #<>aAllegianceInfo
  lda #size(aAllegianceInfo)+size(aPhaseControllerInfo)-1
  jsr rsWriteBlockFromSaveSlot

  ldx #structSaveDataEntry.AllyUnits
  ldy #<>aPlayerUnits
  lda #size(aPlayerUnits)+size(aEnemyUnits)+size(aNPCUnits)-1
  jsr rsWriteBlockFromSaveSlot

  ldx #structSaveDataEntry.PermanentEventFlags
  ldy #<>aPermanentEventFlags
  lda #size(aPermanentEventFlags)+size(aTemporaryEventFlags)+size(aRandomizedItems)+size(aRandomizedNumbers)-1
  jsr rsWriteBlockFromSaveSlot

  ldx #structSaveDataEntry.Convoy
  ldy #<>aConvoy
  lda #size(aConvoy)-1
  jsr rsWriteBlockFromSaveSlot

  ldx #structSaveDataEntry.LossesTable
  ldy #<>aLossesTable
  lda #size(aLossesTable)+size(aWinsTable)+size(aTurncountsTable)-1
  jsr rsWriteBlockFromSaveSlot

  plb
  plp
  rtl

rsWriteBlockToSaveSlot ; 81/C78E

  .xl
  .autsiz
  .databank ?

  pha
  tya
  clc
  adc wSaveSlotOffset
  tay
  pla
  mvn #$7E,#`aSRAM
  rts

rsWriteBlockFromSaveSlot ; 81/C79B

  .xl
  .autsiz
  .databank ?

  pha
  txa
  clc
  adc wSaveSlotOffset
  tax
  pla
  mvn #`aSRAM,#$7E
  rts

rlCheckIfSaveSlotValid ; 81/C7A8

  .xl
  .autsiz
  .databank ?

  php
  phb
  pha
  sep #$20
  lda #`aSRAM
  pha
  rep #$20
  plb

  .databank `aSRAM

  pla
  jsr rsGetSaveSlotOffset
  lda wSaveSlotOffset
  tax
  lda @l aSRAM,x
  cmp #$200A
  bne +

  jsl rlVerifySaveSlotChecksum
  bcc +

  jsr rsCopySaveTempInfo
  lda wSaveSlotTempCurrentChapter
  sta wR0
  lda wSaveSlotTempCurrentTurn
  sta wR1
  plb
  plp
  sec
  rtl

  +
  plb
  plp
  clc
  rtl

rlCheckIfSaveSlotFilled ; 81/C7E2

  .xl
  .autsiz
  .databank ?

  php
  phb
  pha
  sep #$20
  lda #`aSRAM
  pha
  rep #$20
  plb

  .databank `aSRAM

  pla
  jsr rsGetSaveSlotOffset
  lda wSaveSlotOffset
  tax
  lda @l aSRAM,x
  cmp #$200A
  bne +

  jsr rsCopySaveTempInfo
  lda wSaveSlotTempCurrentChapter
  sta wR0
  lda wSaveSlotTempCurrentTurn
  sta wR1
  plb
  plp
  sec
  rtl

  +
  plb
  plp
  clc
  rtl

rsCopySaveTempInfo ; 81/C816

  .al
  .xl
  .autsiz
  .databank `aSRAM

  lda structSaveDataEntry.CurrentChapter,b,x
  and #$00FF
  sta wSaveSlotTempCurrentChapter

  lda structSaveDataEntry.CurrentTurn,b,x
  sta wSaveSlotTempCurrentTurn

  lda structSaveDataEntry.Unknown,b,x
  sta wSaveSlotTempUnknown

  lda structSaveDataEntry.Options.TileSettingIndex,b,x
  sta wSaveSlotTempTileSettingIndex

  jsr rsGetSavedTileSettingColors

  lda structSaveDataEntry.GameTime,b,x
  sta dwR12

  lda structSaveDataEntry.MenuPressCounter,b,x
  sta dwR12+2

  jsl rlUnknown81C847
  rts

rlUnknown81C847 ; 81/C847

  .xl
  .autsiz
  .databank ?

  php
  phb
  sep #$20
  lda #`wSaveSlotTempCurrentChapter
  pha
  rep #$20
  plb

  .databank `wSaveSlotTempCurrentChapter

  lda #$003C
  sta dwR14
  stz dwR14+2
  jsl rlUnsignedDivide32By32
  lda dwR10
  sta @l wSaveSlotTempUnknown4

  jsl rlUnsignedDivide32By32
  lda dwR10
  sta @l wSaveSlotTempUnknown3

  jsl rlUnsignedDivide32By32
  lda dwR12
  sta @l wSaveSlotTempUnknown2
  plb
  plp
  rtl

rsGetSavedTileSettingColors ; 81/C879

  .al
  .xl
  .autsiz
  .databank ?

  lda wSaveSlotTempTileSettingIndex
  asl a
  asl a
  sta wR0
  asl a
  clc
  adc wR0
  clc
  adc @l wSaveSlotOffset
  tay
  lda structSaveDataEntry.Options.TileSetting1UpperRed,b,y
  sta wSelectedTileSettingUpperRed
  lda structSaveDataEntry.Options.TileSetting1UpperGreen,b,y
  sta wSelectedTileSettingUpperGreen
  lda structSaveDataEntry.Options.TileSetting1UpperBlue,b,y
  sta wSelectedTileSettingUpperBlue
  lda structSaveDataEntry.Options.TileSetting1LowerRed,b,y
  sta wSelectedTileSettingLowerRed
  lda structSaveDataEntry.Options.TileSetting1LowerGreen,b,y
  sta wSelectedTileSettingLowerGreen
  lda structSaveDataEntry.Options.TileSetting1LowerBlue,b,y
  sta wSelectedTileSettingLowerBlue
  rts

rlGetSaveSlotOffset ; 81/C8B6

  .al
  .xl
  .autsiz
  .databank ?

  jsr rsGetSaveSlotOffset
  rtl

rsGetSaveSlotOffset ; 81/C8BA

  .al
  .xl
  .autsiz
  .databank ?

  and #$00FF
  asl a
  tax
  lda _SaveSlotTable,x
  sta @l wSaveSlotOffset
  rts

  _SaveSlotTable ; 81/C8C8
    .word <>aSRAM.aSaveSlot1
    .word <>aSRAM.aSaveSlot2
    .word <>aSRAM.aSaveSlot3
    .word <>aSRAM.aSaveSlotSuspend

rlFreeSaveSlotByIndex ; 81/C8D0

  .autsiz
  .databank ?

  php

  rep #$30
  and #$00FF
  sta wR0

  phb
  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  lda aSRAM.aSaveDataHeader.LastSuspend
  and #$00FF
  cmp wR0
  bne +

  lda #$0000
  sta aSRAM.aSaveSlotSuspend.MagicNumber

  +
  lda wR0
  jsr rsGetSaveSlotOffset
  lda @l wSaveSlotOffset
  tax
  lda #$0000
  sta aSRAM+structSaveDataEntry.MagicNumber,x
  jsl rlClearSRAMHeaderIfNoFiles
  plb
  plp
  rtl

rlCalculateSaveSlotChecksum ; 81/C90B

  .al
  .xl
  .autsiz
  .databank ?

  lda @l wSaveSlotOffset
  clc
  adc #structSaveDataEntry.GameTime
  sta lR18
  ldy #size(structSaveDataEntry) - structSaveDataEntry.GameTime - 2
  tdc
  clc

  -
  adc (lR18),y
  dec y
  dec y
  bpl -

  sta wR0
  rtl

rlWriteSaveSlotChecksum ; 81/C923

  .xl
  .autsiz
  .databank ?

  php
  phb
  sep #$20
  lda #`aSRAM
  pha
  rep #$20
  plb

  .databank `aSRAM

  jsl rlCalculateSaveSlotChecksum
  lda @l wSaveSlotOffset
  tax
  lda wR0
  sta @l aSRAM+structSaveDataEntry.Checksum,x
  plb
  plp
  rtl

rlVerifySaveSlotChecksum ; 81/C93F

  .xl
  .autsiz
  .databank ?

  php
  phb
  sep #$20
  lda #`aSRAM
  pha
  rep #$20
  plb

  .databank `aSRAM

  jsl rlCalculateSaveSlotChecksum
  lda @l wSaveSlotOffset
  tax
  lda @l aSRAM+structSaveDataEntry.Checksum,x
  cmp wR0
  beq +

  plb
  plp
  clc
  rtl

  +
  plb
  plp
  sec
  rtl

rlClearSRAMHeaderIfNoFiles ; 81/C962

  .autsiz
  .databank ?

  php
  rep #$30
  lda #$0000
  jsl rlCheckIfSaveSlotValid
  bcs +

  lda #$0001
  jsl rlCheckIfSaveSlotValid
  bcs +

  lda #$0002
  jsl rlCheckIfSaveSlotValid
  bcs +

  lda #$0003
  jsl rlCheckIfSaveSlotValid
  bcs +

  sep #$20
  lda #$00
  sta aSRAM.aSaveDataHeader.LastFile
  sta aSRAM.aSaveDataHeader.LastSuspend
  sta aSRAM.aSaveDataHeader.CompletionCount
  sta aSRAM.aSaveDataHeader.CompletionFlag

  +
  plp
  rtl

rlUpdateSaveSlotLosses ; 81/C99F

  .xl
  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #`wLastSavedSlot
  pha
  rep #$20
  plb

  .databank `wLastSavedSlot

  lda wLastSavedSlot
  cmp #$FFFF
  beq +

  jsr rsGetSaveSlotOffset

  ldx #<>aLossesTable
  ldy #structSaveDataEntry.LossesTable
  lda #size(aLossesTable)-1
  jsr rsWriteBlockToSaveSlot
  jsl rlWriteSaveSlotChecksum

  +
  plb
  plp
  rtl

rlGetCharacterWinLossTableOffset ; 81/C9C7

  .autsiz
  .databank ?

  php
  rep #$30
  tax
  lda aWinLossOffsetsTable,x
  and #$00FF
  cmp #$00FF
  beq +

  plp
  clc
  rtl

  +
  plp
  sec
  rtl

.include "../TABLES/WinLossOffsets.asm"
