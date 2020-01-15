
rlDrawBurstWindow ; 84/A09B

  .al
  .autsiz
  .databank `aOptions.wBurstWindowOption

  lda aOptions.wBurstWindowOption
  cmp #$0001
  beq _BurstDisabled

  lda wBurstWindowDrawn
  bne _Drawn

  bra _NotDrawn

  _BurstDisabled
  rtl

  _NotDrawn

  ; We only draw the window for visible units

  ldx wCursorTileIndex,b
  lda aPlayerVisibleUnitMap,x
  and #$00FF
  sta wR17
  beq _DoNotDraw

  ; We begin a counter for the cursor
  ; being held on this unit at these coords
  ; for ten frames before drawing the window

  cmp wBurstWindowTargetDeploymentNumber
  bne _DoNotDraw

  inc wBurstWindowDelayCounter
  lda wBurstWindowDelayCounter
  cmp #10
  beq _DrawWindow
  rtl

  _DoNotDraw
  stz wBurstWindowDelayCounter

  lda wR17
  sta wBurstWindowTargetDeploymentNumber

  lda wCursorXCoord,b
  sta wBurstWindowTargetXCoordinate
  lda wCursorYCoord,b
  sta wBurstWindowTargetYCoordinate
  rtl

  _Drawn

  ; If the window is already drawn
  ; check if it needs to be cleared

  lda wCursorXCoord,b
  cmp wBurstWindowTargetXCoordinate
  bne _ClearWindow

  lda wCursorYCoord,b
  cmp wBurstWindowTargetYCoordinate
  bne _ClearWindow

  ; While the cursor is held on
  ; the unit, swap between showing
  ; HP and status every 64 frames if
  ; the unit has an abnormal status

  lda wUnknown0000DB
  and #$003F
  bne +

  lda wBurstWindowTargetDeploymentNumber
  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aBurstWindowCharacterBuffer.Status,b
  and #$00FF
  beq +

  lda wUnknown0000DB
  and #$007F
  beq _SwapHP
  bra _SwapStatus

  +
  rtl

  _SwapHP
  jsr rsDrawBurstWindowHP
  jsl rlEnableBG3Sync
  rtl

  _SwapStatus
  jsr rsDrawBurstWindowStatus
  jsl rlEnableBG3Sync
  rtl

  _ClearWindow
  sep #$20
  lda #TM_Setting(True, True, True, False, True)
  sta bBuf_TM
  rep #$20

  lda wBurstWindowDrawn
  beq +

  jsr rsClearBurstWindowTilemap

  stz wBurstWindowTargetDeploymentNumber
  stz wBurstWindowDrawn

  jsl rlEnableBG1Sync
  jsl rlEnableBG3Sync

  +
  rtl

  _DrawWindow
  dec wBurstWindowDrawn

  lda wBurstWindowTargetDeploymentNumber
  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  jsl rlGetBurstWindowPalette
  jsr rsGetBurstWindowStyle
  jsr rsGetBurstWindowPosition
  jsr rsGetBurstWindowCharacterName
  jsr rsDrawBurstWindowHPIfNotStatus
  jsr rsDrawBurstWindowTilemap
  jsl rlEnableBG1Sync
  jsl rlEnableBG3Sync

  lda wCursorXCoord,b
  sta wBurstWindowTargetXCoordinate
  lda wCursorYCoord,b
  sta wBurstWindowTargetYCoordinate
  rtl

rlDMABurstWindowTiles ; 84/A17D

  .autsiz
  .databank ?

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $F4F700, $02C0, VMAIN_Setting(True), $4000

  rtl

rsGetBurstWindowStyle ; 84/A18B

  .autsiz
  .databank `aOptions.wBurstWindowOption

  ; There are 6 styles of burst window:
  ; Above the unit
  ; Above and to the right of the unit
  ; Above and to the left of the unit
  ; Below the unit
  ; Below and to the right of the unit
  ; Below and to the left of the unit

  ; Thus style+3 gives the lower window
  ; style+1 gives the right window
  ; style+2 gives the left window

  php
  rep #$30

  stz wBurstWindowStyle

  ; First we grab the pixel distance of the
  ; cursor from top left of the screen

  lda wCursorXCoord,b
  sta wR0
  lda wCursorYCoord,b
  sta wR1
  jsl rlUnknown81B544

  ; We want at more than 8 grahpics tiles between
  ; the target unit's origin and the top of the window
  ; vertically to use the 'Above the unit' style

  lda wR1
  cmp #64
  beq +
  bge _YGreaterThan64

  +
  inc wBurstWindowStyle
  inc wBurstWindowStyle
  inc wBurstWindowStyle

  _YGreaterThan64

  ; If there are less than 3 tiles between
  ; the target unit's origin and the left
  ; edge of the screen we need to use the
  ; 'to the right of the unit' style

  lda wR0
  cmp #16
  beq +
  bge _XGreaterThan16

  +
  inc wBurstWindowStyle

  _XGreaterThan16

  ; Otherwise check if there are less than 4
  ; to the right of the target unit's origin
  ; for the 'to the left of the unit' style

  cmp #256 - 32
  blt _XLowerThan224

  inc wBurstWindowStyle
  inc wBurstWindowStyle

  _XLowerThan224

  ; Store the tile coordinates of the
  ; unit's origin relative to the screen

  lda wR0
  lsr a
  lsr a
  lsr a
  sta wBurstWindowOriginXTile

  lda wR1
  lsr a
  lsr a
  lsr a
  sta wBurstWindowOriginYTile

  plp
  rts

rsGetBurstWindowPosition ; 84/A1DA

  .al
  .autsiz
  .databank `aOptions.wBurstWindowOption

  ; Use style*sizeof(sint) to get
  ; burst window tilemap position relative
  ; to target unit's origin

  lda wBurstWindowStyle
  asl a
  asl a
  tax

  lda wBurstWindowOriginXTile
  clc
  adc aBurstWindowPositionTable,x
  sta wBurstWindowPositionXTile

  lda wBurstWindowOriginYTile
  clc
  adc aBurstWindowPositionTable+2,x
  sta wBurstWindowPositionYTile

  rts

aBurstWindowPositionTable ; 84/A1F7
  .sint [-3, -6]
  .sint [ 1, -6]
  .sint [-8, -6]
  .sint [-3,  3]
  .sint [ 1,  3]
  .sint [-8,  3]

rsGetBurstWindowCharacterName ; 84/A20F

  .al
  .autsiz
  .databank `aOptions.wBurstWindowOption

  ; Name gets drawn one tile down from
  ; the top of the window

  lda aBurstWindowCharacterBuffer.Character,b
  jsl rlGetCharacterNamePointer

  lda #$3180
  sta wUnknown000DE7,b
  lda #<>$83C0F6
  sta lUnknown000DDE,b
  lda #>`$83C0F6
  sta lUnknown000DDE+1,b

  lda wBurstWindowPositionYTile
  inc a
  sta wBurstWindowNameYTile

  xba
  ora wBurstWindowPositionXTile
  inc a
  tax
  jsl $87E728
  rts

rsDrawBurstWindowStatus ; 84/A23A

  .al
  .xl
  .autsiz
  .databank `aOptions.wBurstWindowOption

  ; Use X as an index in a table of
  ; graphics tilemap offsets for the various
  ; status text images

  ; Table order follows the comparisons below
  ; every failed comparison increases the index

  lda aBurstWindowCharacterBuffer.Status,b
  and #$00FF
  ldx #$0000
  cmp #StatusSleep
  beq +

  inc x

  cmp #StatusPetrify
  beq +

  inc x

  cmp #StatusSilence
  beq +

  inc x

  cmp #StatusPoison
  beq +

  inc x

  cmp #StatusBerserk
  beq +

  ; Since we only reach this routine
  ; if the unit has a status, any other
  ; status not listed here will hang

  ; Interesting that it jumps to the bank $00 handler

  jsl riBRK & $00FFFF

  +

  ; First we clear the HP
  ; text, which is 3 tiles down and 1 over

  lda wBurstWindowPositionYTile
  clc
  adc #3
  asl a
  asl a
  asl a
  asl a
  asl a
  clc
  adc wBurstWindowPositionXTile
  asl a
  pha
  phx

  clc
  adc #<>aBG3TilemapBuffer + ((1 + (0 * $10)) * 2)
  sta wR0
  lda #7
  sta wR1
  lda #1
  sta wR2
  lda #$01DF
  jsl rlFillTilemapRectByWord

  ; Get tilemap for status text

  plx
  lda #>`$F4F400
  sta lR18+1
  lda aBurstWindowStatusTilemapOffsetTable,x
  and #$00FF
  clc
  adc #<>$F4F400
  sta lR18

  ; Drawing the image 4 tiles right

  pla
  clc
  adc #<>aBG3TilemapBuffer + ((4 + (0 * $10)) * 2)
  sta lR19

  lda #4
  sta wR0
  lda #1
  sta wR1
  lda #$1000
  sta wUnknown000DE7,b
  jsl $84A3FF
  rts

aBurstWindowStatusTilemapOffsetTable ; 84/A2BD
  .byte $0E
  .byte $16
  .byte $1E
  .byte $26
  .byte $2E

rsDrawBurstWindowHPIfNotStatus ; 84/A2C2

  .al
  .autsiz
  .databank `aOptions.wBurstWindowOption

  lda aBurstWindowCharacterBuffer.Status,b
  and #$00FF
  beq rsDrawBurstWindowHP

  jmp rsDrawBurstWindowStatus

rsDrawBurstWindowHP ; 84/A2CD

  .al
  .autsiz
  .databank `aOptions.wBurstWindowOption

  ; Get the tilemap for the HP
  ; text

  lda #<>$F4F400
  sta lR18
  lda #>`$F4F400
  sta lR18+1
  lda #7
  sta wR0
  lda #1
  sta wR1

  lda wBurstWindowNameYTile
  inc a
  inc a
  asl a
  asl a
  asl a
  asl a
  asl a
  clc
  adc wBurstWindowPositionXTile
  inc a
  asl a
  clc
  adc #<>aBG3TilemapBuffer
  sta lR19
  pha

  lda #$2000
  sta wUnknown000DE7,b
  jsl $84A3FF

  ; Draw current and max HP
  ; HP text tilemap already includes
  ; the base tile index of the numbers tiles
  ; so each tilemap entry just needs the digit
  ; added to it

  ply
  inc y
  inc y
  inc y
  inc y
  lda aBurstWindowCharacterBuffer.CurrentHP,b
  jsr rsDrawBurstWindowNumber

  inc y
  inc y
  lda aBurstWindowCharacterBuffer.MaxHP,b
  jsr rsDrawBurstWindowNumber
  rts

rsDrawBurstWindowNumber ; 84/A316

  .al
  .autsiz
  .databank `aOptions.wBurstWindowOption

  and #$00FF
  asl a
  tax

  lda $87E26C,x
  and #$00FF
  bne _UpperDigit

  lda #$01DF
  sta $0000,b,y
  bra +

  _UpperDigit
  clc
  adc $0000,b,y
  sta $0000,b,y

  +
  inc y
  inc y
  lda $87E26B,x
  and #$00FF
  clc
  adc $0000,b,y
  sta $0000,b,y
  inc y
  inc y
  rts

rsDrawBurstWindowTilemap ; 84/A346

  .al
  .autsiz
  .databank `aOptions.wBurstWindowOption

  lda #>`$F3FC80
  sta lR18+1

  lda wBurstWindowStyle
  asl a
  tax
  lda aBurstWindowTilemapTable,x
  sta lR18

  lda wBurstWindowPositionYTile
  asl a
  asl a
  asl a
  asl a
  asl a
  clc
  adc wBurstWindowPositionXTile
  asl a
  clc
  adc #<>aBG1TilemapBuffer
  sta lR19
  lda #9
  sta wR0
  lda #5
  sta wR1
  lda #$2400
  sta wUnknown000DE7,b
  jsl $84A3FF
  rts

aBurstWindowTilemapTable ; 84/A37E
  .word <>$F3FC80
  .word <>$F3FC92
  .word <>$F3FCA4
  .word <>$F3FDC0
  .word <>$F3FDD2
  .word <>$F3FDE4

rlGetBurstWindowPalette ; 84/A38A

  .al
  .xl
  .autsiz
  .databank ?

  phb
  lda aBurstWindowCharacterBuffer.DeploymentNumber,b
  and #Player | Enemy | NPC
  lsr a
  lsr a
  lsr a
  lsr a
  lsr a
  tax
  lda aBurstWindowPaletteTable,x
  tax
  ldy #aBGPal1
  lda #size(aBGPal1)-1
  mvn #`$9E8600,#$7E
  plb
  rtl

aBurstWindowPaletteTable ; 84/A3A7
  .word <>$9E8600
  .word <>$9E8620
  .word <>$9E8640

rsClearBurstWindowTilemap ; 84/A3AD

  .al
  .autsiz
  .databank `aOptions.wBurstWindowOption

  lda wBurstWindowPositionYTile
  asl a
  asl a
  asl a
  asl a
  asl a
  clc
  adc wBurstWindowPositionXTile
  asl a
  pha
  clc
  adc #<>aBG1TilemapBuffer
  tax
  lda #$02FF
  jsr rsClearBurstWindowTilemapLayer

  pla
  clc
  adc #<>aBG3TilemapBuffer
  tax
  lda #$01DF
  jsr rsClearBurstWindowTilemapLayer
  rts

rsClearBurstWindowTilemapLayer ; 84/A3D3

  .al
  .xl
  .autsiz
  .databank ?

  ; Fill 5 rows of 9 tiles with value in A

  sta wR0
  ldy #5

  -
  lda wR0
  sta $0000,b,x
  sta $0002,b,x
  sta $0004,b,x
  sta $0006,b,x
  sta $0008,b,x
  sta $000A,b,x
  sta $000C,b,x
  sta $000E,b,x
  sta $0010,b,x
  txa
  clc
  adc #(32 * 2)
  tax
  dec y
  bpl -

  rts
