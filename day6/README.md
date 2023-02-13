# Day6

## Part 1

- Look got 4 characters that are all different for start
- example
- mjqjpqmgbljsphdztnvjfqwrcgsmlb
- should output 7 because jpqm


-    bvwbjplbgvbhsrlpgdmjqwftvncz: first marker after character 5
-    nppdvjthqldpwncqszvftbrmjlhg: first marker after character 6
-    nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg: first marker after character 10
-    zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw: first marker after character 11

## Part 2

- look for 14 unique....
- character_counts = string |> String.graphemes
           |> Enum.reduce([], fn(letter, acc) -> Keyword.update(acc, String.to_atom(letter), 1, &(&1 + 1)) end)

was found and produces....
[a: 2, b: 1, c: 1, d: 1]
for "abcda"

But used something else....
string
      |> String.graphemes
      |> Enum.sort()
      |> Enum.chunk_by(fn arg -> arg end)
for the same "abcda" it produces... [["a", "a"], ["b"], ["c"], ["d"]]

