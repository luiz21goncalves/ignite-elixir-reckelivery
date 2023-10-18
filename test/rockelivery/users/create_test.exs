defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.BrasilApi.ClientMock
  alias Rockelivery.Users.Create
  alias Rockelivery.{Error, User}

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response = Create.call(params)

      assert {:ok,
              %User{
                age: 25,
                address: "Rua das bananeiras, 15",
                cep: "12345678",
                cpf: "12345678901",
                email: "email@banana.com",
                password: "123456",
                name: "João das Bananeiras"
              }} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:user_params, %{"age" => 10, "password" => "123"})

      response = Create.call(params)

      expected_response = %{
        password: ["should be at least 6 character(s)"],
        age: ["must be greater than or equal to 18"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
