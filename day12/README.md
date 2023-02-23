# Day12 - Hill climbing

**Part one**

- a is lowest, z is highest
- S current position (elevation a)
- E best signal (elevation z)
- as few steps as possible
- you can only move one step at a time (up, down, left or right)
- your destination can only be one higher
- it can be lower by as much as possible

```
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi

v..v<<<<
>v.vv<<^
.>vv>E^^
..v>>>^^
..>>>>>^
```
- the one above finishes after 31 steps
- find fewest steps

**thoughts**

- map of rows, and lists of each
- find coordinates of S as start at a level
- possibly four ways to go....
- place start into map of routes
- loop over map of routes try to add another point

- start
```
routes = %{0 => [[0,0]]} # coordinate of start
visited = [[0,0]]
```

- S has been visited, other points have also been visited.
- if direction is E return count of steps
- if direction is a cell (not outside, not -1, -1) and not visited, and valid (within one up, same or down) add to routes and to visited
- if none can be added (change to -1,-1)

