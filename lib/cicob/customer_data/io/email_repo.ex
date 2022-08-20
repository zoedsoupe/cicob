defmodule Cicob.CustomerData.IO.EmailRepo do
  use Cicob, :repo

  alias Cicob.CustomerData.Models.Email

  @fields Email.__schema__(:fields)

  @impl true
  def get(email_id) do
    Repo.fetch(Email, email_id)
  end

  @impl true
  def insert(%Email{} = email) do
    email
    |> cast(%{}, @fields)
    |> Repo.insert()
  end
end
