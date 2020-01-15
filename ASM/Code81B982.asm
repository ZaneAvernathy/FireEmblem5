
rlSetTurnStartCursorPosition ; 81/B982

  .al
  .xl
  .autsiz
  .databank `$7E5290

  lda wCurrentPhase,b
  jsl $83B296

  lda $7E5290,x
  and #$00FF
  cmp #$0002
  bne _End

  ; First turn always starts on
  ; the first unit

  lda #$0001
  cmp wCurrentTurn,b
  beq +

  ; If player phase and autocursor disabled

  lda aOptions.wAutocursorOption
  ora wCurrentPhase,b
  cmp #$0001
  beq _AutocursorDisabled

  ; Else get the first unit of
  ; currently acting allegiance

  +
  lda wCurrentPhase,b
  inc a
  asl a
  tax

  -
  lda $838E98,x
  tay

  ; Ensure there's a unit in that
  ; deployment slot

  lda structCharacterDataRAM.Character,b,y
  bne +

  inc x
  inc x
  bra -

  +
  lda structCharacterDataRAM.X,b,y
  and #$00FF
  sta wCursorXCoord,b
  sta wR0
  lda structCharacterDataRAM.Y,b,y
  and #$00FF
  sta wCursorYCoord,b

  -
  sta wR1
  jsl $83C181

  lda wCursorXCoord,b
  sta wR0
  lda wCursorYCoord,b
  sta wR1
  jsl rlUnknown81B4ED

  _End
  rtl

  _AutocursorDisabled
  lda wTurnEndXCoordinate
  sta wCursorXCoord,b
  sta wR0
  lda wTurnEndYCoordinate
  sta wCursorYCoord,b
  bra -

rlUnknown81B9F4 ; 81/B9F4

  .al
  .xl
  .autsiz
  .databank ?

  lda wCurrentPhase,b
  pha
  lda wR0
  pha
  lda wR1
  pha
  lda wR2
  pha
  lda wR3
  pha
  lda wR4
  pha
  lda wR5
  pha

  lda aSelectedCharacterBuffer.DeploymentNumber,b
  and #Player | Enemy | NPC
  sta wCurrentPhase,b
  jsl $83B267

  pla
  sta wR5
  pla
  sta wR4
  pla
  sta wR3
  pla
  sta wR2
  pla
  sta wR1
  pla
  sta wR0

  jsl $838D28
  pla
  sta wCurrentPhase,b

  jsl $83B267
  rtl

rlUnknown81BA36 ; 81/BA36

  .al
  .xl
  .autsiz
  .databank ?

  php
  phb
  sep #$20
  lda #`$7E4F96
  pha
  rep #$20
  plb

  .databank `$7E4F96

  jsl $839B7F
  stz $7E4F96
  ldx $7E4FC8

  _Loop
  inc x
  inc x
  lda $838E98,x
  beq _BA77

  cmp #$FFFF
  beq _BA79
  tay
  lda structCharacterDataRAM.Character,b,y
  beq _BA77

  lda structCharacterDataRAM.TurnStatus,b,y
  bit #TurnStatusActing | TurnStatusGrayed
  bne _BA77

  lda structCharacterDataRAM.Status,b,y
  and #$00FF
  cmp #StatusSleep
  beq _BA77

  cmp #StatusPetrify
  beq _BA77

  bra _BA88

  _BA77
  bra _Loop

  _BA79
  lda $7E4F96
  bne _BAA8

  dec $7E4F96
  txa
  and #$0180
  tax
  bra _Loop

  _BA88
  stx $7E4FC8
  sty wProcInput0,b
  phx
  lda #(`procUnknown81BAC5)<<8
  sta lR43+1
  lda #<>procUnknown81BAC5
  sta lR43
  jsl rlProcEngineCreateProc
  plx
  jsl $84A125
  stz wUnknown000302,b
  plb
  plp
  rtl

  _BAA8
  jsl $84A125
  lda #$0000
  sta wUnknown000E25,b
  phx
  lda #(`$8A82DF)<<8
  sta lR43+1
  lda #<>$8A82DF
  sta lR43
  jsl rlProcEngineCreateProc
  plx
  plb
  plp
  rtl
