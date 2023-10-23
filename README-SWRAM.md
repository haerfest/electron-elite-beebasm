# README SWRAM

## Introduction

I had two goals in mind with this adaptation of Elite for the Acorn Electron to
SWRAM:

1. **Speed**. Speed the game up, since the 6502 CPU in the Electron can access
   SWRAM at 2 MHz rather than the 1 MHz it clocks down to when accessing the
   main RAM.

2. **Disk loading/saving**. Support loading and saving Commanders from/to disk.
   Electron Elite is originally a tape game and though it can be loaded from
   disk, it still switches to *TAPE when started, making loading and saving
   inconvenient in modern times.  Supporting loading and saving from/to disk
   was desired.

Both goals were achieved.

## Changes Made

I had to make a couple of changes:

1. Interrupts are cleared by writing to SHEILA &Fx05.  That register is also
   used to page BASIC, the keyboard, and sideways RAM/ROM in.  Electron OS
   1.00 clears interrupts by writing a value &x0 to this register, and expects
   the lower four bits (all zero) *not* to result in paging bank #0 in.
   Various emulators I tested with did not implement this correctly, nor did
   some later-developed expansion hardware for the real machine.  I had to
   implement a workaround so that the game would work in such environments as
   well.

2. I moved most workspaces to SWRAM, but left the zero-page workspace alone.
   It is accessed using shorter, faster instructions and moving them to SWRAM
   would require them to use absolute addressing modes, cancelling out any
   benefits achieved by the fast access speed.

3. The K% and WP workspaces must be kept in successive order, as when a new
   ship is created the distance between them is used to gauge whether there
   is sufficient space available.  Failing to honour this results in the game
   entering an endless loop when your ship is destroyed, as it tries in vain
   to create up to four cargo cannisters but never succeeds in doing so.

4. The ZERO routine is used to reset the contents of K% and WP.  Failing to
   adapt this routine to refer to the new locations of both workspaces results
   in the game thinking your ship crashes into the planet as soon as you leave
   the space station at Lave.  After starting a new game you will then see a
   spinning cargo cannister on the title screen.

5. I started by moving all code to SWRAM and only moved individual routines back
   to main RAM when the assembler complained it would not fit.  I moved routines
   that had to do with non-performance critical tasks such as buying and selling
   goods, or consulting the galaxy charts.

6. With most code in SWRAM, there was no longer a need to relocate the main
   ELITECO code down from its loading address &2000 to &D00, so I left it
   alone.  This freed up work areas for DFS and MMFS so saving Commanders to
   disk now works.  I had to remove an OSBYTE call that enabled *TAPE.

7. Upon an OSFILE loading or saving error, the BRK handler would be called with
   the BASIC ROM paged back in.  I had made the main source agnostic of which
   SWRAM bank it was paged in, but now I had to make it aware of that so it
   could restore order.  With the smallest workspace S% now at &2000 rather than
   &D00, the RTI opcode was no longer necessary and I used that location for the
   loader to write the SWRAM bank to use to.

8. I added a little BASIC program called ELITESW that is loaded from *BOOT.  It
    asks the user which SWRAM bank to use, and stores that in &87 from which the
    loader picks it up.  The loader then loads the main game in SWRAM and main
    RAM, and stores this value at S% (&2000) so the main game can use it (see
    previous point).
    
9. Since loading and saving from/to an SD card is fast en quiet, I added a
   little confirmation beep to indicate success.

10. The code that is loaded into SWRAM is in a file called ELITECP.  The only
    reason for this is that initially, with no code moved yet, I had no space in
    the loader to add a second *LOAD specification.  I changed the existing one
    for ELITECO to ELITECP, loaded that file, then DEC'd the P into an O, so the
    next call would load ELITECO as before.  I left that in.


