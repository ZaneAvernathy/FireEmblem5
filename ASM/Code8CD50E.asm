
rlUnknown8CD50E ; 8C/D50E

	.al
	.xl
	.autsiz
	.databank ?

	rtl

rlUnknown8CD50F ; 8C/D50F

	.al
	.xl
	.autsiz
	.databank ?

	inc wUnknown000302,b
	stz wUnknown000304,b
	rtl

rlUnknown8CD516 ; 8C/D516

	.al
	.xl
	.autsiz
	.databank ?

	lda wUnknown000304,b
	cmp #$0001
	bmi +

	-
	bra -

	+
	asl a
	tax
	jsr (_aUnknown8CD526,x)
	rtl

	_aUnknown8CD526 ; 8C/D526
		.addr rsUnknown8CD528

rsUnknown8CD528 ; 8C/D528

	.al
	.xl
	.autsiz
	.databank ?

	rts

aUnknown8CD529 ; 8C/D529

	.addr rlUnknown8CD52F
	.addr rlUnknown8CD55C
	.addr rlUnknown8CD560

rlUnknown8CD52F ; 8C/D52F

	.al
	.xl
	.autsiz
	.databank ?

	php
	rep #$20
	lda #$0000
	sta wUnknown001730,b

	jsl $95800B
	jsr rsUnknown8C83D5

	lda #$0000
	sta wEventEngineCycleType,b
	sta wEventExecutionOffset,b
	sta lEventEngineEventDefinitionPointer,b
	sta lEventEngineEventDefinitionPointer+1,b
	sta wUnknown001791,b
	stz wEventEngineStatus,b

	sep #$20
	lda #TM_Setting(False, False, False, False, False)
	sta bBuf_TM
	plp
	rtl

rlUnknown8CD55C ; 8C/D55C

	.al
	.xl
	.autsiz
	.databank ?

	jsr rsDoEventEngineCycle
	rtl

rlUnknown8CD560 ; 8C/D560

	.al
	.xl
	.autsiz
	.databank ?

	rtl

