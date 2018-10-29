defmodule ChallengePlayer.Repo.Migrations.CreateCheckouts do
  use Ecto.Migration

  def change do
    create table(:checkouts) do
      add :id, :integer

      timestamps()
    end

  end
end
