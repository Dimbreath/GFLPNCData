-- params : ...
-- function num : 0 , upvalues : _ENV
local GMNetworkCtrl = class("GMNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
GMNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.gmOperationTab = {}
end

GMNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_GM_GMOperation, self, proto_csmsg.SC_GM_GMOperation, self.SC_GM_GMOperation)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_GM_COMPLETE, self, proto_csmsg.SC_EXPLORATION_GM_COMPLETE, self.SC_EXPLORATION_GM_COMPLETE)
end

GMNetworkCtrl.CS_GM_GMOperation = function(self, id, param)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.gmOperationTab).id = id
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.gmOperationTab).param = param
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_GM_GMOperation, proto_csmsg.CS_GM_GMOperation, self.gmOperationTab)
end

GMNetworkCtrl.SC_GM_GMOperation = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "GMNetworkCtrl:SC_GM_GMOperation error:" .. tostring(msg.ret)
    print(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  else
    do
      print("GM Success")
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

GMNetworkCtrl.SC_EXPLORATION_GM_COMPLETE = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ExplorationManager:ExitExploration()
end

GMNetworkCtrl.Reset = function(self)
  -- function num : 0_5
end

return GMNetworkCtrl

