defmodule Day14 do
  @moduledoc """
  Documentation for `Day14`.
  """

  def solve1 do
    {:ok, contents} = File.read("input.txt")
    part1(contents)
  end

  def part1(contents) do
    [map, maxDepth] = parseCoordinatesOfRock(contents) |> rockMap()
    map |> sandFalling(500,0,maxDepth)
        |> countSand()
  end

  @doc """
  Convert from string to coord

  ## Examples

      iex> Day14.convert("5,4")
      [5,4]

  """
  def convert(coord) do
    [first, second] = String.split(coord, ",")
    [String.to_integer(first), String.to_integer(second)]
  end

  def parseCoordinatesOfRock(contents) do
    String.split(contents, "\n", trim: true) |> Enum.map(fn line -> String.split(line, " -> ") end)
                                             |> Enum.map(fn line -> Enum.map(line, fn coord -> convert(coord) end)  end)
  end

  @doc """
  Calculate maxdepth

  ## Examples

      iex> Day14.maxDepth([[[5,2],[6,2]]])
      2

      iex> Day14.maxDepth([[[5,2],[6,2]],[[5,2],[5,3]]])
      3

  """
  def maxDepth(coords) do
    Enum.flat_map(coords, fn item -> item end) |> Enum.map(fn ([_x, y]) -> y end)
                                               |> Enum.max()
  end

  @doc """
  Builds map

  ## Examples

      iex> Day14.addToMap(498,4,"y",%{})
      %{498 => %{4 => "y"}}

      iex> Day14.addToMap(498,5,"y",%{498 => %{4 => "y"}})
      %{498 => %{4 => "y", 5 => "y"}}

      iex> Day14.addToMap(497,6,"y",%{498 => %{4 => "y", 5 => "y"}})
      %{498 => %{4 => "y", 5 => "y"}, 497 => %{6 => "y"}}

  """
  def addToMap(x,y,char,map) do
    case x in Map.keys(map) do
      true -> Map.put(map, x, Map.put(map[x], y, char))
      false -> Map.put(map, x, Map.put(%{}, y, char))
    end
  end

  def addLines([_one], map), do: map
  def addLines([[x,y1], [x,y2] | tail], map) do
    vertical = y1..y2
    map = vertical |> Enum.to_list()
                   |> Enum.reduce(map, fn y, output -> addToMap(x,y,"#",output) end)
    addLines([[x,y2] | tail], map)
  end
  def addLines([[x1,y], [x2,y] | tail], map) do
    horizontal = x1..x2
    map = horizontal |> Enum.to_list()
                     |> Enum.reduce(map, fn x, output -> addToMap(x,y,"#",output) end)
    addLines([[x2,y] | tail], map)
  end

  def addRock([], map), do: map
  def addRock([head | tail], map), do: addRock(tail, addLines(head, map))

  def rockMap(coords) do
   [addRock(coords, %{}), maxDepth(coords)]
  end

  def trycoord(map, x, y) do
    map[x] == nil or map[x][y] == nil
  end

  def sandFalling(map,_sandx,maxdepth,maxdepth), do: map
  def sandFalling(map,sandx,sandy,maxdepth) do
    cond do
      trycoord(map,sandx,sandy+1)   -> sandFalling(map,sandx,sandy+1,maxdepth)
      trycoord(map,sandx-1,sandy+1) -> sandFalling(map,sandx-1,sandy+1,maxdepth)
      trycoord(map,sandx+1,sandy+1) -> sandFalling(map,sandx+1,sandy+1,maxdepth)
      # at rest add to map and start another particle.
      true -> sandFalling(addToMap(sandx,sandy,"o",map),500,0,maxdepth)
    end
  end

  def isSand(item) do
    case item do
      "o" -> 1
      _ -> 0
    end
  end

  @doc """
  Counts sand in map

  ## Examples

      iex> Day14.countSand(%{494 => %{9 => "o"},498 => %{4 => "o", 5 => "o", 6 => "#", 9 => "o"}})
      4

  """
  def countSand(map) do
    map |> Map.values()
        |> Enum.map(fn map -> Map.values(map) end)
        |> Enum.flat_map(fn item -> item end)
        |> Enum.map(fn item -> isSand(item) end)
        |> Enum.sum()
  end
end
