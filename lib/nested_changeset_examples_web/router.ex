defmodule NestedChangesetExamplesWeb.Router do
  use NestedChangesetExamplesWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", NestedChangesetExamplesWeb do
    # Use the default browser stack
    pipe_through(:browser)
    resources("/contacts", ContactController)
    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", NestedChangesetExamplesWeb do
  #   pipe_through :api
  # end
end
