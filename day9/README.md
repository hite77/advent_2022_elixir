# Day9

## Part 1

-rope is short (H) and (T) must always be touching
-diagnonally adjacent, or overlapping
```
...
.TH.
....

....
.H..
..T.
....

...
.H. (H covers T)
...
```

- if the head is ever two steps directly up, down, left, or right from the tail, the tail must also move one step in that direction so it remains close enough.
```
.....    .....    .....
.TH.. -> .T.H. -> ..TH.
.....    .....    .....

...    ...    ...
.T.    .T.    ...
.H. -> ... -> .T.
...    .H.    .H.
...    ...    ...
```
-otherwise, if the head and tail aren’t touching and aren’t in the same row or column, the tail always moves one step diagonally to keep up:

```
.....    .....    .....
.....    ..H..    ..H..
..H.. -> ..... -> ..T..
.T...    .T...    .....
.....    .....    .....

.....    .....    .....
.....    .....    .....
..H.. -> ...H. -> ..TH.
.T...    .T...    .....
.....    .....    .....
```

- at start they are overlapped
- then head follows a series of moves
```
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
```
- so this represents
1 head right 4
2 then up 4
3 then left 3
4 then down 1
5 right 4
6 down 1
7 left 5
8 right 2

- move H with Tail following
- count up the positions the tail took up for this it is 13

**steps**
— parse arguments into move list
— track current position of H and T
— as H moves — find out if T moves (move one step at a time)
— T will need to update and add position
— as T moves add unique positions to list (no duplicates). map? “1,1” => count of visits may need counts for part 2, or don’t throw away.
— for part 1 count up resultant maps keys.

scratchpad


## Part 2

-longer ropes
-rather than 2 knots (HT) now there needs to be:
-(H covers 1, 2, 3, 4, 5, 6, 7, 8, 9, s)
-H, 1-9 are moving using the same rules
-track where 9 moves

- for the:

```
assert Day9.part2([“R 4","U 4","L 3","D 1","R 4","D 1","L 5","R 2"]) == 1
```
- the other pieces are detailed and should be able to integration test it.
- also:
```
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
```
- is detailed at steps, and answer is: tail (9) visits 36 positions

**thoughts**

- store locations of H (already done)
- refactor code so that movement of head happens separately for part 1 and part 2….
- then calculate movement of T for part 1
- then calculate movement of 1 for part 2
- continue for 2 based on 1
- continue for …9 based on 8
- Perform integration
