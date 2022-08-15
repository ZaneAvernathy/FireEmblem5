
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_ARENA :?= false
.if (!GUARD_FE5_ARENA)
  GUARD_FE5_ARENA := true

  ; Definitions

    .weak

      ArenaTierOneNormalClasses := [Cavalier, LanceKnight, AxeKnight, SwordKnight, Troubadour, Myrmidon, ArmoredLance, ArmoredAxe, ArmoredSword, Brigand, Pirate, Mage, LoptyrMage, ThunderMage, WindMage]
      ArenaTierOneBowClasses    := [BowKnight, ArcherEnemy, Sniper, BowKnightF, BowKnight, ArcherEnemy, Sniper, BowKnightF, Mage, LoptyrMage, ThunderMage, WindMage]
      ArenaThiefClasses         := [Thief, ThiefF, Dancer, Soldier, Thief, ThiefF, Dancer, Soldier, Mage, LoptyrMage, ThunderMage, WindMage]
      ArenaTierTwoNormalClasses := [DukeKnight, Paladin, PaladinF, ForestKnight, MageKnight, GreatKnight, PegasusKnight, Swordmaster, General, Baron, HighPriest, Bishop, Sage]
      ArenaTierTwoBowClasses    := [Sniper, ArchKnight, ArchKnightF, HighPriest, Bishop, Sage]

      ArenaNormalAutolevelScheme :?= (-AutolevelScheme7)
      ArenaThiefAutolevelScheme  :?= (-AutolevelScheme8)

    .endweak

    structArenaOpponentPool .struct Pool, AutolevelScheme
      .if (\Pool === ?)
        Pool            .word <>\Pool
        AutolevelScheme .sint \AutolevelScheme
      .else
        .word <>\Pool
        .sint \AutolevelScheme
      .endif
    .endstruct

  ; Freespace inclusions

    ; TODO: rename this

    .section ArenaClassPoolSection

      startData

        aTierOneArenaOpponentTypes .block ; 85/EF31
          _Normal    .structArenaOpponentPool aTierOneArenaOpponentNormalPool, ArenaNormalAutolevelScheme
          _BowOnly   .structArenaOpponentPool aTierOneBowArenaOpponentPool,    ArenaNormalAutolevelScheme
          _Thieflike .structArenaOpponentPool aThiefArenaOpponentPool,         ArenaThiefAutolevelScheme
        .endblock

        aTierTwoArenaOpponentTypes .block ; 85/EF3D
          _Normal    .structArenaOpponentPool aTierTwoArenaOpponentNormalPool, ArenaNormalAutolevelScheme
          _BowOnly   .structArenaOpponentPool aTierTwoBowArenaOpponentPool,    ArenaNormalAutolevelScheme
          _Thieflike .structArenaOpponentPool aThiefArenaOpponentPool,         ArenaNormalAutolevelScheme
        .endblock

        aTierOneArenaOpponentNormalPool .byte ArenaTierOneNormalClasses, 0 ; 85/EF49
        aTierOneBowArenaOpponentPool    .byte ArenaTierOneBowClasses, 0    ; 85/EF59
        aThiefArenaOpponentPool         .byte ArenaThiefClasses, 0         ; 85/EF66

        aTierTwoArenaOpponentNormalPool .byte ArenaTierTwoNormalClasses, 0 ; 85/EF73
        aTierTwoBowArenaOpponentPool    .byte ArenaTierTwoBowClasses, 0    ; 85/EF81

      endData

    .endsection ArenaClassPoolSection

.endif ; GUARD_FE5_ARENA
