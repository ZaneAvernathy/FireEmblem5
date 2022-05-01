
.weak
  WARNINGS :?= "None"
.endweak

GUARD_FE5_DMA :?= false
.if (!GUARD_FE5_DMA)
  GUARD_FE5_DMA := true

  ; Freespace inclusions

    .section UnknownDMASection

      startCode

        rlUnknownDMA ; 80/842C

          .autsiz
          .databank ?

          ; DMAs data using a series of structs after
          ; the jsl to this routine.

          ; Data has the format:
          ; Byte channels to use
          ; 7 bytes per channel, format is
          ; ports $0043x0-$0043x7 in order.

          ; Inputs:
          ; Data immediately following jsl

          ; Outputs:
          ; None

          php
          phb

          sep #$20

          ; Temporary stack definition

          .virtual #$01,s
            _DB             .byte ?
            _P              .byte ?
            _ReturnLocation .long ?
          .endvirtual

          lda _ReturnLocation+2
          pha

          plb

          .databank ?

          rep #$30

          lda _ReturnLocation
          tax

          ; Get channels.

          lda 1,b,x
          and #$00FF

          sta wR34
          sta wR35

          inc x

          ldy #0

          _ChannelLoop

            ; If channel is used, fill in with data.

            lsr wR34
            bcc +

              lda 1+structDMAChannel.Parameters,b,x
              sta DMA_IO[0].DMAP,b,y

              lda 1+structDMAChannel.Source,b,x
              sta DMA_IO[0].A1,b,y
              lda 1+structDMAChannel.Source+2,b,x
              sta DMA_IO[0].A1+2,b,y

              lda 1+structDMAChannel.Count,b,x
              sta DMA_IO[0].DAS,b,y

              ; Move to next data struct.

              txa
              clc
              adc #size(structDMAChannel)
              tax

            +

            ; Move to next set of DMA ports.

            tya
            clc
            adc #size(DMA_IO[0])
            tay

            ; Continue for all channels.

            cpy #size(DMA_IO) + ...
            bne _ChannelLoop

          ; Overwrite return address to jump
          ; over data.

          txa
          sta _ReturnLocation

          sep #$20

          ; Begin transfers.

          lda wR35
          sta MDMAEN,b

          plb
          plp
          rtl

          .databank 0

      endCode

    .endsection UnknownDMASection

.endif ; GUARD_FE5_DMA
