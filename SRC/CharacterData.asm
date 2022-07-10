
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_CHARACTER_DATA :?= false
.if (!GUARD_FE5_CHARACTER_DATA)
  GUARD_FE5_CHARACTER_DATA := true

  ; Definitions

    .weak

    .endweak

  ; Freespace inclusions

    .section SupportDataSection

      startData

        aSupportData .include "../TABLES/SupportData.csv.asm"
        .word 0

      endData

    .endsection SupportDataSection

    .section AutolevelDataSection

      startData

        aAutolevelSchemePointers .block ; 88/8232
          .word None
          .addr AutolevelScheme1AutolevelDataEntry
          .addr AutolevelScheme2AutolevelDataEntry
          .addr AutolevelScheme3AutolevelDataEntry
          .addr AutolevelScheme4AutolevelDataEntry
          .addr AutolevelScheme5AutolevelDataEntry
          .addr AutolevelScheme6AutolevelDataEntry
          .addr AutolevelScheme7AutolevelDataEntry
          .addr AutolevelScheme8AutolevelDataEntry
          .addr AutolevelScheme9AutolevelDataEntry
        .endblock

        aAutolevelSchemes .include "../TABLES/AutolevelData.csv.asm" ; 88/8246

      endData

    .endsection AutolevelDataSection

    .section DeathQuoteDialogueSection

      dialogueSigurdPlaceholderDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/SigurdPlaceholder.dialogue.txt" ; 82/B8AF
      dialogueLeifDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Leif.dialogue.txt" ; 82/B8B8
      dialogueFinnDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Finn.dialogue.txt" ; 82/B8CD
      dialogueOrsinDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Orsin.dialogue.txt" ; 82/B8F1
      dialogueHalvanDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Halvan.dialogue.txt" ; 82/B90C
      dialogueEyvelDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Eyvel.dialogue.txt" ; 82/B933
      dialogueDagdarDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Dagdar.dialogue.txt" ; 82/B964
      dialogueRalphDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Ralph.dialogue.txt" ; 82/B98B
      dialogueMartyDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Marty.dialogue.txt" ; 82/B9A9
      dialogueRonanDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Ronan.dialogue.txt" ; 82/B9BA
      dialogueMirandaDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Miranda.dialogue.txt" ; 82/B9CC
      dialogueSapphieDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Sapphie.dialogue.txt" ; 82/B9F6
      dialogueLaraDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Lara.dialogue.txt" ; 82/BA1B
      dialogueBrightonDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Brighton.dialogue.txt" ; 82/BA3F
      dialogueFergusDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Fergus.dialogue.txt" ; 82/BA5A
      dialogueEdaDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Eda.dialogue.txt" ; 82/BA7D
      dialogueAsvelDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Asvel.dialogue.txt" ; 82/BAB3
      dialogueMatriaDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Matria.dialogue.txt" ; 82/BAD2
      dialogueHicksDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Hicks.dialogue.txt" ; 82/BB03
      dialogueNannaDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Nanna.dialogue.txt" ; 82/BB30
      dialogueSelphinaDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Selphina.dialogue.txt" ; 82/BB4F
      dialogueDahlsonDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Dahlson.dialogue.txt" ; 82/BB7B
      dialogueCallionDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Callion.dialogue.txt" ; 82/BB9F
      dialogueGalzus1DeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Galzus1.dialogue.txt" ; 82/BBBB
      dialoguePanDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Pan.dialogue.txt" ; 82/BBEB
      dialogueGladeDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Glade.dialogue.txt" ; 82/BC0C
      dialogueKaneDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Kane.dialogue.txt" ; 82/BC40
      dialogueAlbaDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Alba.dialogue.txt" ; 82/BC60
      dialogueRobertDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Robert.dialogue.txt" ; 82/BC87
      dialogueFredDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Fred.dialogue.txt" ; 82/BCB5
      dialogueOlwenDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Olwen.dialogue.txt" ; 82/BCD9
      dialogueCedDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Ced.dialogue.txt" ; 82/BCF4
      dialogueLithis1DeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Lithis1.dialogue.txt" ; 82/BD23
      dialogueKarinDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Karin.dialogue.txt" ; 82/BD3D
      dialogueDeanDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Dean.dialogue.txt" ; 82/BD63
      dialogueShanam2DeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Shanam2.dialogue.txt" ; 82/BD82
      dialogueTrudeDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Trude.dialogue.txt" ; 82/BD9A
      dialogueTanyaDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Tanya.dialogue.txt" ; 82/BDBD
      dialogueLinoanDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Linoan.dialogue.txt" ; 82/BDD9
      dialogueMischaDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Mischa.dialogue.txt" ; 82/BDEA
      dialogueSalemDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Salem.dialogue.txt" ; 82/BE20
      dialogueSchroffDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Schroff.dialogue.txt" ; 82/BE5C
      dialogueMareetaDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Mareeta.dialogue.txt" ; 82/BE9A
      dialogueTinaDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Tina.dialogue.txt" ; 82/BEAE
      dialogueGunterDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Gunter.dialogue.txt" ; 82/BECF
      dialogueAmaldaDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Amalda.dialogue.txt" ; 82/BEFA
      dialogueConomoreDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Conomore.dialogue.txt" ; 82/BF30
      dialogueHomerDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Homer.dialogue.txt" ; 82/BF54
      dialogueDermottDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Dermott.dialogue.txt" ; 82/BF69
      dialogueSarahDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Sarah.dialogue.txt" ; 82/BF8B
      dialogueSaiasDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/Saias.dialogue.txt" ; 82/BF99
      dialogueUnknownUnusedDeathQuote .include "../TEXT/DIALOGUE/DEATHQUOTES/UnknownUnused.dialogue.txt" ; 82/BFC9
      dialogueLeifDeathNanna .include "../TEXT/DIALOGUE/DEATHQUOTES/LeifDeathNanna.dialogue.txt" ; 82/BFDB
      dialogueLeifDeathFinn .include "../TEXT/DIALOGUE/DEATHQUOTES/LeifDeathFinn.dialogue.txt" ; 82/BFFE
      dialogueLeifDeathEyvel .include "../TEXT/DIALOGUE/DEATHQUOTES/LeifDeathEyvel.dialogue.txt" ; 82/C01C
      dialogueLeifDeathDorias .include "../TEXT/DIALOGUE/DEATHQUOTES/LeifDeathDorias.dialogue.txt" ; 82/C049
      dialogueLeifDeathAugust .include "../TEXT/DIALOGUE/DEATHQUOTES/LeifDeathAugust.dialogue.txt" ; 82/C071

    .endsection DeathQuoteDialogueSection

    .section RetreatQuoteDialogueSection

      dialogueLeifUnusedRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/LeifUnused.dialogue.txt" ; 82/C09B
      dialogueFinnRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Finn.dialogue.txt" ; 82/C0B9
      dialogueOrsinRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Orsin.dialogue.txt" ; 82/C0D3
      dialogueHalvanRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Halvan.dialogue.txt" ; 82/C0F0
      dialogueEyvelRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Eyvel.dialogue.txt" ; 82/C109
      dialogueDagdarRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Dagdar.dialogue.txt" ; 82/C139
      dialogueRalphRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Ralph.dialogue.txt" ; 82/C166
      dialogueMartyRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Marty.dialogue.txt" ; 82/C182
      dialogueRonanRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Ronan.dialogue.txt" ; 82/C199
      dialogueMirandaRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Miranda.dialogue.txt" ; 82/C1B3
      dialogueSapphieRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Sapphie.dialogue.txt" ; 82/C1CC
      dialogueLaraRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Lara.dialogue.txt" ; 82/C1F3
      dialogueBrightonRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Brighton.dialogue.txt" ; 82/C21B
      dialogueFergusRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Fergus.dialogue.txt" ; 82/C237
      dialogueEdaRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Eda.dialogue.txt" ; 82/C263
      dialogueAsvelRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Asvel.dialogue.txt" ; 82/C292
      dialogueMatriaRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Matria.dialogue.txt" ; 82/C2BE
      dialogueHicksRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Hicks.dialogue.txt" ; 82/C2D7
      dialogueNannaRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Nanna.dialogue.txt" ; 82/C2F5
      dialogueSelphinaRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Selphina.dialogue.txt" ; 82/C311
      dialogueDahlsonRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Dahlson.dialogue.txt" ; 82/C340
      dialogueCallionRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Callion.dialogue.txt" ; 82/C377
      dialogueGalzusRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Galzus.dialogue.txt" ; 82/C39D
      dialoguePanRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Pan.dialogue.txt" ; 82/C3AB
      dialogueGladeRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Glade.dialogue.txt" ; 82/C3D4
      dialogueKaneRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Kane.dialogue.txt" ; 82/C3FF
      dialogueAlbaRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Alba.dialogue.txt" ; 82/C429
      dialogueRobertRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Robert.dialogue.txt" ; 82/C43E
      dialogueFredRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Fred.dialogue.txt" ; 82/C44E
      dialogueOlwenRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Olwen.dialogue.txt" ; 82/C472
      dialogueCed1RetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Ced1.dialogue.txt" ; 82/C491
      dialogueCed2RetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Ced2.dialogue.txt" ; 82/C4AD
      dialogueLithisRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Lithis.dialogue.txt" ; 82/C4C7
      dialogueKarinRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Karin.dialogue.txt" ; 82/C4EF
      dialogueDeanRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Dean.dialogue.txt" ; 82/C521
      dialogueShanamRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Shanam.dialogue.txt" ; 82/C541
      dialogueTrudeRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Trude.dialogue.txt" ; 82/C557
      dialogueTanyaRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Tanya.dialogue.txt" ; 82/C575
      dialogueLinoanRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Linoan.dialogue.txt" ; 82/C5A2
      dialogueMischaRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Mischa.dialogue.txt" ; 82/C5C0
      dialogueSalemRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Salem.dialogue.txt" ; 82/C5E3
      dialogueSchroffRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Schroff.dialogue.txt" ; 82/C605
      dialogueMareetaRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Mareeta.dialogue.txt" ; 82/C641
      dialogueTinaRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Tina.dialogue.txt" ; 82/C663
      dialogueGunterRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Gunter.dialogue.txt" ; 82/C68B
      dialogueAmaldaRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Amalda.dialogue.txt" ; 82/C6C0
      dialogueConomoreRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Conomore.dialogue.txt" ; 82/C6E4
      dialogueHomerRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Homer.dialogue.txt" ; 82/C704
      dialogueDermottRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Dermott.dialogue.txt" ; 82/C72F
      dialogueSarahRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Sarah.dialogue.txt" ; 82/C748
      dialogueSaiasRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Saias.dialogue.txt" ; 82/C756
      dialogueShivaRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Shiva.dialogue.txt" ; 82/C77A
      dialogueXavierRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Xavier.dialogue.txt" ; 82/C78D
      dialogueIliosRetreatQuote .include "../TEXT/DIALOGUE/RETREATQUOTES/Ilios.dialogue.txt" ; 82/C7A1

    .endsection RetreatQuoteDialogueSection

.endif ; GUARD_FE5_CHARACTER_DATA
