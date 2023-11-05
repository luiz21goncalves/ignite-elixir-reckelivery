defmodule Rockelivery.Items.CreateTest do
  alias Rockelivery.Error
  alias Rockelivery.Item
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.Items.Create

  describe "call/1" do
    test "when all params are valid, returns the item" do
      params = build(:item_params)

      response = Create.call(params)

      %{
        "category" => category,
        "description" => description,
        "photo" => photo,
        "price" => price
      } = params

      category_atoms = %{"food" => :food, "drink" => :drink, "dessert" => :dessert}
      category_atom = category_atoms[category]

      decimal_price = Decimal.from_float(price)

      assert {:ok,
              %Item{
                id: _id,
                category: ^category_atom,
                description: ^description,
                photo: ^photo,
                price: ^decimal_price,
                inserted_at: _inserted_at,
                updated_at: _updated_at
              }} = response
    end

    test "when there are invalid params, returns an error" do
      params =
        build(:item_params, %{
          "category" => "invalid_category",
          "description" => "123",
          "price" => -1
        })

      response = Create.call(params)

      expected_response = %{
        description: ["should be at least 6 character(s)"],
        category: ["is invalid"],
        price: ["must be greater than 0"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
