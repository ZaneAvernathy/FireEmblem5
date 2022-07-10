
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_CLASS_DATA :?= false
.if (!GUARD_FE5_CLASS_DATA)
  GUARD_FE5_CLASS_DATA := true

  ; Definitions

    .weak

      ; Format: (Mounted, Dismounted)
      MountedClassList  := [(Cavalier,      CavalierDismounted)]
      MountedClassList ..= [(LanceKnight,   LanceKnightDismounted)]
      MountedClassList ..= [(BowKnight,     BowKnightDismounted)]
      MountedClassList ..= [(BowKnightF,    BowKnightFDismounted)]
      MountedClassList ..= [(AxeKnight,     AxeKnightDismounted)]
      MountedClassList ..= [(SwordKnight,   SwordKnightDismounted)]
      MountedClassList ..= [(Troubadour,    TroubadourDismounted)]
      MountedClassList ..= [(KnightLord,    KnightLordDismounted)]
      MountedClassList ..= [(DukeKnight,    DukeKnightDismounted)]
      MountedClassList ..= [(MasterKnight,  MasterKnightDismounted)]
      MountedClassList ..= [(MasterKnightF, MasterKnightFDismounted)]
      MountedClassList ..= [(Paladin,       PaladinDismounted)]
      MountedClassList ..= [(PaladinF,      PaladinFDismounted)]
      MountedClassList ..= [(ArchKnight,    ArchKnightDismounted)]
      MountedClassList ..= [(ArchKnightF,   ArchKnightFDismounted)]
      MountedClassList ..= [(ForestKnight,  ForestKnightDismounted)]
      MountedClassList ..= [(MageKnight,    MageKnightDismounted)]
      MountedClassList ..= [(MageKnightF,   MageKnightFDismounted)]
      MountedClassList ..= [(GreatKnight,   GreatKnightDismounted)]
      MountedClassList ..= [(PegasusKnight, PegasusKnightDismounted)]
      MountedClassList ..= [(FalconKnight,  FalconKnightDismounted)]
      MountedClassList ..= [(WyvernRider,   WyvernRiderDismounted)]
      MountedClassList ..= [(WyvernRiderF,  WyvernRiderFDismounted)]
      MountedClassList ..= [(WyvernKnight,  WyvernKnightDismounted)]
      MountedClassList ..= [(WyvernKnightF, WyvernKnightFDismounted)]
      MountedClassList ..= [(WyvernMaster,  WyvernMasterDismounted)]
      MountedClassList ..= [(WyvernMasterF, WyvernMasterFDismounted)]
      MountedClassList ..= [(PegasusRider,  PegasusRiderDismounted)]

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

    .section MountDismountTableSection

      startData

        aMountedClasses .for _Mounted, _Dismounted in MountedClassList ; 88/8000
          .byte _Mounted
        .endfor

        aDismountedClasses .for _Mounted, _Dismounted in MountedClassList ; 88/801C
          .byte _Dismounted
        .endfor

      endData

    .endsection MountDismountTableSection

    .section Unknown888038Section

      startData

        ; Unknown, unreferenced?
        .text ROM[$040038:$040054]

      endData

    .endsection Unknown888038Section

.endif ; GUARD_FE5_CLASS_DATA
