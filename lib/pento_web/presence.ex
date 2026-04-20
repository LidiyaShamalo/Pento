defmodule PentoWeb.Presence do
  @moduledoc"""
  Предоставляет отслеживание присутствия для каналов и процессов.
  Смотрите [`Phoenix.Presence`](https://hexdocs.pm/phoenix/Phoenix.Presence.html)
  документацию для получения дополнительных деталей.
  """

  use Phoenix.Presence,
  otp_app: :pento,
  pubsub_server: Pento.PubSub
  
end
