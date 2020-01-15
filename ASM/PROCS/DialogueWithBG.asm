
procDialogueWithBG .dstruct structProcInfo, "TT", rlProcDialogueWithBGInit, rlProcDialogueWithBGOnCycle, aProcDialogueWithBGCode ; 82/8D2D

aUnknown828D35 ; 82/8D35
  .word $0000

rlProcDialogueWithBGInit ; 82/8D37

  .al
  .xl
  .autsiz
  .databank ?

  jsl rlUnknown8CCA8C

  lda wProcInput0,b
  sta lR18
  lda wProcInput1,b
  sta lR18+1

  jsl rlUnknown8289AE

  lda #$6800
  sta $7E45B8

  lda #$5000
  sta $7E45BF

  lda #$5600
  sta $7E45D8

  lda #$1800
  tsb wUnknown0017E9,b

  lda #$0002
  sta wUnknown001836,b
  rtl

rlProcDialogueWithBGOnCycle ; 82/8D6B

  .al
  .xl
  .autsiz
  .databank ?

  lda #<>rlProcDialogueWithBGOnCycle2
  sta aProcHeaderOnCycle,b,x

  lda #(`aDialogueBoxHDMAInfo)<<8
  sta lR44+1
  lda #<>aDialogueBoxHDMAInfo
  sta lR44

  lda #$0006
  sta wR40

  jsl rlHDMAArrayEngineCreateEntryByIndex
  rtl

rlProcDialogueWithBGOnCycle2 ; 82/8D85

  .al
  .xl
  .autsiz
  .databank ?

  lda wUnknown0000DB
  and #$0003
  bne ++

  lda bBuf_INIDISP
  and #INIDISP.Brightness
  cmp #INIDISP_Setting(False, 15)
  beq +

  inc a
  sep #$20
  sta bBuf_INIDISP
  rep #$20
  bra ++

  +
  lda #<>rlProcDialogueWithBGOnCycle3
  sta aProcHeaderOnCycle,b,x

  +
  rtl

rlProcDialogueWithBGOnCycle3 ; 82/8DA6

  .al
  .xl
  .autsiz
  .databank ?

  phx
  lda #$0004
  sta wBuf_BG3HOFS
  jsl rlUnknown828965
  plx

  lda wUnknown0017E9,b
  bit #$0001
  bne +

  lda #<>rlProcDialogueWithBGOnCycle4
  sta aProcHeaderOnCycle,b,x

  +
  rtl

rlProcDialogueWithBGOnCycle4 ; 82/8DC0

  .al
  .xl
  .autsiz
  .databank ?

  lda bBuf_INIDISP
  and #$00FF
  beq +

  sep #$20
  dec bBuf_INIDISP
  rep #$20

  lda bBuf_INIDISP
  and #$00FF
  bne ++

  phx
  lda #(`aBG1TilemapBuffer)<<8
  sta lR18+1
  lda #<>aBG1TilemapBuffer
  sta lR18
  lda #$0800
  sta lR19
  lda #$02FF
  jsl rlBlockFillWord

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG1TilemapBuffer, $0800, VMAIN_Setting(True), $E000

  jsl $958127

  lda #$0006
  jsl rlHDMAArrayEngineFreeEntryByIndex

  plx

  +
  lda #<>rlProcDialogueWithBGOnCycle5
  sta aProcHeaderOnCycle,b,x

  +
  rtl

rlProcDialogueWithBGOnCycle5 ; 82/8E0B

  .al
  .xl
  .autsiz
  .databank ?

  lda #(`rsUnknown809E95)<<8
  sta wProcInput0+1,b
  lda #<>rsUnknown809E95
  sta wProcInput0,b
  phx

  lda #(`procUnknown82A272)<<8
  sta lR44+1
  lda #<>procUnknown82A272
  sta lR44
  jsl rlProcEngineCreateProc
  plx

  jsl rlEventEngineDeleteProcAndClearActive
  rtl

aProcDialogueWithBGCode ; 82/8E2C

  PROC_HALT

