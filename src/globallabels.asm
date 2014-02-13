debug = 0 
;skiptimer = 0 ; 0 for release buid , 1 for no wait in timer procedure

DreamLoad = $8000
;;;;;;;;;;;;;;;;;;;;;
; dload stuff


; TODO sprawdzaj z dload.cfg czy to ejst spojne!
iloader = $0500 ;$9000

loadfile = iloader
loadts = iloader+3
shutup = iloader+6
wakeup = iloader+9
ledoff = iloader+12
speederoff = iloader+15

OPWaitingForAction = 0
OPLoadTune = 1

NUMBER_OF_TUNES = 11 -1

