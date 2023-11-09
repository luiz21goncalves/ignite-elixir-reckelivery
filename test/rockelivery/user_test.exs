defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      %{
        "name" => name,
        "age" => age,
        "address" => address,
        "cep" => cep,
        "cpf" => cpf,
        "email" => email,
        "password" => password
      } = params

      assert %Changeset{
               changes: %{
                 name: ^name,
                 age: ^age,
                 address: ^address,
                 cep: ^cep,
                 cpf: ^cpf,
                 email: ^email,
                 password: ^password
               },
               valid?: true
             } = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:user_params)

      update_params = %{age: 27, name: "Bananinha"}

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      %{
        "address" => address,
        "cep" => cep,
        "cpf" => cpf,
        "email" => email,
        "password" => password
      } = params

      assert %Changeset{
               changes: %{
                 name: "Bananinha",
                 age: 27,
                 address: ^address,
                 cep: ^cep,
                 cpf: ^cpf,
                 email: ^email,
                 password: ^password
               },
               valid?: true
             } = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:user_params, %{"password" => "123", "age" => 15})

      response = User.changeset(params)

      expected_response = %{
        password: ["should be at least 6 character(s)"],
        age: ["must be greater than or equal to 18"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
