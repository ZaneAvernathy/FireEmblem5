
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_IRQ :?= false
.if (!GUARD_FE5_IRQ)
  GUARD_FE5_IRQ := true

  ; Freespace inclusions

    .section IRQHandlerSection

      startCode

        riIRQN ; 80/82B4

          .autsiz
          .databank ?

          ; Handles IRQs.
          ; You shouldn't call this yourself.

          ; Inputs:
          ; wIRQPointer: short pointer to routine

          ; Outputs:
          ; None

          rep #$30

          ; Break out of bank 00

          jml +

          +

          phb
          phd
          pha
          phx
          phy

          phk
          plb

          .databank `*

          lda #0
          tcd

          ; Execute routine if IRQ.

          lda TIMEUP,b
          bit #TIMEUP_IRQ
          beq +

            pea #<>(+)-size(byte)
            jmp (wIRQPointer)

          +

          ply
          plx
          pla
          pld
          plb

          rti

          .databank 0

      endCode

    .endsection IRQHandlerSection

    .section IRQDummyRoutineSection

      startCode

        rsIRQDummyRoutine ; 80/82D9

          .autsiz
          .databank ?

          ; wIRQPointer is set to this
          ; when there isn't anything needed
          ; for IRQs.

          ; Inputs:
          ; None

          ; Outputs:
          ; None

          rts

          .databank 0

      endCode

    .endsection IRQDummyRoutineSection

.endif ; GUARD_FE5_IRQ
