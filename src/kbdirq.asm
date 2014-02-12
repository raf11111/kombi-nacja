checkkbd: 
;fe ins/del
;fd return
;fb <>
;f7 f7
;ef f1
;df f3
;bf f5
;7f up/dn

		lda #$0
		sta $dc03	; port b ddr (input)
		lda #$ff
		sta $dc02	; port a ddr (output)
				
		;lda #$00
		lda #$fe
		sta $dc00	; port a
		lda $dc01       ; port b
		cmp lastkey
		beq ckeckkbdexit
		sta lastkey
		cmp #$ff
		beq ckeckkbdexit

		sta $c000+24*40
		jsr checkKeys
		
ckeckkbdexit
		lda tuneToLoad
		sta $c001+24*40
		rts

checkKeys:		
__f1    cmp #$fb
		bne __f3
		ldx tuneToLoad
		beq *+3
		dec tuneToLoad
		rts
		
__f3	cmp #$7f
		bne __f5
		ldx tuneToLoad
		cpx #NUMBER_OF_TUNES
		bpl *+3
		inc tuneToLoad
		rts
		
__f5	cmp #$fd
		bne exitkbd
		lda #OPLoadTune
		sta OPFLAG
exitkbd
		rts
		
lastkey byte 0		