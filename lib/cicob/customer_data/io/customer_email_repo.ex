defmodule Cicob.CustomerData.IO.CustomerEmailRepo do
  use Cicob, :repo

  alias Cicob.CustomerData.Models.CustomerEmail

  @fields CustomerEmail.__schema__(:fields)

  @impl true
  def get(customer_email_id) do
    Repo.fetch(CustomerEmail, customer_email_id)
  end

  @impl true
  def insert(%CustomerEmail{} = customer_email) do
    customer_email
    |> cast(%{}, @fields)
    |> Repo.insert()
  end
end
