
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_PORTRAITS :?= false
.if (!GUARD_FE5_PORTRAITS)
  GUARD_FE5_PORTRAITS := true

  ; Definitions

    .weak

      structPortraitEntry .struct GraphicsPointer, PaletteIndex
        GraphicsPointer .long \GraphicsPointer
        PaletteIndex .byte \PaletteIndex
      .endstruct

    .endweak

  ; Freespace inclusions

    .section PortraitTableSection

      startData

        aPortraitTable .include "../TABLES/Portraits.csv.asm"

      endData

    .endsection PortraitTableSection

    .section PortraitPalettesSection

      startPalettes

        ; TODO: figure out the gaps

        aPortraitPalettes .include "../TABLES/PortraitPalettes.csv.asm"

      endPalettes

    .endsection PortraitPalettesSection

    .section PortraitGraphicsBlock1Section

      startPortraits

        g4bppcLeifPortrait .text ROM[$355E80:$3563B9]
        g4bppcFinnPortrait .text ROM[$3563B9:$3568B7]
        g4bppcNannaPortrait .text ROM[$3568B7:$356E23]
        g4bppcHannibalPortrait .text ROM[$356E23:$357322]
        g4bppcJuliusPortrait .text ROM[$357322:$3578A6]
        g4bppcIshtarPortrait .text ROM[$3578A6:$357E34]
        g4bppcArionPortrait crossbankRaw ROM[$357E34:$358318]

      endPortraits

    .endsection PortraitGraphicsBlock1Section

    .section PortraitGraphicsBlock2Section

      startPortraits

        crossbankRawRemainder

        g4bppcTravantPortrait .text ROM[$358318:$358851]
        g4bppcCairprePortrait .text ROM[$358851:$358C84]
        g4bppcSeliphPortrait .text ROM[$358C84:$3591DE]
        g4bppcLeifAngryPortrait .text ROM[$3591DE:$359717]
        g4bppcDermottPortrait .text ROM[$359717:$359BD9]
        g4bppcDaisyPortrait .text ROM[$359BD9:$35A119]
        g4bppcAsaelloPortrait .text ROM[$35A119:$35A613]
        g4bppcLewynPortrait .text ROM[$35A613:$35AB36]
        g4bppcJuliaPortrait .text ROM[$35AB36:$35B048]
        g4bppcLaraPortrait .text ROM[$35B048:$35B605]
        g4bppcMirandaPortrait .text ROM[$35B605:$35BADC]
        g4bppcRonanPortrait .text ROM[$35BADC:$35BFB5]
        g4bppcOrsinPortrait .text ROM[$35BFB5:$35C4CE]
        g4bppcHalvanPortrait .text ROM[$35C4CE:$35C9DC]
        g4bppcDagdarPortrait .text ROM[$35C9DC:$35CF30]
        g4bppcRalphPortrait .text ROM[$35CF30:$35D3D2]
        g4bppcEyvelPortrait .text ROM[$35D3D2:$35D981]
        g4bppcMartyPortrait .text ROM[$35D981:$35DE20]
        g4bppcGalzusPortrait .text ROM[$35DE20:$35E3F9]
        g4bppcAlbaPortrait .text ROM[$35E3F9:$35E928]
        g4bppcLeonsterite4Portrait .text ROM[$35E928:$35EE1D]
        g4bppcSelphinaPortrait .text ROM[$35EE1D:$35F2FF]
        g4bppcHicksPortrait .text ROM[$35F2FF:$35F862]
        g4bppcDahlsonPortrait .text ROM[$35F862:$35FD2F]
        g4bppcOlwenPortrait crossbankRaw ROM[$35FD2F:$360209]

      endPortraits

    .endsection PortraitGraphicsBlock2Section

    .section PortraitGraphicsBlock3Section

      startPortraits

        crossbankRawRemainder

        g4bppcPanPortrait .text ROM[$360209:$360729]
        g4bppcCallionPortrait .text ROM[$360729:$360C0D]
        g4bppcMareetaPortrait .text ROM[$360C0D:$361117]
        g4bppcFeminaPortrait .text ROM[$361117:$3615D7]
        g4bppcAsvelPortrait .text ROM[$3615D7:$361AB8]
        g4bppcMatriaPortrait .text ROM[$361AB8:$361F78]
        g4bppcSapphiePortrait .text ROM[$361F78:$3624EE]
        g4bppcMischaPortrait .text ROM[$3624EE:$362A94]
        g4bppcSalemPortrait .text ROM[$362A94:$362FB9]
        g4bppcSchroffPortrait .text ROM[$362FB9:$363499]
        g4bppcFergusPortrait .text ROM[$363499:$3639C0]
        g4bppcBrightonPortrait .text ROM[$3639C0:$363E8D]
        g4bppcSarahPortrait .text ROM[$363E8D:$36430D]
        g4bppcTanyaPortrait .text ROM[$36430D:$364815]
        g4bppcTrudePortrait .text ROM[$364815:$364CDA]
        g4bppcShanamPortrait .text ROM[$364CDA:$36524C]
        g4bppcTinaPortrait .text ROM[$36524C:$36578C]
        g4bppcLinoanPortrait .text ROM[$36578C:$365C66]
        g4bppcSaiasPortrait .text ROM[$365C66:$366173]
        g4bppcAmaldaPortrait .text ROM[$366173:$36662B]
        g4bppcEdaPortrait .text ROM[$36662B:$366B79]
        g4bppcReinhardtPortrait .text ROM[$366B79:$3670A4]
        g4bppcGunterPortrait .text ROM[$3670A4:$3674EA]
        g4bppcFredPortrait .text ROM[$3674EA:$3679CB]
        g4bppcKanePortrait .text ROM[$3679CB:$367E67]
        g4bppcRobertPortrait crossbankRaw ROM[$367E67:$368356]

      endPortraits

    .endsection PortraitGraphicsBlock3Section

    .section PortraitGraphicsBlock4Section

      startPortraits

        crossbankRawRemainder

        g4bppcKarinPortrait .text ROM[$368356:$36885F]
        g4bppcDeanPortrait .text ROM[$36885F:$368DD2]
        g4bppcLithisPortrait .text ROM[$368DD2:$36930E]
        g4bppcCedPortrait .text ROM[$36930E:$369854]
        g4bppcAltenaPortrait .text ROM[$369854:$369D9B]
        g4bppcHomerPortrait .text ROM[$369D9B:$36A2CB]
        g4bppcArthurPortrait .text ROM[$36A2CB:$36A84E]
        g4bppcJeanPortrait .text ROM[$36A84E:$36AD56]
        g4bppcLeonsterite1Portrait .text ROM[$36AD56:$36B266]
        g4bppcIliosPortrait .text ROM[$36B266:$36B735]
        g4bppcLeonsterite3Portrait .text ROM[$36B735:$36BBDE]
        g4bppcXavierPortrait .text ROM[$36BBDE:$36C098]
        g4bppcZaummPortrait .text ROM[$36C098:$36C56B]
        g4bppcGustavPortrait .text ROM[$36C56B:$36C9FC]
        g4bppcDoriasPortrait .text ROM[$36C9FC:$36CEA0]
        g4bppcLobosPortrait .text ROM[$36CEA0:$36D314]
        g4bppcGladePortrait .text ROM[$36D314:$36D7B0]
        g4bppcDvorakPortrait .text ROM[$36D7B0:$36DC05]
        g4bppcEichmannPortrait .text ROM[$36DC05:$36E09F]
        g4bppcFardenPortrait .text ROM[$36E09F:$36E4DA]
        g4bppcAugustPortrait .text ROM[$36E4DA:$36E988]
        g4bppcWeissmanPortrait .text ROM[$36E988:$36ED87]
        g4bppcLeonsterite5Portrait .text ROM[$36ED87:$36F246]
        g4bppcHortefeuxPortrait .text ROM[$36F246:$36F6BA]
        g4bppcCodhaPortrait .text ROM[$36F6BA:$36FBE9]
        g4bppcLeonsterite6Portrait crossbankRaw ROM[$36FBE9:$370071]

      endPortraits

    .endsection PortraitGraphicsBlock4Section

    .section PortraitGraphicsBlock5Section

      startPortraits

        crossbankRawRemainder

        g4bppcLeonsterite7Portrait .text ROM[$370071:$3704E4]
        g4bppcJabalPortrait .text ROM[$3704E4:$3709F5]
        g4bppcZaillePortrait .text ROM[$3709F5:$370ED4]
        g4bppcKolkhoPortrait .text ROM[$370ED4:$371378]
        g4bppcGomerPortrait .text ROM[$371378:$371840]
        g4bppcBakstPortrait .text ROM[$371840:$371D0E]
        g4bppcShivaPortrait .text ROM[$371D0E:$372236]
        g4bppcRaydrikPortrait .text ROM[$372236:$37274E]
        g4bppcLargoPortrait .text ROM[$37274E:$372C11]
        g4bppcBlumePortrait .text ROM[$372C11:$3730AB]
        g4bppcManfroyPortrait .text ROM[$3730AB:$3735B3]
        g4bppcBarathPortrait .text ROM[$3735B3:$373A8A]
        g4bppcConomorePortrait .text ROM[$373A8A:$373F63]
        g4bppcKempfPortrait .text ROM[$373F63:$374477]
        g4bppcVeldPortrait .text ROM[$374477:$37497A]
        g4bppcShopkeeperPortrait .text ROM[$37497A:$374DC7]
        g4bppcArenaPortrait .text ROM[$374DC7:$37520C]
        g4bppcMan1Portrait .text ROM[$37520C:$3756A3]
        g4bppcMan6Portrait .text ROM[$3756A3:$375B4B]
        g4bppcAnnaPortrait .text ROM[$375B4B:$376104]
        g4bppcWoman1Portrait .text ROM[$376104:$376595]
        g4bppcMan7Portrait .text ROM[$376595:$376986]
        g4bppcWoman2Portrait .text ROM[$376986:$376E9B]
        g4bppcGirl1Portrait .text ROM[$376E9B:$37732A]
        g4bppcMan8Portrait .text ROM[$37732A:$377712]
        g4bppcGirl2Portrait .text ROM[$377712:$377C0A]
        g4bppcBoy1Portrait crossbankRaw ROM[$377C0A:$378019]

      endPortraits

    .endsection PortraitGraphicsBlock5Section

    .section PortraitGraphicsBlock6Section

      startPortraits

        crossbankRawRemainder

        g4bppcMan9Portrait .text ROM[$378019:$378470]
        g4bppcWoman3Portrait .text ROM[$378470:$3788E7]
        g4bppcGirl7Portrait .text ROM[$3788E7:$378D9C]
        g4bppcBoy2Portrait .text ROM[$378D9C:$3791AA]
        g4bppcMan10Portrait .text ROM[$3791AA:$3795C0]
        g4bppcMan11Portrait .text ROM[$3795C0:$3799BC]
        g4bppcMan12Portrait .text ROM[$3799BC:$379DCD]
        g4bppcKnightPortrait .text ROM[$379DCD:$37A1F5]
        g4bppcBowKnightPortrait .text ROM[$37A1F5:$37A64C]
        g4bppcAxeKnightPortrait .text ROM[$37A64C:$37AA5D]
        g4bppcMagicKnightPortrait .text ROM[$37AA5D:$37AEBF]
        g4bppcPegasusKnightPortrait .text ROM[$37AEBF:$37B317]
        g4bppcWyvernKnightPortrait .text ROM[$37B317:$37B75D]
        g4bppcArcherPortrait .text ROM[$37B75D:$37BB1D]
        g4bppcMyrmidonPortrait .text ROM[$37BB1D:$37BF16]
        g4bppcGeneralPortrait .text ROM[$37BF16:$37C3DD]
        g4bppcSoldierPortrait .text ROM[$37C3DD:$37C7D1]
        g4bppcFighterPortrait .text ROM[$37C7D1:$37CB8F]
        g4bppcArmorPortrait .text ROM[$37CB8F:$37CFD4]
        g4bppcBrigandPortrait .text ROM[$37CFD4:$37D3A1]
        g4bppcMagicSwordPortrait .text ROM[$37D3A1:$37D772]
        g4bppcPriestPortrait .text ROM[$37D772:$37DC2E]
        g4bppcMagePortrait .text ROM[$37DC2E:$37E053]
        g4bppcPriestessPortrait .text ROM[$37E053:$37E47D]
        g4bppcBallisticianPortrait .text ROM[$37E47D:$37E801]
        g4bppcThiefPortrait .text ROM[$37E801:$37EBDE]
        g4bppcHighPriestPortrait .text ROM[$37EBDE:$37EF61]
        g4bppcDancerPortrait .text ROM[$37EF61:$37F388]

      endPortraits

    .endsection

.endif ; GUARD_FE5_PORTRAITS
