defmodule Day11Test do
  use ExUnit.Case
  doctest Day11

  setup_all do
    contents = """
  Monkey 0:
    Starting items: 79, 98
    Operation: new = old * 19
    Test: divisible by 23
      If true: throw to monkey 2
      If false: throw to monkey 3

  Monkey 1:
    Starting items: 54, 65, 75, 74
    Operation: new = old + 6
    Test: divisible by 19
      If true: throw to monkey 2
      If false: throw to monkey 0

  Monkey 2:
    Starting items: 79, 60, 97
    Operation: new = old * old
    Test: divisible by 13
      If true: throw to monkey 1
      If false: throw to monkey 3

  Monkey 3:
    Starting items: 74
    Operation: new = old + 3
    Test: divisible by 17
      If true: throw to monkey 0
      If false: throw to monkey 1

"""
    {:ok, part1: contents}
  end

  test "parsing", state do
    assert Day11.parse(state[:part1]) == [%{
      0 => [{[79,98], "times", 19, 23, 2, 3}, 0],
      1 => [{[54,65,75,74], "plus", 6, 19, 2, 0}, 0],
      2 => [{[79,60,97], "times", "self", 13, 1, 3}, 0],
      3 => [{[74], "plus", 3, 17, 0, 1}, 0]
    }, [17, 13, 19, 23]]
  end

  test "turn for monkey" do
    assert Day11.monkeyTurn([0], %{
      0 => [{[79,69], "times", 19, 23, 2, 3}, 0],
      2 => [{[13], "plus", 6, 19, 2, 0}, 0],
      3 => [{[23,34], "times", "self", 13, 1, 3}, 0]
      }, 3, []) == %{
            0 => [{[], "times", 19, 23, 2, 3}, 2],
            2 => [{[437,13], "plus", 6, 19, 2, 0}, 0],
            3 => [{[500,23,34], "times", "self", 13, 1, 3}, 0]
      }
  end

  test "parts", state do
    assert Day11.part1(state[:part1]) == 10605
    assert Day11.part2(state[:part1]) == 2713310158
  end

  test "solutions" do
    assert Day11.solve1 == 69918
    assert Day11.solve2 == 19573408701
  end
end
