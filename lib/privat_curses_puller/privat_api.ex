defmodule PrivatCursesPuller.PrivatAPI do
  alias PrivatCursesPuller.PrivatAPI.{CurseInfo, AuthInfo}

  @spec get_cashless_curses :: [CurseInfo.t]
  def get_cashless_curses do
    
  end

  @spec auth_commercial_api(String.t, String.t) :: AuthInfo.t
  def auth_commercial_api(client_id, client_secret) do
    
  end

  @spec get_commercial_curses(String.t) :: [CurseInfo.t]
  def get_commercial_curses(token) do
    
  end
end
