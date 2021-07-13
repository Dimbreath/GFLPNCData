-- params : ...
-- function num : 0 , upvalues : _ENV
local BattlePassController = class("BattlePassController", ControllerBase)
local base = ControllerBase
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local eActivityState = ActivityFrameEnum.eActivityState
BattlePassController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.network = NetworkManager:GetNetwork(NetworkTypeID.BattlePass)
end

BattlePassController.BuyBattlePass = function(self, passId, purchaseType)
  -- function num : 0_1 , upvalues : _ENV, BattlePassEnum
  local passCfg = (ConfigData.battlepass_type)[passId]
  local payId = nil
  if purchaseType == (BattlePassEnum.BuyQuality).Senior then
    payId = passCfg.senior_price
  else
    if purchaseType == (BattlePassEnum.BuyQuality).Ultimate then
      payId = passCfg.ultimate_price
    end
  end
  ;
  (self.network):CS_BATTLEPASS_Buy(payId, function(dataList)
    -- function num : 0_1_0 , upvalues : _ENV
    UIManager:DeleteWindow(UIWindowTypeID.EventBattlePassPurchase)
  end
)
end

BattlePassController.TakeBattlePassReward = function(self, id, level, takeway)
  -- function num : 0_2
  (self.network):CS_BATTLEPASS_Take(id, level, takeway)
end

BattlePassController.BuyBattlePassExp = function(self, id, num, callback)
  -- function num : 0_3
  (self.network):CS_BATTLEPASS_Buy_Exp(id, num, callback)
end

BattlePassController.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return BattlePassController

