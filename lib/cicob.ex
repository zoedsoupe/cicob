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

  def service do
    quote do
      alias Cicob.Repo
    end
  end

  def repo do
    quote do
      alias Cicob.Repo
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
