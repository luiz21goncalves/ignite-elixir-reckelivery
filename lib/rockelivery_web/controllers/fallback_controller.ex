defmodule RockeliveryWeb.FallbackController do
  use RockeliveryWeb, :controller

  alias RockeliveryWeb.ErrorJSON

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render("400.json", result: result)
  end
end
