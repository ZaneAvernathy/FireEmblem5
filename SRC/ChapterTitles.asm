
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_CHAPTERTITLES :?= false
.if (!GUARD_FE5_CHAPTERTITLES)
  GUARD_FE5_CHAPTERTITLES := true

  ; Freespace inclusions

    .section ChapterTitleSection

      startDialogue

        dialogueChapter1Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter1.dialogue.txt" ; 9A/B7EF
        dialogueChapter2Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter2.dialogue.txt" ; 9A/B80F
        dialogueChapter2xTitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter2x.dialogue.txt" ; 9A/B82D
        dialogueChapter3Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter3.dialogue.txt" ; 9A/B848
        dialogueChapter4Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter4.dialogue.txt" ; 9A/B867
        dialogueChapter4xTitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter4x.dialogue.txt" ; 9A/B886
        dialogueChapter5Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter5.dialogue.txt" ; 9A/B8A4
        dialogueChapter6Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter6.dialogue.txt" ; 9A/B8C3
        dialogueChapter7Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter7.dialogue.txt" ; 9A/B8DF
        dialogueChapter8Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter8.dialogue.txt" ; 9A/B8FF
        dialogueChapter8xTitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter8x.dialogue.txt" ; 9A/B91C
        dialogueChapter9Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter9.dialogue.txt" ; 9A/B93A
        dialogueChapter10Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter10.dialogue.txt" ; 9A/B95A
        dialogueChapter11Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter11.dialogue.txt" ; 9A/B971
        dialogueChapter11xTitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter11x.dialogue.txt" ; 9A/B989
        dialogueChapter12Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter12.dialogue.txt" ; 9A/B99F
        dialogueChapter12xTitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter12x.dialogue.txt" ; 9A/B9B7
        dialogueChapter13Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter13.dialogue.txt" ; 9A/B9CE
        dialogueChapter14Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter14.dialogue.txt" ; 9A/B9E3
        dialogueChapter14xTitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter14x.dialogue.txt" ; 9A/B9F8
        dialogueChapter15Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter15.dialogue.txt" ; 9A/BA12
        dialogueChapter16ATitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter16A.dialogue.txt" ; 9A/BA27
        dialogueChapter17ATitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter17A.dialogue.txt" ; 9A/BA3E
        dialogueChapter16BTitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter16B.dialogue.txt" ; 9A/BA56
        dialogueChapter17BTitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter17B.dialogue.txt" ; 9A/BA6D
        dialogueChapter18Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter18.dialogue.txt" ; 9A/BA84
        dialogueChapter19Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter19.dialogue.txt" ; 9A/BA99
        dialogueChapter20Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter20.dialogue.txt" ; 9A/BAB2
        dialogueChapter21Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter21.dialogue.txt" ; 9A/BAC9
        dialogueChapter21xTitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter21x.dialogue.txt" ; 9A/BADE
        dialogueChapter22Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter22.dialogue.txt" ; 9A/BAF7
        dialogueChapter22xTitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter22x.dialogue.txt" ; 9A/BB0F
        dialogueChapter23Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter23.dialogue.txt" ; 9A/BB28
        dialogueChapter24Title .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter24.dialogue.txt" ; 9A/BB3F
        dialogueChapter24xTitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/Chapter24x.dialogue.txt" ; 9A/BB59
        dialogueChapterFinalTitle .include "../TEXT/DIALOGUE/CHAPTERTITLES/ChapterFinal.dialogue.txt" ; 9A/BB6F

      endDialogue

    .endsection ChapterTitleSection

.endif ; GUARD_FE5_CHAPTERTITLES
