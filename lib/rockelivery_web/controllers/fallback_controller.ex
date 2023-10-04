defmodule RockeliveryWeb.FallbackController do
  use RockeliveryWeb, :controller

  alias Rockelivery.Error
  alias RockeliveryWeb.ErrorJSON

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(json: ErrorJSON)
    |> render("error.json", result: result)
  end
end
