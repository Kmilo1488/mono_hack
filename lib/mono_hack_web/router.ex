defmodule MonoHackWeb.Router do
  use MonoHackWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MonoHackWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

  end

  scope "/", MonoHackWeb do
    pipe_through :browser

    live "/transactions", TransactionLive, :index

    # live "/", PageLive, :index
    resources "/", CustomerController, only: [:index, :new, :show, :create] do
      post "/balance", CustomerController, :add_balance
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", MonoHackWeb do
    pipe_through :api

    resources "/transaction", TransactionController, only: [:create, :show]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: MonoHackWeb.Telemetry
    end
  end
end
