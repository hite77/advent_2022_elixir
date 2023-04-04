defmodule Day15Test do
  use ExUnit.Case
  doctest Day15

  setup_all do
    contents = """
    Sensor at x=2, y=18: closest beacon is at x=-2, y=15
    Sensor at x=9, y=16: closest beacon is at x=10, y=16
    Sensor at x=13, y=2: closest beacon is at x=15, y=3
    Sensor at x=12, y=14: closest beacon is at x=10, y=16
    Sensor at x=10, y=20: closest beacon is at x=10, y=16
    Sensor at x=14, y=17: closest beacon is at x=10, y=16
    Sensor at x=8, y=7: closest beacon is at x=2, y=10
    Sensor at x=2, y=0: closest beacon is at x=2, y=10
    Sensor at x=0, y=11: closest beacon is at x=2, y=10
    Sensor at x=20, y=14: closest beacon is at x=25, y=17
    Sensor at x=17, y=20: closest beacon is at x=21, y=22
    Sensor at x=16, y=7: closest beacon is at x=15, y=3
    Sensor at x=14, y=3: closest beacon is at x=15, y=3
    Sensor at x=20, y=1: closest beacon is at x=15, y=3
    """
    {:ok, contents: contents}
  end

  test "parseLine", state do
    assert Day15.parseline(state[:contents] |> String.split("\n", trim: true) |> hd) == [[2,18],[-2,15]]
  end

  test "parse", state do
    assert Day15.parse(state[:contents]) == [[[2, 18], [-2, 15]],
                                             [[9, 16], [10, 16]],
                                             [[13, 2], [15, 3]],
                                             [[12, 14], [10, 16]],
                                             [[10, 20], [10, 16]],
                                             [[14, 17], [10, 16]],
                                             [[8, 7], [2, 10]],
                                             [[2, 0], [2, 10]],
                                             [[0, 11], [2, 10]],
                                             [[20, 14], [25, 17]],
                                             [[17, 20], [21, 22]],
                                             [[16, 7], [15, 3]],
                                             [[14, 3], [15, 3]],
                                             [[20, 1], [15, 3]]]
  end
end
