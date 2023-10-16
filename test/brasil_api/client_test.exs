defmodule Rockelivery.BrasilApi.ClientTest do
  use ExUnit.Case, async: true

  alias Plug.Conn
  alias Rockelivery.BrasilApi.Client
  alias Rockelivery.Error

  describe "get_cep_info/2" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid cep, returns the cep info", %{bypass: bypass} do
      cep = "01001000"

      url = endpoint_url(bypass.port)

      body = ~s({
        "cep": "01001000",
        "state": "SP",
        "city": "São Paulo",
        "neighborhood": "Sé",
        "street": "Praça da Sé",
        "service": "correios"
      })

      Bypass.expect_once(bypass, "GET", cep, fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_cep_info(url, cep)

      expected_response =
        {:ok,
         %{
           "cep" => "01001000",
           "city" => "São Paulo",
           "neighborhood" => "Sé",
           "service" => "correios",
           "state" => "SP",
           "street" => "Praça da Sé"
         }}

      assert response == expected_response
    end

    test "when the cep is invalid, returns an error", %{bypass: bypass} do
      cep = "00000000"

      url = endpoint_url(bypass.port)

      Bypass.expect_once(bypass, "GET", cep, fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(404, "")
      end)

      response = Client.get_cep_info(url, cep)

      expected_response = {:error, %Error{result: "Invalid CEP.", status: :bad_request}}

      assert response == expected_response
    end

    test "when there is a generic error, returns an error", %{bypass: bypass} do
      cep = "00000000"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_cep_info(url, cep)

      expected_response = {:error, %Error{result: :econnrefused, status: :bad_request}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
