
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

      startData

        aClassData ; TODO: class data

      endData

    .endsection ClassDataSection

    .section MovementTypeSection

      startData

        .include "../TABLES/MovementType.csv.asm"

      endData

    .endsection MovementTypeSection

    .section TerrainBonusSection

      startData

        TerrainHitAvoid .include "../TABLES/TerrainHitAvoid.csv.asm"
        TerrainAvoid .include "../TABLES/TerrainAvoid.csv.asm"
        TerrainDefense .include "../TABLES/TerrainDefense.csv.asm"
        aTerrainMagicTable .include "../TABLES/TerrainMagic.csv.asm"

      endData

    .endsection TerrainBonusSection

.endif ; GUARD_FE5_CLASS_DATA
