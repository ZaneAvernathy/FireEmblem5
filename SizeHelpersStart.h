
.weak
  WARNINGS :?= "None"
.endweak

GUARD_SIZE_HELPERS_START :?= false
.if (!GUARD_SIZE_HELPERS_START)
  GUARD_SIZE_HELPERS_START := true

  ; These are boundaries for different kinds of things in the ROM.

  ; I would have liked to have both the starts and ends in a single
  ; 2-tuple of lists but tuples are immutable and 64tass doesn't let
  ; you modify nested structures.

  ; Each starts with a zero in case nothing is put in those
  ; types, because folds aren't allowed on empty lists.

  GeneralGraphicsStarts := [0]
  GeneralGraphicsEnds   := [0]

    PalettesStarts := [0]
    PalettesEnds   := [0]

    TilemapsStarts := [0]
    TilemapsEnds   := [0]

    PortraitsStarts := [0]
    PortraitsEnds   := [0]

    BattleAnimationsStarts := [0]
    BattleAnimationsEnds   := [0]

    GeneralMapSpritesStarts := [0]
    GeneralMapSpritesEnds   := [0]

      BattleMapSpritesStarts := [0]
      BattleMapSpritesEnds   := [0]

      IdleMapSpritesStarts := [0]
      IdleMapSpritesEnds   := [0]

      MovingMapSpritesStarts := [0]
      MovingMapSpritesEnds   := [0]

  GeneralCodeStarts := [0]
  GeneralCodeEnds   := [0]

    ProcsStarts := [0]
    ProcsEnds   := [0]

  GeneralEventsStarts := [0]
  GeneralEventsEnds   := [0]

    EventScenesStarts := [0]
    EventScenesEnds   := [0]

    EventDataStarts := [0]
    EventDataEnds   := [0]

  GeneralDataStarts := [0]
  GeneralDataEnds   := [0]

  GeneralTextStarts := [0]
  GeneralTextEnds   := [0]

    DialogueStarts := [0]
    DialogueEnds   := [0]

    MenuTextStarts := [0]
    MenuTextEnds   := [0]

  FreespaceStarts := [0]
  FreespaceEnds   := [0]

  ; Macros

    startGraphics .segment Pointer=*
      GeneralGraphicsStarts ..= [\Pointer]
    .endsegment

    endGraphics .segment Pointer=*
      GeneralGraphicsEnds ..= [\Pointer]
    .endsegment


    startPalettes .segment Pointer=*
      PalettesStarts ..= [\Pointer]
    .endsegment

    endPalettes .segment Pointer=*
      PalettesEnds ..= [\Pointer]
    .endsegment


    startTilemaps .segment Pointer=*
      TilemapsStarts ..= [\Pointer]
    .endsegment

    endTilemaps .segment Pointer=*
      TilemapsEnds ..= [\Pointer]
    .endsegment


    startPortraits .segment Pointer=*
      PortraitsStarts ..= [\Pointer]
    .endsegment

    endPortraits .segment Pointer=*
      PortraitsEnds ..= [\Pointer]
    .endsegment


    startBattleAnimations .segment Pointer=*
      BattleAnimationsStarts ..= [\Pointer]
    .endsegment

    endBattleAnimations .segment Pointer=*
      BattleAnimationsEnds ..= [\Pointer]
    .endsegment


    startMapSprites .segment Pointer=*
      GeneralMapSpritesStarts ..= [\Pointer]
    .endsegment

    endMapSprites .segment Pointer=*
      GeneralMapSpritesEnds ..= [\Pointer]
    .endsegment


    startBattleMapSprites .segment Pointer=*
      BattleMapSpritesStarts ..= [\Pointer]
    .endsegment

    endBattleMapSprites .segment Pointer=*
      BattleMapSpritesEnds ..= [\Pointer]
    .endsegment


    startIdleMapSprites .segment Pointer=*
      IdleMapSpritesStarts ..= [\Pointer]
    .endsegment

    endIdleMapSprites .segment Pointer=*
      IdleMapSpritesEnds ..= [\Pointer]
    .endsegment


    startMovingMapSprites .segment Pointer=*
      MovingMapSpritesStarts ..= [\Pointer]
    .endsegment

    endMovingMapSprites .segment Pointer=*
      MovingMapSpritesEnds ..= [\Pointer]
    .endsegment


    startCode .segment Pointer=*
      GeneralCodeStarts ..= [\Pointer]
    .endsegment

    endCode .segment Pointer=*
      GeneralCodeEnds ..= [\Pointer]
    .endsegment


    startProcs .segment Pointer=*
      ProcsStarts ..= [\Pointer]
    .endsegment

    endProcs .segment Pointer=*
      ProcsEnds ..= [\Pointer]
    .endsegment


    startEvents .segment Pointer=*
      GeneralEventsStarts ..= [\Pointer]
    .endsegment

    endEvents .segment Pointer=*
      GeneralEventsEnds ..= [\Pointer]
    .endsegment


    startEventScenes .segment Pointer=*
      EventScenesStarts ..= [\Pointer]
    .endsegment

    endEventScenes .segment Pointer=*
      EventScenesEnds ..= [\Pointer]
    .endsegment


    startEventData .segment Pointer=*
      EventDataStarts ..= [\Pointer]
    .endsegment

    endEventData .segment Pointer=*
      EventDataEnds ..= [\Pointer]
    .endsegment


    startData .segment Pointer=*
      GeneralDataStarts ..= [\Pointer]
    .endsegment

    endData .segment Pointer=*
      GeneralDataEnds ..= [\Pointer]
    .endsegment


    startText .segment Pointer=*
      GeneralTextStarts ..= [\Pointer]
    .endsegment

    endText .segment Pointer=*
      GeneralTextEnds ..= [\Pointer]
    .endsegment


    startDialogue .segment Pointer=*
      DialogueStarts ..= [\Pointer]
    .endsegment

    endDialogue .segment Pointer=*
      DialogueEnds ..= [\Pointer]
    .endsegment


    startMenuText .segment Pointer=*
      MenuTextStarts ..= [\Pointer]
    .endsegment

    endMenuText .segment Pointer=*
      MenuTextEnds ..= [\Pointer]
    .endsegment


    startFreespace .segment Pointer=*
      FreespaceStarts ..= [\Pointer]
    .endsegment

    endFreespace .segment Pointer=*
      FreespaceEnds ..= [\Pointer]
    .endsegment

  ; Helpers

    RegionSize .sfunction Starts, Ends, (Ends - Starts) + ...
    SizeFormatter .sfunction dSize, ROMSize=$400000, format("$%06X %%%05.2f", dSize, 100.0-((float(ROMSize-dSize)/float(ROMSize)*100)))

    WidthScan .function Label="", Size=0, Children=[], Depth=0, RunningWidth=0, RunningDepth=0

      ; We're trying to find the max depth of all children along
      ; with the length of the longest label.

      ; Check if our label is longer than the running width.

      RunningWidth := RunningWidth >? len(Label)

      ; Try to find the max depth of children.

      ; Check if our depth is deeper than the running depth.

      RunningDepth := RunningDepth >? Depth

      .for _Label, _Size, _Children in Children
        _T := WidthScan(_Label, _Size, _Children, Depth+1, RunningWidth, RunningDepth)
        RunningDepth := Depth >? _T[0]
        RunningWidth := _T[1]
      .endfor

    .endfunction (RunningDepth, RunningWidth)

    SizeScan .function Label="", Size=0, Children=[], Pad=0, Depth=0, RegionText=[]

      ; We're trying to recursively make a list of strings for
      ; all region types.

      ; We need to tally up the size of all children.

      RunningSize := Size

      .for _Label, _Size, _Children in Children
        _T := SizeScan(_Label, _Size, _Children, Pad, Depth+1, RegionText)
        RunningSize += _T[0]
        RegionText ..= _T[1]
      .endfor

      ; Build a string using our size.

      RegionText ..= [zstr.ljust("  " x Depth .. Label, Pad) .. SizeFormatter(RunningSize)]

    .endfunction (RunningSize, RegionText)

.endif ; GUARD_SIZE_HELPERS_START
