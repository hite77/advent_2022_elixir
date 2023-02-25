defmodule Day12Test do
  use ExUnit.Case
  doctest Day12

  setup_all do
    contents = """
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
"""
    map = %{0 => %{0 => "S",1 => "a", 2 => "b", 3 => "q", 4 => "p", 5 => "o", 6 => "n", 7 => "m"},
            1 => %{0 => "a", 1 => "b", 2 => "c", 3 => "r", 4 => "y", 5 => "x", 6 => "x", 7 => "l"},
            2 => %{0 => "a", 1 => "c", 2 => "c", 3 => "s", 4 => "z", 5 => "E", 6 => "x", 7 => "k"},
            3 => %{0 => "a", 1 => "c", 2 => "c", 3 => "t", 4 => "u", 5 => "v", 6 => "w", 7 => "j"},
            4 => %{0 => "a", 1 => "b", 2 => "d", 3 => "e", 4 => "f", 5 => "g", 6 => "h", 7 => "i"}}
    {:ok, part1: contents, map: map}
  end

  test "parse", state do
    [start, map] = Day12.parse(state[:part1])
    assert start == [0,0]
    assert Map.keys(map) == [0,1,2,3,4]
    assert map[0] == %{0 => "S",1 => "a", 2 => "b", 3 => "q", 4 => "p", 5 => "o", 6 => "n", 7 => "m"}
    assert map[1] == %{0 => "a", 1 => "b", 2 => "c", 3 => "r", 4 => "y", 5 => "x", 6 => "x", 7 => "l"}
    assert map[2] == %{0 => "a", 1 => "c", 2 => "c", 3 => "s", 4 => "z", 5 => "E", 6 => "x", 7 => "k"}
    assert map[3] == %{0 => "a", 1 => "c", 2 => "c", 3 => "t", 4 => "u", 5 => "v", 6 => "w", 7 => "j"}
    assert map[4] == %{0 => "a", 1 => "b", 2 => "d", 3 => "e", 4 => "f", 5 => "g", 6 => "h", 7 => "i"}
  end

  test "move", state do
    assert Day12.move(state[:map], [0,0], [0,1], [5, 8]) == true #S is a
    assert Day12.move(state[:map], [1,0], [1,1], [5, 8]) == true
    assert Day12.move(state[:map], [2,1], [2,0], [5, 8]) == true
    assert Day12.move(state[:map], [0,0], [-1,0], [5, 8]) == false
    assert Day12.move(state[:map], [0,0], [0,-1], [5, 8]) == false
    assert Day12.move(state[:map], [0,7], [0,8], [5, 8]) == false
    assert Day12.move(state[:map], [4,7], [5,7], [5, 8]) == false
    assert Day12.move(state[:map], [2,4], [2,5], [5, 8]) == :solved
    assert Day12.move(state[:map], [1,5], [2,5], [5, 8]) == false #E is z
  end

  test "add moves from one to two" do
    [solved, to, moves, visited] = Day12.addMove([0,1], 1, 0, %{0 => [[0,0]]}, [[0,0]])
    assert solved == false
    assert to == 2
    assert visited == [[0,1],[0,0]]
    assert moves == %{0 => [[0,0]], 1 => [[0,1],[0,0]]}
  end

  test "add moves from two to more" do
    [solved, to, moves, visited] = Day12.addMove([1,0], 2, 1, %{0 => [[0, 0]], 1 => [[0, 1], [0, 0]]}, [[0, 1], [0, 0]])
    assert solved == false
    assert to == 3
    assert visited == [[1,0],[0,1],[0,0]]
    assert moves == %{0 => [[0,0]], 1 => [[0,1],[0,0]], 2 => [[1, 0], [0, 1], [0, 0]]}
  end


  test "calculateMoves adds move to visited and moves", state do
    [solved, moves, visited] = Day12.calculateMoves(false, state[:map], 0, %{0 => [[0,0]]}, [[0,0]])
    assert solved == false
    assert moves ==  %{1 => [[0, 1], [0, 0]], 2 => [[1, 0], [0, 0]]}
    assert visited ==  [[1,0],[0,1],[0,0]]
  end

  test "calculateMoves doesn't add moves if visited", state do
    [solved, moves, visited] = Day12.calculateMoves(false, state[:map], 0, %{0 => [[0,0]]}, [[0,0],[0,1]])
    assert solved == false
    assert moves ==  %{1 => [[1, 0], [0, 0]]}
    assert visited ==  [[1, 0], [0, 0], [0, 1]]
  end

   test "calculateMoves returns moves when solved", state do
    [solved, moves, visited] = Day12.calculateMoves(false, state[:map], 0, %{0 => [[2,4]]}, [[2,4]])
    assert solved == true
    assert moves ==  [[2, 5], [2, 4]]
    assert visited == [[2, 5], [1, 4], [2, 4]]
  end

  test "part1", state do
    assert Day12.part1(state[:part1]) == 31
  end

  test "solutions" do
    assert Day12.solve1 == 462
  end
end
