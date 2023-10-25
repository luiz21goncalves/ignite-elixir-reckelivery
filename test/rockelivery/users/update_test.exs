defmodule Rockelivery.Users.UpdateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.UUID
  alias Rockelivery.Error
  alias Rockelivery.User

  describe "call/1" do
    test "when all params are valid, update the user" do
      user = insert(:user)

      response =
        Rockelivery.update_user(%{
          "id" => user.id,
          "name" => "Jane Doe",
          "email" => "jane.doe@email.com",
          "age" => 32
        })

      assert {:ok,
              %User{
                id: _id,
                password: nil,
                address: "Rua das bananeiras, 15",
                cep: "12345678",
                cpf: "12345678901",
                email: "jane.doe@email.com",
                name: "Jane Doe",
                age: 32
              }} = response
    end

    test "when there are invalid params, returns an error" do
      response = Rockelivery.update_user(%{"id" => UUID.generate()})

      expected_response = {:error, %Error{status: :not_found, result: "User not found."}}

      assert expected_response == response
    end
  end
end
