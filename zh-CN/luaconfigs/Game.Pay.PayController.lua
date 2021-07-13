-- params : ...
-- function num : 0 , upvalues : _ENV
local PayController = class("PayController", ControllerBase)
local base = ControllerBase
local rapidjson = require("rapidjson")
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_MicaSDKManager = CS.MicaSDKManager
local cs_LanguageGlobal = CS.LanguageGlobal
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
PayController.OnInit = function(self)
  -- function num : 0_0
end

PayController.GetPayPriceInter = function(self, productId)
  -- function num : 0_1 , upvalues : _ENV, cs_LanguageGlobal
  local productCfg = (ConfigData.pay_product)[productId]
  if productCfg == nil then
    error("Cant get pay_product cfg, productId : " .. tostring(productId))
    return 
  end
  local paySdkCfg = (ConfigData.pay_sdk)[productCfg.sdk_id]
  if paySdkCfg == nil then
    error("Cant get pay_sdk cfg, id : " .. tostring(productCfg.sdk_id))
    return 
  end
  local pricePara = "price_" .. (cs_LanguageGlobal.GetLanguageStr)()
  if paySdkCfg[pricePara] == nil then
    error("Cant get payCfg." .. pricePara)
    return 
  end
  local priceInter = (math.floor)(paySdkCfg[pricePara] / 100)
  do return priceInter, priceInter == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

PayController.GetPayPriceShow = function(self, productId)
  -- function num : 0_2 , upvalues : _ENV
  local priceInter = self:GetPayPriceInter(productId)
  if priceInter == 0 then
    return "免费", "免费"
  end
  local payPriceUnit = ConfigData:GetTipContent(TipContent.PayPriceUnit)
  return (string.format)(payPriceUnit, tostring(priceInter)), priceInter, (string.format)(payPriceUnit, "")
end

PayController.GetPayName = function(self, productId)
  -- function num : 0_3 , upvalues : _ENV
  local productCfg = (ConfigData.pay_product)[productId]
  if productCfg == nil then
    error("Cant get pay_product cfg, productId : " .. tostring(productId))
    return 
  end
  local paySdkCfg = (ConfigData.pay_sdk)[productCfg.sdk_id]
  if paySdkCfg == nil then
    error("Cant get pay_sdk cfg, id : " .. tostring(productCfg.sdk_id))
    return 
  end
  return (LanguageUtil.GetLocaleText)(paySdkCfg.name)
end

PayController.GetPayRewards = function(self, productId, isDouble)
  -- function num : 0_4 , upvalues : _ENV
  local rechargeCfg = (ConfigData.pay_recharge)[productId]
  if rechargeCfg == nil then
    error("Cant get pay_recharge cfg, id : " .. tostring(productCfg.sdk_id))
    return 
  end
  if isDouble then
    return rechargeCfg.doubleRewardIdList, rechargeCfg.doubleRewardNumList
  else
    return rechargeCfg.rewardIdList, rechargeCfg.rewardNumList
  end
end

PayController.ReqPay = function(self, productId, num, callback, showTitle)
  -- function num : 0_5 , upvalues : _ENV, cs_LanguageGlobal, cs_MicaSDKManager, cs_MessageCommon, rapidjson
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  self._rewardTitle = showTitle
  local productCfg = (ConfigData.pay_product)[productId]
  if productCfg == nil then
    error("Cant get pay_product cfg, productId : " .. tostring(productId))
    return 
  end
  local paySdkCfg = (ConfigData.pay_sdk)[productCfg.sdk_id]
  if paySdkCfg == nil then
    error("Cant get pay_sdk cfg, id : " .. tostring(productCfg.sdk_id))
    return 
  end
  local pricePara = "price_" .. (cs_LanguageGlobal.GetLanguageStr)()
  if paySdkCfg[pricePara] == nil then
    error("Cant get payCfg." .. pricePara)
    return 
  end
  local totalPrice = paySdkCfg[pricePara] * num
  if self.__OnRecPayRewardFunc == nil then
    self.__OnRecPayRewardFunc = BindCallback(self, self.OnRecPayReward)
  end
  self.__payCallback = callback
  if totalPrice == 0 then
    (NetworkManager:GetNetwork(NetworkTypeID.Pay)):CS_RECHARGE_RechargeFree(productId, self.__OnRecPayRewardFunc)
    return 
  end
  if not (cs_MicaSDKManager.Instance):IsUseSdk() then
    (NetworkManager:GetNetwork(NetworkTypeID.Pay)):CS_RECHARGE_FakeRecharge(productId, totalPrice, self.__OnRecPayRewardFunc)
    return 
  end
  local channelId = (cs_MicaSDKManager.Instance).channelId
  if channelId == (Consts.GameChannelType).Kol then
    (cs_MessageCommon.ShowMessageBoxConfirm)((ConfigData:GetTipContent(10011)), nil)
    return 
  end
  local extraStr = PlayerDataCenter.strPlayerId
  if channelId == (Consts.GameChannelType).Bilibili or channelId == (Consts.GameChannelType).BilibiliQATest then
    extraStr = extraStr .. "-bili"
  else
    if channelId == (Consts.GameChannelType).BilibiliKol then
      extraStr = extraStr .. "-kol"
    end
  end
  local payParamTab = {GAME_USER_ROLE_NAME = PlayerDataCenter.playerName, GAME_USER_ID = PlayerDataCenter.strPlayerId, AMOUNT = tostring(totalPrice), PRODUCT_ID = "com.sunborn.neuralcloud.cn.diamond" .. tostring(paySdkCfg.id), PRODUCT_NAME = (LanguageUtil.GetLocaleText)(paySdkCfg.name), PRODUCT_DESC = (LanguageUtil.GetLocaleText)(paySdkCfg.description), VIRTUAL_QUANTITY = tostring(num), EXTRA = extraStr}
  local payParamJson = (rapidjson.encode)(payParamTab)
  ;
  (cs_MicaSDKManager.Instance):ReqPay(payParamJson, function(payFinish)
    -- function num : 0_5_0
  end
)
end

PayController.OnRecPayReward = function(self, objList)
  -- function num : 0_6 , upvalues : _ENV
  if objList.Count == 0 then
    error("objList.Count == 0")
    return 
  end
  local rechargeRewardsBrief = objList[0]
  self:ShowPayReward(rechargeRewardsBrief)
end

PayController.ShowPayReward = function(self, rechargeRewardsBrief)
  -- function num : 0_7 , upvalues : _ENV, cs_MicaSDKManager, cs_MessageCommon
  local rewardIds = {}
  local rewardNums = {}
  local rewardDic = rechargeRewardsBrief.rewards
  local mergedRewardIdDic = {}
  do
    for id,num in pairs(rewardDic) do
      if not mergedRewardIdDic[id] then
        local showId = id
        local showNum = num
        local mergeIdList = eItemMergeDic[id]
        if mergeIdList ~= nil then
          showNum = 0
          for k,mergeId in ipairs(mergeIdList) do
            local mNum = rewardDic[mergeId]
            if mNum ~= nil then
              showNum = showNum + mNum
            end
            mergedRewardIdDic[mergeId] = true
          end
          showId = mergeIdList[1]
        end
        ;
        (table.insert)(rewardIds, showId)
        ;
        (table.insert)(rewardNums, showNum)
      end
    end
  end
  if #rewardIds == 0 then
    self.waitMsgBoxConfirm = true
    if not (cs_MicaSDKManager.Instance):IsUseSdk() then
      (cs_MessageCommon.ShowMessageBoxConfirm)(ConfigData:GetTipContent(10003), function()
    -- function num : 0_7_0 , upvalues : self
    self.waitMsgBoxConfirm = false
  end
)
    end
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.Pay)):CS_RECHARGE_ConfirmRewards()
  else
    local _heroIdSnapShoot = self._heroIdSnapShoot
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_7_1 , upvalues : self, _ENV, rewardIds, rewardNums, _heroIdSnapShoot
    if window == nil then
      return 
    end
    if self._rewardTitle == nil or not self._rewardTitle then
      local msg = ConfigData:GetTipContent(10006)
    end
    window:AddNext2ShowReward(rewardIds, rewardNums, _heroIdSnapShoot, nil, msg)
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.Pay)):CS_RECHARGE_ConfirmRewards()
  end
)
  end
  do
    if self.__payCallback ~= nil then
      (self.__payCallback)()
      self.__payCallback = nil
    end
  end
end

PayController.SetWaitShowPayResult = function(self, rechargeRewardsBrief)
  -- function num : 0_8
  self._waitShowPayResult = rechargeRewardsBrief
end

PayController.TryShowPayResult = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self._waitShowPayResult == nil then
    return 
  end
  local hasRewardItem = (table.count)((self._waitShowPayResult).rewards) > 0
  self:ShowPayReward(self._waitShowPayResult)
  self._waitShowPayResult = nil
  while 1 do
    if hasRewardItem then
      if UIManager:GetWindow(UIWindowTypeID.CommonReward) == nil then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  while UIManager:GetWindow(UIWindowTypeID.CommonReward) ~= nil do
    (coroutine.yield)(nil)
  end
  while self.waitMsgBoxConfirm do
    (coroutine.yield)(nil)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

PayController.IsPayItem = function(self, itemId)
  -- function num : 0_10 , upvalues : _ENV
  do return itemId == ConstGlobalItem.PaidSubItem or itemId == ConstGlobalItem.PaidItem end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

PayController.TryConvertPayItem = function(self, itemId, num, beforeJumpCallback, jumpOverCallback, callBack, directShowShop)
  -- function num : 0_11 , upvalues : _ENV
  if itemId == ConstGlobalItem.PaidSubItem then
    self:ConvertQuartz(num, beforeJumpCallback, jumpOverCallback, callBack, directShowShop)
    return true
  else
    if itemId == ConstGlobalItem.PaidItem then
      self:Jump2BuyQuartz(beforeJumpCallback, jumpOverCallback, directShowShop)
    end
  end
  return false
end

PayController.ConvertQuartz = function(self, num, beforeJumpCallback, jumpOverCallback, callBack, directShowShop)
  -- function num : 0_12 , upvalues : _ENV, cs_MessageCommon
  local msg = (string.format)(ConfigData:GetTipContent(10008), num, num)
  ;
  (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_12_0 , upvalues : _ENV, num, callBack, self, beforeJumpCallback, jumpOverCallback, directShowShop
    local quartzNum = PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem)
    -- DECOMPILER ERROR at PC12: Unhandled construct in 'MakeBoolean' P1

    if num <= quartzNum and callBack ~= nil then
      callBack()
    end
    self:Jump2BuyQuartz(beforeJumpCallback, jumpOverCallback, directShowShop)
  end
, nil)
end

PayController.Jump2BuyQuartz = function(self, beforeJumpCallback, jumpOverCallback, directShow)
  -- function num : 0_13 , upvalues : cs_MessageCommon, _ENV, ShopEnum, JumpManager
  (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(10009), function()
    -- function num : 0_13_0 , upvalues : ShopEnum, directShow, JumpManager, beforeJumpCallback, jumpOverCallback
    local shopId = (ShopEnum.ShopId).recharge
    if directShow then
      JumpManager:DirectShowShop(beforeJumpCallback, jumpOverCallback, shopId)
    else
      JumpManager:Jump((JumpManager.eJumpTarget).DynShop, beforeJumpCallback, jumpOverCallback, {shopId})
    end
  end
, nil)
end

PayController.OnDelete = function(self)
  -- function num : 0_14 , upvalues : base
  (base.OnDelete)(self)
end

return PayController

