# Day13

**Part 1**

- comparing list pairs
- if both values are integers, the lower integer should come first.  If the left integer is lower than the right,  the inputs are in the right order.  If the left integer is higher than the right integer, the inputs are not in the right order.  Otherwise the inputs are the same integer, continue checking
- if both values are lists, compare the first value of each list, then the second value.  If the left list runs out of items first the inputs are in the right order.  if the right list runs out of items first the inputs are not in the right order.  if the lists are the same length, and no comparison makes a decision about the order, continue checking the next part
- if exactly one value is an integer, conver the integer to a list which contains the integer then retry. if comparing [0,0,0] and 2, convert the right value to [2] then compare [0,0,0] and [2]

ignore parens?
1,1,3,1,1 vs 1,1,5,1,1
lower 3 right order

1,2,3,4 vs 1,4
lower 2 right order

9 vs 8,7,6
Right side smaler not right order

4,4,4,4 4,4,4,4,4
Left ran out of items so inputs are in the right order

7,7,7,7 7,7,7
right side ran out of items so not right order

[] vs [3]
left ran out of items so inputs right

[[[]]] vs [[]]
compare [[]] []
right side ran out of items, inputs not in the right order

- if considering [] this next one might be enlightening
- Compare [1,[2,[3,[4,[5,6,7]]]],8,9] vs [1,[2,[3,[4,[5,6,0]]]],8,9]
- Compare 1 vs 1
- compare 2,[3,[4,[5,6,7]]]] vs [2,[3,[4,[5,6,0]]]]
- compare 2 vs 2
- compare [3,[4,[5,6,7]]] vs [3,[4,[5,6,0]]]
- compare 3 vs 3
- compare 4,[5,6,7]] vs [4,[5,6,0]]
- compare 4 vs 4
- compare [5,6,7] vs [5,6,0]
- compare 5 vs 5
- compare 6 vs 6
- compare 7 vs 0
right side smaller inputs not in right order

needs to have numbers and nesting levels....
recursive call with what is in []
parse pairs "[1,[2,[3,[4,[5,6,7]]]],8,9]" vs [1,[2,[3,[4,[5,6,0]]]],8,9]
first character is [ call compare with head inside and tail passed
1,..... vs 1,..... --> number, and then comma

first vs second
[1, [2, [3, [4, [5,6,7]]]],8,9] vs [1,[2,[3,[4,[5,6,0]]]],8,9]

parse from text into array....
