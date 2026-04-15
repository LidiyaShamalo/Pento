# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pento.Repo.insert!(%Pento.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Pento.{Accounts, Catalog}

# Начальный пользователь
{:ok, user} = Accounts.register_user(%{
  email: "seed@example.com",
  password: "password123password123"
})

# # Если пользователь существует
# user = Accounts.get_user_by_email("seed@example.com")

# Область действия для пользователя
scope = Accounts.get_scope_for_user(user.id)

# Создание продуктов с использованием учетной области
products = [
  %{
    name: "Шахматы",
    description: "Классическая стратегическая игра",
    unit_price: 10.00,
    sku: 5678910
  },
    %{
    name: "Шашки",
    description: "Классическая настольная игра",
    unit_price: 8.00,
    sku: 1234567
  },
    %{
    name: "Настольная игра",
    description: "Древняя стратегическая игра",
    unit_price: 15.00,
    sku: 9876543
  }
]
Enum.each(products, fn product_attrs ->
  {:ok, product} = Catalog.create_product(scope, product_attrs)
  IO.puts("Созданный продукт: #{product.name}")
end)
