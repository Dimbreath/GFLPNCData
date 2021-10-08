local BattlePassController = class("BattlePassController", ControllerBase)
local base = ControllerBase
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local eActivityState = ActivityFrameEnum.eActivityState
BattlePassController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.network = NetworkManager:GetNetwork(NetworkTypeID.BattlePass)
end

BattlePassController.__IsBattlePassFinished = function(self, passId)
  -- function num : 0_1 , upvalues : _ENV
  local passInfo = ((PlayerDataCenter.battlepassData).passInfos)[passId]
  do
    if passInfo == nil or not passInfo:IsBattlePassValid() then
      local showingWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
      showingWindow:ShowTextBoxWithConfirm(ConfigData:GetTipContent(323), function()
    -- function num : 0_1_0 , upvalues : _ENV
    if UIManager:GetWindow(UIWindowTypeID.EventBattlePass) ~= nil then
      (UIUtil.ReturnHome)()
    end
  end
)
      return true
    end
    return false
  end
end

BattlePassController.BuyBattlePass = function(self, passId, purchaseType)
  -- function num : 0_2 , upvalues : _ENV, BattlePassEnum
  if self:__IsBattlePassFinished(passId) then
    return 
  end
  local passCfg = (ConfigData.battlepass_type)[passId]
  local payId = nil
  if purchaseType == (BattlePassEnum.BuyQuality).Senior then
    payId = passCfg.senior_price
  else
    if purchaseType == (BattlePassEnum.BuyQuality).Ultimate then
      payId = passCfg.ultimate_price
    else
      if purchaseType == (BattlePassEnum.BuyQuality).SupplyUltimate then
        payId = passCfg.supply_price
      end
    end
  end
  ;
  (self.network):CS_BATTLEPASS_Buy(payId, function(dataList)
    -- function num : 0_2_0 , upvalues : _ENV
    local window = UIManager:GetWindow(UIWindowTypeID.EventBattlePassPurchase)
    if window ~= nil then
      window:OnBtnCloseClick()
    end
  end
)
end

BattlePassController.TakeBattlePassReward = function(self, id, level, takeway)
  -- function num : 0_3
  if self:__IsBattlePassFinished(id) then
    return 
  end
  ;
  (self.network):CS_BATTLEPASS_Take(id, level, takeway)
end

BattlePassController.BuyBattlePassExp = function(self, id, num, callback)
  -- function num : 0_4
  if self:__IsBattlePassFinished(id) then
    return 
  end
  ;
  (self.network):CS_BATTLEPASS_Buy_Exp(id, num, callback)
end

BattlePassController.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return BattlePassController

