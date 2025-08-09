ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Recheck.Repo, :manual)
# Config ExMachina
{:ok, _} = Application.ensure_all_started(:ex_machina)
