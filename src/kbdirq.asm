SUBROUTINE checkKbdIRQ

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

		sta $c000+13*40
		jsr checkKeys
		
ckeckkbdexit
		lda tuneToLoad
		sta $c001+13*40
		rts

checkKeys:	
;left-right
__f1    cmp #$fb
		bne __f3
		ldx tuneToLoad
		beq __f3
		dec tuneToLoad
		inc $d020
		jsr moveScreenUp
		
		lda #<($c000 + 24*40)
		sta .dstLn + 1
		lda #>($c000 + 24*40)
		sta .dstLn + 2
		jsr printNewSong
				
		dec $d020
		rts

;up-dn
__f3	cmp #$7f
		bne __f5
		ldx tuneToLoad
		cpx #NUMBER_OF_TUNES
		bpl __f5
		inc tuneToLoad
		inc $d020
		jsr moveScreenDown

		lda #<($c000 + 16*40)
		sta .dstLn + 1
		lda #>($c000 + 16*40)
		sta .dstLn + 2
		jsr printNewSong

		dec $d020
		rts
		
__f5	cmp #$fd
		bne exitkbd
		lda #OPLoadTune
		sta OPFLAG
exitkbd
		rts
		
lastkey byte 0		

printNewSong:
		jsr mul40
		
		lda mul40hi
		clc
		adc #>menuItems
		sta .srcChr + 2
		
		lda mul40lo
		clc
		adc #<menuItems
		sta .srcChr + 1
		
		ldy #39
.srcChr	lda $0000,y
.dstLn	sta $0000,y
		dey
		bpl .srcChr

		rts
