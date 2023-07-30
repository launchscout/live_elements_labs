defmodule LiveElementsLabs.Repo do
  use Ecto.Repo,
    otp_app: :live_elements_labs,
    adapter: Ecto.Adapters.Postgres
end
