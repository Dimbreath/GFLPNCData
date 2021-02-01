-- params : ...
-- function num : 0 , upvalues : _ENV
LuaGR = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

LuaGR.MsgCenterBroadcast = function(eventType, ...)
  -- function num : 0_0 , upvalues : _ENV
  MsgCenter:Broadcast(eventType, ...)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

LuaGR.RequireAndNew = function(name)
  -- function num : 0_1 , upvalues : _ENV
  return ((require(name)).New)()
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

LuaGR.CS_GM_GMOperation = function(id, param)
  -- function num : 0_2 , upvalues : _ENV
  local network = NetworkManager:GetNetwork(NetworkTypeID.GM)
  network:CS_GM_GMOperation(id, param)
end


