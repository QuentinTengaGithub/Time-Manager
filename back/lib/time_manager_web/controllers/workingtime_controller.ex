defmodule TimeManagerWeb.WorkingtimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.Store
  alias TimeManager.Store.Workingtime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Store.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- Store.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    else
      unmatched ->
        IO.inspect(unmatched, label: "unmatched")
    end
  end

  def show(conn, %{"id" => id}) do
    workingtime = Store.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Store.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Store.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Store.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Store.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
