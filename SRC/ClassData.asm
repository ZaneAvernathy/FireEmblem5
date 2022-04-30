
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_CLASS_DATA :?= false
.if (!GUARD_FE5_CLASS_DATA)
  GUARD_FE5_CLASS_DATA := true

  ; Definitions

    .weak

    .endweak

  ; Freespace inclusions

    .section ClassDataSection

      aClassData ; TODO: class data

    .endsection ClassDataSection

    .section MovementTypeSection

      .include "../TABLES/MovementType.csv.asm"

    .endsection MovementTypeSection

    .section TerrainBonusSection

      TerrainHitAvoid .include "../TABLES/TerrainHitAvoid.csv.asm"
      TerrainAvoid .include "../TABLES/TerrainAvoid.csv.asm"
      TerrainDefense .include "../TABLES/TerrainDefense.csv.asm"
      aTerrainMagicTable .include "../TABLES/TerrainMagic.csv.asm"

    .endsection TerrainBonusSection

.endif ; GUARD_FE5_CLASS_DATA
