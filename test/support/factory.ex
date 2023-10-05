defmodule Rockelivery.Factory do
  use ExMachina

  def user_params_factory do
    %{
      age: 25,
      address: "Rua das bananeiras, 15",
      cep: "12345678",
      cpf: "12345678901",
      email: "email@banana.com",
      password: "123456",
      name: "João das Bananeiras"
    }
  end
end
