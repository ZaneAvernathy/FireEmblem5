
rlDrawSkillInfo ; 81/F898

  .al
  .xl
  .autsiz
  .databank ?

  ; Draws the skill info text

  ; Inputs:
  ; wR0: X coordinate in tiles
  ; wR1: Y coordinate in tiles, min 20?

  php
  rep #$30

  lda wR0
  sta wProcInput0,b ; X

  ; Not sure yet why it's Y-2

  lda wR1
  dec a
  dec a
  sta wProcInput1,b ; Y
  phx
  lda #(`procSkillInfo)<<8
  sta lR44+1
  lda #<>procSkillInfo
  sta lR44
  jsl rlProcEngineCreateProc
  plx
  plp
  rtl

procSkillInfo .dstruct structProcInfo, None, rlProcSkillInfoInit, rlProcSkillInfoOnCycle, None ; 81/F8B9

rlProcSkillInfoInit ; 81/F8C1

  .al
  .xl
  .autsiz
  .databank ?

  ; aProcBody0: drawn skill icon array offset

  lda #$FFFF
  sta wInfoWindowTarget
  sta aProcBody0,b,x

  ; aProcBody1: X | (Y << 8)

  lda wProcInput1,b
  xba
  ora wProcInput0,b
  sta aProcBody1,b,x

  ; aProcBody3: X

  lda wProcInput0,b
  sta aProcBody3,b,x

  ; aProcBody4: Y - 18?

  lda wProcInput1,b
  sec
  sbc #18
  sta aProcBody4,b,x

  ; aProcBody2: Tilemap position

  lda wProcInput1,b
  asl a
  asl a
  asl a
  asl a
  asl a
  clc
  adc wProcInput0,b
  asl a
  clc
  adc #<>aBG3TilemapBuffer
  sta aProcBody2,b,x

  rtl

rlProcSkillInfoOnCycle ; 81/F8FA

  .al
  .xl
  .autsiz
  .databank ?

  ; Nothing to do if already displaying
  ; info for the right skill

  lda aProcBody0,b,x
  cmp wInfoWindowTarget
  bne +

  rtl

  +
  php
  phb
  sep #$20
  lda #`wInfoWindowTarget
  pha
  rep #$20
  plb

  .databank `wInfoWindowTarget

  lda #<>$83C0F6
  sta lUnknown000DDE,b
  lda #>`$83C0F6
  sta lUnknown000DDE+1,b

  ; Fetch the icon index and type of skill

  lda wInfoWindowTarget
  sta aProcBody0,b,x
  tay
  lda aInventorySkillInfoWindowIconArray,y
  sta aProcBody5,b,x
  lda aInventorySkillInfoWindowTypeArray,y
  sta aProcBody6,b,x

  ; Do the thing

  jsr rsProcSkillInfoClearTilemap
  jsr rsProcItemInfoClearIcons
  jsr rlProcSkillInfoDrawIcon
  jsr rlProcSkillInfoDrawSkillName
  jsr rlProcSkillInfoDrawSkillDescription
  jsr rlProcSkillInfoDrawSkillType
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG3TilemapBuffer+$0800, $0300, VMAIN_Setting(True), $A800

  plb
  plp
  rtl

rsProcSkillInfoClearTilemap ; 81/F94F

  .al
  .xl
  .autsiz
  .databank `wInfoWindowTarget

  phx
  lda aProcBody2,b,x
  sta wR0
  lda #10
  sta wR1
  lda #11
  sta wR2
  jsl rlFillTilemapRectByWord
  plx
  rts

rlProcSkillInfoDrawIcon ; 81/F965

  .al
  .xl
  .autsiz
  .databank `wInfoWindowTarget

  phx

  ; Icon index

  lda aProcBody5,b,x
  sta wR2

  ; Palette

  lda #5 << 9
  sta wR3

  ; X

  lda aProcBody3,b,x
  sta wR0

  ; Y

  lda aProcBody4,b,x
  sta wR1

  jsl $8A8085
  plx
  rts

rlProcSkillInfoDrawSkillName ; 81/F980

  .al
  .xl
  .autsiz
  .databank `wInfoWindowTarget

  lda #$2180
  sta wUnknown000DE7,b

  phx
  phx
  lda #>`aSkillNames
  sta lR18+1

  ; Use icon index to fetch name

  lda aProcBody5,b,x
  sec
  sbc #$00B1 ; Start of skill icons in sheet
  asl a
  tax
  lda aSkillNames,x
  sta lR18
  plx

  ; Draw name at X+2, Y
  ; To account for icon

  lda aProcBody1,b,x
  inc a
  inc a
  tax
  jsl $87E728
  plx
  rts

rlProcSkillInfoDrawSkillDescription ; 81/F9A9

  .al
  .xl
  .autsiz
  .databank `wInfoWindowTarget

  ; Same as the name, basically

  phx
  phx
  lda #>`aSkillDescriptions
  sta lR18+1
  lda aProcBody5,b,x
  sec
  sbc #$00B1
  asl a
  tax
  lda aSkillDescriptions,x
  sta lR18
  plx

  ; Draw to X, Y+3

  lda aProcBody1,b,x
  clc
  adc #3 << 8
  tax
  jsl $8588E4
  plx
  rts

rlProcSkillInfoDrawSkillType ; 81/F9CE

  .al
  .xl
  .autsiz
  .databank `wInfoWindowTarget

  phx
  phx
  lda #$3580
  sta wUnknown000DE7,b

  lda #>`aSkillTypes
  sta lR18+1

  ; Use skill type to get text

  lda aProcBody6,b,x
  tax
  lda aSkillTypes,x
  sta lR18
  plx

  ; Draw to X+4, Y+9

  lda aProcBody1,b,x
  clc
  adc #4 | (9 << 8)
  tax
  jsl $87E728
  plx
  rts
