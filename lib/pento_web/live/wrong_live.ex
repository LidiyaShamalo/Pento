defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    user = socket.assigns.current_scope.user
    num_guess = Enum.random(1..10)
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Сделайте предположение:",
        num_guess: num_guess,
        current_user: user
        )}

  end

  def render(assigns) do
    ~H"""
    <main class="px-4 py-20 sm:px-6 lg:px-8">
    <h1 class="mb-4 text-4xl font-extrabold">Your score: {@score}</h1>
    <h2>
      {@message}
    </h2>
    <br />
    <h2>
      <%= for n <- 1..10 do %>
        <.link
          class="btn btn-secondary"
          phx-click="guess"
          phx-value-number={n}
        >
          {n}
        </.link>
      <% end %>
    </h2>
    <h2>
      {@current_user.email}
    </h2>
    </main>
    """
  end


  def handle_event("guess", %{"number" => guess}, socket) do
    guess_int = String.to_integer(guess)
    if socket.assigns.num_guess == guess_int do
      message = "Your guess: #{guess}. Hooray! You guessed it!"
      score = socket.assigns.score + 1

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score,
          num_guess: Enum.random(1..10)
        )
      }
    else
      message = "Your guess: #{guess}. Wrong. Guess again"
      score = socket.assigns.score - 1

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score,
          num_guess: Enum.random(1..310)
        )
      }
    end
  end
end
