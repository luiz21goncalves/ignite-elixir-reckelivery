defmodule Rockelivery.BrasilApi.Behavior do
  alias Rockelivery.Error

  @typep client_result :: {:ok, map()} | {:error, Error.t()}

  @callback get_cep_info(String.t()) :: client_result

  @callback get_cep_info(String.t(), String.t()) :: client_result
end
