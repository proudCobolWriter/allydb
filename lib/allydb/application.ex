defmodule Allydb.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    port = String.to_integer(System.get_env("ALLYDB_PORT") || "4000")

    children = [
      {
        Allydb.Database,
        name: Allydb.Database
      },
      {
        Task.Supervisor,
        name: Allydb.Server.TaskSupervisor
      },
      Supervisor.child_spec({Task, fn -> Allydb.Server.accept(port) end}, restart: :permanent)
    ]

    opts = [strategy: :one_for_one, name: Allydb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
