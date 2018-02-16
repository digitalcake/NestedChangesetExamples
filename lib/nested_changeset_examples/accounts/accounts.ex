defmodule NestedChangesetExamples.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Multi

  alias NestedChangesetExamples.Repo

  alias NestedChangesetExamples.Accounts.Contact
  alias NestedChangesetExamples.Accounts.Contact.PhoneNumber

  @doc """
  Returns the list of contacts.

  ## Examples

      iex> list_contacts()
      [%Contact{}, ...]

  """
  def list_contacts do
    Repo.all(Contact)
  end

  @doc """
  Gets a single contact.

  Raises `Ecto.NoResultsError` if the Contact does not exist.

  ## Examples

      iex> get_contact!(123)
      %Contact{}

      iex> get_contact!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contact!(id), do: Repo.get!(Contact, id)

  @doc """
  Creates a contact.

  ## Examples

      iex> create_contact(%{field: value})
      {:ok, %Contact{}}

      iex> create_contact(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contact_with_cast_assoc(attrs) do
    %Contact{}
    |> Contact.changeset_with_cast_assoc(attrs)
    |> Repo.insert()
  end

  def create_contact_ecto_multi(attrs) do
    contact_cs = Contact.changeset(%Contact{}, attrs)

    Ecto.Multi.new()
    |> Ecto.Multi.insert(:contact, contact_cs)
    |> Ecto.Multi.merge(fn %{contact: contact} ->
      phone_numbers = attrs[:phone_numbers] || []

      phone_numbers
      |> Enum.with_index()
      |> Enum.reduce(Multi.new(), fn {params, index}, multi_accumulator ->
        multi_accumulator
        |> Multi.run({:phone_numer, index}, fn _ ->
          phone_attrs = Map.merge(params, %{contact_id: contact.id})
          phone_cs = PhoneNumber.changeset(%PhoneNumber{}, phone_attrs)

          Repo.insert(phone_cs)
        end)
      end)
    end)
    |> Repo.transaction()
  end

  @doc """
  Updates a contact.

  ## Examples

      iex> update_contact(contact, %{field: new_value})
      {:ok, %Contact{}}

      iex> update_contact(contact, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contact(%Contact{} = contact, attrs) do
    contact
    |> Contact.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Contact.

  ## Examples

      iex> delete_contact(contact)
      {:ok, %Contact{}}

      iex> delete_contact(contact)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contact(%Contact{} = contact) do
    Repo.delete(contact)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contact changes.

  ## Examples

      iex> change_contact(contact)
      %Ecto.Changeset{source: %Contact{}}

  """
  def change_contact(%Contact{} = contact) do
    Contact.changeset(contact, %{})
  end
end
