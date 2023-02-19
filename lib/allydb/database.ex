defmodule Allydb.Database do
  @moduledoc false

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(_) do
    {:ok, __MODULE__}
  end

  @impl true
  def handle_call(:create, _from, state) do
    :ets.new(state, [:named_table, :public, :set])

    {:reply, :ok, state}
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
  def handle_call({:delete, key}, _from, state) do
    :ets.delete(state, key)

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

  @impl true
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
  def handle_call({:hset, key, value}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, map}] ->
        case map do
          %{} ->
            new_map = Map.merge(map, value)

            :ets.insert(state, {key, new_map})

            {:reply, Kernel.map_size(new_map), state}

          _ ->
            :ets.insert(state, {key, value})

            {:reply, Kernel.map_size(value), state}
        end

      [] ->
        :ets.insert(state, {key, value})

        {:reply, Kernel.map_size(value), state}
    end
  end

  @impl true
  def handle_call({:hget, key, field}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, map}] ->
        case map do
          %{} -> {:reply, Map.get(map, field), state}
          _ -> {:reply, nil, state}
        end

      [] ->
        {:reply, nil, state}
    end
  end

  @impl true
  def handle_call({:hgetall, key}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, map}] ->
        case map do
          %{} -> {:reply, map, state}
          _ -> {:reply, nil, state}
        end

      [] ->
        {:reply, nil, state}
    end
  end

  @impl true
  def handle_call({:hdel, key, fields}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, map}] ->
        case map do
          %{} ->
            filtered = Enum.filter(fields, &Map.has_key?(map, &1))

            :ets.insert(state, {key, Map.drop(map, filtered)})

            {:reply, length(filtered), state}

          _ ->
            {:reply, 0, state}
        end

      [] ->
        {:reply, 0, state}
    end
  end

  @impl true
  def handle_call({:hlen, key}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, map}] ->
        case map do
          %{} -> {:reply, Kernel.map_size(map), state}
          _ -> {:reply, 0, state}
        end

      [] ->
        {:reply, 0, state}
    end
  end

  @impl true
  def handle_call({:hexists, key, field}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, map}] ->
        case map do
          %{} ->
            has_key =
              case Map.has_key?(map, field) do
                true -> 1
                false -> 0
              end

            {:reply, has_key, state}

          _ ->
            {:reply, 0, state}
        end

      [] ->
        {:reply, 1, state}
    end
  end

  @impl true
  def handle_call({:hkeys, key}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, map}] ->
        case map do
          %{} -> {:reply, Map.keys(map), state}
          _ -> {:reply, [], state}
        end

      [] ->
        {:reply, [], state}
    end
  end

  @impl true
  def handle_call({:hvals, key}, _from, state) do
    case :ets.lookup(state, key) do
      [{_, map}] ->
        case map do
          %{} -> {:reply, Map.values(map), state}
          _ -> {:reply, [], state}
        end

      [] ->
        {:reply, [], state}
    end
  end

  def create() do
    GenServer.call(__MODULE__, :create)
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  def delete(key) do
    GenServer.call(__MODULE__, {:delete, key})
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

  def hset(key, value) do
    GenServer.call(__MODULE__, {:hset, key, value})
  end

  def hget(key, field) do
    GenServer.call(__MODULE__, {:hget, key, field})
  end

  def hgetall(key) do
    GenServer.call(__MODULE__, {:hgetall, key})
  end

  def hdel(key, field) do
    GenServer.call(__MODULE__, {:hdel, key, field})
  end

  def hlen(key) do
    GenServer.call(__MODULE__, {:hlen, key})
  end

  def hexists(key, field) do
    GenServer.call(__MODULE__, {:hexists, key, field})
  end

  def hkeys(key) do
    GenServer.call(__MODULE__, {:hkeys, key})
  end

  def hvals(key) do
    GenServer.call(__MODULE__, {:hvals, key})
  end
end
