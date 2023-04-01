defmodule Day14Test do
  use ExUnit.Case
  doctest Day14

  setup_all do
    contents = """
    498,4 -> 498,6 -> 496,6
    503,4 -> 502,4 -> 502,9 -> 494,9
    """
    {:ok, contents: contents}
  end

  test "parse coordinates of rock", state do
    coords = Day14.parseCoordinatesOfRock(state[:contents])
    assert coords == [[[498,4],[498,6],[496,6]],[[503,4],[502,4],[502,9],[494,9]]]
  end

  test "rock map and max depth" do
    [map, maxDepth] = Day14.rockMap([[[498,4],[498,6],[496,6]],[[503,4],[502,4],[502,9],[494,9]]])
    assert maxDepth == 9
    assert map == %{494 => %{9 => "#"},
                    495 => %{9 => "#"},
                    496 => %{6 => "#", 9 => "#"},
                    497 => %{6 => "#", 9 => "#"},
                    498 => %{4 => "#", 5 => "#", 6 => "#", 9 => "#"},
                    499 => %{9 => "#"},
                    500 => %{9 => "#"},
                    501 => %{9 => "#"},
                    502 => %{4 => "#", 5 => "#", 6 => "#", 7 => "#", 8 => "#", 9 => "#"},
                    503 => %{4 => "#"}}
  end

  test "parts", state do
    assert Day14.part(state[:contents],:part1) == 24
    assert Day14.part(state[:contents],:part2) == 93
  end

  test "solve" do
    assert Day14.solve1 == 1406
    assert Day14.solve2 == 20870
  end
end
