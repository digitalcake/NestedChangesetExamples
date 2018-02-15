# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :nested_changeset_examples,
  ecto_repos: [NestedChangesetExamples.Repo]

# Configures the endpoint
config :nested_changeset_examples, NestedChangesetExamplesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/le1MDrlbT/MZBxnDU9jg7RstZ9X3mWVoapyH1R794miBhHjUFCNR1I2kmOzGlis",
  render_errors: [view: NestedChangesetExamplesWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NestedChangesetExamples.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
