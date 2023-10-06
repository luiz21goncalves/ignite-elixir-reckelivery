defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  alias Ecto.UUID

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = %{
        "age" => 25,
        "address" => "Rua das bananeiras, 15",
        "cep" => "12345678",
        "cpf" => "12345678901",
        "email" => "email@banana.com",
        "password" => "123456",
        "name" => "João das Bananeiras"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "user" => %{
                 "age" => 25,
                 "address" => "Rua das bananeiras, 15",
                 "cep" => "12345678",
                 "cpf" => "12345678901",
                 "email" => "email@banana.com",
                 "name" => "João das Bananeiras",
                 "id" => _id
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{"password" => "123456", "age" => 25}

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"],
          "name" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      user = insert(:user)

      response =
        conn |> delete(Routes.users_path(conn, :delete, user.id)) |> response(:no_content)

      assert response == ""
    end

    test "when there is no user, returns the error", %{conn: conn} do
      id = UUID.generate()

      response = conn |> delete(Routes.users_path(conn, :delete, id)) |> response(:not_found)

      {:ok, expected_response} = Jason.encode(%{message: "User not found."})

      assert response == expected_response
    end
  end
end
