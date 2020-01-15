
structItemDataEntryRAM .struct
  Type            .byte ? ; $00
  Might           .byte ? ; $01
  Accuracy        .byte ? ; $02
  Weight          .byte ? ; $03
  Durability      .byte ? ; $04
  Critrate        .byte ? ; $05
  Range           .byte ? ; $06
  WeaponRank      .word ? ; $07
  Effectiveness   .word ? ; $09
  StatBonus       .word ? ; $0B
  Cost            .word ? ; $0D
  Description     .word ? ; $0F
  UseEffect       .byte ? ; $11
  WeaponEffect    .byte ? ; $12
  Skills2         .byte ? ; $13
  Skills3         .byte ? ; $14
  Traits          .byte ? ; $15
  Icon            .byte ? ; $16
  DisplayedWeapon .byte ? ; $17
  BaseWeapon      .byte ? ; $18
.ends

structItemDataEntry .struct Type, AlternateType, Might, Accuracy, Weight, Durability, Critrate, MinRange, MaxRange, WeaponRank, Effectiveness, StatBonus, Cost, Description, UseEffect, WeaponEffect, Skills2, Skills3, Traits, Icon
  Type          .byte (\AlternateType << 4) | \Type ; $00
  Might         .char \Might           ; $01
  Accuracy      .byte \Accuracy        ; $02
  Weight        .byte \Weight          ; $03
  Durability    .char \Durability      ; $04
  Critrate      .byte \Critrate        ; $05
  Range         .byte (\MaxRange << 4) | (\MinRange) ; $06
  WeaponRank    .word <>\WeaponRank    ; $07
  Effectiveness .word <>\Effectiveness ; $09
  StatBonus     .word <>\StatBonus     ; $0B
  Cost ; $0D
  .if \Cost != 0
    .if \Durability != -1
      .word (\Cost - 200) / (\Durability)
    .else
      .word (\Cost - 200)
    .endif
  .else
    .word 0
  .endif
  Description  .word <>\Description ; $0F
  UseEffect    .byte \UseEffect     ; $11
  WeaponEffect .byte \WeaponEffect  ; $12
  Skills2      .byte \Skills2       ; $13
  Skills3      .byte \Skills3       ; $14
  Traits       .byte \Traits        ; $15
  Icon         .byte \Icon          ; $16
.ends

structItemStatBonuses .struct Strength=?, Magic=?, Skill=?, Speed=?, Defense=?, Constitution=?, Luck=?, Movement=?
  Strength     .byte \Strength     ; $00
  Magic        .byte \Magic        ; $01
  Skill        .byte \Skill        ; $02
  Speed        .byte \Speed        ; $03
  Defense      .byte \Defense      ; $04
  Constitution .byte \Constitution ; $05
  Luck         .byte \Luck         ; $06
  Movement     .byte \Movement     ; $07
.ends
