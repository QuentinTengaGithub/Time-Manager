defmodule TimeManagerWeb.PageController do
  use TimeManagerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def didi(conn, _params) do
    json(conn, %{didi: "didi"})
  end
end
