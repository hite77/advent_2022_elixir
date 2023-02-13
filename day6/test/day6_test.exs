defmodule Day6Test do
  use ExUnit.Case
  doctest Day6

  test "finds location of non repeat of four characters" do
    assert Day6.findPositionOfFirstUniqueFourCharacters("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 4) == 7
    assert Day6.findPositionOfFirstUniqueFourCharacters("bvwbjplbgvbhsrlpgdmjqwftvncz", 4) == 5
    assert Day6.findPositionOfFirstUniqueFourCharacters("nppdvjthqldpwncqszvftbrmjlhg", 4) == 6
    assert Day6.findPositionOfFirstUniqueFourCharacters("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 4) == 10
    assert Day6.findPositionOfFirstUniqueFourCharacters("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 4) == 11
  end

  test "same for 14 unique" do
    assert Day6.findPositionOfFirstUnique14Characters("bvwbjplbgvbhsrlpgdmjqwftvncz", 14) == 23
    assert Day6.findPositionOfFirstUnique14Characters("nppdvjthqldpwncqszvftbrmjlhg", 14) == 23
    assert Day6.findPositionOfFirstUnique14Characters("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 14) == 29
    assert Day6.findPositionOfFirstUnique14Characters("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 14) == 26
  end

  test "solutions" do
    assert Day6.solve1 == 1760
    assert Day6.solve2 == 2974
  end
end
