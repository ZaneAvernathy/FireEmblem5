
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_TILESETS :?= false
.if (!GUARD_FE5_TILESETS)
  GUARD_FE5_TILESETS := true

  ; Definitions

    .weak

    .endweak

  ; Freespace inclusions

    .section ChapterTilesetFadePaletteBlock1Section

      startPalettes

        aChapter1TilesetFadePalette .text ROM[$37F388:$37F42A]
        aChapter2TilesetFadePalette .text ROM[$37F42A:$37F4C2]
        aChapter2xTilesetFadePalette .text ROM[$37F4C2:$37F559]
        aChapter3TilesetFadePalette .text ROM[$37F559:$37F5FB]
        aChapter4TilesetFadePalette .text ROM[$37F5FB:$37F692]
        aChapter4xTilesetFadePalette .text ROM[$37F692:$37F722]
        aChapter5TilesetFadePalette .text ROM[$37F722:$37F7C0]
        aChapter6TilesetFadePalette .text ROM[$37F7C0:$37F85F]
        aChapter07TilesetFadePalette .text ROM[$37F85F:$37F8F4]
        aChapter08TilesetFadePalette .text ROM[$37F8F4:$37F98D]
        aChapter08xTilesetFadePalette .text ROM[$37F98D:$37FA1A]
        aChapter09TilesetFadePalette .text ROM[$37FA1A:$37FAA6]
        aChapter10TilesetFadePalette .text ROM[$37FAA6:$37FB3B]
        aChapter11TilesetFadePalette .text ROM[$37FB3B:$37FBDC]
        aChapter11xTilesetFadePalette .text ROM[$37FBDC:$37FC78]
        aChapter12TilesetFadePalette .text ROM[$37FC78:$37FD06]
        aChapter12xTilesetFadePalette .text ROM[$37FD06:$37FD93]
        aChapter13TilesetFadePalette .text ROM[$37FD93:$37FE25]
        aChapter14TilesetFadePalette .text ROM[$37FE25:$37FEB3]
        aChapter14xTilesetFadePalette .text ROM[$37FEB3:$37FF4F]
        aChapter15TilesetFadePalette .text ROM[$37FF4F:$37FFE9]
        aChapter16ATilesetFadePalette crossbankRaw ROM[$37FFE9:$380079]

      endPalettes

    .endsection ChapterTilesetFadePaletteBlock1Section

    .section ChapterTilesetFadePaletteBlock2Section

      startPalettes

        crossbankRawRemainder

        aChapter17ATilesetFadePalette .text ROM[$380079:$38010B]
        aChapter16BTilesetFadePalette .text ROM[$38010B:$380198]
        aChapter17BTilesetFadePalette .text ROM[$380198:$38022B]
        aChapter18TilesetFadePalette .text ROM[$38022B:$3802C9]
        aChapter19TilesetFadePalette .text ROM[$3802C9:$38035A]
        aChapter20TilesetFadePalette .text ROM[$38035A:$3803FB]
        aChapter21TilesetFadePalette .text ROM[$3803FB:$380491]
        aChapter21xTilesetFadePalette .text ROM[$380491:$380533]
        aChapter22TilesetFadePalette .text ROM[$380533:$380659]
        aChapter23TilesetFadePalette .text ROM[$380659:$3806E7]
        aChapter24TilesetFadePalette .text ROM[$3806E7:$380780]
        aChapter24xTilesetFadePalette .text ROM[$380780:$380820]
        aChapterFinalTilesetFadePalette .text ROM[$380820:$3808C0]
        aChapterUnknownTilesetFadePalette .text ROM[$3808C0:$380960]

      endPalettes

    .endsection ChapterTilesetFadePaletteBlock2Section

.endif ; GUARD_FE5_TILESETS
