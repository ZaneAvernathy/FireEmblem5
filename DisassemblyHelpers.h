
.weak
  WARNINGS :?= "None"
.endweak

GUARD_DISASSEMBLY_HELPERS :?= false
.if (!GUARD_DISASSEMBLY_HELPERS)
  GUARD_DISASSEMBLY_HELPERS := true

  ; These are used to track the
  ; current number of bytes disassembled.

  DisassemblySize := 0

  DataSize        := 0
  CodeSize        := 0
  GraphicsSize    := 0
  EventsSize      := 0

  DataStarts      := [0]
  DataEnds        := [0]

  CodeStarts      := [0]
  CodeEnds        := [0]

  GraphicsStarts  := [0]
  GraphicsEnds    := [0]

  EventsStarts    := [0]
  EventsEnds      := [0]

  TextStarts    := [0]
  TextEnds      := [0]

  startData .segment Pointer=*
    DataStarts ..= [\Pointer]
  .endm

  startCode .segment Pointer=*
    CodeStarts ..= [\Pointer]
  .endm

  startGraphics .segment Pointer=*
    GraphicsStarts ..= [\Pointer]
  .endm

  startEvents .segment Pointer=*
    EventsStarts ..= [\Pointer]
  .endm

  startText .segment Pointer=*
    TextStarts ..= [\Pointer]
  .endm

  endData .segment Pointer=*
    DataEnds ..= [\Pointer]
  .endm

  endCode .segment Pointer=*
    CodeEnds ..= [\Pointer]
  .endm

  endGraphics .segment Pointer=*
    GraphicsEnds ..= [\Pointer]
  .endm

  endEvents .segment Pointer=*
    EventsEnds ..= [\Pointer]
  .endm

  endText .segment Pointer=*
    TextEnds ..= [\Pointer]
  .endm

  SizeFormatter .function dSize, ROMSize=$400000
  .endf format("$%06X %%%02.2f", dSize, 100.0-((float(ROMSize-dSize)/float(ROMSize)*100)))

.endif ; GUARD_DISASSEMBLY_HELPERS
