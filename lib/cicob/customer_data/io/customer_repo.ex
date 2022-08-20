defmodule Cicob.CustomerData.IO.CustomerRepo do
  use Cicob, :repo

  alias Cicob.CustomerData.Models.Customer

  @fields Customer.__schema__(:fields)

  @impl true
  def get(customer_id) do
    Repo.fetch(Customer, customer_id)
  end

  @impl true
  def insert(%Customer{} = customer) do
    customer
    |> cast(%{}, @fields)
    |> Repo.insert()
  end

  def load_emails(%Customer{} = customer) do
    Repo.preload(customer, :emails)
  end
end
