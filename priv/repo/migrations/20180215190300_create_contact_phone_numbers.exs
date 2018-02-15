defmodule NestedChangesetExamples.Repo.Migrations.CreateContactPhoneNumbers do
  use Ecto.Migration

  use Ecto.Migration

  def change do
    create table(:contact_phone_numbers) do
      add(:number, :string)
      add(:contact_id, references(:contacts))

      timestamps()
    end
  end
end
