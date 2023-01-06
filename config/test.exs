import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bin_day_as_a_service, BinDayAsAServiceWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "6tCLe5kVTqcDlECIRFMEmbiUwf/FrvpYbRQaipUm7dg4hhTds0S5x7b4wOyzbKij",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
