defmodule TimeManager.Store.User do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type :id
  schema "users" do
    field :firstname, :string
    field :email, :string
    field :lastname, :string
    field :password, :string, virtual: true
    field :position, :integer
    field :team, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :position, :password])
    |> validate_required([:firstname, :lastname, :email, :position, :password])
  end

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :position, :password])
    |> validate_required([:firstname, :lastname, :email, :position, :password])
    |> unique_constraint(:email)
    |> encrypted_and_put_password()
  end

  defp encrypted_and_put_password(user) do
    with password <- fetch_field!(user, :password) do
      encrypted_password = Bcrypt.Base.hash_password(password, Bcrypt.gen_salt(12, true))
      put_change(user, :password, encrypted_password)
    end
  end


  # defp validate_email(changeset) do
  #   changeset
  #   |> validate_required([:email])
  #   |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
  #   |> validate_length(:email, max: 160)
  #   |> unsafe_validate_unique(:email, Cam.Repo)
  #   |> unique_constraint(:email)
  # end

  # defp validate_password(changeset, opts) do
  #   changeset
  #   |> validate_required([:password])
  #   |> validate_length(:password, min: 12, max: 80)
  #   # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
  #   # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
  #   # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
  #   |> maybe_hash_password(opts)
  # end

  # defp maybe_hash_password(changeset, opts) do
  #   hash_password? = Keyword.get(opts, :hash_password, true)
  #   password = get_change(changeset, :password)

  #   if hash_password? && password && changeset.valid? do
  #     changeset
  #     |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
  #     |> delete_change(:password)
  #   else
  #     changeset
  #   end
  # end
end
