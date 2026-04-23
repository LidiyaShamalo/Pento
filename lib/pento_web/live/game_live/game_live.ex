defmodule PentoWeb.GameLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
    <section class="mx-auto max-w-4xl px-4 py-8">
      <h1 class="font-heavytext-3xlmb-6">Добро пожаловать в Pento!</h1>
    </section>
    """
  end

end
