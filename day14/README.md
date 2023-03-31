# Day14

Day 14

lines of rock
498,4 -> 498, 6 -> 496,6                       two lines same right(x), y changing down, and horizontal left
503,4 -> 502, 4 -> 502,9 -> 494,9.      three lines (left, down, left)

sand is pouring from 500,0

sand falls 1 at a time
if next step contains sand, it tries to go diagonal.  one down and to left.
it tries to go down, then down left, then down right.
if it can’t move further it is at rest.

then next sand is generated
sample has first sand position, second, and then five in

should return how many pieces of sand before it falls forever (24)

test for sand past lowest rock if so we have the sand. 

Need parsing, and map to store rock as # and o as sand.
