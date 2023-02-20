defmodule Allydb.Utils do
  @moduledoc false

  def chunk_two(value) do
    value
    |> Enum.chunk_every(2)
    |> Enum.map(fn [k, v] -> {k, v} end)
    |> Enum.into(%{})
  end

  def parse_line(line) do
    line
    |> String.split(" ")
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.with_index()
    |> Enum.map(fn {x, i} -> if i == 0, do: String.upcase(x), else: x end)
  end

  def parse_line_with_end(line) do
    line
    |> String.slice(0..-2)
    |> parse_line()
  end
end
