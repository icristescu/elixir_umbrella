defmodule WorkerPool.PoolsSupervisor do
  use Supervisor

  def start_link(pools) do
    Supervisor.start_link(__MODULE__, pools, name: :pools_supervisor)
  end

  def init(pools) do
    IO.puts "PoolsSupervisor started..."

    children =
      Enum.map(pools, fn ns ->
	id = String.to_atom(ns[:name])
	Supervisor.child_spec({WorkerPool.PoolSupervisor, ns}, id: id) end)
    Supervisor.init(children, strategy: :one_for_one)

  end


end
