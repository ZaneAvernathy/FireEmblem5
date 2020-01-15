
aIRQArrayEngineMainActionTable ; 82/A63B

  .addr rlUnknown82A6AE
  .addr rlUnknown82A76F
  .addr rlUnknown82A77C

rsUnknown82A641 ; 82/A641

  .al
  .xl
  .autsiz
  .databank ?

  lda $0000,b,y
  sta aIRQArraySleepTimer,b,x
  inc y
  inc y
  tya
  sta aIRQArrayCodeOffset,b,x
  pla
  rts

rsUnknown82A64F ; 82/A64F

  .al
  .xl
  .autsiz
  .databank ?

  stz aIRQArrayTypeOffset,b,x
  stz aIRQArrayVTimerSetting,b,x
  jsr rsUnknown82A783
  dec wIRQArrayIndex,b
  pla
  rts

rsUnknown82A65D ; 82/A65D

  .al
  .xl
  .autsiz
  .databank ?

  lda #$0001
  sta aIRQArraySleepTimer,b,x
  dec y
  dec y
  tya
  sta aIRQArrayCodeOffset,b,x
  pla
  rts

rsUnknown82A66B ; 82/A66B

  .al
  .xl
  .autsiz
  .databank ?

  lda $0000,b,y
  sta lIRQArrayCodePointer,b
  lda $0001,b,y
  sta lIRQArrayCodePointer+1,b
  phy
  phx
  jsl +
  plx
  ply
  inc y
  inc y
  inc y
  rts

  +
  jmp [lIRQArrayCodePointer]

rsUnknown82A686 ; 82/A686

  .al
  .xl
  .autsiz
  .databank ?

  lda $0000,b,y
  sta aIRQArrayOnCycle,b,x
  inc y
  inc y
  rts

rsUnknown82A68F ; 82/A68F

  .al
  .xl
  .autsiz
  .databank ?

  lda $0000,b,y
  tay
  rts

rsUnknown82A694 ; 82/A694

  .al
  .xl
  .autsiz
  .databank ?

  lda $0002,b,y
  bit aIRQArrayBitfield,b,x
  beq rsUnknown82A68F

  inc y
  inc y
  inc y
  inc y
  rts

rsUnknown82A6A1 ; 82/A6A1

  .al
  .xl
  .autsiz
  .databank ?

  lda $0002,b,y
  bit aIRQArrayBitfield,b,x
  bne rsUnknown82A68F

  inc y
  inc y
  inc y
  inc y
  rts

rlUnknown82A6AE ; 82/A6AE

  .al
  .xl
  .autsiz
  .databank ?

  php
  phb
  phk
  plb
  ldx #size(aIRQArraySpace)-1

  sep #$20
  lda #$00

  -
  sta aIRQArraySpace,b,x
  dec x
  bpl -

  rep #$20
  jsl rlUnknown82A6EA
  plb
  plp
  rtl

rlUnknown82A6C8 ; 82/A6C8

  .al
  .xl
  .autsiz
  .databank ?

  sei
  phb
  php

  phk
  plb

  .databank `*

  sep #$20
  lda bBuf_NMITIMEN
  ora #NMITIMEN_Setting(False, True, True, False)
  sta bBuf_NMITIMEN
  rep #$20

  lda #$8000
  trb wIRQArrayFlag,b
  jsl rlUnknown82A783
  lda #<>rsUnknown80A4D0
  sta wUnknown0000D5
  plp
  plb
  cli
  rtl

rlUnknown82A6EA ; 82/A6EA

  .al
  .xl
  .autsiz
  .databank ?

  sei
  sep #$20
  lda bBuf_NMITIMEN
  and #~NMITIMEN_Setting(False, True, True, False)
  sta bBuf_NMITIMEN
  rep #$20
  lda #$8000
  tsb wIRQArrayFlag,b
  lda #<>rsUnknown8082D9
  sta wUnknown0000D5
  rtl

rlUnknown82A701 ; 82/A701

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
  lda lR43
  tay
  sep #$20
  lda lR43+2
  pha
  rep #$20
  plb
  lda wIRQArrayIndex,b
  cmp #$0007
  bcc +

  plx
  plp
  plb
  sec
  rtl

  +
  lda wIRQArrayIndex,b
  asl a
  tax
  tya
  sta aIRQArrayTypeOffset,b,x
  lda lR43+1
  and #$FF00
  xba
  sta aIRQArrayTypeBank,b,x

  lda #$0000
  sta aIRQArrayBitfield,b,x
  lda $0000,b,y
  sta aIRQArrayHTimerSetting,b,x
  lda $0002,b,y
  sta aIRQArrayVTimerSetting,b,x
  lda $0004,b,y
  sta aIRQArrayOnCycle,b,x
  lda $0006,b,y
  sta aIRQArrayCodeOffset,b,x

  lda #$0001
  sta aIRQArraySleepTimer,b,x

  inc wIRQArrayIndex,b
  plx
  plp
  plb
  clc
  rtl

rlUnknown82A75C ; 82/A75C

  .al
  .xl
  .autsiz
  .databank ?

  phb
  php

  phk
  plb

  .databank `*

  ldx wIRQArrayUnknownIndex1,b
  stz aIRQArrayTypeOffset,b,x
  stz aIRQArrayVTimerSetting,b,x
  dec wIRQArrayIndex,b
  plp
  plb
  rtl

rlUnknown82A76F ; 82/A76F

  .al
  .xl
  .autsiz
  .databank ?

  rtl

rlUnknown82A770 ; 82/A770

  .al
  .xl
  .autsiz
  .databank ?

  sep #$20
  lda bBuf_INIDISP
  and #INIDISP.ForcedBlank
  sta INIDISP,b
  rep #$20
  rtl

rlUnknown82A77C ; 82/A77C

  .al
  .xl
  .autsiz
  .databank ?

  lda #<>rsUnknown8082D9
  sta wUnknown0000D5
  sei
  rtl

rlUnknown82A783 ; 82/A783

  .al
  .xl
  .autsiz
  .databank ?

  sei
  phb
  php

  phk
  plb

  .databank `*

  lda wIRQArrayIndex,b
  cmp wIRQArrayUnknownIndex2,b
  beq ++

  sta wIRQArrayUnknownIndex2,b
  jsr rsUnknown82A783
  lda wIRQArrayUnknownIndex2,b
  beq +

  dec a
  asl a
  sta wIRQArrayUnknownIndex1,b
  tax
  jsr rsUnknown82A8BF
  bra ++

  +
  lda #$0000
  sta lIRQArrayCodePointer,b
  sta lIRQArrayCodePointer+1,b

  +
  plp
  plb
  cli
  rtl

rsUnknown82A783 ; 82/A7B3

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
  phy
  lda wIRQArrayUnknownIndex2,b
  cmp #$0001
  beq _End
  bcc _End

  and #~%1
  sta wR30

  -
  lda wIRQArrayUnknownIndex2,b
  asl a
  sec
  sbc wR30
  sta wR32
  stz wR31

  -
  lda wR30
  clc
  adc wR31
  tay
  ldx wR31
  lda aIRQArrayVTimerSetting,b,x
  cmp aIRQArrayVTimerSetting,b,y
  bcs +

  jsr rsIRQArrayEngineSwap

  +
  inc wR31
  inc wR31
  lda wR31
  cmp wR32
  bcc -

  dec wR30
  dec wR30
  bne --

  _End
  ply
  plx
  plp
  plb
  rts

rsIRQArrayEngineSwap ; 82/A7FB

  .al
  .xl
  .autsiz
  .databank ?

  lda aIRQArrayTypeOffset,b,x
  sta aIRQArrayTypeOffset+(2 * 7),b
  lda aIRQArrayTypeBank,b,x
  sta aIRQArrayTypeBank+(2 * 7),b
  lda aIRQArrayBitfield,b,x
  sta aIRQArrayBitfield+(2 * 7),b
  lda aIRQArrayHTimerSetting,b,x
  sta aIRQArrayHTimerSetting+(2 * 7),b
  lda aIRQArrayVTimerSetting,b,x
  sta aIRQArrayVTimerSetting+(2 * 7),b
  lda aIRQArrayOnCycle,b,x
  sta aIRQArrayOnCycle+(2 * 7),b
  lda aIRQArrayCodeOffset,b,x
  sta aIRQArrayCodeOffset+(2 * 7),b
  lda aIRQArraySleepTimer,b,x
  sta aIRQArraySleepTimer+(2 * 7),b

  lda aIRQArrayTypeOffset,b,y
  sta aIRQArrayTypeOffset,b,x
  lda aIRQArrayTypeBank,b,y
  sta aIRQArrayTypeBank,b,x
  lda aIRQArrayBitfield,b,y
  sta aIRQArrayBitfield,b,x
  lda aIRQArrayHTimerSetting,b,y
  sta aIRQArrayHTimerSetting,b,x
  lda aIRQArrayVTimerSetting,b,y
  sta aIRQArrayVTimerSetting,b,x
  lda aIRQArrayOnCycle,b,y
  sta aIRQArrayOnCycle,b,x
  lda aIRQArrayCodeOffset,b,y
  sta aIRQArrayCodeOffset,b,x
  lda aIRQArraySleepTimer,b,y
  sta aIRQArraySleepTimer,b,x

  lda aIRQArrayTypeOffset+(2 * 7),b
  sta aIRQArrayTypeOffset,b,y
  lda aIRQArrayTypeBank+(2 * 7),b
  sta aIRQArrayTypeBank,b,y
  lda aIRQArrayBitfield+(2 * 7),b
  sta aIRQArrayBitfield,b,y
  lda aIRQArrayHTimerSetting+(2 * 7),b
  sta aIRQArrayHTimerSetting,b,y
  lda aIRQArrayVTimerSetting+(2 * 7),b
  sta aIRQArrayVTimerSetting,b,y
  lda aIRQArrayOnCycle+(2 * 7),b
  sta aIRQArrayOnCycle,b,y
  lda aIRQArrayCodeOffset+(2 * 7),b
  sta aIRQArrayCodeOffset,b,y
  lda aIRQArraySleepTimer+(2 * 7),b
  sta aIRQArraySleepTimer,b,y
  rts

rlUnknown82A88C ; 82/A88C

  .al
  .xl
  .autsiz
  .databank ?

  phb
  php

  phk
  plb

  .databank `*

  lda wIRQArrayFlag,b
  bit #$8000
  bne _End

  lda lIRQArrayCodePointer,b
  ora lIRQArrayCodePointer+1,b
  beq _End

  ldx wIRQArrayUnknownIndex1,b
  jsl rlUnknown82A916
  jsr rsUnknown82A8E9
  ldx wIRQArrayUnknownIndex1,b
  bne +

  lda wIRQArrayUnknownIndex2,b
  asl a
  tax

  +
  dec x
  dec x
  stx wIRQArrayUnknownIndex1,b
  jsr rsUnknown82A8BF

  _End
  plp
  plb
  rtl

rsUnknown82A8BF ; 82/A8BF

  .al
  .xl
  .autsiz
  .databank ?

  sep #$20
  lda aIRQArrayHTimerSetting+1,b,x
  sta HTIME+1,b
  lda aIRQArrayHTimerSetting,b,x
  sta HTIME,b
  lda aIRQArrayVTimerSetting+1,b,x
  sta VTIME+1,b
  lda aIRQArrayVTimerSetting,b,x
  sta VTIME,b

  rep #$20
  lda aIRQArrayTypeBank,b,x
  xba
  sta lIRQArrayCodePointer+1,b
  lda aIRQArrayOnCycle,b,x
  sta lIRQArrayCodePointer,b
  rts

rsUnknown82A8E9 ; 82/A8E9

  .al
  .xl
  .autsiz
  .databank ?

  ldx wIRQArrayUnknownIndex1,b
  dec aIRQArraySleepTimer,b,x
  bne _End

  ldy aIRQArrayCodeOffset,b,x

  -
  lda $0000,b,y
  bpl +

  sta lIRQArrayCodePointer,b
  inc y
  inc y
  pea <>(-)-1
  jmp (lIRQArrayCodePointer)

  +
  sta aIRQArraySleepTimer,b,x
  lda $0002,b,y
  sta aIRQArrayVTimerSetting,b,x
  tya
  clc
  adc #$0004
  sta aIRQArrayCodeOffset,b,x

  _End
  rts

rlUnknown82A916 ; 82/A916

  .al
  .xl
  .autsiz
  .databank ?

  sep #$20
  lda lIRQArrayCodePointer+2,b
  pha
  rep #$20
  plb
  jmp [lIRQArrayCodePointer]
