defmodule Allydb.Handlers do
  @moduledoc false
  alias Allydb.Utils

  @new_line "\n> "

  require Logger

  def handle_line(command, socket \\ nil)

  def handle_line([""], socket) do
    send_empty_response(socket)

    " "
  end

  def handle_line(["PING"], socket) do
    send_response(socket, "PONG")

    " "
  end

  def handle_line(["GET", key], socket) do
    value = Allydb.Database.get(key)

    Logger.info("GET #{key} -> #{value}")

    send_response(socket, value)

    " "
  end

  def handle_line(["SET", key | value], socket) do
    value = Enum.join(value, " ")

    Allydb.Database.set(key, value)

    Logger.info("SET #{key} -> #{value}")

    send_response(socket, value)

    "SET #{key} #{value}"
  end

  def handle_line(["DEL", key], socket) do
    Allydb.Database.delete(key)

    Logger.info("DEL #{key}")

    send_response(socket, key)

    "DEL #{key}"
  end

  def handle_line(["LPUSH", key | value], socket) do
    value = Enum.join(value, " ")

    Allydb.Database.lpush(key, value)

    Logger.info("LPUSH #{key} -> #{value}")

    send_response(socket, value)

    "LPUSH #{key} #{value}"
  end

  def handle_line(["LPUSHX", key | value], socket) do
    value = Enum.join(value, " ")

    Allydb.Database.lpushx(key, value)

    Logger.info("LPUSHX #{key} -> #{value}")

    send_response(socket, value)

    "LPUSHX #{key} #{value}"
  end

  def handle_line(["RPUSH", key | value], socket) do
    value = Enum.join(value, " ")

    Allydb.Database.rpush(key, value)

    Logger.info("RPUSH #{key} -> #{value}")

    send_response(socket, value)

    "RPUSH #{key} #{value}"
  end

  def handle_line(["RPUSHX", key | value], socket) do
    value = Enum.join(value, " ")

    Allydb.Database.rpushx(key, value)

    Logger.info("RPUSHX #{key} -> #{value}")

    send_response(socket, value)

    "RPUSHX #{key} #{value}"
  end

  def handle_line(["LPOP", key], socket) do
    value = Allydb.Database.lpop(key)

    Logger.info("LPOP #{key} -> #{value}")

    send_response(socket, value)

    "LPOP #{key}"
  end

  def handle_line(["RPOP", key], socket) do
    value = Allydb.Database.rpop(key)

    Logger.info("RPOP #{key} -> #{value}")

    send_response(socket, value)

    "RPOP #{key}"
  end

  def handle_line(["LLEN", key], socket) do
    value = Allydb.Database.llen(key)

    Logger.info("LLEN #{key} -> #{value}")

    send_response(socket, value)

    " "
  end

  def handle_line(["LTRIM", key, start, stop], socket) do
    start = String.to_integer(start)
    stop = String.to_integer(stop)

    Allydb.Database.ltrim(key, start, stop)

    Logger.info("LTRIM #{key} -> #{start} #{stop}")

    send_response(socket, "ok")

    "LTRIM #{key} #{start} #{stop}"
  end

  def handle_line(["LINDEX", key, index], socket) do
    index = String.to_integer(index)

    value = Allydb.Database.lindex(key, index)

    Logger.info("LINDEX #{key} -> #{value}")

    send_response(socket, value)

    " "
  end

  def handle_line(["LRANGE", key, start, stop], socket) do
    start = String.to_integer(start)
    stop = String.to_integer(stop)

    value = Allydb.Database.lrange(key, start, stop)

    Logger.info("LRANGE #{key} -> #{value}")

    Enum.each(value, fn x ->
      send_line_response(socket, x)
    end)

    send_empty_response(socket)

    " "
  end

  def handle_line(["LPOS", key, value], socket) do
    index = Allydb.Database.lpos(key, value)

    Logger.info("LPOS #{key} -> #{index}")

    send_response(socket, index)

    " "
  end

  def handle_line(["LREM", key, value], socket) do
    Allydb.Database.lrem(key, value)

    Logger.info("LREM #{key}")

    send_response(socket, key)

    "LREM #{key} #{value}"
  end

  def handle_line(["LINSERT", key, before_after, pivot, value], socket) do
    case String.downcase(before_after) do
      "before" ->
        Allydb.Database.linsert(key, :before, pivot, value)

        Logger.info("LINSERT #{key}")

        send_response(socket, key)

        "LINSERT #{key} #{before_after} #{pivot} #{value}"

      "after" ->
        Allydb.Database.linsert(key, :after, pivot, value)

        Logger.info("LINSERT #{key}")

        send_response(socket, key)

        "LINSERT #{key} #{before_after} #{pivot} #{value}"
    end
  end

  def handle_line(["LSET", key, index, value], socket) do
    index = String.to_integer(index)

    Allydb.Database.lset(key, index, value)

    Logger.info("LSET #{key} -> #{value}")

    send_response(socket, value)

    "LSET #{key} #{index} #{value}"
  end

  def handle_line(["HSET", key | value], socket) do
    IO.inspect(value)

    new_value = Utils.chunk_two(value)

    Allydb.Database.hset(key, new_value)

    Logger.info("HSET #{key}")

    send_response(socket, "ok")

    values = Enum.map_join(value, " ", fn x -> x end)

    "HSET #{key} #{values}"
  end

  def handle_line(["HGET", key, field], socket) do
    value = Allydb.Database.hget(key, field)

    Logger.info("HGET #{key} -> #{value}")

    send_response(socket, value)

    " "
  end

  def handle_line(["HGETALL", key], socket) do
    value = Allydb.Database.hgetall(key)

    Logger.info("HGETALL #{key} -> #{Enum.map_join(value, ", ", fn {k, v} -> "#{k}: #{v}" end)}")

    Enum.each(value, fn {k, v} ->
      send_line_response(socket, k)
      send_line_response(socket, v)
    end)

    send_empty_response(socket)

    " "
  end

  def handle_line(["HDEL", key | fields], socket) do
    Allydb.Database.hdel(key, fields)

    Logger.info("HDEL #{key}")

    send_response(socket, "ok")

    "HDEL #{key} #{Enum.join(fields, " ")}"
  end

  def handle_line(["HLEN", key], socket) do
    count = Allydb.Database.hlen(key)

    Logger.info("HLEN #{key} -> #{count}")

    send_response(socket, count)

    " "
  end

  def handle_line(["HEXISTS", key, field], socket) do
    value = Allydb.Database.hexists(key, field)

    Logger.info("HEXISTS #{key} -> #{value}")

    send_response(socket, value)

    " "
  end

  def handle_line(["HKEYS", key], socket) do
    value = Allydb.Database.hkeys(key)

    Logger.info("HKEYS #{key} -> #{value}")

    Enum.each(value, fn x ->
      send_line_response(socket, x)
    end)

    send_empty_response(socket)

    " "
  end

  def handle_line(["HVALS", key], socket) do
    value = Allydb.Database.hvals(key)

    Logger.info("HVALS #{key} -> #{value}")

    Enum.each(value, fn x ->
      send_line_response(socket, x)
    end)

    send_empty_response(socket)

    " "
  end

  def handle_line(["EXIT"], socket) do
    Logger.info("EXIT")

    :gen_tcp.close(socket)

    :ok = Task.Supervisor.terminate_child(Allydb.Server.TaskSupervisor, self())

    "EXIT"
  end

  def handle_line([command | _], socket) do
    send_response(socket, "Invalid command: #{command}")

    " "
  end

  defp send_response(socket, value) do
    case socket do
      nil ->
        :ok

      _ ->
        :gen_tcp.send(socket, "#{value} #{@new_line}")
    end
  end

  defp send_line_response(socket, value) do
    case socket do
      nil ->
        :ok

      _ ->
        :gen_tcp.send(socket, "#{value}\n")
    end
  end

  defp send_empty_response(socket) do
    case socket do
      nil ->
        :ok

      _ ->
        :gen_tcp.send(socket, @new_line)
    end
  end
end
