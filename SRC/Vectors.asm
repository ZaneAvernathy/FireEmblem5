
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_VECTORS :?= false
.if (!GUARD_FE5_VECTORS)
  GUARD_FE5_VECTORS := true

  ; Definitions

    .weak

      riBRK     :?= address($808000)
      riVBlankN :?= address($8081B6)
      riIRQN    :?= address($8082B4)
      riResetE  :?= address($808A36)

    .endweak

  ; Freespace inclusions

    .section VectorTableSection

                    .addr riBRK
                    .addr riBRK
      aCOPVectorN   .addr riBRK
      aBRKVectorN   .addr riBRK
      aABORTVectorN .addr riBRK
      aNMIVectorN   .addr riVBlankN
                    .addr riBRK
      aIRQVectorN   .addr riIRQN

                    .addr riBRK
                    .addr riBRK
      aCOPVectorE   .addr riBRK
      aBRKVectorE   .addr riBRK
      aABORTVectorE .addr riBRK
      aNMIVectorE   .addr riBRK
      aRESETVectorE .addr riResetE
      aIRQVectorE   .addr riBRK

    .endsection VectorTableSection

.endif ; GUARD_FE5_VECTORS
