defmodule Day8Test do
  use ExUnit.Case
  doctest Day8

  test "spike fetching with two indexes" do
    mapStringKey = %{"1,1" => 3, "0,1" => 2}
    assert mapStringKey["1,1"] == 3
    assert mapStringKey["0,1"] == 2

    map = %{[0,0] => 3, [0,1] => 2, [1,0] => 1, [1,1] => 2}
    assert Map.fetch(map, [0,0]) == {:ok, 3}
    assert Map.fetch(map, [0,1]) == {:ok, 2}
    assert Map.fetch(map, [1,0]) == {:ok, 1}
    assert Map.fetch(map, [1,1]) == {:ok, 2}
  end

  # def getTree(x, y, map) do
  #   {:ok, tree} = Map.fetch(map, [x,y])
  #   IO.puts("x: #{x}, y: #{y}, height: #{tree}")
  # end

  # test "spike call with all coords inside" do
  #   map = %{[1,1] => 3, [2,1] => 0, [3,1] => 3, [4,1] => 7, [5,1] => 3,
  #           [1,2] => 2, [2,2] => 5, [3,2] => 5, [4,2] => 1, [5,2] => 2,
  #           [1,3] => 6, [2,3] => 5, [3,3] => 3, [4,3] => 3, [5,3] => 2,
  #           [1,4] => 3, [2,4] => 3, [3,4] => 5, [4,4] => 4, [5,4] => 9,
  #           [1,5] => 3, [2,5] => 5, [3,5] => 3, [4,5] => 9, [5,5] => 0
  #         }
  #   width = 5
  #   height = 5
  #   widthRange = 1..width
  #   heightRange = 1..height
  #   assert widthRange == 1..5
  #   assert heightRange == 1..5

  #   Enum.map(widthRange, fn x -> Enum.map(heightRange, fn y -> getTree(x,y, map) end) end)
  # end


  test "visibleTrees for edges" do
    map = %{"1,1" => 3, "2,1" => 0, "3,1" => 3, "4,1" => 7, "5,1" => 3,
            "1,2" => 2, "2,2" => 5, "3,2" => 5, "4,2" => 1, "5,2" => 2,
            "1,3" => 6, "2,3" => 5, "3,3" => 3, "4,3" => 3, "5,3" => 2,
            "1,4" => 3, "2,4" => 3, "3,4" => 5, "4,4" => 4, "5,4" => 9,
            "1,5" => 3, "2,5" => 5, "3,5" => 3, "4,5" => 9, "5,5" => 0
        }
    assert Day8.visibleTrees([1,1], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([1,2], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([1,3], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([1,4], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([1,5], map, 5, 5, 0) == 1

    assert Day8.visibleTrees([2,1], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([2,5], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([3,1], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([3,5], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([4,1], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([4,5], map, 5, 5, 0) == 1

    assert Day8.visibleTrees([5,1], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([5,2], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([5,3], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([5,4], map, 5, 5, 0) == 1
    assert Day8.visibleTrees([5,5], map, 5, 5, 0) == 1
  end

  test "visibleTrees for middle" do
    map = %{"1,1" => 3, "2,1" => 0, "3,1" => 3, "4,1" => 7, "5,1" => 3,
            "1,2" => 2, "2,2" => 5, "3,2" => 5, "4,2" => 1, "5,2" => 2,
            "1,3" => 6, "2,3" => 5, "3,3" => 3, "4,3" => 3, "5,3" => 2,
            "1,4" => 3, "2,4" => 3, "3,4" => 5, "4,4" => 4, "5,4" => 9,
            "1,5" => 3, "2,5" => 5, "3,5" => 3, "4,5" => 9, "5,5" => 0
          }
    assert Day8.visibleTrees([2,2], map, 5, 5, 0) == 1 # left and top
    assert Day8.visibleTrees([3,2], map, 5, 5, 0) == 1 # top and right
    assert Day8.visibleTrees([4,2], map, 5, 5, 0) == 0

    assert Day8.visibleTrees([2,3], map, 5, 5, 0) == 1 # right
    assert Day8.visibleTrees([3,3], map, 5, 5, 0) == 0
    assert Day8.visibleTrees([4,3], map, 5, 5, 0) == 1 # right

    assert Day8.visibleTrees([2,4], map, 5, 5, 0) == 0
    assert Day8.visibleTrees([3,4], map, 5, 5, 0) == 1 # bottom and left
    assert Day8.visibleTrees([4,4], map, 5, 5, 0) == 0
  end

  test "visibleTrees count visible trees" do
    map = %{"1,1" => 3, "2,1" => 0, "3,1" => 3, "4,1" => 7, "5,1" => 3,
            "1,2" => 2, "2,2" => 5, "3,2" => 5, "4,2" => 1, "5,2" => 2,
            "1,3" => 6, "2,3" => 5, "3,3" => 3, "4,3" => 3, "5,3" => 2,
            "1,4" => 3, "2,4" => 3, "3,4" => 5, "4,4" => 4, "5,4" => 9,
            "1,5" => 3, "2,5" => 5, "3,5" => 3, "4,5" => 9, "5,5" => 0
          }

    width = 5
    height = 5
    assert 1..width |> Enum.map(fn x -> 1..height |> Enum.map(fn y -> [x,y] end) end)
                    |> Enum.flat_map(fn x -> x end)
                    |> Enum.reduce(0, fn (treeLocation, output) ->  Day8.visibleTrees(treeLocation, map, width, height, output) end) == 21
  end


  test "parsing to map for trees" do
    [width, height, map] = Day8.parse("30373\n25512\n65332\n33549\n35390")
    assert width == 5
    assert height == 5
    assert map == %{"1,1" => 3, "2,1" => 0, "3,1" => 3, "4,1" => 7, "5,1" => 3,
                    "1,2" => 2, "2,2" => 5, "3,2" => 5, "4,2" => 1, "5,2" => 2,
                    "1,3" => 6, "2,3" => 5, "3,3" => 3, "4,3" => 3, "5,3" => 2,
                    "1,4" => 3, "2,4" => 3, "3,4" => 5, "4,4" => 4, "5,4" => 9,
                    "1,5" => 3, "2,5" => 5, "3,5" => 3, "4,5" => 9, "5,5" => 0
                  }
  end

  test "parsing another map for trees" do
    [width, height, map] = Day8.parse("303\n255")
    assert width == 3
    assert height == 2
    assert map == %{"1,1" => 3, "2,1" => 0, "3,1" => 3,
                    "1,2" => 2, "2,2" => 5, "3,2" => 5}
  end

  test "solutions" do
    assert Day8.solve1 == 1794
  end
end
