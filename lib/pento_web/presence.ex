defmodule PentoWeb.Presence do
  @moduledoc"""
  Предоставляет отслеживание присутствия для каналов и процессов.
  Смотрите [`Phoenix.Presence`](https://hexdocs.pm/phoenix/Phoenix.Presence.html)
  документацию для получения дополнительных деталей.
  """

  use Phoenix.Presence,
  otp_app: :pento,
  pubsub_server: Pento.PubSub

  @user_activity_topic "user_activity"

  def track_user(pid, product, user_email) do
    track(
      pid,
      @user_activity_topic,
      product.name,
      %{users: [%{email: user_email}]}
    )
  end
end
