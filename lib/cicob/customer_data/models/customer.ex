defmodule Cicob.CustomerData.Models.Customer do
  use Cicob, :model

  alias Cicob.CustomerData.Models

  schema "customers" do
    has_many :customer_emails, Models.CustomerEmail
  end
end
