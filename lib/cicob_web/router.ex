defmodule CicobWeb.Router do
  use CicobWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CicobWeb do
    pipe_through :api

    scope "/customers/:customer_id" do
      resources "/emails", EmailController, only: [:create]
    end
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: CicobWeb.Telemetry
    end
  end
end
