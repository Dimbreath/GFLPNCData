-- params : ...
-- function num : 0 , upvalues : _ENV
local CDKeyNetworkCtrl = class("CDKeyNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
CDKeyNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CDK_Redeem, self, proto_csmsg.SC_CDK_Redeem, self.MSG_SC_CDK_Redeem)
end

CDKeyNetworkCtrl.SendCDKRedeem = function(self, key)
  -- function num : 0_1 , upvalues : _ENV
  local tabMsg = {cdk = key}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_CDK_Redeem, proto_csmsg.CS_CDK_Redeem, tabMsg)
end

CDKeyNetworkCtrl.MSG_SC_CDK_Redeem = function(self, msg)
  -- function num : 0_2 , upvalues : _ENV, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    local heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    self:ShowCDKeyRewards(msg.rewards, heroIdSnapShoot)
    self:Try2ClearErrorCode()
  else
    do
      do
        if isGameDev then
          local err = "CDKeyNetworkCtrl:MSG_SC_CDK_Redeem Error Code" .. tostring(msg.ret)
          ;
          (cs_MessageCommon.ShowMessageTips)(err)
        end
        self:Try2ShowErrorCode(msg.ret)
      end
    end
  end
end

CDKeyNetworkCtrl.ShowCDKeyRewards = function(self, rewards, heroIdSnapShoot)
  -- function num : 0_3 , upvalues : _ENV
  local rewardIds = {}
  local rewardNums = {}
  for k,v in pairs(rewards) do
    (table.insert)(rewardIds, k)
    ;
    (table.insert)(rewardNums, v)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_3_0 , upvalues : rewardIds, rewardNums, heroIdSnapShoot
    if window == nil then
      return 
    end
    window:InitRewardsItem(rewardIds, rewardNums, heroIdSnapShoot)
  end
)
end

CDKeyNetworkCtrl.__Try2GetCDKeyPanelUI = function(self, errorCode)
  -- function num : 0_4 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.Setting)
  if win == nil or not win.active then
    return 
  end
  if win.cDKeyPanelNode == nil then
    return 
  end
  return win.cDKeyPanelNode
end

CDKeyNetworkCtrl.Try2ShowErrorCode = function(self, errorCode)
  -- function num : 0_5
  local cDKeyPanel = self:__Try2GetCDKeyPanelUI()
  if cDKeyPanel == nil then
    return 
  end
  cDKeyPanel:ShowErrorTips(errorCode)
end

CDKeyNetworkCtrl.Try2ClearErrorCode = function(self, errorCode)
  -- function num : 0_6
  local cDKeyPanel = self:__Try2GetCDKeyPanelUI()
  if cDKeyPanel == nil then
    return 
  end
  cDKeyPanel:RefreshText2Empty()
end

return CDKeyNetworkCtrl

