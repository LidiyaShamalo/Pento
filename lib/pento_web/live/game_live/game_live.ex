defmodule PentoWeb.GameLive do
  use PentoWeb, :live_view

  import PentoWeb.GameLive.Component

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
    <div class="p-4"> <!-- Обертка для структуры -->
      <section class="mx-auto max-w-4xl px-4 py-8">
        <h1 class="text-3xl font-heavy mb-6">Добро пожаловать в Pento!</h1>
        <.canvas view_box="0 0 200 30">
          <.point x={0} y={0} fill="blue" name="a"/>
          <.point x={1} y={0} fill="green" name="b"/>
          <.point x={0} y={1} fill="red" name="c"/>
          <.point x={1} y={1} fill="black" name="d"/>
        </.canvas>
      </section>
    </div>
    """
  end

end
