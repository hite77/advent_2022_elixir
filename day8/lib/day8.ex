defmodule Day8 do
  @moduledoc """
  Tree height in forest
  """

  @doc """
  Check visible methods

  ## Examples

  current item is higher
  iex> Day8.visibleLeft([6,5], %{"6,5" => 5}, 2)
  false

  going left one is higher
  iex> Day8.visibleLeft([3,4], %{"3,4" => 5, "2,4" => 8}, 7)
  false

  all lower to the left is visible
  iex> Day8.visibleLeft([3,4], %{"3,4" => 5, "2,4" => 5, "1,4" => 3}, 7)
  true

  current item is higher
  iex> Day8.visibleRight([6,5], %{"6,5" => 5}, 2, 8)
  false

  moving one right is higher
  iex> Day8.visibleRight([6,5], %{"6,5" => 5, "7,5" => 9}, 7, 8)
  false

  all lower to the right is visible
  iex> Day8.visibleRight([6,5], %{"6,5" => 5, "7,5" => 4, "8,5" => 0}, 7, 8)
  true

  current item is higher so not visible
  iex> Day8.visibleUp([7,3], %{"7,3" => 5}, 3)
  false

  going up one is higher so not visible
  iex> Day8.visibleUp([7,3], %{"7,3" => 2, "7,2" => 5}, 3)
  false

  iex> Day8.visibleUp([7,3], %{"7,3" => 2, "7,2" => 2, "7,1" => 1}, 3)
  true

  current item is higher so not visible
  iex> Day8.visibleDown([7,3], %{"7,3" => 5}, 3, 5)
  false

  going down one is higher so not visible
  iex> Day8.visibleDown([7,3], %{"7,3" => 2, "7,4" => 5}, 3, 5)
  false

  going down one is equal so not visible
  iex> Day8.visibleDown([7,3], %{"7,3" => 2, "7,4" => 3}, 3, 5)
  false

  iex> Day8.visibleDown([7,3], %{"7,3" => 2, "7,4" => 2, "7,5" => 1}, 3, 5)
  true

  """
  def visibleDown([_x, y], _map, _height, cellHeight) when y == cellHeight+1, do: true
  def visibleDown([x, y], map, height, cellHeight) do
    # TODO need to test in documentation and/or tests with equal
    if map["#{x},#{y}"] >= height do
      false
    else
      visibleDown([x, y+1], map, height, cellHeight)
    end
  end

  def visibleUp([_x, 0], _map, _cellHeight), do: true
  def visibleUp([x, y], map, cellHeight) do
    if map["#{x},#{y}"] >= cellHeight do
      false
    else
      visibleUp([x, y-1], map, cellHeight)
    end
  end

  def visibleRight([x, _y], _map, _cellHeight, width) when x == width+1, do: true
  def visibleRight([x, y], map, cellHeight, width) do
    if map["#{x},#{y}"] >= cellHeight do
      false
    else
      visibleRight([x+1, y], map, cellHeight, width)
    end
  end


  def visibleLeft([0, _y], _map, _cellHeight), do: true
  def visibleLeft([x, y], map, cellHeight) do
    if map["#{x},#{y}"] >= cellHeight do
      false
    else
      visibleLeft([x-1, y], map, cellHeight)
    end
  end

  @doc """
  Coordinates of tree will return visible 1, or not visible 0

  ## Examples

      Left edge
      iex> Day8.visibleTrees([1, "anything"], "anymap", "anywidth", "anyheight", 0)
      1

      Right edge
      iex> Day8.visibleTrees([23, "anything"], "anymap", 23, "anyheight", 0)
      1

      Top edge
      iex> Day8.visibleTrees(["anything", 1], "anymap", "anywidth", "anyheight", 0)
      1

      Bottom edge
      iex> Day8.visibleTrees(["anything", 42], "anymap", "anywidth", 42, 0)
      1

  """
  def visibleTrees([1, _y], _map, _width, _height, output), do: output + 1
  def visibleTrees([x, _y], _map, x, _height, output), do: output + 1
  def visibleTrees([_x, 1], _map, _width, _height, output), do: output + 1
  def visibleTrees([_x, y], _map, _width, y, output), do: output + 1
  def visibleTrees([x,  y], map, width, height, output) do
    cellHeight = map["#{x},#{y}"]
    if (visibleLeft([x-1,y], map, cellHeight) or
      visibleRight([x+1,y], map, cellHeight, width) or
      visibleUp([x, y-1], map, cellHeight) or
      visibleDown([x, y+1], map, cellHeight, height)) do
        output + 1
      else
        output
      end
  end

  @doc ~S"""
  Parse into map

  ## Examples

  iex> Day8.parse(["3","0","3"], 1, 1, %{})
  %{"1,1" => 3, "2,1" => 0, "3,1" => 3}

  iex> Day8.parse(["399","255"], 1, %{})
  %{"1,1" => 3, "1,2" => 2, "2,1" => 9, "2,2" => 5, "3,1" => 9, "3,2" => 5}

  Parses width and height and map.
  iex> Day8.parse("303\n255")
  [3, 2, %{"1,1" => 3, "2,1" => 0, "3,1" => 3, "1,2" => 2, "2,2" => 5, "3,2" => 5}]
  """

  # line1 , "303" , y=1 ==> String.graphemes() "3","0","3" => call with x=1, y=1 convert to int and return map | "1,1" => 3
  # line2 , "255" , y=2
  def parse([], _y, _x, map), do: map
  def parse([head|tail], y, x, map) do
    map = put_in(map["#{x},#{y}"], String.to_integer(head))
    parse(tail, y, x+1, map)
  end
  def parse([], _y, map), do: map
  def parse([head|tail], y, map) do
    map = parse(String.graphemes(head), y, 1, map)
    parse(tail, y+1, map)
  end
  def parse(contents) do
    lines = String.split(contents, "\n")
    [head | _tail] = lines
    [String.length(head),length(lines), parse(lines, 1, %{})]
  end

  def part1(contents) do
    [width, height, map] = parse(contents)

    # map = %{"1,1" => 3, "2,1" => 0, "3,1" => 3, "4,1" => 7, "5,1" => 3,
    # "1,2" => 2, "2,2" => 5, "3,2" => 5, "4,2" => 1, "5,2" => 2,
    # "1,3" => 6, "2,3" => 5, "3,3" => 3, "4,3" => 3, "5,3" => 2,
    # "1,4" => 3, "2,4" => 3, "3,4" => 5, "4,4" => 4, "5,4" => 9,
    # "1,5" => 3, "2,5" => 5, "3,5" => 3, "4,5" => 9, "5,5" => 0
    # }

    1..width |> Enum.map(fn x -> 1..height |> Enum.map(fn y -> [x,y] end) end)
             |> Enum.flat_map(fn x -> x end)
             |> Enum.reduce(0, fn (treeLocation, output) ->  Day8.visibleTrees(treeLocation, map, width, height, output) end)
  end

  def solve1 do
    {:ok, contents} = File.read("day8.txt")
    part1(contents)
  end
end
