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

  test "solve part 1" do
    assert Day6.solve1 == 1760
  end
end
