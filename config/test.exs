use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nested_changeset_examples, NestedChangesetExamplesWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :nested_changeset_examples, NestedChangesetExamples.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "nested_changeset_examples_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
