-- params : ...
-- function num : 0 , upvalues : _ENV
local FriendshipNetworkCtrl = class("FriendshipNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
FriendshipNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

FriendshipNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_INTIMACY_Detail, self, proto_csmsg.SC_INTIMACY_Detail, self.SC_INTIMACY_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_INTIMACY_Presentation, self, proto_csmsg.SC_INTIMACY_Presentation, self.SC_INTIMACY_Presentation)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_INTIMACY_UpgradeLine, self, proto_csmsg.SC_INTIMACY_UpgradeLine, self.SC_INTIMACY_UpgradeLine)
end

FriendshipNetworkCtrl.CS_INTIMACY_Detail = function(self, isInitData)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_Detail, proto_csmsg.CS_INTIMACY_Detail, {})
  if isInitData then
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_Detail, function()
    -- function num : 0_2_0 , upvalues : _ENV
    (PlayerDataCenter.allFriendshipData):AddFriendshipgBonus()
    ;
    (PlayerDataCenter.allFriendshipData):AddFosterBonus()
  end
, proto_csmsg_MSG_ID.MSG_SC_INTIMACY_Detail)
  end
end

FriendshipNetworkCtrl.SC_INTIMACY_Detail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  (PlayerDataCenter.allFriendshipData):UpdateData(msg)
  MsgCenter:Broadcast(eMsgEventId.OnHeroFriendshipDataChange)
end

FriendshipNetworkCtrl.CS_INTIMACY_Presentation = function(self, heroId, giftsDic, callback, newLevel, newExp)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  self.msg = {}
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.msg).heroId = heroId
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.msg).data = giftsDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_Presentation, proto_csmsg.CS_INTIMACY_Presentation, self.msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_Presentation, function()
    -- function num : 0_4_0 , upvalues : _ENV, heroId, self, newExp, newLevel, callback
    if ((PlayerDataCenter.allFriendshipData).FriendshipDataList)[heroId] == nil then
      self:CS_INTIMACY_Detail()
    else
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (((PlayerDataCenter.allFriendshipData).FriendshipDataList)[heroId]).exp = newExp
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

      if newLevel ~= nil then
        (((PlayerDataCenter.allFriendshipData).FriendshipDataList)[heroId]).lv = newLevel
      end
    end
    MsgCenter:Broadcast(eMsgEventId.OnHeroFriendshipDataChange)
    ;
    (PlayerDataCenter.allFriendshipData):AddFriendshipgBonus()
    if callback ~= nil then
      callback()
    end
  end
, proto_csmsg_MSG_ID.MSG_SC_INTIMACY_Presentation)
end

FriendshipNetworkCtrl.SC_INTIMACY_Presentation = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FriendshipNetworkCtrl:OnRecvSendGift error:" .. tostring(msg.ret)
    print(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_Presentation)
  end
end

FriendshipNetworkCtrl.CS_INTIMACY_UpgradeLine = function(self, heroId, lineId, callback)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  self.msg = {}
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.msg).heroId = heroId
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.msg).lineId = lineId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_UpgradeLine, proto_csmsg.CS_INTIMACY_UpgradeLine, self.msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_UpgradeLine, function()
    -- function num : 0_6_0 , upvalues : _ENV, callback
    (PlayerDataCenter.allFriendshipData):AddFosterBonus()
    if callback ~= nil then
      callback()
    end
  end
, proto_csmsg_MSG_ID.MSG_SC_INTIMACY_UpgradeLine, proto_csmsg_MSG_ID.MSG_SC_INTIMACY_Detail)
end

FriendshipNetworkCtrl.SC_INTIMACY_UpgradeLine = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FriendshipNetworkCtrl:OnRecvUpgradeLine error:" .. tostring(msg.ret)
    print(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_UpgradeLine)
  else
    do
      ;
      (PlayerDataCenter.allFriendshipData):RemoveFosterBonus()
      self:CS_INTIMACY_Detail()
    end
  end
end

FriendshipNetworkCtrl.Reset = function(self)
  -- function num : 0_8
end

return FriendshipNetworkCtrl

