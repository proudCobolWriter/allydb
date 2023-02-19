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

  @impl true
  def handle_call({:lpush, key, value}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] -> :ets.insert(state, {key, [value | list]})
      [] -> :ets.insert(state, {key, [value]})
    end

    {:reply, :ok, state}
  end

  @impl true
  def handle_call({:lpushx, key, value}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] ->
        :ets.insert(state, {key, [value | list]})

        {:reply, value, state}

      [] ->
        {:reply, nil, state}
    end
  end

  @impl true
  def handle_call({:rpush, key, value}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] -> :ets.insert(state, {key, list ++ [value]})
      [] -> :ets.insert(state, {key, [value]})
    end

    {:reply, :ok, state}
  end

  @impl true
  def handle_call({:rpushx, key, value}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] ->
        :ets.insert(state, {key, list ++ [value]})

        {:reply, value, state}

      [] ->
        {:reply, nil, state}
    end
  end

  @impl true
  def handle_call({:lpop, key}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, [value | list]}] ->
        :ets.insert(state, {key, list})

        {:reply, value, state}

      [{_, []}] ->
        {:reply, nil, state}

      [] ->
        {:reply, nil, state}
    end
  end

  @impl true
  def handle_call({:rpop, key}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] ->
        value = Enum.at(list, -1)

        :ets.insert(state, {key, Enum.take(list, length(list) - 1)})

        {:reply, value, state}

      [] ->
        {:reply, nil, state}
    end
  end

  @impl true
  def handle_call({:llen, key}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] -> {:reply, length(list), state}
      [] -> {:reply, 0, state}
    end
  end

  @impl true
  def handle_call({:ltrim, key, start, stop}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] ->
        :ets.insert(state, {key, Enum.slice(list, start, stop - start + 1)})

        {:reply, :ok, state}

      [] ->
        {:reply, :ok, state}
    end
  end

  @impl true
  def handle_call({:lindex, key, index}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] ->
        {:reply, Enum.at(list, index), state}

      [] ->
        {:reply, nil, state}
    end
  end

  @impl true
  def handle_call({:lrange, key, start, stop}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] ->
        {:reply, Enum.slice(list, start, stop - start + 1), state}

      [] ->
        {:reply, [], state}
    end
  end

  @impl true
  def handle_call({:lpos, key, value}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] ->
        {:reply, Enum.find_index(list, &(&1 == value)), state}

      [] ->
        {:reply, nil, state}
    end
  end

  @impl true
  def handle_call({:lrem, key, value}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] ->
        filtered = Enum.filter(list, &(&1 != value))

        :ets.insert(state, {key, filtered})

        {:reply, length(list) - length(filtered), state}

      [] ->
        {:reply, :ok, state}
    end
  end

  @impl true
  def handle_call({:linsert, key, position, pivot, value}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] ->
        case position do
          :before ->
            index = Enum.find_index(list, &(&1 == pivot))
            :ets.insert(state, {key, Enum.take(list, index) ++ [value] ++ Enum.drop(list, index)})

          :after ->
            index = Enum.find_index(list, &(&1 == pivot))

            :ets.insert(
              state,
              {key, Enum.take(list, index + 1) ++ [value] ++ Enum.drop(list, index + 1)}
            )
        end

        {:reply, :ok, state}

      [] ->
        {:reply, :ok, state}
    end
  end

  def handle_call({:lset, key, index, value}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, list}] ->
        :ets.insert(state, {key, Enum.take(list, index) ++ [value] ++ Enum.drop(list, index + 1)})

        {:reply, :ok, state}

      [] ->
        {:reply, :ok, state}
    end
  end

  @impl true
  def handle_call({:delete, key}, _from, state) do
    :ets.delete(state, key)

    {:reply, :ok, state}
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  def lpush(key, value) do
    GenServer.call(__MODULE__, {:lpush, key, value})
  end

  def lpushx(key, value) do
    GenServer.call(__MODULE__, {:lpushx, key, value})
  end

  def rpush(key, value) do
    GenServer.call(__MODULE__, {:rpush, key, value})
  end

  def rpushx(key, value) do
    GenServer.call(__MODULE__, {:rpushx, key, value})
  end

  def lpop(key) do
    GenServer.call(__MODULE__, {:lpop, key})
  end

  def rpop(key) do
    GenServer.call(__MODULE__, {:rpop, key})
  end

  def llen(key) do
    GenServer.call(__MODULE__, {:llen, key})
  end

  def ltrim(key, start, stop) do
    GenServer.call(__MODULE__, {:ltrim, key, start, stop})
  end

  def lindex(key, index) do
    GenServer.call(__MODULE__, {:lindex, key, index})
  end

  def lrange(key, start, stop) do
    GenServer.call(__MODULE__, {:lrange, key, start, stop})
  end

  def lpos(key, value) do
    GenServer.call(__MODULE__, {:lpos, key, value})
  end

  def lrem(key, value) do
    GenServer.call(__MODULE__, {:lrem, key, value})
  end

  def linsert(key, position, pivot, value) do
    GenServer.call(__MODULE__, {:linsert, key, position, pivot, value})
  end

  def lset(key, index, value) do
    GenServer.call(__MODULE__, {:lset, key, index, value})
  end

  def delete(key) do
    GenServer.call(__MODULE__, {:delete, key})
  end
end
