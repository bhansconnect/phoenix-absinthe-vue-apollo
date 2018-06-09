defmodule WebsiteWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :website

  socket("/socket", WebsiteWeb.UserSocket)

  if Mix.env() == :dev do
    IO.puts("Running development, no gzip")

    plug(
      Plug.Static,
      at: "/",
      from: :website,
      gzip: false,
      only: ~w(css fonts images js favicon.ico robots.txt)
    )
  else
    IO.puts("Running production, gzip enabled. make sure to mix phx.digest")

    plug(
      Plug.Static,
      at: "/",
      from: :website,
      gzip: true,
      only: ~w(css fonts images js favicon.ico robots.txt)
    )
  end

  if code_reloading? do
    socket("/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket)
    plug(Phoenix.LiveReloader)
    plug(Phoenix.CodeReloader)
  end

  plug(Plug.Logger)

  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug(
    Plug.Session,
    store: :cookie,
    key: "_website_key",
    signing_salt: "kmAPPFf9"
  )

  plug(WebsiteWeb.Router)

  @doc """
  Callback invoked for dynamically configuring the endpoint.

  It receives the endpoint configuration and checks if
  configuration should be loaded from the system environment.
  """
  def init(_key, config) do
    if config[:load_from_system_env] do
      port = System.get_env("PORT") || raise "expected the PORT environment variable to be set"
      {:ok, Keyword.put(config, :http, [:inet6, port: port])}
    else
      {:ok, config}
    end
  end
end
