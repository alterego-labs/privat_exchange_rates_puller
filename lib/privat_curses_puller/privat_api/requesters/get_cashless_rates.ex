defmodule PrivatCursesPuller.PrivatAPI.Requesters.GetCashlessRates do
  alias PrivatCursesPuller.PrivatAPI.CurseInfo, as: RatesInfo

  @api_url "https://api.privatbank.ua/p24api/pubinfo?exchange&json&coursid=11"

  @doc """
  Calls a requester
  """
  @spec call :: RatesInfo.t
  def call do
    @api_url
    |> do_http_request
    |> parse_response
    |> transform_response
  end

  defp do_http_request(url) do
    HTTPotion.get url
  end

  defp parse_response(%HTTPotion.Response{} = http_response) do
    {:ok, response_hash} = JSX.decode(http_response.body, [{:labels, :atom}])
    response_hash
  end

  defp transform_response(response_hash) do
    Enum.map(response_hash, fn(entry) -> 
      entry = convert_number_values(entry)
      struct(RatesInfo, entry)
    end)
  end

  defp convert_number_values(map) do
    old_buy = Map.get(map, :buy)
    old_sale = Map.get(map, :sale)
    map
    |> Map.put(:buy, String.to_float(old_buy))
    |> Map.put(:sale, String.to_float(old_sale))
  end
end
