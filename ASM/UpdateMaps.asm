
aUnknown81A800 ; 81/A800
.for n=0, n<16, n+=1
  .for i=0, i<64, i+=4
    .word (n * $80) + i
  .next
  .for i=0, i<64, i+=4
    .word $0800 + (n * $80) + i
  .next
.next

rlUpdateUnitMapsAndFog ; 81/AC00

  .autsiz
  .databank ?

  php
  rep #$30
  jsl rlUpdateUnitMaps
  jsl rlUpdateFogTiles
  lda #%00000100
  sta wBGUpdateFlags
  plp
  rtl

rlUpdateVisibilityMap ; 81/AC14

  .al
  .xl
  .autsiz
  .databank ?

  jsl $83A73C ; Update visibility map
  jsl $83A617
  jsl $83A678
  rtl

rlUpdateUnitMaps ; 81/AC21

  .xl
  .autsiz
  .databank ?

  php
  phb
  sep #$20
  lda #`aPlayerVisibleUnitMap
  pha
  rep #$20
  plb

  .databank `aPlayerVisibleUnitMap

  ; Clear player-visible unit map

  lda #(`aPlayerVisibleUnitMap)<<8
  sta lR18+1
  lda #<>aPlayerVisibleUnitMap
  sta lR18
  lda #$0000
  jsl rlFillMapByWord

  ; Clear unit map

  lda #(`aUnitMap)<<8
  sta lR18+1
  lda #<>aUnitMap
  sta lR18
  lda #$0000
  jsl rlFillMapByWord

  ; Refill the maps

  lda #<>rlUpdateUnitMapStatus
  sta lR25
  lda #(rlUpdateUnitMapStatus)>>8
  sta lR25+1
  lda #Player + 1
  jsl $839825
  lda #Enemy + 1
  jsl $839825
  lda #NPC + 1
  jsl $839825
  jsl $8885D1
  plb
  plp
  rtl

rlUpdateUnitMapStatus ; 81/AC73

  .al
  .xl
  .autsiz
  .databank `aUnitMap

  lda aTargetingCharacterBuffer.TurnStatus,b
  bit #TurnStatusRescued | TurnStatusActing
  bne _End

  lda aTargetingCharacterBuffer.X,b
  and #$00FF
  sta wR0

  lda aTargetingCharacterBuffer.Y,b
  and #$00FF
  sta wR1

  jsl rlGetMapTileIndexByCoords
  tax

  sep #$20
  lda aTargetingCharacterBuffer.DeploymentNumber,b
  sta aUnitMap,x
  lda aVisibilityMap,x
  beq +

  lda aTargetingCharacterBuffer.DeploymentNumber,b
  sta aPlayerVisibleUnitMap,x
  rep #$30
  lda aTargetingCharacterBuffer.TurnStatus,b
  and #~TurnStatusUnselectable
  sta aTargetingCharacterBuffer.TurnStatus,b
  lda #aTargetingCharacterBuffer
  sta wR1
  jsl $839041

  _End
  rtl

  +
  rep #$30
  lda aTargetingCharacterBuffer.TurnStatus,b
  ora #TurnStatusUnselectable
  sta aTargetingCharacterBuffer.TurnStatus,b
  lda #aTargetingCharacterBuffer
  sta wR1
  jsl $839041
  rtl

rlUpdateFogTiles ; 81/ACCD

  .autsiz
  .databank ?

  php
  sep #$20
  phb
  lda #`aVisibilityMap
  pha
  plb

  .databank `aVisibilityMap

  rep #$30

  ; Get map position of screen

  lda wMapScrollWidthPixels,b
  lsr a
  lsr a
  lsr a
  lsr a
  sta wMapScrollWidth16,b
  sta wR0

  lda wMapScrollHeightPixels,b
  lsr a
  lsr a
  lsr a
  lsr a
  sta wMapScrollHeight16,b
  sta wR1

  jsl rlGetMapTileIndexByCoords
  sta wR2

  asl a
  sta wR6

  lda wMapRowSize,b
  sec
  sbc #16
  sta wR9

  stz wR5

  lda #14
  sta wR4

  -
  lda #16
  sta wR3

  -

  ; Check vision map entry for tile

  ldx wR2
  lda aVisibilityMap,x
  and #$00FF
  bne +

  ; If fog, write fow tile

  ldx wR5
  lda aUnknown81A800,x
  tay
  lda #$22FA
  sta aBG2TilemapBuffer+$00,y
  sta aBG2TilemapBuffer+$02,y
  sta aBG2TilemapBuffer+$40,y
  sta aBG2TilemapBuffer+$42,y
  bra ++

  +

  ; Otherwise write map tile

  ldx wR6
  lda aMapMetatileMap,x
  sta wR8
  ldx wR5
  lda aUnknown81A800,x
  tay
  ldx wR8
  lda $7F0010,x
  sta aBG2TilemapBuffer+$00,y
  lda $7F0012,x
  sta aBG2TilemapBuffer+$40,y
  lda $7F0014,x
  sta aBG2TilemapBuffer+$02,y
  lda $7F0016,x
  sta aBG2TilemapBuffer+$42,y

  +
  inc wR2

  inc wR6
  inc wR6

  inc wR5
  inc wR5

  dec wR3
  bne -

  lda wR5
  clc
  adc #$0020
  sta wR5
  lda wR2
  clc
  adc wR9
  sta wR2
  asl a
  sta wR6
  dec wR4
  bne --

  plb
  plp
  rtl

rlHandleMapScrollStep ; 81/AD82

  .autsiz
  .databank ?

  sep #$20
  phb
  lda #`aMapTilemapLeftTileScrollBuffer
  pha
  plb

  .databank `aMapTilemapLeftTileScrollBuffer

  rep #$30

  ; Check if we need to scroll horizontally

  lda wMapScrollWidthPixels,b
  cmp wMapOffsetWidthPixels,b
  beq _CheckVertical
  blt _Left

  ; Scrolling right

  lda wMapScrollWidthPixels,b
  dec a
  dec wMapOffsetWidthPixels,b
  eor wMapOffsetWidthPixels,b
  and #$0010
  beq _CheckVertical

  ; Move toward the next metatile

  lda #16
  sta wR9
  bra _DoHorizontalScroll

  _Left
  lda wMapScrollWidthPixels,b
  eor wMapOffsetWidthPixels,b
  and #$0010
  beq _CheckVertical

  ; Move toward the previous metatile

  stz wR9

  _DoHorizontalScroll
  jsr rsGetScrolledMapTilemapRow

  _CheckVertical

  ; Do the same for vertical scrolling

  lda wMapScrollHeightPixels,b
  cmp wMapOffsetHeightPixels,b
  bne +

  jmp _End

  +
  blt _Up

  ; Scrolling down

  lda wMapScrollHeightPixels,b
  dec a
  dec wMapOffsetHeightPixels,b
  eor wMapOffsetHeightPixels,b
  and #$0010
  beq _End

  lda #14
  sta wR11
  bra _DoVerticalScroll

  _Up
  lda wMapScrollHeightPixels,b
  eor wMapOffsetHeightPixels,b
  and #$0010
  beq _End

  stz wR11

  _DoVerticalScroll
  jsr rsGetScrolledMapTilemapColumn

  _End
  lda wMapScrollWidthPixels,b
  sta wMapOffsetWidthPixels,b
  lda wMapScrollHeightPixels,b
  sta wMapOffsetHeightPixels,b
  plb
  rtl

rsGetScrolledMapTilemapRow ; 81/ADFC

  .al
  .xl
  .autsiz
  .databank ?

  lda wMapScrollHeightPixels,b
  lsr a
  lsr a
  lsr a
  lsr a
  sec
  sbc wMapScrollHeight16,b
  and #$000F
  sta wR2

  asl a
  asl a
  asl a
  asl a
  asl a
  sta wR1

  lda wMapScrollWidthPixels,b
  lsr a
  lsr a
  lsr a
  lsr a
  sec
  sbc wMapScrollWidth16,b
  clc
  adc wR9
  and #$001F
  clc
  adc wR1
  asl a
  sta wR7

  lda wMapScrollWidthPixels,b
  lsr a
  lsr a
  lsr a
  lsr a
  clc
  adc wR9
  sta wR0

  lda wMapScrollHeightPixels,b
  lsr a
  lsr a
  lsr a
  lsr a
  sta wR1

  jsl rlGetMapTileIndexByCoords
  asl a
  sta wR6
  jsr rsCopyScrolledMapTilemapRow
  jsr rsUpdateScrolledMapTilemapRow
  rts

rsGetScrolledMapTilemapColumn ; 81/AE4D

  .al
  .xl
  .autsiz
  .databank ?

  lda wMapScrollWidthPixels,b
  lsr a
  lsr a
  lsr a
  lsr a
  sta wR0

  sec
  sbc wMapScrollWidth16,b
  and #$001F
  sta wR2

  lda wMapScrollHeightPixels,b
  lsr a
  lsr a
  lsr a
  lsr a
  sec
  sbc wMapScrollHeight16,b
  clc
  adc wR11
  and #$000F
  asl a
  asl a
  asl a
  asl a
  asl a
  clc
  adc wR2
  asl a
  sta wR7

  lda wMapScrollHeightPixels,b
  lsr a
  lsr a
  lsr a
  lsr a
  clc
  adc wR11
  sta wR1

  jsl rlGetMapTileIndexByCoords
  asl a
  sta wR6
  jsr rsCopyScrolledMapTilemapColumn
  jsr rsUpdateScrolledMapTilemapColumn
  rts

rsUpdateScrolledMapTilemapRow ; 81/AE95

  .al
  .xl
  .autsiz
  .databank ?

  lda #`aMapTilemapRightTileScrollBuffer
  sta lR18+2

  lda #$0040
  sta wR0

  lda wMapScrollWidthPixels,b
  lsr a
  lsr a
  lsr a
  lsr a
  clc
  adc wR9
  sec
  sbc wMapScrollWidth16,b
  asl a
  and #$003F
  tax
  lda aUnknown81A800,x
  lsr a
  sta wR2
  clc
  adc #$F000 / 2
  sta wR1
  lda #<>aMapTilemapLeftTileScrollBuffer
  sta lR18
  jsl rlDMAByPointerStep32

  lda #<>aMapTilemapRightTileScrollBuffer
  sta lR18
  inc wR1
  jsl rlDMAByPointerStep32

  lda wDisplayRangeFlag,b
  beq _End

  lda #<>aRangeTilemapLeftTileScrollBuffer
  sta lR18
  lda wR2
  clc
  adc #$E000 / 2
  sta wR1
  jsl rlDMAByPointerStep32

  lda #<>aRangeTilemapRightTileScrollBuffer
  sta lR18
  inc wR1
  jsl rlDMAByPointerStep32

  _End
  rts

rsUpdateScrolledMapTilemapColumn ; 81/AEF5

  .al
  .xl
  .autsiz
  .databank ?

  lda #`aBG2TilemapBuffer
  sta lR18+2

  ldx wR7
  lda aUnknown81A800,x
  sta wR4
  and #$0F80
  sta wR2
  clc
  adc #<>aBG2TilemapBuffer
  sta lR18
  lda #$0080
  sta wR0
  lda wR4
  lsr a
  and #$FFE0
  sta wR3
  clc
  adc #$F000 / 2
  sta wR1
  jsl rlDMAByPointer

  lda wDisplayRangeFlag,b
  beq +

  lda wR2
  clc
  adc #<>aBG1TilemapBuffer
  sta lR18
  lda wR3
  clc
  adc #$E000 / 2
  sta wR1
  jsl rlDMAByPointer

  +
  lda wR4
  clc
  adc #$0800
  and #$0F80
  sta wR2
  clc
  adc #<>aBG2TilemapBuffer
  sta lR18
  lda wR4
  clc
  adc #$0800
  and #$0F80
  lsr a
  and #$FFE0
  sta wR3
  clc
  adc #$F000 / 2
  sta wR1
  jsl rlDMAByPointer

  lda wDisplayRangeFlag,b
  beq +

  lda wR2
  clc
  adc #<>aBG1TilemapBuffer
  sta lR18
  lda wR3
  clc
  adc #$E000 / 2
  sta wR1
  jsl rlDMAByPointer

  +
  rts

rsCopyScrolledMapTilemapRow ; 81/AF81

  .al
  .xl
  .autsiz
  .databank `aMapTilemapRightTileScrollBuffer

  ; Clear right tile in metatiles
  ; for scrolling

  lda #$02FF

  .for offset in range(aMapTilemapRightTileScrollBuffer, aMapTilemapRightTileScrollBuffer+size(aMapTilemapRightTileScrollBuffer), 2)

    sta offset

  .next

  ; Scroll buffer index?

  lda wR2
  and #$000F
  asl a
  asl a
  tay

  ; Row count

  lda #15
  sta wR8

  -
  jsr rsCopyHorizontalScrolledMetatileToBuffer
  jsr rsCopyHorizontalScrolledRangeTileToTilemap

  ; wR6 is current metatile index in map / 2
  ; Move down a metatile

  lda wR6
  clc
  adc wMapRowSize,b
  clc
  adc wMapRowSize,b
  sta wR6

  ; Next metatile buffer entry

  tya
  clc
  adc #$0004
  and #$003F
  tay

  ; Next row

  dec wR8
  bpl -

  rts

rsCopyScrolledMapTilemapColumn ; 81/B011

  .al
  .xl
  .autsiz
  .databank ?

  lda wR7
  sta wR10

  lda #16
  sta wR8
  ldy #$0000

  -
  jsr rsCopyVerticalScrolledMetatileToTilemap
  jsr rsCopyVerticalScrolledRangeTileToTilemap

  inc wR6
  inc wR6

  lda wR10
  and #$FFC0
  sta wR0

  lda wR10
  inc a
  inc a
  and #$003F
  clc
  adc wR0
  sta wR10

  dec wR8
  bpl -

  rts

rsCopyHorizontalScrolledMetatileToBuffer ; 81/B03F

  .al
  .xl
  .autsiz
  .databank `aMapTilemapLeftTileScrollBuffer

  ; Check if tile is visible

  lda wR6
  lsr a
  tax
  lda aVisibilityMap,x
  and #$00FF
  beq +

  ; Fetch metatile and copy to scroll buffer

  ldx wR6
  lda aMapMetatileMap,x
  tax
  lda $7F0010,x
  sta aMapTilemapLeftTileScrollBuffer,y
  lda $7F0010+2,x
  sta aMapTilemapLeftTileScrollBuffer+2,y
  lda $7F0010+4,x
  sta aMapTilemapRightTileScrollBuffer,y
  lda $7F0010+6,x
  sta aMapTilemapRightTileScrollBuffer+2,y
  rts

  +

  ; Tile is obscured by fog, draw a black metatile

  lda #$22FA
  sta aMapTilemapLeftTileScrollBuffer,y
  sta aMapTilemapLeftTileScrollBuffer+2,y
  sta aMapTilemapRightTileScrollBuffer,y
  sta aMapTilemapRightTileScrollBuffer+2,y
  rts

rsCopyVerticalScrolledMetatileToTilemap ; 81/B07E

  .al
  .xl
  .autsiz
  .databank `aVisibilityMap

  ; Check if tile is visible

  ldx wR10
  lda aUnknown81A800,x
  tay
  lda wR6
  lsr a
  tax
  lda aVisibilityMap,x
  and #$00FF
  beq +

  ; Fetch metatile and copy

  ldx wR6
  lda aMapMetatileMap,x
  tax
  lda $7F0010,x
  sta aBG2TilemapBuffer+$00,y
  lda $7F0010+2,x
  sta aBG2TilemapBuffer+$40,y
  lda $7F0010+4,x
  sta aBG2TilemapBuffer+$02,y
  lda $7F0010+6,x
  sta aBG2TilemapBuffer+$42,y
  rts

  +

  ; Copy a fog tile

  lda #$22FA
  sta aBG2TilemapBuffer+$00,y
  sta aBG2TilemapBuffer+$02,y
  sta aBG2TilemapBuffer+$40,y
  sta aBG2TilemapBuffer+$42,y
  rts

rsUnknown81B0C4 ; 81/B0C4

  .al
  .xl
  .autsiz
  .databank `aMapTilemapLeftTileScrollBuffer

  lda wR6
  lsr a
  tax
  lda aPlayerVisibleUnitMap,x
  and #$00FF
  beq +

  sta wR0
  lda #aBurstWindowCharacterBuffer
  sta wR1
  jsl $83901C
  jsl rlUnknown81B4D2
  sta aMapTilemapLeftTileScrollBuffer,y
  inc a
  sta aMapTilemapRightTileScrollBuffer,y
  clc
  adc #15
  sta aMapTilemapLeftTileScrollBuffer+2,y
  inc a
  sta aMapTilemapRightTileScrollBuffer+2,y

  +
  rts

rsUnknown81B0F2 ; 81/B0F2

  .al
  .xl
  .autsiz
  .databank `aBG1TilemapBuffer

  ldx wR10
  lda aUnknown81A800,x
  tay
  lda wR6
  lsr a
  tax
  lda aPlayerVisibleUnitMap,x
  and #$00FF
  beq +

  sta wR0
  lda #aBurstWindowCharacterBuffer
  sta wR1
  jsl $83901C
  jsl rlUnknown81B4D2
  sta aBG1TilemapBuffer+$00,y
  inc a
  sta aBG1TilemapBuffer+$02,y
  clc
  adc #$000F
  sta aBG1TilemapBuffer+$40,y
  inc a
  sta aBG1TilemapBuffer+$42,y
  rts

  +
  lda #$02FF
  sta aBG1TilemapBuffer+$00,y
  sta aBG1TilemapBuffer+$02,y
  sta aBG1TilemapBuffer+$40,y
  sta aBG1TilemapBuffer+$42,y
  rts

rsCopyVerticalScrolledRangeTileToTilemap ; 81/B137

  .al
  .xl
  .autsiz
  .databank `aBG1TilemapBuffer

  lda wDisplayRangeFlag,b
  bne +

  rts

  +
  ldx wR10
  lda aUnknown81A800,x
  tay
  lda wR6
  lsr a
  tax
  lda aRangeMap-1,x
  bmi _EdgeOfRange

  ; Max movement range

  cmp #$7100
  bge _Attackable

  ; Moveable space tile

  lda #$2812
  sta aBG1TilemapBuffer+$00,y
  lda #$2813
  sta aBG1TilemapBuffer+$02,y
  lda #$2814
  sta aBG1TilemapBuffer+$40,y
  lda #$2815
  sta aBG1TilemapBuffer+$42,y
  rts

  _EdgeOfRange

  ; Check if this was the edge of
  ; Moveable range

  lda aMovementMap,x
  and #$00FF
  beq _NoTile

  ; Attackable space tile

  _Attackable
  lda #$2412
  sta aBG1TilemapBuffer+$00,y
  lda #$2413
  sta aBG1TilemapBuffer+$02,y
  lda #$2414
  sta aBG1TilemapBuffer+$40,y
  lda #$2415
  sta aBG1TilemapBuffer+$42,y
  rts

  _NoTile
  lda #$02FF
  sta aBG1TilemapBuffer+$00,y
  sta aBG1TilemapBuffer+$02,y
  sta aBG1TilemapBuffer+$40,y
  sta aBG1TilemapBuffer+$42,y
  rts

rsCopyHorizontalScrolledRangeTileToTilemap ; 81/B19C

  .al
  .xl
  .autsiz
  .databank `aRangeTilemapLeftTileScrollBuffer

  lda wDisplayRangeFlag,b
  bne +
  rts

  +
  lda wR6
  lsr a
  tax
  lda aRangeMap-1,x
  bmi _EdgeOfRange

  cmp #$7100
  bge _Attackable

  lda #$2812
  sta aRangeTilemapLeftTileScrollBuffer+$00,y
  lda #$2813
  sta aRangeTilemapRightTileScrollBuffer+$00,y
  lda #$2814
  sta aRangeTilemapLeftTileScrollBuffer+$02,y
  lda #$2815
  sta aRangeTilemapRightTileScrollBuffer+$02,y
  rts

  _EdgeOfRange
  lda aMovementMap,x
  and #$00FF
  beq _NoTile

  _Attackable
  lda #$2412
  sta aRangeTilemapLeftTileScrollBuffer+$00,y
  lda #$2413
  sta aRangeTilemapRightTileScrollBuffer+$00,y
  lda #$2414
  sta aRangeTilemapLeftTileScrollBuffer+$02,y
  lda #$2415
  sta aRangeTilemapRightTileScrollBuffer+$02,y
  rts

  _NoTile
  lda #$02FF
  sta aRangeTilemapLeftTileScrollBuffer,y
  sta aRangeTilemapRightTileScrollBuffer,y
  sta aRangeTilemapLeftTileScrollBuffer+2,y
  sta aRangeTilemapRightTileScrollBuffer+2,y
  rts

rlEnableBG1Sync ; 81/B1FA

  .al
  .autsiz
  .databank ?

  lda wBGUpdateFlags
  ora #%00000010
  sta wBGUpdateFlags
  rtl

rlEnableBG2Sync ; 81/B206

  .al
  .autsiz
  .databank ?

  lda wBGUpdateFlags
  ora #%00000100
  sta wBGUpdateFlags
  rtl

rlEnableBG3Sync ; 81/B212

  .al
  .autsiz
  .databank ?

  lda wBGUpdateFlags
  ora #%00001000
  sta wBGUpdateFlags
  rtl

rlUpdateBGTilemaps ; 81/B21E

  .autsiz
  .databank ?

  php
  rep #$30

  ; Layers

  lda #3 - 1
  sta wR0

  ; Check if BG3 needs updating

  lda wBGUpdateFlags
  and #%00001000
  beq +

  ; Clear flag and update

  lda wBGUpdateFlags
  and #~%00001000
  sta wBGUpdateFlags
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer, $0700, VMAIN_Setting(True), $A000

  ; Decrement layer count and continue for remaining layers

  dec wR0
  +

  lda wBGUpdateFlags
  and #%00000010
  beq +

  lda wBGUpdateFlags
  and #~%00000010
  sta wBGUpdateFlags
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG1TilemapBuffer, $0700, VMAIN_Setting(True), $E000

  dec wR0
  beq ++

  +
  lda wBGUpdateFlags
  and #%00000100
  beq +

  lda wBGUpdateFlags
  and #~%00000100
  sta wBGUpdateFlags
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG2TilemapBuffer, $0700, VMAIN_Setting(True), $F000

  +
  plp
  rtl

rlUpdateBGTilemapsByMapScrollAmount ; 81/B291

  .autsiz
  .databank ?

  rep #$30
  lda wMapScrollWidth16,b
  asl a
  asl a
  asl a
  asl a
  sta wR0

  lda wMapScrollWidthPixels,b
  sec
  sbc wR0
  and #$01FF
  sta wR0

  lda wMapScrollHeight16,b
  asl a
  asl a
  asl a
  asl a
  sta wR1

  lda wMapScrollHeightPixels,b
  sec
  sbc wR1
  and #$00FF
  sta wR1

  ; If range tiles drawn, scroll them too

  lda @l wDisplayRangeFlag
  beq +

  lda wR0
  sta wBuf_BG1HOFS
  lda wR1
  sta wBuf_BG1VOFS

  +
  lda wBGUpdateFlags
  and #%00001110
  cmp #%00001110
  beq +

  lda wR0
  sta wBuf_BG2HOFS
  lda wR1
  sta wBuf_BG2VOFS

  +
  rtl

rlGetMapScrollReturnStep ; 81/B2DE

  .al
  .xl
  .autsiz
  .databank ?

  ; End if no scrolling to be done

  lda wUnknown000E6D,b
  bne +

  rtl

  +
  php
  phb
  sep #$20
  lda #`wMapScrollReturnStepIndex
  pha
  rep #$20
  plb

  .databank `wMapScrollReturnStepIndex

  ; Clear scrolling flag if done
  ; after this iteration

  ldx wMapScrollReturnStepIndex
  bne +

  stz wUnknown000E6D,b

  +

  ; dec timer

  dec wMapScrollReturnStepIndex

  ; Get which scrolling step we're on
  ; so we can get how many pixels we're
  ; scrolling this time around

  lda aCameraPanStepArray,x
  and #$00FF
  sta wR0

  ; Sub how far we're stepping from the remaining
  ; distance

  lda wMapScrollReturnRemainingPixelDistance
  sec
  sbc wR0
  sta wMapScrollReturnRemainingPixelDistance
  tay

  lda wMapScrollReturnVerticalDominantFlag
  cmp #$0001
  beq _VerticalDominant

  lda wMapScrollWidthPixels,b
  ldx wMapScrollHorizontalReturnDirectionFlag
  beq _Right

  sec
  sbc wR0
  bra +

  _Right
  clc
  adc wR0

  +
  sta wMapScrollWidthPixels,b
  bra ++

  _VerticalDominant
  lda wMapScrollHeightPixels,b
  ldx wMapScrollVerticalReturnDirectionFlag
  beq _Down

  sec
  sbc wR0
  bra +

  _Down
  clc
  adc wR0

  +
  sta wMapScrollHeightPixels,b

  +
  stz dwR12

  lda wMapScrollReturnXDistance
  sta dwR14
  sec
  sbc wMapScrollReturnRemainingPixelDistance
  sta dwR12+2

  stz dwR14+2

  ; ((xdist - remaining) * $1000) / xdist

  jsl rlUnsignedDivide32By32

  ; result * ydist

  lda wMapScrollReturnYDistance
  sta dwR10

  stz dwR10+2

  jsl rlUnsignedMultiply32By32

  lda wMapScrollReturnVerticalDominantFlag
  cmp #$0001
  beq _VerticalDominant2

  lda dwMapScrollReturnYStart
  ldx wMapScrollVerticalReturnDirectionFlag
  beq _Down2

  sec
  sbc dwR14+2
  bra +

  _Down2
  clc
  adc dwR14+2

  +
  sta wMapScrollHeightPixels,b
  bra _End

  _VerticalDominant2
  lda dwMapScrollReturnXStart
  ldx wMapScrollHorizontalReturnDirectionFlag
  beq _Right2

  sec
  sbc dwR14+2
  bra +

  _Right2
  clc
  adc dwR14+2

  +
  sta wMapScrollWidthPixels,b

  _End
  plb
  plp
  rtl

rlUnknown81B38C ; 81/B38C

  .autsiz
  .databank ?

  php
  phb
  sep #$20
  lda #`wMapScrollHorizontalReturnDirectionFlag
  pha
  plb

  .databank `wMapScrollHorizontalReturnDirectionFlag

  rep #$30
  lda #$0001
  sta wR8
  sta wMapScrollHorizontalReturnDirectionFlag
  sta wMapScrollVerticalReturnDirectionFlag
  stz wMapScrollReturnStepIndex
  lda wR3
  bne +

  lda wR2
  sta wR8

  +
  lda wMapScrollWidthPixels,b
  sec
  sbc wR0
  bpl +

  dec wMapScrollHorizontalReturnDirectionFlag
  eor #$FFFF
  inc a

  +
  sta wR5
  lda wMapScrollHeightPixels,b
  sec
  sbc wR1
  bpl +

  dec wMapScrollVerticalReturnDirectionFlag
  eor #$FFFF
  inc a

  +
  sta wR6
  ldx #$0001
  stx wMapScrollReturnVerticalDominantFlag
  ldx wR6
  stx wMapScrollReturnXDistance
  ldx wR5
  stx wMapScrollReturnYDistance
  lda wR6
  cmp wR5
  beq +

  bge ++

  +
  ldx #$0000
  stx wMapScrollReturnVerticalDominantFlag
  ldx wR5
  stx wMapScrollReturnXDistance
  ldx wR6
  stx wMapScrollReturnYDistance
  lda wR5
  bra ++

  +
  lda wR6

  +
  sta wR4
  sta wMapScrollReturnRemainingPixelDistance
  lda wR3
  sta wR17

  -
  jsr _B42F
  bcs _B443

  jsr _B412
  jsr _B41E
  bra -

  _B412
  ldx wMapScrollReturnStepIndex
  lda wR8
  sta aCameraPanStepArray,x
  inc wMapScrollReturnStepIndex
  rts

  _B41E
  dec wR17
  bne +

  lda wR3
  sta wR17
  lda wR8
  cmp wR2
  beq +

  inc wR8

  +
  rts

  _B42F
  lda wR4
  sec
  sbc wR8
  bmi +

  sta wR4
  clc
  rts

  +
  lda wR4
  sta wR8
  jsr _B412
  sec
  rts

  _B443
  lda wMapScrollWidthPixels,b
  sta dwMapScrollReturnXStart
  lda wMapScrollHeightPixels,b
  sta dwMapScrollReturnYStart
  stz dwMapScrollReturnXStart+2
  stz dwMapScrollReturnYStart+2
  inc wUnknown000E6D,b
  dec wMapScrollReturnStepIndex
  plb
  plp
  rtl

rlUnknown81B45E ; 81/B45E

  .al
  .xl
  .autsiz
  .databank ?

  lda wR0
  sec
  sbc #$0007
  asl a
  asl a
  asl a
  asl a
  bcc +

  lda #$0000
  bra ++

  +
  cmp wMapWidthPixels,b
  blt +

  lda wMapWidthPixels,b

  +
  sta wR0

  lda wR1
  sec
  sbc #$0007
  asl a
  asl a
  asl a
  asl a
  bcc +

  lda #$0000
  bra ++

  +
  cmp wMapHeightPixels,b
  blt +

  lda wMapHeightPixels,b

  +
  sta wR1
  rtl

rlUnknown81B495 ; 81/B495

  .al
  .xl
  .autsiz
  .databank ?

  ldx wR0
  phx
  ldx wR1
  phx
  jsl rlUnknown81B45E
  jsl rlUnknown81B38C
  plx
  stx wR1
  plx
  stx wR0
  jsl $83C181
  rtl

rlUnknown81B4AE ; 81/B4AE

  .al
  .xl
  .autsiz
  .databank ?

  jsl rlUnknown81B4B5
  jmp rlUnknown81B495

rlUnknown81B4B5 ; 81/B4B5

  .al
  .xl
  .autsiz
  .databank ?

  lda aOptions.wUnitSpeedOption
  beq +

  ldx #16
  stx wR2
  ldx #1
  stx wR3
  bra ++

  +
  ldx #8
  stx wR2
  ldx #2
  stx wR3

  +
  rtl

rlUnknown81B4D2 ; 81/B4D2

  .al
  .xl
  .autsiz
  .databank ?

  phx
  lda #$0400
  sta wR0

  lda aBurstWindowCharacterBuffer.TurnStatus,b
  bit #TurnStatusGrayed
  beq +

  lda #$0800
  sta wR0

  +
  lda aBurstWindowCharacterBuffer.SpriteInfo2,b
  clc
  adc wR0
  plx
  rtl

rlUnknown81B4ED ; 81/B4ED

  .al
  .xl
  .autsiz
  .databank ?

  lda wUnknown000E6D,b
  bne _End

  lda wR0
  and #$00FF
  asl a
  asl a
  asl a
  asl a
  pha
  sta wR0

  lda wR1
  and #$00FF
  asl a
  asl a
  asl a
  asl a
  pha
  sta wR1

  jsl $83C108

  pla
  sta wR1
  pla
  sta wR0

  lda wMapScrollWidthPixels,b
  cmp wR2
  bne +

  lda wMapScrollHeightPixels,b
  cmp wR3
  bne +

  lda wR0
  sec
  sbc wMapScrollWidthPixels,b
  sta wR0
  lda wR1
  sec
  sbc wMapScrollHeightPixels,b
  sta wR1
  rtl

  +
  lda wR2
  sta wR0
  lda wR3
  sta wR1
  jsl rlUnknown81B4B5
  jsl rlUnknown81B38C

  _End
  rtl

rlUnknown81B544 ; 81/B544

  .autsiz
  .databank ?

  php
  rep #$30
  lda wR0
  asl a
  asl a
  asl a
  asl a
  sec
  sbc @l wMapScrollWidthPixels
  sta wR0

  lda wR1
  asl a
  asl a
  asl a
  asl a
  sec
  sbc @l wMapScrollHeightPixels
  sta wR1
  plp
  rtl
