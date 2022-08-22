defmodule CicobWeb.EmailView do
  def render("success.json", %{data: email}) do
    %{data: email}
  end
end
