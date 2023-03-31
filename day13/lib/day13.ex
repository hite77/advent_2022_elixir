defmodule Day13 do
  @moduledoc """
  Documentation for `Day13`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day13.hello()
      :world

  """
  def hello do
    :world
  end

  # left to right scan []

  def parsePacket(string) do
    Regex.split(~r/[^\w\/[\/]]+/, string)
    # <<head::binary-size(1)>> <> tail = string
    # case head do
    #   "[" -> parsePacket(tail, level + 1)
    #   "]" -> parsePacket(tail, level - 1)
    #   _ -> parsePacket(tail, level)
    # end
    #String.split(string, ["[","]"], trim: true)
  end
end
