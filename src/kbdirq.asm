checkkbd:
		jsr keyscan
		lda $11 ;actkey
		cmp #$ff	;$ff= no key pressed
		beq ckeckkbdexit

		cmp #$40	;convert to screen codes
		bmi checkkbd2
		sec
		sbc #$40

		cmp #$1A ; 'z' key
		bne checkkbd2

		cmp #'Z
		
		lda #OPLoadTune
		sta OPFLAG
		
checkkbd2:
		sta $0400
ckeckkbdexit