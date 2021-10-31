
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_ITEM_DATA :?= false
.if (!GUARD_FE5_ITEM_DATA)
  GUARD_FE5_ITEM_DATA := true

  .include "../../VoltEdge/VoltEdge.h"

  ; Definitions

    .weak

    .endweak

  ; Freespace inclusions

    .section ItemBonusesSection

      aItemBonuses .block

                                                              ; STR MAG SKL SPD DEF CON LUK MOV

        aNoItemBonuses           .dstruct structItemStatBonuses,  0,  0,  0,  0,  0,  0,  0,  0 ; B0/8000

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

    .endsection ItemBonusesSection

.endif ; GUARD_FE5_ITEM_DATA
