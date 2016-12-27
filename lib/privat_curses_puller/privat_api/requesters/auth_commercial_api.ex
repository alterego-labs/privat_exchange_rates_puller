defmodule PrivatCursesPuller.PrivatAPI.Requesters.AuthCommercialApi do
  alias PrivatCursesPuller.PrivatAPI.AuthInfo

  import Inflex

  @api_url "https://link.privatbank.ua/api/auth/createSession"

  @doc """
  Calls a requester
  """
  @spec call(String.t, String.t) :: AuthInfo.t
  def call(client_id, client_secret) do
    @api_url
    |> do_http_request(client_id, client_secret)
    |> parse_response
    |> transform_response
  end

  defp do_http_request(url, client_id, client_secret) do
    post_body_hash = %{clientId: client_id, clientSecret: client_secret}
    {:ok, post_body_json} = JSX.encode(post_body_hash)
    HTTPotion.post url, [body: post_body_json, headers: ["Content-Type": "application/json"]]
  end

  defp parse_response(%HTTPotion.Response{} = http_response) do
    {:ok, response_hash} = JSX.decode(http_response.body, [{:labels, :atom}])
    response_hash
  end

  defp transform_response(response_hash) do
    correct_response_hash = for {key, val} <- response_hash, into: %{} do
      new_key = key |> underscore |> String.to_atom
      {new_key, val}
    end
    struct(AuthInfo, correct_response_hash)
  end
end
