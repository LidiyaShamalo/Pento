ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Pento.Repo, :manual)

System.put_env("PHX_LIVE_VIEW_BROWSER_OPEN_PATH", Path.expand("tmp/test_pages"))
ExUnit.start()
