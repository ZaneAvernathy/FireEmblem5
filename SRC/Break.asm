
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_BREAK :?= false
.if (!GUARD_FE5_BREAK)
  GUARD_FE5_BREAK := true

  ; Freespace inclusions

    .section BreakpointHandlerSection

      startCode

        riBRK ; 80/8000

          .autsiz
          .databank ?

          bra riBRK

          .databank 0

      endCode

    .endsection BreakpointHandlerSection

.endif ; GUARD_FE5_BREAK
