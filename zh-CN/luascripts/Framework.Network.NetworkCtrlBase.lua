-- params : ...
-- function num : 0 , upvalues : _ENV
local NetworkCtrlBase = class("NetworkCtrlBase")
local pb = require("pb")
local pb_slice = require("pb.slice")
local traceback = debug.traceback
NetworkCtrlBase.ctor = function(self)
  -- function num : 0_0
end

NetworkCtrlBase.InitNetwork = function(self)
  -- function num : 0_1
end

local DecodeMsg = function(protoName, msgData)
  -- function num : 0_2 , upvalues : pb, pb_slice
  local msg = (pb.decode)(protoName, (pb_slice.new)(msgData.RawData, 1, msgData.RawDataLen))
  return msg
end

NetworkCtrlBase.RegisterNetwork = function(self, cmdId, tab, protoName, func)
  -- function num : 0_3 , upvalues : _ENV, DecodeMsg, traceback
  local cb = function(msgData)
    -- function num : 0_3_0 , upvalues : _ENV, DecodeMsg, traceback, protoName, cmdId, func, tab
    local status, msg = xpcall(DecodeMsg, traceback, protoName, msgData)
    if status then
      if (GR.IsOpenNetworkMsgLog)() then
        print("lua RecvMsg,[" .. tostring(cmdId) .. "]:" .. (serpent.block)(msg))
      end
      func(tab, msg)
    else
      error(msg)
      error("客户端和服务器当前的通信协议不匹配，请更新客户端或者更新服务器！")
    end
  end

  NetworkManager:RegisterListener(cmdId, cb)
end

NetworkCtrlBase.UnRegisterNetwork = function(self, cmdId)
  -- function num : 0_4 , upvalues : _ENV
  NetworkManager:UnRegisterListener(cmdId)
end

NetworkCtrlBase.SendMsg = function(self, cmdId, protoName, tabMsg)
  -- function num : 0_5 , upvalues : pb, _ENV
  local msgContent = (pb.encode)(protoName, tabMsg)
  NetworkManager:SendMsg(cmdId, msgContent)
  if (GR.IsOpenNetworkMsgLog)() then
    print("lua SendMsg,[" .. tostring(cmdId) .. "]:" .. (serpent.block)(tabMsg))
  end
end

NetworkCtrlBase.Reset = function(self)
  -- function num : 0_6
end

NetworkCtrlBase.OnDelete = function(self)
  -- function num : 0_7
  self:UnRegisterNetwork()
end

return NetworkCtrlBase

