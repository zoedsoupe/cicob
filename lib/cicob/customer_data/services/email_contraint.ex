defmodule Cicob.CustomerData.Services.EmailConstraint do
  use Cicob, :domain_service

  alias Cicob.CustomerData.IO.CustomerRepo

  def validate(attrs, id \\ nil) do
    with {:ok, :default} <- validate_default_rule(attrs, id),
         {:ok, :active} <- validate_active_rule(attrs, id),
         {:ok, :default_and_active} <- validate_active_and_default_rule(attrs) do
      :ok
    end
  end

  defp validate_default_rule(%{default: false} = attrs, id) do
    if has_default?(attrs.customer_id, id) do
      {:ok, :default}
    else
      {:error, :at_least_one_default_email}
    end
  end

  defp validate_default_rule(_attrs, nil), do: {:ok, :default}

  defp has_default?(customer_id, id) do
    {:ok, customer} = CustomerRepo.get(customer_id)

    customer
    |> CustomerRepo.load_emails()
    |> Map.get(:emails, [])
    |> Enum.filter(& &1.default)
    |> case do
      [] -> false
      data -> Enum.any?(data, &(&1.id == id))
    end
  end

  defp validate_active_rule(%{active: true} = attrs, nil) do
    {:ok, customer} = CustomerRepo.get(attrs.customer_id)

    customer
    |> CustomerRepo.load_emails()
    |> Map.get(:emails, [])
    |> Enum.filter(& &1.active)
    |> case do
      [] -> {:ok, :active}
      _ -> {:error, :already_has_active_email}
    end
  end

  defp validate_active_rule(%{active: false} = attrs, id) do
    if has_active?(attrs.customer_id, id) do
      {:ok, :active}
    else
      {:error, :at_least_one_active_email}
    end
  end

  defp validate_active_rule(_attrs, nil), do: {:ok, :active}

  defp has_active?(customer_id, id) do
    {:ok, customer} = CustomerRepo.get(customer_id)

    customer
    |> CustomerRepo.load_emails()
    |> Map.get(:emails, [])
    |> Enum.filter(& &1.active)
    |> case do
      [] -> false
      data -> Enum.any?(data, &(&1.id == id))
    end
  end

  defp validate_active_and_default_rule(attrs) do
    case attrs do
      %{active: false, default: true} -> {:error, :email_cant_be_desactivated}
      _attrs -> {:ok, :default_and_active}
    end
  end
end
