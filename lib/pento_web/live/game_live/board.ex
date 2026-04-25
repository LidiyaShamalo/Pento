defmodule PentoWeb.GameLive.Board do
  use PentoWeb, :live_component

  alias Pento.Game.{Board, Pentomino}
  alias Pento.Game
  import PentoWeb.GameLive.{Component, Colors}

  def update(%{puzzle: puzzle, id: id}, socket) do
    {:ok,
      socket
      |> assign_params(id, puzzle)
      |> assign_board()
      |> assign_shapes()
  }
  end

  def assign_params(socket, id, puzzle) do
    assign(socket, id: id, puzzle: puzzle)
  end

  def assign_board(%{assigns: %{puzzle: puzzle}} = socket) do
    board=
      puzzle
      |>String.to_existing_atom()
      |>Board.new()

    assign(socket, board: board)

  end

  def assign_shapes(%{assigns: %{board: board}} = socket) do
    shapes = Board.to_shapes(board)
    assign(socket, shapes: shapes)
  end

  def render(assigns) do
    ~H"""
    <div id={@id} phx-window-keydown="key" phx-target={@myself}>
      <.canvas view_box="0 0 200 70">
        <%= for shape <- @shapes do %>
          <.shape
            points={shape.points}
            fill={color(shape.color, Board.active?(@board, shape.name), false)}
            name={shape.name}
          />
        <% end %>
      </.canvas>
      <hr />
      <.palette
        shape_names={@board.palette}
        completed_shape_names={Enum.map(@board.completed_pentos, & &1.name)}
      />
    </div>
    """
  end

end
