defmodule NestedChangesetExamples.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :name, :string
      add :description, :text

      timestamps()
    end

  end
end
