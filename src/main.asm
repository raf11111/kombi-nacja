;
; Kombi-nacja - main part sourcecode
; by Raf/Vulture Design
;

;*= $0400
;.incprg "..\gfx\knation-0400.PRG"
;*= $0800
;.incprg "..\gfx\knation-d800.prg"
;*= $2000
;.incprg "..\gfx\knation-2000.prg"


.include "macros.asm"
.include "globallabels.asm"

.include "start.asm"
.include "systemsetup.asm"
.include "showpic.asm"
.include "packedlen.asm"
.include "computeloadaddr.asm"
.include "kbdirq.asm"

*= $8000	
.incprg "..\dload\user_cfg\dload.prg" 

exom ALIGN 255,0
.include "exomizer.asm"

.include "menuitems.asm"

*= $c000
;; checkerboard
;	REPEAT 7 ;14*40 / 2
;		REPEAT 20
;			BYTE $21, $12
;		REPEND
;		REPEAT 20
;			BYTE $12, $21
;		REPEND
;	REPEND

	REPEAT 14*40
		byte $20
	REPEND

;.scru "1*                                      "
;.scru "2*                                      "
;.scru "3*                                      "
;.scru "4*                                      "
;.scru "5*                                      "
;.scru "1                                       "
;.scru "2                                       "
;.scru "3                                       "
;.scru "4                                       "

;repeat 200
;		byte 1,2,3
;repend
	
	
*= $c800
.incprg "..\gfx\Font.prg", $c800

*= $e000
.incbin "..\gfx\kombilogo.bin"

