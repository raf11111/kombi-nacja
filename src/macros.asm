
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

MAC OPclearflag
		lda #$0 ; OPWaitingForAction
		sta OPFLAG
ENDM
		
MAC clearVicIRQ
		lda #$ff   ; clear IRQ
		sta $d019 
ENDM	

MAC setIRQ 
		lda #<{0}
		sta $fffe  
		lda #>{0}
		sta $ffff
ENDM	

MAC	setVicBank
	pha
	lda #{1}
	eor #3
	and $dd00
	sta $dd00
	pla
ENDM

MAC	setVicBankDLOAD
	;pha
    lda #($3f ^ {1})      ;the new substitute for setting the vic
    sta $dd02               ;bank to %xy
	;pla
ENDM

MAC incw
	lda {1}
	clc
	adc #1
	sta {1}
	bcc .a
	inc {1}+1
.a	nop
ENDM

MAC setVicScreenDisable
	lda $d011
	and #%11101111
	sta $d011
ENDM
	
MAC setVicScreenEnable
	lda $d011
	ora #%00010000
	sta $d011
ENDM

	

