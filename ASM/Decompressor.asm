
rlUnknown80B554 ; 80/B554

  .al
  .xl
  .autsiz
  .databank ?

  phb
  php
  phk
  plb

  .databank `*

  pha
  pla
  sta wUnknown0000D7
  bra rlUnknown80B561

rlUnknown80B55E ; 80/B55E

  .al
  .xl
  .autsiz
  .databank ?

  pla
  sta wR26

rlUnknown80B561 ; 80/B561

  .al
  .xl
  .autsiz
  .databank ?

  plp
  plb
  rtl

rlUnknown80B564 ; 80/B564

  .autsiz
  .databank ?

  php
  phb
  rep #$30
  ldy lDecompSource
  stz lDecompSource
  sep #$20
  lda #$01
  sta bDecompFlag
  bra rlDecompressor._Unknown80B593

rlDecompressor ; 80/B574

  .autsiz
  .databank ?

  ; This is the main decompression routine.
  ; It has subroutines for various compression methods
  ; and handles some basic decompression setup

  ; Inputs:
  ; lDecompSource: Long pointer to compressed data
  ; lDecompDest: Long pointer to where to decompress to

  ; Outputs:
  ; None

  php
  phb
  rep #$30

  ; Fetch source in Y

  ldy lDecompSource
  bmi _ROMSource

  ; If decompressing from RAM,
  ; we want to wrap 7FFF->0000
  ; instead of FFFF->8000

  tya
  clc
  adc #$8000
  tay
  lda #$8000
  sta lDecompSource
  sep #$20
  dec lDecompSource+2
  bra +

  _ROMSource

  .al
  .xl
  .autsiz
  .databank ?

  stz lDecompSource
  sep #$20

  +

  ; Clear internal stuff and
  ; fetch dest in X

  stz bDecompFlag

  _Unknown80B593
  stz bDecompCount
  lda lDecompDest+2
  pha
  plb

  .databank ?

  ldx lDecompDest
  jmp _GetNextMethod

  _DecCount ; 80/B59E

  .as
  .xl
  .autsiz
  .databank ?

  dec a
  sta bDecompCount
  bne +

  _SetSource ; 80/B5A3

  .as
  .xl
  .autsiz
  .databank ?

  lda lDecompTemp+2
  sta lDecompSource+2
  ldy lDecompTemp

  +
  rts

  _BankBoundary ; 80/B5AA

  .as
  .xl
  .autsiz
  .databank ?

  inc lDecompSource+2
  ldy lDecompSource
  bne _End

  pha
  lda bDecompFlag
  bne +

  ldy #$8000

  +
  pla

  _End
  rts

  _ORR80Plus ; 80/B5BA

  .as
  .xl
  .autsiz
  .databank ?

  sta bDecompVar0
  asl a
  bpl _LessThanC0

  ; C0 and above

  and #$20
  beq +

  ; D0
  ; Upper nybble data
  ; Lower nybble F

  lda bDecompVar0
  asl a
  asl a
  asl a
  asl a
  ora #$0F
  sta $0000,b,x
  inc x
  lda #$1F
  bra _ORRHandler

  +

  ; C0
  ; Upper nybble F
  ; Lower nybble data

  lda bDecompVar0
  and #$0F
  ora #$F0
  sta $0000,b,x
  inc x
  lda #$0F
  bra _ORRHandler

  _LessThanC0
  and #$20
  beq +

  ; 90
  ; Upper nybble data
  ; Lower nybble 0

  lda bDecompVar0
  asl a
  asl a
  asl a
  asl a
  sta $0000,b,x
  inc x
  lda #$10
  bra _ORRHandler

  +

  ; 80
  ; Upper nybble 0
  ; Lower nybble data

  lda bDecompVar0
  and #$0F
  sta $0000,b,x
  inc x
  lda #$00
  bra _ORRHandler

  _ORR ; 80/B5FF

  .as
  .xl
  .autsiz
  .databank ?

  and #$0F ; count
  inc a
  sta bDecompMethodCount

  ; Next byte determines the type of ORR

  lda [lDecompSource],y
  inc y
  bne +

  jsr _BankBoundary

  +
  pha
  lda bDecompCount
  beq +

  dec a
  sta bDecompCount
  bne +

  jsr _SetSource

  +
  pla
  cmp #$80
  bge _ORR80Plus

  _ORRHandler
  cmp #$10
  blt _LowerNybbleData

  and #$0F
  sta bDecompVar0

  _UpperDataLoop
  lda [lDecompSource],y
  inc y
  bne +

  jsr _BankBoundary

  +
  sta bDecompVar1
  and #$F0
  ora bDecompVar0
  sta $0000,b,x
  inc x
  lda bDecompCount
  beq +

  jsr _DecCount

  +
  dec bDecompMethodCount
  bmi _ORREnd

  lda bDecompVar1
  asl a
  asl a
  asl a
  asl a
  ora bDecompVar0
  sta $0000,b,x
  inc x
  dec bDecompMethodCount
  bpl _UpperDataLoop

  jmp _GetNextMethod

  _LowerNybbleData
  asl a
  asl a
  asl a
  asl a
  sta bDecompVar0

  _LowerDataLoop
  lda [lDecompSource],y
  inc y
  bne +

  jsr _BankBoundary

  +
  sta bDecompVar1
  lsr a
  lsr a
  lsr a
  lsr a
  ora bDecompVar0
  sta $0000,b,x
  inc x
  lda bDecompCount
  beq +

  jsr _DecCount

  +
  dec bDecompMethodCount
  bmi _ORREnd

  lda bDecompVar1
  and #$0F
  ora bDecompVar0
  sta $0000,b,x
  inc x
  dec bDecompMethodCount
  bpl _LowerDataLoop

  _ORREnd
  jmp _GetNextMethod

  _DupOrORR ; 80/B68C

  .as
  .xl
  .autsiz
  .databank ?

  cmp #$50
  bge +
  jmp _ORR

  ; Duplicate 2x

  +
  and #$0F
  sta bDecompMethodCount

  _DupLoop
  lda [lDecompSource],y ; get data
  inc y
  bne +

  jsr _BankBoundary

  +
  sta $0000,b,x ; wRite it twice
  inc x
  sta $0000,b,x
  inc x
  lda bDecompCount
  beq +

  jsr _DecCount

  +
  dec bDecompMethodCount
  bpl _DupLoop

  jmp _GetNextMethod

  _DupCheckOrAppend ; 80/B6B5

  .as
  .xl
  .autsiz
  .databank ?

  ; Method << 1 in A

  lsr a
  cmp #$60
  blt _DupOrORR

  ; Otherwise it's append
  ; next byte is the value that is appended

  xba
  lda [lDecompSource],y
  inc y
  bne +

  jsr _BankBoundary

  +
  pha
  lda bDecompCount
  beq +

  dec a
  sta bDecompCount
  bne +

  jsr _SetSource

  +
  pla
  sta bDecompVar0
  xba
  cmp #$70
  and #$0F
  inc a
  sta bDecompMethodCount
  bge _Postappend

  _Preappend
  lda bDecompVar0 ; append val
  sta $0000,b,x
  inc x
  lda [lDecompSource],y ; then data
  inc y
  bne +

  jsr _BankBoundary

  +
  sta $0000,b,x
  inc x
  lda bDecompCount
  beq +

  jsr _DecCount

  +
  dec bDecompMethodCount
  bpl _Preappend
  bra _GetNextMethod

  _Postappend
  lda [lDecompSource],y ; append data
  inc y
  bne +

  jsr _BankBoundary

  +
  sta $0000,b,x
  inc x
  lda bDecompCount
  beq +

  jsr _DecCount

  +
  lda bDecompVar0 ; then val
  sta $0000,b,x
  inc x
  dec bDecompMethodCount
  bpl _Postappend

  bra _GetNextMethod

  _DupAppendOrLiteral ; 80/B71B

  .as
  .xl
  .autsiz
  .databank ?

  ; Method << 1 in A

  bmi _DupCheckOrAppend

  ; Otherwise literal bytes

  lsr a

  ; Number of bytes to copy

  sta bDecompMethodCount

  _LiteralLoop
  lda [lDecompSource],y ; get byte to copy
  inc y
  bne +

  jsr _BankBoundary

  +
  sta $0000,b,x ; Store to dest
  inc x
  lda bDecompCount
  beq +

  jsr _DecCount

  +
  dec bDecompMethodCount
  bpl _LiteralLoop

  _GetNextMethod ; 80/B737

  .as
  .xl
  .autsiz
  .databank ?

  ; This fetches the next compressed method byte
  ; and decides what to do based on it.

  ; Fetch method from source

  lda [lDecompSource],y
  inc y
  bne +

  jsr _BankBoundary

  +
  pha

  ; Decrement lookback method count

  lda bDecompCount
  beq +

  dec a
  sta bDecompCount
  bne +

  jsr _SetSource

  +
  pla
  asl a
  bcc _DupAppendOrLiteral ; 70 and below
  bmi _UpperMethodOrLZLong ; E0 and above

  ; Else 70 < M <= C0
  ; sliding window

  _LZ77 ; 80/B752

  .as
  .xl
  .autsiz
  .databank ?

  ; I'm calling this LZ77 based on Twilkitri(?)'s
  ; doc but I'm not sure if that's really correct.

  ; length = 2 + (method-0x80)>>2

  lsr a
  pha
  lsr a
  lsr a
  inc a
  sta bDecompMethodCount
  pla

  ; upper bits of distance

  and #$03
  xba

  _LZGetLowerDistByte
  lda [lDecompSource],y ; get lower distance byte
  inc y
  bne +

  jsr _BankBoundary

  +
  phy
  rep #$20

  ; Subtract current dest point
  ; to get pos in decomp to read

  sta lDecompDest
  txa
  sec
  sbc lDecompDest
  tay
  sep #$20

  _LZLoop
  lda $0000,b,y ; copy from
  sta $0000,b,x
  inc y
  inc x
  dec bDecompMethodCount
  bpl _LZLoop

  ply

  _NextLookbackOrEnd ; 80/B77E

  .as
  .xl
  .autsiz
  .databank ?

  lda bDecompCount
  beq _GetNextMethod

  jsr _DecCount
  bra _GetNextMethod

  _UpperMethodOrLZLong ; 80/B787

  .as
  .xl
  .autsiz
  .databank ?

  ror a
  cmp #$E0
  bcs _RLEOrSpecial

  ; Long LZ77
  ; length = 2 + ((((method&0x1F)<<8)|(data[pos+1]&0x80))>>7)

  and #$1F
  xba
  lda [lDecompSource],y
  inc y
  bne +

  jsr _BankBoundary

  +
  pha
  lda bDecompCount
  beq +

  dec a
  sta bDecompCount
  bne +

  jsr _SetSource

  +
  pla
  rep #$20
  asl a
  sep #$20
  lsr a
  xba
  inc a
  sta bDecompMethodCount
  bra _LZGetLowerDistByte

  _RLEOrSpecial ; 80/B7B1

  .as
  .xl
  .autsiz
  .databank ?

  cmp #$F0
  bge _DetermineSpecialMethod

  ; RLE

  ; length = 3 + (method&0xF)<<8 + data[pos+1]

  and #$0F
  sta bDecompVar1
  lda [lDecompSource],y
  inc y
  bne +

  jsr _BankBoundary

  +
  sta bDecompVar0
  lda bDecompCount
  beq +

  jsr _DecCount

  +
  lda [lDecompSource],y ; grab byte to repeat
  inc y
  bne +

  jsr _BankBoundary

  +
  phy
  pha
  pha
  rep #$20
  lda bDecompVar0
  clc
  adc #$0003
  lsr a
  tay
  pla

  _RLELoop
  sta $0000,b,x ; store byte
  inc x
  inc x
  dec y
  bne _RLELoop
  sep #$20
  bcc _RLEEnd

  sta $0000,b,x
  inc x

  _RLEEnd
  ply
  bra _NextLookbackOrEnd

  _DetermineSpecialMethod ; 80/B7F3

  .as
  .xl
  .autsiz
  .databank ?

  ; This stuff seems similar to the LZ77 used on the GBA
  ; but without using the same chunk(?) byte?

  cmp #$F8
  bge +

  ; Short RLE
  ; length = 3 + (method&0x7)

  and #$07
  adc #$02
  sta bDecompMethodCount
  lda [lDecompSource],y ; byte to repeat
  inc y
  bne _ShortRLELoop
  jsr _BankBoundary

  _ShortRLELoop
  sta $0000,b,x
  inc x
  dec bDecompMethodCount
  bpl _ShortRLELoop
  jmp _NextLookbackOrEnd

  +
  cmp #$FC
  bge _CheckForEndFlag

  ; like the sliding window but
  ; we're going back in the source
  ; and decompressing that instead
  ; of copying from the output

  ; methods to repeat: 3 + (method & 0x3)<<3 + (data[pos+1]>>5)
  ; distance: 3 + (data[pos+1]&0x1F)<<8 + data[pos+2]

  and #$03
  xba
  lda [lDecompSource],y
  inc y
  bne +

  jsr _BankBoundary

  +
  rep #$20
  asl a
  asl a
  asl a
  sep #$20
  lsr a
  lsr a
  lsr a
  xba
  pha
  lda [lDecompSource],y
  inc y
  bne +

  jsr _BankBoundary

  +
  rep #$20
  clc
  adc #$0003

  _SetReadposAndCount
  sty lDecompTemp
  sta lDecompDest
  sep #$20
  lda lDecompSource+2
  sta lDecompTemp+2
  lda bDecompFlag
  rep #$20
  beq _GetPreviousBankOffset

  tya
  sec
  sbc lDecompDest
  bge _SetCountAndDecomp

  bra _GetPreviousBank

  _GetPreviousBankOffset
  tya
  sec
  sbc lDecompDest
  bmi _SetCountAndDecomp

  clc
  adc #$8000

  _GetPreviousBank
  dec lDecompSource+2

  _SetCountAndDecomp
  tay
  sep #$20
  pla
  clc
  adc #$03
  sta bDecompCount
  jmp _GetNextMethod

  _CheckForEndFlag
  cmp #$FE
  bge _EndDecomp

  ; same as before but
  ; distance = data[pos+1]&0x3F
  ; count = 3 + data[pos+1]>>6 + (method&1)<<2

  and #$01
  xba
  lda [lDecompSource],y
  inc y
  bne +

  jsr _BankBoundary

  +
  rep #$20
  asl a
  asl a
  sep #$20
  xba
  pha
  xba
  lsr a
  lsr a
  rep #$20
  and #$003F
  inc a
  inc a
  bra _SetReadposAndCount

  _EndDecomp
  plb
  plp
  rtl
