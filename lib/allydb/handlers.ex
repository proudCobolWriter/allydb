defmodule Allydb.Handlers do
  @new_line "\n> "

  require Logger

  def handle_line([""], socket) do
    :gen_tcp.send(socket, @new_line)
  end

  def handle_line(["PING"], socket) do
    :gen_tcp.send(socket, "PONG #{@new_line}")
  end

  def handle_line(["GET", key], socket) do
    value = Allydb.Database.get(key)

    Logger.info("GET #{key} -> #{value}")

    :gen_tcp.send(socket, "#{value} #{@new_line}")
  end

  def handle_line(["SET", key | value], socket) do
    value = Enum.join(value, " ")

    :ok = Allydb.Database.set(key, value)

    Logger.info("SET #{key} -> #{value}")

    :gen_tcp.send(socket, "#{value} #{@new_line}")
  end

  def handle_line(["LPUSH", key | value], socket) do
    value = Enum.join(value, " ")

    :ok = Allydb.Database.lpush(key, value)

    Logger.info("LPUSH #{key} -> #{value}")

    :gen_tcp.send(socket, "#{value} #{@new_line}")
  end

  def handle_line(["RPUSH", key | value], socket) do
    value = Enum.join(value, " ")

    :ok = Allydb.Database.rpush(key, value)

    Logger.info("RPUSH #{key} -> #{value}")

    :gen_tcp.send(socket, "#{value} #{@new_line}")
  end

  def handle_line(["LPOP", key], socket) do
    value = Allydb.Database.lpop(key)

    Logger.info("LPOP #{key} -> #{value}")

    :gen_tcp.send(socket, "#{value} #{@new_line}")
  end

  def handle_line(["RPOP", key], socket) do
    value = Allydb.Database.rpop(key)

    Logger.info("RPOP #{key} -> #{value}")

    :gen_tcp.send(socket, "#{value} #{@new_line}")
  end

  def handle_line(["LLEN", key], socket) do
    value = Allydb.Database.llen(key)

    Logger.info("LLEN #{key} -> #{value}")

    :gen_tcp.send(socket, "#{value} #{@new_line}")
  end

  def handle_line(["LTRIM", key, start, stop], socket) do
    start = String.to_integer(start)
    stop = String.to_integer(stop)

    value = Allydb.Database.ltrim(key, start, stop)

    Logger.info("LTRIM #{key} -> #{value}")

    :gen_tcp.send(socket, "#{value} #{@new_line}")
  end

  def handle_line(["LINDEX", key, index], socket) do
    index = String.to_integer(index)

    value = Allydb.Database.lindex(key, index)

    Logger.info("LINDEX #{key} -> #{value}")

    :gen_tcp.send(socket, "#{value} #{@new_line}")
  end

  def handle_line(["LRANGE", key, start, stop], socket) do
    start = String.to_integer(start)
    stop = String.to_integer(stop)

    value = Allydb.Database.lrange(key, start, stop)

    Logger.info("LRANGE #{key} -> #{value}")

    Enum.each(value, fn x ->
      :gen_tcp.send(socket, "#{x}\n")
    end)

    :gen_tcp.send(socket, @new_line)
  end

  def handle_line(["LPOS", key, value], socket) do
    index = Allydb.Database.lpos(key, value)

    Logger.info("LPOS #{key} -> #{index}")

    :gen_tcp.send(socket, "#{index} #{@new_line}")
  end

  def handle_line(["DEL", key], socket) do
    :ok = Allydb.Database.delete(key)

    Logger.info("DEL #{key}")

    :gen_tcp.send(socket, "#{key} #{@new_line}")
  end

  def handle_line(["EXIT"], socket) do
    Logger.info("EXIT")

    :gen_tcp.close(socket)

    :ok = Task.Supervisor.terminate_child(Allydb.Server.TaskSupervisor, self())
  end

  def handle_line([command | _], socket) do
    :gen_tcp.send(socket, "Invalid command: #{command} #{@new_line}")
  end
end
