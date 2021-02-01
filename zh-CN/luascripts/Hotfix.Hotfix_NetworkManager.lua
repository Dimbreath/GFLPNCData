-- params : ...
-- function num : 0 , upvalues : _ENV
local Hotfix_NetworkManager = class("Hotfix_NetworkManager", HotfixBase)
local ctype_SocketException = typeof((((CS.System).Net).Sockets).SocketException)
local OnTcpError = function(self, channel, err)
  -- function num : 0_0 , upvalues : ctype_SocketException, _ENV
  if err == nil then
    return 
  end
  if err:GetType() == ctype_SocketException then
    print("OnTcp SocketError:" .. err:ToString())
  else
    warn("OnTcpError:" .. err:ToString())
  end
end

Hotfix_NetworkManager.Register = function(self)
  -- function num : 0_1 , upvalues : _ENV, OnTcpError
  self:RegisterHotfix(CS.NetworkManager, "OnTcpError", OnTcpError)
end

return Hotfix_NetworkManager

