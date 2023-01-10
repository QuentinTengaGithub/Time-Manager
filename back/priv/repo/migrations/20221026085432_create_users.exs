defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string
      add :lastname, :string
      add :email, :string
      add :position, :integer
      add :password, :string
      add :team, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
