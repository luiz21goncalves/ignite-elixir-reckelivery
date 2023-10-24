defmodule Rockelivery.Users.DeleteTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.UUID
  alias Rockelivery.Error
  alias Rockelivery.User

  describe "call/1" do
    test "when a user exists, delete the user" do
      %User{id: id} = insert(:user)

      response = Rockelivery.delete_user(id)

      assert {:ok, _user} = response
    end

    test "when a user does not exist, returns an error" do
      user_id = UUID.generate()

      response = Rockelivery.delete_user(user_id)

      expected_response = {:error, %Error{status: :not_found, result: "User not found."}}

      assert expected_response == response
    end
  end
end
