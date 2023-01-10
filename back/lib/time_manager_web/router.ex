defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router



  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TimeManagerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: [System.get_env("ORIGIN_DOMAIN")]
    plug :accepts, ["html","json","xml"]
  end

  pipeline :auth do
    plug TimeManager.Guardian.AuthPipeline
  end

  scope "/", TimeManagerWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/didi", PageController, :didi

  end

  scope "/api", TimeManagerWeb do
    pipe_through [:api, :auth]

    post "/session/refresh", SessionController, :refresh
    post "/session/delete", SessionController, :delete
  end
  scope "/api", TimeManagerWeb do
    pipe_through :api

    post "/users", UserController, :register
    post "/session/new", SessionController, :new


    # resources "/users", UserController, except: [:new, :edit]

    # scope "/users" do
    #   get    "/",    UserController, :index
    #   get    "/getbyId/:id", UserController, :show
    #   get    "/getbyMail/:email", UserController, :getMail
    #   post   "/", UserController, :register
    #   put    "/", UserController, :update
    #   delete "/:id", UserController, :delete
    # end
    # resources "/workingtimes", WorkingtimeController, except: [:new, :edit]
    scope "/workingtimes" do
      get "/", WorkingtimeController, :index
      get "/:user_id", WorkingtimeController, :show
      get "/:user_id/:id", WorkingtimeController, :show
      post "/:user_id", WorkingtimeController, :create
      put "/:id", WorkingtimeController, :update
      delete "/:id", WorkingtimeController, :delete
    end

    scope "/clocks" do
      get "/", ClockController, :index
      get "/:user_id", ClockController, :show
      post "/:user_id", ClockController, :create
      put "/:user_id", ClockController, :update
    end
  end
  # scope "/api", TimeManagerWeb do
  #   pipe_through [:api, :require_authenticated_user]

  #   get "/users/settings", UserSettingsController, :edit
  #   put "/users/settings", UserSettingsController, :update
  # end
end
