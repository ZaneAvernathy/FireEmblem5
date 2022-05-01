
.weak
  WARNINGS :?= "None"
.endweak

GUARD_SIZE_HELPERS_END :?= false
.if (!GUARD_SIZE_HELPERS_END)
  GUARD_SIZE_HELPERS_END := true

  ; Children must be defined before parents.

  AllRegions := []
  NoChildren := []

  MapSpritesChildren  := [("Battle: ", RegionSize(BattleMapSpritesStarts, BattleMapSpritesEnds), NoChildren)]
  MapSpritesChildren ..= [("Idle: ", RegionSize(IdleMapSpritesStarts, IdleMapSpritesEnds), NoChildren)]
  MapSpritesChildren ..= [("Moving: ", RegionSize(MovingMapSpritesStarts, MovingMapSpritesEnds), NoChildren)]

  AllMapSprites := [("Map Sprites: ", RegionSize(GeneralMapSpritesStarts, GeneralMapSpritesEnds), MapSpritesChildren)]

  GraphicsChildren  := [("Palettes: ", RegionSize(PalettesStarts, PalettesEnds), NoChildren)]
  GraphicsChildren ..= [("Tilemaps: ", RegionSize(TilemapsStarts, TilemapsEnds), NoChildren)]
  GraphicsChildren ..= [("Portraits: ", RegionSize(PortraitsStarts, PortraitsEnds), NoChildren)]
  GraphicsChildren ..= [("Battle Animations: ", RegionSize(BattleAnimationsStarts, BattleAnimationsEnds), NoChildren)]
  GraphicsChildren ..= AllMapSprites

  AllGraphics := [("Graphics: ", RegionSize(GeneralGraphicsStarts, GeneralGraphicsEnds), GraphicsChildren)]
  AllRegions ..= AllGraphics

  CodeChildren := [("Procs: ", RegionSize(ProcsStarts, ProcsEnds), NoChildren)]

  AllCode := [("Code: ", RegionSize(GeneralCodeStarts, GeneralCodeEnds), CodeChildren)]
  AllRegions ..= AllCode

  EventsChildren  := [("Scenes: ", RegionSize(EventScenesStarts, EventScenesEnds), NoChildren)]
  EventsChildren ..= [("Data: ", RegionSize(EventDataStarts, EventDataEnds), NoChildren)]

  AllEvents := [("Events: ", RegionSize(GeneralEventsStarts, GeneralEventsEnds), EventsChildren)]
  AllRegions ..= AllEvents

  DataChildren := NoChildren

  AllData := [("Data: ", RegionSize(GeneralDataStarts, GeneralDataEnds), DataChildren)]
  AllRegions ..= AllData

  TextChildren  := [("Dialogue: ", RegionSize(DialogueStarts, DialogueEnds), NoChildren)]
  TextChildren ..= [("Menu Text: ", RegionSize(MenuTextStarts, MenuTextEnds), NoChildren)]

  AllText := [("Text: ", RegionSize(GeneralTextStarts, GeneralTextEnds), TextChildren)]
  AllRegions ..= AllText

  FreespaceChildren := NoChildren

  AllFreespace := [("Freespace: ", RegionSize(FreespaceStarts, FreespaceEnds), FreespaceChildren)]
  AllRegions ..= AllFreespace

  _T := WidthScan("Total: ", 0, AllRegions)
  _MaxDepth := _T[0]
  _MaxWidth := _T[1]

  _Pad := _MaxWidth + (2 * (_MaxDepth - 1))

  _T := SizeScan("Total: ", 0, AllRegions, _Pad)

  .for _RegionString in _T[1][::-1]
    .warn _RegionString
  .endfor

.endif ; GUARD_SIZE_HELPERS_END
