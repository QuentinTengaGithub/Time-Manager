defmodule TimeManager.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :start, :naive_datetime
      add :end, :naive_datetime
      add :user, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:workingtimes, [:user])
  end
end
