# Day9

**Part 1**

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
