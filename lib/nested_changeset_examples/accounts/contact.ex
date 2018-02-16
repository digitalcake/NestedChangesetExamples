defmodule NestedChangesetExamples.Accounts.Contact do
  use Ecto.Schema
  import Ecto.Changeset
  alias NestedChangesetExamples.Accounts.Contact

  schema "contacts" do
    field(:description, :string)
    field(:name, :string)

    has_many(
      :phone_numbers,
      NestedChangesetExamples.Accounts.Contact.PhoneNumber,
      on_delete: :delete_all
    )

    timestamps()
  end

  @doc false
  def changeset_with_cast_assoc(%Contact{} = contact, attrs) do
    contact
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> cast_assoc(:phone_numbers)
  end

  @doc false

  def changeset(%Contact{} = contact, attrs) do
    contact
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
