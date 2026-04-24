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
        <h1 class="text-3xl font-heavy mb-6">Добро пожаловать в Pento!</h1>
          <.live_component module={Board} puzzle={@puzzle} id="board-component"/>
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



end
