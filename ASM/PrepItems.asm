
aMainPrepItemsActionTable .binclude "../TABLES/PrepItemsActionTable.casm" ; 81/E14D

aUnknown81E1B9 ; 81/E1B9
  .sint  0
  .sint  1
  .sint -1
  .sint -1
  .sint  1
  .sint  1
  .sint  1
  .sint -1
  .sint -1
  .sint -1
  .sint -1
  .sint -1
  .sint -1
  .sint  0
  .sint  0
  .sint  0
  .sint  0
  .sint  0
  .sint  0
  .sint  1
  .sint  0
  .sint  1

rsPrepItemsDrawMainDescriptionAndGetNextAction ; 81/E1E5

  .al
  .xl
  .autsiz
  .databank ?

  lda #(aPrepItemsDescriptionPointers._MainDescription - aPrepItemsDescriptionPointers)
  jsr rsPrepItemsDrawMenuDescriptionText

rsUnknown81E1EB ; 81/E1EB

  .al
  .xl
  .autsiz
  .databank ?

  jmp rsPrepItemsSelectNextAction

rsPrepItemsRedrawTradeDescriptionAfterClosingInventory ; 81/E1EE

  .al
  .xl
  .autsiz
  .databank ?

  lda #(aPrepItemsDescriptionPointers._Trade - aPrepItemsDescriptionPointers)
  jsr rsPrepItemsDrawMenuDescriptionText

  phx
  lda #(`procPrepItemsTradeInitiatorCursor)<<8
  sta lR44+1
  lda #<>procPrepItemsTradeInitiatorCursor
  sta lR44
  jsl rlProcEngineCreateProc
  plx

rsUnknown81E204 ; 81/E204

  .al
  .xl
  .autsiz
  .databank ?

  jmp rsPrepItemsSelectNextAction

rlUnknown81E207 ; 81/E207

  .al
  .xl
  .autsiz
  .databank `$7EA952

  lda wBuf_BG3VOFS
  sta $7EA952

  lda wPrepItemsActionIndex
  and #$00FF
  asl a
  asl a
  tax
  lda aMainPrepItemsActionTable,x
  sta wR0
  pea <>(+)-1
  jmp (wR0)

  +
  lda aSelectedCharacterBuffer.DeploymentNumber,b
  pha

  sep #$20
  lda #$01
  sta aSelectedCharacterBuffer.DeploymentNumber,b
  rep #$20

  ldy #<>aSelectedCharacterBuffer

  lda #8
  sta wR0

  lda #5
  sta wR1

  jsl rlInventoryDrawMapSpriteCheckGrayed

  pla
  sta aSelectedCharacterBuffer.DeploymentNumber,b

  jsl $8A8126

  rtl

rsPrepItemsSelectNextAction ; 81/E248

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda wPrepItemsActionIndex
  and #$00FF
  asl a
  asl a
  inc a
  inc a
  tax
  lda aMainPrepItemsActionTable,x
  sta wPrepItemsActionIndex
  rts

rlUnknown81E25B ; 81/E25B

  .al
  .xl
  .autsiz
  .databank ?

  php
  phb
  sep #$20
  lda #`wPrepItemsActionIndex
  pha
  rep #$20
  plb

  .databank `wPrepItemsActionIndex

  jsl $8A8060
  jsr rsUnknown81E386
  jsl $85BDB2

  lda wPrepUnitListLastScrollOffset
  sta wBuf_BG3VOFS

  stz $7EA937

  jsl $85F42F
  jsl $85F417
  jsl $85F717
  jsr rsPrepItemsSetLinecounts
  jsl $85BDE1
  jsl $85BD6F
  jsr rsUnknown81E35B
  jsl $85B4F9

  lda aPrepDeploymentSlots
  sta wR0
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $839086
  jsl rlPrepItemsDrawHoveredUnitInfo

  lda #aMainPrepItemsActionTable.List
  cmp wPrepItemsActionIndex
  beq +

  jsl rlPrepItemsCopyListSlice

  phx
  lda #(`procUnknown81F12C)<<8
  sta lR44+1
  lda #<>procUnknown81F12C
  sta lR44
  jsl rlProcEngineCreateProc
  plx
  bra ++

  +
  jsr rsPrepItemsSetupList
  lda $7E6FCB
  beq +

  jsl rlPrepItemsResortList

  +
  phx
  lda #(`procUnknown81E93C)<<8
  sta lR44+1
  lda #<>procUnknown81E93C
  sta lR44
  jsl rlProcEngineCreateProc
  plx

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $F28000, $5800, VMAIN_Setting(True), $4800

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG1TilemapBuffer, $0700, VMAIN_Setting(True), $E000

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG2TilemapBuffer, size(aBG2TilemapBuffer), VMAIN_Setting(True), $F000

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer, size(aBG2TilemapBuffer), VMAIN_Setting(True), $A000

  plb
  plp
  rtl

rsPrepItemsSetLinecounts ; 81/E319

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  stz wPrepUnitListTextCoordinateBase

  lda #256
  sta wPrepUnitListSpriteVerticalOffset

  stz wMenuMinimumLine

  lda #1
  sta wMenuUpScrollThreshold

  lda #3
  sta wMenuDownScrollThreshold

  lda #5
  sta wMenuBottomThreshold

  jsr rsPrepItemsCountUnits

  dec a
  dec a
  sta wR13
  lda #$0006
  sta wR14
  jsl rlUnsignedDivide16By8
  lda wR13
  sta wMenuMaximumLine
  rts

rsPrepItemsCountUnits ; 81/E34D

  .al
  .xl
  .autsiz
  .databank `aPrepDeploymentSlots

  ; Returns 2 * valid units in A?

  ldx #0000

  -
  lda aPrepDeploymentSlots,x
  beq +

  inc x
  inc x
  bra -

  +
  txa
  rts

rsUnknown81E35B ; 81/E35B

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda #<>aPrepItemsHDMAInfo
  sta lR44
  lda #>`aPrepItemsHDMAInfo
  sta lR44+1
  lda #$0005
  sta wR40
  jsl rlHDMAArrayEngineCreateEntryByIndex
  rts

aPrepItemsHDMAInfo .dstruct structHDMAArrayEntryInfo, rlPrepItemsHDMADummy, rlPrepItemsHDMADummy, aPrepItemsHDMACode, aPrepItemsHDMATable, TM - PPU_REG_BASE, DMAPx_Setting(DMAPx_TransferCPUToIO, DMAPx_Mode0, DMAPx_ABusFixed1, DMAPx_Direct)

rlPrepItemsHDMADummy ; 81/E37A

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  rtl

aPrepItemsHDMACode ; 81/E37B
  .dstruct structHDMAArrayCodeHalt

aPrepItemsHDMATable ; 81/E37D

  .byte HDMA_DirectTableSetting(False, 117)

  .byte TM_Setting(True, True, True, False, True)

  .byte HDMA_DirectTableSetting(False, 11)

  .byte TM_Setting(True, True, True, False, False)

  .byte HDMA_DirectTableSetting(False, 95)

  .byte TM_Setting(True, True, True, False, True)

  .byte HDMA_DirectTableSetting(False, 1)

  .byte TM_Setting(False, False, False, False, False)

  .byte HDMA_DirectTableSetting(False, 0)

rsUnknown81E386 ; 81/E386

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda #<>$83C0FF
  sta lUnknown000DDE,b
  lda #>`$83C0FF
  sta lUnknown000DDE+1,b

  lda $7E4E6B
  sta lR18
  lda $7E4E6B+1
  sta lR18+1

  lda #$0B40
  sta wUnknown000DE7,b

  jsl $87D6FC
  jsl $85979B

  lda #(`$9EEF90)<<8
  sta lR18+1
  lda #<>$9EEF90
  sta lR18
  lda #(`aBG3TilemapBuffer)<<8
  sta lR19+1
  lda #<>aBG3TilemapBuffer
  sta lR19
  jsl rlAppendDecompList

  lda #<>aBG2TilemapBuffer
  sta wR0
  lda #$02FF
  jsl rlFillTilemapByWord

  lda #<>aBG2TilemapBuffer + ((0 + (32 * $20)) * 2)
  sta wR0
  lda #$02FF
  jsl rlFillTilemapByWord
  rts

rlPrepItemsCopyListSlice ; 81/E3DB

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda #<>aPrepItemsTextInfo
  sta lUnknown000DDE,b
  lda #>`aPrepItemsTextInfo
  sta lUnknown000DDE+1,b

  jsl $85F747

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (32 * $20)) * 2), ((0 + (32 * $20)) * 2), VMAIN_Setting(True), ($A000 + ((0 + (32 * $20)) * 2))

  rtl

rsPrepItemsActionDefault ; 81/E3F9

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda #(aPrepItemsDescriptionPointers._MainDescription - aPrepItemsDescriptionPointers)
  jsr rsPrepItemsDrawMenuDescriptionText

  lda #120
  sta wBuf_BG3VOFS

  jmp rsPrepItemsSelectNextAction

aPrepItemsTextInfo ; 81/E407

  .byte $20, $20

  .long 0
  .byte 0
  .long aBG3TilemapBuffer + ((0 + (32 * $20)) * 2)

rsPrepItemsHandleUnitList ; 81/E410

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsl $85FAFA

  stz wPrepUnitListMovingFlag

  ; Save current scroll to see if we scrolled
  ; during input checking

  lda wMenuLineScrollCount
  pha

  jsr rsPrepItemsHandleMainUnitListDirectionalInputs
  jsr rsPrepItemsHandleMainUnitListOtherInputs

  pla
  jsr rsPrepItemsHandleUnitListScrolling

  lda wPrepUnitListMovingFlag
  beq +

  jsl rlPrepItemsDrawHoveredUnitInfo

  +
  rts

rsPrepItemsHandleUnitListScrolling ; 81/E42F

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  cmp wMenuLineScrollCount
  beq _End
  bcc +

  lda #4
  jsr rsUnknown81EE5E
  rts

  +
  lda #-4
  jsr rsUnknown81EE5E

  _End
  rts

rsPrepItemsHandleMainUnitListDirectionalInputs ; 81/E444

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda wJoy1Alt
  bit #JoypadUp
  bne _Up

  bit #JoypadDown
  bne _Down

  bit #JoypadLeft
  bne _Left

  bit #JoypadRight
  bne _Right

  rts

  _Up

  lda wPrepUnitListColumn
  sta wR0

  lda wPrepUnitListRow
  dec a
  sta wR1

  jsl $85FAD0
  bcc _End

  lda wPrepUnitListRow
  jsl $83C8EE
  bcc _End

  sta wPrepUnitListRow

  dec wPrepUnitListMovingFlag
  jsl rlUnknown81F512

  _End
  rts

  _Down

  lda wPrepUnitListColumn
  sta wR0

  lda wPrepUnitListRow
  inc a
  sta wR1

  jsl $85FAD0
  bcc _End

  lda wPrepUnitListRow
  jsl $83C8BF
  bcc _End

  sta wPrepUnitListRow

  dec wPrepUnitListMovingFlag
  jsl rlUnknown81F512
  rts

  _Left

  lda wPrepUnitListRow
  sta wR1

  lda wPrepUnitListColumn
  dec a
  sta wR0

  jsl $85FAD0
  bcc _End

  dec wPrepUnitListColumn
  dec wPrepUnitListMovingFlag
  jsl rlUnknown81F512
  rts

  _Right

  lda wPrepUnitListRow
  sta wR1

  lda wPrepUnitListColumn
  inc a
  sta wR0

  jsl $85FAD0
  bcc _End

  inc wPrepUnitListColumn
  dec wPrepUnitListMovingFlag
  jsl rlUnknown81F512
  rts

rsPrepItemsHandleMainUnitListOtherInputs ; 81/E4DD

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda wJoy1Input
  bit #JoypadDown | JoypadUp
  bne _End

  lda wJoy1New
  bit #JoypadSelect
  bne _Select

  bit #JoypadA
  bne _A

  bit #JoypadX
  bne _X

  _End
  rts

  _Select

  ; Closes the menu

  lda #$A1E0
  sta wProcInput0,b

  lda #(`procUnknown82A1BB)<<8
  sta lR44+1
  lda #<>procUnknown82A1BB
  sta lR44

  jsl rlProcEngineCreateProc

  sep #$20
  lda #INIDISP_Setting(False, 0)
  sta bBuf_INIDISP

  rep #$20
  lda #$0021
  jsl rlUnknown808C87
  rts

  _A

  ; Opens the option list

  lda #$000D
  jsl rlUnknown808C87
  jmp rsPrepItemsSelectNextAction

  _X

  ; Opens the unit's inventory

  ; Save where we're at for when we close the inventory

  lda wBuf_BG3VOFS
  sta wPrepUnitListLastScrollOffset

  lda wPrepUnitListColumn
  sta wPrepUnitListLastSelectedColumn

  lda wPrepUnitListRow
  sta wPrepUnitListLastSelectedRow

  lda wMenuLineScrollCount
  sta wPrepUnitListLastScrolledMenuLine

  lda #aMainPrepItemsActionTable.InventoryFromMainUnitList
  sta wPrepItemsActionIndex

  lda #<>rlUnknown80BE27
  sta lUnknown7EA4EC
  lda #>`rlUnknown80BE27
  sta lUnknown7EA4EC+1
  jsl $85FA88
  rts

rlPrepItemsDrawHoveredUnitInfo ; 81/E552

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda #<>$83C0F6
  sta lUnknown000DDE,b
  lda #>`$83C0F6
  sta lUnknown000DDE+1,b

  jsl $85FABE
  sta wR0

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $839086

  ; Clear existing portrait

  lda #(`procPortrait0)<<8
  sta lR44+1
  lda #<>procPortrait0
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +

  ; Draw portrait to 10, 1

  lda #10 | (1 << 8)
  sta wR0
  lda aSelectedCharacterBuffer.Character,b
  ldx #$0000
  jsl rlUnknown8CBF73

  ; Copy an 8x8 tile slice of the deploy menu
  ; tilemap that contains the unit info
  ; labels to 1, 1

  lda #<>$F2FDC4
  sta lR18
  lda #>`$F2FDC4
  sta lR18+1
  lda #8
  sta wR0
  lda #8
  sta wR1
  lda #<>aBG3TilemapBuffer + ((1 + (1 * $20)) * 2)
  sta wR19
  stz wUnknown000DE7,b
  jsl $84A3FF

  lda #$2180
  sta wUnknown000DE7,b

  ; Draw name

  lda aSelectedCharacterBuffer.Character,b
  jsl $839334
  ldx #3 | (1 << 8)
  jsl $87E728

  ; Draw class

  lda aSelectedCharacterBuffer.Class,b
  jsl $839351
  ldx #1 | (3 << 8)
  jsl $87E728

  lda #$22A0
  sta wUnknown000DE7,b

  ; Draw level

  lda aSelectedCharacterBuffer.Level,b
  sta lR18
  stz lR18+1
  ldx #5 | (5 << 8)
  jsl $858859

  ; Draw EXP

  lda aSelectedCharacterBuffer.Experience,b
  sta lR18
  stz lR18+1
  ldx #8 | (5 << 8)
  jsl $858884

  ; Draw HP

  lda aSelectedCharacterBuffer.CurrentHP,b
  sta lR18
  stz lR18+1
  ldx #5 | (7 << 8)
  jsl $858859

  lda aSelectedCharacterBuffer.MaxHP,b
  sta lR18
  stz lR18+1
  ldx #8 | (7 << 8)
  jsl $858859

  ; Kill existing inventory drawing if it exists
  ; and make a new one

  lda #(`procPrepItemsDrawInventory)<<8
  sta lR44+1
  lda #<>procPrepItemsDrawInventory
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +
  phx
  lda #(`procPrepItemsDrawInventory)<<8
  sta lR44+1
  lda #<>procPrepItemsDrawInventory
  sta lR44
  jsl rlProcEngineCreateProc
  plx
  rtl

rsPrepItemsCopyUnitListSlice ; 81/E633

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  ; When the menu options subwindow is opened
  ; we need to copy the visible section of the unit list
  ; to the main tilemap section because
  ; we can't use the window/bg scrolling shenanigans
  ; at the same time

  ; width, height

  lda #26
  sta wR0

  lda #10
  sta wR1

  ; Where we're drawing it to

  lda #<>aBG3TilemapBuffer + ((5 + (17 * $20)) * 2)
  sta lR19

  lda #>`aBG3TilemapBuffer
  sta lR18+1

  ; Get where we're grabbing it from

  lda wMenuLineScrollCount
  asl a
  clc
  adc #1 * $20
  asl a
  asl a
  asl a
  asl a
  asl a
  asl a
  clc
  adc #10
  clc
  adc #<>aBG3TilemapBuffer
  sta lR18
  stz wUnknown000DE7,b
  jsl $84A3FF

  ; Get positions for the map sprites

  lda wPrepUnitListSpriteVerticalOffset
  inc a
  sec
  sbc wBuf_BG3VOFS
  sta wPrepUnitListSpriteVerticalOffset

  ; Account for BG layers having their first pixel cut off

  lda #1
  sta wBuf_BG3VOFS

  lda #$0003
  jsl rlHDMAArrayEngineFreeEntryByIndex

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (17 * $20)) * 2), ((10 * $20) * 2), VMAIN_Setting(True), ($A000 + ((0 + (17 * $20)) * 2))

  rts

rsPrepItemsDrawOptionsTilemaps ; 81/E68A

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  ; Save positions

  lda wBuf_BG3VOFS
  sta wPrepUnitListLastScrollOffset

  lda wPrepUnitListColumn
  sta wPrepUnitListLastSelectedColumn

  lda wPrepUnitListRow
  sta wPrepUnitListLastSelectedRow

  lda wMenuLineScrollCount
  sta wPrepUnitListLastScrolledMenuLine

  ; Draw a segment of the unit list to the tilemap

  jsr rsPrepItemsCopyUnitListSlice

  ; Draw the description of last selected menu option

  lda wPrepItemsSelectedOption
  jsr rsPrepItemsDrawHoverMenuDescriptionText

  lda #$2000
  sta wUnknown000DE7,b

  ; Draw the options subwindow tilemap in two parts

  lda #<>$F4F46E
  sta lR18
  lda #>`$F4F46E
  sta lR18+1

  lda #9
  sta wR0

  lda #6
  sta wR1

  lda #<>aBG3TilemapBuffer + ((0 + (16 * $20)) * 2)
  sta lR19

  jsl $84A3FF

  lda #<>$F4F45C
  sta lR18
  lda #>`$F4F45C
  sta lR18+1

  lda #9
  sta wR0

  lda #6
  sta wR1

  lda #<>aBG3TilemapBuffer + ((0 + (22 * $20)) * 2)
  sta lR19

  jsl $84A3FF

  jsr rsPrepItemsDrawUnitListFrozenCursor

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (16 * $20)) * 2), ((0 + (12 * $20)) * 2), VMAIN_Setting(True), ($A000 + ((0 + (16 * $20)) * 2))

  jmp rsPrepItemsSelectNextAction

rsUnknown81E6FD ; 81/E6FD

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsr rsPrepItemsHandleOptionsSubmenuInputs
  jsr rsPrepItemsDrawOptionsCursor
  jsr rsPrepItemsDrawUnitListFrozenCursor
  rts

rsPrepItemsHandleOptionsSubmenuInputs ; 81/E707

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda wJoy1Alt
  bit #JoypadUp
  bne _Up

  bit #JoypadDown
  bne _Down

  lda wJoy1New
  bit #JoypadB
  bne _B

  bit #JoypadA
  bne _A

  rts

  _Up

  ; Check if we need to wrap to bottom

  lda wPrepItemsSelectedOption
  bne +

  ; Don't wrap if held input

  lda wJoy1Alt
  cmp wJoy1New
  bne _End

  ; Fetch past the end

  lda #_Discard - _ActionTable + 2

  +

  ; Move up an option

  dec a
  dec a
  sta wPrepItemsSelectedOption

  ; Draw the new description

  jsr rsPrepItemsDrawHoverMenuDescriptionText

  ; Play a sound

  lda #$0009
  jsl rlUnknown808C87

  _End
  rts

  _Down

  ; Same as up

  lda wPrepItemsSelectedOption
  cmp #_Discard - _ActionTable
  bne +

  lda wJoy1Alt
  cmp wJoy1New
  bne _End

  lda #+(_List - _ActionTable - 2)

  +
  inc a
  inc a
  sta wPrepItemsSelectedOption

  jsr rsPrepItemsDrawHoverMenuDescriptionText

  lda #$0009
  jsl rlUnknown808C87
  rts

  _B

  lda #(aPrepItemsDescriptionPointers._MainDescription - aPrepItemsDescriptionPointers)
  jsr rsPrepItemsDrawMenuDescriptionText

  jsr rsPrepItemsClearOptionsTilemap

  lda #aMainPrepItemsActionTable.HandleUnitList
  sta wPrepItemsActionIndex

  lda #$0021
  jsl rlUnknown808C87
  rts

  _A
  lda #$000D
  jsl rlUnknown808C87

  stz wPrepItemsDiscardIndex

  ldx wPrepItemsSelectedOption
  lda _ActionTable,x
  sta wPrepItemsActionIndex

  rts

  _ActionTable ; 81/E78B
    _List   .word aMainPrepItemsActionTable.List
    _Trade    .word aMainPrepItemsActionTable.Trade
    _Armory   .word aMainPrepItemsActionTable.Armory
    _Convoy   .word aMainPrepItemsActionTable.Convoy
    _Discard  .word aMainPrepItemsActionTable.Discard

rsPrepItemsClearOptionsTilemap ; 81/E795

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda wPrepUnitListSpriteVerticalOffset
  dec a
  clc
  adc wPrepUnitListLastScrollOffset
  sta wPrepUnitListSpriteVerticalOffset

  lda wPrepUnitListLastScrollOffset
  sta wBuf_BG3VOFS

  ; Clear the corners of the subwindow's tilemap
  ; because they overwrote the borders

  ; We don't care about the rest of the subwindow
  ; because it'll be covered by the unit list

  ldx #<>aBG3TilemapBuffer + ((7 + (16 * $20)) * 2)
  lda (0 + (0 * $20)) * 2,b,x
  sta (1 + (0 * $20)) * 2,b,x

  lda #$01DF
  sta (1 + (1 * $20)) * 2,b,x

  ldx #<>aBG3TilemapBuffer + ((7 + (27 * $20)) * 2)
  lda (0 + (0 * $20)) * 2,b,x
  sta (1 + (0 * $20)) * 2,b,x

  lda #<>$85BD96
  sta lR44
  lda #>`$85BD96
  sta lR44+1

  lda #$0003
  sta wR40
  jsl rlHDMAArrayEngineCreateEntryByIndex

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (16 * $20)) * 2), ((0 + (2 * $20)) * 2), VMAIN_Setting(True), ($A000 + ((0 + (16 * $20)) * 2))

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (27 * $20)) * 2), ((0 + (2 * $20)) * 2), VMAIN_Setting(True), ($A000 + ((0 + (27 * $20)) * 2))

  rts

rsPrepItemsDrawOptionsCursor ; 81/E7EB

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda #8
  sta wR0

  lda wPrepItemsSelectedOption
  asl a
  asl a
  asl a
  clc
  adc #136
  sta wR1

  jsl $859013
  rts

rsPrepItemsDrawOptionsFrozenCursor ; 81/E801

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda #8
  sta wR0

  lda wPrepItemsSelectedOption
  asl a
  asl a
  asl a
  clc
  adc #136
  sta wR1

  jsl $8590CF
  rts

.include "PROCS/Unknown81E817.asm"

rsPrepItemsSetupDiscard ; 81/E83E

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  ; Get the size of the unit's inventory

  ldx #$0000

  -
  lda aSelectedCharacterBuffer.Items,b,x
  beq +

  inc x
  inc x
  cpx #size(aSelectedCharacterBuffer.Items)
  bne -

  +
  stx wPrepItemsDiscardLength
  txa
  bne +

  ; If they have no items we don't have anything to do

  lda #aMainPrepItemsActionTable.HandleOptionsInputs
  sta wPrepItemsActionIndex
  jmp rsUnknown81E6FD

  +
  lda #(aPrepItemsDescriptionPointers._Discard - aPrepItemsDescriptionPointers)
  jsr rsPrepItemsDrawMenuDescriptionText

  lda #aMainPrepItemsActionTable.HandleDiscardList
  sta wPrepItemsActionIndex

rsPrepItemsDiscardCycle ; 81/E868

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsr rsPrepItemsHandleDiscardInputs
  jsr rsDrawDiscardCursor
  jsr rsPrepItemsDrawOptionsFrozenCursor
  jsr rsPrepItemsDrawUnitListFrozenCursor
  rts

rsPrepItemsHandleDiscardInputs ; 81/E875

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda wJoy1Alt
  bit #JoypadUp
  bne _Up

  bit #JoypadDown
  bne _Down

  lda wJoy1New
  bit #JoypadB
  bne _B

  bit #JoypadA
  bne _A

  rts

  _Up

  ; See if we need to wrap

  lda wPrepItemsDiscardIndex
  bne +

  ; Don't wrap if held input

  lda wJoy1New
  cmp wJoy1Alt
  bne _End

  lda wPrepItemsDiscardLength

  +
  dec a
  dec a
  sta wPrepItemsDiscardIndex
  lda #$0009
  jsl rlUnknown808C87

  _End
  rts

  _Down

  ; Same as up

  lda wPrepItemsDiscardIndex
  inc a
  inc a
  cmp wPrepItemsDiscardLength
  bne +

  lda wJoy1New
  cmp wJoy1Alt
  bne _End

  lda #$0000

  +
  sta wPrepItemsDiscardIndex
  lda #$0009
  jsl rlUnknown808C87
  rts

  _B

  ; Back out of discarding

  lda #aMainPrepItemsActionTable.HandleOptionsInputs
  sta wPrepItemsActionIndex

  lda #$0021
  jsl rlUnknown808C87
  rts

  _A

  ; Discard the selected item

  ; You can't discard unsellable items

  ldx wPrepItemsDiscardIndex
  lda aSelectedCharacterBuffer.Items,b,x
  jsl rlCopyItemDataToBuffer
  lda aItemDataBuffer.Traits,b
  bit #TraitUnsellable
  bne +

  ; Handle discarding

  lda #aMainPrepItemsActionTable.HandleDiscard
  sta wPrepItemsActionIndex

  lda #$000D
  jsl rlUnknown808C87
  rts

  +
  lda #$0022
  jsl rlUnknown808C87
  rts

rsUnknown81E8FD ; 81/E8FD

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  ldx wPrepItemsDiscardIndex
  lda aSelectedCharacterBuffer.Items,b,x
  jsl $85CC59
  rts

aUnknown81E908 ; 81/E908

  .word range(8, 120, 16)

rsDrawDiscardCursor ; 81/E916

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda #136
  sta wR0

  ldx wPrepItemsDiscardIndex
  lda aUnknown81E908,x
  sta wR1
  jsl $859013
  rts

rsDrawDiscardFrozenCursor ; 81/E929

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda #136
  sta wR0

  ldx wPrepItemsDiscardIndex
  lda aUnknown81E908,x
  sta wR1
  jsl $8590CF
  rts

.include "PROCS/Unknown81E93C.asm"

rsPrepItemsSetupSelectedUnit ; 81/EA07

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  ; Copy selected unit

  lda #<>aSelectedCharacterBuffer
  sta wR0

  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl $83905C

  ; Draw the description

  lda #(aPrepItemsDescriptionPointers._Trade - aPrepItemsDescriptionPointers)
  jsr rsPrepItemsDrawMenuDescriptionText

  jsr rsPrepItemsClearOptionsTilemap

  ; Cursor for selected unit

  phx
  lda #(`procPrepItemsTradeInitiatorCursor)<<8
  sta lR44+1
  lda #<>procPrepItemsTradeInitiatorCursor
  sta lR44
  jsl rlProcEngineCreateProc
  plx

  jmp rsPrepItemsSelectNextAction

rsPrepItemsHandleTradeUnitList ; 81/EA31

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsl $85FAFA

  stz wPrepUnitListMovingFlag

  lda wPrepUnitListLastSelectedColumn
  sta wR0

  lda wPrepUnitListLastSelectedRow
  sta wR1

  lda wMenuLineScrollCount

  pha
  jsr rsPrepItemsHandleMainUnitListDirectionalInputs
  jsr rsPrepItemsHandleTradeUnitListOtherInputs
  pla

  jsr rsPrepItemsHandleUnitListScrolling
  lda wPrepUnitListMovingFlag
  beq +

  jsl rlPrepItemsDrawHoveredUnitInfo

  +
  rts

rsPrepItemsHandleTradeUnitListOtherInputs ; 81/EA5A

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda wJoy1New
  bit #JoypadA
  bne _A

  bit #JoypadB
  bne _B

  bit #JoypadX
  bne _X

  rts

  _X

  ; Open hovered unit's inventory

  lda #aMainPrepItemsActionTable.InventoryFromTrade
  sta wPrepItemsActionIndex

  lda #<>rlUnknown80BE27
  sta lUnknown7EA4EC
  lda #>`rlUnknown80BE27
  sta lUnknown7EA4EC+1
  jsl $85FA88
  rts

  _B

  ; Back out of searching for trade partner

  ; Kill trade initiator's cursor

  lda #(`procPrepItemsTradeInitiatorCursor)<<8
  sta lR44+1
  lda #<>procPrepItemsTradeInitiatorCursor
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +

  lda #aMainPrepItemsActionTable.BackOutOfTradeSearch
  sta wPrepItemsActionIndex

  lda #$0021
  jsl rlUnknown808C87
  rts

  _A

  ; Select a trade partner

  ; Ensure that the unit isn't the initiator

  lda wPrepUnitListColumn
  cmp wPrepUnitListLastSelectedColumn
  bne +

  lda wPrepUnitListRow
  cmp wPrepUnitListLastSelectedRow
  bne +

  lda #$0022
  jsl rlUnknown808C87
  bra _End

  +

  lda wPrepUnitListLastSelectedColumn
  sta wR0

  lda wPrepUnitListLastSelectedRow
  sta wR1

  jsl $85FAD0
  sta wR0

  lda #<>aSelectedCharacterBuffer
  sta wR1

  jsl $839086
  jsl $85FAA0

  lda wPrepUnitListColumn
  sta wR0

  lda wPrepUnitListRow
  sta wR1

  jsl $85FAD0
  sta wR0

  lda #<>aItemSkillCharacterBuffer
  sta wR1

  jsl $839086
  jsl $85FAA0

  ; Ensure that both characters have at least one item

  lda aSelectedCharacterBuffer.Items,b
  ora aItemSkillCharacterBuffer.Items,b
  beq _End

  ; Kill the cursor

  lda #(`procPrepItemsTradeInitiatorCursor)<<8
  sta lR44+1
  lda #<>procPrepItemsTradeInitiatorCursor
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +

  lda #<>rlUnknown80BE27
  sta lUnknown7EA4EC
  lda #>`rlUnknown80BE27
  sta lUnknown7EA4EC+1

  stz $7EAD50

  ; Trade?

  jsl rlUnknown80B925

  lda #aMainPrepItemsActionTable.DrawOptionsTilemaps
  sta wPrepItemsActionIndex

  lda #$000D
  jsl rlUnknown808C87

  _End
  rts

rsPrepItemsBackOutOfTradeSearch ; 81/EB33

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda wPrepUnitListLastScrollOffset
  sta wBuf_BG3VOFS

  lda wPrepUnitListLastSelectedColumn
  sta wPrepUnitListColumn

  lda wPrepUnitListLastSelectedRow
  sta wPrepUnitListRow

  lda wPrepUnitListLastScrolledMenuLine
  sta wMenuLineScrollCount

  jsl rlPrepItemsDrawHoveredUnitInfo

  jmp rsPrepItemsSelectNextAction

rsPrepItemsDrawUnitListFrozenCursor ; 81/EB51

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  ; We don't draw the cursor if it's covered by
  ; the options subwindow

  lda wPrepUnitListLastSelectedColumn
  beq +

  sta wR0

  lda wPrepUnitListLastSelectedRow
  sta wR1

  jsl $85FB23

  +
  rts

rsPrepItemsCreateConvoyMenu ; 81/EB62

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsl $85FABE
  sta wR0

  lda #<>aSelectedCharacterBuffer
  sta wR1

  jsl $839086
  jsl $85FAA0

  lda #<>rlUnknown80BE20
  sta lUnknown7EA4EC
  lda #>`rlUnknown80BE20
  sta lUnknown7EA4EC+1

  jsl rlUnknown80BA41

  jmp rsPrepItemsSelectNextAction

rsPrepItemsConvoyDummy ; 81/EB88

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  rts

rlPrepItemsListPopulateListFromUnits ; 81/EB89

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  ; Fills the list of items used by the list menu
  ; by getting all items held by units

  ; Inputs:
  ; A: Pointer to selected unit
  ; X: Current size of aPrepItemsListItemArray

  ; Store current unit, we don't want them in the list

  phx
  sta wR15

  stz wR16
  plx

  -

  ; Grab a unit, check ensure that they exist
  ; and aren't our selected unit

  ldy wR16
  lda aPrepDeploymentSlots,y
  beq _End

  cmp wR15
  beq _Next

  ; Save the unit's ID

  tay
  lda structCharacterDataRAM.Character,b,y
  and #$00FF
  xba
  sta wR17

  ; Go through their items

  tya
  clc
  adc #structCharacterDataRAM.Items
  sta wR1
  ldy #$0000

  -

  ; If out of items, continue

  lda (wR1),y
  beq _Next

  ; Store item

  sta aPrepItemsListItemArray,x

  ; Get unit, combine with index in inventory

  tya
  ora wR17
  sta aPrepItemsListOwnerArray,x

  inc x
  inc x
  inc y
  inc y
  cpy #size(structCharacterDataRAM.Items)
  bne -

  _Next
  inc wR16
  inc wR16
  bra --

  _End
  rtl

rlPrepItemsListPopulateListFromConvoy ; 81/EBCB

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  ; Fills the list of items used by the list menu
  ; by getting all items in the convoy

  ; Inputs:
  ; X: Current size of aPrepItemsListItemArray

  ldy #$0000

  -
  lda aConvoy,y
  beq +

  ; Store item

  sta aPrepItemsListItemArray,x

  ; store index in aPrepItemsListItemArray
  ; owner will be 00

  tya
  sta aPrepItemsListOwnerArray,x

  inc x
  inc x
  inc y
  inc y
  cpy #size(aConvoy)
  bne -

  +
  rtl

.include "PROCS/PrepItemsDrawInventory.asm"

rsPrepItemsSetupList ; 81/ED34

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsl $85C774
  jsl $8AC361
  jsl $85C793

  ; Clear space for our lists of items and their owners

  lda #<>aPrepItemsListItemArray
  sta lR18
  lda #>`aPrepItemsListItemArray
  sta lR18+1
  lda #$0000
  jsl rlFillMapByWord

  lda #<>aPrepItemsListOwnerArray
  sta lR18
  lda #>`aPrepItemsListOwnerArray
  sta lR18+1
  lda #$0000
  jsl rlFillMapByWord

  ; Fill the lists with owned items

  ldx #$0000
  jsl rlPrepItemsListPopulateListFromConvoy
  phx

  jsl $85FABE

  plx
  jsl rlPrepItemsListPopulateListFromUnits

  ; We need there to be at least one item owned

  lda aPrepItemsListItemArray
  beq +

  jsl rlUnknown81F191
  jsr rsPrepItemsClearOptionsTilemap

  lda #120
  sta wBuf_BG3VOFS

  stz $7EA937

  ; Clear the half of the tilemap usually used for the unit list
  ; it'll be used for the item list now

  lda #<>aBG3TilemapBuffer + ((5 + (32 * $20)) * 2)
  sta wR0
  lda #26
  sta wR1
  lda #32
  sta wR2
  lda #$01DF
  jsl rlFillTilemapRectByWord

  lda #(aPrepItemsDescriptionPointers._ListActive - aPrepItemsDescriptionPointers)
  jsr rsPrepItemsDrawMenuDescriptionText

  jsl rsPrepItemsListUpdateSortMethodName

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (32 * $20)) * 2), ((0 + (32 * $20)) * 2), VMAIN_Setting(True), ($A000 + ((0 + (32 * $20)) * 2))

  jmp rsPrepItemsSelectNextAction

  +
  phx
  lda #(`procUnknown81F12C)<<8
  sta lR44+1
  lda #<>procUnknown81F12C
  sta lR44
  jsl rlProcEngineFindProc
  plx
  bcc +

  lda #aMainPrepItemsActionTable.HandleOptionsInputs
  sta wPrepItemsActionIndex
  jmp rsUnknown81E6FD

  +
  jsl rlPrepItemsCopyListSlice

  phx
  lda #(`procUnknown81F12C)<<8
  sta lR44+1
  lda #<>procUnknown81F12C
  sta lR44
  jsl rlProcEngineCreateProc
  plx

  lda #aMainPrepItemsActionTable.DrawOptionsTilemaps
  sta wPrepItemsActionIndex
  rts

rsUnknown81EDED ; 81/EDED

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsl $85B544
  jsl rlPrepItemsResortList
  jsr rsPrepItemsListDrawOwnerName
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG2TilemapBuffer + ((0 + (32 * $20)) * 2), ((0 + (32 * $20)) * 2), VMAIN_Setting(True), ($F000 + ((0 + (32 * $20)) * 2))

  jmp rsPrepItemsSelectNextAction

rsUnknown81EE08 ; 81/EE08

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (32 * $20)) * 2), ((0 + (32 * $20)) * 2), VMAIN_Setting(True), ($A000 + ((0 + (32 * $20)) * 2))

  phx
  lda #(`$85C8BA)<<8
  sta lR44+1
  lda #<>$85C8BA
  sta lR44
  jsl rlProcEngineCreateProc
  plx
  jmp rsPrepItemsSelectNextAction

rsPrepItemsListHandleItemList ; 81/EE28

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsl $85BE14

  lda wMenuLineScrollCount
  sta $7EA939

  stz wPrepUnitListMovingFlag

  jsl $85BE67
  jsr rsPrepItemsListHandleOtherInputs
  jsl $85C003

  lda wPrepUnitListMovingFlag
  beq +

  jsr rsPrepItemsListDrawOwnerName

  lda $7EA939
  sec
  sbc wMenuLineScrollCount
  beq +

  asl a
  asl a
  jsr rsPrepItemsScrollItemList
  lda $7EA939

  jsl $85BFF3

  +
  rts

rsUnknown81EE5E ; 81/EE5E

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  sta wPrepScrollDirectionIncrement

  lda #$0004
  sta wPrepScrollDirectionStep

  lda wPrepItemsActionIndex
  jsl $8397E8

  lda #aMainPrepItemsActionTable.Unknown13
  sta wPrepItemsActionIndex

  lda wPrepScrollDirectionIncrement
  bmi +

  lda #$0008
  jsl $83CCB1
  bra rsPrepItemsDoListScrollStep

  +
  lda #$0008
  jsl $83CCC9
  bra rsPrepItemsDoListScrollStep

rsPrepItemsScrollItemList ; 81/EE8B

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  sta wPrepScrollDirectionIncrement

  ; If holding Y, scroll twice as fast

  lda wJoy1Input
  bit #JoypadY
  bne +

  lda #$0004
  sta wPrepScrollDirectionStep

  lda wPrepItemsActionIndex
  jsl $8397E8

  lda #aMainPrepItemsActionTable.Unknown14
  sta wPrepItemsActionIndex

  lda #$0008
  sta wR17
  bra ++

  +
  lda wPrepScrollDirectionIncrement
  asl a
  sta wPrepScrollDirectionIncrement

  lda #$0002
  sta wPrepScrollDirectionStep

  lda wPrepItemsActionIndex
  jsl $8397E8

  lda #aMainPrepItemsActionTable.Unknown14
  sta wPrepItemsActionIndex

  lda #$0010
  sta wR17

  +
  lda wPrepScrollDirectionIncrement
  bmi +

  lda wR17
  jsl $83CCB1
  bra rsPrepItemsDoListScrollStep

  +
  lda wR17
  jsl $83CCC9
  bra rsPrepItemsDoListScrollStep

rsPrepItemsDoListScrollStep ; 81/EEE3

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda wBuf_BG3VOFS
  sec
  sbc wPrepScrollDirectionIncrement
  sta wBuf_BG3VOFS

  dec wPrepScrollDirectionStep
  bne +

  jsl $839808
  sta wPrepItemsActionIndex

  lda #$0002
  jsl $83CCB1

  lda #$0002
  jsl $83CCC9

  +
  lda wPrepListCursorXCoordinate
  sta wR0

  lda wPrepListCursorYCoordinate
  sta wR1

  jsl $859013
  rts

rsPrepItemsListDrawOwnerName ; 81/EF14

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda #<>$83C0F6
  sta lUnknown000DDE,b
  lda #>`$83C0F6
  sta lUnknown000DDE+1,b

  lda #$2180
  sta wUnknown000DE7,b

  ; Clear space to write name to

  lda #<>aBG3TilemapBuffer + ((1 + (13 * $20)) * 2)
  sta wR0
  lda #5 ; Width
  sta wR1
  lda #2 ; Height
  sta wR2
  ; Normally it'd load the tile index
  ; to fill with here before the jsl
  jsl rlFillTilemapRectByWord

  ; Fetch selected item's owner's name

  jsl $85C352
  tax
  lda aPrepItemsListOwnerArray,x
  xba
  and #$00FF
  jsl $839334

  ; Get name padding amount

  jsl $87E873

  ; Negate it and add to position to write name

  eor #$FFFF
  inc a
  clc
  adc #6 | (13 << 8)
  tax
  jsl $87E728
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (13 * $20)) * 2), ((0 + (2 * $20)) * 2), VMAIN_Setting(True), ($A000 + ((0 + (13 * $20)) * 2))

  rts

rsPrepItemsListHandleOtherInputs ; 81/EF68

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda wJoy1Input
  bit #JoypadDown | JoypadUp
  bne _End

  lda wJoy1New
  bit #JoypadB
  bne _B

  bit #JoypadA
  bne _A

  bit #JoypadSelect
  bne _Select

  _End
  rts

  _B

  ; Backs out of the menu

  lda #$0021
  jsl rlUnknown808C87
  jmp rsPrepItemsSelectNextAction

  _Select

  ; Switches sorting method

  inc wPrepItemsListSortMethod
  inc wPrepItemsListSortMethod

  lda wPrepItemsListSortMethod
  cmp #$0006
  bne +

  stz wPrepItemsListSortMethod

  +
  jsl rlPrepItemsResortList
  jsl rsPrepItemsListUpdateSortMethodNameAndOwner
  phx
  lda #(`procUnknown81F4A9)<<8
  sta lR44+1
  lda #<>procUnknown81F4A9
  sta lR44
  jsl rlProcEngineCreateProc
  plx
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (13 * $20)) * 2), ((0 + (2 * $20)) * 2), VMAIN_Setting(True), ($A000 + ((0 + (13 * $20)) * 2))

  lda #$000B
  jsl rlUnknown808C87
  rts

  _A

  ; Either trade with owner or go to the convoy

  lda #$000C
  jsl rlUnknown808C87

  ; Fetch item's owner

  jsl $85C352
  tax
  lda aPrepItemsListOwnerArray,x
  cmp #$00FF
  bcc _Convoy ; Upper byte will be 00 for convoy

  ; Strip position in inventory from owner

  pha
  and #$000E
  ora #$0010
  sta $7EAD50

  ; Setup owner's data

  pla
  xba
  and #$00FF
  sta wR0
  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl $83976E

  lda wPrepUnitListColumn
  sta wR0
  lda wPrepUnitListRow
  sta wR1
  jsl $85FAD0

  sta wR0
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $839086
  jsl $85FAA0

  ; Trade

  lda #<>rlUnknown80BE27
  sta lUnknown7EA4EC
  lda #>`rlUnknown80BE27
  sta lUnknown7EA4EC+1
  jsl rlUnknown80B925

  lda #aMainPrepItemsActionTable.List
  sta wPrepItemsActionIndex
  rts

  _Convoy

  ; Don't need to strip owner

  sta $7EAD50

  lda wPrepUnitListColumn
  sta wR0
  lda wPrepUnitListRow
  sta wR1
  jsl $85FAD0

  sta wR0
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $839086
  jsl $85FAA0

  ; Convoy

  lda #<>rlUnknown80BE27
  sta lUnknown7EA4EC
  lda #>`rlUnknown80BE27
  sta lUnknown7EA4EC+1
  jsl rlUnknown80BA41

  lda #$0000
  sta $7EA95C

  lda #aMainPrepItemsActionTable.List
  sta wPrepItemsActionIndex
  rts

rsPrepItemsListClearItemListTilemaps ; 81/F068

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  ; Clear item list item names

  lda #<>aBG3TilemapBuffer + ((5 + (32 * $20)) * 2)
  sta wR0
  lda #26
  sta wR1
  lda #32
  sta wR2
  lda #$01DF
  jsl rlFillTilemapRectByWord

  ; Clear item list icons

  lda #<>aBG2TilemapBuffer + ((3 + (32 * $20)) * 2)
  sta wR0
  lda #2
  sta wR1
  lda #32
  sta wR2
  lda #$02FF
  jsl rlFillTilemapRectByWord

  lda #<>aBG2TilemapBuffer + ((19 + (32 * $20)) * 2)
  sta wR0
  lda #2
  sta wR1
  lda #32
  sta wR2
  lda #$02FF
  jsl rlFillTilemapRectByWord

  lda #<>aPrepItemsTextInfo
  sta lUnknown000DDE,b
  lda #>`aPrepItemsTextInfo
  sta lUnknown000DDE+1,b
  jsl $85F747

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (32 * $20)) * 2), ((0 + (32 * $20)) * 2), VMAIN_Setting(True), ($A000 + ((0 + (32 * $20)) * 2))

  jsl $85C8E2
  jsr rsPrepItemsSetLinecounts
  jmp rsPrepItemsSelectNextAction

rsPrepItemsListRevertUnitListPositions ; 81/F0D1

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG2TilemapBuffer + ((0 + (32 * $20)) * 2), ((0 + (32 * $20)) * 2), VMAIN_Setting(True), ($F000 + ((0 + (32 * $20)) * 2))

  phx
  lda #(`procUnknown81F12C)<<8
  sta lR44+1
  lda #<>procUnknown81F12C
  sta lR44
  jsl rlProcEngineCreateProc
  plx

  lda wPrepUnitListLastScrollOffset
  sta wBuf_BG3VOFS

  lda wPrepUnitListLastSelectedColumn
  sta wPrepUnitListColumn

  lda wPrepUnitListLastSelectedRow
  sta wPrepUnitListRow

  lda wPrepUnitListLastScrolledMenuLine
  sta wMenuLineScrollCount

  jmp rsPrepItemsSelectNextAction

.include "PROCS/PrepItemsTradeInitiatorCursor.asm"

.include "PROCS/Unknown81F12C.asm"

rlUnknown81F191 ; 81/F191

  .al
  .xl
  .autsiz
  .databank ?

  lda #(`$83CB4B)<<8
  sta lR44+1
  lda #<>$83CB4B
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +
  lda #(`$83CB7B)<<8
  sta lR44+1
  lda #<>$83CB78
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +
  lda #(`procUnknown81F12C)<<8
  sta lR44+1
  lda #<>procUnknown81F12C
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +
  rtl

rlPrepItemsClearDiscardDescription ; 81/F1CB

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda #<>aBG3TilemapBuffer + ((1 + (10 * $20)) * 2)
  sta wR0
  lda #14
  sta wR1
  lda #5
  sta wR2
  lda #$01DF
  jsl rlFillTilemapRectByWord
  rtl

rsPrepItemsBuildDiscardConfirmMenu ; 81/F1E2

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  ; Clear description and replace it with
  ; the prompt and options

  jsl rlPrepItemsClearDiscardDescription

  lda #$2180
  sta wUnknown000DE7,b

  lda #<>$83C0F6
  sta lUnknown000DDE,b
  lda #>`$83C0F6
  sta lUnknown000DDE+1,b

  ldx #2 | (10 << 8)

  lda #(`menutextPrepItemsDiscardPrompt)<<8
  sta lR18+1
  lda #<>menutextPrepItemsDiscardPrompt
  sta lR18

  jsl $87E728
  bra +

  .include "../TEXT/PREPITEMS/DiscardPrompt.asm"

  +
  ldx #4 | (13 << 8)
  lda #(`menutextPrepItemsDiscardOptions)<<8
  sta lR18+1
  lda #<>menutextPrepItemsDiscardOptions
  sta lR18
  jsl $87E728
  bra +

  .include "../TEXT/PREPITEMS/DiscardOptions.asm"

  +

  ; Flag tilemaps for display and continue

  jsl rlEnableBG3Sync

  lda #$0002
  sta wEventEngineUnknownXTarget

  lda #aMainPrepItemsActionTable.HandleDiscardConfirm
  sta wPrepItemsActionIndex

rlPrepItemsHandleDiscard ; 81/F256

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsr rsPrepItemsDrawOptionsFrozenCursor
  jsr rsPrepItemsDrawUnitListFrozenCursor
  jsr rsDrawDiscardFrozenCursor
  jsr rsPrepItemsHandleDiscardConfirmInputs
  jsl rlPrepItemsDrawDiscardCursor
  rts

rsPrepItemsHandleDiscardConfirmInputs ; 81/F267

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda wJoy1New
  bit #JoypadLeft
  bne _Left

  bit #JoypadRight
  bne _Right

  bit #JoypadB
  bne _B

  bit #JoypadA
  bne _A

  rts

  _Left

  stz wEventEngineUnknownXTarget

  lda #$0009
  jsl rlUnknown808C87
  rts

  _Right

  lda #$0002
  sta wEventEngineUnknownXTarget

  lda #$0009
  jsl rlUnknown808C87
  rts

  _B

  ; Back out of menu

  lda #aMainPrepItemsActionTable.Discard
  sta wPrepItemsActionIndex

  lda #$0021
  jsl rlUnknown808C87
  rts

  _A

  ; Discard the item

  lda #aMainPrepItemsActionTable.Discard
  sta wPrepItemsActionIndex

  lda wEventEngineUnknownXTarget
  beq +

  rts

  +
  lda #$000D
  jsl rlUnknown808C87

  ldx wPrepItemsDiscardIndex

  ; Clear the item and write unit's data back

  lda #$0000
  sta aSelectedCharacterBuffer.Items,b,x

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $83A49C

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $839041

  phx
  lda #(`procPrepItemsDrawInventory)<<8
  sta lR44+1
  lda #<>procPrepItemsDrawInventory
  sta lR44
  jsl rlProcEngineCreateProc
  plx

  ; Stop if they're out of items
  ; Else dec number of remaining items

  lda wPrepItemsDiscardLength
  cmp #$0002
  beq ++

  dec a
  dec a
  cmp wPrepItemsDiscardIndex
  beq +

  rts

  +
  dec wPrepItemsDiscardIndex
  dec wPrepItemsDiscardIndex
  rts

  +
  lda #(aPrepItemsDescriptionPointers._Discard - aPrepItemsDescriptionPointers)
  jsr rsPrepItemsDrawMenuDescriptionText

  lda #aMainPrepItemsActionTable.HandleOptionsInputs
  sta wPrepItemsActionIndex

  rts

rlPrepItemsDrawDiscardCursor ; 81/F307

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  ldx wEventEngineUnknownXTarget
  lda _CursorxTable,x
  sta wR0
  lda #104
  sta wR1
  jsl $859013
  rtl

  _CursorxTable ; 81/F31A
    .word 16
    .word 56

rlPrepItemsResortList ; 81/F31E

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda wPrepItemsListSortMethod
  jsl $85C8A6
  jsl $85C7DB
  jsl $85BC15
  rtl

rsPrepItemsDrawMenuDescriptionText ; 81/F32E

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsr rsPrepItemsClearMenuDescriptionTextSpace

  tay
  lda #<>$83C0F6
  sta lUnknown000DDE,b
  lda #>`$83C0F6
  sta lUnknown000DDE+1,b

  lda #$2180
  sta wUnknown000DE7,b

  ; Get pointers to both lines and draw

  lda #>`aPrepItemsDescriptionPointers
  sta lR18+1
  lda #<>aPrepItemsDescriptionPointers
  sta lR19
  lda #>`aPrepItemsDescriptionPointers
  sta lR19+1
  lda [lR19],y
  sta lR18
  inc y
  inc y
  lda [lR19],y
  pha
  ldx #1 | (10 << 8)
  jsl $87E728

  pla
  sta lR18
  ldx #1 | (13 << 8)
  jsl $87E728

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (10 * $20)) * 2), ((0 + (5 * $20)) * 2), VMAIN_Setting(True), ($A000 + ((0 + (10 * $20)) * 2))

  rts

rsPrepItemsClearMenuDescriptionTextSpace ; 81/F37B

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  pha
  lda #<>aBG3TilemapBuffer + ((1 + (10 * $20)) * 2)
  sta wR0
  lda #14
  sta wR1
  lda #5
  sta wR2
  jsl rlFillTilemapRectByWord
  pla
  rts

.include "../TABLES/PrepItemsDescriptions.asm"

.include "../TEXT/PREPITEMS/DescriptionLine1.asm"
.include "../TEXT/PREPITEMS/DescriptionLine2.asm"
.include "../TEXT/PREPITEMS/ListDescriptionLine1.asm"
.include "../TEXT/PREPITEMS/ListDescriptionLine2.asm"
.include "../TEXT/PREPITEMS/TradeDescriptionLine1.asm"
.include "../TEXT/PREPITEMS/ConvoyDescriptionLine1.asm"
.include "../TEXT/PREPITEMS/DiscardDescriptionLine1.asm"
.include "../TEXT/PREPITEMS/ArmoryDescriptionLine1.asm"
.include "../TEXT/PREPITEMS/BlankDescriptionLine.asm"

rsUnknown81F457 ; 81/F457

  .al
  .xl
  .autsiz
  .databank ?

  lda wJoy1New
  and #~JoypadID
  beq +

  jsl $85CD4D

  +
  rts

rsPrepItemsDrawHoverMenuDescriptionText ; 81/F463

  .al
  .xl
  .autsiz
  .databank ?

  tax
  lda _HoverDescriptions,x
  jsr rsPrepItemsDrawMenuDescriptionText
  rts

  _HoverDescriptions ; 81/F46C
    .word aPrepItemsDescriptionPointers._List - aPrepItemsDescriptionPointers
    .word aPrepItemsDescriptionPointers._Trade - aPrepItemsDescriptionPointers
    .word aPrepItemsDescriptionPointers._Armory - aPrepItemsDescriptionPointers
    .word aPrepItemsDescriptionPointers._Convoy - aPrepItemsDescriptionPointers
    .word aPrepItemsDescriptionPointers._Discard - aPrepItemsDescriptionPointers

rsPrepItemsListUpdateSortMethodNameAndOwner ; 81/F476

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsr rsPrepItemsListDrawOwnerName
  bra +

rsPrepItemsListUpdateSortMethodName ; 81/F47B

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer + ((0 + (13 * $20)) * 2), ((0 + (2 * $20)) * 2), VMAIN_Setting(True), ($A000 + ((0 + (13 * $20)) * 2))

  +
  lda #<>$83C0F6
  sta lUnknown000DDE,b
  lda #>`$83C0F6
  sta lUnknown000DDE+1,b

  lda #$2980
  sta wUnknown000DE7,b

  lda wPrepItemsListSortMethod
  jsl $85CDB5

  ldx #9 | (13 << 8)
  jsl $87E728
  rtl

.include "PROCS/Unknown81F4A9.asm"

rsPrepItemsHandleArmory ; 81/F4D8

  .al
  .xl
  .autsiz
  .databank `wPrepItemsActionIndex

  lda #$0004
  jsl rlHDMAArrayEngineFreeEntryByIndex

  lda #$0005
  jsl rlHDMAArrayEngineFreeEntryByIndex

  lda #(`procPortrait0)<<8
  sta lR44+1
  lda #<>procPortrait0
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +
  jsl $83CB80
  jsl $83CB94
  jsl rlUnknown80B981

  lda #<>rlUnknown80BE20
  sta lUnknown7EA4EC
  lda #>`rlUnknown80BE20
  sta lUnknown7EA4EC+1
  rts

rlUnknown81F512 ; 81/F512

  .al
  .xl
  .autsiz
  .databank ?

  lda #(`procItemSelectPortrait)<<8
  sta lR44+1
  lda #<>procItemSelectPortrait
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +
  lda #(`procPortrait0)<<8
  sta lR44+1
  lda #<>procPortrait0
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +
  lda #(`procPortrait1)<<8
  sta lR44+1
  lda #<>procPortrait1
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +
  lda #(`procPortrait2)<<8
  sta lR44+1
  lda #<>procPortrait2
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +
  lda #(`procPortrait3)<<8
  sta lR44+1
  lda #<>procPortrait3
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +
  lda #(`$85F7FF)<<8
  sta lR44+1
  lda #<>$85F7FF
  sta lR44
  jsl rlProcEngineFindProc
  bcc +

  stz aProcHeaderTypeOffset,b,x

  +
  lda #$0009
  jsl rlUnknown808C87
  jsl $839B7F
  rtl

