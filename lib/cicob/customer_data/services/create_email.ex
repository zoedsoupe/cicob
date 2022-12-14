defmodule Cicob.CustomerData.Services.CreateEmail do
  use Cicob, :application_service

  alias Cicob.CustomerData.IO.CustomerEmailRepo
  alias Cicob.CustomerData.IO.CustomerRepo
  alias Cicob.CustomerData.IO.EmailRepo
  alias Cicob.CustomerData.Models.CustomerEmail
  alias Cicob.CustomerData.Models.Email
  alias Cicob.CustomerData.Services.EmailConstraint

  @impl true
  def process(params) do
    with %Email{} = email <- Email.new(params),
         {:ok, customer} <- CustomerRepo.get(email.customer_id),
         emails <- CustomerRepo.load_emails(customer) |> Map.get(:emails),
         :ok <- EmailConstraint.validate(params, emails),
         {:ok, new_email} <- EmailRepo.insert(email),
         %CustomerEmail{} = customer_email <-
           CustomerEmail.new(email_id: new_email.id, customer_id: email.customer_id),
         {:ok, _customer_email} <- CustomerEmailRepo.insert(customer_email) do
      {:ok, new_email}
    end
  end
end
