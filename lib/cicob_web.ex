defmodule CicobWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use CicobWeb, :controller
      use CicobWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  import Ecto.Changeset, only: [cast: 3, validate_required: 2, apply_action: 2]

  def controller do
    quote do
      use Phoenix.Controller, namespace: CicobWeb

      import CicobWeb, only: [normalize: 2]
      import Plug.Conn
      alias CicobWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/cicob_web/templates",
        namespace: CicobWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  defp view_helpers do
    quote do
      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import CicobWeb.ErrorHelpers
      alias CicobWeb.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  def normalize(params, input_schema) do
    types =
      Enum.reduce(input_schema, %{}, fn
        {field, [type, _]}, acc ->
          Map.put(acc, field, type)
      end)

    required =
      Enum.reduce(input_schema, [], fn
        {field, [_type, required: true]}, acc -> [field | acc]
        _, acc -> acc
      end)

    fields = Map.keys(types)

    {%{}, types}
    |> cast(params, fields)
    |> validate_required(required)
    |> apply_action(:normalize)
  end
end
