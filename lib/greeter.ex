defmodule Greeter do
  use Application # Indicate this module is an application entrypoint

  def start(_args, _opts) do
    children = [
      { Greeter.WorkersSupervisor, [] },
      { Registry, keys: :unique, name: GreeterRegistry }
    ]

    # :one_to_one strategy indicates only the crashed child will be restarted, without affecting the rest of children.
    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end
