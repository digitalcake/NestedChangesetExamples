defmodule NestedChangesetExamplesWeb.ContactController do
  use NestedChangesetExamplesWeb, :controller

  alias NestedChangesetExamples.Accounts
  alias NestedChangesetExamples.Accounts.Contact

  def index(conn, _params) do
    contacts = Accounts.list_contacts()
    render(conn, "index.html", contacts: contacts)
  end

  def new(conn, _params) do
    changeset = Accounts.change_contact(%Contact{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"contact" => contact_params}) do
    case Accounts.create_contact(contact_params) do
      {:ok, contact} ->
        conn
        |> put_flash(:info, "Contact created successfully.")
        |> redirect(to: contact_path(conn, :show, contact))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    contact = Accounts.get_contact!(id)
    render(conn, "show.html", contact: contact)
  end

  def edit(conn, %{"id" => id}) do
    contact = Accounts.get_contact!(id)
    changeset = Accounts.change_contact(contact)
    render(conn, "edit.html", contact: contact, changeset: changeset)
  end

  def update(conn, %{"id" => id, "contact" => contact_params}) do
    contact = Accounts.get_contact!(id)

    case Accounts.update_contact(contact, contact_params) do
      {:ok, contact} ->
        conn
        |> put_flash(:info, "Contact updated successfully.")
        |> redirect(to: contact_path(conn, :show, contact))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", contact: contact, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    contact = Accounts.get_contact!(id)
    {:ok, _contact} = Accounts.delete_contact(contact)

    conn
    |> put_flash(:info, "Contact deleted successfully.")
    |> redirect(to: contact_path(conn, :index))
  end
end
