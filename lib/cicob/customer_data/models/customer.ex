defmodule Cicob.CustomerData.Models.Customer do
  use Cicob, :model

  alias Cicob.CustomerData.Models

  schema "customers" do
    has_many :customer_emails, Models.CustomerEmail
    has_many :emails, through: [:customer_emails, :email]
  end
end
