defmodule CicobWeb.ErrorView do
  use CicobWeb, :view

  def render("error.json", %{reason: reason}) do
    %{errors: %{detail: reason}}
  end

  def render("error.json", %{changeset: changeset}) do
    %{errors: %{detail: traverse_changeset_errors(changeset)}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal Server Error"}}
  end

  defp traverse_changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _matches, key ->
        opts
        |> Keyword.get(String.to_existing_atom(key), key)
        |> to_string()
      end)
    end)
  end

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
