defmodule PentoWeb.Admin.SurveyResultsLive do
  use PentoWeb, :live_component
  alias Pento.Catalog

  def update(assigns, socket) do
    {:ok,
    socket
    |> assign(assigns)
    |> assign_age_group_filter("all")
    |> assign_products_with_average_ratings()
    |> assign_dataset()
    |> assign_chart()
    |> assign_chart_svg()
    }
  end

  def assign_age_group_filter(socket, age_group) do
    socket
    |> assign(:age_group_filter, age_group)
  end

  def assign_products_with_average_ratings(
    %{assigns: %{ age_group_filter: age_group_filter}} =
    socket) do
      assign(
        socket,
        :products_with_average_ratings,
        Catalog.products_with_average_ratings(
          %{age_group_filter: age_group_filter}
        )
      )
      # |> assign(
      #   :products_with_average_ratings,
      #   Catalog.products_with_average_ratings()
      # )
  end

  def assign_dataset(
    %{assigns: %{
      products_with_average_ratings: products_with_average_ratings}
    } = socket) do
      socket
      |> assign(
        :dataset,
        make_bar_chat_dataset(products_with_average_ratings)
      )
    end

    defp make_bar_chat_dataset(data) do
      Contex.Dataset.new(data)
    end

    defp assign_chart(%{assigns: %{dataset: dataset}} = socket) do
      socket
      |> assign(:chart, make_bar_chart(dataset))
    end

    defp make_bar_chart(dataset) do
      Contex.BarChart.new(dataset)
    end

    def assign_chart_svg(%{assigns: %{chart: chart}} = socket) do
      socket
      |> assign(:chart_svg, render_bar_chart(chart))
    end

    defp render_bar_chart(chart) do
      Contex.Plot.new(500, 400, chart)
      |> Contex.Plot.titles(title(), subtitle())
      |> Contex.Plot.axis_labels(x_axis(), y_axis())
    end

    defp title do
      "ProductRatings"
    end

    defp subtitle do
      "averagestarratingsperproduct"
    end

    defp x_axis do
      "products"
    end

    defp y_axis do
      "stars"
    end

    def handle_event("age_group_filter", %{"age_group_filter" => age_group},
                      socket) do
      {:noreply,
        socket
        |> assign_age_group_filter(age_group)
        |> assign_products_with_average_ratings()
        |> assign_dataset()
        |> assign_chart()
        |> assign_chart_svg()
      }

    end

end
