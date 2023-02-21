defmodule Day10 do
  @moduledoc """
  Documentation for `Day10`.
  """

  @doc """
  Build timeline

  ## Examples

      iex> Day10.timeline("noop", [%{}, 0, 1])
      [%{0 => 1}, 1, 1]

      iex> Day10.timeline("addx 3", [%{0 => 1}, 1, 1])
      [%{0 => 1, 1 => 1, 2 => 1}, 3, 4]
  """
  def timeline("addx " <> adder, [map, tick, x]) do
    map = put_in(map[tick], x)
    map = put_in(map[tick+1], x)
    [map, tick + 2, x+String.to_integer(adder)]
  end
  def timeline("noop", [map, tick, x]), do: [put_in(map[tick], x), tick + 1, x]
  def timeline(commands) do
    commands |> Enum.reduce([%{}, 1, 1], fn (command, output) -> timeline(command, output) end)
             |> hd()
  end

  def part1(contents) do
    map = timeline(contents)
    20 * map[20] +
    60 * map[60] +
    100 * map[100] +
    140 * map[140] +
    180 * map[180] +
    220 * map[220]
  end

  def match(coord, value, offset) do
    actualCoord = coord - offset
    cond do
      actualCoord == value     -> "#"
      actualCoord == value + 1 -> "#"
      actualCoord == value - 1 -> "#"
      true                     -> "."
    end
  end

  def pixel(coord, frequencyMap, output, offset), do: output <> match(coord, frequencyMap[coord+1], offset)

  def part2(contents) do
    frequencyMap = timeline(contents)
    %{
      1 => Enum.reduce(Enum.to_list(0..39),    "", fn (coord,output) -> pixel(coord, frequencyMap, output,   0) end),
      2 => Enum.reduce(Enum.to_list(40..79),   "", fn (coord,output) -> pixel(coord, frequencyMap, output,  40) end),
      3 => Enum.reduce(Enum.to_list(80..119),  "", fn (coord,output) -> pixel(coord, frequencyMap, output,  80) end),
      4 => Enum.reduce(Enum.to_list(120..159), "", fn (coord,output) -> pixel(coord, frequencyMap, output, 120) end),
      5 => Enum.reduce(Enum.to_list(160..199), "", fn (coord,output) -> pixel(coord, frequencyMap, output, 160) end),
      6 => Enum.reduce(Enum.to_list(200..239), "", fn (coord,output) -> pixel(coord, frequencyMap, output, 200) end)
    }
  end

  def solve1 do
    {:ok, contents} = File.read("day10.txt")
    part1(String.split(contents, "\n", trim: true))
  end

  def solve2 do
    {:ok, contents} = File.read("day10.txt")
    part2(String.split(contents, "\n", trim: true))
  end
end
