defmodule NestedChangesetExamples.Accounts.Contact.PhoneNumber do
  use Ecto.Schema
  import Ecto.Changeset
  alias NestedChangesetExamples.Accounts.Contact.PhoneNumber

  schema "contact_phone_numbers" do
    field(:number, :string)
    belongs_to(:contact, NestedChangesetExamples.Accounts.Contact)
    timestamps()
  end

  @doc false
  def changeset(%PhoneNumber{} = phone_number, attrs) do
    phone_number
    |> cast(attrs, [:number])
    |> validate_required([:number])
  end
end
