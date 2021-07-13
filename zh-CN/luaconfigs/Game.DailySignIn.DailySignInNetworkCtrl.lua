-- params : ...
-- function num : 0 , upvalues : _ENV
local DailySignInNetworkCtrl = class("DailySignInNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
DailySignInNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

DailySignInNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MONTH_CARD_Detail, self, proto_csmsg.SC_MONTH_CARD_Detail, self.SC_MONTH_CARD_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MONTH_CARD_Changed_Ntf, self, proto_csmsg.SC_MONTH_CARD_Changed_Ntf, self.SC_MONTH_CARD_Changed_Ntf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MONTH_CARD_BUY, self, proto_csmsg.SC_MONTH_CARD_BUY, self.SC_MONTH_CARD_BUY)
end

DailySignInNetworkCtrl.CS_MONTH_CARD_BUY = function(self, id, callback)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {payId = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MONTH_CARD_BUY, proto_csmsg.CS_MONTH_CARD_BUY, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MONTH_CARD_BUY, callback, proto_csmsg_MSG_ID.MSG_SC_MONTH_CARD_BUY)
end

DailySignInNetworkCtrl.SC_MONTH_CARD_BUY = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_MONTH_CARD_BUY error:" .. tostring(msg.ret)
      error(errorMsg)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(errorMsg)
      end
    end
    local monthCard = (ConfigData.month_card)[1]
    local productId = monthCard.price
    local payCtr = ControllerManager:GetController(ControllerTypeId.Pay)
    payCtr:ReqPay(productId, 1)
  end
end

DailySignInNetworkCtrl.CS_MONTH_CARD_Detail = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MONTH_CARD_Detail, proto_csmsg.CS_MONTH_CARD_Detail, table.emptytable)
end

DailySignInNetworkCtrl.SC_MONTH_CARD_Detail = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV
  do
    if msg == nil then
      local errorMsg = "DailySignInNetworkCtrl:SC_MONTH_CARD_Detail error"
      error(errorMsg)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(errorMsg)
      end
    end
    if msg.data ~= nil and (msg.data).monthCards ~= nil then
      self:ApplyMonthCardDiff((msg.data).monthCards)
    end
  end
end

DailySignInNetworkCtrl.SC_MONTH_CARD_Changed_Ntf = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV
  if msg == nil then
    local errorMsg = "DailySignInNetworkCtrl:SC_MONTH_CARD_Changed_Ntf error"
    do
      error(errorMsg)
      if isGameDev then
        do
          ((CS.MessageCommon).ShowMessageTips)(errorMsg)
          -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if (msg.syncUpdateDiff).resource ~= nil and (((msg.syncUpdateDiff).resource).backpack).updates ~= nil then
    local firstBuyReward = {}
    local isHaveReard = nil
    for itemId,data in pairs((((msg.syncUpdateDiff).resource).backpack).updates) do
      local addNum = data.count - PlayerDataCenter:GetItemCount(itemId)
      if not firstBuyReward[itemId] then
        do
          firstBuyReward[itemId] = (addNum <= 0 or 0) + addNum
          isHaveReard = true
          -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    if isHaveReard then
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_6_0 , upvalues : _ENV, firstBuyReward
    if window == nil then
      return 
    end
    local rewardIds = {}
    local rewardNums = {}
    for id,num in pairs(firstBuyReward) do
      (table.insert)(rewardIds, id)
      ;
      (table.insert)(rewardNums, num)
    end
    window:InitRewardsItem(rewardIds, rewardNums)
    window:InitRewardTitle("月卡购买奖励")
  end
)
    end
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

DailySignInNetworkCtrl.ApplyMonthCardDiff = function(self, diffMsgDic)
  -- function num : 0_7 , upvalues : _ENV
  (PlayerDataCenter.dailySignInData):UpadteMonthCardData(diffMsgDic)
end

DailySignInNetworkCtrl.Reset = function(self)
  -- function num : 0_8
end

return DailySignInNetworkCtrl

