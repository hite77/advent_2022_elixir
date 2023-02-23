# Day11

**Part 2**

numbers

if I keep multiplying by number 1, number 2, etc....  if divisible can reduce down....

11 * 7 = 77?

19 * 2 * 3 * 17 * 13 * 7 * 5 * 11 do a rem on it to reduce it

Monkey 0 old * 11
  divisible by 19 -> 6 or 7
Monkey 1 old + 8
  divisible by 2-> 6, or 0
Monkey 2 old + 1
  divisible by 3 -> 5, or 3
Monkey 3 old * 7
  divisible by 17 -> 5, 4
Monkey 4 old + 4
  divisible by 13 -> 0, or 1
Monkey 5 old + 7
  divisible by 7 --> 1 or 4
Monkey 6 old * old
  divisible by 5 --> 7 or 2
Monkey 7 old + 6
  divisible by 11 -> 2 or 3