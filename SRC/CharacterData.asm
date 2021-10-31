
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_CHARACTER_DATA :?= false
.if (!GUARD_FE5_CHARACTER_DATA)
  GUARD_FE5_CHARACTER_DATA := true

  .include "../../VoltEdge/VoltEdge.h"

  ; Definitions

    .weak

    .endweak

  ; Freespace inclusions

    .section SupportDataSection

      aSupportData .include "../TABLES/SupportData.csv.asm"
      .word 0

    .endsection SupportDataSection

.endif ; GUARD_FE5_CHARACTER_DATA
