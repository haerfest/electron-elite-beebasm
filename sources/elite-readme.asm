\ ******************************************************************************
\
\ ELECTRON ELITE README
\
\ Electron Elite was written by Ian Bell and David Braben and is copyright
\ Acornsoft 1984
\
\ The code on this site has been disassembled from the version released on Ian
\ Bell's personal website at http://www.elitehomepage.org/
\
\ The commentary is copyright Mark Moxon, and any misunderstandings or mistakes
\ in the documentation are entirely my fault
\
\ The terminology and notations used in this commentary are explained at
\ https://www.bbcelite.com/about_site/terminology_used_in_this_commentary.html
\
\ The deep dive articles referred to in this commentary can be found at
\ https://www.bbcelite.com/deep_dives
\
\ ------------------------------------------------------------------------------
\
\ This source file produces the following binary file:
\
\   * output/README.txt
\
\ ******************************************************************************

INCLUDE "sources/elite-header.h.asm"

.readme

 EQUB 10, 13
 EQUS "---------------------------------------"
 EQUB 10, 13
 EQUS "Acornsoft Elite (flicker-free version)"
 EQUB 10, 13
 EQUB 10, 13
 EQUS "Version: Acorn Electron cassette"
 EQUB 10, 13
 EQUS "Release: Stairway to Hell archive"
 EQUB 10, 13
 EQUS "Code no: Acornsoft SLG38 v1.1"
 EQUB 10, 13
 EQUB 10, 13
 EQUS "Contains the flicker-free ship drawing"
 EQUB 10, 13
 EQUS "routines from the BBC Master version,"
 EQUB 10, 13
 EQUS "backported by Mark Moxon"
 EQUB 10, 13
 EQUB 10, 13
 EQUS "See www.bbcelite.com for details"
 EQUB 10, 13
 EQUS "---------------------------------------"
 EQUB 10, 13

SAVE "output/README.txt", readme, P%

