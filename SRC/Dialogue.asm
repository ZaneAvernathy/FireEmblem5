
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_DIALOGUE :?= false
.if (!GUARD_FE5_DIALOGUE)
  GUARD_FE5_DIALOGUE := true

  ; Definitions

    .weak

      .include "../TEXT/DIALOGUE/Dialogue.h"

      ; Control codes

        DIALOGUE_ESCAPE .segment Code
          ; Text codes $10+ must be escaped in order to be used.
          ; The macros for these codes already include the escape byte,
          ; but this macro is incldued here for completeness.
          ; You can use this with text codes $00-$0F, too.
          .byte $00, \Code
        .endsegment

        ; $00 technically exists as a duplicate of `DIALOGUE_NL`
        ; but $00 is used to escape codes $10+. You could technically
        ; use it by using `DIALOGUE_ESCAPE $00`.

        DIALOGUE_EOF .segment
          ; Ends the current dialogue string. For
          ; proper scenes, `DIALOGUE_END_SCENE` should
          ; be used.
          .byte $01
        .endsegment

        DIALOGUE_NL .segment
          ; Advances to the next line. Depending on
          ; the context, may scroll text.
          .byte $02
        .endsegment

        DIALOGUE_CLEAR .segment
          ; Resets the text drawing position and
          ; clears text (depending on the context,
          ; this may occur when the next character is
          ; rendered or may occur instantly.)
          .byte $03
        .endsegment

        DIALOGUE_SCROLL .segment
          ; Advances lines until all drawn lines
          ; are gone. Depending on the context,
          ; may scroll text.
          .byte $04
        .endsegment

        DIALOGUE_END_SCENE .segment
          ; Ends a dialogue scene. For other dialogue
          ; font text, `DIALOGUE_EOF` may be more appropriate.
          .byte $05
        .endsegment

        DIALOGUE_LEFT .segment
          ; Sets the `left` portrait slot as active,
          ; affecting text rendering and commands
          ; that come afterward.
          .byte $06
        .endsegment

        DIALOGUE_RIGHT .segment
          ; Sets the `left` portrait slot as active,
          ; affecting text rendering and commands
          ; that come afterward.
          .byte $07
        .endsegment

        DIALOGUE_WAIT_PRESS .segment
          ; Halts dialogue processing until the
          ; `A` button is pressed.
          .byte $08
        .endsegment

        ; These all select a font `page`, which is a
        ; set of 240 glyphs. You can only draw glyphs from
        ; a single page at a time, and you must switch pages
        ; by using one for the following commands in order
        ; to use glyphs from another page.

        ; The text engine begins set to page 0, but it
        ; is considered good practice to set the page you're
        ; using anyway.

        DIALOGUE_FONT_0 .segment
          .byte $09
          .enc "DialoguePage0"
        .endsegment

        DIALOGUE_FONT_1 .segment
          .byte $0A
          .enc "DialoguePage1"
        .endsegment

        DIALOGUE_FONT_2 .segment
          .byte $0B
          .enc "DialoguePage2"
        .endsegment

        DIALOGUE_FONT_3 .segment
          .byte $0C
          .enc "DialoguePage3"
        .endsegment

        DIALOGUE_FONT_4 .segment
          .byte $0D
          .enc "DialoguePage4"
        .endsegment

        DIALOGUE_FONT_5 .segment
          .byte $0E
          .enc "DialoguePage5"
        .endsegment

        DIALOGUE_PAUSE .segment Time
          ; Pauses for a number of frames.
          .byte $0F
          .byte \Time
        .endsegment

        DIALOGUE_SET_TILEMAP_ABSOLUTE .segment BufferOffset
          ; Sets the dialogue system's position in the tilemap
          ; buffer to the given offset. This isn't relative to the
          ; text box and is most likely going to be relative to the
          ; top left of the screen.
          .byte $00, $10
          .word \BufferOffset
        .endsegment

        DIALOGUE_SET_TILEMAP_ABSOLUTE_COORDS .segment Coordinates=[], Width=32
          ; This is an alias for `DIALOGUE_SET_TILEMAP_ABSOLUTE`,
          ; where you can specify coordinates instead of an offset.
          DIALOGUE_SET_TILEMAP_ABSOLUTE ((\Coordinates[1] * \Width) + \Coordinates[0]) * size(word)
        .endsegment

        DIALOGUE_SET_TEXT_BOX_AREA .segment Width, Height
          ; Sets the size of the usable text area
          ; dimensions in tiles.
          .byte $00, $11
          .byte \Width, \Height
        .endsegment

        DIALOGUE_SET_TEXT_SPEED .segment Speed
          ; Sets the speed at which text is rendered.
          ; Lower (positive) is faster.
          ; Some reference values:
          ; 1 (text speed fast)
          ; 3 (text speed normal)
          ; 5 (text speed slow)
          ; Setting the speed to -3 will
          ; reset the text speed back to the speed setting
          ; in the options window.
          .byte $00, $12
          .byte \Speed
        .endsegment

        DIALOGUE_SET_MUSIC .segment Song
          ; Sets the current music.
          .byte $00, $13
          .byte \Song
        .endsegment

        DIALOGUE_SET_TEXT_SOUND .segment Sound
          ; Sets the sound of text bloops.
          ; Possible values:
          ; 0: no sound
          ; 1: normal bloops
          ; 2: quiet clicks
          ; 3: quiet bloops
          ; 4-10: normal bloops
          .byte $00, $14
          .byte \Sound
        .endsegment

        DIALOGUE_SET_BASE_TILE .segment BaseTile
          ; Sets the base tile used for text.
          ; Can be used to set the color of text.
          .byte $00, $15
          .word \BaseTile
        .endsegment

        DIALOGUE_SET_FILL_TILE .segment FillTile
          ; Sets the fill tile used for clearing text.
          .byte $00, $16
          .word \FillTile
        .endsegment

        DIALOGUE_WAIT_CLEAR .segment
          ; This is a combined `DIALOGUE_WAIT_PRESS` and
          ; `DIALOGUE_CLEAR`.
          .byte $00, $17
        .endsegment

        ; $00, $18 is a duplicate of `DIALOGUE_WAIT_PRESS`

        DIALOGUE_SET_TILEMAP_RELATIVE .segment BufferOffset
          ; Sets the dialogue system's position in the tilemap
          ; buffer to the given offset. This is relative to the
          ; current text box.
          .byte $00, $19
          .word \BufferOffset
        .endsegment

        DIALOGUE_SET_TILEMAP_RELATIVE_COORDS .segment Coordinates=[], Width=32
          ; This is an alias for `DIALOGUE_SET_TILEMAP_RELATIVE`,
          ; where you can specify coordinates instead of an offset.
          DIALOGUE_SET_TILEMAP_RELATIVE ((\Coordinates[1] * \Width) + \Coordinates[0]) * size(word)
        .endsegment

        DIALOGUE_SET_GRAPHICS_BASE .segment VRAMPosition
          ; Sets the VRAM position that text graphics
          ; will be drawn to.
          .byte $00, $1A
          .word \VRAMPosition
        .endsegment

        DIALOGUE_SET_TILEMAP_BUFFER .segment TilemapBuffer
          ; Sets the position of the start of the tilemap buffer.
          .byte $00, $1B
          .long \TilemapBuffer
        .endsegment

        DIALOGUE_ALIGN .segment Padding=0
          ; Aligns text drawing to the next tile, and adds
          ; a number of possible blank tiles.
          .byte $00, $1C
          .byte \Padding
        .endsegment

        ; $00, $1D is a duplicate of `DIALOGUE_PAUSE`

        DIALOGUE_OVERWRITE_STATUS .segment Status
          ; Overwrites the entire dialogue engine status
          ; bitfield with `Status`.
          .byte $00, $1E
          .word \Status
        .endsegment

        DIALOGUE_SET_STATUS .segment Status
          ; Sets the specified `Status` bits in the
          ; dialogue engine status bitfield.
          .byte $00, $1F
          .word \Status
        .endsegment

        DIALOGUE_CLEAR_STATUS .segment Status
          ; Unsets the specified `Status` bits in the
          ; dialogue engine status bitfield.
          .byte $00, $20
          .word \Status
        .endsegment

        ; $00, $21 and $00, $22 are no-ops

        DIALOGUE_LOAD_RAM_BY_SLOT .segment
          ; Loads a portrait to the current slot
          ; based on the portrait ID in
          ; $7E4594 (left slot)
          ; $7E4596 (right slot)
          .byte $00, $23
        .endsegment

        DIALOGUE_NUMBER .segment
          ; Draws a number based on the word at $7E4598.
          ; This doesn't accept `0` as an input, use
          ; `DIALOGUE_NUMBER_PADDED` if your value can be `0`.
          .byte $00, $24
        .endsegment

        DIALOGUE_NUMBER2 .segment
          ; Draws a number based on the word at $7E459A.
          ; This doesn't accept `0` as an input, use
          ; `DIALOGUE_NUMBER_PADDED2` if your value can be `0`.
          .byte $00, $25
        .endsegment

        DIALOGUE_NUMBER_PADDED .segment Width
          ; Draws a number based on the word at $7E4598.
          ; Tries to right-align the number within a `Width` number
          ; of characters by padding with spaces.
          .byte $00, $26
          .byte \Width
        .endsegment

        DIALOGUE_NUMBER_PADDED2 .segment Width
          ; Draws a number based on the word at $7E459A.
          ; Tries to right-align the number within a `Width` number
          ; of characters by padding with spaces.
          .byte $00, $27
          .byte \Width
        .endsegment

        ; $00, $28 and $00, $29 are no-ops

        DIALOGUE_SCROLL_ALL .segment
          ; Scrolls both text boxes as if `DIALOGUE_SCROLL`
          ; was used on both.
          .byte $00, $2A
        .endsegment

        DIALOGUE_SET_TEXT .segment DialoguePointer
          ; Changes the string being interpreted by the
          ; dialogue engine.
          .byte $00, $2B
          .long \DialoguePointer
        .endsegment

        ; $00, $2C and $00, $2D are no-ops

        DIALOGUE_ASMC_0 .segment Pointer
          ; Calls a native assembly routine.
          .byte $00, $2E
          .long \Pointer
        .endsegment

        DIALOGUE_ASMC_1 .segment Pointer, Arg1
          ; Calls a native assembly routine, passing in
          ; `Arg1` in `A`.
          .byte $00, $2F
          .long \Pointer
          .word \Arg1
        .endsegment

        DIALOGUE_ASMC_2 .segment Pointer, Arg1, Arg2
          ; Calls a native assembly routine, passing in
          ; `Arg1` in `A` and `Arg2` in `X`.
          .byte $00, $30
          .long \Pointer
          .word \Arg1
          .word \Arg2
        .endsegment

        DIALOGUE_LOAD_RAM .segment
          ; Loads a portrait to the current slot
          ; based on the portrait ID in $7E4594
          .byte $00, $31
        .endsegment

        DIALOGUE_LOAD_RAM2 .segment
          ; Loads a portrait to the current slot
          ; based on the portrait ID in $7E4596
          .byte $00, $32
        .endsegment

        ; $00, $33 is a no-op

        DIALOGUE_PLAY_SOUND .segment SoundID
          ; Plays a sound effect.
          .byte $00, $34
          .byte \SoundID
        .endsegment

        ; $00, $35 and $00, $36 are no-ops

        ; $00, $37 is a duplicate of `DIALOGUE_LOAD_RAM2`

        DIALOGUE_OPEN .segment
          ; Displays the text box for the current slot.
          .byte $00, $38
        .endsegment

        DIALOGUE_CLOSE .segment
          ; Hides the text box for the current slot.
          .byte $00, $39
        .endsegment

        DIALOGUE_LOAD .segment Portrait
          ; Loads a portrait into the current slot.
          .byte $00, $3A
          .word \Portrait
        .endsegment

        DIALOGUE_UNLOAD .segment
          ; Unloads the portrait in the current slot.
          .byte $00, $3B
        .endsegment

    .endweak

.endif ; GUARD_FE5_DIALOGUE
