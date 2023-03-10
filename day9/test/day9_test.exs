defmodule Day9Test do
  use ExUnit.Case
  doctest Day9

  test "parts/solves" do
    assert Day9.part1(["R 4","U 4","L 3","D 1","R 4","D 1","L 5","R 2"]) == 13
    assert Day9.solve1 == 6090
    assert Day9.solve2 == 2566
  end

  test "unwrap counts of moves into a full list" do
    assert Day9.unwrapMoves("U 4") == ["U", "U", "U", "U"]
    assert Day9.unwrapMoves("D 1") == ["D"]
    assert Day9.unwrapMoves("D 3") == ["D", "D", "D"]
    assert Day9.unwrapMoves("L 1") == ["L"]
    assert Day9.unwrapMoves("U 2") == ["U", "U"]
   end

   test "updateMap" do
     assert Day9.updateMap(0,0, %{"0,0" => 1}) == %{"0,0" => 2}
     assert Day9.updateMap(0,0, %{}) == %{"0,0" => 1}
   end

   test "move Head And Tail record unique Tail positions in map" do
    # add some negative tests to make sure it works.

     #                            Head  Tail     Map of tail    Head  Tail     Map of Tail
     assert Day9.performMove("R", [0,0, 0,0, %{"0,0" => 1}]) == [1,0, 0,0, %{"0,0" => 1}]
     assert Day9.performMove("R", [1,0, 0,0, %{"0,0" => 1}]) == [2,0, 1,0, %{"0,0" => 1, "1,0" => 1}]
     assert Day9.performMove("R", [1,0, 0,1, %{"0,0" => 1}]) == [2,0, 1,0, %{"0,0" => 1, "1,0" => 1}]
     assert Day9.performMove("R", [1,0, 0,-1, %{"0,0" => 1}]) == [2,0, 1,0, %{"0,0" => 1, "1,0" => 1}]

     assert Day9.performMove("R", [1,0, 0,0, %{"1,0" => 1}]) == [2,0, 1,0, %{"1,0" => 2}]
     assert Day9.performMove("R", [1,0, 0,1, %{"1,0" => 1}]) == [2,0, 1,0, %{"1,0" => 2}]
     assert Day9.performMove("R", [1,0, 0,-1, %{"1,0" => 1}]) == [2,0, 1,0, %{"1,0" => 2}]

     assert Day9.performMove("L", [0,0, 0,0, %{"0,0" => 1}])  == [-1,0, 0,0, %{"0,0" => 1}]
     assert Day9.performMove("L", [-1,0, 0,0, %{"0,0" => 1}]) == [-2,0, -1,0, %{"0,0" => 1, "-1,0" => 1}]
     assert Day9.performMove("L", [-1,0, 0,1, %{"0,0" => 1}]) == [-2,0, -1,0, %{"0,0" => 1, "-1,0" => 1}]
     assert Day9.performMove("L", [-1,0, 0,-1, %{"0,0" => 1}]) == [-2,0, -1,0, %{"0,0" => 1, "-1,0" => 1}]

     assert Day9.performMove("L", [-1,0, 0,0, %{"-1,0" => 1}]) == [-2,0, -1,0, %{"-1,0" => 2}]
     assert Day9.performMove("L", [-1,0, 0,1, %{"-1,0" => 1}]) == [-2,0, -1,0, %{"-1,0" => 2}]
     assert Day9.performMove("L", [-1,0, 0,-1, %{"-1,0" => 1}]) == [-2,0, -1,0, %{"-1,0" => 2}]

     assert Day9.performMove("U", [0,0, 0,0, %{"0,0" => 1}])  == [0,1, 0,0, %{"0,0" => 1}]
     assert Day9.performMove("U", [0,1, 0,0, %{"0,0" => 1}]) == [0,2, 0,1, %{"0,0" => 1, "0,1" => 1}]
     assert Day9.performMove("U", [0,1, 1,0, %{"0,0" => 1}]) == [0,2, 0,1, %{"0,0" => 1, "0,1" => 1}]
     assert Day9.performMove("U", [0,1, -1,0, %{"0,0" => 1}]) == [0,2, 0,1, %{"0,0" => 1, "0,1" => 1}]

     assert Day9.performMove("U", [0,1, 0,0, %{"0,1" => 1}]) == [0,2, 0,1, %{"0,1" => 2}]
     assert Day9.performMove("U", [0,1, 1,0, %{"0,1" => 1}]) == [0,2, 0,1, %{"0,1" => 2}]
     assert Day9.performMove("U", [0,1, -1,0, %{"0,1" => 1}]) == [0,2, 0,1, %{"0,1" => 2}]

     assert Day9.performMove("D", [0,0, 0,0, %{"0,0" => 1}])  == [0,-1, 0,0, %{"0,0" => 1}]
     assert Day9.performMove("D", [0,-1, 0,0, %{"0,0" => 1}]) == [0,-2, 0,-1, %{"0,0" => 1, "0,-1" => 1}]
     assert Day9.performMove("D", [0,-1, 1,0, %{"0,0" => 1}]) == [0,-2, 0,-1, %{"0,0" => 1, "0,-1" => 1}]
     assert Day9.performMove("D", [0,-1, -1,0, %{"0,0" => 1}]) == [0,-2, 0,-1, %{"0,0" => 1, "0,-1" => 1}]

     assert Day9.performMove("D", [0,-1, 0,0, %{"0,-1" => 1}]) == [0,-2, 0,-1, %{"0,-1" => 2}]
     assert Day9.performMove("D", [0,-1, 1,0, %{"0,-1" => 1}]) == [0,-2, 0,-1, %{"0,-1" => 2}]
     assert Day9.performMove("D", [0,-1, -1,0, %{"0,-1" => 1}]) == [0,-2, 0,-1, %{"0,-1" => 2}]
   end

   def pushMoves(contents) do
    contents |> Enum.map(fn move -> Day9.unwrapMoves(move) end)
             |> Enum.flat_map(fn move -> move end)
             |> Enum.reduce([0,0,0,0, %{"0,0" => 1}], fn (move, data) -> Day9.performMove(move, data) end)
   end

   test "integration test of part 1" do
    # == R4 ==
    assert ["R 1"] |> pushMoves() == [1, 0, 0, 0, %{"0,0" => 1}]
    assert ["R 2"] |> pushMoves() == [2, 0, 1, 0, %{"0,0" => 1, "1,0" => 1}]
    assert ["R 3"] |> pushMoves() == [3, 0, 2, 0, %{"0,0" => 1, "1,0" => 1, "2,0" => 1}]
    assert ["R 4"] |> pushMoves() == [4, 0, 3, 0, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1}]
    # == U4 ==
    assert ["R 4", "U 1"] |> pushMoves() == [4, 1, 3, 0, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1}]
    assert ["R 4", "U 2"] |> pushMoves() == [4, 2, 4, 1, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1}]
    assert ["R 4", "U 3"] |> pushMoves() == [4, 3, 4, 2, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1}]
    assert ["R 4", "U 4"] |> pushMoves() == [4, 4, 4, 3, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 1}]
    # == L3 ==
    assert ["R 4", "U 4", "L 1"] |> pushMoves() == [3, 4, 4, 3, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 1}]
    assert ["R 4", "U 4", "L 2"] |> pushMoves() == [2, 4, 3, 4, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 1,
                                                    "3,4" => 1}]
    assert ["R 4", "U 4", "L 3"] |> pushMoves() == [1, 4, 2, 4, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 1,
                                                    "3,4" => 1, "2,4" => 1}]
    # == D1 ==
    assert ["R 4", "U 4", "L 3", "D 1"] |> pushMoves() == [1, 3, 2, 4, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 1,
                                                    "3,4" => 1, "2,4" => 1}]
    # == R4 ==
    assert ["R 4", "U 4", "L 3", "D 1", "R 1"] |> pushMoves() == [2, 3, 2, 4, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 1,
      "3,4" => 1, "2,4" => 1}]
    assert ["R 4", "U 4", "L 3", "D 1", "R 2"] |> pushMoves() == [3, 3, 2, 4, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 1,
      "3,4" => 1, "2,4" => 1}]
    assert ["R 4", "U 4", "L 3", "D 1", "R 3"] |> pushMoves() == [4, 3, 3, 3, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 1,
      "3,4" => 1, "2,4" => 1, "3,3" => 1}]
    assert ["R 4", "U 4", "L 3", "D 1", "R 4"] |> pushMoves() == [5, 3, 4, 3, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 2,
      "3,4" => 1, "2,4" => 1, "3,3" => 1}]
    # == D1 ==
    assert ["R 4", "U 4", "L 3", "D 1", "R 4", "D 1"] |> pushMoves() == [5, 2, 4, 3, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 2,
      "3,4" => 1, "2,4" => 1, "3,3" => 1}]
    # == L5 ==
    assert ["R 4", "U 4", "L 3", "D 1", "R 4", "D 1", "L 1"] |> pushMoves() == [4, 2, 4, 3, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 2,
      "3,4" => 1, "2,4" => 1, "3,3" => 1}]
    assert ["R 4", "U 4", "L 3", "D 1", "R 4", "D 1", "L 2"] |> pushMoves() == [3, 2, 4, 3, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 2,
      "3,4" => 1, "2,4" => 1, "3,3" => 1}]
    assert ["R 4", "U 4", "L 3", "D 1", "R 4", "D 1", "L 3"] |> pushMoves() == [2, 2, 3, 2, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 2,
      "3,4" => 1, "2,4" => 1, "3,3" => 1, "3,2" => 1}]
    assert ["R 4", "U 4", "L 3", "D 1", "R 4", "D 1", "L 4"] |> pushMoves() == [1, 2, 2, 2, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 2,
      "3,4" => 1, "2,4" => 1, "3,3" => 1, "3,2" => 1, "2,2" => 1}]
    assert ["R 4", "U 4", "L 3", "D 1", "R 4", "D 1", "L 5"] |> pushMoves() == [0, 2, 1, 2, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 2,
      "3,4" => 1, "2,4" => 1, "3,3" => 1, "3,2" => 1, "2,2" => 1, "1,2" => 1}]
  # == R2 ==
    assert ["R 4", "U 4", "L 3", "D 1", "R 4", "D 1", "L 5", "R 1"] |> pushMoves() == [1, 2, 1, 2, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 2,
      "3,4" => 1, "2,4" => 1, "3,3" => 1, "3,2" => 1, "2,2" => 1, "1,2" => 1}]
    assert ["R 4", "U 4", "L 3", "D 1", "R 4", "D 1", "L 5", "R 2"] |> pushMoves() == [2, 2, 1, 2, %{"0,0" => 1, "1,0" => 1, "2,0" => 1, "3,0" => 1, "4,1" => 1, "4,2" => 1, "4,3" => 2,
      "3,4" => 1, "2,4" => 1, "3,3" => 1, "3,2" => 1, "2,2" => 1, "1,2" => 1}]
   end

   test "difference of one" do
    assert Day9.moveTail([-6,-5], [-7,-5, [[0,1], [5,6]]]) == [-7, -5, [[0, 1], [5, 6]]]
    assert Day9.moveTail([-8,-5], [-7,-5, [[0,1], [5,6]]]) == [-7, -5, [[0, 1], [5, 6]]]
    assert Day9.moveTail([-7,-4], [-7,-5, [[0,1], [5,6]]]) == [-7, -5, [[0, 1], [5, 6]]]
    assert Day9.moveTail([-7,-6], [-7,-5, [[0,1], [5,6]]]) == [-7, -5, [[0, 1], [5, 6]]]
    assert Day9.moveTail([-6,-4], [-7,-5, [[0,1], [5,6]]]) == [-7, -5, [[0, 1], [5, 6]]]
    assert Day9.moveTail([-6,-6], [-7,-5, [[0,1], [5,6]]]) == [-7, -5, [[0, 1], [5, 6]]]
    assert Day9.moveTail([-8,-6], [-7,-5, [[0,1], [5,6]]]) == [-7, -5, [[0, 1], [5, 6]]]
    assert Day9.moveTail([-8,-4], [-7,-5, [[0,1], [5,6]]]) == [-7, -5, [[0, 1], [5, 6]]]

    assert Day9.moveTail([-6,-5], [-7,-5, [[0,0]]]) == [-7, -5, [[0,0]]]
    assert Day9.moveTail([-8,-5], [-7,-5, [[0,0]]]) == [-7, -5, [[0,0]]]
    assert Day9.moveTail([-7,-4], [-7,-5, [[0,0]]]) == [-7, -5, [[0,0]]]
    assert Day9.moveTail([-7,-6], [-7,-5, [[0,0]]]) == [-7, -5, [[0,0]]]
    assert Day9.moveTail([-6,-4], [-7,-5, [[0,0]]]) == [-7, -5, [[0,0]]]
    assert Day9.moveTail([-6,-6], [-7,-5, [[0,0]]]) == [-7, -5, [[0,0]]]
    assert Day9.moveTail([-8,-6], [-7,-5, [[0,0]]]) == [-7, -5, [[0,0]]]
    assert Day9.moveTail([-8,-4], [-7,-5, [[0,0]]]) == [-7, -5, [[0,0]]]
  end

  test "distance of two" do
    assert Day9.moveTail([0, 2], [0,0, [[0,1]]]) == [0, 1, [[0, 1], [0, 1]]]
    assert Day9.moveTail([0, 2], [0,0, [[0,1], [5,6]]]) == [0, 1, [[0, 1], [0, 1], [5,6]]]

    assert Day9.moveTail([0, -2], [0,0, [[0,1]]]) == [0, -1, [[0, -1], [0, 1]]]
    assert Day9.moveTail([0, -2], [0,0, [[0,1], [5,6]]]) == [0, -1, [[0, -1], [0, 1], [5,6]]]

    assert Day9.moveTail([2, 0], [0,0, [[0,1]]]) == [1, 0, [[1, 0], [0, 1]]]
    assert Day9.moveTail([2, 0], [0,0, [[0,1], [5,6]]]) == [1, 0, [[1, 0], [0, 1], [5,6]]]

    assert Day9.moveTail([-2, 0], [0,0, [[0,1]]]) == [-1, 0, [[-1, 0], [0, 1]]]
    assert Day9.moveTail([-2, 0], [0,0, [[0,1], [5,6]]]) == [-1, 0, [[-1, 0], [0, 1], [5,6]]]
  end

  test "diagonals moves" do
    #1
    assert Day9.moveTail([3, 8], [5,7, [[4, 0]]])           == [4, 8, [[4, 8], [4, 0]]]
    assert Day9.moveTail([3, 8], [5,7, [[4, 0], [3, 0]]])   == [4, 8, [[4, 8],[4, 0], [3, 0]]]
    #2
    assert Day9.moveTail([4, 9], [5,7, [[4, 0]]])           == [4, 8, [[4, 8], [4, 0]]]
    assert Day9.moveTail([4, 9], [5,7, [[4, 0], [3, 0]]])   == [4, 8, [[4, 8],[4, 0], [3, 0]]]
    #3
    assert Day9.moveTail([5, 2], [4,0, [[4, 0]]])           == [5, 1, [[5, 1], [4, 0]]]
    assert Day9.moveTail([5, 2], [4,0, [[4, 0], [3, 0]]])   == [5, 1, [[5, 1],[4, 0], [3, 0]]]
    #4 x1 = x2
    assert Day9.moveTail([5, 2], [4,0, [[4, 0]]])           == [5, 1, [[5, 1], [4, 0]]]
    assert Day9.moveTail([5, 2], [4,0, [[4, 0], [3, 0]]])   == [5, 1, [[5, 1],[4, 0], [3, 0]]]
    #5
    assert Day9.moveTail([-1, 5], [-3,6, [[4, 0]]])         == [-2, 5, [[-2, 5], [4, 0]]]
    assert Day9.moveTail([-1, 5], [-3,6, [[4, 0], [3, 0]]]) == [-2, 5, [[-2, 5],[4, 0], [3, 0]]]
    #6
    assert Day9.moveTail([-2, 4], [-3,6, [[4, 0]]])         == [-2, 5, [[-2, 5], [4, 0]]]
    assert Day9.moveTail([-2, 4], [-3,6, [[4, 0], [3, 0]]]) == [-2, 5, [[-2, 5],[4, 0], [3, 0]]]
    #7
    assert Day9.moveTail([-3, 6], [-2,8, [[4, 0]]])         == [-3, 7, [[-3, 7], [4, 0]]]
    assert Day9.moveTail([-3, 6], [-2,8, [[4, 0], [3, 0]]]) == [-3, 7, [[-3, 7],[4, 0], [3, 0]]]
    #8
    assert Day9.moveTail([-4, 7], [-2,8, [[4, 0]]])         == [-3, 7, [[-3, 7], [4, 0]]]
    assert Day9.moveTail([-4, 7], [-2,8, [[4, 0], [3, 0]]]) == [-3, 7, [[-3, 7],[4, 0], [3, 0]]]
  end
end
