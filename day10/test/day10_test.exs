defmodule Day10Test do
  use ExUnit.Case
  doctest Day10

  test "timeline tests" do
    map = Day10.timeline(["noop", "addx 3", "addx -5", "noop"])
    assert map[1] == 1
    assert map[2] == 1
    assert map[3] == 1
    assert map[4] == 4
    assert map[5] == 4
    assert map[6] == -1
  end

  test "trying to find problem" do
    assert Day10.timeline("addx 15", [%{}, 0, 1]) == [%{0 => 1, 1 => 1}, 2, 16]
  end

  test "longer sample test" do
    {:ok, contents} = File.read("sample1.txt")
    map = Day10.timeline(String.split(contents, "\n", trim: true))
    assert map[20] == 21
    assert map[60] == 19
    assert map[100] == 18
    assert map[140] == 21
    assert map[180] == 16
    assert map[220] == 18
  end

  test "solve" do
    assert Day10.solve1 == 14820
  end
end
