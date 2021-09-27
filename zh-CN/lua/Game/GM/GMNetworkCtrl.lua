local GMNetworkCtrl = class("GMNetworkCtrl", NetworkCtrlBase)
GMNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.gmOperationTab = {}
end

GMNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_GM_GMOperation, self, proto_csmsg.SC_GM_GMOperation, self.SC_GM_GMOperation)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_GM_COMPLETE, self, proto_csmsg.SC_EXPLORATION_GM_COMPLETE, self.SC_EXPLORATION_GM_COMPLETE)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_GM_ShieldGuide, self, proto_csmsg.SC_GM_ShieldGuide, self.SC_GM_ShieldGuide)
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
  -- function num : 0_3 , upvalues : _ENV
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "GMNetworkCtrl:SC_GM_GMOperation error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  else
    do
      print("GM Success")
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

GMNetworkCtrl.SC_EXPLORATION_GM_COMPLETE = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  ExplorationManager:ExitExploration(nil, nil, true)
end

GMNetworkCtrl.SC_GM_ShieldGuide = function(self)
  -- function num : 0_5 , upvalues : _ENV
  GuideManager:SetGMSkipGuide(true)
  GuideManager:SkipGuide()
end

GMNetworkCtrl.Reset = function(self)
  -- function num : 0_6
end

return GMNetworkCtrl

