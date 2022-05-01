
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_DEPLOYMENT_SLOTS :?= false
.if (!GUARD_FE5_DEPLOYMENT_SLOTS)
  GUARD_FE5_DEPLOYMENT_SLOTS := true

  ; Definitions

    .weak

        PlayerSlotCount = len(aPlayerUnits._Units)
        EnemySlotCount  = len(aEnemyUnits._Units) - 1
        NPCSlotCount    = len(aNPCUnits._Units)

    .endweak

  ; Freespace inclusions

    .section DeploymentSlotTableSection

      startData

        aDeploymentSlotTable ; 83/8E98

          ; This table is used to get a pointer to a unit in RAM
          ; given the unit's deployment number.

          ; Each of the three allegiances get $40 entries,
          ; with the first entry always 0000 and the last always FFFF
          ; Which are used as start/stop markers for looping through
          ; deployment slots.

          ; That leaves $3E (62d) potential slots, but only:
          ; Player: 48
          ; Enemy: 50*
          ; NPC: 16
          ; are used, with the remaining slots full of
          ; some strange nonsense terminated the same way
          ; as the actual entries.

          ; *There are only 50 set pointers for enemy deployment slots
          ; despite there being space for 51 allocated.

          _PlayerSlots .sint 0, <>aPlayerUnits._Units[0:PlayerSlotCount], -1 ; 83/8E98

            ; The remaining player slots are filled with
            ; pointers to enemy units, starting with the
            ; second one.

            .sint <>aEnemyUnits._Units[1:Enemy-(Player+PlayerSlotCount+2)], -1

          _EnemySlots .sint 0, <>aEnemyUnits._Units[0:EnemySlotCount], -1 ; 83/8F18

            ; The remaining enemy slots are filled with
            ; pointers to NPC units.

            .sint <>aNPCUnits._Units[0:NPC-(Enemy+EnemySlotCount+3)], -1

          _NPCSlots .sint 0, <>aNPCUnits._Units[0:NPCSlotCount], -1 ; 83/8F98

            ; The rest of the NPC slots are a wild mess.

            ; 7 pointers to garbage outside of the
            ; NPC unit pool.

            _Offset := aNPCUnits._Units[-1] + (size(structCharacterDataRAM) * 2)

            .rept 7

              .word <>_Offset
              _Offset += size(structCharacterDataRAM)

            .endrept

            ; 7 end markers.

            .rept 7

              .sint -1

            .endrept

            ; The rest are start markers.

            .rept $40 - (NPCSlotCount + 14 + 1)

              .sint 0

            .endrept

            .sint -1

      endData

    .endsection DeploymentSlotTableSection

.endif ; GUARD_FE5_DEPLOYMENT_SLOTS
