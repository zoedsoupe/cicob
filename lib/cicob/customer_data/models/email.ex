defmodule Cicob.CustomerData.Models.Email do
  use Cicob, :model

  alias Cicob.CustomerData.Models

  schema "emails" do
    field :address, :string
    field :default, :boolean
    field :active, :boolean

    field :customer_id, :integer, virtual: true

    has_many :customer_emails, Models.CustomerEmail
  end
end
