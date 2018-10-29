defmodule ChallengePlayerWeb.Router do
  use ChallengePlayerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ChallengePlayerWeb do
    pipe_through :api

    get "/checkout/free", CheckoutController, :free

  end
end
