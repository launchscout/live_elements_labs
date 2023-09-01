defmodule LiveElementsLabsWeb.AirportMapLive do
  use LiveElementsLabsWeb, :live_view

  use LiveElements.CustomElementsHelpers

  alias LiveElementsLabs.Airports

  custom_element :lit_google_map, events: [:bounds_changed, :tilesloaded]

  @impl true
  def mount(_params, _session, socket) do
    %{lng: lng, lat: lat} = Airports.locate_airport_by_indentifier("KMCO")
    {:ok,
     assign(socket,
       airports: [],
       api_key: System.get_env("API_KEY"),
       center_lat: lat,
       center_lng: lng
     )}
  end

  @impl true
  def handle_event("bounds_changed", event_payload, socket),
    do: load_airports(event_payload, socket)

  @impl true
  def handle_event("tilesloaded", event_payload, socket), do: load_airports(event_payload, socket)

  defp load_airports(
         %{"north" => north, "east" => east, "west" => west, "south" => south},
         socket
       ) do
    airports =
      Airports.list_airports_in_bounds(%{north: north, east: east, west: west, south: south})

    {:noreply, socket |> assign(airports: airports)}
  end
end
