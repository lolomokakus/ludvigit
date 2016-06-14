// A program I wrote for my Casio fx-9750GII calculator
// Symbol definitions:
//    →: Arrow, used for variable definitions. Press the → button below the D-pad to enter.
//    ⇢: Thick arrow, used for comparisons. Press SHIFT, VARS, F3, F3 to enter.

0→C // Cycle counter, starts at zero
250→D~E // How many cycles before screen cleanup?
RanInt#(1,21)→X // Select a random coordinate on the screen to begin with
RanInt#(1,6)→Y
Lbl 0 // Loop start
C+1→C // Increment cycle counter
RanInt#(0,2)→A // Decide whether to move and in what direction
RanInt#(0,2)→B
A=1⇢X+1→X // Move one step to the right
A=2⇢X-1→X // Move one step to the left
B=1⇢Y+1→Y // Move one step down
B=2⇢Y-1→Y // Move one step up
// Casio made the odd decision of making the upper left corner origo, essentially
// inverting the Y axis. Thanks for that, mates!
X<1⇢1→X // Make sure the we don't move outside screen boundaries
X>21⇢21→X
Y<1⇢1→Y
Y>6⇢6→Y
Locate 1,7,C // Print cycle counter in the lower left corner of the screen
If X≥10 // Make sure displayed coordinates don't overlap
Then Locate 16,7,X // Display X coordinate next to Y coordinate
Else Locate 17,7,X
IfEnd
Locate 20,7,Y // Display Y coordinate in the lower right corner of the screen
A=0⇢Locate 18,7,"±" // Display indicators next to the coordinates to show
A=1⇢Locate 18,7,"+" // what direction we moved in
A=2⇢Locate 18,7,"-"
B=0⇢Locate 21,7,"±"
B=1⇢Locate 21,7,"+"
B=2⇢Locate 21,7,"-"
Locate X,Y,"@" // Display the cute little @ symbol
0→Z // Pause program for a short while
While Z<45
Z+1→Z
WhileEnd
Locate X,Y,"•" // Overwrite @ symbol with • to indicate where it has been previously
Locate 1,7,"                     " // Blank out the lower part of the screen
If C=D // Clean up the screen if we've reached the amount of cycles specified in D
Then D+E→D // Determine next cleanup cycle
ClrText // Clear screen
IfEnd
Goto 0 // Loop end
