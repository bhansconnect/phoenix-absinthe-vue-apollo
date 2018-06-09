defmodule WebsiteWeb.Router do
  use WebsiteWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(Website.Context)
  end

  scope "/api" do
    pipe_through(:api)

    if Mix.env() == :dev do
      forward(
        "/graphiql",
        Absinthe.Plug.GraphiQL,
        schema: WebsiteWeb.Schema,
        analyze_complexity: true,
        max_complexity: 200
      )
    end

    forward("/", Absinthe.Plug, schema: WebsiteWeb.Schema)
  end

  scope "/", WebsiteWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebsiteWeb do
  #   pipe_through :api
  # end
end
