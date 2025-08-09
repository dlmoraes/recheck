defmodule Recheck.Services do
  import Ecto.Query, warn: false
  alias Recheck.Repo

  alias Recheck.Operations.Service

  def create_service(attrs \\ %{}) do
    %Service{}
    |> Service.changeset(attrs)
    |> Repo.insert()
  end

  def get_service!(id), do: Repo.get!(Service, id)

  def list_services do
    Repo.all(Service)
  end

  def update_service(%Service{} = service, attrs) do
    service
    |> Service.changeset(attrs)
    |> Repo.update()
  end

  def delete_service(%Service{} = service) do
    Repo.delete(service)
  end

  def list_unique_services do
    Repo.all(from s in Service, select: s.name, distinct: true)
  end
end
