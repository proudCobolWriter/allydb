defmodule Allydb.Server do
  @moduledoc false

  require Logger

  @new_line "\n> "

  def accept(port) do
    {:ok, socket} =
      :gen_tcp.listen(
        port,
        [:binary, packet: :line, active: false, reuseaddr: true]
      )

    Logger.info("Accepting connections on port #{port}")

    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)

    :gen_tcp.send(client, "> ")

    {:ok, pid} =
      Task.Supervisor.start_child(Allydb.Server.TaskSupervisor, fn -> serve(client) end)

    :ok = :gen_tcp.controlling_process(client, pid)

    loop_acceptor(socket)
  end

  defp serve(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} -> data |> parse_line() |> handle_line(socket)
      {:error, :closed} -> :gen_tcp.close(socket)
    end

    serve(socket)
  end

  defp parse_line(line) do
    line
    |> String.split(" ")
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.with_index()
    |> Enum.map(fn {x, i} -> if i == 0, do: String.upcase(x), else: x end)
  end

  defp handle_line([""], socket) do
    :gen_tcp.send(socket, @new_line)
  end

  defp handle_line(["PING"], socket) do
    :gen_tcp.send(socket, "PONG #{@new_line}")
  end

  defp handle_line(["GET", key], socket) do
    value = Allydb.Database.get(key)

    Logger.info("GET #{key} -> #{value}")

    :gen_tcp.send(socket, "#{value} #{@new_line}")
  end

  defp handle_line(["SET", key, value], socket) do
    :ok = Allydb.Database.set(key, value)

    Logger.info("SET #{key} -> #{value}")

    :gen_tcp.send(socket, "#{value} #{@new_line}")
  end

  defp handle_line(["DEL", key], socket) do
    :ok = Allydb.Database.delete(key)

    Logger.info("DEL #{key}")

    :gen_tcp.send(socket, "#{key} #{@new_line}")
  end

  defp handle_line(["EXIT"], socket) do
    :gen_tcp.close(socket)

    :ok = Task.Supervisor.terminate_child(Allydb.Server.TaskSupervisor, self())
  end

  defp handle_line(_, socket) do
    :gen_tcp.send(socket, "Invalid command #{@new_line}")
  end
end
