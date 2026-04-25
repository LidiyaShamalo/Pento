defmodule PentoWeb.GameLive do
  use PentoWeb, :live_view

  import PentoWeb.GameLive.Component
  alias PentoWeb.GameLive.Board
  def mount(%{"puzzle" => puzzle}, _session, socket) do
    {:ok, assign(socket, puzzle: puzzle)}
  end

  def render(assigns) do
    ~H"""
    <div class="p-4">
      <section class="mx-auto max-w-4xl px-4 py-8">
        <div class="grid grid-cols-2">
          <div class="border-l-4 border-indigo-500 pl-4">
            <h1 class="text-3xl font-extrabold text-gray-900 leading-none">
              Добро пожаловать
            </h1>
            <p class="text-lg font-medium text-gray-500 mt-1 uppercase tracking-widest">
              в мир Pento
            </p>
          </div>
        <.help />
      </div>
      <.live_component module={Board} puzzle={@puzzle} id="board-component" />
    </section>
    </div>
    """
  end

  attr :points, :list, required: true
  attr :name, :string, required: true
  attr :fill, :string, required: true

  def shape(assigns) do
    ~H"""
    <%= for {x, y} <- @points do %>
      <.point x={x} y={y} fill={@fill} name={@name} />
    <% end %>
    """
  end

  def help(assigns) do
    ~H"""
    <div class="relative">
      <.help_button />
      <.help_page />
    </div>
    """
  end

  attr :class, :string, default: "h-8 w-8 text-slate hover:text-slate-400"

    def help_button(assigns) do
    ~H"""
    <button
      phx-click={JS.toggle(to: "#info", in: "fade-in", out: "fade-out")}
      class="text-slate hover:text-slate-400">
      <.icon name="hero-question-mark-circle-solid" class="h-8 w-8" />
    </button>
    """
  end


        def help_page(assigns) do
    ~H"""
    <div
      id="info"
      class="absolute right-0 top-10 bg-gray-100 text-gray-800 border-2 border-gray-400 p-4 z-10 w-80 shadow-lg rounded hidden"
    >
      <ul class="list-disc list-inside">
        <div class="mb-4">
          <h3 class="font-bold text-gray-900 border-b border-gray-300 pb-1 mb-2 uppercase text-xs tracking-wider">
            🎯 Цель игры
          </h3>
          <p class="text-sm italic">Соберите все пенто на доске, чтобы одержать победу.</p>
        </div>
        <div class="mb-4">
          <h3 class="font-bold text-gray-900 border-b border-gray-300 pb-1 mb-2 uppercase text-xs tracking-wider">
            🕹️ Управление
          </h3>
          <ul class="text-sm space-y-2">
            <li><span class="font-semibold text-indigo-700">Клик:</span> поднять пенто (повторный — отмена).</li>
            <li><span class="font-semibold text-indigo-700">Shift:</span> повернуть фигуру.</li>
            <li><span class="font-semibold text-indigo-700">Enter:</span> перевернуть (отразить).</li>
            <li><span class="font-semibold text-indigo-700">Пробел:</span> опустить на доску.</li>
          </ul>
        </div>
        <div>
        <h3 class="font-bold text-gray-900 border-b border-gray-300 pb-1 mb-2 uppercase text-xs tracking-wider">
          ⚠️ Ограничения
        </h3>
        <ul class="text-sm list-disc list-inside space-y-1 text-gray-700">
          <li>Фигуры не должны перекрываться.</li>
          <li>Пенто должен быть строго в границах доски.</li>
        </ul>
      </div>
      </ul>
    </div>
    """
  end



end
