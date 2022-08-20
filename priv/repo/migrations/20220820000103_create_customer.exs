defmodule Cicob.Repo.Migrations.CreateCustomer do
  use Ecto.Migration

  def change do
    create table("customers")
  end
end
