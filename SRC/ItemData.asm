
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_ITEM_DATA :?= false
.if (!GUARD_FE5_ITEM_DATA)
  GUARD_FE5_ITEM_DATA := true

  ; Definitions

    .weak

      ; Format: (PoisonedItem, CleanedItem)
      TransformingItemList  := [(PoisonSword,    IronSword)]
      TransformingItemList ..= [(PoisonSpear,    IronLance)]
      TransformingItemList ..= [(PoisonAxe,      IronAxe)]
      TransformingItemList ..= [(PoisonBow,      IronBow)]
      TransformingItemList ..= [(PoisonBallista, IronBallista)]
      TransformingItemList ..= [(Venin,          Fenrir)]
      TransformingItemList ..= [(Stone,          Fenrir)]

    .endweak

  ; Freespace inclusions

    .section ItemBonusesSection

      startData

        aItemBonuses .block

                                                                ; STR MAG SKL SPD DEF CON LUK MOV

          aNoItemBonuses           .dstruct structItemStatBonuses,  0,  0,  0,  0,  0,  0,  0,  0 ; B0/8000

          ; Normally I would use a .csv for tables like this,
          ; but this random word in the table messes that up.

          .word $0000 ; B0/8008

          aBlessedSwordItemBonuses .dstruct structItemStatBonuses,  0, 10,  0,  0,  0,  0,  0,  0 ; B0/800A
          aLightBrandItemBonuses   .dstruct structItemStatBonuses,  0,  0,  0,  0,  0,  0, 10,  0 ; B0/8012
          aWindSwordItemBonuses    .dstruct structItemStatBonuses,  0,  0,  0,  5,  0,  0,  0,  0 ; B0/801A
          aFireBrandItemBonuses    .dstruct structItemStatBonuses,  0,  5,  0,  0,  0,  0,  0,  0 ; B0/8022
          aVoltEdgeItemBonuses     .dstruct structItemStatBonuses,  0,  0,  5,  0,  0,  0,  0,  0 ; B0/802A
          aParagonSwordItemBonuses .dstruct structItemStatBonuses,  0,  0,  0,  0,  5,  0,  0,  0 ; B0/8032
          aLoptyrsBladeItemBonuses .dstruct structItemStatBonuses,  0, 20,  0,  0,  0,  0,  0,  0 ; B0/803A
          aBraveLanceItemBonuses   .dstruct structItemStatBonuses,  0,  0,  0,  0,  0,  0, 10,  0 ; B0/8042
          aForsetiItemBonuses      .dstruct structItemStatBonuses,  0,  0, 20, 20,  0,  0,  0,  0 ; B0/804A
          aPugiItemBonuses         .dstruct structItemStatBonuses,  0,  0,  0,  0,  0,  0,  0,  0 ; B0/8052
          aUnknown1ItemBonuses     .dstruct structItemStatBonuses,  0, 20,  0,  0,  0,  0,  0,  0 ; B0/805A
          aUnknown2ItemBonuses     .dstruct structItemStatBonuses,  0,  0,  0, 20,  0,  0,  0,  0 ; B0/8062
          aGungnirItemBonuses      .dstruct structItemStatBonuses,  0,  0,  0,  0, 10,  0,  0,  0 ; B0/806A
          aGaeBolgItemBonuses      .dstruct structItemStatBonuses, 10,  0,  0,  0,  0,  0,  0,  0 ; B0/8072

        .endblock

      endData

    .endsection ItemBonusesSection

    .section ScrollGrowthModifiersSection

      startData

        aScrollTable .include "../TABLES/ScrollTable.csv.asm" ; 88/8054
        .byte 0

      endData

    .endsection ScrollGrowthModifiersSection

    .section TransformingItemSection

      startData

        aTransformingItems .for _Base, _Transformed in TransformingItemList ; 88/8223
          .byte _Base
        .endfor
        .byte 0

        aTransformedItems .for _Base, _Transformed in TransformingItemList ; 88/822B
          .byte _Transformed
        .endfor

      endData

    .endsection TransformingItemSection

.endif ; GUARD_FE5_ITEM_DATA
