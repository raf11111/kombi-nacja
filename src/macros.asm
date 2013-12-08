
; music depack and run macro

MAC wywolaj
	cmp #{1}
	bne .next
	lda #0
	sta 54272+24
	sei
	lda #{2}
	sta opbase + 1
	lda #{3}
	sta opbase + 2
	
	jsr exod_decrunch
	jsr $1000
	lda #$ff
	sta $11 ; actkey
	cli
.next:	
ENDM

MAC enterIRQ
		pha        ;store register A in stack
		txa
		pha        ;store register X in stack
		tya
		pha        ;store register Y in stack
ENDM

MAC exitIRQ
pla
		tay        ;restore register Y from stack (remember stack is FIFO: First In First Out)
		pla
		tax        ;restore register X from stack
		pla        ;restore register A from stack
ENDM
