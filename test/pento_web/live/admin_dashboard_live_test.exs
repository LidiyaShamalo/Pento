defmodule PentoWeb.AdminDashboardLiveTest do
  use PentoWeb.ConnCase

  import Phoenix.LiveViewTest
  alias Pento.{Accounts, Surveey, Catalog}

  @create_product_attrs %{
    description: "test description",
    name: "Test Game",
    sku: 42,
    unit_price: 120.5
  }

  @create_demogrephic_attrs %{
    gender: "female",
    year_of_birth: DateTime.utc_now().year - 15
  }

  @create_demogrephic_over_18_attrs %{
    gender: "male",
    year_of_birth: DateTime.utc_now().year - 30
  }

  @create_user_attrs%{ email: "test@test.com", password: "passwordpassword"}
  @create_user2_attrs%{ email: "test2@test.com", password: "passwordpassword"}
  @create_user3_attrs%{ email: "test3@test.com", password: "passwordpassword"}

  defp product_fixture(scope) do
    {:ok, product} = Catalog.create_product(scope, @create_product_attrs)
    product
  end

  defp user_fixture(attrs \\@create_user_attrs) do
    {:ok, user} = Accounts.register_user(attrs)
    user
  end

  defp demographic_fixture(scope, user, attrs) do
    attrs =
      attrs
      |> Map.merge(%{user_id: user.id})
    {:ok, demographic} = Survey.create_demographic(scope, attrs)
    demographic
  end

  defp rating_fixture(scope, stars, user, product) do
    {:ok, rating} =
      Survey.create_rating(scope, %{
        stars: stars,
        user_id: user.id,
        product_id: product.id
      })
      rating
  end

  defp create_product(%{scope: scope}) do
    product = product_fixture(scope)
    %{product: product}
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  defp create_demographic(scope, user, attrs \\@create_demogrephic_attrs) do
    demographic = demographic_fixture(scope, user, attrs)
    %{demographic: demographic}
  end

  defp create_rating(scope, stars, user, product) do
    rating = rating_fixture(scope, stars, user, product)
    %{rating: rating}
  end

end
