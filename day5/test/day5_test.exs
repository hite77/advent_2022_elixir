defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "separate out crates and moves" do
    input = ["    [D]", "[N] [C]", "[Z] [M] [P]", " 1   2   3", "", "move 1 from 2 to 1", "move 3 from 1 to 3", "move 2 from 2 to 1", "move 1 from 1 to 2", ""]
    [moves, crates] = Enum.reduce(input, [], fn (item, output) -> Day5.separate(item, output) end)
    assert crates == ["[Z] [M] [P]", "[N] [C]", "    [D]"]
    assert moves ==  ["move 1 from 1 to 2", "move 2 from 2 to 1", "move 3 from 1 to 3", "move 1 from 2 to 1"]
  end

  test "converting from strings to map of crates" do
   assert Day5.convertCrates("    [D]", 1, %{}) == %{2 => ["[D]"]}
   assert Day5.convertCrates("[N] [C]", 1, %{2 => ["[D]"]}) == %{
        1 => ["[N]"],
        2 => ["[C]", "[D]"]
      }
    assert Day5.convertCrates("[Z] [M] [P]", 1, %{1 => ["[N]"], 2 => ["[C]", "[D]"]}) == %{
        1 => ["[Z]", "[N]"],
        2 => ["[M]", "[C]", "[D]"],
        3 => ["[P]"]}
  end

  test "can convert moves to tuples" do
    assert Day5.convertMove("move 1 from 2 to 1") == {1, 2, 1}
    assert Day5.convertMove("move 3 from 1 to 3") == {3, 1, 3}
  end

  test "perform moves will move the pieces" do
    crates = %{
      1 => ["[N]","[Z]"],
      2 => ["[D]","[C]","[M]"],
      3 => ["[P]"]
    }

    afterFirstMove = %{
      1 => ["[D]","[N]","[Z]"],
      2 => ["[C]","[M]"],
      3 => ["[P]"]
    }

    afterSecondMove = %{
      1 => [],
      2 => ["[C]","[M]"],
      3 => ["[Z]","[N]","[D]","[P]"]
    }

    afterThirdMove = %{
      1 => ["[M]", "[C]"],
      2 => [],
      3 => ["[Z]","[N]","[D]","[P]"]
    }

    afterFourthMove = %{
      1 => ["[C]"],
      2 => ["[M]"],
      3 => ["[Z]","[N]","[D]","[P]"]
    }

    assert Day5.performMove({1, 2, 1}, crates) == afterFirstMove
    assert Day5.performMove({3, 1, 3}, afterFirstMove) == afterSecondMove
    assert Day5.performMove({2, 2, 1}, afterSecondMove) == afterThirdMove
    assert Day5.performMove({1, 1, 2}, afterThirdMove) == afterFourthMove
  end

  test "Gets top crate" do
    assert Day5.topCrate({1, ["[C]"]}) == "C"
    assert Day5.topCrate({1, ["[M]"]}) == "M"
    assert Day5.topCrate({1, ["[Z]","[N]","[D]","[P]"]}) == "Z"
  end

  test "part1 test" do
    input = """
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"""
    assert Day5.part1(input) == "CMZ"
  end

  test "solve1 using my input" do
    assert Day5.solve1 == "TDCHVHJTG"
  end
end
