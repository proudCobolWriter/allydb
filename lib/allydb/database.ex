defmodule Allydb.Database do
  @moduledoc false

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(_) do
    {:ok, :ets.new(__MODULE__, [:named_table, :public, :set])}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, value}] -> {:reply, value, state}
      [] -> {:reply, nil, state}
    end
  end

  @impl true
  def handle_call({:set, key, value}, _from, state) do
    :ets.insert(state, {key, value})

    {:reply, :ok, state}
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end
end
