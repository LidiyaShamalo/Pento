defmodule PentoWeb.RatingLive.Index do
  use Phoenix.Component
  alias PentoWeb.RatingLive
  alias PentoWeb.RatingLive.Show


  attr :products, :list, required: true
  attr :current_scope, :map, required: true

  def list_products(assigns) do
    ~H"""
    <.heading products={@products} current_scope={@current_scope}/>
    <div class="divide-y">
      <.product_rating
      :for={{product, index} <- Enum.with_index(@products)}
      product={product}
      index={index}
      current_scope={@current_scope}/>
    </div>
    """
  end

  attr :products, :list, required: true
  attr :current_scope, :map, required: true

  def heading(assigns) do
    ~H"""
    <h2 class="flex justify-between">
      Ratings
      <%= if ratings_complete?(@products, @current_scope) do %>
        ✅
      <%end%>
    </h2>
    """
  end

  def ratings_complete?(products, current_scope) do
    Enum.all?(products, fn product ->
      Enum.any?(product.ratings, &(&1.user_id == current_scope.user.id))
    end)
  end

  def product_rating(assigns) do
    ~H"""
      <div><%= @product.name%></div>
      <%= if rating = List.first(@product.ratings) do %>
        <RatingLive.Show.stars rating={rating}/>
      <%else%>
        <div>
          <h3><%= @product.name %> rating form coming soon!</h3>
        </div>
      <% end %>
    """
  end

end
