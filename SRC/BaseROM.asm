
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_BASEROM :?= false
.if (!GUARD_FE5_BASEROM)
  GUARD_FE5_BASEROM := true

  ; Fill the base ROM in parts to prevent
  ; pc wrap warnings.

  * := $000000

  .for bank in range($000000, $400000, $8000)
    * := bank
    .binary "../FE5.sfc", bank, $8000
  .endfor

.endif ; GUARD_FE5_BASEROM
