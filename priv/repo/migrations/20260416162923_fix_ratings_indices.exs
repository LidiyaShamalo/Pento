defmodule Pento.Repo.Migrations.FixRatingsIndices do
  use Ecto.Migration

  def change do
    # Удаляем старые неправильные индексы
    drop unique_index(:ratings, [:user_id])
    drop unique_index(:ratings, [:product_id])

    # Добавляем один правильный составной индекс
    create unique_index(:ratings, [:user_id, :product_id])
  end
end
