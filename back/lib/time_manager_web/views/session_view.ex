defmodule TimeManagerWeb.SessionView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.SessionView

  def render("token.json", %{access_token: access_token}) do
    %{access_token: access_token}
  end
end
