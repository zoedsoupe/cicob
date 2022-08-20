defmodule Cicob.Service do
  @callback process(keyword) :: {:ok, term} | {:error, term}
end
