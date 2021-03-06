defmodule CachedContentful.Application do
 use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_, _) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: ExMedium.Worker.start_link(arg1, arg2, arg3)
      # worker(ExMedium.Worker, [arg1, arg2, arg3]),
      worker(CachedContentful.EntryRegistry, [CachedContentful.EntryRegistry]),
      worker(CachedContentful.AssetRegistry, [CachedContentful.AssetRegistry]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CachedContentful.Supervisor]
    Supervisor.start_link(children, opts)

    CachedContentful.ResultSupervisor.start_link()
  end
  
end
