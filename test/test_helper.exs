ExUnit.start()
Faker.start()
Ecto.Adapters.SQL.Sandbox.mode(Rockelivery.Repo, :manual)

Mox.defmock(Rockelivery.BrasilApi.ClientMock, for: Rockelivery.BrasilApi.Behavior)
