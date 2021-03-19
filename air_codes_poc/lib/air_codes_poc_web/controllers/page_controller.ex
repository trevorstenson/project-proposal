defmodule AirCodesPocWeb.PageController do
  use AirCodesPocWeb, :controller

  def api_info() do
    %{
      BASE_URL: "https://test.api.amadeus.com/v1",
      API_KEY: "REDACTED",
      API_SECRET: "REDACTED",
      APT_LAT: 42.337420,
      APT_LONG: -71.085610,
      API_ENDPOINT: "/reference-data/locations/airports",
      TOKEN_ENDPOINT: "/security/oauth2/token",
    }
  end

  def index(conn, _params) do
    conn = check_token(conn)
    info = api_info()
    location = {info[:APT_LAT], info[:APT_LONG]}
    details = get_airports_in_range(conn, location, 100)

    render(conn, "index.html", airports: details)
  end

  def check_token(conn) do
    info = api_info()
    expiry = get_session(conn, :expiry)
    now = Time.utc_now()

    conn = if expiry != nil && Time.compare(now, expiry) == :lt do
      IO.puts "Valid"
      conn
    else
      IO.puts "Refresh"
      body = {
        :form,
        [{"grant_type", "client_credentials"}, {"client_id", info[:API_KEY]}, {"client_secret", info[:API_SECRET]}]
      }
      headers = [{"Content-Type", "x-www-form-urlencoded"}]
      {_, resp} = HTTPoison.post "#{info[:BASE_URL]}#{info[:TOKEN_ENDPOINT]}", body, headers
      {_, data} = Jason.decode(resp.body)

      new_token = data["access_token"]
      expires_in = data["expires_in"]

      new_expire = Time.add(now, expires_in)

      conn = conn
             |> put_session(:token, new_token)
             |> put_session(:expiry, new_expire)

      conn
    end

    conn
  end

  def get_airports_in_range(conn, location, search_radius) do
      token = get_session(conn, :token)
      info = api_info()
      {lat, long} = location;
      params = [
        {"latitude", lat},
        {"longitude", long},
        {"radius", search_radius},
        {"sort", "distance"}
      ]
      headers = [{"Authorization", "Bearer #{token}"}]

      {_, resp} = HTTPoison.get "#{info[:BASE_URL]}#{info[:API_ENDPOINT]}", headers, [{:params, params}]
      {_, data} = Jason.decode(resp.body)

      results = data["data"]

      airport_details = Enum.map(results, fn airport ->
      %{
        name: airport["name"],
        iata: airport["iataCode"],
        distance: "#{airport["distance"]["value"]} #{airport["distance"]["unit"]}"
      }
      end)

      airport_details
  end
end

