
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_VBLANK :?= false
.if (!GUARD_FE5_VBLANK)
  GUARD_FE5_VBLANK := true

  .include "../../VoltEdge/VoltEdge.h"

  ; Definitions

    .weak

      rlCopyINIDISPBuffer    :?= address($8081A8)
      rlProcessSoundQueues   :?= address($808D9C)
      rlIncrementIngameTime  :?= address($838E5B)

    .endweak

  ; Freespace inclusions

    .section VBlankHandlerSection

      riVBlankN ; 80/81B6

        .autsiz
        .databank ?

        ; Handles VBlank.
        ; You shouldn't call this yourself.

        ; Inputs:
        ; wVBlankPointer: short pointer to routine
        ; wUnknown0000D9: some kind of flag

        ; Outputs:
        ; None

        cli

        rep #$30

        ; Break out of bank 00

        jml +

        +

        phb
        phd
        pha
        phx
        phy

        lda #0
        tcd

        phk
        plb

        .databank `*

        ; Acknowledge VBlank.

        lda RDNMI,b

        lda wVBlankFlag
        bpl +

          jmp _8A20

        +
        ora #$8000
        sta wVBlankFlag

        .for i in range(wR0, wR26, size(word))

          lda i
          pha

        .endfor

        pea #<>(+)-size(byte)

        jmp (wVBlankPointer)

        +

        jsl rlIncrementIngameTime

        .for i in range(wR26-size(word), wR0-size(word), -size(word))

          pla
          sta i

        .endfor

        inc wVBlankEnabledFramecount

        ply
        plx
        pla
        pld

        stz wVBlankFlag,b

        plb

        rti

        _8A20

        inc wVBlankDisabledFramecount

        jsl rlProcessSoundQueues
        jsl rlCopyINIDISPBuffer
        jsl rlIncrementIngameTime

        ply
        plx
        pla
        pld
        plb

        rti

        .databank 0

    .endsection VBlankHandlerSection

    .section EnableVBlankSection

      rlEnableVBlank ; 80/82DA

        .autsiz
        .databank ?

        ; Enables VBlank.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        php

        sep #$20

        lda bBufferNMITIMEN
        ora #NMITIMEN_VBlank
        sta bBufferNMITIMEN
        sta NMITIMEN,b

        plp
        rtl

        .databank 0

    .endsection EnableVBlankSection

    .section DisableVBlankSection

      rlDisableVBlank ; 80/82E8

        .autsiz
        .databank ?

        ; Disables VBlank.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        php

        sep #$20

        lda bBufferNMITIMEN
        and #~NMITIMEN_VBlank
        sta bBufferNMITIMEN
        sta NMITIMEN,b

        plp
        rtl

        .databank 0

    .endsection DisableVBlankSection

    .section HaltUntilVBlankSection

      rlHaltUntilVBlank ; 80/82F6

        .autsiz
        .databank ?

        ; Halts code execution until the
        ; endfor VBlank has occurred.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        php

        lda wVBlankEnabledFramecount

        -
        cmp wVBlankEnabledFramecount
        beq -

        plp

        rtl

    .endsection HaltUntilVBlankSection

    .section EnableForcedBlankSection

      rlEnableForcedBlank ; 80/82FF

        .autsiz
        .databank ?

        ; Enables forced blanking and
        ; waits for endfor VBlank.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        php
        phb

        phk
        plb

        .databank `*

        sep #$20

        lda bBufferINIDISP
        ora #INIDISP_ForcedBlank
        sta bBufferINIDISP

        jsl rlHaltUntilVBlank

        plb
        plp

        rtl

        .databank 0

    .endsection EnableForcedBlankSection

    .section DisableForcedBlankSection

      rlDisableForcedBlank ; 80/82FF

        .autsiz
        .databank ?

        ; Disables forced blanking and
        ; waits for endfor VBlank.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        php
        phb

        phk
        plb

        .databank `*

        sep #$20

        lda bBufferINIDISP
        and #~INIDISP_ForcedBlank
        sta bBufferINIDISP

        jsl rlHaltUntilVBlank

        plb
        plp

        rtl

        .databank 0

    .endsection DisableForcedBlankSection

.endif ; GUARD_FE5_VBLANK
