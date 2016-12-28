defmodule PrivatCursesPuller.PrivatAPI.Requesters.GetCommercialRates do
  alias PrivatCursesPuller.PrivatAPI.CurseInfo, as: RatesInfo

  @api_url "https://link.privatbank.ua/api/kursValut?exchange=true&coursid=3"

  @spec call(String.t) :: [RatesInfo.t]
  def call(token) do
    @api_url
    |> do_http_request(token)
    |> parse_response
    |> transform_response
  end

  defp do_http_request(url, token) do
    headers = ["Accept": "application/json", "Authorization": "Token #{token}"]
    HTTPotion.post url, [headers: headers]
  end

  defp parse_response(%HTTPotion.Response{} = http_response) do
    {:ok, response_hash} = JSX.decode(http_response.body)
    response_hash
  end

  defp transform_response(response_hash) do
    Enum.map(response_hash, fn(entry) -> 
      struct_map = entry
                    |> Map.get("exchangerate")
                    |> normalize_keys
      struct_map = convert_number_values(struct_map)
      struct(RatesInfo, struct_map)
    end)
  end

  defp normalize_keys(map) do
    for {key, val} <- map, into: %{} do
      normal_key = key
                    |> String.replace("@", "")
                    |> String.to_atom
      {normal_key, val}
    end
  end

  defp convert_number_values(map) do
    old_buy = Map.get(map, :buy)
    old_sale = Map.get(map, :sale)
    map
    |> Map.put(:buy, String.to_float(old_buy))
    |> Map.put(:same, String.to_float(old_sale))
  end
end
