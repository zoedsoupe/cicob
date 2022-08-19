import Config

config :cicob, Cicob.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "cicob_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cicob, CicobWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "1XCO2bfnWKhrXFOnhHbXo7In8GB/A+bnYB+P+tg04APMIr9ijvgCY6JDbxVRqK08",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
