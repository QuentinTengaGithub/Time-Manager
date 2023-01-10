defmodule TimeManager.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
  opt_app: :time_manager,
  module: TimeManager.Guardian,
  error_handler: TimeManager.Guardian.AuthErrorHandler

  @claims %{typ: "access"}

  plug(Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer")
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource, ensure: true)
end
