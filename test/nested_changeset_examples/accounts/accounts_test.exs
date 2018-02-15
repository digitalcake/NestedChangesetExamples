defmodule NestedChangesetExamples.AccountsTest do
  use NestedChangesetExamples.DataCase

  alias NestedChangesetExamples.Accounts

  describe "contacts" do
    alias NestedChangesetExamples.Accounts.Contact

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def contact_fixture(attrs \\ %{}) do
      {:ok, contact} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_contact()

      contact
    end

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert Accounts.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Accounts.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      assert {:ok, %Contact{} = contact} = Accounts.create_contact(@valid_attrs)
      assert contact.description == "some description"
      assert contact.name == "some name"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      assert {:ok, contact} = Accounts.update_contact(contact, @update_attrs)
      assert %Contact{} = contact
      assert contact.description == "some updated description"
      assert contact.name == "some updated name"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_contact(contact, @invalid_attrs)
      assert contact == Accounts.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Accounts.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Accounts.change_contact(contact)
    end
  end
end
