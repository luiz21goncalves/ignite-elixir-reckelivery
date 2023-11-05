defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Faker.Random.Elixir, as: Random
  alias Rockelivery.User

  def user_params_factory do
    %{
      "age" => 25,
      "address" => "Rua das bananeiras, 15",
      "cep" => "12345678",
      "cpf" => "12345678901",
      "email" => "email@banana.com",
      "password" => "123456",
      "name" => "João das Bananeiras"
    }
  end

  def user_factory do
    %User{
      age: 25,
      address: "Rua das bananeiras, 15",
      cep: "12345678",
      cpf: "12345678901",
      email: "email@banana.com",
      password: "123456",
      name: "João das Bananeiras"
    }
  end

  def cep_info_factory do
    %{
      "cep" => "01001000",
      "city" => "São Paulo",
      "neighborhood" => "Sé",
      "service" => "correios",
      "state" => "SP",
      "street" => "Praça da Sé"
    }
  end

  def item_params_factory do
    category_list = ["food", "drink", "dessert"]

    %{
      "category" => Enum.at(category_list, Random.random_between(0, 2)),
      "description" => Faker.Lorem.paragraph(),
      "price" => Faker.Commerce.price(),
      "photo" => Faker.Internet.image_url()
    }
  end
end
