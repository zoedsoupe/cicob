defmodule CicobWeb.FallbackController do
  @moduledoc false
  use CicobWeb, :controller

  alias CicobWeb.ErrorView

  @type conn :: Plug.Conn.t()

  @spec call(conn, any) :: conn
  def call(conn, nil) do
    call(conn, {:error, :not_found})
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ErrorView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, %Ecto.Changeset{} = changeset) do
    call(conn, {:error, changeset})
  end

  def call(conn, {:error, :forbidden}) do
    conn
    |> put_status(:forbidden)
    |> put_view(ErrorView)
    |> render("error.json", reason: "Access Denied")
  end

  def call(conn, {:error, :timeout}) do
    conn
    |> put_status(:request_timeout)
    |> put_view(ErrorView)
    |> render("error.json", reason: "Request timeout")
  end

  def call(conn, {:error, reason}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", reason: reason)
  end
end
