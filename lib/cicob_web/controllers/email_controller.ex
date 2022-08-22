defmodule CicobWeb.EmailController do
  use CicobWeb, :controller

  alias Cicob.CustomerData.Services.CreateEmail

  action_fallback CicobWeb.FallbackController

  defp create_schema do
    [
      address: [:string, required: true],
      default: [:boolean, required: true],
      active: [:boolean, required: true],
      customer_id: [:integer, required: true]
    ]
  end

  def create(conn, params) do
    with {:ok, params} <- normalize(params, create_schema()),
         {:ok, email} <- CreateEmail.process(params) do
      render(conn, "success.json", data: email)
    end
  end
end
