defmodule PentoWeb.GameLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~H"""
    <div class="p-4"> <!-- Обертка для структуры -->
      <section class="mx-auto max-w-4xl px-4 py-8">
        <h1 class="text-3xl font-bold mb-6">Добро пожаловать в Pento!</h1>
      </section>

      <svg viewBox="0 0 100 100" class="w-24 h-24">
        <defs>
          <rect id="point"width= "10"height= "10"/>
        </defs>
        <use xlink:href="#point" x= "0" y= "0" fill= "blue"/>
        <use xlink:href="#point" x= "10" y= "0" fill= "green"/>
        <use xlink:href="#point" x= "0" y= "10" fill= "red"/>
        <use xlink:href="#point" x= "10" y= "10" fill= "black"/>
      </svg>
    </div>
    """
  end

end
