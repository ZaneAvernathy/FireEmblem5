
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_JOYPAD :?= false
.if (!GUARD_FE5_JOYPAD)
  GUARD_FE5_JOYPAD := true

  ; Freespace inclusions

  .section GetJoypadInputSection

    rlGetJoypadInput ; 80/8002

      .autsiz
      .databank ?

      ; Reads joypad input every frame.
      ; You shouldn't call this yourself.

      ; Inputs:
      ; None

      ; Outputs:
      ; None

      php

      sep #$20

      ; Wait for controllers.

      -
      lda HVBJOY,b
      and #HVBJOY_JoypadBusy
      bne -

      rep #$20

      ; Controller 1

      ; Fetch inputs.

      lda JOY1,b
      sta wJoy1Input

      ; If a nonstandard controller
      ; is plugged in, use old inputs.

      and #JOY_ID
      beq +

        lda wJoy1Old
        sta wJoy1Input

      +

      ; Strip strictly-new inputs.

      lda wJoy1Input
      eor wJoy1Old
      and wJoy1Input
      sta wJoy1New
      sta wJoy1Repeated

      ; Check for held inputs.

      lda wJoy1Input
      beq _Joy1Reset

      cmp wJoy1Old
      bne _Joy1Reset

        ; Every time the timer ticks out,
        ; set the repeated inputs and
        ; reset the timer to the repeat
        ; interval.

        dec wJoy1RepeatTimer
        bne +

          lda wJoy1Input
          sta wJoy1Repeated

          lda wJoyRepeatInterval
          sta wJoy1RepeatTimer

          bra +

      _Joy1Reset

      lda wJoyRepeatDelay
      sta wJoy1RepeatTimer

      +

      lda wJoy1Input
      sta wJoy1Old

      ; Same thing for controller 2

      lda JOY2,b
      sta wJoy2Input

      ; If a nonstandard controller
      ; is plugged in, use old inputs.

      and #JOY_ID
      beq +

        lda wJoy2Old
        sta wJoy2Input

      +

      ; Strip strictly-new inputs.

      lda wJoy2Input
      eor wJoy2Old
      and wJoy2Input
      sta wJoy2New
      sta wJoy2Repeated

      ; Check for held inputs.

      lda wJoy2Input
      beq _Joy2Reset

      cmp wJoy2Old
      bne _Joy2Reset

        ; Every time the timer ticks out,
        ; set the repeated inputs and
        ; reset the timer to the repeat
        ; interval.

        dec wJoy2RepeatTimer
        bne +

          lda wJoy2Input
          sta wJoy2Repeated

          lda wJoyRepeatInterval
          sta wJoy2RepeatTimer

          bra +

      _Joy2Reset

      lda wJoyRepeatDelay
      sta wJoy2RepeatTimer

      +

      lda wJoy2Input
      sta wJoy2Old

      plp
      rtl

      .databank 0

  .endsection GetJoypadInputSection

.endif ; GUARD_FE5_JOYPAD
