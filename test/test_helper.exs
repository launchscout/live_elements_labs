{:ok, _} = Application.ensure_all_started(:wallaby)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(LiveElementsLabs.Repo, :manual)
