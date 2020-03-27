defmodule Greeter.Worker do
  use GenServer, restart: :transient

  def start_link(name),
    do: GenServer.start_link(__MODULE__, name, name: process_name(name))

  def init(name),
    do: {:ok, name, {:continue, nil}}

  def handle_continue(nil, name) do
    IO.puts("👋 #{name}")
    {:stop, :normal, name}
  end

  defp process_name(name),
    do: {:via, Registry, {GreeterRegistry, "greeter_for_#{name}"}}
end
