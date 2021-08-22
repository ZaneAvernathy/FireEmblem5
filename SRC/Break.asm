
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_BREAK :?= false
.if (!GUARD_FE5_BREAK)
  GUARD_FE5_BREAK := true

  .include "../../VoltEdge/VoltEdge.h"

  ; Freespace inclusions

    .section BreakpointHandlerSection

      riBRK ; 80/8000

        .autsiz
        .databank ?

        bra riBRK

        .databank 0

    .endsection BreakpointHandlerSection

.endif ; GUARD_FE5_BREAK
