defmodule Cicob do
  @moduledoc false

  def model do
    quote do
      use Ecto.Schema

      @self __MODULE__

      def new(fields) do
        struct(@self, fields)
      end

      defimpl Jason.Encoder, for: @self do
        def encode(struct, opts) do
          Jason.Encode.map(struct, opts)
        end
      end
    end
  end

  def domain_service do
    quote do
      alias Cicob.Repo
    end
  end

  def application_service do
    quote do
      alias Cicob.Repo

      @behaviour Cicob.Service
    end
  end

  def repo do
    quote do
      import Ecto.Changeset
      import Ecto.Query

      alias Cicob.Repo

      @behaviour Cicob.Repo

      def update(%mod{} = model) do
        fields = mod.__schema__(:fields)
        values = Map.take(model, fields)

        mod
        |> struct(id: model.id)
        |> cast(values, fields)
        |> Repo.update()
      end
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
