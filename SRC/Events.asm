
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_EVENT_INSTALLER :?= false
.if (!GUARD_FE5_EVENT_INSTALLER)
  GUARD_FE5_EVENT_INSTALLER := true

  ; Definitions

    .weak

    .endweak

  .include "../EVENTS/Chapter01.event"
  .include "../EVENTS/Chapter02.event"
  .include "../EVENTS/Chapter02x.event"
  .include "../EVENTS/Chapter03.event"
  .include "../EVENTS/Chapter04.event"
  .include "../EVENTS/Chapter04x.event"
  .include "../EVENTS/Chapter05.event"
  .include "../EVENTS/Chapter06.event"
  .include "../EVENTS/Chapter07.event"
  .include "../EVENTS/Chapter08.event"
  .include "../EVENTS/Chapter08x.event"
  .include "../EVENTS/Chapter09.event"
  .include "../EVENTS/Chapter10.event"
  .include "../EVENTS/Chapter11.event"
  .include "../EVENTS/Chapter11x.event"
  .include "../EVENTS/Chapter12.event"
  .include "../EVENTS/Chapter12x.event"
  .include "../EVENTS/Chapter13.event"
  .include "../EVENTS/Chapter14.event"
  .include "../EVENTS/Chapter14x.event"
  .include "../EVENTS/Chapter15.event"
  .include "../EVENTS/Chapter16A.event"
  .include "../EVENTS/Chapter17A.event"
  .include "../EVENTS/Chapter16B.event"
  .include "../EVENTS/Chapter17B.event"
  .include "../EVENTS/Chapter18.event"
  .include "../EVENTS/Chapter19.event"
  .include "../EVENTS/Chapter20.event"
  .include "../EVENTS/Chapter21.event"
  .include "../EVENTS/Chapter21x.event"
  .include "../EVENTS/Chapter22.event"
  .include "../EVENTS/Chapter23.event"
  .include "../EVENTS/Chapter24.event"
  .include "../EVENTS/Chapter24x.event"
  .include "../EVENTS/ChapterFinal.event"

  ; Freespace inclusions

    .section ChapterEndLinoanDeadDialogueSection

      dialogueChapterEndLinoanDead .include "../TEXT/DIALOGUE/ChapterEndLinoanDead.dialogue.txt" ; 82/C7D9

    .endsection ChapterEndLinoanDeadDialogueSection

    .section UnusedBlankWMDialogueSection

      dialogueUnusedBlankWM .include "../TEXT/DIALOGUE/UnusedBlankWM.dialogue.txt" ; 82/C82E

    .endsection UnusedBlankWMDialogueSection

.endif ; GUARD_FE5_EVENT_INSTALLER
