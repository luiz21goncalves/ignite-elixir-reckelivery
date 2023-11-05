defmodule Rockelivery.Users.GetTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.Error

  describe "by_id/1" do
    test "when finding the user, returns the user" do
      user = insert(:user)

      expected_response = {:ok, %{user | password: nil}}

      response = Rockelivery.get_user_by_id(user.id)

      assert response == expected_response
    end

    test "when not finding the user, return an error" do
      user_id = "f4133b95-d09d-4d41-a0d4-55b67f791f74"

      response = Rockelivery.get_user_by_id(user_id)

      expected_response = {:error, Error.build_user_not_found_error()}

      assert response == expected_response
    end
  end

  describe "by_email/1" do
    test "when finding the user, returns the user" do
      user = insert(:user)

      expected_response = {:ok, %{user | password: nil}}

      response = Rockelivery.get_user_by_email(user.email)

      assert response == expected_response
    end

    test "when not finding the user, return an error" do
      email = "not-found@email.com"

      response = Rockelivery.get_user_by_email(email)

      expected_response = {:error, Error.build_user_not_found_error()}

      assert response == expected_response
    end
  end
end
