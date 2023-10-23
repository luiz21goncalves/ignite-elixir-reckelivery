defmodule Rockelivery.Users.GetTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.Error
  alias Rockelivery.User
  alias Rockelivery.Users.Get

  describe "by_id/1" do
    test "when finding the user, returns the user" do
      changeset = User.changeset(build(:user_params))
      {:ok, %User{id: user_id} = user} = Repo.insert(changeset)

      expected_response = {:ok, %{user | password: nil}}

      response = Get.by_id(user_id)

      assert response == expected_response
    end

    test "when not finding the user, return an error" do
      user_id = "f4133b95-d09d-4d41-a0d4-55b67f791f74"

      response = Get.by_id(user_id)

      expected_response = {:error, Error.build_user_not_found_error()}

      assert response == expected_response
    end
  end

  describe "by_email/1" do
    test "when finding the user, returns the user" do
      changeset = User.changeset(build(:user_params))
      {:ok, %User{email: email} = user} = Repo.insert(changeset)

      expected_response = {:ok, %{user | password: nil}}

      response = Get.by_email(email)

      assert response == expected_response
    end

    test "when not finding the user, return an error" do
      email = "not-found@email.com"

      response = Get.by_email(email)

      expected_response = {:error, Error.build_user_not_found_error()}

      assert response == expected_response
    end
  end
end
