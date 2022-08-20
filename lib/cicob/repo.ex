defmodule Cicob.Repo do
  use Ecto.Repo,
    otp_app: :cicob,
    adapter: Ecto.Adapters.Postgres

  @type changeset :: Ecto.Changeset.t()

  @callback all(module) :: list(struct)
  @callback get(integer) :: {:ok, struct} | {:error, :not_found}
  @callback get_by(keyword) :: {:ok, struct} | {:error, :not_found}
  @callback insert(struct) :: {:ok, struct} | {:error, changeset}

  @optional_callbacks all: 1, get_by: 1

  def fetch(model, id) do
    case __MODULE__.get(model, id) do
      nil -> {:error, :not_found}
      model -> {:ok, model}
    end
  end
end
