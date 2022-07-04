
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_BATTLE_BACKGROUNDS :?= false
.if (!GUARD_FE5_BATTLE_BACKGROUNDS)
  GUARD_FE5_BATTLE_BACKGROUNDS := true

  ; Definitions

    .weak

    .endweak

  ; Freespace inclusions

    .section BattleBackgroundBlock1Section

      startTilemaps
        acThicketBGTilemap .text ROM[$204AFF:$204FFB]
      endTilemaps

      startGraphics
        g4bppcForestBG .text ROM[$204FFB:$207C25]
      endGraphics

      startTilemaps
        acForestBGTilemap crossbankRaw ROM[$207C25:$208140]
      endTilemaps

    .endsection BattleBackgroundBlock1Section

    .section BattleBackgroundBlock2Section

      startTilemaps
        crossbankRawRemainder
      endTilemaps

      startGraphics
        g4bppcRiverBG .text ROM[$208140:$20ABF2]
      endGraphics

      startTilemaps
        acRiverBGTilemap .text ROM[$20ABF2:$20AFA3]
      endTilemaps

      startGraphics
        g4bppcPlainsBG .text ROM[$20AFA3:$20D780]
      endGraphics

      startTilemaps
        acPlainsBGTilemap .text ROM[$20D780:$20DBBD]
      endTilemaps

      startGraphics
        g4bppcCastleBG crossbankRaw ROM[$20DBBD:$210B55]
      endGraphics

    .endsection BattleBackgroundBlock2Section

    .section BattleBackgroundBlock3Section

      startGraphics
        crossbankRawRemainder
      endGraphics

      startGraphics
        g4bppcBeachBG .text ROM[$210B55:$213592]
      endGraphics

      startTilemaps
        acBeachBGTilemap .text ROM[$213592:$21397E]
      endTilemaps

      startGraphics
        g4bppcPeakBG .text ROM[$21397E:$2160BF]
      endGraphics

      startTilemaps
        acPeakBGTilemap .text ROM[$2160BF:$216415]
      endTilemaps

      startGraphics
        g4bppcWastelandBG crossbankRaw ROM[$216415:$219503]
      endGraphics

    .endsection BattleBackgroundBlock3Section

    .section BattleBackgroundBlock4Section

      startGraphics
        crossbankRawRemainder
      endGraphics

      startTilemaps
        acWastelandBGTilemap .text ROM[$219503:$219A22]
      endTilemaps

      startGraphics
        g4bppcArenaBG .text ROM[$219A22:$21BFBE]
      endGraphics

      startTilemaps
        acArenaBGTilemap .text ROM[$21BFBE:$21C5D7]
      endTilemaps

      .text ROM[$21C5D7:$21C60C] ; Unused, unreferenced?

      startTilemaps
        acTownBGTilemap .text ROM[$21C60C:$21CB11]
      endTilemaps

      startGraphics
        g4bppcForestFG .text ROM[$21CB11:$21E31F]
      endGraphics

      startTilemaps
        acIndoorsBGTilemap .text ROM[$21E31F:$21E98F]
      endTilemaps

      startGraphics
        g4bppcIndoorsBG crossbankRaw ROM[$21E98F:$221571]
      endGraphics

    .endsection BattleBackgroundBlock4Section

    .section BattleBackgroundBlock5Section

      startGraphics
        crossbankRawRemainder
      endGraphics

      startTilemaps
        acCastleBGTilemap .text ROM[$221571:$22191F]
      endTilemaps

      startTilemaps
        acPlateauBGTilemap .text ROM[$22191F:$221E3D]
      endTilemaps

      startGraphics
        g4bppcPlateauBG .text ROM[$221E3D:$22479C]
        g4bppcThroneBG  .text ROM[$22479C:$226DF4]
      endGraphics

      startTilemaps
        acThroneBGTilemap .text ROM[$226DF4:$22747E]
      endTilemaps

      startGraphics
        g4bppcPillarsFG crossbankRaw ROM[$22747E:$2281C2]
      endGraphics

    .endsection BattleBackgroundBlock5Section

    .section BattleBackgroundBlock6Section

      startGraphics
        crossbankRawRemainder
      endGraphics

      startTilemaps
        acPillarsFGLeftTilemap  .text ROM[$2281C2:$2282CD]
        acPillarsFGRightTilemap .text ROM[$2282CD:$2283EF]
      endTilemaps

      startGraphics
        g4bppcChandelierFG .text ROM[$2283EF:$2294F7]
      endGraphics

      startTilemaps
        acChandelierFGLeftTilemap  .text ROM[$2294F7:$22966B]
        acChandelierFGRightTilemap .text ROM[$22966B:$2297D2]
      endTilemaps

      startGraphics
        g4bppcThicketBG .text ROM[$2297D2:$22CBC1]

        ; Weirdly, the tower from the FE4 intro is in here.

        g4bppcFE4Tower .text ROM[$22CBC1:$22FB26]
      endGraphics

      startTilemaps
        acFE4Tower             .text ROM[$22FB26:$22FDF4]
        acForestFGLeftTilemap  .text ROM[$22FDF4:$22FF89]
        acForestFGRightTilemap crossbankRaw ROM[$22FF89:$230172]
      endTilemaps

    .endsection BattleBackgroundBlock6Section

    .section BattleBackgroundBlock7Section

      startTilemaps
        crossbankRawRemainder
      endTilemaps

      startTilemaps
        acFenceFGLeftTilemap      .text ROM[$230172:$2301D6]
        acFenceFGRightTilemap     .text ROM[$2301D6:$230230]
        acStumpFGLeftTilemap      .text ROM[$230230:$2302FC]
        acStumpFGRightTilemap     .text ROM[$2302FC:$2303CC]
        acLowRocksFGLeftTilemap   .text ROM[$2303CC:$230485]
        acLowRocksFGRightTilemap  .text ROM[$230485:$230540]
        acHighRocksFGLeftTilemap  .text ROM[$230540:$230637]
        acHighRocksFGRightTilemap .text ROM[$230637:$230733]
        acBridgeBGTilemap         .text ROM[$230733:$230B50]
      endTilemaps

      startGraphics
        g4bppcFenceFG     .text ROM[$230B50:$230E94]
        g4bppcStumpFG     .text ROM[$230E94:$23177A]
        g4bppcLowRocksFG  .text ROM[$23177A:$232021]
        g4bppcHighRocksFG .text ROM[$232021:$232A84]
      endGraphics

    .endsection BattleBackgroundBlock7Section

.endif ; GUARD_FE5_BATTLE_BACKGROUNDS
