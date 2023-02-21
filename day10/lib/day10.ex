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

  def solve1 do
    {:ok, contents} = File.read("day10.txt")
    part1(String.split(contents, "\n", trim: true))
  end
end
