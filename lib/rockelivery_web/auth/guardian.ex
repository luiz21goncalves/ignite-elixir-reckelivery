defmodule RockeliveryWeb.Auth.Guardian do
  use Guardian, otp_app: :rockelivery

  alias Rockelivery.Error
  alias Rockelivery.User

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(%{"sub" => id}) do
    Rockelivery.get_user_by_id(id)
  end

  def authenticate(%{"email" => email, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- Rockelivery.get_user_by_email(email),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      _ -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}
end
