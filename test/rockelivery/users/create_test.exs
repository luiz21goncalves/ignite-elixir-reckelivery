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

      %{
        "name" => name,
        "age" => age,
        "address" => address,
        "cep" => cep,
        "cpf" => cpf,
        "email" => email,
        "password" => password
      } = params

      assert {:ok,
              %User{
                age: ^age,
                address: ^address,
                cep: ^cep,
                cpf: ^cpf,
                email: ^email,
                password: ^password,
                name: ^name
              }} = response
    end

    test "when cep is invalid, returns an error" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:error, Error.build(:bad_request, "Invalid CEP.")}
      end)

      response = Create.call(params)

      expected_response = {:error, %Error{status: :bad_request, result: "Invalid CEP."}}

      assert expected_response == response
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
