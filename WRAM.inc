
.virtual $000000

  .union
    aDecompVariables         .fill $0B ; $000000
    .struct
      lDecompSource          .long ? ; $000000
      .union
        lDecompDest          .long ? ; $000003
        .struct
          bDecompVar0        .byte ? ; $000003
          bDecompVar1        .byte ? ; $000004
          bDecompMethodCount .byte ? ; $000005
        .ends
      .endu
      lDecompTemp            .long ? ; $000006
      bDecompCount           .byte ? ; $000009
      bDecompFlag            .byte ? ; $00000A
    .ends
  .endu

  wR0 .word ? ; $00000B
  wR1 .word ? ; $00000D
  wR2 .word ? ; $00000F
  wR3 .word ? ; $000011
  wR4 .word ? ; $000013
  wR5 .word ? ; $000015
  wR6 .word ? ; $000017
  wR7 .word ? ; $000019
  wR8 .word ? ; $00001B
  wR9 .word ? ; $00001D
  .union
    dwR10 .dword ? ; $00001F
    .struct
      wR10 .word ? ; $00001F
      wR11 .word ? ; $000021
    .ends
  .endu
  .union
    dwR12 .dword ? ; $000023
    .struct
      wR12 .word ? ; $000023
      wR13 .word ? ; $000025
    .ends
  .endu
  .union
    .struct
      dwR14 .dword ? ; $000027
      dwR16 .dword ? ; $00002B
    .ends
    .struct
      wR14 .word ? ; $000027
      wR15 .word ? ; $000029
      wR16 .word ? ; $00002B
      wR17 .word ? ; $00002D
    .ends
  .endu
  lR18 .long ? ; $00002F
  .union
    wR19 .word ? ; $000032
    lR19 .long ? ; $000032
  .endu
  .union
    wR20 .word ? ; $000035
    lR20 .long ? ; $000035
  .endu
  .union
    wR21 .word ? ; $000038
    lR21 .long ? ; $000038
  .endu
  .union
    wR22 .word ? ; $00003B
    lR22 .long ? ; $00003B
  .endu
  .union
    wR23 .word ? ; $00003E
    lR23 .long ? ; $00003E
  .endu
  .union
    wR24 .word ? ; $000041
    lR24 .long ? ; $000041
  .endu
  lR25 .long ? ; $000044
  wR26 .word ? ; $000047
  wR27 .word ? ; $000049
  wR28 .word ? ; $00004B
  wR29 .word ? ; $00004D
  wR30 .word ? ; $00004F
  wR31 .word ? ; $000051
  wR32 .word ? ; $000053
  wR33 .word ? ; $000055
  wR34 .word ? ; $000057
  wR35 .word ? ; $000059
  .union
    dwR36 .dword ? ; $00005B
    .struct
      wR36 .word ? ; $00005B
      wR37 .word ? ; $00005D
    .ends
  .endu
  lR38 .long ? ; $00005F
  lR39 .long ? ; $000062
  wR40 .word ? ; $000065
  wR41 .word ? ; $000067
  wR42 .word ? ; $000069
  wR43 .word ? ; $00006B
  lR44 .long ? ; $00006D
  lR45 .long ? ; $000070
  wR46 .word ? ; $000073
  lR47 .long ? ; $000075
  lR48 .long ? ; $000078

  bBuf_INIDISP   .byte ? ; $00007B
  bBuf_OBSEL     .byte ? ; $00007C
  wBuf_OAMADD    .word ? ; $00007D
  bBuf_BGMODE    .byte ? ; $00007F
  bBuf_MOSAIC    .byte ? ; $000080
  bBuf_BG1SC     .byte ? ; $000081
  bBuf_BG2SC     .byte ? ; $000082
  bBuf_BG3SC     .byte ? ; $000083
  bBuf_BG4SC     .byte ? ; $000084
  bBuf_BG12NBA   .byte ? ; $000085
  bBuf_BG34NBA   .byte ? ; $000086
  bBuf_M7SEL     .byte ? ; $000087
  bBuf_W12SEL    .byte ? ; $000088
  bBuf_W34SEL    .byte ? ; $000089
  wBuf_BG1HOFS   .word ? ; $00008A
  wBuf_BG1VOFS   .word ? ; $00008C
  wBuf_BG2HOFS   .word ? ; $00008E
  wBuf_BG2VOFS   .word ? ; $000090
  wBuf_BG3HOFS   .word ? ; $000092
  wBuf_BG3VOFS   .word ? ; $000094
  wBuf_BG4HOFS   .word ? ; $000096
  wBuf_BG4VOFS   .word ? ; $000098
  bBuf_WOBJSEL   .byte ? ; $00009A
  bBuf_WH0       .byte ? ; $00009B
  bBuf_WH1       .byte ? ; $00009C
  bBuf_WH2       .byte ? ; $00009D
  bBuf_WH3       .byte ? ; $00009E
  bBuf_WBGLOG    .byte ? ; $00009F
  bBuf_WOBJLOG   .byte ? ; $0000A0
  bBuf_TM        .byte ? ; $0000A1
  bBuf_TS        .byte ? ; $0000A2
  bBuf_TMW       .byte ? ; $0000A3
  bBuf_TSW       .byte ? ; $0000A4
  bBuf_CGWSEL    .byte ? ; $0000A5
  bBuf_CGADSUB   .byte ? ; $0000A6
  bBuf_COLDATA_0 .byte ? ; $0000A7
  bBuf_COLDATA_1 .byte ? ; $0000A8
  bBuf_COLDATA_2 .byte ? ; $0000A9
  bBuf_COLDATA_3 .byte ? ; $0000AA
  bBuf_SETINI    .byte ? ; $0000AB

  .fill $10 ; Unknown, Unused?

  bBuf_NMITIMEN .byte ? ; $0000BC
  bBuf_VTIMEL   .byte ? ; $0000BD
  bBuf_VTIMEH   .byte ? ; $0000BE
  bBuf_HTIMEL   .byte ? ; $0000BF
  bBuf_HTIMEH   .byte ? ; $0000C0
  bBuf_HDMAEN   .byte ? ; $0000C1
  bBuf_MEMSEL   .byte ? ; $0000C2

  .fill $10 ; Unknown, Unused?

  wUnknown0000D3 .word ? ; $0000D3
  wUnknown0000D5 .word ? ; $0000D5
  wUnknown0000D7 .word ? ; $0000D7
  wUnknown0000D9 .word ? ; $0000D9
  wUnknown0000DB .word ? ; $0000DB
  wUnknown0000DD .word ? ; $0000DD

  .byte ? ; Unknown, Unused?

  wJoyLongTime  .word ? ; $0000E0
  wJoyShortTime .word ? ; $0000E2
  wJoy1Input    .word ? ; $0000E4
  wJoy2Input    .word ? ; $0000E6
  wJoy1New      .word ? ; $0000E8
  wJoy2New      .word ? ; $0000EA
  wJoy1Alt      .word ? ; $0000EC
  wJoy2Alt      .word ? ; $0000EE
  wJoy1Old      .word ? ; $0000F0

  .fill 4 ; Unknown, Unused?

  wJoy1PressTime .word ? ; $0000F6
  wJoy2Old       .word ? ; $0000F8

  .fill 4 ; Unknown, Unused?

  wJoy2PressTime .word ? ; $0000FE

  .union
    aBGPaletteBuffer  .fill $100 ; $000100
    .struct
      aBGPal0         .fill $20 ; $000100
      aBGPal1         .fill $20 ; $000120
      aBGPal2         .fill $20 ; $000140
      aBGPal3         .fill $20 ; $000160
      aBGPal4         .fill $20 ; $000180
      aBGPal5         .fill $20 ; $0001A0
      aBGPal6         .fill $20 ; $0001C0
      aBGPal7         .fill $20 ; $0001E0
    .ends
  .endu
  .union
    aOAMPaletteBuffer .fill $100 ; $000200
    .struct
      aOAMPal0        .fill $20 ; $000200
      aOAMPal1        .fill $20 ; $000220
      aOAMPal2        .fill $20 ; $000240
      aOAMPal3        .fill $20 ; $000260
      aOAMPal4        .fill $20 ; $000280
      aOAMPal5        .fill $20 ; $0002A0
      aOAMPal6        .fill $20 ; $0002C0
      aOAMPal7        .fill $20 ; $0002E0
    .ends
  .endu

  wUnknown000300 .word ? ; $000300
  wUnknown000302 .word ? ; $000302
  wUnknown000304 .word ? ; $000304
  lUnknown000306 .long ? ; $000306
  aUnknown000309 .fill (3 * $10) ; $000309

  wScreenBrightnessTimeIncrement .word ? ; $000339
  wScreenBrightnessTimer         .word ? ; $00033B
  wScreenBrightnessFlag          .word ? ; $00033D

  wUnknown00033F .word ? ; $00033F

  bUnknown000341          .byte ? ; $000341
  bHDMAPendingChannels    .byte ? ; $000342
  wNextDMAArrayStructOffs .word ? ; $000343
  bDMAArrayFlag           .byte ? ; $000345
  aDMAStructArray         .fill $100 ; $000346

  wDecompListPosition .word ?   ; $000446
  bDecompListFlag     .byte ?   ; $000448
  aDecompList         .fill $20 ; $000449

  bUnknown000469 .byte ? ; $000469
  bUnknown00046A .byte ? ; $00046A

  aRNTable          .fill 55  ; $00046B
  wNextRNIndex      .word ?   ; $0004A2
  bRNShuffleCounter .byte ?   ; $0004A4
  bRNShuffleValue   .byte ?   ; $0004A5

  lBlockCopySource .long ? ; $0004A6
  lBlockCopyDest   .long ? ; $0004A9
  wBlockCopySize   .word ? ; $0004AC
  .union
    aBlockCopyMVNRoutineSpace .fill 4 ; $0004AE
    rsBlockCopyMVNRAM
    .struct
      bBlockCopyMVNOpcode     .byte ? ; $0004AE
      bBlockCopyMVNDestBank   .byte ? ; $0004AF
      bBlockCopyMVNSourceBank .byte ? ; $0004B0
      bBlockCopyMVNRetOpcode  .byte ? ; $0004B1
    .ends
  .endu
  .union
    aBlockCopyMVPRoutineSpace .fill 4 ; $0004B2
    rsBlockCopyMVPRAM
    .struct
      bBlockCopyMVPOpcode     .byte ?   ; $0004B2
      bBlockCopyMVPDestBank   .byte ?   ; $0004B3
      bBlockCopyMVPSourceBank .byte ?   ; $0004B4
      bBlockCopyMVPRetOpcode  .byte ?   ; $0004B5
    .ends
  .endu

  .union
    aSoundSystemSpace    .fill $70 ; $0004B6
    .struct
      wSoundSystemOffset .word ?   ; $0004B6
      wSoundSystemBank   .word ?   ; $0004B8
      aUnknown0004BA     .fill 4   ; $0004BA
      aUnknown0004BE     .fill 4   ; $0004BE
      aUnknown0004C2     .fill 4   ; $0004C2
      aUnknown0004C6     .fill 4   ; $0004C6
      aUnknown0004CA     .fill 6   ; $0004CA
      aUnknown0004D0     .fill 6   ; $0004D0
      aUnknown0004D6     .fill (5 * 2) ; $0004D6
      aUnknown0004E0     .fill (5 * 2) ; $0004E0
      wUnknown0004EA     .word ?   ; $0004EA
      wUnknown0004EC     .word ?   ; $0004EC
      wUnknown0004EE     .word ?   ; $0004EE
      wUnknown0004F0     .word ?   ; $0004F0
      wUnknown0004F2     .word ?   ; $0004F2
      wUnknown0004F4     .word ?   ; $0004F4
      wUnknown0004F6     .word ?   ; $0004F6
      wUnknown0004F8     .word ?   ; $0004F8
      wUnknown0004FA     .word ?   ; $0004FA
      bUnknown0004FC     .byte ?   ; $0004FC
      bUnknown0004FD     .byte ?   ; $0004FD
      wUnknown0004FE     .word ?   ; $0004FE
      wUnknown000500     .word ?   ; $000500
      wUnknown000502     .word ?   ; $000502
      wUnknown000504     .word ?   ; $000504
      wUnknown000506     .word ?   ; $000506
      wUnknown000508     .word ?   ; $000508
      wUnknown00050A     .word ?   ; $00050A
      wUnknown00050C     .word ?   ; $00050C
      wUnknown00050E     .word ?   ; $00050E
      wUnknown000510     .word ?   ; $000510
      wUnknown000512     .word ?   ; $000512
      wUnknown000514     .word ?   ; $000514
      bUnknown000516     .byte ?   ; $000516
      bUnknown000517     .byte ?   ; $000517
      wUnknown000518     .word ?   ; $000518
      wUnknown00051A     .word ?   ; $00051A
      wUnknown00051C     .word ?   ; $00051C
      wUnknown00051E     .word ?   ; $00051E
      wUnknown000520     .word ?   ; $000520
      wUnknown000522     .word ?   ; $000522
      wUnknown000524     .word ?   ; $000524
    .ends
  .endu

  .union
    aProcRAM                  .fill $237  ; $000526
    .struct
      wProcFlag               .sint ?   ; $000526
      wProcIndex              .word ?   ; $000528
      lProcCodePointer        .long ?   ; $00052A
      wProcInput0             .word ?   ; $00052D
      wProcInput1             .word ?   ; $00052F
      wProcInput2             .word ?   ; $000531
      wProcInput3             .word ?   ; $000533
      wProcInput4             .word ?   ; $000535
      wProcInput5             .word ?   ; $000537
      wProcInput6             .word ?   ; $000539
      wProcInput7             .word ?   ; $00053B
      aProcHeaderTypeOffset   .fill $20 ; $00053D
      aProcHeaderTypeBank     .fill $20 ; $00055D
      aProcHeaderName         .fill $20 ; $00057D
      aProcHeaderBitfield     .fill $20 ; $00059D
      aProcHeaderOnCycle      .fill $20 ; $0005BD
      aProcHeaderCodeOffset   .fill $20 ; $0005DD
      aProcHeaderSleepTimer   .fill $20 ; $0005FD
      aProcHeaderUnknownTimer .fill $20 ; $00061D
      aProcBody0              .fill $20 ; $00063D
      aProcBody1              .fill $20 ; $00065D
      aProcBody2              .fill $20 ; $00067D
      aProcBody3              .fill $20 ; $00069D
      aProcBody4              .fill $20 ; $0006BD
      aProcBody5              .fill $20 ; $0006DD
      aProcBody6              .fill $20 ; $0006FD
      aProcBody7              .fill $20 ; $00071D
      aProcUnknownBitfield    .fill $20 ; $00073D
    .ends
  .endu

  .union
    aActiveSpriteRAM           .fill $327  ; $00075D
    .struct
      wActiveSpriteFlag        .word ?   ; $00075D
      wActiveSpriteIndex       .word ?   ; $00075F
      lActiveSpriteCodePointer .long ?   ; $000761

      aActiveSpriteTypeOffset  .fill $20 ; $000764
      aActiveSpriteBanks       .fill $20 ; $000784
      aActiveSpriteRenderer    .fill $20 ; $0007A4
      aActiveSpriteUpdater     .fill $20 ; $0007C4
      aActiveSpriteOnCycle     .fill $20 ; $0007E4
      aActiveSpriteFrameTimer  .fill $20 ; $000804
      aActiveSpriteCodeOffset  .fill $20 ; $000824
      aActiveSpriteFrameOffset .fill $20 ; $000844
      aUnknown000864           .fill $20 ; $000864
      aActiveSpriteXCoordinate .fill $20 ; $000884
      aUnknown0008A4           .fill $20 ; $0008A4
      aActiveSpriteYCoordinate .fill $20 ; $0008C4
      aActiveSpriteSpriteBase  .fill $20 ; $0008E4
      aUnknown000904           .fill $20 ; $000904
      aActiveSpritePalette     .fill $20 ; $000924
      aUnknown000944           .fill $20 ; $000944
      aUnknown000964           .fill $20 ; $000964
      aUnknown000984           .fill $20 ; $000984
      aUnknown0009A4           .fill $20 ; $0009A4
      aUnknown0009C4           .fill $20 ; $0009C4
      aUnknown0009E4           .fill $20 ; $0009E4
      aUnknown000A04           .fill $20 ; $000A04
      aUnknown000A24           .fill $20 ; $000A24
      aUnknown000A44           .fill $20 ; $000A44
      aUnknown000A64           .fill $20 ; $000A64
    .ends
  .endu

  aUnknownSpriteArray .fill size(structUnknownSpriteEntryRAM) * 32 ; $000A84

  wUnknown000C04 .word ? ; $000C04

  .fill $10

  wUnknown000C16 .word ? ; $000C16

  .fill $4C

  wUnknownSpriteArraySize  .word ? ; $000C64
  wUnknownSpriteArrayCount .word ? ; $000C66
  lSpriteRendererPointer   .long ? ; $000C68
  wUnknown000C6B           .word ? ; $000C6B

  .union
    aHDMAArraySpace                 .fill $A6 ; $000C6D
    .struct
      wUnknown000C6D                .word ?   ; $000C6D
      wHDMAArrayIndex               .word ?   ; $000C6F
      lHDMAArrayCodePointer         .long ?   ; $000C71
      bHDMAArrayPendingChannels     .byte ?   ; $000C74
      aHDMAArrayTypeOffset          .fill $10 ; $000C75
      aHDMAArrayTypeBank            .fill $10 ; $000C85
      aHDMAArrayBitfield            .fill $10 ; $000C95
      aHDMAArrayOnCycle             .fill $10 ; $000CA5
      aHDMAArrayCodeOffset          .fill $10 ; $000CB5
      aHDMAArraySleepTimer          .fill $10 ; $000CC5
      aHDMAArrayUnknownTimer        .fill $10 ; $000CD5
      aHDMAArrayTableOffset         .fill $10 ; $000CE5
      .union
        aHDMAArrayTableBankAndBBADx .fill $10 ; $000CF5
        .struct
          aHDMAArrayTableBank       .byte ?   ; $000CF5
          aHDMAArrayBBADxSetting    .byte ?   ; $000CF6
        .ends
      .endu
      .union
        aHDMAArrayDMAPxAndHDMABank  .fill $10 ; $000D05
        .struct
          aHDMAArrayDMAPxSetting    .byte ?   ; $000D05
          aHDMAArrayHDMABank        .byte ?   ; $000D06
        .ends
      .endu
    .ends
  .endu

  .union
    aIRQArraySpace           .fill $8B ; $000D15
    .struct
      wIRQArrayFlag          .word ?   ; $000D15
      wIRQArrayUnknownIndex1 .word ?   ; $000D17
      wIRQArrayUnknownIndex2 .word ?   ; $000D19
      wIRQArrayIndex         .word ?   ; $000D1B
      lIRQArrayCodePointer   .long ?   ; $000D1D
      aIRQArrayTypeOffset    .fill 2 * 8 ; $000D20
      aIRQArrayTypeBank      .fill 2 * 8 ; $000D30
      aIRQArrayBitfield      .fill 2 * 8 ; $000D40
      aIRQArrayHTimerSetting .fill 2 * 8 ; $000D50
      aIRQArrayVTimerSetting .fill 2 * 8 ; $000D60
      aIRQArrayOnCycle       .fill 2 * 8 ; $000D70
      aIRQArrayCodeOffset    .fill 2 * 8 ; $000D80
      aIRQArraySleepTimer    .fill 2 * 8 ; $000D90
    .ends
  .endu

  .union
    aUnknownArraySpace .fill $23 ; $000DA0
    .struct
      aUnknown000DA0   .fill 2 * 3 ; $000DA0
      wUnknown000DA6   .word ?   ; $000DA6
      wUnknown000DA8   .word ?   ; $000DA8
      wUnknown000DAA   .word ?   ; $000DAA
      wUnknown000DAC   .word ?   ; $000DAC
      wUnknown000DAE   .word ?   ; $000DAE
      wUnknown000DB0   .word ?   ; $000DB0
      lUnknown000DB2   .long ?   ; $000DB2
      lUnknown000DB5   .long ?   ; $000DB5
      lUnknown000DB8   .long ?   ; $000DB8
      lUnknown000DBB   .long ?   ; $000DBB
      lUnknown000DBE   .long ?   ; $000DBE
      wUnknown000DC1   .word ?   ; $000DC1
    .ends
  .endu

  .union
    .fill $32
    .struct
      aUnknown000DC3 .fill $1B ; $000DC3
      lUnknown000DDE .long ?   ; $000DDE
      lUnknown000DE1 .long ?   ; $000DE1
      lUnknown000DE4 .long ?   ; $000DE4
      wUnknown000DE7 .word ?   ; $000DE7
      wUnknown000DE9 .word ?   ; $000DE9
    .ends
  .endu

  .union
    .fill $10
    .struct
      lUnknown000DF5 .long ? ; $000DF5
    .ends
  .endu

  wIngameTime  .word ? ; $000E05
  wMenuCounter .word ? ; $000E07

  wWinCounter     .word ? ; $000E09
  wCaptureCounter .word ? ; $000E0B

  wParagonModeEnable .word ? ; $000E0D

  wCursorCycleTimer .word ? ; $000E0F

  wCurrentChapter .word ? ; $000E11
  wCurrentTurn    .word ? ; $000E13
  wCurrentPhase   .word ? ; $000E15

  wDefaultVisibilityFill .word ? ; $000E17
  wVisionRange           .word ? ; $000E19

  wSaveSlotOffset .word ? ; $000E1B
  wUnknown000E1D  .word ? ; $000E1D
  wUnknown000E1F  .word ? ; $000E1F

  wChapterBoss .word ? ; $000E21

  wUnknown000E23 .word ? ; $000E23
  wUnknown000E25 .word ? ; $000E25
  wUnknown000E27 .word ? ; $000E27

  wPrepScreenFlag .word ? ; $000E29
  wUnknown000E2B  .word ? ; $000E2B

  wCurrentMapMusic .word ? ; $000E2D

  wMapWidth16                  .word ? ; $000E2F
  wMapHeight16                 .word ? ; $000E31
  wMapWidthPixels              .word ? ; $000E33
  wMapHeightPixels             .word ? ; $000E35
  wMapScrollWidth16            .word ? ; $000E37
  wMapScrollHeight16           .word ? ; $000E39
  wMapScrollWidthPixels        .word ? ; $000E3B
  wMapScrollHeightPixels       .word ? ; $000E3D
  wMapOffsetWidthPixels        .word ? ; $000E3F
  wMapOffsetHeightPixels       .word ? ; $000E41
  wMapPartialScrollWidthTimer  .word ? ; $000E43
  wMapPartialScrollHeightTimer .word ? ; $000E45
  s16MapScrollWidthModifier    .sint ? ; $000E47
  s16MapScrollHeightModifier   .sint ? ; $000E49
  wCursorTileIndex             .word ? ; $000E4B
  wCursorXCoord                .word ? ; $000E4D
  wCursorYCoord                .word ? ; $000E4F
  wCursorXCoordPixelsScrolling .word ? ; $000E51
  wCursorYCoordPixelsScrolling .word ? ; $000E53
  wCursorXCoordPixels          .word ? ; $000E55
  wCursorYCoordPixels          .word ? ; $000E57
  wCursorXOffset               .word ? ; $000E59
  wCursorYOffset               .word ? ; $000E5B

  wMoveDestTileIndex  .word ? ; $000E5D
  wMoveStartTileIndex .word ? ; $000E5F

  wSelectedUnitXCoord .word ? ; $000E61
  wSelectedUnitYCoord .word ? ; $000E63

  wUnknown000E65 .word ? ; $000E65

  wMapTileCount     .word ? ; $000E67
  wMapRowSize       .word ? ; $000E69
  wDisplayRangeFlag .word ? ; $000E6B
  wUnknown000E6D    .word ? ; $000E6D

  aSelectedCharacterBuffer    .dstruct structExpandedCharacterDataRAM ; $000E6F
  aTargetingCharacterBuffer   .dstruct structExpandedCharacterDataRAM ; $000EB3
  aBurstWindowCharacterBuffer .dstruct structExpandedCharacterDataRAM ; $000EF7

  aItemDataBuffer .dstruct structItemDataEntryRAM ; $000F3B

  bUnknown000F54   .byte ? ; $000F54
  bMovementCostCap .byte ? ; $000F55

  aUnknownActionStruct000F56 .dstruct structActionStructEntry ; $000F56

  aItemSkillCharacterBuffer .dstruct structExpandedCharacterDataRAM ; $000FC7

  ; Unknown
  .fill $2D ; $00100B

  .union
    aRangePathArray    .fill $500  ; $001038
    .struct
      aRangePathArray1 .fill $280  ; $001038
      aRangePathArray2 .fill $280  ; $0012B8
    .ends
  .endu

  wMenuType                 .word ?   ; $001538
  aUnknown00153A            .fill $20 ; $00153A
  aUnknown00155A            .fill $20 ; $00155A
  s16UnknownSpriteXModifier .sint ?   ; $00157A
  bUnknown00157C            .byte ?   ; $00157C
  s16UnknownSpriteYModifier .sint ?   ; $00157D
  bUnknown00157F            .byte ?   ; $00157F
  bUnknown001580            .byte ?   ; $001580
  bUnknown001581            .byte ?   ; $001581
  bUnknown001582            .byte ?   ; $001582
  bUnknown001583            .byte ?   ; $001583
  bUnknown001584            .byte ?   ; $001584
  bUnknown001585            .byte ?   ; $001585
  wUnknown001586            .word ?   ; $001586
  wUnknown001588            .word ?   ; $001588
  wUnknown00158A            .word ?   ; $00158A
  wUnknown00158C            .word ?   ; $00158C
  wUnknown00158E            .word ?   ; $00158E
  wUnknown001590            .word ?   ; $001590
  wUnknown001592            .word ?   ; $001592
  wUnknown001594            .word ?   ; $001594
  wUnknown001596            .word ?   ; $001596
  wUnknown001598            .word ?   ; $001598
  wUnknown00159A            .word ?   ; $00159A
  wUnknown00159C            .word ?   ; $00159C
  lUnknown00159E            .long ?   ; $00159E
  wUnknown0015A1            .word ?   ; $0015A1
  wUnknown0015A3            .word ?   ; $0015A3
  wUnknown0015A5            .word ?   ; $0015A5
  wUnknown0015A7            .word ?   ; $0015A7
  wUnknown0015A9            .word ?   ; $0015A9
  wUnknown0015AB            .word ?   ; $0015AB
  wUnknown0015AD            .word ?   ; $0015AD
  wUnknown0015AF            .word ?   ; $0015AF
  wUnknown0015B1            .word ?   ; $0015B1
  bUnknown0015B3            .byte ?   ; $0015B3
  bUnknown0015B4            .byte ?   ; $0015B4
  wUnknown0015B5            .word ?   ; $0015B5
  wUnknown0015B7            .word ?   ; $0015B7
  wUnknown0015B9            .word ?   ; $0015B9
  wUnknown0015BB            .word ?   ; $0015BB
  wUnknown0015BD            .word ?   ; $0015BD
  wUnknown0015BF            .word ?   ; $0015BF
  aUnknown0015C1            .fill 4   ; $0015C1
  aUnknown0015C5            .fill 8   ; $0015C5
  aUnknown0015CD            .fill 4   ; $0015CD
  aUnknown0015D1            .fill 4   ; $0015D1
  aUnknown0015D5            .fill 4   ; $0015D5
  aUnknown0015D9            .fill 4   ; $0015D9
  aUnknown0015DD            .fill 4   ; $0015DD
  aUnknown0015E1            .fill 4   ; $0015E1
  aUnknown0015E5            .fill 4   ; $0015E5
  aUnknown0015E9            .fill 4   ; $0015E9
  aUnknown0015ED            .fill 4   ; $0015ED
  aUnknown0015F1            .fill 4   ; $0015F1
  aUnknown0015F5            .fill 4   ; $0015F5
  aUnknown0015F9            .fill 4   ; $0015F9
  aUnknown0015FD            .fill 4   ; $0015FD
  aUnknown001601            .fill 4   ; $001601
  aUnknown001605            .fill 4   ; $001605
  aUnknown001609            .fill 4   ; $001609
  aUnknown00160D            .fill 4   ; $00160D
  wUnknown001611            .word ?   ; $001611
  wUnknown001613            .word ?   ; $001613
  wUnknown001615            .word ?   ; $001615
  wUnknown001617            .word ?   ; $001617
  wUnknown001619            .word ?   ; $001619
  aUnknown00161B            .fill $20 ; $00161B
  aUnknown00163B            .fill $20 ; $00163B
  wUnknown00165B            .word ?   ; $00165B
  wUnknown00165D            .word ?   ; $00165D
  wUnknown00165F            .word ?   ; $00165F
  wUnknown001661            .word ?   ; $001661
  wUnknown001663            .word ?   ; $001663
  wUnknown001665            .word ?   ; $001665
  wUnknown001667            .word ?   ; $001667
  bUnknown001669            .byte ?   ; $001669
  bUnknown00166A            .byte ?   ; $00166A
  wUnknown00166B            .word ?   ; $00166B
  wUnknown00166D            .word ?   ; $00166D
  wUnknown00166F            .word ?   ; $00166F
  wUnknown001671            .word ?   ; $001671
  wUnknown001673            .word ?   ; $001673
  wUnknown001675            .word ?   ; $001675
  wUnknown001677            .word ?   ; $001677
  wUnknown001679            .word ?   ; $001679
  bUnknown00167B            .byte ?   ; $00167B
  bUnknown00167C            .byte ?   ; $00167C
  bUnknown00167D            .byte ?   ; $00167D
  bUnknown00167E            .byte ?   ; $00167E

  ; Unknown
  .fill $A1

  wUnknown001720                       .word ?   ; $001720
  wUnknown001722                       .word ?   ; $001722
  wUnknown001724                       .word ?   ; $001724
  lUnknown001726                       .long ?   ; $001726
  lUnknown001729                       .long ?   ; $001729
  wEventEngineStatus                   .word ?   ; $00172C
  wEventEngineCycleType                .word ?   ; $00172E
  wUnknown001730                       .word ?   ; $001730
  wUnknown001732                       .word ?   ; $001732
  wEventEngineCharacterStructParameter .word ?   ; $001734
  wEventEngineCharacterTarget          .word ?   ; $001736
  wEventEngineXCoordinate              .word ?   ; $001738
  wEventEngineYCoordinate              .word ?   ; $00173A
  wEventEngineXCoordinateAlt           .word ?   ; $00173C
  wEventEngineYCoordinateAlt           .word ?   ; $00173E
  wEventEngineParameter1               .word ?   ; $001740
  wEventEngineParameter2               .word ?   ; $001742
  wEventEngineParameter3               .word ?   ; $001744
  lEventEngineLongParameter            .long ?   ; $001746
  wEventEngineUnknownTileChangeIndex   .word ?   ; $001749
  wEventEngineTruthFlag                .word ?   ; $00174B
  aEventCharacterBuffer .dstruct structExpandedCharacterDataRAM ; $00174D
  wUnknown001791                       .word ?   ; $001791
  wEventExecutionOffset                .word ?   ; $001793
  lEventStartPointer                   .long ?   ; $001795
  lEventEngineUnitGroupPointer         .long ?   ; $001798
  bEventEngineUnitLoadingFlag          .byte ?   ; $00179B
  lEventEngineEventDefinitionPointer   .long ?   ; $00179C
  aEventEngineActiveProcs              .fill $20 ; $00179F
  aUnknown0017BF                       .fill 8   ; $0017BF
  aUnknown0017C7                       .fill 8   ; $0017C7
  aUnknown0017CF                       .fill 8   ; $0017CF
  wUnknown0017D7                       .word ?   ; $0017D7
  wUnknown0017D9                       .word ?   ; $0017D9
  wUnknown0017DB                       .word ?   ; $0017DB
  wUnknown0017DD                       .word ?   ; $0017DD
  wUnknown0017DF                       .word ?   ; $0017DF
  aUnknown0017E1                       .fill 4   ; $0017E1
  aUnknown0017E5                       .fill 4   ; $0017E5
  wUnknown0017E9                       .word ?   ; $0017E9
  wUnknown0017EB                       .word ?   ; $0017EB
  wUnknown0017ED                       .word ?   ; $0017ED
  wUnknown0017EF                       .word ?   ; $0017EF
  wUnknown0017F1                       .word ?   ; $0017F1
  wUnknown0017F3                       .word ?   ; $0017F3
  wUnknown0017F5                       .word ?   ; $0017F5
  wUnknown0017F7                       .word ?   ; $0017F7
  bUnknown0017F9                       .byte ?   ; $0017F9
  wUnknown0017FA                       .word ?   ; $0017FA
  wUnknown0017FC                       .word ?   ; $0017FC
  wUnknown0017FE                       .word ?   ; $0017FE
  wUnknown001800                       .word ?   ; $001800
  wUnknown001802                       .word ?   ; $001802
  wUnknown001804                       .word ?   ; $001804
  wUnknown001806                       .word ?   ; $001806
  wUnknown001808                       .word ?   ; $001808
  aUnknown00180A                       .fill $26 ; $00180A
  wUnknown001830                       .word ?   ; $001830
  wUnknown001832                       .word ?   ; $001832
  wUnknown001834                       .word ?   ; $001834
  wUnknown001836                       .word ?   ; $001836
  wUnknown001838                       .word ?   ; $001838
  bUnknown00183A                       .byte ?   ; $00183A
  wUnknown00183B                       .word ?   ; $00183B
  bUnknown00183D                       .byte ?   ; $00183D
  lUnknown00183E                       .long ?   ; $00183E
  bUnknown001841                       .byte ?   ; $001841
  wUnknown001842                       .word ?   ; $001842
  bUnknown001844                       .byte ?   ; $001844
  bUnknown001845                       .byte ?   ; $001845
  wUnknown001846                       .word ?   ; $001846
  wUnknown001848                       .word ?   ; $001848

  .fill 4 ; Unknown

  bUnknown00184E .byte ? ; $00184E
  bUnknown00184F .byte ? ; $00184F

  .fill $13 ; Unknown

  bUnknown001863 .byte ? ; $001863

  .fill $42 ; Unknown

  bUnknown0018A6 .byte ? ; $0018A6

  .fill $22A ; Unknown

  wUnknown001AD1 .word ? ; $001AD1
  lUnknown001AD3 .long ? ; $001AD3
  wUnknown001AD6 .word ? ; $001AD6

  .fill 6

  wUnknown001ADE .word ?   ; $001ADE
  aUnknown001AE0 .fill $16 ; $001AE0

  .fill $10A ; Unknown

  aSpriteBuf .fill (size(structPPUOAMEntry) * 128) ; $001C00
  aSpriteBufUpperAttributes .fill (2 * 128)/8 ; $001E00
  wNextFreeSpriteOffs       .word ? ; $001E20
  wUnknown1E22              .word ? ; $001E22

  .union
  aStackSpace .fill $1D4  ; $001E24
    .struct
      StackEnd ; $001E24
      aStackBody     .fill $1D3  ; $001E24
      StackFirstFree .fill 1   ; $001FF7
      StackStart ; $001FF8
    .ends
  .endu

  aEngineNameUnknown .fill 4 ; $001FF8
  aEngineName        .fill 4 ; $001FFC

.endv

.virtual $7E2000

  aUnknownSoundDecompBuffer1 .fill $1000 ; $7E2000
  aUnknownSoundDecompBuffer2 .fill $1000 ; $7E3000

  wUnknownIndex7E4000    .word ? ; $7E4000
  wUnknown7E4002         .word ? ; $7E4002
  p16UnknownStackPointer .word ? ; $7E4004
  wUnknownCharacterIndex .word ? ; $7E4006
  wUnknown7E4008         .word ? ; $7E4008
  wUnknown7E400A         .word ? ; $7E400A
  wUnknown7E400C         .word ? ; $7E400C
  wUnknown7E400E         .word ? ; $7E400E
  wUnknown7E4010         .word ? ; $7E4010
  wUnknown7E4012         .word ? ; $7E4012
  wUnknown7E4014         .word ? ; $7E4014
  wUnknown7E4016         .word ? ; $7E4016

  .fill ($7E45AF - *)

  lUnknown7E45AF .long ? ; $7E45AF
  lUnknown7E45B2 .long ? ; $7E45B2
  lUnknown7E45B5 .long ? ; $7E45B5
  wUnknown7E45B8 .word ? ; $7E45B8

  .fill ($7E45BC - *)

  lUnknownDialogueTextTilemapBufferPosition .long ?   ; $7E45BC
  wUnknown7E45BF                            .word ?   ; $7E45BF
  wUnknown7E45C1                            .word ?   ; $7E45C1

  .fill ($7E45D8 - *)

  wUnknown7E45D8 .word ? ; $7E45D8

  .fill ($7E496E - *)

  aPermanentEventFlags              .fill 5   ; $7E496E
  aTemporaryEventFlags              .fill 12  ; $7E4973

  aRandomizedItems   .fill 2 * 2 * 16  ; $7E497F
  aRandomizedNumbers .fill 32  ; $7E49BF

  .fill ($7E4E06 - *)

  wInventoryActionIndex .word ? ; $7E4E06

  .fill ($7E4E0A - *)

  wPrepItemsActionIndex  .word ?   ; $7E4E0A
  wInventoryScrolledFlag .word ?   ; $7E4E0C

  .fill ($7E4E10 - *)

  wPrepItemsListSortMethod .word ?   ; $7E4E10

  .fill ($7E4E14 - *)

  wInfoWindowTarget .word ?   ; $7E4E14

  .fill ($7E4E18 - *)

  aOptions .block                    ; $7E4E18
    wWindowOption            .word ? ; $7E4E18
    wWindowOption1UpperRed   .word ? ; $7E4E1A
    wWindowOption1UpperGreen .word ? ; $7E4E1C
    wWindowOption1UpperBlue  .word ? ; $7E4E1E
    wWindowOption1LowerRed   .word ? ; $7E4E20
    wWindowOption1LowerGreen .word ? ; $7E4E22
    wWindowOption1LowerBlue  .word ? ; $7E4E24
    wWindowOption2UpperRed   .word ? ; $7E4E26
    wWindowOption2UpperGreen .word ? ; $7E4E28
    wWindowOption2UpperBlue  .word ? ; $7E4E2A
    wWindowOption2LowerRed   .word ? ; $7E4E2C
    wWindowOption2LowerGreen .word ? ; $7E4E2E
    wWindowOption2LowerBlue  .word ? ; $7E4E30
    wWindowOption3UpperRed   .word ? ; $7E4E32
    wWindowOption3UpperGreen .word ? ; $7E4E34
    wWindowOption3UpperBlue  .word ? ; $7E4E36
    wWindowOption3LowerRed   .word ? ; $7E4E38
    wWindowOption3LowerGreen .word ? ; $7E4E3A
    wWindowOption3LowerBlue  .word ? ; $7E4E3C
    wWindowOption4UpperRed   .word ? ; $7E4E3E
    wWindowOption4UpperGreen .word ? ; $7E4E40
    wWindowOption4UpperBlue  .word ? ; $7E4E42
    wWindowOption4LowerRed   .word ? ; $7E4E44
    wWindowOption4LowerGreen .word ? ; $7E4E46
    wWindowOption4LowerBlue  .word ? ; $7E4E48
    wWindowOption5UpperRed   .word ? ; $7E4E4A
    wWindowOption5UpperGreen .word ? ; $7E4E4C
    wWindowOption5UpperBlue  .word ? ; $7E4E4E
    wWindowOption5LowerRed   .word ? ; $7E4E50
    wWindowOption5LowerGreen .word ? ; $7E4E52
    wWindowOption5LowerBlue  .word ? ; $7E4E54
    wAnimationOption         .word ? ; $7E4E56
    wTerrainWindowOption     .word ? ; $7E4E58
    wBurstWindowOption       .word ? ; $7E4E5A
    wTextSpeedOption         .word ? ; $7E4E5C
    wUnitSpeedOption         .word ? ; $7E4E5E
    wSoundOption             .word ? ; $7E4E60
    wBGMOption               .word ? ; $7E4E62
    wAutocursorOption        .word ? ; $7E4E64
    wVolumeOption            .word ? ; $7E4E66
  .bend

  .fill ($7E4F67 - *)

  wSelectedTileSettingUpperRed   .word ? ; $7E4F67
  wSelectedTileSettingUpperGreen .word ? ; $7E4F69
  wSelectedTileSettingUpperBlue  .word ? ; $7E4F6B
  wSelectedTileSettingLowerRed   .word ? ; $7E4F6D
  wSelectedTileSettingLowerGreen .word ? ; $7E4F6F
  wSelectedTileSettingLowerBlue  .word ? ; $7E4F71

  .fill ($7E4F83 - *)

  wBGUpdateFlags .word ? ; $7E4F83

  .fill ($7E4F89 - *)

  wBurstWindowTargetDeploymentNumber .word ? ; $7E4F89
  wBurstWindowTargetXCoordinate      .word ? ; $7E4F8B
  wBurstWindowTargetYCoordinate      .word ? ; $7E4F8D
  wBurstWindowDelayCounter           .word ? ; $7E4F8F
  wBurstWindowDrawn                  .word ? ; $7E4F91

  lGold .long ? ; $7E4F93

  .fill ($7E4FA0 - *)

  wEventEngineUnknownXTarget .word ? ; $7E4FA0
  wEventEngineUnknownYTarget .word ? ; $7E4FA2

  .fill ($7E4FB8 - *)

  wLastSavedSlot .word ? ; $7E4FB8

  .fill ($7E4FC2 - *)

  wObjectiveMarkerFrame .word ? ; $7E4FC2

  .fill ($7E4FCA - *)

  wTurnEndXCoordinate .word ? ; $7E4FCA
  wTurnEndYCoordinate .word ? ; $7E4FCC

  bUnknownTargetingDeploymentNumber .byte ? ; $7E4FCE
  bUnknown7E4FCF                    .byte ? ; $7E4FCF

  aConvoy .fill 2 * 128 ; $7E4FD0

  .fill ($7E50D2 - *)

  aUNITEntryBuffer     .dstruct structUNITEntry  ; $7E50D2
  aClassDataBuffer     .dstruct structClassDataEntry ; $7E50E6
  aCharacterDataBuffer .dstruct structCharacterDataROMEntry ; $7E510A
  aItemStatBonusBuffer .dstruct structItemStatBonuses  ; $7E513A

  aMapTileRowIndexes        .fill 2 * 64 ; $7E5142
  wPreviousMapTileRowAmount .word ? ; $7E51C2
  wNextMapTileAmount        .word ? ; $7E51C4
  wNextMapTileRowAmount     .word ? ; $7E51C6
  wPreviousMapTileAmount    .word ? ; $7E51C8

  wPlayerUnitTargetFlag .word ? ; $7E51CA

  wCurrentRegisteringMapSpriteID         .word ? ; $7E51CC
  wCurrentRegisteringMapSpriteArrayIndex .word ? ; $7E51CE
  wCurrentRegisteringMapSpriteVRAMOffset .word ? ; $7E51D0

  .word ? ; $7E51D2

  wAttackItemSelectionHighestMight .word ? ; $7E51D4
  wAttackItemSelectionHighestHit   .word ? ; $7E51D6
  wAttackItemSelectionHighestAvoid .word ? ; $7E51D8
  wAttackItemSelectionHighestCrit  .word ? ; $7E51DA

  wMapScrollHorizontalReturnDirectionFlag .word ? ; $7E51DC
  wMapScrollVerticalReturnDirectionFlag   .word ? ; $7E51DE
  dwMapScrollReturnXStart                 .dword ? ; $7E51E0
  dwMapScrollReturnYStart                 .dword ? ; $7E51E4
  wMapScrollReturnRemainingPixelDistance  .word ? ; $7E51E8
  wMapScrollReturnXDistance               .word ? ; $7E51EA
  wMapScrollReturnYDistance               .word ? ; $7E51EC
  wMapScrollReturnVerticalDominantFlag    .word ? ; $7E51EE
  wMapScrollReturnStepIndex               .word ? ; $7E51F0

  bUnknown7E51F2 .byte ? ; $7E51F2
  wUnknown7E51F3 .word ? ; $7E51F3
  bUnknown7E51F5 .byte ? ; $7E51F5
  wUnknown7E51F6 .word ? ; $7E51F6
  bUnknown7E51F8 .byte ? ; $7E51F8
  wUnknown7E51F9 .word ? ; $7E51F9
  bUnknown7E51FB .byte ? ; $7E51FB

  .fill ($7E520A - *)

  wEnemyUnitTargetFlag .word ? ; $7E520A

  aTerrainMovementCostBuffer .dstruct structTerrainEntry ; $7E520C

  .fill ($7E524A - *)

  wNPCUnitTargetFlag .word ? ; $7E524A

  .fill ($7E5250 - *)

  wObjectiveMarkerColorIndex .word ? ; $7E5250
  wObjectiveMarkerColorValue .word ? ; $7E5252
  aObjectiveMarkers .fill 7 * size(structObjectiveMarkerEntryRAM) ; $7E5254

  aAllegianceInfo     .block ; $7E528C
    bAlliedAllegiance .byte ? ; $7E528C
    bEnemyAllegiance  .byte ? ; $7E528D
    bNPCAllegiance    .byte ? ; $7E528E
                      .byte ? ; $7E528F
    .bend

  aPhaseControllerInfo     .block ; $7E5290
    bPlayerPhaseController .byte ? ; $7E5290
    bEnemyPhaseController  .byte ? ; $7E5291
    bNPCPhaseController    .byte ? ; $7E5292
                           .byte ? ; $7E5293
  .bend

  aAllegianceTargets            .block ; $7E5294
    bAlliedAllegianceTargetable .byte ? ; $7E5294
    bEnemyAllegianceTargetable  .byte ? ; $7E5295
    bNPCAllegianceTargetable    .byte ? ; $7E5296
                                .byte ? ; $7E5297
  .bend

  aPlayerUnits .fill size(structCharacterDataRAM) * 48 ; $7E5298
  aEnemyUnits  .fill size(structCharacterDataRAM) * 51 ; $7E5EC8
  aNPCUnits    .fill size(structCharacterDataRAM) * 16 ; $7E6BBB

  .union
    .struct
      aPlayerVisibleUnitMap .fill $600 ; $7E6FCB
      aUnitMap              .fill $600 ; $7E75CB
    .ends
    .struct
      aPrepItemsListItemArray  .fill (2 * $300) ; $7E6FCB
      aPrepItemsListOwnerArray .fill (2 * $300) ; $7E75CB
    .ends
  .endu

  aTerrainMap        .fill $600 ; $7E7BCB
  aMapMetatileMap    .fill 2 * $600 ; $7E81CB
  aVisibilityMap     .fill $600 ; $7E8DCB
  aTargetableUnitMap .fill $600 ; $7E93CB
  aThreatenedTileMap .fill $600 ; $7E99CB

  aCameraPanStepArray .fill $100 ; $7E9FCB

  aUnknown7EA0CB .fill 2 ; $7EA0CB

  aIconArrayIconTableIndex .fill 2 * 24 ; $7EA0CD
  aIconArrayTileIndex      .fill 2 * 24 ; $7EA0FD
  aIconArrayXCoordinate    .fill 2 * 24 ; $7EA12D
  aIconArrayYCoordinate    .fill 2 * 24 ; $7EA15D
  aIconArrayAttributes     .fill 2 * 24 ; $7EA18D
  aIconArrayFlag           .fill 2 * 24 ; $7EA1BD

  wMenuLineScrollCount     .word ? ; $7EA1ED
  wMenuMinimumLine         .word ? ; $7EA1EF
  wMenuMaximumLine         .word ? ; $7EA1F1
  wMenuUpScrollThreshold   .word ? ; $7EA1F3
  wMenuDownScrollThreshold .word ? ; $7EA1F5
  wMenuBottomThreshold     .word ? ; $7EA1F7

  .fill ($7EA202 - *)

  aLossesTable     .fill 49 ; $7EA202
  aWinsTable       .fill 49 ; $7EA233
  aTurncountsTable .fill size(structTurncountEntryRAM) * 40 ; $7EA264

  .fill ($7EA4EA - *)

  wCapturingFlag     .word ? ; $7EA4EA
  lUnknown7EA4EC     .long ? ; $7EA4EC
  aActionStructUnit1 .dstruct structActionStructEntry  ; $7EA4EF
  aActionStructUnit2 .dstruct structActionStructEntry  ; $7EA560

  .fill ($7EA69B - *)

  wAutolevelHPGrowth  .word ? ; $7EA69B
  wAutolevelSTRGrowth .word ? ; $7EA69D
  wAutolevelMAGGrowth .word ? ; $7EA69F
  wAutolevelSKLGrowth .word ? ; $7EA6A1
  wAutolevelSPDGrowth .word ? ; $7EA6A3
  wAutolevelDEFGrowth .word ? ; $7EA6A5
  wAutolevelCONGrowth .word ? ; $7EA6A7
  wAutolevelLUKGrowth .word ? ; $7EA6A9
  wAutolevelMOVGrowth .word ? ; $7EA6AB

  .fill ($7EA72D - *)

  aMovementDirectionArray            .fill $80 ; $7EA72D
  wPhaseChangeHPEffectArrayOffset    .word ?   ; $7EA7AD
  aPhaseChangeHPEffectArray          .fill 2 * 68  ; $7EA7AF
  aMapTilemapLeftTileScrollBuffer    .fill 2 * 2 * 16  ; $7EA837
  aMapTilemapRightTileScrollBuffer   .fill 2 * 2 * 16  ; $7EA877
  aRangeTilemapLeftTileScrollBuffer  .fill 2 * 2 * 16  ; $7EA8B7
  aRangeTilemapRightTileScrollBuffer .fill 2 * 2 * 16  ; $7EA8F7

  .union
    aPhaseGraphicBuffer .fill $1000 ; $7EA937
    .struct
      aRangeMap .fill $600 ; $7EA937

      .fill ($7EAF63 - *)

      wSaveSlotTempCurrentChapter   .word ? ; $7EAF63
      wSaveSlotTempCurrentTurn      .word ? ; $7EAF65
      wSaveSlotTempUnknown          .word ? ; $7EAF67
      wSaveSlotTempUnknown2         .word ? ; $7EAF69
      wSaveSlotTempUnknown3         .word ? ; $7EAF6B
      wSaveSlotTempUnknown4         .word ? ; $7EAF6D
      wSaveSlotTempTileSettingIndex .word ? ; $7EAF6F
                                    .word ? ; $7EAF71

      aMovementMap .fill $600 ; $7EAF73

      .fill ($7EB5AF - *)

      wInventoryScrollingStep              .word ? ; $7EB5AF
      wInventoryItemInfoWindowOffset       .word ? ; $7EB5B1
      wInventorySkillInfoWindowIndex       .word ? ; $7EB5B3
      wInventorySkillInfoWindowArrayOffset .word ? ; $7EB5B5
      aInventorySkillInfoWindowIconArray   .fill 32 ; $7EB5B7
      aInventorySkillInfoWindowTypeArray   .fill 32 ; $7EB5D7
      wBurstWindowStyle                    .word ? ; $7EB5F7
      wBurstWindowOriginXTile              .word ? ; $7EB5F9
      wBurstWindowOriginYTile              .word ? ; $7EB5FB
      wBurstWindowPositionXTile            .word ? ; $7EB5FD
      wBurstWindowPositionYTile            .word ? ; $7EB5FF
      wBurstWindowNameYTile                .word ? ; $7EB601

      .fill ($7EB603 - *)

      aPrepDeploymentSlots         .fill (2 * $60) ; $7EB603
      wPrepDeploymentSlotsOffset   .word ? ; $7EB6C3
      wPrepUnitListColumn          .word ? ; $7EB6C5
      wPrepUnitListRow             .word ? ; $7EB6C7
      wPrepMinimumDeployableUnits  .word ? ; $7EB6C9
      wPrepMaximumDeployableUnits  .word ? ; $7EB6CB
      wPrepSelectedDeployableUnits .word ? ; $7EB6CD
      wPrepTotalDeployableUnits    .word ? ; $7EB6CF

      .fill ($7EB6DB - *)

      wPrepUnitListTextCoordinateBase   .word ? ; $7EB6DB
      wPrepUnitListSpriteVerticalOffset .word ? ; $7EB6DD
      wPrepUnitListMovingFlag           .word ? ; $7EB6DF
                                        .word ? ; $7EB6E1
      wPrepScrollDirectionIncrement     .word ? ; $7EB6E3
      wPrepScrollDirectionStep          .word ? ; $7EB6E5
      wPrepListCursorXCoordinate        .word ? ; $7EB6E7
      wPrepListCursorYCoordinate        .word ? ; $7EB6E9
      wPrepItemsSelectedOption          .word ? ; $7EB6EB
      wPrepItemsDiscardIndex            .word ? ; $7EB6ED
      wPrepItemsDiscardLength           .word ? ; $7EB6EF
      wPrepUnitListLastSelectedColumn   .word ? ; $7EB6F1
      wPrepUnitListLastSelectedRow      .word ? ; $7EB6F3
      wPrepUnitListLastScrollOffset     .word ? ; $7EB6F5
      wPrepUnitListLastScrolledMenuLine .word ? ; $7EB6F7
    .ends
    .struct
      aFadingPaletteSpace .fill 8 * $120 ; $7EA937

      .fill ($7EB71D - *)

      aFadingBGPaletteBands  .fill 2 * 3 * $60 ; $7EB71D
      aFadingOAMPaletteBands .fill 2 * 3 * $40 ; $7EB95D
    .ends
    .struct
      aRandomizedItemCreationArray .fill 2 * 2 * 16 ; $7EA937
    .ends
    .struct
      lUnitGroupLoadingPointer        .long ? ; $7EA937
      wUnitGroupLoadingCount          .word ? ; $7EA93A
      wUnitGroupLoadingInventoryIndex .word ? ; $7EA93C

      .fill ($7EACE2 - *)

      .union
        aFullInventoryConvoyBuffer .fill 2 * 8 ; $7EACE2
        .struct
          wFullInventoryConvoyBufferItem1   .word ? ; $7EACE2
          wFullInventoryConvoyBufferItem2   .word ? ; $7EACE4
          wFullInventoryConvoyBufferItem3   .word ? ; $7EACE6
          wFullInventoryConvoyBufferItem4   .word ? ; $7EACE8
          wFullInventoryConvoyBufferItem5   .word ? ; $7EACEA
          wFullInventoryConvoyBufferItem6   .word ? ; $7EACEC
          wFullInventoryConvoyBufferItem7   .word ? ; $7EACEE
          wFullInventoryConvoyBufferItemNew .word ? ; $7EACF0
        .ends
      .endu
    .ends
  .endu

  .fill ($7EC1AF - *)

  aUpperMapSpriteAndStatusBuffer .fill 120 * size(structMapSpriteAndStatusEntry) ; $7EC1AF
  aLowerMapSpriteBuffer .fill 127 * size(structMapSpriteAndStatusEntry) ; $7EC47F

  lUnknown7EC779 .long ? ; $7EC779

  aBG1TilemapBuffer .fill $1000 ; $7EC77C
  aBG2TilemapBuffer .fill $1000 ; $7ED77C
  aBG3TilemapBuffer .fill $1000 ; $7EE77C

.endv
