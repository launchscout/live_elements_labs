defmodule LiveElementsLabsWeb.AirportMapLive do
  use LiveElementsLabsWeb, :live_view

  use LiveElements.CustomElementsHelpers

  alias LiveElementsLabs.Airports

  custom_element :lit_google_map, events: [:bounds_changed, :tilesloaded]

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, airports: [], api_key: System.get_env("API_KEY"))}
  end

  @impl true
  def handle_event(
        "bounds_changed",
        %{"north" => north, "east" => east, "west" => west, "south" => south},
        socket
      ) do
    airports =
      Airports.list_airports_in_bounds(%{north: north, east: east, west: west, south: south})

    {:noreply, socket |> assign(airports: airports)}
  end

  @impl true
  def handle_event(
        "tilesloaded",
        %{"north" => north, "east" => east, "west" => west, "south" => south},
        socket
      ) do
    IO.inspect("in tiles loaded")
    airports =
      Airports.list_airports_in_bounds(%{north: north, east: east, west: west, south: south})

    {:noreply, socket |> assign(airports: airports)}
  end
end
