# Foodtrunk

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Run `mix run priv/repo/seeds.exs` to seed the initial data
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

## Running tests
Setup the testing database:
```
  MIX_ENV=test mix ecto.create
  MIX_ENV=test mix ecto.migrate
```

Running tests:
```
  mix test
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
