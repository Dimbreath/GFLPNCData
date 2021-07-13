-- params : ...
-- function num : 0 , upvalues : _ENV
local DebugNetworkCtrl = class("DebugNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
DebugNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.heroAttrTab = {}
end

DebugNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Debug_Attr, self, proto_csmsg.SC_HERO_Debug_Attr, self.SC_HERO_Debug_Attr)
end

DebugNetworkCtrl.CS_HERO_Debug_Attr = function(self, heroDic, callBack)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.heroAttrTab).hero = heroDic
  self.__HERO_Debug_Attr_callBack = callBack
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_Debug_Attr, proto_csmsg.CS_HERO_Debug_Attr, self.heroAttrTab)
end

DebugNetworkCtrl.SC_HERO_Debug_Attr = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  if self.__HERO_Debug_Attr_callBack ~= nil then
    (self.__HERO_Debug_Attr_callBack)(msg)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

DebugNetworkCtrl.Reset = function(self)
  -- function num : 0_4
end

return DebugNetworkCtrl

