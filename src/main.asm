;
; Kombi-nacja - main part sourcecode
; by Raf/Vulture Design
;

;*= $0400
;.incprg "..\gfx\knation-0400.PRG"
*= $0800
.incprg "..\gfx\knation-d800.prg"
*= $2000
.incprg "..\gfx\knation-2000.prg"


.include "macros.asm"
.include "globallabels.asm"

.include "start.asm"
;.include "kbd.asm"
;.include "minikey.asm"
.include "systemsetup.asm"
.include "showpic.asm"
.include "packedlen.asm"
.include "computeloadaddr.asm"
.include "kbdirq.asm"

*= $8000	
.incprg "..\dload\user_cfg\dload.prg" 

exom ALIGN 255,0
.include "exomizer.asm"

*= $c000 + 14 * 40

;     "                    "
songpos 
.scru "slodkiego milego zyc"
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "
.scru "01) a song          "

*= $c800
.incprg "..\gfx\Font.prg", $c800

*= $e000
.incbin "..\gfx\kombilogo.bin"

