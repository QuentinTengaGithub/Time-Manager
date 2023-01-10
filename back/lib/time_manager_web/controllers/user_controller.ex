defmodule TimeManagerWeb.UserController do
  require Logger
  use TimeManagerWeb, :controller

  alias TimeManager.Store
  alias TimeManager.Store.User

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    users = Store.list_users()
    render(conn, "index.json", users: users)
  end

  def register(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Store.create_user(user_params) do
      conn
      |> put_status(:created)
      |> text("User succesfully registered with email :" <> " " <> user.email)
      |> render("show.json", user: user)
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Store.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    else
      unmatched ->
        IO.inspect(unmatched, label: "unmatched")
    end
  end

  def show(conn, %{"id" => id}) do
    user = Store.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def getMail(conn, %{"email" => email}) do
    user = Store.get_user_by_mail!(email)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Store.get_user!(id)

    with {:ok, %User{} = user} <- Store.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Store.get_user!(id)

    with {:ok, %User{}} <- Store.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
