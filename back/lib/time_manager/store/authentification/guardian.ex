defmodule TimeManager.Guardian do
  use Guardian, opt_app: :time_manager
  alias TimeManager.Store

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def ressource_from_claims(claims) do
    id = claims["sub"]
    resource = Account.get_by_id!(id)
    {:ok, resource}
  end
end
