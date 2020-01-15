
rlUnknown838000 ; 83/8000

  .autsiz
  .databank ?

  rtl

rlUnknown838001 ; 83/8000

  .autsiz
  .databank ?

  inc wUnknown000302,b
  stz wUnknown000304,b
  rtl

rlUnknown838008 ; 83/8008

  .al
  .autsiz
  .databank ?

  lda wUnknown000304,b
  cmp #$0001
  bmi +

  -
  bra -

  +
  asl a
  tax
  jsr (_Table,x)
  rtl

  _Table ; 83/8018
    .addr rsUnknown83801A

rsUnknown83801A ; 83/801A

  .al
  .autsiz
  .databank ?

  jsl rlUnknown838053
  rts

aUnknown83801F ; 83/801F

  .addr rsRunChapterOpeningEvents
  .word $0001

  .addr rsUnknown838093
  .word $0002

  .addr rsRunChapterTurnEvents
  .word $0003

  .addr rsUnknown8381C2
  .word $0004

  .addr rsUnknown8381F6
  .word $000B

  .addr rsUnknown838513
  .word $0000

  .addr $83F44E
  .word $0001

  .addr rsUnknown83813C
  .word $0000

  .addr rsUnknown838158
  .word $0000

  .addr rsUnknown838189
  .word $0000

  .addr rsUnknown83821F
  .word $0000

  .addr rsUnknown83820C
  .word $000A

  .addr rsUnknown838459
  .word $0000

rlUnknown838053 ; 83/8053

  .al
  .autsiz
  .databank ?

  stz aBGPal0,b

  jsl $8E96DB

  php
  phb

  sep #$20
  lda #`aPhaseControllerInfo
  pha
  plb
  rep #$30

  .databank `aPhaseControllerInfo

  lda wUnknown000E23,b
  and #$00FF
  asl a
  asl a
  tax
  lda aUnknown83801F,x
  sta wR0
  pea <>(+)-1
  jmp (wR0)

  +
  plb
  plp
  rtl

rsUnknown83807C ; 83/807C

  .al
  .autsiz
  .databank ?

  lda wUnknown000E23,b
  and #$00FF
  asl a
  asl a
  inc a
  inc a
  tax
  lda aUnknown83801F,x
  sta wUnknown000E23,b
  rts

rlUnknown83808F ; 83/808F

  .al
  .autsiz
  .databank ?

  stz wUnknown000E25,b
  rtl

rsUnknown838093 ; 83/8093

  .al
  .xl
  .autsiz
  .databank `aPhaseControllerInfo

  -
  lda bBuf_INIDISP
  and #$00FF
  cmp #INIDISP_Setting(False, 15)
  beq +

  jmp _End

  +
  lda aUnknown0004BA,b
  beq +

  jmp _End

  +
  jsl $8593EB

  lda #$00E0
  jsl rlUnknown808C7D

  jsl rlPhaseChangeRefreshAllUnitsOfAllegiance

  ; If all phases have been gone through,
  ; increment turn and set phase back to player

  lda wCurrentPhase,b
  clc
  adc #Enemy
  cmp #NPC+1
  blt ++

  lda wCurrentTurn,b
  inc a
  cmp #9999
  blt +

  lda #9999

  +
  sta wCurrentTurn,b
  lda #Player

  +
  sta wCurrentPhase,b

  ; Given allegiance return 0-2

  lda wCurrentPhase,b
  jsl $83B296

  ; Grab offset of controller info

  lda aPhaseControllerInfo,x
  and #$00FF
  tax
  lda aPhaseControllerTable,x
  cmp #$0001
  bne +

  jmp -

  +
  jsl rlUnknown8397E8
  jsl $848A52
  jsl $83B267
  jsl $83B399
  jsr rsUnknown8382D2
  jsl rlUpdateVisibilityMap
  jsl rlUpdateUnitMapsAndFog

  stz wPhaseChangeHPEffectArrayOffset
  stz $7EA67F

  lda wCurrentPhase,b
  asl a
  sta $7E4FC8

  jsl $83CD2B
  lda #$0000
  sta wUnknown000E25,b

  jmp rsUnknown83807C

  _End
  rts

aPhaseControllerTable ; 83/8128
  .word $0001
  .word $0005
  .word $0006

rlUnknown83812E ; 83/812E

  .al
  .autsiz
  .databank ?

  lda wUnknown000E23,b
  jsl rlUnknown8397E8
  lda #$0007
  sta wUnknown000E23,b
  rtl

rsUnknown83813C ; 83/813C

  .autsiz
  .databank ?

  lda $7FAA14
  bne +

  jsl $839808
  sta wUnknown000E23,b

  +
  rts

rlUnknown83814A ; 83/814A

  .al
  .autsiz
  .databank ?

  lda wUnknown000E23,b
  jsl rlUnknown8397E8
  lda #$0008
  sta wUnknown000E23,b
  rtl

rsUnknown838158 ; 83/8158

  .al
  .autsiz
  .databank `lUnknown7EA4EC

  lda $7FAA14
  bne +

  jsl $839808
  sta wUnknown000E23,b
  jsl $8A9013
  lda lUnknown7EA4EC
  sta lR18
  lda lUnknown7EA4EC+1
  sta lR18+1
  phk
  pea <>(+)-1
  jmp [lR18]

  +
  rts

rlUnknown83817B ; 83/817B

  .al
  .autsiz

  lda wUnknown000E23,b
  jsl rlUnknown8397E8
  lda #$0009
  sta wUnknown000E23,b
  rtl

rsUnknown838189 ; 83/8189

  .autsiz
  .databank ?

  lda wUnknown000E6D,b
  bne +

  jsl $839808
  sta wUnknown000E23,b

  +
  rts

.include "PROCS/Unknown838196.asm"

rsRunChapterOpeningEvents ; 83/81B1

  .autsiz
  .databank ?

  jsl rlEventEngineRunChapterOpeningEvents
  jmp rsUnknown83807C

rsRunChapterTurnEvents ; 83/81B8

  .autsiz
  .databank ?

  stz wCurrentMapMusic,b
  jsl rlEventEngineRunChapterTurnEvents
  jmp rsUnknown83807C

rsUnknown8381C2 ; 83/81C2

  .al
  .autsiz
  .databank `aOptions.wUnitSpeedOption

  lda wCurrentPhase,b
  jsl $859999
  beq ++

  lda aOptions.wUnitSpeedOption
  bne +

  jsl rlUnknown81BCAE
  jsl rlUpdateUnitMapsAndFog

  phx
  lda #(`$87C4EF)<<8
  sta lR44+1
  lda #<>$87C4EF
  sta lR44
  jsl rlProcEngineCreateProc
  plx

  +
  jmp rsUnknown83807C

  +
  lda #$0001
  sta wUnknown000E23,b
  jsl $839808
  rts

rsUnknown8381F6 ; 83/81F6

  .al
  .autsiz
  .databank ?

  lda bBuf_INIDISP
  and #$00FF
  cmp #INIDISP_Setting(False, 15)
  bne +

  jsl $8593EB
  jsl $83A5A4
  jmp rsUnknown83807C

  +
  rts

rsUnknown83820C ; 83/820C

  .al
  .autsiz
  .databank ?

  lda bBuf_INIDISP
  and #$00FF
  cmp #INIDISP_Setting(False, 15)
  bne +

  lda aUnknown0004BA,b
  bne +

  jmp rsUnknown83807C

  +
  rts

rsUnknown83821F ; 83/821F

  .xl
  .autsiz
  .databank `wPhaseChangeHPEffectArrayOffset

  sep #$20
  ldx wPhaseChangeHPEffectArrayOffset
  lda aPhaseChangeHPEffectArray+structPhaseChangeHPEffectArrayEntryRAM.DeploymentNumber,x
  bne +

  jmp _82B7

  +
  sta wR0
  ldx #<>aActionStructUnit1
  stx wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber
  ldx aActionStructUnit1.Character
  beq _82AE

  ldx wPhaseChangeHPEffectArrayOffset
  lda aPhaseChangeHPEffectArray+structPhaseChangeHPEffectArrayEntryRAM.HPChange,x
  bmi +

  lda aActionStructUnit1.CurrentHP
  cmp aActionStructUnit1.MaxHP
  beq _82AE

  +
  ldy #<>aActionStructUnit1
  sty wR0
  ldy #<>aSelectedCharacterBuffer
  sty wR1
  jsl rlCopyExpandedCharacterDataBufferToBuffer
  lda aActionStructUnit1.MaxHP
  sta $7EA54C
  lda aActionStructUnit1.CurrentHP
  sta $7EA54D
  clc
  adc aPhaseChangeHPEffectArray+structPhaseChangeHPEffectArrayEntryRAM.HPChange,x
  bpl +

  lda #$00

  +
  cmp aSelectedCharacterBuffer.MaxHP,b
  blt +

  lda aSelectedCharacterBuffer.MaxHP,b

  +
  sta aSelectedCharacterBuffer.CurrentHP,b
  sta aActionStructUnit1.CurrentHP

  rep #$30
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  lda #<>aActionStructUnit1
  sta wR1
  jsl rlGetEquippableItemInventoryOffset

  sep #$20
  lda aItemDataBuffer.DisplayedWeapon,b
  sta aActionStructUnit1.EquippedItemID1
  rep #$20
  jsl $83E63C
  jsl rlUnknown8383F6
  jsl $83E7BE
  jsl $84B5CC
  jsl rlUnknown83814A

  _82AE
  rep #$30
  inc wPhaseChangeHPEffectArrayOffset
  inc wPhaseChangeHPEffectArrayOffset
  rts

  _82B7
  rep #$30
  jsl $839808
  sta wUnknown000E23,b
  cmp #$0006
  bne +

  jsl $83F500

  +
  jsl rlUpdateUnitMaps
  jsl rlSetTurnStartCursorPosition
  rts

rsUnknown8382D2 ; 83/82D2

  .autsiz
  .databank `wPhaseChangeHPEffectArrayOffset

  php
  rep #$30
  stz wPhaseChangeHPEffectArrayOffset
  lda #<>$8382F1
  sta lR25
  lda #>`$8382F1
  sta lR25+1
  lda wCurrentPhase,b
  jsl rlRunRoutineForAllUnitsInAllegiance
  ldx wPhaseChangeHPEffectArrayOffset
  stz aPhaseChangeHPEffectArray+structPhaseChangeHPEffectArrayEntryRAM.DeploymentNumber,x
  plp
  rts

rlUnknown8382F1 ; 83/82F1

  .al
  .autsiz
  .databank `wPhaseChangeHPEffectArrayOffset

  lda aTargetingCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aTargetingCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords
  sta wR17
  lda aTargetingCharacterBuffer.TurnStatus,b
  bit #TurnStatusActing
  bne +

  lda aTargetingCharacterBuffer.Status,b
  and #$00FF
  cmp #StatusPetrify
  beq +

  stz wR16
  jsr rsGetTerrainHealAmount
  jsr rsGetRenewalHealAmount
  jsr rsAppendHealAmountToArray
  jsr rsDecrementMagicAndVisionBonuses
  jsr rsGetPoisonDamageAmount
  lda #<>aTargetingCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  +
  rtl

rsGetRenewalHealAmount ; 83/8335

  .al
  .autsiz
  .databank `wPhaseChangeHPEffectArrayOffset

  lda aTargetingCharacterBuffer.Skills1,b
  bit #Skill1Renewal
  bne +

  rts

  +
  lda #11
  jsl rlUnknown80B0E6
  clc
  adc #10
  sta wR14

  lda aTargetingCharacterBuffer.MaxHP,b
  and #$00FF
  sta wR13
  xba
  sta wR13
  jsl rlUnsignedDivide16By8
  lda wR13
  xba
  and #$00FF
  sta wR13

  _AddToHeal
  sep #$20
  lda wR16
  clc
  adc wR13
  sta wR16
  rep #$30
  rts

rsGetTerrainHealAmount ; 83/836E

  .al
  .autsiz
  .databank `wPhaseChangeHPEffectArrayOffset

  ldx wR17
  lda aTerrainMap,x
  and #$00FF
  cmp #TerrainGate
  beq +

  cmp #TerrainFort
  beq +

  cmp #TerrainThrone
  beq +

  cmp #TerrainChurch1
  beq +

  cmp #TerrainChurch2
  beq +

  rts

  +
  lda #5
  sta wR13
  jmp rsGetRenewalHealAmount._AddToHeal

rsDecrementMagicAndVisionBonuses ; 83/8398

  .al
  .autsiz
  .databank `wPhaseChangeHPEffectArrayOffset

  sep #$20
  lda aTargetingCharacterBuffer.MagicBonus,b
  beq +

  dec aTargetingCharacterBuffer.MagicBonus,b

  +
  lda aTargetingCharacterBuffer.VisionBonus,b
  beq +

  dec aTargetingCharacterBuffer.VisionBonus,b

  +
  rep #$30
  rts

rsGetPoisonDamageAmount ; 83/83AD

  .al
  .autsiz
  .databank `wPhaseChangeHPEffectArrayOffset

  lda aTargetingCharacterBuffer.Status,b
  and #$00FF
  cmp #StatusPoison
  bne +

  lda #3
  jsl rlUnknown80B0E6
  sep #$20
  inc a
  eor #$FF
  inc a
  ldx wPhaseChangeHPEffectArrayOffset
  sta aPhaseChangeHPEffectArray+structPhaseChangeHPEffectArrayEntryRAM.HPChange,x
  lda aTargetingCharacterBuffer.DeploymentNumber,b
  sta aPhaseChangeHPEffectArray+structPhaseChangeHPEffectArrayEntryRAM.DeploymentNumber,x
  inc x
  inc x
  stx wPhaseChangeHPEffectArrayOffset
  rep #$30

  +
  rts

rsAppendHealAmountToArray ; 83/83D9

  .al
  .autsiz
  .databank `wPhaseChangeHPEffectArrayOffset

  lda wR16
  and #$00FF
  beq +

  sep #$20
  ldx wPhaseChangeHPEffectArrayOffset
  sta aPhaseChangeHPEffectArray+structPhaseChangeHPEffectArrayEntryRAM.HPChange,x
  lda aTargetingCharacterBuffer.DeploymentNumber,b
  sta aPhaseChangeHPEffectArray+structPhaseChangeHPEffectArrayEntryRAM.DeploymentNumber,x
  inc x
  inc x
  stx wPhaseChangeHPEffectArrayOffset
  rep #$30

  +
  rts

rlUnknown8383F6 ; 83/83F6

  .al
  .autsiz
  .databank `aActionStructUnit1

  lda aActionStructUnit1.CurrentHP
  and #$00FF
  beq +

  rtl

  +
  sep #$20
  ldx aActionStructUnit1.Character
  stx aBurstWindowCharacterBuffer.Character,b
  lda aActionStructUnit1.CurrentHP
  sta aBurstWindowCharacterBuffer.CurrentHP,b
  lda aActionStructUnit1.DeploymentNumber
  sta bUnknownTargetingDeploymentNumber
  lda #$C0
  sta aActionStructUnit2.DeploymentNumber
  lda #$14
  sta bUnknown7E4FCF
  rep #$30
  jsl $83E71B
  jsl rlUpdateSaveSlotLosses
  jsl $839C70
  lda #<>rlUnknown838438
  sta lUnknown7EA4EC
  lda #>`rlUnknown838438
  sta lUnknown7EA4EC+1
  rtl

rlUnknown838438 ; 83/8438

  .al
  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #`bUnknownTargetingDeploymentNumber
  pha
  rep #$20
  plb

  .databank `bUnknownTargetingDeploymentNumber

  lda bUnknownTargetingDeploymentNumber
  beq +

  jsl rlUpdateVisibilityMap
  jsl $83A246

  +
  stz bUnknownTargetingDeploymentNumber
  jsl rlUpdateUnitMapsAndFog
  plb
  plp
  rtl

rsUnknown838459 ; 83/8459

  .al
  .autsiz
  .databank `$7E4F98

  phx
  lda #(`procPrepScreenMapScroll)<<8
  sta lR44+1
  lda #<>procPrepScreenMapScroll
  sta lR44
  jsl rlProcEngineCreateProc
  plx
  stz $7E4F98
  lda #$FFFF
  sta wPrepScreenFlag,b
  lda #$0005
  sta wUnknown000E23,b
  lda #$0000
  sta wUnknown000E25,b
  jsl $85F418
  jsl $85F42F
  jsl rlUnknown83812E
  rts

aUnknown83848B ; 83/848B
  .addr rsUnknown83853C
  .word $0000

  .addr rsUnknown838576
  .word $0002

  .addr rsUnknown8385EE
  .word $001F

  .addr rsUnknown83865E
  .word $0000

  .addr rsUnknown838686
  .word $0000

  .addr rsUnknown83897C
  .word $0006

  .addr rsUnknown8389C6
  .word $0007

  .addr rsUnknown838A19
  .word $0020

  .addr rsUnknown838A64
  .word $0009

  .addr rsUnknown838A6B
  .word $0000

  .addr rsUnknown838513
  .word $0000

  .addr rsUnknown838C3E
  .word $0021

  .addr rsUnknown838C6F
  .word $0002

  .addr rsUnknown838997
  .word $0006

  .addr rsUnknown838D09
  .word $0000

  .addr rsUnknown838AC1
  .word $0010

  .addr rsUnknown838AD1
  .word $0011

  .addr rsUnknown838AE1
  .word $0012

  .addr rsUnknown838AF1
  .word $0013

  .addr rsUnknown838B01
  .word $0014

  .addr rsUnknown838B24
  .word $0015

  .addr rsUnknown838B5C
  .word $0016

  .addr rsUnknown838BA0
  .word $0017

  .addr rsUnknown838BB0
  .word $0018

  .addr rsUnknown838BDB
  .word $0000

  .addr rsUnknown838DD9
  .word $001A

  .addr rsUnknown838DEC
  .word $001B

  .addr rsUnknown838D52
  .word $0000

  .word $0000
  .word $0000

  .addr rsUnknown838DF7
  .word $0000

  .addr rsUnknown838E1E
  .word $0000

  .addr rsUnknown838E58
  .word $0000

  .addr rsUnknown838A39
  .word $0008

  .addr rsUnknown838A39
  .word $000C

rsUnknown838513 ; 83/8513

  .al
  .autsiz
  .databank ?

  lda wUnknown000E25,b
  and #$00FF
  asl a
  asl a
  tax
  lda aUnknown83848B,x
  sta wR0
  pea <>(+)-1
  jmp (wR0)

  +
  rts

rsUnknown838529 ; 83/8529

  .al
  .autsiz
  .databank ?

  lda wUnknown000E25,b
  and #$00FF
  asl a
  asl a
  inc a
  inc a
  tax
  lda aUnknown83848B,x
  sta wUnknown000E25,b
  rts

rsUnknown83853C ; 83/853C

  .al
  .autsiz
  .databank `$7E4F8F

  lda aUnknown0004BA,b
  bne _End

  stz $7E4F8F
  jsl $8593AD
  jsl $859446
  jsl $84A17D
  jsl $83CD11

  lda wPrepScreenFlag,b
  beq _856F

  bmi _8568

  lda #$FFFF
  sta wPrepScreenFlag,b

  lda #$001A
  sta wUnknown000E25,b

  _End
  rts

  _8568
  lda #$0019
  sta wUnknown000E25,b
  rts

  _856F
  lda #$0001
  sta wUnknown000E25,b
  rts

rsUnknown838576 ; 83/8576

  .al
  .autsiz
  .databank ?

  lda wUnknown000E6D,b
  beq +

  rts

  +
  jsl $849E80
  jsl $84A09B
  jsl $839B84
  jsl $83BDD1
  lda #$0004
  jsl $83BF67
  jsl $839B84
  jsl $83C6A9

  lda wJoy1Input
  and #JoypadY
  beq +

  jsr rsUnknown838708
  rts

  +
  lda wJoy1New
  bit #JoypadR
  beq +

  jsl rlUnknown81BA36
  jmp _End
  rts

  +
  lda wJoy1New
  bit #JoypadA
  beq +

  jsr rsUnknown8386A4
  jmp _End
  rts

  +
  lda wJoy1New
  bit #JoypadX
  beq +

  jsr rsUnknown83873F
  jmp _End
  rts

  +
  lda wJoy1New
  bit #JoypadSelect
  beq +

  jsr $8386E3
  jmp _End
  rts

  +
  lda wJoy1New
  bit #JoypadStart
  beq _End

  stz wUnknown000E2B,b
  jsl rlUnknown838A72

  _End
  rts

rsUnknown8385EE ; 83/85EE

  .al
  .autsiz
  .databank ?

  lda wUnknown000E6D,b
  beq +

  rts

  +
  jsl $839B84
  jsl $83BE94
  lda #$0004
  jsl $83BF67
  jsl $839B84
  jsl $83C6A9

  lda wJoy1New
  bit #JoypadA
  beq +

  jsr rsUnknown838853
  rts

  +
  lda wJoy1New
  bit #JoypadB
  beq ++

  lda #$0021
  jsl rlUnknown808C87

  lda aSelectedCharacterBuffer.TurnStatus,b
  bit #TurnStatusMoved
  bne +

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer
  jsl $839B37
  jsr rsUnknown83894C
  jsr rsUnknown838669
  jsl $8A9013
  jmp rsUnknown838529

  +
  jsr rsUnknown838669

  +
  lda wJoy1New
  bit #JoypadR
  beq +

  jsr rsUnknown838669

  +
  lda wJoy1Input
  and #JoypadY
  beq +

  jsr rsUnknown838708

  +
  rts

rsUnknown83865E ; 83/865E

  .al
  .autsiz
  .databank ?

  lda wJoy1New
  and #JoypadA
  beq +

  jmp rsUnknown838529

  +
  rts

rsUnknown838669 ; 83/8669

  .autsiz
  .databank ?

  lda wSelectedUnitXCoord,b
  sta wR0
  lda wSelectedUnitYCoord,b
  sta wR1
  jsl $83C181

rsUnknown838677 ; 83/8677

  .autsiz
  .databank ?

  lda wSelectedUnitXCoord,b
  sta wR0
  lda wSelectedUnitYCoord,b
  sta wR1
  jsl rlUnknown81B4ED
  rts

rsUnknown838686 ; 83/8686

  .al
  .autsiz
  .databank ?

  jsl $83BDC5
  lda #$0008
  jsl $83BF67
  jsl $83C6A9

  lda wJoy1Input
  and #JoypadY
  bne +

  jsl $839808
  sta wUnknown000E25,b

  +
  rts

rsUnknown8386A4 ; 83/86A4

  .al
  .autsiz
  .databank `$7E4F87

  jsl $839B7F
  lda #$FFFF
  sta $7E4F87
  jsl $84A125
  ldx wCursorTileIndex,b
  lda aPlayerVisibleUnitMap,x
  and #$00FF
  beq +

  sta wR0
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber
  lda aSelectedCharacterBuffer.TurnStatus,b
  and #TurnStatusGrayed
  bne +

  lda aSelectedCharacterBuffer.Status,b
  and #$00FF
  cmp #StatusSleep
  beq +

  jsr $838764
  jsl $83CD2B
  rts

  +
  jsl $839B7F
  lda #$FFFF
  sta $7E4F87
  jsl $84A125
  lda #$0000
  sta wUnknown000E25,b
  phx
  lda #(`$8A82D7)<<8
  sta lR44+1
  lda #<>$8A82D7
  sta lR44
  jsl rlProcEngineCreateProc
  plx
  rts

rsUnknown838708 ; 83/8708

  .al
  .autsiz
  .databank `$7E4F87

  lda wCursorXCoordPixelsScrolling,b
  ora wCursorYCoordPixelsScrolling,b
  and #$0007
  bne ++

  lda #$FFFF
  sta $7E4F87
  lda wUnknown000E25,b
  jsl rlUnknown8397E8
  lda #$0002
  cmp wUnknown000E25,b
  beq +

  jsl $849FB3
  jsl $84A125
  jsl rlEnableBG1Sync
  jsl rlEnableBG3Sync

  +
  lda #$0004
  sta wUnknown000E25,b

  +
  rts

rsUnknown83873F ; 83/873F

  .al
  .autsiz
  .databank `$7E4F8F

  ldx wCursorTileIndex,b
  lda aPlayerVisibleUnitMap,x
  and #$00FF
  beq +

  pha
  stz $7E4F8F
  lda #$FFFF
  sta $7E4F87
  jsl $84A125
  pla
  jsl rlUnknown80BBD2
  lda #$0000
  sta wUnknown000E25,b

  +
  rts

rsUnknown838764 ; 83/8764

  .al
  .autsiz
  .databank `aPlayerVisibleUnitMap

  ldx wCursorTileIndex,b
  lda aPlayerVisibleUnitMap,x
  sta wR0
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber
  lda aSelectedCharacterBuffer.TurnStatus,b
  and #~TurnStatusMoved
  sta aSelectedCharacterBuffer.TurnStatus,b
  stz $7E4F96
  stz $7E4F98
  jsl $839A3D
  lda #<>aSelectedCharacterBuffer
  sta wR14
  jsl rlUnknown8387D5
  sta wR2
  sta $7E4F9C
  lda aSelectedCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aSelectedCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  lda aSelectedCharacterBuffer.Class,b
  and #$00FF
  sta wR3
  lda #$FFFF
  sta wR4
  lda aSelectedCharacterBuffer.Skills1,b
  sta wR5
  jsl rlUnknown81B9F4
  jsl rlDrawAttackRange
  jsl $849FB3
  jsl $83C1E9
  lda #$0001
  sta wDisplayRangeFlag,b
  lda #$0002
  sta wUnknown000E25,b
  rts

rlUnknown8387D5 ; 83/87D5

  .al
  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  phx
  phy
  lda wR14
  sta wR0
  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl rlCopyExpandedCharacterDataBufferToBuffer
  jsl rlCombineCharacterDataAndClassBases
  lda aUnknownActionStruct000F56.Movement,b
  and #$00FF
  sta wR2
  lda aSelectedCharacterBuffer.TurnStatus,b
  bit #TurnStatusRescuing
  beq _End

  lda lR18
  pha
  lda lR18+1
  pha
  lda wR0
  pha
  lda wR1
  pha
  lda wR3
  pha
  lda aUnknownActionStruct000F56.Rescue,b
  sta wR0
  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber
  jsl rlCombineCharacterDataAndClassBases
  lda aUnknownActionStruct000F56.Constitution,b
  and #$00FF
  asl a
  sta wR3
  lda wR14
  sta wR1
  jsl $83A855
  cmp wR3
  bcs +

  lda wR2
  lsr a
  sta wR2

  +
  pla
  sta wR3
  pla
  sta wR1
  pla
  sta wR0
  pla
  sta lR18+1
  pla
  sta lR18

  _End
  lda wR2
  ply
  plx
  plb
  plp
  rtl

rsUnknown838853 ; 83/8853

  .autsiz
  .databank ?

  php
  rep #$30
  lda wPrepScreenFlag,b
  beq +

  jmp _88FB

  +
  lda aSelectedCharacterBuffer.DeploymentNumber,b
  jsl $83B320
  bcc +

  jmp _88FB

  +
  lda aSelectedCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aSelectedCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords
  sta wMoveStartTileIndex,b
  lda wCursorTileIndex,b
  sta wMoveDestTileIndex,b
  jsr rsUnknown838913
  bcc +

  lda wCursorXCoord,b
  sta wR0
  lda wCursorYCoord,b
  sta wR1
  jsl rlUnknown80E451
  lda wSelectedUnitXCoord,b
  sta wR0
  lda wSelectedUnitYCoord,b
  sta wR1
  jsl $83A6BB
  pha
  sep #$20
  lda wR0
  sta aSelectedCharacterBuffer.X,b
  lda wR1
  sta aSelectedCharacterBuffer.Y,b
  rep #$20
  lda #(`aMovementDirectionArray)<<8
  sta lR18+1
  lda #<>aMovementDirectionArray
  sta lR18
  jsl $8A8FBC
  jsl rlUnknown83812E

  lda #$000D
  jsl rlUnknown808C87

  jsr rsUnknown83894C
  jsr rsUnknown83895F
  lda #$0005
  sta wUnknown000E25,b
  jsr rsUnknown838677
  pla
  tax
  beq +

  lda #$0006
  sta wUnknown000E25,b
  lda #$FFFF
  sta $7E4F96
  lda aSelectedCharacterBuffer.TurnStatus,b
  ora #TurnStatusMovementStar | TurnStatusMoved
  sta aSelectedCharacterBuffer.TurnStatus,b

  +
  plp
  rts

  _88FB
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer
  jsr rsUnknown83894C
  jsl $8A9013
  lda #$001F
  sta wUnknown000E25,b
  plp
  rts

rsUnknown838913 ; 83/8913

  .al
  .autsiz
  .databank `aRangeMap

  ldx wCursorTileIndex,b
  lda aRangeMap,x
  and #$00FF
  cmp #$006F
  bge _False

  lda aPlayerVisibleUnitMap,x
  and #$00FF
  beq _True

  bra _False

  and #Player | Enemy | NPC
  bne _False

  sta wR0
  lda aSelectedCharacterBuffer.TurnStatus,b
  bit #TurnStatusRescuing
  bne _False

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber
  lda aBurstWindowCharacterBuffer.Rescue,b
  beq _True

  _False
  clc
  rts

  _True
  sec
  rts

rsUnknown83894C ; 83/894C

  .autsiz
  .databank ?

  php
  rep #$30
  lda #$0000
  sta wDisplayRangeFlag,b
  stz wBuf_BG1HOFS
  stz wBuf_BG1VOFS
  jsl rlUpdateUnitMaps
  plp
  rts

rsUnknown83895F ; 83/895F

  .al
  .autsiz
  .databank `aRangeMap

  lda aSelectedCharacterBuffer.TurnStatus,b
  bit #TurnStatusMoved
  bne +

  ldx wCursorTileIndex,b
  lda aRangeMap,x
  and #$00FF
  sta wR0
  lda $7E4F9C
  sec
  sbc wR0
  sta $7E4F9C

  +
  rts

rsUnknown83897C ; 83/897C

  .al
  .autsiz
  .databank ?

  jsl $858033
  jsl $858466
  phx
  lda #(`$878350)<<8
  sta lR44+1
  lda #<>$878350
  sta lR44
  jsl rlProcEngineCreateProc
  plx
  jmp rsUnknown838529

rsUnknown838997 ; 83/8997

  .al
  .autsiz
  .databank `$7E4F96

  lda aUnknown0004BA,b
  ora wUnknown0004F4,b
  and #$00FF
  bne ++

  lda $7E4F96
  beq +

  jmp rsUnknown838D09

  +
  jsl $858033
  jsl $858466
  phx
  lda #(`$878350)<<8
  sta lR44+1
  lda #<>$878350
  sta lR44
  jsl rlProcEngineCreateProc
  plx
  jmp rsUnknown838529

  +
  rts

rsUnknown8389C6 ; 83/89C6

  .al
  .autsiz
  .databank `$7E4F96

  lda $7E4F96
  bne ++

  lda aSelectedCharacterBuffer.TurnStatus,b
  bit #TurnStatusMoved
  beq +

  jmp rsUnknown838CE2

  +
  sep #$20
  lda wSelectedUnitXCoord,b
  sta aSelectedCharacterBuffer.X,b
  lda wSelectedUnitYCoord,b
  sta aSelectedCharacterBuffer.Y,b
  rep #$20
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer
  jsr rsUnknown838669
  jsl $839B37
  jsr $83894C
  jsl $8A9013
  lda #$0000
  sta wUnknown000E25,b
  rts

  +
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $83A7BA
  bcc +

  jmp $838C3E

  +
  jsl rlUnknown8C9CCD
  jmp rsUnknown838529

rsUnknown838A19 ; 83/8A19

  .al
  .autsiz
  .databank ?

  lda aSelectedCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aSelectedCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl $83C181
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $839A94
  jmp rsUnknown838529

rsUnknown838A39 ; 83/8A39

  .al
  .autsiz
  .databank ?

  lda bBuf_INIDISP
  and #$00FF
  cmp #INIDISP_Setting(False, 15)
  bne +

  lda aUnknown0004BA,b
  bne +

  jsl rlUnknown838A50
  jmp rsUnknown838529

  +
  rts

rlUnknown838A50 ; 83/8A50

  .al
  .autsiz
  .databank `$7E524E

  lda $7E524E
  beq +

  jsl $84B6CD
  bcc +

  jsl $84B6B0
  jsl rlUnknown83812E

  +
  rtl

rsUnknown838A64 ; 83/8A64

  .al
  .autsiz
  .databank ?

  jsl $83A8D2
  jmp rsUnknown838529

rsUnknown838A6B ; 83/8A6B

  .al
  .autsiz
  .databank ?

  jsl rlUnknown8C9CDD
  jmp rsUnknown838529

rlUnknown838A72 ; 83/8A72

  .al
  .autsiz
  .databank`$7E4FA6

  lda $7E4FA6
  bne +

  phx
  lda #(`$849DF4)<<8
  sta lR44+1
  lda #<>$849DF4
  sta lR44
  jsl rlProcEngineFindProc
  plx
  bcs +

  sep #$20
  lda #TM_Setting(False, True, False, False, True)
  sta bBuf_TM
  rep #$20
  lda #$000F
  sta wUnknown000E25,b
  lda #$FFFF
  sta $7E4F87
  jsl $8593EB
  jsl $83B476
  jsl $8497C1
  jsl $848B79
  stz $7EBADD
  phx
  lda #(`$849CDB)<<8
  sta lR44+1
  lda #<>$849CDB
  sta lR44
  jsl rlProcEngineCreateProc
  plx

  +
  rtl

rsUnknown838AC1 ; 83/8AC1

  .al
  .autsiz
  .databank ?

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $7FB0F5, $C00, VMAIN_Setting(True), $A000

  jmp rsUnknown838529

rsUnknown838AD1 ; 83/8AD1

  .al
  .autsiz
  .databank ?

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $7FBCF5, $C00, VMAIN_Setting(True), $AC00

  jmp rsUnknown838529

rsUnknown838AE1 ; 83/8AE1

  .al
  .autsiz
  .databank ?

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $7FC8F5, $C00, VMAIN_Setting(True), $B800

  jmp rsUnknown838529

rsUnknown838AF1 ; 83/8AF1

  .al
  .autsiz
  .databank ?

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $7FD4F5, $C00, VMAIN_Setting(True), $C400

  jmp rsUnknown838529

rsUnknown838B01 ; 83/8B01

  .al
  .autsiz
  .databank `wEventEngineUnknownXTarget

  stz wEventEngineUnknownXTarget
  jsl $849A04
  jsl $849B64

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, aBG1TilemapBuffer, $800, VMAIN_Setting(True), $E000

  sep #$20
  lda #TM_Setting(True, True, False, False, True)
  sta bBuf_TM
  rep #$20

  jmp rsUnknown838529

rsUnknown838B24 ; 83/8B24

  .al
  .autsiz
  .databank `$7EBADD

  lda wUnknown000E2B,b
  beq +

  lda wJoy1New
  bit #JoypadA
  beq +

  lda $7EBADD
  bne +

  lda #$0002
  sta wUnknown000E2B,b
  bra ++

  +
  jsl $849E68
  jsl $839BA5
  lda wJoy1New
  bit #JoypadStart | JoypadB
  beq ++

  lda $7EBADD
  bne ++

  +
  lda #$0049
  jsl rlUnknown808CDD
  jmp rsUnknown838529

  +
  rts

rsUnknown838B5C ; 83/8B5C

  .al
  .autsiz
  .databank ?

  lda wMapScrollWidthPixels,b
  lsr a
  lsr a
  lsr a
  lsr a
  clc
  adc #7
  sta wR0

  lda wMapScrollHeightPixels,b
  lsr a
  lsr a
  lsr a
  lsr a
  clc
  adc #6
  sta wR1

  jsl $83C181
  stz wBuf_BG1VOFS
  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $F3CC80, $C00, VMAIN_Setting(True), $B800

  phx
  lda #(`$849DF4)<<8
  sta lR44+1
  lda #<>$849DF4
  sta lR44
  jsl rlProcEngineCreateProc
  plx

  jsl $8593AD
  jmp rsUnknown838529

rsUnknown838BA0 ; 83/8BA0

  .al
  .autsiz
  .databank ?

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $F3D880, $C00, VMAIN_Setting(True), $C400

  jmp rsUnknown838529

rsUnknown838BB0 ; 83/8BB0

  .al
  .autsiz
  .databank ?

  lda #<>aBG3TilemapBuffer
  sta wR0
  lda #$01DF
  jsl rlFillTilemapByWord
  jsl rlEnableBG3Sync

  lda #<>aBG1TilemapBuffer
  sta wR0
  lda #$02FF
  jsl rlFillTilemapByWord
  jsl rlEnableBG1Sync

  sep #$20
  lda #BG12NBA_Setting($4000, $4000)
  sta bBuf_BG12NBA
  rep #$20
  jmp rsUnknown838529

rsUnknown838BDB ; 83/8BDB

  .al
  .autsiz
  .databank ?

  phx
  lda #(`$849DF4)<<8
  sta lR44+1
  lda #<>$849DF4
  sta lR44
  jsl rlProcEngineFindProc
  plx
  bcc +

  rts

  +
  lda wUnknown000E2B,b
  cmp #$0001
  beq _8C0E

  cmp #$0002
  beq _8C2D

  lda wPrepScreenFlag,b
  bne +

  jmp rsUnknown838529

  +
  jsl $859446
  lda #$001B
  sta wUnknown000E25,b
  rts

  _8C0E
  lda aSelectedCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aSelectedCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl rlUnknown81B4ED
  jsl rlUnknown83817B
  lda #$0005
  sta wUnknown000E25,b
  rts

  _8C2D
  phx
  lda #(`$87C674)<<8
  sta lR44+1
  lda #<>$87C674
  sta lR44
  jsl rlProcEngineCreateProc
  plx
  rts

rsUnknown838C3E ; 83/8C3E

  .al
  .autsiz
  .databank `$7E4F96

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $839A94
  lda aSelectedCharacterBuffer.TurnStatus,b
  and #~TurnStatusGrayed
  ora #TurnStatusMoved
  sta aSelectedCharacterBuffer.TurnStatus,b
  stz $7E4F96
  stz $7E4F98
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer
  jsl $8885D1
  lda #$000B
  sta wUnknown000E25,b
  jmp rsUnknown838529

rsUnknown838C6F ; 83/8C6F

  .al
  .autsiz
  .databank `$7E4F9C

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $839A3D
  lda aSelectedCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aSelectedCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  lda aSelectedCharacterBuffer.Class,b
  and #$00FF
  sta wR3
  lda #$FFFF
  sta wR4
  lda aSelectedCharacterBuffer.Skills1,b
  sta wR5
  lda $7E4F9C
  sta wR2
  beq +

  jsl rlUnknown81B9F4
  lda #<>aMovementMap
  sta lR18
  lda #>`aMovementMap
  sta lR18+1
  lda #$0000
  jsl rlFillMapByWord
  jsl $83C1E9
  lda #$0001
  sta wDisplayRangeFlag,b
  jmp rsUnknown838529

  +
  lda wR0
  sta wCursorXCoord,b
  lda wR1
  sta wCursorYCoord,b
  jsl rlGetMapTileIndexByCoords
  sta wCursorTileIndex,b
  tax
  sep #$20
  lda #$00
  sta aRangeMap,x
  rep #$20
  jsr rsUnknown838853
  rts

rsUnknown838CE2 ; 83/8CE2

  .al
  .autsiz
  .databank ?

  jsl $8A9013
  lda aSelectedCharacterBuffer.DeploymentNumber,b
  sta wR0
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber
  lda aSelectedCharacterBuffer.TurnStatus,b
  and #~TurnStatusActing
  sta aSelectedCharacterBuffer.TurnStatus,b
  lda #$000C
  sta wUnknown000E25,b
  jsr rsUnknown838669
  jmp rsUnknown838C6F

rsUnknown838D09 ; 83/8D09

  .al
  .autsiz
  .databank ?

  lda #$0006
  sta wUnknown000E25,b
  jsl $858033
  jsl $858466
  phx
  lda #(`$878AE0)<<8
  sta lR44+1
  lda #<>$878AE0
  sta lR44
  jsl rlProcEngineCreateProc
  plx
  rts

rlUnknown838D28 ; 83/8D28

  .autsiz
  .databank ?

  php
  sep #$20
  phb
  lda #`aTerrainMovementCostBuffer
  pha
  plb

  .databank `aTerrainMovementCostBuffer

  lda #$71
  sta bMovementCostCap,b
  rep #$30

  jsl rlCopyTerrainMovementCostBuffer
  lda wR5
  bit #$0004
  beq +

  sep #$20
  lda #$08
  sta aTerrainMovementCostBuffer.Unknown4
  sta aTerrainMovementCostBuffer.Unknown1
  rep #$30

  +
  jmp rlFillMovementRangeArray

rsUnknown838D52 ; 83/8D52

  .al
  .autsiz
  .databank `aPlayerVisibleUnitMap

  lda wUnknown000E6D,b
  beq +

  rts

  +
  jsl $849E80
  jsl $84A09B
  jsl $839B84
  jsl $83BDD1

  lda #$0004
  jsl $83BF67
  jsl $839B84
  jsl $83C6A9

  lda wJoy1Input
  bit #JoypadY
  beq +

  jsr rsUnknown838708
  rts

  +
  lda wJoy1New
  bit #JoypadX
  beq +

  jsr rsUnknown83873F
  jmp rsUnknown838576._End
  rts

  +
  lda wJoy1New
  bit #JoypadA
  beq +

  ldx wCursorTileIndex,b
  lda aPlayerVisibleUnitMap,x
  and #$00FF
  beq ++

  lda #$FFFF
  sta $7E4F87
  jsl $84A125
  jsr rsUnknown838764
  lda #$0001
  sta wPrepScreenFlag,b
  rts

  +
  lda wJoy1New
  bit #JoypadA | JoypadB
  beq ++

  +
  lda #$FFFF
  sta $7E4F87
  jsl $84A125
  lda #$0000
  sta wUnknown000E25,b

  +
  lda wJoy1New
  bit #JoypadStart
  beq +

  jsl rlUnknown838A72

  +
  rts

rsUnknown838DD9 ; 83/8DD9

  .al
  .autsiz
  .databank ?

  phx
  lda #(`$8A8580)<<8
  sta lR44+1
  lda #<>$8A8580
  sta lR44
  jsl rlProcEngineCreateProc
  plx
  jmp rsUnknown838529

rsUnknown838DEC ; 83/8DEC

  .autsiz
  .databank ?

  jsl $859446
  jsl $83CD11
  jmp rsUnknown838529

rsUnknown838DF7 ; 83/8DF7

  .al
  .autsiz
  .databank `$7EA695

  lda #$000A
  sta $7EA695
  jsl $83E7FE
  jsl $84B66E
  lda #$0006
  sta wUnknown000E25,b
  jsl rlUnknown83812E
  jsl $83E63C
  rts

rsUnknown838E14 ; 83/8E14

  .al
  .autsiz
  .databank ?

  jsr rsUnknown838764
  lda #$001E
  sta wUnknown000E25,b
  rts

rsUnknown838E1E ; 83/8E1E

  .al
  .autsiz
  .databank ?

  jsl $83C6A9
  lda wJoy1New
  bit #JoypadX | JoypadA | JoypadRight | JoypadLeft | JoypadDown | JoypadUp | JoypadB
  beq +

  lda wJoy1New
  and #JoypadA | JoypadB
  sta wJoy1New

  lda wJoy1Alt
  and #JoypadA | JoypadB
  sta wJoy1Alt

  lda wJoy1Input
  and #JoypadA | JoypadB
  sta wJoy1Input

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer
  jsr rsUnknown83894C
  jsl $8A9013
  lda #$0000
  sta wUnknown000E25,b
  jmp rsUnknown83853C

  +
  rts

rsUnknown838E58 ; 83/8E58

  .autsiz
  .databank ?

  jmp rsUnknown838529

rlIncrementIngameTime ; 83/8E5B

  .autsiz
  .databank ?

  php
  rep #$30
  inc wIngameTime,b
  lda wMenuCounter,b
  adc #$0000
  bcs +

  sta wMenuCounter,b
  plp
  rtl

  +
  lda #$FFFF
  sta wIngameTime,b
  plp
  rtl

rlGetMapTileIndexByCoords ; 83/8E76

  .autsiz
  .databank ?

  ; Given [X, Y] return tile index in the
  ; current chapter map

  ; Inputs:
  ; wR0: X coordinate
  ; wR1: Y coordinate

  ; Outputs:
  ; A: Tile index

  phx
  lda wR1
  asl a
  tax
  lda aMapTileRowIndexes,x
  clc
  adc wR0
  plx
  rtl

rlGetMapCoordsByTileIndex ; 83/8E84

  .autsiz
  .databank ?

  ; Given a tile index return
  ; coordinates in current chapter map

  ; Inputs:
  ; A: Tile index

  ; Outputs:
  ; wR0: X coordinate
  ; wR1: Y coordinate

  sta wR13
  lda wMapRowSize,b
  sta wR14
  jsl rlUnsignedDivide16By8
  lda wR10
  sta wR0
  lda wR13
  sta wR1
  rtl

.include "../TABLES/DeploymentSlotTable.asm"

rlCopyCharacterDataToBufferByDeploymentNumber ; 83/901C

  .autsiz
  .databank ?

  ; Copies character data from deployment slot given by
  ; deployment number in wR0 into location given by
  ; short RAM pointer in wR1 and saves the deployment
  ; number and pointer to the end of the character data

  ; Inputs:
  ; wR0: Deployment number
  ; wR1: Destination

  ; Outputs:
  ; None

  php
  phb

  rep #$30

  phx
  phy

  ldy wR1

  ; Store deployment number and slot pointer
  ; to buffer to make it easier to write the data
  ; back.

  lda wR0
  and #$00FF
  sta structExpandedCharacterDataRAM.DeploymentNumber,b,y

  asl a
  tax
  lda aDeploymentSlotTable,x
  sta structExpandedCharacterDataRAM.DeploymentSlot,b,y

  ; Copy unit to buffer

  tax
  lda #size(structCharacterDataRAM)-1
  mvn #`aPlayerUnits,#$7E

  ply
  plx
  plb
  plp
  rtl

rlCopyCharacterDataFromBuffer ; 83/9041

  .autsiz
  .databank ?

  ; Writes character data from a buffer
  ; back to their deployment slot.

  ; Inputs:
  ; wR1: Short RAM pointer to buffer with character data

  ; Outputs:
  ; None

  php
  phb

  rep #$30

  phx
  phy

  ; Hang if there's no slot to write to

  ldx wR1
  lda structExpandedCharacterDataRAM.DeploymentSlot,b,x
  bne +

  -
  beq -

  +
  tay
  lda #size(structCharacterDataRAM)-1
  mvn #$7E,#`aPlayerUnits

  ply
  plx
  plb
  plp
  rtl

rlCopyExpandedCharacterDataBufferToBuffer ; 83/905C

  .autsiz
  .databank ?

  ; Copies expanded character data to another place.

  ; Inputs:
  ; wR0: Source expanded character data
  ; wR1: Destination

  ; Outputs:
  ; None

  php
  phb

  rep #$30

  phx
  phy

  ldx wR0
  ldy wR1

  lda #size(structExpandedCharacterDataRAM)-1
  mvn #$7E,#$7E

  ply
  plx
  plb
  plp
  rtl

rlCopyCharacterDataBufferToBuffer ; 83/9071

  .autsiz
  .databank ?

  ; Copies character data to another place.

  ; Inputs:
  ; wR0: Source character data
  ; wR1: Destination

  ; Outputs:
  ; None

  php
  phb

  rep #$30

  phx
  phy

  ldx wR0
  ldy wR1
  lda #size(structCharacterDataRAM)-1
  mvn #$7E,#$7E

  ply
  plx
  plb
  plp
  rtl

rlCopyExpandedCharacterDataBufferToBufferAndUpdateSlot ; 83/9086

  ; Copies expanded character data to another place.
  ; Also updates the deployment slot to reflect the
  ; new location.

  ; Inputs:
  ; wR0: Source expanded character data
  ; wR1: Destination

  ; Outputs:
  ; None

  phy

  jsl rlCopyExpandedCharacterDataBufferToBuffer

  ldy wR1
  lda wR0
  sta structExpandedCharacterDataRAM.DeploymentSlot,b,y

  ply
  rtl

rlClearExpandedCharacterData ; 83/9094

  .autsiz
  .databank ?

  ; Clears an expanded character data struct.

  ; Inputs:
  ; wR1: Short RAM pointer to expanded character data.

  ; Outputs:
  ; None

  php
  phb

  sep #$20

  phx
  phy

  ldx wR1
  ldy #size(structExpandedCharacterDataRAM)-1
  lda #$00

  -
  sta $0000,b,x
  inc x
  dec y
  bpl -

  ply
  plx
  plb
  plp
  rtl

rlUnknown8390AD ; 83/90AD

  .autsiz
  .databank ?

  jsl $848EC8
  rtl

rlCheckIfDeploymentSlotEnd ; 83/90B2

  .autsiz
  .databank ?

  asl a
  tax
  lda aDeploymentSlotTable,x
  bmi +

  clc
  rtl

  +
  sec
  rtl

rlCombineCharacterDataAndClassBases ; 83/90BE

  .autsiz
  .databank ?

  ; Adds class bases to an expanded character data
  ; struct, along with magic bonuses and maluses from statuses.
  ; Also caps the results at 20.

  ; Inputs:
  ; wR1: Short RAM pointer to expanded character data

  ; Outputs:
  ; None

  php
  phb

  sep #$20
  lda #`aClassDataBuffer
  pha
  plb

  .databank `aClassDataBuffer

  phx
  phy

  ldy wR1

  tdc
  sta structExpandedCharacterDataRAM.DeploymentSlot,b,y
  sta structExpandedCharacterDataRAM.DeploymentSlot+1,b,y

  lda structExpandedCharacterDataRAM.Class,b,y
  jsl rlCopyClassDataToBuffer

  lda aClassDataBuffer.Strength
  clc
  adc structExpandedCharacterDataRAM.Strength,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Strength,b,y

  lda aClassDataBuffer.Magic
  clc
  adc structExpandedCharacterDataRAM.Magic,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Magic,b,y

  lda aClassDataBuffer.Skill
  clc
  adc structExpandedCharacterDataRAM.Skill,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Skill,b,y

  lda aClassDataBuffer.Speed
  clc
  adc structExpandedCharacterDataRAM.Speed,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Speed,b,y

  lda aClassDataBuffer.Defense
  clc
  adc structExpandedCharacterDataRAM.Defense,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Defense,b,y

  lda aClassDataBuffer.Constitution
  clc
  adc structExpandedCharacterDataRAM.Constitution,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Constitution,b,y

  lda aClassDataBuffer.Movement
  clc
  adc structExpandedCharacterDataRAM.Movement,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Movement,b,y

  ldx wR1
  lda structExpandedCharacterDataRAM.TurnStatus,b,x
  bit #TurnStatusRescuing
  beq +

  jsl $83E448

  +
  lda structExpandedCharacterDataRAM.Status,b,x
  cmp #StatusSleep
  beq +

  cmp #StatusPetrify
  bne ++

  +
  jsl $83E4AC

  +
  lda structExpandedCharacterDataRAM.MagicBonus,b,x
  sta aItemStatBonusBuffer.Magic
  clc
  adc structExpandedCharacterDataRAM.Magic,b,x
  sta structExpandedCharacterDataRAM.Magic,b,x
  jsr rsCombineTerrainMagicBonus
  ply
  plx
  plb
  plp
  rtl

rsCombineTerrainMagicBonus ; 83/9179

  .autsiz
  .databank `aTerrainMap

  ; Gets the magic bonus of the tile that
  ; a unit is on.

  ; Inputs:
  ; X: Short RAM pointer to character data

  ; Outputs:
  ; None

  phx
  rep #$30

  ; Get tile index

  lda structExpandedCharacterDataRAM.X,b,x
  and #$00FF
  sta wR0

  lda structExpandedCharacterDataRAM.Y,b,x
  and #$00FF
  sta wR1

  jsl rlGetMapTileIndexByCoords

  ; Get terrain type at tile

  tax
  lda aTerrainMap,x
  and #$00FF

  ; Get the terrain magic bonus for that tile

  tax
  sep #$20
  lda aTerrainMagicTable,x
  sta wR0

  plx

  ; Add to bonus from item

  lda aItemStatBonusBuffer.Magic
  clc
  adc wR0
  sta aItemStatBonusBuffer.Magic

  ; Finally, add to the character's magic stat

  lda structExpandedCharacterDataRAM.Magic,b,x
  clc
  adc wR0
  sta structExpandedCharacterDataRAM.Magic,b,x

  rts

rlCombineCharacterDataAndClassWeaponRanks ; 83/91B4

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #`aClassDataBuffer
  pha
  rep #$20
  plb

  .databank `aClassDataBuffer

  phx
  phy

  ldy wR1

  lda #$0000
  sta structExpandedCharacterDataRAM.DeploymentSlot,b,y

  lda structExpandedCharacterDataRAM.Class,b,y
  jsl rlCopyClassDataToBuffer

  ldy wR1

  sep #$20
  lda aClassDataBuffer.SwordRank
  beq +

  clc
  adc structExpandedCharacterDataRAM.SwordRank,b,y
  bcc +

  lda #RankA

  +
  sta structExpandedCharacterDataRAM.SwordRank,b,y

  lda aClassDataBuffer.LanceRank
  beq +

  clc
  adc structExpandedCharacterDataRAM.LanceRank,b,y
  bcc +

  lda #RankA

  +
  sta structExpandedCharacterDataRAM.LanceRank,b,y

  lda aClassDataBuffer.AxeRank
  beq +

  clc
  adc structExpandedCharacterDataRAM.AxeRank,b,y
  bcc +

  lda #RankA

  +
  sta structExpandedCharacterDataRAM.AxeRank,b,y

  lda aClassDataBuffer.BowRank
  beq +

  clc
  adc structExpandedCharacterDataRAM.BowRank,b,y
  bcc +

  lda #RankA

  +
  sta structExpandedCharacterDataRAM.BowRank,b,y

  lda aClassDataBuffer.StaffRank
  beq +

  clc
  adc structExpandedCharacterDataRAM.StaffRank,b,y
  bcc +

  lda #RankA

  +
  sta structExpandedCharacterDataRAM.StaffRank,b,y

  lda aClassDataBuffer.FireRank
  beq +

  clc
  adc structExpandedCharacterDataRAM.FireRank,b,y
  bcc +

  lda #RankA

  +
  sta structExpandedCharacterDataRAM.FireRank,b,y

  lda aClassDataBuffer.ThunderRank
  beq +

  clc
  adc structExpandedCharacterDataRAM.ThunderRank,b,y
  bcc +

  lda #RankA

  +
  sta structExpandedCharacterDataRAM.ThunderRank,b,y

  lda aClassDataBuffer.WindRank
  beq +

  clc
  adc structExpandedCharacterDataRAM.WindRank,b,y
  bcc +

  lda #RankA

  +
  sta structExpandedCharacterDataRAM.WindRank,b,y

  lda aClassDataBuffer.LightRank
  beq +

  clc
  adc structExpandedCharacterDataRAM.LightRank,b,y
  bcc +

  lda #RankA

  +
  sta structExpandedCharacterDataRAM.LightRank,b,y

  lda aClassDataBuffer.DarkRank
  beq +

  clc
  adc structExpandedCharacterDataRAM.DarkRank,b,y
  bcc +

  lda #RankA

  +
  sta structExpandedCharacterDataRAM.DarkRank,b,y

  ply
  plx
  plb
  plp
  rtl

rlClampCharacterStats ; 83/9278

  .autsiz
  .databank ?

  phb
  php

  sep #$20
  lda #$7E
  pha
  plb

  .databank $7E

  lda structExpandedCharacterDataRAM.Strength,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Strength,b,y

  lda structExpandedCharacterDataRAM.Magic,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Magic,b,y

  lda structExpandedCharacterDataRAM.Skill,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Skill,b,y

  lda structExpandedCharacterDataRAM.Speed,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Speed,b,y

  lda structExpandedCharacterDataRAM.Defense,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Defense,b,y

  lda structExpandedCharacterDataRAM.Constitution,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Constitution,b,y

  lda structExpandedCharacterDataRAM.Movement,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Movement,b,y

  lda structExpandedCharacterDataRAM.Luck,b,y
  cmp #20
  blt +

  lda #20

  +
  sta structExpandedCharacterDataRAM.Luck,b,y

  plp
  plb
  rtl

rlStoreAvailableDeploymentSlotToCharacterData ; 83/92E3

  .autsiz
  .databank ?

  ; Given a short RAM pointer to expanded character data
  ; and a deployment number, store the next unoccupied slot
  ; and number of that allegiance to the character data

  ; Writes 0000 as the slot if there are no more remaining slots.

  ; Inputs:
  ; wR0: Deployment number to start at
  ; wR1: Short RAM pointer to expanded character data

  ; Outputs:
  ; None

  php
  phb

  sep #$20
  lda #`aPlayerUnits
  pha
  plb

  .databank `aPlayerUnits

  rep #$30

  -

  ; Grab the next deployment slot

  lda wR0
  asl a
  tax
  lda aDeploymentSlotTable,x

  ; Check if we're out of slots
  ; for this allegiance

  cmp #$FFFF
  beq _AllegianceEnd

  ; Else check if the slot is occupied

  tax
  lda structExpandedCharacterDataRAM.Character,b,x
  beq +

  ; If occupied, loop

  inc wR0
  bra -

  +

  ; If empty, store empty slot's number
  ; and slot to our source

  txy
  ldx wR1
  lda wR0
  sta structExpandedCharacterDataRAM.DeploymentNumber,b,x
  tya
  sta structExpandedCharacterDataRAM.DeploymentSlot,b,x
  bra +

  _AllegianceEnd
  ldx wR1
  stz structExpandedCharacterDataRAM.DeploymentSlot,b,x

  +
  plb
  plp
  rtl

rlGetItemNamePointer ; 83/931A

  .autsiz
  .databank ?

  ; Given item in aItemDataBuffer, return pointer
  ; to item name in lR18

  ; Inputs:
  ; aItemDataBuffer: item

  ; Outputs:
  ; lR18: Long pointer to item name

  php
  rep #$30
  phx

  lda #>`ItemNames
  sta lR18+1

  lda aItemDataBuffer.BaseWeapon,b
  and #$00FF
  asl a
  tax
  lda ItemNames.aItemNamePointerTable,x
  sta lR18

  plx
  plp
  rtl

rlGetCharacterNamePointer ; 83/9334

  .autsiz
  .databank ?

  ; Given character ID in A, return long pointer
  ; to character name in lR18

  ; Inputs:
  ; A: Character ID

  ; Outputs:
  ; lR18: Long pointer to character name

  php
  rep #$30
  phx
  phy
  pha

  lda #<>CharacterNames
  sta lR18
  lda #>`CharacterNames
  sta lR18+1
  pla
  asl a
  tax
  lda CharacterNames.aCharacterNamePointers,x
  sta lR18
  ply
  plx
  plp
  rtl

rlGetClassNamePointer ; 83/9351

  .autsiz
  .databank ?

  ; Given class ID in A, return long pointer
  ; to class name in lR18

  ; Inputs:
  ; A: Class ID

  ; Outputs:
  ; lR18: Long pointer to class name

  php
  rep #$30
  pha
  lda #<>ClassNames
  sta lR18
  lda #>`ClassNames
  sta lR18+1
  pla
  and #$00FF
  asl a
  tax
  lda ClassNames.aClassNamePointers,x
  sta lR18
  plp
  rtl

rlGetWeaponRankTextPointer ; 83/936D

  .al
  .autsiz

  ; Given a weapon rank in A, a pointer to
  ; that weapon rank's text

  ; Inputs:
  ; A: Weapon rank

  ; Outputs:
  ; lR18: Long pointer to rank text

  ; If rank is showable, skip this step

  cmp #50
  bge +

  ; Else check if unit is mounted and has
  ; this weapon type as a dismounted rank

  ldy wR16
  beq +

  ; If they don't have it as an alternate rank
  ; or don't have a level in it, return a space

  lda #<>menutextRankNone
  sta lR18
  lda #>`menutextRankNone
  sta lR18+1
  rtl

  .include "../TEXT/WEAPONRANKS/None.asm"

  +

  ; Else check if the rank in negative
  ; which indicates a star

  php
  rep #$30
  ora #$0000
  bmi +

  ; Otherwise we divide by WeaponRankIncrement
  ; to get the appropriate level

  and #$00FF
  sta wR13
  lda #WeaponRankIncrement
  sta wR14
  jsl rlUnsignedDivide16By8

  lda wR13
  asl a
  tax
  lda #>`WeaponRankText
  sta lR18+1
  lda WeaponRankText.aRankTextPointers,x
  sta lR18
  plp
  rtl

  WeaponRankText .block ; 83/93AC

    aRankTextPointers ; 83/93AC
      .addr menutextRankDash
      .addr menutextRankE
      .addr menutextRankD
      .addr menutextRankC
      .addr menutextRankB
      .addr menutextRankA

    .include "../TEXT/WEAPONRANKS/Dash.asm"
    .include "../TEXT/WEAPONRANKS/E.asm"
    .include "../TEXT/WEAPONRANKS/D.asm"
    .include "../TEXT/WEAPONRANKS/C.asm"
    .include "../TEXT/WEAPONRANKS/B.asm"
    .include "../TEXT/WEAPONRANKS/A.asm"

    .include "../TEXT/WEAPONRANKS/Star.asm"

  .bend

  +
  lda #<>WeaponRankText.menutextRankStar
  sta lR18
  lda #>`WeaponRankText.menutextRankStar
  sta lR18+1
  plp
  rtl

rlCopyClassDataToBuffer ; 83/93E0

  .autsiz
  .databank ?

  ; Given class ID in A, write class
  ; data to aClassDataBuffer

  ; Inputs:
  ; A: Class ID

  ; Outputs:
  ; None

  php
  phb
  rep #$30
  phx
  phy

  and #$00FF
  dec a
  sta wR10
  lda #size(structClassDataEntry)
  sta wR11
  jsl rlUnsignedMultiply16By16
  lda wR12
  clc
  adc #<>aClassData
  tax

  ldy #<>aClassDataBuffer
  lda #size(structClassDataEntry)-1
  mvn #`aClassData,#`aClassDataBuffer

  ply
  plx
  plb
  plp
  rtl

rlGetClassDataOffset ; 83/940A

  .autsiz
  .databank ?

  ; Given a class ID in A
  ; return the class' offset in
  ; aClassData in wR12

  ; Inputs:
  ; A: Class ID

  ; Outputs:
  ; wR12: Offset in aClassData

  and #$00FF
  dec a
  sta wR10
  lda #size(structClassDataEntry)
  sta wR11
  jsl rlUnsignedMultiply16By16
  rtl

rlCopyCharacterDataToBuffer ; 83/941A

  .autsiz
  .databank ?

  ; Given character ID in A, write character
  ; data to aCharacterDataBuffer

  ; Inputs:
  ; A: Character ID

  ; Outputs:
  ; None

  php
  phb
  rep #$30
  phx
  phy

  dec a
  sta wR10
  lda #size(structCharacterDataROMEntry)
  sta wR11
  jsl rlUnsignedMultiply16By16
  lda wR12
  clc
  adc #<>aCharacterData
  tax

  ldy #<>aCharacterDataBuffer
  lda #size(structCharacterDataROMEntry)-1
  mvn #`aCharacterData,#`aCharacterDataBuffer

  ply
  plx
  plb
  plp
  rtl

rlWriteUNITEntryToBuffer ; 83/9441

  .autsiz
  .databank ?

  ; Given a long pointer to a UNIT entry
  ; in lR18, write that entry to a buffer

  ; Inputs:
  ; lR18: long pointer to UNIT entry

  ; Outputs:
  ; None

  php
  phb

  sep #$20
  lda #`aUNITEntryBuffer
  pha
  plb

  .databank `aUNITEntryBuffer

  ldy #size(structUNITEntry)-1

  -
  lda [lR18],y
  sta aUNITEntryBuffer,y
  dec y
  bpl -

  plb
  plp
  rtl

rlWriteUNITGroupData ; 83/9457

  .autsiz
  .databank ?

  ; Given a number of units to load in A and
  ; a long pointer to their UNIT group in lR18
  ; write their data to RAM

  ; Inputs:
  ; A: Unit count
  ; lR18: UNIT group long pointer

  ; Outputs:
  ; Carry clear on full success
  ; Carry set if not enough deployment slots

  php
  phb

  tax

  sep #$20
  lda #`lUnitGroupLoadingPointer
  pha
  rep #$20
  plb

  .databank `lUnitGroupLoadingPointer

  stx wUnitGroupLoadingCount

  lda lR18
  sta lUnitGroupLoadingPointer
  lda lR18+1
  sta lUnitGroupLoadingPointer+1

  _Loop
  lda lUnitGroupLoadingPointer
  sta lR18
  lda lUnitGroupLoadingPointer+1
  sta lR18+1
  jsl rlWriteUNITEntryToBuffer

  lda aUNITEntryBuffer.Character
  beq _False

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlClearExpandedCharacterData

  lda aUNITEntryBuffer.Allegiance
  and #Player | Enemy | NPC
  inc a
  sta wR0

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlStoreAvailableDeploymentSlotToCharacterData

  lda aSelectedCharacterBuffer.DeploymentSlot,b
  beq _True

  jsr rsUNITGroupCopyUnitIdentity

  lda aSelectedCharacterBuffer.Character,b
  jsl rlCopyCharacterDataToBuffer

  lda aCharacterDataBuffer.Class
  jsl rlCopyClassDataToBuffer

  jsr rsUNITGroupCopyUnitMiscStats
  jsr rsUNITGroupCreateUnitItems
  jsr rsUNITGroupCopyUnitSkills
  lda aCharacterDataBuffer.HPOrAutolevel
  bit #$0080
  bne +

  jsr rsUNITGroupCopyUnitCoreStats
  bra ++

  +
  jsl $83A970

  +
  jsr rsUNITGroupSetTurnStatusIfUnderRoof
  jsr rsUnknown83964B
  lda lUnitGroupLoadingPointer
  clc
  adc #size(structUNITEntry)
  sta lUnitGroupLoadingPointer
  dec wUnitGroupLoadingCount
  bne _Loop

  _False
  plb
  plp
  clc
  rtl

  _True
  plb
  plp
  sec
  rtl

rsUNITGroupCopyUnitMiscStats ; 83/94EA

  .autsiz
  .databank `lUnitGroupLoadingPointer

  sep #$20

  lda aCharacterDataBuffer.Class
  sta aSelectedCharacterBuffer.Class,b

  lda aCharacterDataBuffer.MapSprite
  sta aSelectedCharacterBuffer.SpriteInfo1,b

  lda aCharacterDataBuffer.MovementStars
  sta aSelectedCharacterBuffer.MovementStars,b

  lda aCharacterDataBuffer.LeadershipStars
  sta aSelectedCharacterBuffer.LeadershipStars,b

  rep #$30
  rts

rsUNITGroupCopyUnitCoreStats ; 83/9507

  .autsiz
  .databank `lUnitGroupLoadingPointer

  php
  sep #$20

  lda aCharacterDataBuffer.Strength
  sta aSelectedCharacterBuffer.Strength,b

  lda aCharacterDataBuffer.Magic
  sta aSelectedCharacterBuffer.Magic,b

  lda aCharacterDataBuffer.Skill
  sta aSelectedCharacterBuffer.Skill,b

  lda aCharacterDataBuffer.Speed
  sta aSelectedCharacterBuffer.Speed,b

  lda aCharacterDataBuffer.Defense
  sta aSelectedCharacterBuffer.Defense,b

  lda aCharacterDataBuffer.Constitution
  sta aSelectedCharacterBuffer.Constitution,b

  lda aCharacterDataBuffer.Luck
  sta aSelectedCharacterBuffer.Luck,b

  lda aCharacterDataBuffer.Movement
  sta aSelectedCharacterBuffer.Movement,b

  lda aClassDataBuffer.HP
  clc
  adc aCharacterDataBuffer.HPOrAutolevel
  blt +

  lda #250

  +
  sta aSelectedCharacterBuffer.CurrentHP,b

  lda aCharacterDataBuffer.SwordRank
  sta aSelectedCharacterBuffer.SwordRank,b

  lda aCharacterDataBuffer.LanceRank
  sta aSelectedCharacterBuffer.LanceRank,b

  lda aCharacterDataBuffer.AxeRank
  sta aSelectedCharacterBuffer.AxeRank,b

  lda aCharacterDataBuffer.BowRank
  sta aSelectedCharacterBuffer.BowRank,b

  lda aCharacterDataBuffer.StaffRank
  sta aSelectedCharacterBuffer.StaffRank,b

  lda aCharacterDataBuffer.FireRank
  sta aSelectedCharacterBuffer.FireRank,b

  lda aCharacterDataBuffer.ThunderRank
  sta aSelectedCharacterBuffer.ThunderRank,b

  lda aCharacterDataBuffer.WindRank
  sta aSelectedCharacterBuffer.WindRank,b

  lda aCharacterDataBuffer.LightRank
  sta aSelectedCharacterBuffer.LightRank,b

  lda aCharacterDataBuffer.DarkRank
  sta aSelectedCharacterBuffer.DarkRank,b

  lda aSelectedCharacterBuffer.CurrentHP,b
  sta aSelectedCharacterBuffer.MaxHP,b

  plp
  rts

rsUNITGroupCreateUnitItems ; 83/958C

  .al
  .autsiz
  .databank `lUnitGroupLoadingPointer

  stz wUnitGroupLoadingInventoryIndex

  -
  ldx wUnitGroupLoadingInventoryIndex
  lda aUNITEntryBuffer.Items,x
  and #$00FF
  beq +

  ora #$FE00
  jsl rlCopyItemDataToBuffer

  nop
  nop
  sep #$20

  lda aItemDataBuffer.Durability,b
  xba
  lda aItemDataBuffer.DisplayedWeapon,b
  rep #$30
  sta wR0

  lda wUnitGroupLoadingInventoryIndex
  asl a
  tax

  lda wR0
  sta aSelectedCharacterBuffer.Items,b,x

  +
  inc wUnitGroupLoadingInventoryIndex
  lda wUnitGroupLoadingInventoryIndex
  cmp #size(structExpandedCharacterDataRAM.Items)/2
  bne -

  rts

rsUNITGroupCopyUnitSkills ; 83/95C6

  .autsiz
  .databank `lUnitGroupLoadingPointer

  sep #$20
  lda aCharacterDataBuffer.Skills1
  ora aClassDataBuffer.Skills1
  sta aSelectedCharacterBuffer.Skills1,b
  rep #$30
  lda aCharacterDataBuffer.Skills2
  ora aClassDataBuffer.Skills2
  sta aSelectedCharacterBuffer.Skills2,b
  rts

rsUNITGroupCopyUnitIdentity ; 83/95DD

  .autsiz
  .databank `lUnitGroupLoadingPointer

  ; Names are hard.

  rep #$30
  lda aUNITEntryBuffer.Character
  sta aSelectedCharacterBuffer.Character,b

  lda aUNITEntryBuffer.MoveX
  sta aSelectedCharacterBuffer.X,b

  lda aUNITEntryBuffer.Leader
  sta aSelectedCharacterBuffer.Leader,b

  sep #$20

  lda aUNITEntryBuffer.AI1
  sta aSelectedCharacterBuffer.AI1,b

  lda aUNITEntryBuffer.AI2
  sta aSelectedCharacterBuffer.AI2,b

  lda aUNITEntryBuffer.AI3
  sta aSelectedCharacterBuffer.AI3,b

  lda aUNITEntryBuffer.AI4
  sta aSelectedCharacterBuffer.Unknown3F,b

  lda aUNITEntryBuffer.BossFlag
  bpl +

  and #~$80
  pha
  ldx aSelectedCharacterBuffer.Character,b
  stx wChapterBoss,b
  pla

  +
  sta aSelectedCharacterBuffer.Level,b

  rep #$30
  rts

rsUNITGroupSetTurnStatusIfUnderRoof ; 83/9620

  .autsiz
  .databank `lUnitGroupLoadingPointer

  lda aSelectedCharacterBuffer.X,b
  and #$00FF
  sta wR0

  lda aSelectedCharacterBuffer.Y,b
  and #$00FF
  sta wR1

  jsl rlGetMapTileIndexByCoords
  tax
  lda aTerrainMap,x
  and #$00FF
  cmp #TerrainUnknown3
  beq +

  rts

  +
  lda aSelectedCharacterBuffer.TurnStatus,b
  ora #TurnStatusActing | TurnStatusUnknown2
  sta aSelectedCharacterBuffer.TurnStatus,b
  rts

rsUnknown83964B ; 83/964B

  .al
  .autsiz
  .databank ?

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $848E5A

  lda #aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer
  rts

rlCheckItemEquippable ; 83/965E

  .autsiz
  .databank ?

  ; Checks if a unit can equip an item.

  ; Inputs:
  ; wR1: Short RAM pointer to structExpandedCharacterDataRAM
  ; aItemDataBuffer: Item to check

  ; Outputs:
  ; Carry set if item equippable else unset

  php
  phb

  sep #$20
  lda #`aClassDataBuffer
  pha
  rep #$20
  plb

  .databank `aClassDataBuffer

  phx
  phy

  ; Keep track of character for later

  lda wR1
  pha

  ; If item is a tome or staff, check if unit is silenced

  lda aItemDataBuffer.Traits,b
  bit #TraitTome | TraitStaff
  beq +

  ldy #structExpandedCharacterDataRAM.Status
  lda (wR1),y
  and #$00FF
  cmp #StatusSilence
  beq _False

  +

  ; Get the weapon rank and see if it's
  ; actually a weapon lock

  lda aItemDataBuffer.WeaponRank,b
  bpl +

  ; It's a lock

  ; Before checking the lock, we see
  ; if unit's class is even able to use weapons
  ; of this type

  ldy #structExpandedCharacterDataRAM.Class
  lda (wR1),y
  jsl rlCopyClassDataToBuffer

  lda aItemDataBuffer.Type,b
  and #$000F
  tay
  lda aClassDataBuffer.WeaponRanks,y
  and #$00FF
  beq _False

  ; Grab character ID to check against
  ; and get short pointer to lock in X

  ldx aItemDataBuffer.WeaponRank,b

  lda (wR1)
  sta wR1

  -

  ;Loop through lock list until
  ; we find a terminator or the unit

  lda WeaponLocks&$FF0000,x
  beq _False

  cmp wR1
  beq _True

  inc x
  inc x
  bra -

  +

  ; Weapon rank wasn't a lock

  ; All items are 'equippable' even
  ; if not usable?

  lda aItemDataBuffer.Type,b
  and #$000F
  cmp #TypeItem
  beq _True

  ; Otherwise we check to see if unit's
  ; class can use weapons of this type

  pha
  ldy #structExpandedCharacterDataRAM.Class
  lda (wR1),y
  jsl rlGetClassDataOffset

  pla
  tay
  clc
  adc #structClassDataEntry.WeaponRanks
  clc
  adc wR12
  tax
  lda aClassData,x
  and #$00FF
  beq _False

  ; If the class can, add class' base weapon
  ; rank to unit's and check if that's
  ; greater than or equal to the required weapon
  ; rank

  pha
  tya
  clc
  adc #structExpandedCharacterDataRAM.WeaponRanks
  tay
  lda (wR1),y
  and #$00FF
  sta wR1
  pla
  clc
  adc wR1
  cmp aItemDataBuffer.WeaponRank,b
  bge _True

  _False
  pla
  sta wR1
  ply
  plx
  plb
  plp
  clc
  rtl

  _True
  pla
  sta wR1
  ply
  plx
  plb
  plp
  sec
  rtl

rlGetEquippableItemInventoryOffset ; 83/9705

  .autsiz
  .databank ?

  ; Given a short pointer to character data in wR1
  ; return offset of first equippable item in wR1.
  ; Returns 7 * 2 with a null item in aItemDataBuffer
  ; if no item equippable

  ; Inputs:
  ; wR1: short pointer to character data

  ; Outputs:
  ; wR1: Offset in inventory of equippable item
  ; aItemDataBuffer: should contain equippable item's data

  php
  rep #$30
  phy

  ldy #size(structExpandedCharacterDataRAM.Items)/2

  ; Start at the unit's items

  lda wR1
  clc
  adc #structExpandedCharacterDataRAM.Items
  sta wR0

  stz wR2

  _Loop

  ; For all item slots in inventory,
  ; Grab item, check if equippable weapon

  lda (wR0)
  inc wR0
  inc wR0
  dec y
  bmi _NoEquippable

  jsl rlCopyItemDataToBuffer
  lda aItemDataBuffer.Traits,b
  bit #TraitWeapon
  beq _Next

  jsl rlCheckItemEquippable
  bcs _Equippable

  _Next
  inc wR2
  inc wR2
  bra _Loop

  _NoEquippable

  ; If we reach the end of the inventory without
  ; finding an equippable item, return 7 * 2
  ; and a null item in aItemDataBuffer

  lda #NoneItem
  jsl rlCopyItemDataToBuffer

  _Equippable
  lda wR2
  sta wR1
  ply
  plp
  rtl

rlCheckStealableWeightAgainstCon ; 83/9745

  .al
  .autsiz
  .databank `aActionStructUnit2

  ; Given a short pointer to character data of thief
  ; in wR1 and target item in aItemDataBuffer,
  ; return carry set if light enough to steal

  ; Inputs:
  ; wR1: Short RAM pointer to thief's character data
  ; aItemDataBuffer: Target item

  ; Outputs:
  ; Carry set if stealable else unset

  php

  lda wR1
  sta wR0

  lda #<>aActionStructUnit2
  sta wR1
  jsl rlCopyExpandedCharacterDataBufferToBuffer

  lda #<>aActionStructUnit2
  sta wR1
  jsl rlCombineCharacterDataAndClassBases

  sep #$20

  lda aActionStructUnit2.Constitution
  cmp aItemDataBuffer.Weight,b
  beq _False
  bge _True

  _False
  plp
  clc
  rtl

  _True
  plp
  sec
  rtl

rlSearchForUnitAndWriteTargetToBuffer ; 83/976E

  .autsiz
  .databank ?

  php

  rep #$30

  phx
  phy

  ; Flag for success?
  ; 0 if successful?

  lda #$0001
  sta wR17

  ; Character ID to look for

  lda wR0
  sta wR2

  ; Buffer to copy unit into?

  lda wR1
  sta wR3

  ; Do search?

  lda #<>rlWriteCharToBufferIfSearchTarget
  sta lR25
  lda #>`rlWriteCharToBufferIfSearchTarget
  sta lR25+1
  jsl rlRunRoutineForAllUnits

  lda wR17

  ply
  plx
  plp
  rtl

rlWriteCharToBufferIfSearchTarget ; 83/9794

  .al
  .autsiz
  .databank ?

  ; Check if character is who
  ; we're looking for

  lda aTargetingCharacterBuffer.Character,b
  cmp wR2
  bne +

  ; If they are, write char to
  ; target buffer

  lda #<>aTargetingCharacterBuffer
  sta wR0

  lda wR3
  sta wR1
  jsl rlCopyExpandedCharacterDataBufferToBuffer

  ; Mark success

  stz wR17

  +
  rtl

rlCheckIfWeaponEffective ; 83/97AB

  .autsiz
  .databank ?

  ; Given an item in aItemDataBuffer and
  ; a pointer to the target's character data
  ; in wR1 return carry set if weapon's
  ; effective against their class

  ; Inputs:
  ; A: Attack range
  ; wR1: pointer to target
  ; aItemDataBuffer: weapon data

  ; Outputs:
  ; Carry set if effective else clear

  php
  phx
  phy
  phb

  sep #$20
  pha

  lda #`aActionStructUnit2
  pha
  plb

  .databank `aActionStructUnit2

  pla
  tax

  rep #$30

  ; Check if weapon casts magic
  ; at range

  lda aItemDataBuffer.Traits,b
  bit #TraitMagicRanged
  beq +

  ; Grab range and if range-1 = 0
  ; weapon is not effective

  txa
  and #$00FF
  dec a
  beq _False

  +

  ; Loop through effectiveness

  sep #$20
  ldy #structExpandedCharacterDataRAM.Class
  ldx aItemDataBuffer.Effectiveness,b

  -
  lda ItemEffectivenesses&$FF0000,x
  beq _False

  inc x
  cmp (wR1),y
  bne -

  plb
  ply
  plx
  plp
  sec
  rtl

  _False
  plb
  ply
  plx
  plp
  clc
  rtl

rlUnknown8397E8 ; 83/97E8

  .autsiz
  .databank ?

  php
  rep #$30
  phx
  pha

  lda $7E4FA6

  -
  bmi -

  cmp #$0010

  -
  bge -

  tax
  pla
  sta $7E4FA8,x
  inc x
  inc x
  txa
  sta $7E4FA6
  plx
  plp
  rtl

rlUnknown839808 ; 83/9808

  .autsiz
  .databank ?

  php
  rep #$30
  phx
  lda $7E4FA6

  -
  beq -

  -
  bmi -

  tax
  dec x
  dec x
  lda $7E4FA8,x
  pha
  txa
  sta $7E4FA6
  pla
  plx
  plp
  rtl

rlRunRoutineForAllUnitsInAllegiance ; 83/9825

  .xl
  .autsiz
  .databank ?

  ; Starting with the deployment slot
  ; in A, runs the routine pointed to by
  ; lR25 for each occupied deployment slot
  ; of an allegiance that the first slot is a
  ; member of.

  ; Inputs:
  ; A: deployment number to start at
  ; lR25: long pointer to routine

  php
  phb
  pha

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  pla
  asl a
  tax

  _Loop
  lda aDeploymentSlotTable,x
  beq _Next

  cmp #$FFFF
  beq _End

  tay
  lda $0000,b,y
  beq _Next

  txa
  lsr a
  sta wR0
  lda #<>aTargetingCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber
  phx
  phk
  pea <>(+)-1
  jmp [lR25]

  +
  plx

  _Next
  inc x
  inc x
  bra _Loop

  _End
  plb
  plp
  rtl

rlRunRoutineForAllUnits ; 83/9861

  .al
  .autsiz
  .databank ?

  ; Runs a routine with a character as an input
  ; for all units

  ; Inputs:
  ; A: deployment number to start at
  ; lR25: long pointer to routine

  lda #Player + 1
  jsl rlRunRoutineForAllUnitsInAllegiance
  lda #Enemy + 1
  jsl rlRunRoutineForAllUnitsInAllegiance
  lda #NPC + 1
  jsl rlRunRoutineForAllUnitsInAllegiance
  rtl

rlUnknown839877 ; 83/9877

  .al
  .autsiz
  .databank ?

  lda #Player + 1
  jsl $83B34F
  bcs +

  jsl rlRunRoutineForAllUnitsInAllegiance

  +
  lda #Enemy + 1
  jsl $83B34F
  bcs +

  jsl rlRunRoutineForAllUnitsInAllegiance

  +
  lda #NPC + 1
  jsl $83B34F
  bcs +

  jsl rlRunRoutineForAllUnitsInAllegiance

  +
  rtl

rlUnknown83989F ; 83/989F

  .al
  .autsiz
  .databank ?

  lda #Player + 1
  jsl $83B34F
  bcc +

  jsl rlRunRoutineForAllUnitsInAllegiance

  +
  lda #Enemy + 1
  jsl $83B34F
  bcc +

  jsl rlRunRoutineForAllUnitsInAllegiance

  +
  lda #NPC + 1
  jsl $83B34F
  bcc +

  jsl rlRunRoutineForAllUnitsInAllegiance

  +
  rtl

rlRunRoutineForAllTilesInRange ; 83/98C7

  .xl
  .autsiz
  .databank `aRangeMap

  ; Given a long pointer to a routine in
  ; lR25, run that routine for all tiles
  ; reachable by a unit's filled range map

  ; Inputs:
  ; aRangeMap: filled by a unit
  ; lR25: long pointer to routine

  php
  sep #$20
  ldx wMapTileCount,b
  dec x

  _Loop
  lda aRangeMap,x
  bmi _Next

  phx
  phk
  pea <>(+)-1
  jmp [lR25]

  +
  plx

  _Next
  dec x
  bpl _Loop

  plp
  rtl

rlRunRoutineForAllTilesVisibleByPlayer ; 83/98E1

  .xl
  .autsiz
  .databank `aPlayerVisibleUnitMap

  ; Given a long pointer to a routine in
  ; lR25, run that routine for all tiles
  ; visible in the player's visibility map

  ; Inputs:
  ; aPlayerVisibleUnitMap: filled by player units
  ; lR25: long pointer to routine

  php
  sep #$20

  ldx #$0000

  _Loop
  lda aPlayerVisibleUnitMap,x
  beq _Next

  phx
  phk
  pea <>(+)-1
  jmp [lR25]

  +
  plx

  _Next
  inc x
  cpx wMapTileCount,b
  bne _Loop

  plp
  rtl

rlRunRoutineForAllVisibleUnitsInRange ; 83/98FD

  .xl
  .autsiz
  .databank `aPlayerVisibleUnitMap

  ; Given a long pointer to a routine in
  ; lR25, a long pointer to a visibility map in
  ; lR24, run routine for all units reachable
  ; by unit that filled aMovementMap

  ; Inputs:
  ; aMovementMap: filled by unit
  ; lR25: long pointer to routine
  ; lR24: long pointer to visibility map

  php
  sep #$20
  ldy wMapTileCount,b
  dec y

  _Loop
  lda aMovementMap,y
  beq _Next

  lda (lR24),y
  beq _Next

  phy
  phk
  pea <>(+)-1
  jmp [lR25]

  +
  ply

  _Next
  dec y
  bpl _Loop

  plp
  rtl

rlRunRoutineForAllPlayerVisibleUnitsInRange ; 83/991B

  .xl
  .autsiz
  .databank `aPlayerVisibleUnitMap

  ; Given a long pointer to a routine in
  ; lR25, run routine for all units reachable
  ; by unit that filled aMovementMap

  ; Inputs:
  ; aMovementMap: filled by unit
  ; aPlayerVisibleUnitMap: filled by player units
  ; lR25: long pointer to routine

  php
  sep #$20
  ldy #$0000

  _Loop
  lda aMovementMap,y
  beq _Next

  lda aPlayerVisibleUnitMap,y
  beq _Next

  phy
  phk
  pea <>(+)-1
  jmp [lR25]

  +
  ply

  _Next
  inc y
  cpy wMapTileCount,b
  bne _Loop

  plp
  rtl

rlRunRoutineForAllItemsInInventory ; 83/993C

  .autsiz
  .databank ?

  ; For all items in inventory pointed
  ; to by short pointer in A, run routine pointed
  ; to by lR25

  ; Inputs:
  ; A: Short pointer to inventory in character data
  ; lR25: long pointer to routine

  ; Outputs:
  ; None

  php
  rep #$30

  tax
  ldy #$0000

  -
  lda $0000,b,x
  beq _End

  phx
  phy
  ldx lR25
  phx
  ldx lR25+1
  phx
  phk
  pea <>(+)-1
  jmp [lR25]

  +
  plx
  stx lR25+1
  plx
  stx lR25
  ply
  plx

  inc x
  inc x
  inc y
  cpy #size(structExpandedCharacterDataRAM.Items)/2
  bne -

  _End
  plp
  rtl

rlRunRoutineForTilesIn1Range ; 83/9969

  .autsiz
  .databank ?

  php
  rep #$30
  lda #(`a1RangeShapeTable)<<8
  sta lR24+1
  lda #<>a1RangeShapeTable
  sta lR24
  jsr rsRunRoutineForAllTilesInShapeAroundTile
  plp
  rtl

a1RangeShapeTable ; 83/997B
  .char  0,  1
  .char -1,  0
  .char  0, -1
  .char  1,  0
  .word $1234

rlRunRoutineForTilesIn2Range ; 83/9985

  .autsiz
  .databank ?

  php
  rep #$30
  lda #(`a2RangeShapeTable)<<8
  sta lR24+1
  lda #<>a2RangeShapeTable
  sta lR24
  jsr rsRunRoutineForAllTilesInShapeAroundTile
  plp
  rtl

a2RangeShapeTable ; 83/9997
  .char  0,  2
  .char -1,  1
  .char -2,  0
  .char -1, -1
  .char  0, -2
  .char  1, -1
  .char  2,  0
  .char  1,  1
  .word $1234

rlRunRoutineForTilesIn1To2Range ; 83/99A9

  .autsiz
  .databank ?

  php
  rep #$30
  lda #(`a1To2RangeShapeTable)<<8
  sta lR24+1
  lda #<>a1To2RangeShapeTable
  sta lR24
  jsr rsRunRoutineForAllTilesInShapeAroundTile
  plp
  rtl

a1To2RangeShapeTable ; 83/99BB
  .char  0,  2
  .char -1,  1
  .char -2,  0
  .char -1,  0
  .char -1, -1
  .char  0, -2
  .char  0, -1
  .char  1, -1
  .char  1,  0
  .char  2,  0
  .char  1,  1
  .char  0,  1
  .word $1234

rsRunRoutineForAllTilesInShapeAroundTile ; 83/99D5

  .al
  .autsiz
  .databank ?

  ; Given a pointer to a shape array in lR24
  ; and a base tile index in X,
  ; run routine pointed to by lR25 for all tiles
  ; in shape

  ; Inputs:
  ; X: Base tile index
  ; lR24: long pointer to shape array
  ; lR25: long pointer to routine

  ; Outputs:
  ; None

  stx wR23

  _Loop

  ; Grab an entry and
  ; check for the end

  lda [lR24]
  cmp #$1234
  beq _End

  ; Y+2 * wMapRowSize

  xba
  inc a
  inc a
  and #$00FF
  sta wR10
  lda wMapRowSize,b
  sta wR11
  jsl rlUnsignedMultiply16By16

  ; result - (2 * wMapRowSize)
  ; Gives us the Y offset

  lda wR12
  sec
  sbc wMapRowSize,b
  sec
  sbc wMapRowSize,b
  sta wR12

  ; Next grab the X offset
  ; and expand s8 -> s16

  lda [lR24]
  and #$00FF
  cmp #$0080
  blt +

  ora #$FF00

  +

  ; Combine the X and Y offsets
  ; and add it to the original tile index
  clc
  adc wR12
  clc
  adc wR23
  tax
  phx
  lda wR23

  ; Save everything before running the routine

  pha
  lda lR24
  pha
  lda lR24+1
  pha
  lda lR25
  pha
  lda lR25+1
  pha
  phk
  pea <>(+)-1
  jmp [lR25]

  +
  pla
  sta lR25+1
  pla
  sta lR25
  pla
  sta lR24+1
  pla
  sta lR24
  pla
  sta wR23

  plx
  inc lR24
  inc lR24
  bra _Loop

  _End
  rts

rlUnknown839A3D ; 83/9A3D

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #`bUnknownTargetingDeploymentNumber
  pha
  rep #$20
  plb

  .databank `bUnknownTargetingDeploymentNumber

  ldy wR1

  lda structExpandedCharacterDataRAM.TurnStatus,b,y
  ora #TurnStatusActing
  sta structExpandedCharacterDataRAM.TurnStatus,b,y

  jsl rlCopyCharacterDataFromBuffer

  stz $7EA67F
  stz bUnknownTargetingDeploymentNumber
  stz $7E524E

  lda structExpandedCharacterDataRAM.TurnStatus,b,y
  and #~TurnStatusActing
  sta structExpandedCharacterDataRAM.TurnStatus,b,y

  lda structExpandedCharacterDataRAM.X,b,y
  and #$00FF
  sta wSelectedUnitXCoord,b

  lda structExpandedCharacterDataRAM.Y,b,y
  and #$00FF
  sta wSelectedUnitYCoord,b

  lda #<>aSelectedCharacterBuffer
  sta wR1

  jsl $83A89D
  jsl $8A8D9C

  jsl rlUpdateUnitMapsAndFog

  lda #%00000100
  sta wBGUpdateFlags

  plb
  plp
  rtl

rlUnknown839A94 ; 83/9A94

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #`bUnknownTargetingDeploymentNumber
  pha
  rep #$20
  plb

  .databank `bUnknownTargetingDeploymentNumber

  ldy wR1
  lda structExpandedCharacterDataRAM.TurnStatus,b,y
  ora #TurnStatusGrayed
  sta structExpandedCharacterDataRAM.TurnStatus,b,y
  jsr $839B08
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer
  jsl rlUpdateUnitMaps
  jsl $8A9013
  lda #<>aSelectedCharacterBuffer
  sta wR14
  jsl rlUnknown8387D5
  pha
  jsl $839C70
  jsl $83A5A4
  lda #<>aSelectedCharacterBuffer
  sta wR14
  jsl rlUnknown8387D5
  sta wR1
  pla
  sta wR0
  jsl $83A29B
  jsl rlUpdateVisibilityMap
  jsl rlUpdateUnitMapsAndFog
  lda aSelectedCharacterBuffer.DeploymentNumber,b
  sta wR0
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber
  jsl $839B37
  jsl $8885D1
  stz bUnknownTargetingDeploymentNumber
  stz wCapturingFlag
  plb
  plp
  rtl

rsSetUnitAsVisible ; 83/9B08

  .autsiz
  .databank `aVisibilityMap

  lda aSelectedCharacterBuffer.TurnStatus,b
  bit #TurnStatusUnselectable
  beq _End

  lda aSelectedCharacterBuffer.X,b
  and #$00FF
  sta wR0

  lda aSelectedCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords

  tax
  lda aVisibilityMap,x
  and #$00FF
  beq _End

  lda aSelectedCharacterBuffer.TurnStatus,b
  and #~TurnStatusUnselectable
  sta aSelectedCharacterBuffer.TurnStatus,b

  _End
  rts

rlUpdateRescuedUnitCoordinates ; 83/9B37

  .al
  .autsiz
  .databank ?

  ; Given a unit in aSelectedCharacterBuffer
  ; update the coordinates of whomever
  ; they're carrying, if any.

  ; Inputs:
  ; aSelectedCharacterBuffer: character data

  ; Outputs:
  ; None

  lda aSelectedCharacterBuffer.Rescue,b
  and #$00FF
  beq _End

  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aSelectedCharacterBuffer.Coordinates,b
  sta aBurstWindowCharacterBuffer.Coordinates,b

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  _End
  rtl

rlUpdateRescuedUnitCoordinatesByBuffer ; 83/9B37

  .al
  .autsiz
  .databank ?

  ; Given a pointer to a unit's character data in wR1
  ; update the coordinates of whomever they're
  ; carrying, if any

  ; Inputs:
  ; wR1: short pointer to character data

  ; Outputs:
  ; None

  ldy wR1
  lda structExpandedCharacterDataRAM.Rescue,b,y
  and #$00FF
  beq _End

  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda structExpandedCharacterDataRAM.Coordinates,b,y
  sta aBurstWindowCharacterBuffer.Coordinates,b

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  _End
  rtl

rlClearJoy1Unknown839B7F ; 83/9B7F

  .autsiz
  .databank ?

  stz wJoy1New
  stz wJoy1Alt
  rtl

rlClearJoypadDirectionalInputsWhileCursorScrolling ; 83/9B84

  .al
  .autsiz
  .databank ?

  lda wCursorXCoordPixelsScrolling,b
  ora wCursorYCoordPixelsScrolling,b
  and #$000F
  beq _End

  lda wJoy1New
  and #JoypadRight | JoypadLeft | JoypadDown | JoypadUp
  sta wJoy1New

  lda wJoy1Alt
  and #JoypadRight | JoypadLeft | JoypadDown | JoypadUp
  sta wJoy1Alt

  lda wJoy1Input
  and #JoypadRight | JoypadLeft | JoypadDown | JoypadUp
  sta wJoy1Input

  _End
  rtl

rlClearJoypadDirectionalInputsWhileMapScrolling ; 83/9BA5

  .al
  .autsiz
  .databank ?

  lda wMapScrollWidthPixels,b
  ora wMapScrollHeightPixels,b
  and #$000F
  beq +

  lda wJoy1New
  and #JoypadRight | JoypadLeft | JoypadDown | JoypadUp
  sta wJoy1New

  +
  rtl

rlUnknown839BB8 ; 83/9BB8

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  lda lR18
  pha
  lda lR18+1
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
  sta wR3

  jsl rlCopyTerrainMovementCostBuffer
  jsr rsUnknown839C1F

  lda #$FFFF
  sta wR4

  lda #$007F
  sta wR2

  jsl rlUnknown80DE00

  pla
  sta wR1
  pla
  sta wR0
  jsl rlUnknown80E451

  pla
  sta wR1
  pla
  sta wR0
  jsl $83A6BB

  pla
  sta lR18+1
  pla
  sta lR18

  sep #$20
  ldy #$0000

  -
  lda $7EA72D,y
  cmp #$0E
  bne +

  lda #$00

  +
  sta [lR18],y
  inc y
  ora #$00
  bne -

  plb
  plp
  rtl

rsUnknown839C1F ; 83/9C1F

  .xl
  .autsiz
  .databank ?

  .databank `aTerrainMovementCostBuffer

  sep #$20
  ldx #size(structTerrainEntry)-1

  -
  lda aTerrainMovementCostBuffer,x
  bmi +

  lda #$01
  sta aTerrainMovementCostBuffer,x

  +
  dec x
  bpl -

  rep #$30
  rts

rlPhaseChangeRefreshAllUnitsOfAllegiance ; 83/9C34

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  lda #<>rlPhaseChangeRefreshUnitEffect
  sta lR25
  lda #>`rlPhaseChangeRefreshUnitEffect
  sta lR25+1
  lda wCurrentPhase,b
  jsl rlRunRoutineForAllUnitsInAllegiance
  plb
  plp
  rtl

rlPhaseChangeRefreshUnitEffect ; 83/9C52

  .al
  .autsiz
  .databank ?

  ; We don't refresh petrified units

  lda aTargetingCharacterBuffer.Status,b
  and #$00FF
  cmp #StatusPetrify
  beq +

  lda aTargetingCharacterBuffer.TurnStatus,b
  and #~(TurnStatusGrayed | TurnStatusMovementStar)
  sta aTargetingCharacterBuffer.TurnStatus,b

  lda #<>aTargetingCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  +
  rtl

rlUnknown839C70 ; 83/9C70

  .al
  .autsiz
  .databank ?

  .databank `bUnknown7E4FCF

  lda bUnknown7E4FCF
  and #$00FF
  tax
  lda aUnknown839C84,x
  sta wR0
  pea <>(+)-1
  jmp (wR0)

  +
  rtl

aUnknown839C84 ; 83/9C84

  .addr rsUnknown839C9A
  .addr rsUnknown839C9B
  .addr rsUnknown839CA6
  .addr rsUnknown839CC1
  .addr rsUnknown839CCA
  .addr rsUnknown839CCE
  .addr rsUnknown839CD2
  .addr rsUnknown839CD3
  .addr rsUnknown839CDB
  .addr rsUnknown839CDF
  .addr rsUnknown839C9F

rsUnknown839C9A ; 83/9C9A

  .al
  .autsiz
  .databank ?

  rts

rsUnknown839C9B ; 83/9C9B

  .al
  .autsiz
  .databank ?

  jsl rlCheckIfGameOverDeath

rsUnknown839C9F ; 83/9C9F

  .al
  .autsiz
  .databank ?

  jsr rsUnknown839D02
  jsr rsDropRescuee

  rts

rsUnknown839CA6 ; 83/9CA6

  .al
  .autsiz
  .databank ?

  jsr $839F73
  jsr rsDropRescuee
  jsr rsUnknown839D68
  jsr rsSetMovementStarTurnStatus

  lda aSelectedCharacterBuffer.DeploymentNumber,b
  sta wR0
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber
  rts

rsUnknown839CC1 ; 83/9CC1

  .al
  .autsiz
  .databank ?

  jsr rsUnknown839E39
  bcc rsUnknown839C9A

  jsr rsDropRescuee
  rts

rsUnknown839CCA ; 83/9CCA

  .al
  .autsiz
  .databank ?

  jsr rsDropRescuee
  rts

rsUnknown839CCE ; 83/9CCE

  .al
  .autsiz
  .databank ?

  jsr $839FA6
  rts

rsUnknown839CD2 ; 83/9CD2

  .al
  .autsiz
  .databank ?

  rts

rsUnknown839CD3 ; 83/9CD3

  .al
  .autsiz
  .databank ?

  jsl rlCheckIfHeldGameOver
  jsr rsUnknown83A100
  rts

rsUnknown839CDB ; 83/9CDB

  .al
  .autsiz
  .databank ?

  jsr $83A182
  rts

rsUnknown839CDF ; 83/9CDF

  .al
  .autsiz
  .databank ?

  jsr $83A1C6
  jsr rsSetMovementStarTurnStatus
  bra rsUnknown839CA6

rsSetMovementStarTurnStatus ; 83/9CE7

  .al
  .autsiz
  .databank ?

  lda aSelectedCharacterBuffer.DeploymentNumber,b
  and #Player | Enemy | NPC
  beq +

  lda aSelectedCharacterBuffer.TurnStatus,b
  ora #TurnStatusMovementStar
  sta aSelectedCharacterBuffer.TurnStatus,b

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  +
  rts

rsUnknown839D02 ; 83/9D02

  .autsiz
  .databank `bUnknownTargetingDeploymentNumber

  php
  rep #$30
  lda bUnknownTargetingDeploymentNumber
  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aBurstWindowCharacterBuffer.TurnStatus,b
  ora #$0041
  sta aBurstWindowCharacterBuffer.TurnStatus,b

  lda aBurstWindowCharacterBuffer.DeploymentNumber,b
  and #Enemy | NPC
  bne +

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl $83A272

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer
  bra ++

  +
  jsl rlClearCharacterDataCharacter

  +
  lda aBurstWindowCharacterBuffer.X,b
  and #$00FF
  sta wR0

  lda aBurstWindowCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords

  tax
  sep #$20
  stz aTargetableUnitMap,x
  rep #$30
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  lda #124
  sta wR4
  jsl rlUnknown80E626
  plp
  rts

rsUnknown839D68 ; 83/9D68

  .autsiz
  .databank `bUnknownTargetingDeploymentNumber

  lda bUnknownTargetingDeploymentNumber
  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aSelectedCharacterBuffer.TurnStatus,b
  ora #TurnStatusRescuing
  sta aSelectedCharacterBuffer.TurnStatus,b

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl $83A899
  jsl $8A8D9C

  lda aBurstWindowCharacterBuffer.TurnStatus,b
  ora #TurnStatusActing
  sta aBurstWindowCharacterBuffer.TurnStatus,b

  sep #$20
  lda aSelectedCharacterBuffer.DeploymentNumber,b
  sta aBurstWindowCharacterBuffer.Rescue,b

  lda aBurstWindowCharacterBuffer.DeploymentNumber,b
  sta aSelectedCharacterBuffer.Rescue,b

  lda aBurstWindowCharacterBuffer.CurrentHP,b
  bne +

  inc aBurstWindowCharacterBuffer.CurrentHP,b

  +
  rep #$30
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  sep #$20
  lda aBurstWindowCharacterBuffer.X,b
  sta wR0
  lda aBurstWindowCharacterBuffer.Y,b
  sta wR1
  lda aSelectedCharacterBuffer.X,b
  sta wR2
  lda aSelectedCharacterBuffer.Y,b
  sta wR3
  jsl $879961

  rep #$30
  sta $7EA72D
  lda #<>$7EA72D
  sta lR18
  lda #>`$7EA72D
  sta lR18+1
  jsl $8A8FBC

  lda #<>rlSetRescuedTargetTurnStatus
  sta lUnknown7EA4EC
  lda #>`rlSetRescuedTargetTurnStatus
  sta lUnknown7EA4EC+1
  jsl rlUnknown83814A

  lda aBurstWindowCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aBurstWindowCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords
  tax
  sep #$20
  stz aTargetableUnitMap,x
  rep #$30
  rts

rlSetRescuedTargetTurnStatus ; 83/9E22

  .al
  .autsiz
  .databank ?

  lda aBurstWindowCharacterBuffer.TurnStatus,b
  ora #TurnStatusRescued
  sta aBurstWindowCharacterBuffer.TurnStatus,b

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  jsl $8885D1
  rtl

rsUnknown839E39 ; 83/9E39

  .al
  .autsiz
  .databank `bUnknownTargetingDeploymentNumber

  lda bUnknownTargetingDeploymentNumber
  sta wR0
  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber
  lda aUnknownActionStruct000F56.Skills1,b
  bit #Skill1Mount
  beq +

  lda aUnknownActionStruct000F56.Class,b
  and #$00FF
  jsl rlCheckIfClassCanDismount
  bcc +

  bra ++

  +
  clc
  rts

  +
  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl $879560

  lda aUnknownActionStruct000F56.X,b
  and #$00FF
  sta wR0
  lda aUnknownActionStruct000F56.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords

  tax
  sep #$20
  lda #$01
  sta aTargetableUnitMap,x

  rep #$20
  lda aUnknownActionStruct000F56.TurnStatus,b
  ora #TurnStatusMovementStar | TurnStatusMoved
  sta aUnknownActionStruct000F56.TurnStatus,b

  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl $848E5A

  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  sec
  rts

rsDropRescuee ; 83/9EA3

  .al
  .autsiz
  .databank `bUnknownTargetingDeploymentNumber

  ; Grab target and check if they were carrying someone

  lda bUnknownTargetingDeploymentNumber
  sta wR0
  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aUnknownActionStruct000F56.TurnStatus,b
  bit #TurnStatusRescuing
  bne +

  jmp _End

  +

  ; If they're actually on the map, get them off
  ; of that tile, because the dropped unit is going there

  bit #TurnStatusActing
  beq +

  lda aUnknownActionStruct000F56.X,b
  and #$00FF
  sta wR0
  lda aUnknownActionStruct000F56.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords

  tax
  sep #$20
  stz aPlayerVisibleUnitMap,x
  stz aUnitMap,x
  stz aTargetableUnitMap,x
  rep #$30

  +

  ; Drop the unit

  lda aUnknownActionStruct000F56.Rescue,b
  sta wR0
  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aUnknownActionStruct000F56.X,b
  and #$00FF
  sta wEventEngineUnknownXTarget

  lda aUnknownActionStruct000F56.Y,b
  and #$00FF
  sta wEventEngineUnknownYTarget

  lda aItemSkillCharacterBuffer.Class,b
  and #$00FF
  sta wR3
  jsl $83F131

  lda wUnknown7E4008
  and #$00FF
  cmp #$00FF
  bne +

  lda aItemSkillCharacterBuffer.Class,b
  and #$00FF
  sta wR3
  jsl $83F191

  lda wUnknown7E4008
  and #$00FF
  cmp #$00FF
  bne +

  -
  bra -

  +
  lda wUnknown7E400A
  jsl rlGetMapCoordsByTileIndex

  sep #$20
  lda wR0
  sta aItemSkillCharacterBuffer.X,b
  lda wR1
  sta aItemSkillCharacterBuffer.Y,b

  ; Clear that both are rescued/rescuing
  ; and who the rescuer/rescuee are

  stz aUnknownActionStruct000F56.Rescue,b
  stz aItemSkillCharacterBuffer.Rescue,b
  rep #$30

  lda aUnknownActionStruct000F56.TurnStatus,b
  and #~TurnStatusRescuing
  sta aUnknownActionStruct000F56.TurnStatus,b

  lda aItemSkillCharacterBuffer.TurnStatus,b
  and #~(TurnStatusRescued | TurnStatusActing)
  sta aItemSkillCharacterBuffer.TurnStatus,b

  ; Copy their updated data back

  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  _End
  rts

rsUnknown839F73 ; 83/9F73

  .al
  .autsiz
  .databank `bUnknownTargetingDeploymentNumber

  lda bUnknownTargetingDeploymentNumber
  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aBurstWindowCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aBurstWindowCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords

  tax
  sep #$20
  lda #$00
  sta aPlayerVisibleUnitMap,x
  sta aUnitMap,x
  sta aTargetableUnitMap,x
  rep #$30
  rts

rsUnknown839FA6 ; 83/9FA6

  .al
  .autsiz
  .databank `bUnknownTargetingDeploymentNumber

  lda bUnknownTargetingDeploymentNumber
  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aBurstWindowCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aBurstWindowCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords

  tax
  lda aTargetableUnitMap,x
  and #$00FF
  beq +

  jmp _Targetable

  +
  lda aBurstWindowCharacterBuffer.TurnStatus,b
  and #~TurnStatusRescued
  sta aBurstWindowCharacterBuffer.TurnStatus,b

  lda aBurstWindowCharacterBuffer.DeploymentNumber,b
  and #Enemy | NPC
  bne +

  lda aBurstWindowCharacterBuffer.TurnStatus,b
  ora #TurnStatusGrayed
  sta aBurstWindowCharacterBuffer.TurnStatus,b

  +
  lda aSelectedCharacterBuffer.TurnStatus,b
  and #~TurnStatusRescuing
  sta aSelectedCharacterBuffer.TurnStatus,b

  sep #$20
  stz aSelectedCharacterBuffer.Rescue,b
  stz aBurstWindowCharacterBuffer.Rescue,b

  lda aSelectedCharacterBuffer.X,b
  sta wR0
  lda aSelectedCharacterBuffer.Y,b
  sta wR1
  lda aBurstWindowCharacterBuffer.X,b
  sta wR2
  lda aBurstWindowCharacterBuffer.Y,b
  sta wR3
  jsl $879961

  rep #$30
  sta $7EA72D

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  lda aBurstWindowCharacterBuffer.Coordinates,b
  pha

  lda aSelectedCharacterBuffer.Coordinates,b
  sta aBurstWindowCharacterBuffer.Coordinates,b
  jsl $8A9013

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl $83A899
  jsl $8A8D9C

  lda #<>$7EA72D
  sta lR18
  lda #>`$7EA72D
  sta lR18+1
  jsl $8A8FBC

  pla
  sta aBurstWindowCharacterBuffer.Coordinates,b

  lda #<>$83A0C3
  sta lUnknown7EA4EC
  lda #>`$83A0C3
  sta lUnknown7EA4EC+1
  stz bUnknownTargetingDeploymentNumber
  jsl rlUnknown83814A
  rts

  _Targetable
  sep #$20
  lda #$0E
  sta $7EA72D
  lda aUnitMap,x
  sta $7EA72E
  lda #$00
  sta $7EA72F
  rep #$30

  lda aSelectedCharacterBuffer.X,b
  and #$00FF
  sta wR2
  lda aSelectedCharacterBuffer.Y,b
  and #$00FF
  sta wR3
  lda aBurstWindowCharacterBuffer.DeploymentNumber,b
  and #Player | Enemy | NPC
  sta wR0
  lda aBurstWindowCharacterBuffer.SpriteInfo1,b
  and #$00FF
  sta wR1
  lda #$0001
  sta wR4
  jsl $8A8D9C
  lda #<>$7EA72D
  sta lR18
  lda #>`$7EA72D
  sta lR18+1
  jsl $8A8FBC
  jsl $83E63C
  jsl rlUnknown83814A
  rts

rlUnknown83A0C3 ; 83/A0C3

  .al
  .autsiz
  .databank `aPlayerVisibleUnitMap

  lda aBurstWindowCharacterBuffer.TurnStatus,b
  and #~TurnStatusActing
  sta aBurstWindowCharacterBuffer.TurnStatus,b

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  lda aBurstWindowCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aBurstWindowCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords

  tax
  sep #$20
  lda aBurstWindowCharacterBuffer.DeploymentNumber,b
  sta aPlayerVisibleUnitMap,x
  sta aUnitMap,x

  rep #$30
  jsl rlUpdateVisibilityMap
  jsl rlUpdateUnitMapsAndFog
  rtl

rsUnknown83A100 ; 83/A100

  .al
  .autsiz
  .databank `bUnknownTargetingDeploymentNumber

  lda bUnknownTargetingDeploymentNumber
  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aBurstWindowCharacterBuffer.TurnStatus,b
  ora TurnStatusUnknown1 ; typo, should be #TurnStatusUnknown1 ?
  sta aBurstWindowCharacterBuffer.TurnStatus,b

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  lda aBurstWindowCharacterBuffer.Rescue,b
  and #$00FF
  beq +

  jsr rsUnknown83A131

  +
  lda aBurstWindowCharacterBuffer.DeploymentNumber,b
  jsr rsUnknown83A131
  rts

rsUnknown83A131 ; 83/A131

  .al
  .autsiz
  .databank `bUnknownTargetingDeploymentNumber

  sta wR0
  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  sep #$20
  lda #None
  sta aItemSkillCharacterBuffer.Rescue,b
  rep #$20

  lda aItemSkillCharacterBuffer.TurnStatus,b
  and #~(TurnStatusRescued | TurnStatusRescuing)
  ora #TurnStatusMovementStar | TurnStatusMoved
  sta aItemSkillCharacterBuffer.TurnStatus,b
  lda aItemSkillCharacterBuffer.DeploymentNumber,b
  bit #Enemy | NPC
  bne +

  lda aItemSkillCharacterBuffer.TurnStatus,b
  ora #TurnStatusActing | TurnStatusCaptured
  sta aItemSkillCharacterBuffer.TurnStatus,b

  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl $83A272

  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer
  rts

  +
  stz aItemSkillCharacterBuffer.Character,b
  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer
  rts

rsUnknown83A182 ; 83/A182

  .al
  .autsiz
  .databank `bUnknownTargetingDeploymentNumber

  lda bUnknownTargetingDeploymentNumber
  and #$00FF
  sta wR0
  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aItemSkillCharacterBuffer.Rescue,b
  and #$00FF
  beq +

  jsr rsUnknown83A1A8

  +
  lda aItemSkillCharacterBuffer.DeploymentNumber,b
  and #$00FF
  jsr rsUnknown83A1A8
  rts

rsUnknown83A1A8 ; 83/A1A8

  .al
  .autsiz
  .databank `bUnknownTargetingDeploymentNumber

  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aBurstWindowCharacterBuffer.TurnStatus,b
  ora #TurnStatusUnknown1 | TurnStatusActing
  sta aBurstWindowCharacterBuffer.TurnStatus,b

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer
  rts

rsUnknown83A1C6 ; 83/A1C6

  .al
  .autsiz
  .databank `aActionStructUnit1

  lda aSelectedCharacterBuffer.Character,b
  sta aActionStructUnit1.Character

  lda bUnknownTargetingDeploymentNumber
  sta wR0
  lda #<>aActionStructUnit2
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  sep #$20
  lda #1
  sta aActionStructUnit1.CurrentHP
  stz aActionStructUnit2.CurrentHP
  rep #$30
  jsl $83E6E5
  jsl $83E71B
  jsl rlUpdateSaveSlotLosses
  rts

rlCheckIfHeldGameOver ; 83/A1F3

  .al
  .autsiz
  .databank `bUnknownTargetingDeploymentNumber

  lda bUnknownTargetingDeploymentNumber
  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aBurstWindowCharacterBuffer.Rescue,b
  and #$00FF
  beq _End

  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  ldx aBurstWindowCharacterBuffer.Character,b
  lda #Chapter23
  cmp wCurrentChapter,b
  bne +

  cpx #CedChp23
  beq ++

  cpx #CedChp4x
  beq ++

  +
  cpx #Leif
  beq +

  bra _End

  +
  jsl rlPickGameOverEvents
  stz wUnknown000302,b

  _End
  rtl

rlCheckIfGameOverDeath ; 83/A238

  .al
  .autsiz
  .databank `bUnknownTargetingDeploymentNumber

  lda bUnknownTargetingDeploymentNumber
  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber
  ldx aBurstWindowCharacterBuffer.Character,b
  lda #Chapter23
  cmp wCurrentChapter,b
  bne +

  cpx #CedChp23
  beq ++

  cpx #CedChp4x
  beq ++

  +
  cpx #Leif
  beq +

  bra _End

  +
  lda aBurstWindowCharacterBuffer.CurrentHP,b
  and #$00FF
  bne _End

  jsl rlPickGameOverEvents
  stz wUnknown000302,b

  _End
  rtl

rlSetUnitCapturedTurnAndChapter ; 83/A272

  .autsiz
  .databank ?

  ; Given a short pointer to a unit
  ; in wR1, set their captured turn and chapter

  ; Inputs:
  ; wR1: short RAM pointer to unit

  ; Outputs:
  ; None

  php
  rep #$30

  ldy wR1
  lda wCurrentTurn,b
  sta structCharacterDataRAM.CapturedTurn,b,y

  sep #$20

  lda wCurrentChapter,b
  sta structCharacterDataRAM.CapturedChapter,b,y

  plp
  rtl

rlUnknown82A287 ; 83/A287

  .autsiz
  .databank `$7E4F9C

  bcc +

  lda $7E4F9C
  lsr a
  sta $7E4F9C

  +
  rtl

rlUnknown82A291 ; 83/A291

  .autsiz
  .databank `$7E4F9C

  bcc +

  lda $7E4F9C
  asl a
  sta $7E4F9C

  +
  rtl

rlUnknown82A29B ; 83/A29B

  .autsiz
  .databank ?

  lda wR0
  cmp wR1
  beq _End

  beq _A2A5

  bge _A2A8

  _A2A5
  blt _A2B2

  _End
  rtl

  _A2A8
  lda $7E4F9C
  lsr a
  sta $7E4F9C
  rtl

  _A2B2
  lda $7E4F9C
  asl a
  sta $7E4F9C
  rtl

rlUnknown83A2BC ; 83/A2BC

  .autsiz
  .databank ?

  php
  phb
  tax
  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  txa
  sta wR0
  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl rlSearchForUnitAndWriteTargetToBuffer

  sep #$20
  stz aUnknownActionStruct000F56.AI1,b
  stz aUnknownActionStruct000F56.AI2,b
  stz aUnknownActionStruct000F56.AI3,b
  stz aUnknownActionStruct000F56.AI4,b
  stz aUnknownActionStruct000F56.Unknown3E,b
  rep #$30
  stz aUnknownActionStruct000F56.Unknown3F,b

  ldx aUnknownActionStruct000F56.DeploymentSlot,b
  lda #$0000
  sta structCharacterDataRAM.Character,b,x

  lda #$0001
  sta wR0
  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl rlStoreAvailableDeploymentSlotToCharacterData

  ora #$0000

  -
  beq -

  sep #$20
  ldx #<>aUnknownActionStruct000F56
  jsr $83AF5F

  rep #$30
  lda aUnknownActionStruct000F56.Rescue,b
  and #$00FF
  beq +

  sta wR0
  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  sep #$20
  lda aUnknownActionStruct000F56.DeploymentNumber,b
  sta aItemSkillCharacterBuffer.Rescue,b
  rep #$20

  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  +
  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  jsl rlUpdateUnitMaps
  jsl rlUpdateVisibilityMap
  plb
  plp
  rtl

rlUnknown83A349 ; 83/A349

  .xl
  .autsiz
  .databank ?

  php
  phb
  tax

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  lda #NPC+1
  pha
  bra rlUnknown83A369

rlUnknown83A35A ; 83/A35A

  .xl
  .autsiz
  .databank ?

  php
  phb
  tax

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  lda #Enemy+1
  pha

rlUnknown83A369 ; 83/A369

  .al
  .xl
  .autsiz
  .databank $7E

  txa
  sta wR0
  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl rlSearchForUnitAndWriteTargetToBuffer

  sep #$20
  ldx #<>aUnknownActionStruct000F56
  jsr $83AF5F

  stz aUnknownActionStruct000F56.AI1,b
  stz aUnknownActionStruct000F56.AI2,b
  stz aUnknownActionStruct000F56.AI3,b
  stz aUnknownActionStruct000F56.AI4,b
  stz aUnknownActionStruct000F56.Unknown3E,b
  rep #$30
  stz aUnknownActionStruct000F56.Unknown3F,b

  ldx aUnknownActionStruct000F56.DeploymentSlot,b
  lda #$0000
  sta structCharacterDataRAM.Character,b,x

  pla
  sta wR0
  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl rlStoreAvailableDeploymentSlotToCharacterData

  ora #$0000

  -
  beq -

  lda #<>aUnknownActionStruct000F56
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  jsl rlUpdateUnitMaps
  jsl rlUpdateVisibilityMap
  plb
  plp
  rtl

rlUnknown83A3BF ; 83/A3BF

  .xl
  .autsiz
  .databank ?

  tax
  php
  phb
  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  txa
  inc a
  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlStoreAvailableDeploymentSlotToCharacterData

  ora #$0000

  -
  beq -

  lda aSelectedCharacterBuffer.DeploymentSlot,b
  pha

  lda aSelectedCharacterBuffer.TurnStatus,b
  and #~(TurnStatusActing | TurnStatusGrayed)
  sta aSelectedCharacterBuffer.TurnStatus,b

  lda aBurstWindowCharacterBuffer.DeploymentSlot,b
  sta aSelectedCharacterBuffer.DeploymentSlot,b

  sep #$20
  lda aBurstWindowCharacterBuffer.DeploymentNumber,b
  sta aSelectedCharacterBuffer.DeploymentNumber,b

  ldx #<>aSelectedCharacterBuffer
  jsr $83AF5F

  stz aSelectedCharacterBuffer.AI1,b
  stz aSelectedCharacterBuffer.AI2,b
  stz aSelectedCharacterBuffer.AI3,b
  stz aSelectedCharacterBuffer.AI4,b
  stz aSelectedCharacterBuffer.Unknown3E,b
  rep #$30
  stz aSelectedCharacterBuffer.Unknown3F,b
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  lda aSelectedCharacterBuffer.TurnStatus,b
  ora #TurnStatusMovementStar | TurnStatusMoved
  sta aSelectedCharacterBuffer.TurnStatus,b

  pla
  sta aSelectedCharacterBuffer.DeploymentSlot,b

  stz aSelectedCharacterBuffer.Character,b

  plb
  plp
  rtl

rlClearCharacterDataCharacter ; 83/A42D

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  ; Clear character

  lda #$0000
  sta (wR1)
  jsl rlCopyCharacterDataFromBuffer

  plb
  plp
  rtl

rlTryGiveCharacterItemFromBuffer ; 83/A443

  .autsiz
  .databank ?

  ; Given a short RAM pointer to a character in
  ; wR1 and an item in aItemDataBuffer, try
  ; placing the item in the unit's inventory.
  ; Returns carry clear on success or carry set
  ; if their inventory was full. Also returns the
  ; item ID/Durability in A.

  ; Inputs:
  ; wR1: Short RAM pointer to unit
  ; aItemDataBuffer: filled by item to give

  ; Outputs:
  ; A: Item ID and Durability
  ; Carry clear if successful else set

  php
  rep #$30
  phx
  phy

  lda wR1
  clc
  adc #structExpandedCharacterDataRAM.Items
  sta wR1

  jsr rsTryGetFreeInventorySlot
  bcs +

  sep #$20
  lda aItemDataBuffer.Durability,b
  xba
  lda aItemDataBuffer.DisplayedWeapon,b
  rep #$20
  sta (wR1),y

  ply
  plx
  plp
  clc
  rtl

  +
  sep #$20
  lda aItemDataBuffer.Durability,b
  xba
  lda aItemDataBuffer.DisplayedWeapon,b

  ply
  plx
  plp
  sec
  rtl

rsTryGetFreeInventorySlot ; 83/A475

  .al
  .xl
  .autsiz
  .databank ?

  ; Given a short pointer to a character's
  ; items in wR1 return the offset of the next
  ; free inventory slot in Y and carry clear.
  ; If the unit's inventory is full, return carry set

  ; Inputs:
  ; wR1: short RAM pointer to unit's items

  ; Outputs:
  ; Y: offset of next free inventory slot
  ; Carry set if full else clear

  ldy #$0000

  -
  lda (wR1),y
  beq +

  inc y
  inc y
  cpy #size(structExpandedCharacterDataRAM.Items)
  bne -

  sec
  rts

  +
  clc
  rts

rlClearInventorySlot ; 83/A487

  .autsiz
  .databank ?

  ; Given a short RAM pointer to a unit
  ; in wR1 and an offset in that unit's
  ; inventory of a slot to clear,
  ; clear that inventory slot and fill
  ; the gap created, if any

  ; Inputs:
  ; wR0: inventory slot offset
  ; wR1: short RAM pointer to unit

  php
  rep #$30

  lda wR0
  clc
  adc #structExpandedCharacterDataRAM.Items
  tay
  lda #$0000
  sta (wR1),y

  jsl rlFillInventoryHoles
  plp
  rtl

rlFillInventoryHoles ; 83/A49C

  .al
  .xl
  .autsiz
  .databank ?

  ; Given a short pointer to a unit
  ; in wR1, move up items to fill
  ; gaps in their inventory

  ; Inputs:
  ; wR1: Short RAM pointer to unit

  ; Outputs:
  ; None

  ; First we adjust the pointer to the
  ; start of their inventory and push
  ; a `stop looping` value before we
  ; prep the loop

  lda wR1
  clc
  adc #structExpandedCharacterDataRAM.Items
  sta wR1

  lda #-1
  pha

  ldy #size(structExpandedCharacterDataRAM.Items)-2

  ; From the bottom up, push all
  ; items in the inventory and ignore
  ; holes

  -
  lda (wR1),y
  beq _Hole

  pha
  lda #$0000
  sta (wR1),y

  _Hole
  dec y
  dec y
  bpl -

  ; Once we get to the top of the
  ; inventory, pop items and place them
  ; after the last until the `stop looping`
  ; value is found

  -
  pla
  cmp #-1
  beq +

  inc y
  inc y
  sta (wR1),y
  bra -

  +
  rtl

rlUnknown83A4C6 ; 83/A4C6

  .autsiz
  .databank ?

  php
  rep #$30

  stz lR18+1
  lda aItemDataBuffer.Cost,b
  sta lR18
  jsl $83A58A
  bcs _A4F3

  jsl rlTryGiveCharacterItemFromBuffer
  bcs _InventoryFull

  stz lR18+1
  lda aItemDataBuffer.Cost,b
  sta lR18
  jsl $83A568

  lda #$FFFF
  sta $7E4F96

  lda #$0000

  _End
  plp
  rtl

  _A4F3
  lda #$0001
  bra _End

  _InventoryFull
  lda #$0002
  bra _End

rlUnknown83A4FD ; 83/A4FD

  .autsiz
  .databank ?

  php
  rep #$30

  ldy wR1
  phy
  pha

  clc
  adc #structExpandedCharacterDataRAM.Items
  tay
  lda (wR1),y
  jsl rlCopyItemDataToBuffer

  stz lR18+1
  lda aItemDataBuffer.Cost,b
  lsr a
  sta lR18
  jsl $83A52E

  pla
  sta wR0

  pla
  sta wR1

  jsl rlClearInventorySlot

  lda #$FFFF
  sta $7E4F96

  plp
  rtl

rlAddToGold ; 83/A52E

  .autsiz
  .databank ?

  ; Given an amount of gold in lR18,
  ; add it to the player's gold total,
  ; capping at 999,999 gold

  ; Inputs:
  ; lR18: Amount to add

  ; Outputs:
  ; None

  php
  rep #$20

  ; Add gained gold to gold total

  lda lR18
  clc
  adc lGold
  sta lGold

  sep #$20
  lda lR18+2
  adc lGold+2
  sta lGold+2
  rep #$30

  ; If new total is greater
  ; than 999,999, cap it at that

  lda #<>999999
  sta lR18
  lda #>`999999
  sta lR18+1
  jsl $83A58A
  bcs +

  lda lR18
  sta lGold
  lda lR18+1
  sta lGold+1

  +
  plp
  rtl

rlSubtractFromGold ; 83/A568

  .autsiz
  .databank ?

  ; Given an amount of gold in lR18,
  ; subtract it from the player's gold total,
  ; returning carry set if the player has less
  ; gold than the amount

  ; Inputs:
  ; lR18: Amount to subtract

  ; Outputs:
  ; Carry set if amount was greater than gold else clear

  php
  rep #$20

  lda lGold
  sec
  sbc lR18
  sta lGold
  sep #$20
  lda lGold+2
  sbc lR18+2
  sta lGold+2
  bmi +

  plp
  clc
  rtl

  +
  plp
  sec
  rtl

rlCheckIfPlayerGoldLessThan ; 83/A58A

  .autsiz
  .databank ?

  ; Given a number in lR18, return
  ; carry set if number is greater
  ; than player gold

  ; Inputs:
  ; lR18: Number

  ; Outputs:
  ; Carry set if number greater than gold else unset

  php
  rep #$20
  lda lGold
  sec
  sbc lR18
  sep #$20
  lda lGold+2
  sbc lR18+2
  bmi +

  plp
  clc
  rtl

  +
  plp
  sec
  rtl

rlUnknown83A5A4 ; 83/A5A4

  .al
  .autsiz
  .databank ?

  jsl rlGetPhaseMusic
  ora #$0000
  beq +

  jsl rlTrySetAlliedDeathMusic

  +
  rtl

rlGetPhaseMusic ; 83/A5B2

  .al
  .databank ?

  php
  phb

  sep #$20
  lda #`aTemporaryEventFlags
  pha
  rep #$20
  plb

  .databank `aTemporaryEventFlags

  lda wCurrentTurn,b
  beq _End

  lda wCurrentPhase,b
  bne _A5E3

  lda aTemporaryEventFlags
  bit #FlagAlliedDeath
  beq _A5D3

  lda #$0006
  bra _End

  _A5D3
  jsl $8599B7
  cmp #$0006
  beq +

  bge _A5E3

  +
  lda #$0005
  bra _End

  _A5E3
  lda #$002B
  sta lR18

  lda wCurrentChapter,b
  jsl $848933

  lda wCurrentPhase,b
  jsl $83B296

  lda lR18,x
  and #$00FF

  _End
  plb
  plp
  rtl

rlTrySetAlliedDeathMusic ; 83/A5FE

  tax
  php
  phb

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  cpx wCurrentMapMusic,b
  beq +

  stx wCurrentMapMusic,b
  stx aUnknown0004BA,b

  +
  plb
  plp
  rtl

rlFillTargetableUnitMap ; 83/A617

  .autsiz
  .databank `aTargetableUnitMap

  php
  rep #$30
  lda #<>aTargetableUnitMap
  sta lR18
  lda #>`aTargetableUnitMap
  sta lR18+1
  lda #$0000
  jsl rlFillMapByWord

  lda #<>rlSetTargetableUnitTile
  sta lR25
  lda #>`rlSetTargetableUnitTile
  sta lR25+1
  lda #$0001
  sta wR17

  -
  lda wR17
  jsl $83B380
  bcc +

  lda wR17
  jsl rlRunRoutineForAllUnitsInAllegiance

  +
  lda wR17
  clc
  adc #$0040
  sta wR17
  cmp #NPC+$41
  bne -

  plp
  rtl

rlSetTargetableUnitTile ; 83/A657

  .al
  .autsiz
  .databank `aTargetableUnitMap

  lda aTargetingCharacterBuffer.TurnStatus,b
  and #TurnStatusDead | TurnStatusRescued | TurnStatusActing
  bne +

  lda aTargetingCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aTargetingCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords
  tax
  inc aTargetableUnitMap,x

  +
  rtl

rlUnknown83A678 ; 83/A678

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  lda #<>rlUnknown83A6A4
  sta lR25
  lda #>`rlUnknown83A6A4
  sta lR25+1

  lda #Player+1
  jsl rlRunRoutineForAllUnitsInAllegiance
  lda #Enemy+1
  jsl rlRunRoutineForAllUnitsInAllegiance
  lda #NPC+1
  jsl rlRunRoutineForAllUnitsInAllegiance

  plb
  plp
  rtl

rlUnknown83A6A4 ; 83/A6A4

  .al
  .autsiz
  .databank $7E

  lda aTargetingCharacterBuffer.TurnStatus,b
  bit #TurnStatusActing
  bne +

  lda #aTargetingCharacterBuffer
  sta wR1
  lda #$0000
  sta wR4
  jsl rlUnknown80E626

  +
  rtl

rlUnknown83A6BB ; 83/A6BB

  .autsiz
  .databank `aMovementDirectionArray

  php
  rep #$30

  lda wR0
  sta wR2

  lda wR1
  sta wR3

  stz wR17

  -
  ldx wR17
  lda aMovementDirectionArray,x
  and #$00FF
  beq _A700

  asl a
  asl a
  tax

  lda _aUnknown83A705,x
  clc
  adc wR0
  sta wR0

  lda _aUnknown83A705+2,x
  clc
  adc wR1
  sta wR1

  jsl rlGetMapTileIndexByCoords

  tax
  lda aTargetableUnitMap,x
  and #$00FF
  bne _A719

  inc wR17

  lda wR0
  sta wR2
  lda wR1
  sta wR3
  bra -

  _A700
  lda #$0000
  plp
  rtl

  _aUnknown83A705
  .sint  0,  0
  .sint  0,  1
  .sint -1,  0
  .sint  0, -1
  .sint  1,  0

  _A719
  ldy wR17
  sep #$20

  lda #$0E
  sta aMovementDirectionArray,y

  lda aUnitMap,x
  sta aMovementDirectionArray+1,y

  lda #$00
  sta aMovementDirectionArray+2,y

  rep #$20
  lda wR2
  sta wR0
  lda wR3
  sta wR1
  lda #-1

  plp
  rtl

rlFillVisibilityMapWithDefaultValue ; 83/A73C

  .al
  .autsiz
  .databank ?

  lda #<>aVisibilityMap
  sta lR18
  lda #>`aVisibilityMap
  sta lR18+1
  lda wDefaultVisibilityFill,b
  jsl rlFillMapByWord
  rtl

rlUnknown83A74E ; 83/A74E

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  lda #<>rlUnknown83A776
  sta lR25
  lda #>`rlUnknown83A776
  sta lR25+1
  jsl rlRunRoutineForAllUnits

  jsl rlDMAByStruct

  .dstruct structDMAToVRAM, $7F2614, $2000, VMAIN_Setting(True), $0000

  plb
  plp
  rtl

rlUnknown83A776 ; 83/A776

  .al
  .autsiz
  .databank ?

  lda aTargetingCharacterBuffer.TurnStatus,b
  bit #TurnStatusDead | TurnStatusUnknown1 | TurnStatusInvisible | TurnStatusCaptured
  bne +

  lda #<>aTargetingCharacterBuffer
  sta wR1
  jsl $848EC8

  lda #<>aTargetingCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  +
  rtl

rlRollRandomNumber0To100 ; 83/A791

  .autsiz
  .databank ?

  ; Inputs:
  ; A: percent chance

  ; Outputs:
  ; Carry set if roll < chance else clear
  ; 0 always returns clear, 100 always set

  php
  rep #$30
  and #$00FF
  beq _False

  cmp #100
  bge _AlwaysTrue

  phy
  ldy wR0
  phy

  sta wR0
  jsl rlGetRandomNumber
  cmp wR0
  bcc _True

  ply
  sty wR0
  ply

  _False
  plp
  clc
  rtl

  _True
  ply
  sty wR0
  ply

  _AlwaysTrue
  plp
  sec
  rtl

rlCheckIfActiveUnitCanCanto ; 83/A7BA

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #`$7E4F98
  pha
  rep #$20
  plb

  .databank `$7E4F98

  lda aSelectedCharacterBuffer.TurnStatus,b
  bit #TurnStatusMoved
  bne _False

  lda $7E4F98
  bit #$0001
  bne _False

  lda aSelectedCharacterBuffer.CurrentHP,b
  and #$00FF
  beq _False

  lda aSelectedCharacterBuffer.Skills1,b
  bit #Skill1MountMove
  bne _True

  _False
  plb
  plp
  clc
  rtl

  _True
  plb
  plp
  sec
  rtl

rlUnknownGetMapTileCoords ; 83/A7EC

  .al
  .autsiz
  .databank `wEventEngineUnknownXTarget

  txa
  jsl rlGetMapCoordsByTileIndex

  lda wR0
  sta wEventEngineUnknownXTarget

  lda wR1
  sta wEventEngineUnknownYTarget
  rtl

rlUnknownGetMapTileCoordsBySelectedUnit ; 83/A7FC

  .al
  .autsiz
  .databank `wEventEngineUnknownXTarget

  lda aSelectedCharacterBuffer.X,b
  and #$00FF
  sta wEventEngineUnknownXTarget
  lda aSelectedCharacterBuffer.Y,b
  and #$00FF
  sta wEventEngineUnknownYTarget
  rtl

rlCheckIfClassCanDismount ; 83/A80F

  .autsiz
  .databank ?

  php
  rep #$30
  and #$00FF
  ldy #<>aMountedClassTable
  sty lR18
  ldy #>`aMountedClassTable
  sty lR18+1
  jsr rsSearchMountTables
  bcs _True

  ldy #<>aDismountedClassTable
  sty lR18
  ldy #>`aDismountedClassTable
  sty lR18+1
  jsr rsSearchMountTables
  bcs _False

  jsl riBRK & $00FFFF

  _True
  tyx
  plp
  sec
  rtl

  _False
  tyx
  plp
  clc
  rtl

rsSearchMountTables ; 83/A83F

  .al
  .xl
  .autsiz
  .databank ?

  ldy #size(aMountedClassTable)-1
  sep #$20

  -
  cmp [lR18],y
  beq _True

  dec y
  bmi _False
  bra -

  _True
  rep #$30
  sec
  rts

  _False
  rep #$30
  clc
  rts

rlGetEffectiveConstitution ; 83/A855

  .al
  .xl
  .autsiz
  .databank ?

  ; Mounted units and ballistae are treated
  ; as having 20 con while nonmounted units
  ; use their actual con

  ; Inputs:
  ; wR1: short pointer to character

  ; Outputs:
  ; A: Effective Constitution

  ldy wR1
  lda structExpandedCharacterDataRAM.Class,b,y
  and #$00FF
  cmp #Ballistician
  beq _CanDismount

  cmp #BallisticianIron
  beq _CanDismount

  cmp #BallisticianPoison
  beq _CanDismount

  lda structExpandedCharacterDataRAM.Skills1,b,y
  bit #Skill1Mount
  beq _CannotDismount

  lda structExpandedCharacterDataRAM.Class,b,y
  jsl rlCheckIfClassCanDismount
  bcc _CannotDismount

  _CanDismount
  lda #20
  rtl

  _CannotDismount
  lda wR1
  sta wR0

  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl rlCopyExpandedCharacterDataBufferToBuffer
  jsl rlCombineCharacterDataAndClassBases
  lda aItemSkillCharacterBuffer.Constitution,b
  and #$00FF
  rtl

rlUnknown83A899 ; 83/A899

  .al
  .autsiz
  .databank ?

  stz wR4
  bra +

rlUnknown83A89D ; 83/A89D

  .al
  .autsiz
  .databank ?

  lda #$0001
  sta wR4

  +
  ldx wR1
  lda structExpandedCharacterDataRAM.X,b,x
  and #$00FF
  sta wR2
  lda structExpandedCharacterDataRAM.Y,b,x
  and #$00FF
  sta wR3
  lda structExpandedCharacterDataRAM.DeploymentNumber,b,x
  and #Player | Enemy | NPC
  sta wR0
  lda structExpandedCharacterDataRAM.SpriteInfo1,b,x
  and #$00FF
  sta wR1
  lda structExpandedCharacterDataRAM.SpriteInfo2,b,x
  sta wR6
  lda structExpandedCharacterDataRAM.Status,b,x
  and #$000F
  sta wR7
  rtl

rlSelectedUnitMovementStar ; 83/A8D2

  .al
  .autsiz
  .databank ?

  lda aSelectedCharacterBuffer.CurrentHP,b
  and #$00FF
  beq _False

  lda aSelectedCharacterBuffer.TurnStatus,b
  bit #TurnStatusMovementStar
  bne _False

  lda aSelectedCharacterBuffer.MovementStars,b
  jsl rlRollRandomNumber0To100
  bcc _False

  lda aSelectedCharacterBuffer.TurnStatus,b
  ora #TurnStatusMovementStar
  and #~(TurnStatusGrayed | TurnStatusMoved)
  sta aSelectedCharacterBuffer.TurnStatus,b

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  jsl rlInvisibleMovementStar

  lda wR1
  sta wR0
  lda #<>aActionStructUnit1
  sta wR1
  jsl rlCopyExpandedCharacterDataBufferToBuffer
  jsl $83E63C
  jsl $84B4DA
  jsl rlUnknown83812E
  sec
  rtl

  _False
  clc
  rtl

rlInvisibleMovementStar ; 83/A921

  .al
  .autsiz
  .databank `aPhaseControllerInfo

  lda wR1
  pha

  lda aSelectedCharacterBuffer.DeploymentNumber,b
  and #Player | Enemy | NPC
  jsl $83B296

  lda aPhaseControllerInfo,x
  and #$00FF
  cmp #$0004
  bne _End

  lda aSelectedCharacterBuffer.TurnStatus,b
  and #~TurnStatusUnselectable
  sta aSelectedCharacterBuffer.TurnStatus,b

  lda aSelectedCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aSelectedCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords
  tax
  lda aVisibilityMap,x
  and #$00FF
  beq _End

  lda aSelectedCharacterBuffer.TurnStatus,b
  ora #TurnStatusUnselectable
  sta aSelectedCharacterBuffer.TurnStatus,b

  _End
  pla
  sta wR1
  jsl $8885D1
  rtl

rlUnknown83A970 ; 83/A970

  .al
  .autsiz
  .databank ?

  jsl $83AA35
  jsl $83AAE0
  jsl $83AAC9
  jsl $83AB5F

  sep #$20
  lda aSelectedCharacterBuffer.CurrentHP,b
  sta aSelectedCharacterBuffer.MaxHP,b
  rep #$30
  rtl

rlUnknown83A98B ; 83/A98B

  .al
  .autsiz
  .databank ?

  jsl $83AAB6
  jsl $83AAE0
  jsl $83AAC9
  jsl $83AB5F

  sep #$20
  lda aSelectedCharacterBuffer.CurrentHP,b
  sta aSelectedCharacterBuffer.MaxHP,b
  rep #$30
  rtl

rlUnknown83A9A6 ; 83/A9A6

  .al
  .xl
  .autsiz
  .databank ?

  php
  sta wR0
  ldx #$0000

  -
  lda $8882F1,x
  beq _End

  cmp wR0
  beq _Found

  inc x
  inc x
  inc x
  bra -

  _Found
  lda $8882F3,x
  and #$00FF

  _End
  plp
  rtl

rlGetTier1Class ; 83/A9C4

  .al
  .autsiz
  .databank `aClassDataBuffer

  ldy wR1
  lda structExpandedCharacterDataRAM.Class,b,y
  jsl rlCopyClassDataToBuffer

  lda aClassDataBuffer.Tier1Class
  and #$00FF
  rtl

rlGetTier1ClassRelativePower ; 83/A9D4

  .al
  .autsiz
  .databank `aClassDataBuffer

  jsl rlGetTier1Class
  ora #$0000
  beq +

  jsl rlCopyClassDataToBuffer
  lda aClassDataBuffer.ClassRelativePower
  and #$00FF
  rtl

  +
  lda #$0000
  rtl

rlGetTier1ClassRelativePowerModifier ; 83/A9EC

  .autsiz
  .databank ?

  ; get t1crp * 20 + (level * crp)

  php
  phb

  sep #$20
  lda #`aClassDataBuffer
  pha
  rep #$20
  plb

  .databank `aClassDataBuffer

  phx
  phy
  ldy #structExpandedCharacterDataRAM.Class
  lda (wR1),y
  jsl rlGetTier1ClassRelativePower

  ; t1 crp * 20

  sta wR0
  asl a
  asl a
  clc
  adc wR0
  asl a
  asl a
  sta wR0

  ldy #structExpandedCharacterDataRAM.Class
  lda (wR1),y
  jsl rlCopyClassDataToBuffer

  lda aClassDataBuffer.ClassRelativePower
  and #$00FF
  sta wR10

  ldy #structExpandedCharacterDataRAM.Level
  lda (wR1),y
  and #$00FF
  sta wR11

  jsl rlUnsignedMultiply16By16

  lda wR12
  clc
  adc wR0

  ply
  plx
  plb
  plp
  rtl

rlRollRandomBases ; 83/AA35

  .al
  .autsiz
  .databank `aClassDataBuffer

  lda #4
  jsl rlUnknown80B0E6

  sep #$20
  sta aSelectedCharacterBuffer.Strength,b
  rep #$30

  lda #4
  jsl rlUnknown80B0E6

  sep #$20
  sta aSelectedCharacterBuffer.Magic,b
  rep #$30

  lda #4
  jsl rlUnknown80B0E6

  sep #$20
  sta aSelectedCharacterBuffer.Skill,b
  rep #$30

  lda #4
  jsl rlUnknown80B0E6

  sep #$20
  sta aSelectedCharacterBuffer.Speed,b
  rep #$30

  lda #4
  jsl rlUnknown80B0E6

  sep #$20
  sta aSelectedCharacterBuffer.Defense,b
  rep #$30

  lda #4
  jsl rlUnknown80B0E6

  sep #$20
  sta aSelectedCharacterBuffer.Constitution,b
  rep #$30

  lda #4
  jsl rlUnknown80B0E6

  sep #$20
  sta aSelectedCharacterBuffer.Luck,b
  rep #$30

  lda #4
  jsl rlUnknown80B0E6

  sep #$20
  clc
  adc aClassDataBuffer.HP
  sta aSelectedCharacterBuffer.CurrentHP,b
  rep #$30

  lda #10
  jsl rlRollRandomNumber0To100
  bcc +

  inc aSelectedCharacterBuffer.Movement,b

  +
  rtl

rlRollRandomHPBase ; 83/AAB6

  .al
  .autsiz
  .databank `aClassDataBuffer

  php
  lda #2
  jsl rlUnknown80B0E6
  sep #$20
  clc
  adc aClassDataBuffer.HP
  sta aSelectedCharacterBuffer.CurrentHP,b
  plp
  rtl

rlGetAdjustedCharacterLevel ; 83/AAC9

  .al
  .autsiz
  .databank `aCharacterDataBuffer

  lda aSelectedCharacterBuffer.Class,b
  sec
  sbc aCharacterDataBuffer.Class

  and #$00FF
  beq +

  lda #10

  +
  clc
  adc aSelectedCharacterBuffer.Level,b
  and #$00FF
  rtl

rlGetAutolevelScheme ; 83/AAE0

  .al
  .autsiz
  .databank `wAutolevelHPGrowth

  jsl $83E033
  lda #>`aAutolevelSchemePointers
  sta lR18+1
  lda aCharacterDataBuffer.HPOrAutolevel
  eor #-1
  inc a
  and #$00FF
  asl a
  tax
  lda aAutolevelSchemePointers,x
  sta lR18

  ldy #structAutolevelScheme.HP
  lda [lR18],y
  and #$00FF
  sta wAutolevelHPGrowth

  ldy #structAutolevelScheme.STR
  lda [lR18],y
  and #$00FF
  sta wAutolevelSTRGrowth

  ldy #structAutolevelScheme.MAG
  lda [lR18],y
  and #$00FF
  sta wAutolevelMAGGrowth

  ldy #structAutolevelScheme.SKL
  lda [lR18],y
  and #$00FF
  sta wAutolevelSKLGrowth

  ldy #structAutolevelScheme.SPD
  lda [lR18],y
  and #$00FF
  sta wAutolevelSPDGrowth

  ldy #structAutolevelScheme.DEF
  lda [lR18],y
  and #$00FF
  sta wAutolevelDEFGrowth

  ldy #structAutolevelScheme.CON
  lda [lR18],y
  and #$00FF
  sta wAutolevelCONGrowth

  ldy #structAutolevelScheme.LUK
  lda [lR18],y
  and #$00FF
  sta wAutolevelLUKGrowth

  ldy #structAutolevelScheme.MOV
  lda [lR18],y
  and #$00FF
  sta wAutolevelMOVGrowth

  rtl

rlGetAutolevelGainedStats ; 83/AB5F

  .al
  .xl
  .autsiz
  .databank ?

  sta wR15
  dec wR15
  bmi +
  beq +

  lda #<>aSelectedCharacterBuffer
  sta wR0
  lda #<>aActionStructUnit1
  sta wR1
  jsl rlCopyExpandedCharacterDataBufferToBuffer

  -
  ldx #<>aActionStructUnit1
  jsl $83DFD6
  jsr rsAddGainedAutolevelStats
  jsr rsAutolevelWeaponRanks
  jsl rlLevelWeaponRanksToInventory
  dec wR15
  bne -

  +
  jsl rlLevelWeaponRanksToInventory
  rtl

rsAddGainedAutolevelStats ; 83/AB8F

  .autsiz
  .databank `aActionStructUnit1

  sep #$20

  lda aActionStructUnit1.LevelUpHPGain
  clc
  adc aSelectedCharacterBuffer.CurrentHP,b
  sta aSelectedCharacterBuffer.CurrentHP,b

  lda aActionStructUnit1.LevelUpStrengthGain
  clc
  adc aSelectedCharacterBuffer.Strength,b
  sta aSelectedCharacterBuffer.Strength,b

  lda aActionStructUnit1.LevelUpMagicGain
  clc
  adc aSelectedCharacterBuffer.Magic,b
  sta aSelectedCharacterBuffer.Magic,b

  lda aActionStructUnit1.LevelUpSkillGain
  clc
  adc aSelectedCharacterBuffer.Skill,b
  sta aSelectedCharacterBuffer.Skill,b

  lda aActionStructUnit1.LevelUpSpeedGain
  clc
  adc aSelectedCharacterBuffer.Speed,b
  sta aSelectedCharacterBuffer.Speed,b

  lda aActionStructUnit1.LevelUpDefenseGain
  clc
  adc aSelectedCharacterBuffer.Defense,b
  sta aSelectedCharacterBuffer.Defense,b

  lda aActionStructUnit1.LevelUpConstitutionGain
  clc
  adc aSelectedCharacterBuffer.Constitution,b
  sta aSelectedCharacterBuffer.Constitution,b

  lda aActionStructUnit1.LevelUpLuckGain
  clc
  adc aSelectedCharacterBuffer.Luck,b
  sta aSelectedCharacterBuffer.Luck,b

  lda aActionStructUnit1.LevelUpMovementGain
  clc
  adc aSelectedCharacterBuffer.Movement,b
  sta aSelectedCharacterBuffer.Movement,b

  rep #$30
  rts

rsAutolevelWeaponRanks ; 83/ABEE

  .xl
  .autsiz
  .databank ?

  sep #$20
  ldx #size(aSelectedCharacterBuffer.WeaponRanks)-1

  -
  lda aSelectedCharacterBuffer.Skill,b
  jsl rlRollRandomNumber0To100
  bcc +

  lda aSelectedCharacterBuffer.WeaponRanks,b,x
  clc
  adc #WeaponRankIncrement
  bcs +

  sta aSelectedCharacterBuffer.WeaponRanks,b,x

  +
  dec x
  bpl -

  rep #$30
  rts

rlLevelWeaponRanksToInventory ; 83/AC0D

  .al
  .autsiz
  .databank `aClassDataBuffer

  lda aSelectedCharacterBuffer.Class,b
  jsl rlCopyClassDataToBuffer
  lda #<>rlLevelWeaponRankToItem
  sta lR25
  lda #>`rlLevelWeaponRankToItem
  sta lR25+1
  lda #aSelectedCharacterBuffer.Items
  jsl rlRunRoutineForAllItemsInInventory
  rtl

rlLevelWeaponRankToItem ; 83/AC26

  .al
  .autsiz
  .databank `aClassDataBuffer

  jsl rlCopyItemDataToBuffer
  lda aItemDataBuffer.Traits,b
  bit #TraitWeapon | TraitStaff
  beq _End

  ; If already A Rank

  lda aItemDataBuffer.WeaponRank,b
  bmi _End

  ; If unit doesn't have a starting rank

  lda aItemDataBuffer.Type,b
  and #$000F
  tax
  sep #$20
  lda aClassDataBuffer.WeaponRanks,x
  beq _End

  ; Add the required weapon rank

  clc
  adc aSelectedCharacterBuffer.WeaponRanks,b,x
  cmp aItemDataBuffer.WeaponRank,b
  bcs _End

  lda aItemDataBuffer.WeaponRank,b
  sec
  sbc aClassDataBuffer.WeaponRanks,x
  sta aSelectedCharacterBuffer.WeaponRanks,b,x

  _End
  rep #$30
  rtl

rlUpdateMountDismountSkills ; 83/AC5B

  .autsiz
  .databank `aClassDataBuffer

  php
  rep #$30
  pha

  jsl rlCopyClassDataToBuffer

  sep #$20
  lda aClassDataBuffer.Skills1
  eor #$FF
  sta wR0

  ldy wR1
  lda structExpandedCharacterDataRAM.Skills1,b,y
  and wR0
  sta structExpandedCharacterDataRAM.Skills1,b,y
  rep #$30

  lda aClassDataBuffer.Skills2
  eor #$FFFF
  sta wR0
  lda structExpandedCharacterDataRAM.Skills2,b,y
  and wR0
  sta structExpandedCharacterDataRAM.Skills2,b,y

  pla
  xba
  jsl rlCopyClassDataToBuffer

  sep #$20
  ldy wR1
  lda structExpandedCharacterDataRAM.Skills1,b,y
  ora aClassDataBuffer.Skills1
  sta structExpandedCharacterDataRAM.Skills1,b,y
  rep #$30
  lda structExpandedCharacterDataRAM.Skills2,b,y
  ora aClassDataBuffer.Skills2
  sta structExpandedCharacterDataRAM.Skills2,b,y
  plp
  rtl

rlUnknown83ACA8 ; 83/ACA8

  .al
  .autsiz
  .databank ?

  lda aSelectedCharacterBuffer.Rescue,b
  and #$00FF
  beq +

  lda wR1
  pha

  lda aSelectedCharacterBuffer.Rescue,b
  sta wR0
  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda aItemSkillCharacterBuffer.TurnStatus,b
  and #~(TurnStatusRescued | TurnStatusRescuing)
  sta aItemSkillCharacterBuffer.TurnStatus,b
  ply

  lda structExpandedCharacterDataRAM.TurnStatus,b,y
  and #~(TurnStatusRescued | TurnStatusRescuing)
  sta structExpandedCharacterDataRAM.TurnStatus,b,y

  sep #$20
  lda #$00
  sta structExpandedCharacterDataRAM.Rescue,b,y
  stz aItemSkillCharacterBuffer.Rescue,b

  rep #$30
  lda #<>aItemSkillCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  +
  rtl

rlSetLordFatigueToFF ; 83/ACEA

  .al
  .autsiz
  .databank ?

  lda #$0001
  sta wR0
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  sep #$20
  lda #-1
  sta aSelectedCharacterBuffer.Fatigue,b

  rep #$20
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  clc
  rtl

rlForceDismountOnImpassibleTiles ; 83/AD0C

  .autsiz
  .databank `aTerrainMap

  php
  phb

  sep #$20
  lda #`aTerrainMap
  pha
  rep #$20
  plb

  .databank `aTerrainMap

  lda aSelectedCharacterBuffer.Skills1,b
  bit #Skill1Mount
  beq _False

  lda aSelectedCharacterBuffer.Class,b
  jsl rlCheckIfClassCanDismount
  bcc _False

  lda aSelectedCharacterBuffer.Class,b
  and #$00FF
  sta wR3
  jsl rlCopyTerrainMovementCostBuffer

  lda aSelectedCharacterBuffer.X,b
  and #$00FF
  sta wR0
  lda aSelectedCharacterBuffer.Y,b
  and #$00FF
  sta wR1
  jsl rlGetMapTileIndexByCoords

  tax
  lda aTerrainMap,x
  and #$00FF
  tay
  lda aTerrainMovementCostBuffer-1,y
  bpl _False

  lda aSelectedCharacterBuffer.Class,b
  xba
  pha
  lda aSelectedCharacterBuffer.Class,b
  jsl rlCheckIfClassCanDismount

  sep #$20
  lda aDismountedClassTable,x
  sta aSelectedCharacterBuffer.Class,b
  jsl rlCopyClassDataToBuffer

  tdc
  lda aClassDataBuffer.MapSprite
  sta aSelectedCharacterBuffer.SpriteInfo1,b
  rep #$30

  pla
  sta wR0
  sep #$20
  lda aSelectedCharacterBuffer.Class,b
  sta wR0
  rep #$30
  ldx #<>aSelectedCharacterBuffer
  stx wR1
  xba
  jsl rlUpdateMountDismountSkills

  plb
  plp
  sec
  rtl

  _False
  plb
  plp
  clc
  rtl

rlCapPromotionStatGains ; 83/AD94

  .autsiz
  .databank ?

  php
  sep #$20

  lda structExpandedCharacterDataRAM.MaxHP,x
  clc
  adc structActionStructEntry.LevelUpHPGain,b,y
  sec
  sbc #80
  bmi +

  sta wR0
  lda structActionStructEntry.LevelUpHPGain,b,y
  sec
  sbc wR0
  sta structActionStructEntry.LevelUpHPGain,b,y

  +
  lda structExpandedCharacterDataRAM.Strength,x
  clc
  adc structActionStructEntry.LevelUpStrengthGain,b,y
  sec
  sbc #20
  bmi +

  sta wR0
  lda structActionStructEntry.LevelUpStrengthGain,b,y
  sec
  sbc wR0
  sta structActionStructEntry.LevelUpStrengthGain,b,y

  +
  lda structExpandedCharacterDataRAM.Magic,x
  clc
  adc structActionStructEntry.LevelUpMagicGain,b,y
  sec
  sbc #20
  bmi +

  sta wR0
  lda structActionStructEntry.LevelUpMagicGain,b,y
  sec
  sbc wR0
  sta structActionStructEntry.LevelUpMagicGain,b,y

  +
  lda structExpandedCharacterDataRAM.Skill,x
  clc
  adc structActionStructEntry.LevelUpSkillGain,b,y
  sec
  sbc #20
  bmi +

  sta wR0
  lda structActionStructEntry.LevelUpSkillGain,b,y
  sec
  sbc wR0
  sta structActionStructEntry.LevelUpSkillGain,b,y

  +
  lda structExpandedCharacterDataRAM.Speed,x
  clc
  adc structActionStructEntry.LevelUpSpeedGain,b,y
  sec
  sbc #20
  bmi +

  sta wR0
  lda structActionStructEntry.LevelUpSpeedGain,b,y
  sec
  sbc wR0
  sta structActionStructEntry.LevelUpSpeedGain,b,y

  +
  lda structExpandedCharacterDataRAM.Defense,x
  clc
  adc structActionStructEntry.LevelUpDefenseGain,b,y
  sec
  sbc #20
  bmi +

  sta wR0
  lda structActionStructEntry.LevelUpDefenseGain,b,y
  sec
  sbc wR0
  sta structActionStructEntry.LevelUpDefenseGain,b,y

  +
  lda structExpandedCharacterDataRAM.Constitution,x
  clc
  adc structActionStructEntry.LevelUpConstitutionGain,b,y
  sec
  sbc #20
  bmi +

  sta wR0
  lda structActionStructEntry.LevelUpConstitutionGain,b,y
  sec
  sbc wR0
  sta structActionStructEntry.LevelUpConstitutionGain,b,y

  +
  lda structExpandedCharacterDataRAM.Luck,x
  clc
  adc structActionStructEntry.LevelUpLuckGain,b,y
  sec
  sbc #20
  bmi +

  sta wR0
  lda structActionStructEntry.LevelUpLuckGain,b,y
  sec
  sbc wR0
  sta structActionStructEntry.LevelUpLuckGain,b,y

  +
  lda structExpandedCharacterDataRAM.Movement,x
  clc
  adc structActionStructEntry.LevelUpMovementGain,b,y
  sec
  sbc #20
  bmi +

  sta wR0
  lda structActionStructEntry.LevelUpMovementGain,b,y
  sec
  sbc wR0
  sta structActionStructEntry.LevelUpMovementGain,b,y

  +
  plp
  rtl

rlUnknown83AE5F ; 83/AE5F

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #`aClassDataBuffer
  pha
  rep #$20
  plb

  .databank `aClassDataBuffer

  lda aSelectedCharacterBuffer.Skills1,b
  bit #Skill1Mount
  beq _End

  lda aSelectedCharacterBuffer.Class,b
  xba
  sta wR17
  lda aSelectedCharacterBuffer.Class,b
  jsl rlCheckIfClassCanDismount

  sep #$20
  lda aMountedClassTable,x
  sta aSelectedCharacterBuffer.Class,b
  sta wR17
  jsl rlCopyClassDataToBuffer

  tdc
  lda aClassDataBuffer.MapSprite
  sta aSelectedCharacterBuffer.SpriteInfo1,b
  rep #$30
  lda #<>aSelectedCharacterBuffer
  sta wR1
  lda wR17
  xba
  jsl rlUpdateMountDismountSkills
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $848E5A

  _End
  plb
  plp
  rtl

rlUnknown83AEAE ; 83/AEAE

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  lda aSelectedCharacterBuffer.Skills1,b
  bit #Skill1Mount
  beq +

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $879560

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl $848E5A

  +
  plb
  plp
  rtl

rlUnknown83AED5 ; 83/AED5

  .autsiz
  .databank ?

  sta wR0

  php
  phb

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlSearchForUnitAndWriteTargetToBuffer
  jsl rlUnknown83AE5F

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  plb
  plp
  rtl

rlUnknown83AEFA ; 83/AEFA

  .autsiz
  .databank ?

  sta wR0

  php
  phb

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlSearchForUnitAndWriteTargetToBuffer
  jsl rlUnknown83AEAE

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  plb
  plp
  rtl

rlGetWeaponAndDurabilityPacked ; 83/AF1F

  .autsiz
  .databank ?

  php
  sep #$20
  lda aItemDataBuffer.Durability,b
  xba
  lda aItemDataBuffer.DisplayedWeapon,b
  plp
  rtl

rlCheckIfTileIsGateOrThroneByTileIndex ; 83/AF2B

  .autsiz
  .databank `aTerrainMap

  php
  sep #$20

  lda aTerrainMap,x

rlCheckIfTileIsGateOrThrone ; 83/AF31

  .autsiz
  .databank `aTerrainMap

  cmp #TerrainGate
  beq _True

  cmp #TerrainThrone
  beq _True

  plp
  clc
  rtl

  _True
  plp
  sec
  rtl

rlCheckIfTileIsGateOrThroneByTerrainID ; 83/AF3F

  .autsiz
  .databank `aTerrainMap

  php
  sep #$20
  bra rlCheckIfTileIsGateOrThrone

rlUnknownClearAI ; 83/AF44

  .autsiz
  .databank ?

  php
  ldx wR1
  sep #$20
  stz structExpandedCharacterDataRAM.AI1,b,x
  stz structExpandedCharacterDataRAM.AI2,b,x
  stz structExpandedCharacterDataRAM.AI3,b,x
  stz structExpandedCharacterDataRAM.AI4,b,x
  stz structExpandedCharacterDataRAM.Unknown3E,b,x
  rep #$30
  stz structExpandedCharacterDataRAM.Unknown3F,b,x
  plp
  rtl

rsSetEXPToZeroOrFF ; 83/AF5F

  .as
  .autsiz
  .databank ?

  lda structExpandedCharacterDataRAM.Level,b,x
  cmp #20
  beq +

  lda structExpandedCharacterDataRAM.DeploymentNumber,b,x
  and #Player | Enemy | NPC
  bne +

  stz structExpandedCharacterDataRAM.Experience,b,x

  rts

  +
  lda #-1
  sta structExpandedCharacterDataRAM.Experience,b,x
  rts

rlUnknown83AF77 ; 83/AF77

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  .databank $7E

  lda wR0
  sta wR16

  lda wR1
  sta wR17

  inc wR2
  inc wR3

  lda #<>rlUnknown83AFA0
  sta lR25
  lda #>`rlUnknown83AFA0
  sta lR25+1
  lda wR2
  jsl rlRunRoutineForAllUnitsInAllegiance

  plb
  plp
  rtl

rlUnknown83AFA0 ; 83/AFA0

  .al
  .autsiz
  .databank ?

  lda aTargetingCharacterBuffer.Character,b
  cmp wR16
  bne +

  lda aTargetingCharacterBuffer.DeploymentSlot,b
  pha
  lda wR3
  sta wR0
  lda #<>aTargetingCharacterBuffer
  sta wR1
  jsl rlStoreAvailableDeploymentSlotToCharacterData
  plx
  lda aTargetingCharacterBuffer.DeploymentSlot,b
  beq +

  stz structExpandedCharacterDataRAM.Character,b,x
  jsr rsUnknownSyncRescue
  lda #<>aTargetingCharacterBuffer
  sta wR1
  jsl rlUnknownClearAI
  sep #$20
  ldx #<>aTargetingCharacterBuffer
  jsr rsSetEXPToZeroOrFF
  rep #$30
  lda wR17
  sta aTargetingCharacterBuffer.Leader,b
  lda #<>aTargetingCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  +
  rtl

rsUnknownSyncRescue ; 83/AFE6

  .al
  .autsiz
  .databank ?

  lda aTargetingCharacterBuffer.Rescue,b
  and #$00FF
  beq +

  sta wR0
  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  sep #$20
  lda aTargetingCharacterBuffer.DeploymentNumber,b
  sta aBurstWindowCharacterBuffer.Rescue,b
  rep #$20

  lda #<>aBurstWindowCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataFromBuffer

  +
  rts

rlCopyItemDataToBuffer ; 83/B00D

  .autsiz
  .databank ?

  ; Given a packed (DD << 8 | ID) item
  ; in A, write its data to the item buffer,
  ; calculating actual price and doing broken
  ; item transformations.

  ; Inputs:
  ; A: (Durability or base weapon) << 8 | item ID

  ; Outputs:
  ; aItemDataBuffer: item

  php
  phb

  rep #$30
  phx
  phy

  ; We'll use the packed value later

  pha

  ; Get offset of item data in aItemData
  ; and mvn the data into the buffer

  and #$00FF
  sta wR10
  lda #size(structItemDataEntry)
  sta wR11
  jsl rlUnsignedMultiply16By16

  lda wR12
  clc
  adc #<>aItemData
  tax
  ldy #aItemDataBuffer
  lda #size(structItemDataEntry)-1
  mvn #`aItemData,#$7E

  ; Use the packed value on the stack
  ; Durability of -2 with an item ID
  ; means to use the item's max durability, else
  ; use its current durability

  lda #$01,s
  cmp #(-2 & $FF) << 8
  beq _CurrentDurability

  bge +

  _CurrentDurability

  ; Copy current durability from packed item

  sep #$20
  xba
  sta aItemDataBuffer.Durability,b
  rep #$30

  +

  ; Generate cost from durability * cost + 200

  lda aItemDataBuffer.Durability,b
  and #$00FF
  sta wR11
  lda aItemDataBuffer.Cost,b
  sta wR10
  jsl rlUnsignedMultiply16By16

  lda wR12
  clc
  adc #200

  ; Only weapons and staves have the base cost
  ; of 200 added

  tax
  lda aItemDataBuffer.Traits,b
  bit #TraitWeapon | TraitStaff
  bne +

  txa
  sec
  sbc #200
  tax

  +
  stx aItemDataBuffer.Cost,b

  pla
  sep #$20
  sta aItemDataBuffer.DisplayedWeapon,b
  sta aItemDataBuffer.BaseWeapon,b

  ; If the weapon is a broken weapon,
  ; its durability is the base weapon

  lda aItemDataBuffer.Traits,b
  bit #TraitBroken
  bne +

  ply
  plx
  plb
  plp
  rtl

  +
  lda aItemDataBuffer.Durability,b
  sta aItemDataBuffer.BaseWeapon,b

  ; Get the offset of the broken item in aItemData
  ; so that we can get the base item's traits
  ; also, remove the ability to cast at range

  rep #$30
  and #$00FF
  sta wR10
  lda #size(structItemDataEntry)
  sta wR11

  ; Cost of a broken waepon is 200 by default

  lda #200
  sta aItemDataBuffer.Cost,b

  jsl rlUnsignedMultiply16By16
  lda wR12
  clc
  adc #<>aItemData + structItemDataEntry.Traits
  tax
  sep #$20
  lda aItemData & $FF0000,x
  and #~(TraitMagicRanged)
  ora aItemDataBuffer.Traits,b
  sta aItemDataBuffer.Traits,b

  ply
  plx
  plb
  plp
  rtl

rlTryGetBrokenItemID ; 83/B0B7

  .autsiz
  .databank ?

  php
  sep #$20
  phx
  phy

  jsl rlCopyItemDataToBuffer

  ; Unbreakable and not-broken items
  ; return their packed durability and item ID

  lda aItemDataBuffer.Traits,b
  bit #TraitUnbreakable
  bne _ReturnUnbroken

  dec aItemDataBuffer.Durability,b
  bne _ReturnUnbroken

  ; Broken ballistae return 0000?

  lda aItemDataBuffer.Traits,b
  bit #TraitBallista
  bne _ReturnNone

  ; If there's a broken equivalent, return that

  tdc
  lda aItemDataBuffer.Type,b
  and #$0F
  tax
  sep #$20
  lda aItemDataBuffer.DisplayedWeapon,b
  xba
  lda aBrokenItemTable,x
  bne +

  _ReturnNone
  tdc

  +
  rep #$30
  ply
  plx
  plp
  rtl

  .include "../TABLES/BrokenItemTable.asm"

  _ReturnUnbroken
  lda aItemDataBuffer.Durability,b
  xba
  lda aItemDataBuffer.DisplayedWeapon,b
  ply
  plx
  plp
  rtl

rlCheckIfInRange ; 83/B104

  .autsiz
  .databank ?

  ; Given an item in aItemDataBuffer
  ; and a target range in A, return carry set if
  ; item can attack target

  ; Inputs:
  ; A: Range, FF for any
  ; aItemDataBuffer: item

  ; Outputs:
  ; Carry set if in range else clear

  php
  rep #$30
  and #$00FF

  ; Range of FF means any?

  cmp #$00FF
  beq _True

  sta wR0

  ; false if min range greater than
  ; target, if target higher than min,
  ; check if less than max

  lda aItemDataBuffer.Range,b
  and #$000F
  cmp wR0
  beq +

  bge _False

  +

  ; Else check if under max range

  lda aItemDataBuffer.Range,b
  lsr a
  lsr a
  lsr a
  lsr a
  and #$000F
  cmp wR0
  blt _False

  _True
  plp
  sec
  rtl

  _False
  plp
  clc
  rtl

rlUnknown83B131 ; 83/B131

  .al
  .autsiz
  .databank ?

  ; $87A2F9 isn't a table, this is bad/old code

  lda aItemDataBuffer.UseEffect,b
  and #$00FF
  tax
  lda $87A2F9,x
  sta lR25
  lda $87A2F9+1,x
  sta lR25+1
  rtl

rlUnknown83B145 ; 83/B145

  .al
  .autsiz
  .databank ?

  sta wR0
  jsl rlCopyItemDataToBuffer

  ; Broken items are

  lda aItemDataBuffer.Traits,b
  bit #TraitBroken
  bne _True

  ; If it's not a weapon/staff it can't
  ; be a broken weapon

  lda aItemDataBuffer.Traits,b
  bit #TraitWeapon | TraitStaff
  beq _False

  lda aItemDataBuffer.DisplayedWeapon,b
  and #$00FF
  ora #(-2 & $FF) << 8
  jsl rlCopyItemDataToBuffer

  lda wR0+1

  sep #$20
  cmp aItemDataBuffer.Durability,b
  beq _False

  _True
  rep #$30
  sec
  rtl

  _False
  rep #$30
  clc
  rtl

rlUnknown83B179 ; 83/B179

  .al
  .autsiz
  .databank ?

  sta wR16
  jsl rlCopyItemDataToBuffer
  lda aItemDataBuffer.Traits,b
  bit #TraitBroken
  bne +

  lda wR16
  and #$00FF
  ora #(-2 & $FF) << 8

  -
  jsl rlCopyItemDataToBuffer
  sep #$20
  lda aItemDataBuffer.Durability,b
  xba
  lda aItemDataBuffer.DisplayedWeapon,b
  rep #$30
  rtl

  +
  lda #(-2 & $FF) << 8
  sep #$20
  lda aItemDataBuffer.Durability,b
  bra -

rlGetTransformedItem ; 83/B1A9

  .al
  .autsiz
  .databank ?

  phx
  phy
  tax

  php
  phb

  sep #$20
  lda #$7E
  pha
  rep #$20
  plb

  stz lR25
  stx wR21
  stx wR22

  txa
  jsl rlCopyItemDataToBuffer

  lda aItemDataBuffer.Traits,b
  bit #TraitBroken
  beq +

  lda wR22
  xba
  sta wR22

  inc lR25

  +
  lda wR22
  jsr rsCheckIfItemTransformsOnPickup
  bcc _DoesNotTransform

  sep #$20
  lda aTransformedItemTable,x
  sta wR22
  rep #$30

  lda lR25
  bne _BrokenTransformed

  lda wR22
  and #$00FF
  ora #(-2 & $FF) << 8
  jsl rlCopyItemDataToBuffer

  sep #$20
  lda wR22+1
  cmp aItemDataBuffer.Durability,b
  blt +

  lda aItemDataBuffer.Durability,b,x

  +
  rep #$30
  lda wR22
  plb
  plp
  ply
  plx
  sec
  rtl

  _DoesNotTransform
  lda wR21
  plb
  plp
  ply
  plx
  clc
  rtl

  _BrokenTransformed
  lda wR22
  xba
  plb
  plp
  ply
  plx
  sec
  rtl

rsCheckIfItemTransformsOnPickup ; 83/B218

  .autsiz
  .databank ?

  sep #$20
  sta wR0
  ldx #$0000

  -
  lda aTransformingItemTable,x
  beq _NotFound

  cmp wR0
  beq _Found

  inc x
  bra -

  _Found
  rep #$30
  sec
  rts

  _NotFound
  rep #$30
  clc
  rts

rlGetRandomItemWeight ; 83/B234

  .al
  .autsiz
  .databank ?

  lda aItemDataBuffer.Traits,b
  bit #TraitWeapon
  bne +

  lda aItemDataBuffer.Cost,b
  clc
  adc #20000
  sta aItemDataBuffer.Cost,b

  lda aItemDataBuffer.Traits,b
  bit #TraitStaff
  bne +

  lda aItemDataBuffer.Cost,b
  clc
  adc #10000
  sta aItemDataBuffer.Cost,b

  +
  lda aItemDataBuffer.Traits,b
  bit #TraitUnsellable
  beq +

  lda #60000
  sta aItemDataBuffer.Cost,b

  +
  rtl

rlGetPhaseTargetFlags ; 83/B267

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #`aAllegianceInfo
  pha
  rep #$20
  plb

  .databank `aAllegianceInfo

  lda wCurrentPhase,b
  jsl rlGetAllegianceInfoOffset
  lda aAllegianceInfo,x
  sta wR0
  and #$0001
  sta wPlayerUnitTargetFlag
  lda wR0
  and #$0002
  sta wEnemyUnitTargetFlag
  lda wR0
  and #$0004
  sta wNPCUnitTargetFlag
  plb
  plp
  rtl

rlGetAllegianceInfoOffset ; 83/B296

  .al
  .xl
  .autsiz
  .databank ?

  ora #$0000
  beq _Player

  cmp #Enemy
  beq _Enemy

  ldx #$0002
  rtl

  _Enemy
  ldx #$0001
  rtl

  _Player
  ldx #$0000
  rtl

rsGetAllegianceController ; 83/B2AC

  .al
  .autsiz
  .databank ?

  ora #$0000
  beq _Player

  cmp #Enemy
  beq _Enemy

  lda #$0004
  rts

  _Enemy
  lda #$0002
  rts

  _Player
  lda #$0001
  rts

rlUnknown83B2C2 ; 83/B2C2

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #`aAllegianceInfo
  pha
  rep #$20
  plb

  .databank `aAllegianceInfo

  lda wR0
  jsl rlGetAllegianceInfoOffset

  lda wR1
  jsr rsGetAllegianceController
  sta wR3

  jsr rsUnknown83B2EF

  lda wR1
  jsl rlGetAllegianceInfoOffset

  lda wR0
  jsr rsGetAllegianceController
  sta wR3

  jsr rsUnknown83B2EF

  plb
  plp
  rtl

rsUnknown83B2EF ; 83/B2EF

  .autsiz
  .databank `aAllegianceInfo

  sep #$20
  lda wR2
  beq +

  lda aAllegianceInfo,x
  ora wR3
  sta aAllegianceInfo,x
  bra ++

  +
  lda wR3
  eor #$FF
  and aAllegianceInfo,x
  sta aAllegianceInfo,x

  +
  rep #$30
  rts

rlCheckIfAllegianceMatchesPhase ; 83/B30C

  .autsiz
  .databank ?

  php
  rep #$30
  pha
  and #Player | Enemy | NPC
  cmp wCurrentPhase,b
  beq _False

  pla
  plp
  sec
  rtl

  _False
  pla
  plp
  clc
  rtl

rlCheckIfAllegianceDoesNotMatchPhase ; 83/B320

  .autsiz
  .databank ?

  php
  rep #$30
  pha
  phx

  and #$00FF
  asl a
  tax
  lda aDeploymentSlotTable,x

  tax
  lda ($7E << 16) | structExpandedCharacterDataRAM.Status,x
  and #$00FF
  cmp #StatusBerserk
  beq _True

  lda #$03,s
  and #Player | Enemy | NPC
  cmp wCurrentPhase,b
  bne _True

  plx
  pla
  plp
  clc
  rtl

  _True
  plx
  pla
  plp
  sec
  rtl

rlCheckIfAllegianceDoesNotMatchPhaseTarget ; 83/B34F

  .autsiz
  .databank ?

  php
  rep #$30
  pha
  phx

  and #$00FF
  asl a
  tax
  lda aDeploymentSlotTable,x

  tax
  lda ($7E << 16) | structExpandedCharacterDataRAM.Status,x
  and #$00FF
  cmp #StatusBerserk
  beq _True

  lda #$03,s
  and #Player | Enemy | NPC
  tax
  lda wPlayerUnitTargetFlag,x
  bne _True

  plx
  pla
  plp
  clc
  rtl

  _True
  plx
  pla
  plp
  sec
  rtl

rlCheckIfTargetableAllegiance ; 83/B380

  .autsiz
  .databank ?

  php
  rep #$30
  pha
  phx

  and #Player | Enemy | NPC
  tax
  lda wPlayerUnitTargetFlag,x
  beq _False

  plx
  pla
  plp
  sec
  rtl

  _False
  plx
  pla
  plp
  clc
  rtl

rlUnknown83B399 ; 83/B399

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #`aAllegianceTargets
  pha
  rep #$20
  plb

  .databank `aAllegianceTargets

  lda wCurrentPhase,b
  pha

  stz wCurrentPhase,b

  jsl rlGetPhaseTargetFlags

  lda #NPC
  jsl rlCheckIfAllegianceDoesNotMatchPhaseTarget
  bcc _B3BC

  lda #$0000
  bra _B3BF

  _B3BC
  lda #$0001

  _B3BF
  sep #$20
  sta aAllegianceTargets.bNPCAllegianceTargetable
  lda #$01
  sta aAllegianceTargets.bAlliedAllegianceTargetable
  lda #$00
  sta aAllegianceTargets.bEnemyAllegianceTargetable
  rep #$30

  pla
  sta wCurrentPhase,b
  jsl rlGetPhaseTargetFlags
  plb
  plp
  rtl

rlSetDefaultUnitTargetFlags ; 83/B3D8

  .autsiz
  .databank ?

  php
  phb

  sep #$20
  lda #`wPlayerUnitTargetFlag
  pha
  rep #$20
  plb

  .databank `wPlayerUnitTargetFlag

  lda #$0001
  sta wPlayerUnitTargetFlag
  lda #$0002
  sta wEnemyUnitTargetFlag
  lda #$0004
  sta wNPCUnitTargetFlag
  plb
  plp
  rtl

rlUnknown83B3FA ; 83/B3FA

  .autsiz
  .databank ?

  jsl rlCheckIfAllegianceMatchesPhase
  bcc +

  jsl rlCheckIfTargetableAllegiance
  bcs +

  clc
  rtl

  +
  sec
  rtl

rsUnknown83B40A ; 83/B40A

  .autsiz
  .databank ?

  php
  sep #$20
  phb
  lda lR18+2
  pha
  plb

  rep #$30
  ldy #$0000
  lda (lR18),y
  sta wR0

  lda #31
  sta wMapWidth16

  ldy #$0002
  lda (lR18),y
  sta wR1

  lda #29
  sta wMapHeight16

  lda lR18
  clc
  adc #$0004
  sta lR18

  lda wR0

  lda #33
  sta wMapRowSize
  sec
  sbc wR0
  sta wR2

  lda wR0
  asl a
  sta wR0

  lda wR2
  asl a
  sta wR2

  ldy lR18
  lda wR1
  sta wR4

  -
  lda wR0
  lsr a
  sta wR3

  -
  lda $0000,b,y
  sta aMapMetatileMap,x
  inc y
  inc y
  inc x
  inc x
  dec wR3
  bne -

  txa
  clc
  adc wR2
  tax
  dec wR4
  bne --

  plb
  plp
  rts

rlFillTerrainMap ; 83/B476

  .autsiz
  .databank ?

  php
  sep #$20
  phb
  lda #`aMapMetatileMap
  pha
  plb

  .databank `aMapMetatileMap

  ldx #size(aTerrainMap) - 1
  stx wR1

  ldx #size(aMapMetatileMap) - 2
  stx wR0

  rep #$20

  -
  ldy wR0
  lda aMapMetatileMap,y
  lsr a
  lsr a
  lsr a
  tax
  sep #$20
  lda $7F2010,x
  ldy wR1
  sta aTerrainMap,y
  rep #$20
  dec wR0
  dec wR0
  dec wR1
  bpl -

  plb
  plp
  rtl

rlClearMapMetatileMap ; 83/B4AB

  .autsiz
  .databank ?

  php
  sep #$20
  phb
  lda #`aMapMetatileMap
  pha
  plb

  .databank `aMapMetatileMap

  rep #$30
  ldx #size(aMapMetatileMap)-2
  lda #$0000

  -
  sta aMapMetatileMap,x
  dec x
  dec x
  bpl -

  plb
  plp
  rts

rsUnknownMenuDrawLabels ; 83/B4C5

  .al
  .xl
  .autsiz
  .databank ?

  lda #(`$83C0F6)<<8
  sta lUnknown000DDE+1,b
  lda #<>$83C0F6
  sta lUnknown000DDE,b
  lda #$2580
  sta wUnknown000DE7,b

  lda #(`$83B60A)<<8
  sta lR18+1
  lda #<>$83B60A
  sta lR18
  ldx #23 | (2 << 8)
  jsl $87E728

  lda #(`$83B64C)<<8
  sta lR18+1
  lda #<>$83B64C
  sta lR18
  ldx #28 | (2 << 8)
  jsl $87E728

  lda #(`$83B610)<<8
  sta lR18+1
  lda #<>$83B610
  sta lR18
  ldx #23 | (4 << 8)
  jsl $87E728

  lda #(`$83B64C)<<8
  sta lR18+1
  lda #<>$83B64C
  sta lR18
  ldx #28 | (4 << 8)
  jsl $87E728

  lda #(`$83B616)<<8
  sta lR18+1
  lda #<>$83B616
  sta lR18
  ldx #23 | (6 << 8)
  jsl $87E728

  lda #(`$83B61A)<<8
  sta lR18+1
  lda #<>$83B61A
  sta lR18
  ldx #23 | (8 << 8)
  jsl $87E728

  lda #(`$83B620)<<8
  sta lR18+1
  lda #<>$83B620
  sta lR18
  ldx #23 | (10 << 8)
  jsl $87E728

  lda #(`$83B626)<<8
  sta lR18+1
  lda #<>$83B626
  sta lR18
  ldx #23 | (12 << 8)
  jsl $87E728

  lda #(`$83B62E)<<8
  sta lR18+1
  lda #<>$83B62E
  sta lR18
  ldx #23 | (14 << 8)
  jsl $87E728

  lda #(`$83B634)<<8
  sta lR18+1
  lda #<>$83B634
  sta lR18
  ldx #23 | (16 << 8)
  jsl $87E728

  lda #(`$83B63C)<<8
  sta lR18+1
  lda #<>$83B63C
  sta lR18
  ldx #23 | (18 << 8)
  jsl $87E728

  lda #(`$83B644)<<8
  sta lR18+1
  lda #<>$83B644
  sta lR18
  ldx #23 | (20 << 8)
  jsl $87E728

  lda #(`$83B64C)<<8
  sta lR18+1
  lda #<>$83B64C
  sta lR18
  ldx #28 | (6 << 8)
  jsl $87E728

  lda #(`$83B64C)<<8
  sta lR18+1
  lda #<>$83B64C
  sta lR18
  ldx #28 | (8 << 8)
  jsl $87E728

  lda #(`$83B64C)<<8
  sta lR18+1
  lda #<>$83B64C
  sta lR18
  ldx #28 | (10 << 8)
  jsl $87E728

  lda #(`$83B64C)<<8
  sta lR18+1
  lda #<>$83B64C
  sta lR18
  ldx #28 | (12 << 8)
  jsl $87E728

  lda #(`$83B64C)<<8
  sta lR18+1
  lda #<>$83B64C
  sta lR18
  ldx #28 | (16 << 8)
  jsl $87E728

  lda #(`$83B64C)<<8
  sta lR18+1
  lda #<>$83B64C
  sta lR18
  ldx #28 | (18 << 8)
  jsl $87E728

  rts

  .enc "MenuText"
  .text "ＬＶ\n"

  .enc "MenuText"
  .text "ＨＰ\n"

  .enc "MenuText"
  .text "カ\n"

  .enc "MenuText"
  .text "まカ\n"

  .enc "MenuText"
  .text "わざ\n"

  .enc "MenuText"
  .text "はやさ\n"

  .enc "MenuText"
  .text "うん\n"

  .enc "MenuText"
  .text "まもり\n"

  .enc "MenuText"
  .text "隊かく\n"

  .enc "MenuText"
  .text "いどう\n"

  .enc "MenuText"
  .text "／\n"



rlUnknown83B650 ; 83/B650

  .al
  .autsiz
  .databank `aPlayerVisibleUnitMap

  ldx wCursorTileIndex,b
  lda aPlayerVisibleUnitMap,x
  and #$00FF
  beq _End

  pha
  lda #<>aBG3TilemapBuffer
  sta wR0
  lda #$01DF
  jsl rlFillTilemapByWord

  pla
  sta wR0
  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCopyCharacterDataToBufferByDeploymentNumber

  lda #<>aSelectedCharacterBuffer
  sta wR1
  jsl rlCombineCharacterDataAndClassBases

  jsr rsUnknownMenuGetCharacterNameAndClass
  jsr rsUnknownMenuDrawLabels
  jsr $83B6C8
  jsr $83B7B6
  jsl rlEnableBG3Sync

  _End
  rtl

rlUnknown83B69F ; 82/B69F

  .autsiz
  .databank `aBG3TilemapBuffer

  php
  rep #$30
  ldx #(size(aBG3TilemapBuffer) / 2) - 2
  lda #$01DF

  -
  sta aBG3TilemapBuffer,x
  dec x
  dec x
  bpl -

  plp
  rtl

rsUnknownMenuGetCharacterNameAndClass ; 83/B6A0

  .al
  .xl
  .autsiz
  .databank ?

  lda #$2180
  sta wUnknown000DE7,b

  lda aSelectedCharacterBuffer.Character,b
  jsl rlGetCharacterNamePointer
  ldx #19 | (0 << 8)
  jsl $87E728

  lda aSelectedCharacterBuffer.Class,b
  and #$00FF
  jsl rlGetClassNamePointer
  sta lR18
  ldx #25 | (0 << 8)
  jsl $87E728

  rts

.comment

  83/B6C8:  A9702A    lda #$2A70
  83/B6CB:  8DE70D    sta wUnknown000DE7,b

  83/B6CE:  A21A02    ldx #26 | (2 << 8)
  83/B6D1:  AD760E    lda aSelectedCharacterBuffer.Level,b
  83/B6D4:  29FF00    and #$00FF
  83/B6D7:  22A9E487  jsl $87E4A9

  83/B6DB:  A21D02    ldx #$021D
  83/B6DE:  AD770E    lda $0E77
  83/B6E1:  29FF00    and #$00FF
  83/B6E4:  22A9E487  jsr $87E4A9

  83/B6E8:  A21A04    ldx #$041A
  83/B6EB:  AD790E    lda $0E79
  83/B6EE:  29FF00    and #$00FF
  83/B6F1:  22A9E487  jsr $87E4A9

  83/B6F5:  A21D04    ldx #$041D
  83/B6F8:  AD780E    lda $0E78
  83/B6FB:  29FF00    and #$00FF
  83/B6FE:  22A9E487  jsr $87E4A9

  83/B702:  A21D06    ldx #$061D
  83/B705:  AD7A0E    lda $0E7A
  83/B708:  29FF00    and #$00FF
  83/B70B:  22A9E487  jsr $87E4A9

  83/B70F:  A21D08    ldx #$081D
  83/B712:  AD7B0E    lda $0E7B
  83/B715:  29FF00    and #$00FF
  83/B718:  22A9E487  jsr $87E4A9

  83/B71C:  A21D0A    ldx #$0A1D
  83/B71F:  AD7C0E    lda $0E7C
  83/B722:  29FF00    and #$00FF
  83/B725:  22A9E487  jsr $87E4A9

  83/B729:  A21D0C    ldx #$0C1D
  83/B72C:  AD7D0E    lda $0E7D
  83/B72F:  29FF00    and #$00FF
  83/B732:  22A9E487  jsr $87E4A9

  83/B736:  A21D0E    ldx #$0E1D
  83/B739:  AD7F0E    lda $0E7F
  83/B73C:  29FF00    and #$00FF
  83/B73F:  22A9E487  jsr $87E4A9

  83/B743:  A21D10    ldx #$101D
  83/B746:  AD7E0E    lda $0E7E
  83/B749:  29FF00    and #$00FF
  83/B74C:  22A9E487  jsr $87E4A9

  83/B750:  A21D12    ldx #$121D
  83/B753:  AD800E    lda $0E80
  83/B756:  29FF00    and #$00FF
  83/B759:  22A9E487  jsr $87E4A9

  83/B75D:  A21D14    ldx #$141D
  83/B760:  AD820E    lda $0E82
  83/B763:  29FF00    and #$00FF
  83/B766:  22A9E487  jsr $87E4A9

  83/B76A:  A21A06    ldx #$061A
  83/B76D:  ADE750    lda $50E7
  83/B770:  29FF00    and #$00FF
  83/B773:  22A9E487  jsr $87E4A9

  83/B777:  A21A08    ldx #$081A
  83/B77A:  ADE850    lda $50E8
  83/B77D:  29FF00    and #$00FF
  83/B780:  22A9E487  jsr $87E4A9

  83/B784:  A21A0A    ldx #$0A1A
  83/B787:  ADE950    lda $50E9
  83/B78A:  29FF00    and #$00FF
  83/B78D:  22A9E487  jsr $87E4A9

  83/B791:  A21A0C    ldx #$0C1A
  83/B794:  ADEA50    lda $50EA
  83/B797:  29FF00    and #$00FF
  83/B79A:  22A9E487  jsr $87E4A9

  83/B79E:  A21A10    ldx #$101A
  83/B7A1:  ADEB50    lda $50EB
  83/B7A4:  29FF00    and #$00FF
  83/B7A7:  22A9E487  jsr $87E4A9

  83/B7AB:  A21A12    ldx #$121A
  83/B7AE:  29FF00    and #$00FF
  83/B7B1:  22A9E487  jsr $87E4A9

  83/B7B5:  60        rts


.endc
