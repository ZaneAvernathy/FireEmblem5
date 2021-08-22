
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_RESET :?= false
.if (!GUARD_FE5_RESET)
  GUARD_FE5_RESET := true

  .include "../../VoltEdge/VoltEdge.h"

  ; Definitions

    .weak

      rsIRQDummyRoutine      :?= address($8082D9)
      rlHaltUntilVBlank      :?= address($8082F6)
      rlSoundSystemSetup     :?= address($808BD0)
      rsDefaultVBlankRoutine :?= address($80A605)
      rsUnknown80A63B        :?= address($80A63B)
      aRESETVectorE          :?= address($80FFFC)
      rlAntipiracyScreen     :?= address($8AAFCA)
      rlIrregularityCheck    :?= address($8AB000)

      .enc "None"
        EngineName :?= "ELM0"

    .endweak

  ; Freespace inclusions

    .section InitPPURegistersSection

      rsInitPPURegisters ; 80/8930

        .autsiz
        .databank ?

        ; Sets PPU registers to startup values.
        ; You shouldn't call this yourself.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        php

        sep #$20

        ; Enable automatic joypad reading.

        lda #NMITIMEN_Setting(true, false, false, false)
        sta NMITIMEN,b
        sta bBufferNMITIMEN

        stz WRIO,b
        stz WRMPYA,b
        stz WRMPYB,b
        stz WRDIVA,b
        stz WRDIVA+1,b
        stz WRDIVB,b
        stz HTIME,b
        stz HTIME+1,b
        stz VTIME,b
        stz VTIME+1,b
        stz MDMAEN,b
        stz HDMAEN,b
        stz APU00,b
        stz APU01,b
        stz APU02,b
        stz APU03,b

        ; Set ROM access speed to fast.

        lda #MEMSEL_Fast
        sta MEMSEL,b
        sta bBufferMEMSEL

        ; Enable forced blanking.

        lda #INIDISP_Setting(true, 0)
        sta INIDISP,b
        sta bBufferINIDISP

        stz OBSEL,b

        stz OAMADD,b
        stz wBufferOAMADD

        ; Set the first object as
        ; having priority.

        lda #OAMADD_Priority_Setting(true, 0) >> 8
        sta OAMADD+1,b
        sta wBufferOAMADD+1

        stz OAMDATA,b
        stz OAMDATA,b
        stz BGMODE,b
        stz MOSAIC,b
        stz bBufferMOSAIC
        stz BG1SC,b
        stz BG2SC,b
        stz BG3SC,b
        stz BG4SC,b
        stz BG12NBA,b
        stz BG34NBA,b
        stz BG1HOFS,b
        stz BG1HOFS,b
        stz BG1VOFS,b
        stz BG1VOFS,b
        stz BG2HOFS,b
        stz BG2HOFS,b
        stz BG2VOFS,b
        stz BG2VOFS,b
        stz BG3HOFS,b
        stz BG3HOFS,b
        stz BG3VOFS,b
        stz BG3VOFS,b
        stz BG4HOFS,b
        stz BG4HOFS,b
        stz BG4VOFS,b
        stz BG4VOFS,b
        stz VMAIN,b
        stz M7SEL,b
        stz M7A,b
        stz M7B,b
        stz M7C,b
        stz M7D,b
        stz M7X,b
        stz M7Y,b
        stz W12SEL,b
        stz W34SEL,b
        stz WOBJSEL,b
        stz WH0,b
        stz WH1,b
        stz WH2,b
        stz WH3,b
        stz WBGLOG,b
        stz WOBJLOG,b
        stz TM,b
        stz TMW,b
        stz TS,b
        stz TSW,b
        stz CGWSEL,b
        stz CGADSUB,b

        ; Clear color data intensities.

        lda #COLDATA_Setting(0, false, false, true)
        sta COLDATA,b
        sta bBufferCOLDATA_1

        lda #COLDATA_Setting(0, false, true, false)
        sta COLDATA,b
        sta bBufferCOLDATA_2

        lda #COLDATA_Setting(0, true, false, false)
        sta COLDATA,b
        sta bBufferCOLDATA_3

        stz SETINI,b

        plp
        rts

        .databank 0

    .endsection InitPPURegistersSection

    .section ResetHandlerSection

      riResetE ; 80/8A36

        .autsiz
        .databank ?

        ; Handles resetting the game.

        ; Inputs:
        ; None

        ; Outputs:
        ; None

        ; Disable interrupts.

        sei

        ; Switch out of emulation mode,
        ; use the emulation bit to see
        ; if this was a soft or hard reset.

        clc
        xce
        bcc +

          ; Hard reset.

          rep #$30

          ; If something edited D before
          ; here, something's fishy.

          tdc
          bne +

            ; Make sure the reset vector
            ; hasn't been edited.

            ldx #<>riResetE
            cpx <>aRESETVectorE,b
            bne +

              ; Otherwise we're in the clear
              ; so far and we need to jump
              ; out of bank 00 into the
              ; FastROM mirror.

              jml +

        +

        ; Initialize the stack pointer

        rep #$30

        ; Move old stack pointer into Y
        ; so that we can scan the old stack
        ; for suspicious activity.

        tsx
        txy

        ldx #<>aStackSpace.bFirstFree
        txs

        ; Set ROM access speed to fast,
        ; enable forced blanking,
        ; disable IRQs, and disable
        ; automatic joypad reading.

        sep #$20

        lda #MEMSEL_Setting(true)
        sta MEMSEL,b

        lda #INIDISP_Setting(true, 0)
        sta INIDISP,b

        stz NMITIMEN,b

        ; Stop DMA

        stz MDMAEN,b
        stz HDMAEN,b

        rep #$30

        ; If, on a previous (soft) reset
        ; the engine name has already been
        ; written, skip checking for
        ; irregularities.

        .enc "None"

        lda aEngineName,b
        cmp #EngineName[0:2]
        bne +

          lda aEngineName+size(word),b
          cmp #EngineName[2:4]
          beq _SkipJumpChecks

        +

        ; Scan the old stack for
        ; a pointer to the reset handler.

        dec y
        lda 0,b,y
        inc a

        cmp <>aRESETVectorE,b
        beq _AntipiracyScreen

          ldx #0

          _JumpLoop

            ; Loop through RAM looking
            ; for jumps to the reset handler.

            ; Construct some example jumps that
            ; we'll use to compare against.

            .virtual

              _AbsoluteIndirectJump .block
                jmp (<>aRESETVectorE)
              .bend

              _AbsoluteJump .block
                jmp <>riResetE,k
              .bend

            .endv

            ; Grab a byte, check if
            ; it's a jump opcode.

            lda 0,b,x
            and #$00FF
            cmp #_AbsoluteIndirectJump[0]
            beq _AbsoluteIndirect

            cmp #_AbsoluteJump[0]
            beq _Absolute

            ; Some kind of stable pattern,
            ; I'm not sure why.

            cmp #$0060
            beq _Sequence

            _Next

              inc x
              cpx #$2000 - size(word)
              bne _JumpLoop

        _SkipJumpChecks

          ; Check which bank we're in.
          ; If still in bank 00, something
          ; went wrong.

          phk
          phk

          pla
          beq _AntipiracyScreen

            bra _SkipAntipiracy

        _AntipiracyScreen

          lda #0
          tcd

          jsl rlAntipiracyScreen

        _AbsoluteIndirect

          ; Check for jmp (NNNN)
          ; opcodes that could have jumped
          ; to the reset handler.

          ldy 1,b,x

          cpy #<>aRESETVectorE
          beq _AntipiracyScreen

          cpy #$1FFF
          bge _Next

          ; Check if there was a pointer
          ; to the reset handler at the location
          ; pointed to by NNNN.

          lda 0,b,y
          cmp #<>riResetE
          beq _AntipiracyScreen

          bra _Next

        _Absolute

          ; Check for jmp riResetE.

          ldy 1,b,x
          cpy #<>riResetE
          beq _AntipiracyScreen

          bra _Next

        _Sequence

          ; Check for some kind of stable
          ; sequence of bytes $60..$80.

          txa
          tcd

          ldy #0
          lda #pack([$60, $61])

          _SequenceLoop
            cmp 0,b,x
            bne _NotSequence

              clc
              adc #pack([2, 2])

              inc x
              inc x

              inc y
              inc y

              cpy #32
              bne _SequenceLoop

              bra _AntipiracyScreen

        _NotSequence

          tdc
          tax
          bra _Next

        _SkipAntipiracy

          lda #0
          tcd

          jsl rlIrregularityCheck
          sta aEngineUnknown,b
          sta aEngineUnknown+size(word),b

          lda #EngineName[0:2]
          sta aEngineName,b

          lda #EngineName[2:4]
          sta aEngineName+size(word),b

        _ClearRAM

          ; Grab WRAM bank.

          pea #pack([$00, $7E])
          plb
          plb

          ; Clear mirrored WRAM, avoid
          ; overwriting the engine stuff.

          ldx #<>aEngineUnknown - size(word)

          -
            stz 0,b,x
            dec x
            dec x
            bpl -

          ; Clear the rest of bank $7E.

          ldx #$2000 - size(word)

          -
            stz range($2000, $10000, $2000),b,x
            dec x
            dec x
            bpl -

          ; Clear bank $7F.

          pea #pack([$00, $7F])
          plb
          plb

          ldx #$2000 - size(word)

          -
            stz range($0000, $10000, $2000),b,x
            dec x
            dec x
            bpl -

        phk
        plb

        .databank `*

        rep #$30

        ; Clear VRAM by filling with
        ; a 0000 word via DMA.

        lda #pack([DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Fixed1, DMAP_Mode1), narrow(VMDATA - PPU_REG_BASE, 1)])
        sta DMA_IO[0].DMAP,b

        ; The size of the DMA transfer is
        ; conveniently 0000* so we use
        ; that as the fixed value to fill
        ; VRAM with.

        ; * For DMAP, a size of 0000 is
        ; interpreted as $10000.

        lda #(`(+)+1)<<8
        sta DMA_IO[0].A1+1,b
        lda #<>(+)+1
        sta DMA_IO[0].A1,b

        +
        lda #0
        sta DMA_IO[0].DAS,b

        stz VMADD,b

        sep #$20

        lda #MDMAEN_Setting([0,])
        sta MDMAEN,b

        rep #$20

        jsr rsInitPPURegisters
        jsl rlSoundSystemSetup

        lda #40
        sta wJoyRepeatDelay

        lda #10
        sta wJoyRepeatInterval

        ; Set default VBlank/IRQ routines.

        lda #<>rsDefaultVBlankRoutine
        sta wVBlankPointer

        lda #<>rsIRQDummyRoutine
        sta wIRQPointer

        lda #<>rsUnknown80A63B
        sta wMainLoopPointer

        jmp rsMainLoop._RunLoop

        .databank 0

    .endsection ResetHandlerSection

    .section ResetAlreadyInitializedSection

      rsResetAlreadyInitialized ; 80/8BA7

        .autsiz
        .databank ?

        rep #$30

        ldx #<>aStackSpace.bFirstFree
        txs

        sep #$20

        lda #INIDISP_Setting(true, 0)
        sta INIDISP,b

        stz NMITIMEN,b
        stz MDMAEN,b
        stz HDMAEN,b

        rep #$30

        jmp riResetE._ClearRAM

        .databank 0

    .endsection ResetAlreadyInitializedSection

    .section MainLoopSection

      rsMainLoop ; 80/8BC2

        .autsiz
        .databank ?

        ; Every frame, runs a routine
        ; pointed to by wMainLoopPointer,
        ; then waits for the next frame.

        ; Inputs:
        ; wMainLoopPointer: short pointer to routine

        ; Outputs:
        ; None

        rep #$30

        jsl rlHaltUntilVBlank

        _RunLoop

        rep #$30

        pea #<>rsMainLoop-1

        jmp (wMainLoopPointer)

        .databank 0

    .endsection MainLoopSection

.endif ; GUARD_FE5_RESET
