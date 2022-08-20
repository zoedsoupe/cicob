defmodule Cicob.Repo.Migrations.CreateCustomerEmail do
  use Ecto.Migration

  def change do
    create table("customer_emails") do
      add :email_id, references("emails"), null: false
      add :customer_id, references("customers"), null: false
    end
  end
end
