# Day8

**Part 1**

tree height

```
30373
25512
65332
33549
35390
```
0 shortest
9 tallest

* tree visible if all of the other trees between it and an edge of the grid are shorter
* only consider trees in the same row or column (only look up, down, left, or right)
* All trees around the edge are visible
* Only consider the interior trees
* The top-left 5 is visible from the left and top. (It isn't visible from the right or bottom since other trees of height 5 are in the way.)
* The top-middle 5 is visible from the top and right.
* The top-right 1 is not visible from any direction; for it to be visible, there would need to only be trees of height 0 between it and an edge.
* The left-middle 5 is visible, but only from the right.
* The center 3 is not visible from any direction; for it to be visible, there would need to be only trees of at most height 2 between it and an edge.
* The right-middle 3 is visible from the right.
* In the bottom row, the middle 5 is visible, but the 3 and 4 are not.
With 16 trees visible on the edge and another 5 visible in the interior, a total of 21 trees are visible in this arrangement.

Consider you map; how many trees are visible from outside the grid?

thoughts:

- map = %{[x,y] => 3}
- key works?
- index top left cornerr [0,0] -- [width -1]
- go from x[array] = 1..width-1 y[array] = 1..height-1
- add outer trees (try on several grids)
- put together coordinate list
- reduce outerCount --> keep going to each edge....
- each step should keep going left [0..pos-1?] all less?
- each step should keep going right [pos|pos+1?..width|width-1] all less
- go up [0..pos|pos-1?] all less
- go down [pos|pos+1?..height|height-1] all less
- if any are all less then visible, but go all directions
- should it be zero positioned?

**todos**

- done: key of [x,y] works?: yes
- done: spike call with all coords….inside start at 1, 0 is outside and -2 to be zero based and inside.
- done: start coding in visitTrees
- done: spike call with leftVisible range, right, up, down should go from 0..pos-1 pos+1..width-1
- done: reduce with left/right/up/down working build on previous
- done: split \n, split on all characters create map with all trees should return map, and width, and height
- done: add up border of any grid edge visible.

**Part 2**

viewing distance

```
30373
25512
65332
33549
35390
```
0 shortest
9 tallest

- want to view many trees.
- look all four directions and stop if you reach an edge, or at first tree that is the same height or taller.
- trees on edge at least one viewing distance will be zero
- so 1 up
- so 1 left tree is = or greater right next
- 2 to the right
- down can see 2 one lower, and one equal

- then multiple 1 * 1 * 2 * 2  = 4 at [3,2] which is the 5 middle second row
- for 5 in the middle of fourth row at [3,4]
- up 2, left 2, down 1, right 2 (next to it lower, second bigger) = 2 * 2 * 1 * 2 == 8

**return highest scenic score**