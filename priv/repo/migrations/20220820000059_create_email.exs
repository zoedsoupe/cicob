defmodule Cicob.Repo.Migrations.CreateEmail do
  use Ecto.Migration

  def change do
    create table("emails") do
      add :address, :string, null: false
      add :default, :boolean, null: false
      add :active, :boolean, null: false
    end
  end
end
