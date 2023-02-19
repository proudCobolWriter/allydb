defmodule Allydb.Utils do
  @moduledoc false

  def chunk_two(value) do
    value =
      Enum.chunk_every(value, 2)
      |> Enum.map(fn [k, v] -> {k, v} end)
      |> Enum.into(%{})

    value
  end
end
