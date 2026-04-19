# mix run priv/repo/rating_seeds.exs
alias Pento.{Repo, Accounts, Survey}
alias Pento.Accounts.{User, Scope}
alias Pento.Survey.{Demographic, Rating}
alias Pento.Catalog.Product

users =
  for i <- 1..43 do
    case Accounts.register_user(%{email: "user#{i}@example.com", password: "passwordpassword"}) do
      {:ok, _user} -> :ok
      {:error, _changeset} -> :already_exists # Игнорируем ошибки, если уже создан
    end
  end

user_ids = Repo.all(User) |> Enum.map(& &1.id)
IO.puts "Найдено пользователей: #{length(user_ids)}"

product_ids = Repo.all(Product) |> Enum.map(& &1.id)
genders = ["male", "female", "other", "prefer not to say"]
years = 1950..2012 |> Enum.to_list()
stars = 1..5 |> Enum.to_list()

for user_id <- user_ids do
  scope = %Scope{user: %User{id: user_id}}
  gender = Enum.random(genders)
  year_of_birth = Enum.random(years)

  Survey.create_demographic(scope, %{
    gender: gender,
    year_of_birth: year_of_birth
  })
end

for uid <- user_ids, pid <- product_ids do
  scope = %Scope{user: %User{id: uid}}
  Survey.create_rating(scope, %{
    user_id: uid,
    product_id: pid,
    stars: Enum.random(stars)
  })
end
