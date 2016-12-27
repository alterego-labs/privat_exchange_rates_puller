defmodule PrivatCursesPuller.PrivatAPI.Requesters.AuthCommercialApiTest do
  use ExUnit.Case, async: false

  import Mock

  alias PrivatCursesPuller.PrivatAPI.Requesters.AuthCommercialApi
  alias PrivatCursesPuller.PrivatAPI.AuthInfo

  @ok_response "{\"id\":\"ba90565a-878d-4ec1-baa5-3ba8c2b94290\",\"clientId\":\"9917120e-e5a6-4489-94c5-dceeeaa8a5cd\",\"expiresIn\":1486472955,\"roles\":[\"ROLE_CLIENT\"]}"

  @tag :wip
  test "returns proper list of rates infos when a response is ok" do
    with_mock HTTPotion, [post: fn(_url, _opts) -> %HTTPotion.Response{body: @ok_response} end] do
      auth_info = AuthCommercialApi.call("client_id", "client_secret")
      assert %AuthInfo{} = auth_info
      assert auth_info.client_id == "9917120e-e5a6-4489-94c5-dceeeaa8a5cd"
      assert auth_info.expires_in == 1486472955
    end 
  end
end

