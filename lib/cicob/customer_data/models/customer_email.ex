defmodule Cicob.CustomerData.Models.CustomerEmail do
  use Cicob, :model

  alias Cicob.CustomerData.Models

  schema "customer_emails" do
    belongs_to :email, Models.Email
    belongs_to :customer, Models.Customer
  end
end
