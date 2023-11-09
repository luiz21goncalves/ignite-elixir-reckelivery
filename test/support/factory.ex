defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Faker.Address.PtBr, as: Address
  alias Faker.Person.PtBr, as: Person
  alias Faker.Random.Elixir, as: Random
  alias Rockelivery.Item
  alias Rockelivery.User

  def cep_factory do
    random_cep = Address.zip_code()

    String.replace(random_cep, ~r"\D", "")
  end

  def user_params_factory do
    %{
      "age" => Random.random_between(18, 99),
      "address" => Address.street_address(),
      "cep" => cep_factory(),
      "cpf" => "#{Random.random_between(11_111_111_111, 99_999_999_999)}",
      "email" => Faker.Internet.email(),
      "password" => Faker.String.base64(),
      "name" => Person.name()
    }
  end

  def user_factory do
    %User{
      age: Random.random_between(18, 99),
      address: Address.street_address(),
      cep: cep_factory(),
      cpf: "#{Random.random_between(11_111_111_111, 99_999_999_999)}",
      email: Faker.Internet.email(),
      password: Faker.String.base64(),
      name: Person.name()
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
      "description" => Faker.Lorem.sentence(),
      "price" => Faker.Commerce.price(),
      "photo" => Faker.Internet.image_url()
    }
  end

  def item_factory do
    category_list = [:food, :drink, :dessert]

    %Item{
      category: Enum.at(category_list, Random.random_between(0, 2)),
      description: Faker.Lorem.sentence(),
      photo: Faker.Internet.image_url(),
      price: Faker.Commerce.price()
    }
  end
end
