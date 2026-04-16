defmodule PentoWeb.DemographicLive.Form do
  use PentoWeb, :live_component
  alias Pento.Survey
  alias Pento.Survey.Demographic

  @impl true
  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign_demographic()
      |> clear_form()

      {:ok, socket}
  end

  defp assign_demographic(
    %{assigns: %{current_scope: current_scope}} = socket
  ) do
    assign(
      socket,
      :demographic,
      %Demographic{user_id: current_scope.user.id}
      )
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp clear_form(%{assigns: %{demographic: demographic}} = socket) do
    current_scope = socket.assigns.current_scope
    changeset = Survey.change_demographic(current_scope, demographic)
    assign_form(socket, changeset)
  end
  
end
