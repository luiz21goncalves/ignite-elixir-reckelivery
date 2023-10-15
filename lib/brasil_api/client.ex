defmodule Rockelivery.BrasilApi.Client do
  use Tesla

  alias Rockelivery.Error
  alias Tesla.Env

  plug Tesla.Middleware.BaseUrl, "https://brasilapi.com.br/api/cep/v1/"
  plug Tesla.Middleware.JSON

  def get_cep_info(cep) do
    "#{cep}"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Env{status: 404, body: _body}}) do
    {:error, Error.build(:bad_request, "Invalid CEP.")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
