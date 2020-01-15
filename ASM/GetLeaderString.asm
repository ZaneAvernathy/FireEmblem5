
rlGetLeaderString ; 81/E115

  .al
  .xl
  .autsiz
  .databank ?

  ; Given a leader in A, return
  ; a pointer to the faction's menutext
  ; in lR18

  ; Inputs:
  ; A: Leader word

  ; Outputs:
  ; lR18: pointer to faction text

  php
  phb

  tax

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  ; Leader table

  lda #<>$89894E
  sta lR18
  lda #>`$89894E
  sta lR18+1

  txa

  sta wR0
  ldy #$0000

  _Loop

  ; Go through table until the end or leader is found

  lda [lR18],y
  beq _End

  cmp wR0
  beq _End

  inc y
  inc y
  inc y
  inc y
  bra _Loop

  _End

  tya
  clc
  adc lR18
  inc a
  inc a
  sta lR18

  lda [lR18]
  sta lR18

  plb
  plp
  rtl
