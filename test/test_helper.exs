ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(BuscaCep.Repo, :manual)
Mox.defmock(BuscaCep.GetCep.Mock, for: BuscaCep.GetCep)
