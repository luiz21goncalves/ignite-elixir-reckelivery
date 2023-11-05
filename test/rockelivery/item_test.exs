defmodule Rockelivery.ItemTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.Item

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:item_params)

      response = Item.changeset(params)

      %{
        "category" => category,
        "description" => description,
        "photo" => photo,
        "price" => price
      } = params

      category_atoms = %{"food" => :food, "drink" => :drink, "dessert" => :dessert}
      category_atom = category_atoms[category]

      decimal_price = Decimal.from_float(price)

      assert %Changeset{
               changes: %{
                 category: ^category_atom,
                 description: ^description,
                 photo: ^photo,
                 price: ^decimal_price
               },
               valid?: true
             } = response
    end
  end
end
