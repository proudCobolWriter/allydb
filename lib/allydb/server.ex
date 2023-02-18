defmodule Allydb.Server do
  @moduledoc false

  require Logger

  alias Allydb.Handlers

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
      {:ok, data} -> data |> parse_line() |> Handlers.handle_line(socket)
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
end
