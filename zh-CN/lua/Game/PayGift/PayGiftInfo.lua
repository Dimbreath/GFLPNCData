local PayGiftInfo = class("PayGiftInfo")
local ShopEnum = require("Game.Shop.ShopEnum")
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
PayGiftInfo.CreatePayGiftInfo = function(groupCfg)
  -- function num : 0_0 , upvalues : PayGiftInfo, _ENV, ShopEnum, _
  local data = (PayGiftInfo.New)()
  data.groupCfg = groupCfg
  data.initPreGroupId = (data.groupCfg).id
  data.initPreGroupLine = (data.groupCfg).line
  if (data.groupCfg).pre_group ~= nil and #(data.groupCfg).pre_group > 0 then
    data.initPreGroupId = ((data.groupCfg).pre_group)[1]
    data.initPreGroupLine = ((ConfigData.pay_gift_type)[data.initPreGroupId]).line
  end
  data.giftCfgList = {}
  for i,v in pairs((data.groupCfg).giftDic) do
    (table.insert)(data.giftCfgList, v)
  end
  data.refreshHour = 5
  data.times = 0
  data.refreshTime = 0
  data.nextRefreshTime = data.refreshTime
  ;
  (table.sort)(data.giftCfgList, function(a, b)
    -- function num : 0_0_0
    if a.limit_type >= b.limit_type then
      do return a.limit_type == b.limit_type end
      do return a.id < b.id end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
  data.defaultCfg = (data.giftCfgList)[1]
  data.needRefresh = (data.defaultCfg).limit_type ~= (ShopEnum.eLimitType).None and (data.defaultCfg).limit_type ~= (ShopEnum.eLimitType).Eternal
  data.isFree = nil
  data.isFree = not (data.defaultCfg).cur_price and not data:IsUseItemPay() or 0 == 0
  do
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    _ = payCtrl:GetPayPriceInter((data.defaultCfg).payId)
    do return data end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

PayGiftInfo.UpdatePayGiftInfo = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.TimePass, true))
  local timepassCtr = nil
  local counterEl = nil
  for k,v in pairs(self.giftCfgList) do
    local tempCounterEl = timepassCtr:getCounterElemData(proto_object_CounterModule.CounterModuleGiftReset, v.id)
    if tempCounterEl ~= nil and PlayerDataCenter.timestamp < tempCounterEl.nextExpiredTm then
      counterEl = tempCounterEl
      break
    end
  end
  do
    if counterEl ~= nil then
      self.times = counterEl.times
      self.refreshTime = counterEl.nextExpiredTm
      self.nextRefreshTime = self.refreshTime
      self:UpadteNextTime()
    end
  end
end

PayGiftInfo.IsUnlock = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return (CheckCondition.CheckLua)((self.groupCfg).pre_condition, (self.groupCfg).pre_para1, (self.groupCfg).pre_para2)
end

PayGiftInfo.GetUnlockParam = function(self)
  -- function num : 0_3
  return (self.groupCfg).pre_condition, (self.groupCfg).pre_para1, (self.groupCfg).pre_para2
end

PayGiftInfo.IsUnlockTimeCondition = function(self)
  -- function num : 0_4 , upvalues : _ENV, CheckerTypeId
  for i,preCondition in ipairs((self.groupCfg).pre_condition) do
    if preCondition == CheckerTypeId.TimeRange then
      return true, ((self.groupCfg).pre_para1)[i], ((self.groupCfg).pre_para2)[i]
    end
  end
  return false
end

PayGiftInfo.IsLinearGift = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self.groupCfg).pre_group ~= nil and #(self.groupCfg).pre_group > 0 then
    return true
  end
  if (self.groupCfg).afterGroup ~= nil and (table.count)((self.groupCfg).afterGroup) > 0 then
    return true
  end
  return false
end

PayGiftInfo.IsSoldOut = function(self)
  -- function num : 0_6 , upvalues : ShopEnum, _ENV
  if (self.defaultCfg).limit_type == (ShopEnum.eLimitType).None then
    return false
  end
  if (self.defaultCfg).times > self.times then
    do return (self.defaultCfg).limit_type ~= (ShopEnum.eLimitType).Eternal end
    do return PlayerDataCenter.timestamp < self.refreshTime and (self.defaultCfg).times <= self.times end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

PayGiftInfo.IsEternalAndSoldOut = function(self)
  -- function num : 0_7 , upvalues : ShopEnum
  do return ((self.defaultCfg).limit_type == (ShopEnum.eLimitType).Eternal and self:IsSoldOut()) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

PayGiftInfo.GetLimitBuyCount = function(self)
  -- function num : 0_8 , upvalues : ShopEnum, _ENV
  local isLimitBuy = (self.defaultCfg).limit_type ~= (ShopEnum.eLimitType).None
  local times = self.times
  if isLimitBuy and self.refreshTime < PlayerDataCenter.timestamp then
    times = 0
  end
  do return isLimitBuy, times, (self.defaultCfg).times end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

PayGiftInfo.GetPayGiftNextTime = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if not self:NeedRefreshTime() then
    return -1
  end
  if PlayerDataCenter.timestamp < self.nextRefreshTime then
    return self.nextRefreshTime
  else
    self:UpadteNextTime()
    return self.nextRefreshTime
  end
end

PayGiftInfo.NeedRefreshTime = function(self)
  -- function num : 0_10 , upvalues : ShopEnum, _ENV
  if (self.defaultCfg).limit_type == (ShopEnum.eLimitType).Subscription then
    if PlayerDataCenter.timestamp >= self.nextRefreshTime then
      do return not self.needRefresh end
      do return true end
      do return false end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
end

PayGiftInfo.IsUseItemPay = function(self)
  -- function num : 0_11
  do return (self.defaultCfg).pay_type == 2 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

PayGiftInfo.UpadteNextTime = function(self)
  -- function num : 0_12 , upvalues : _ENV, ShopEnum
  if PlayerDataCenter.timestamp <= self.nextRefreshTime then
    return 
  end
  local time = TimestampToDate((math.floor)(PlayerDataCenter.timestamp - 3600 * self.refreshHour))
  if (self.defaultCfg).limit_type == (ShopEnum.eLimitType).Day then
    time.hour = 0
    time.min = 0
    time.sec = 0
    self.nextRefreshTime = (os.time)(time) + 86400 + 3600 * self.refreshHour
  else
    if (self.defaultCfg).limit_type == (ShopEnum.eLimitType).Week or (self.defaultCfg).limit_type == (ShopEnum.eLimitType).Subscription then
      local wday = time.wday
      wday = wday - 1
      if wday == 0 then
        wday = 7
      end
      local dayCount = 8 - wday
      time.hour = 0
      time.min = 0
      time.sec = 0
      self.nextRefreshTime = (os.time)(time) + 86400 * dayCount + 3600 * self.refreshHour
    else
      do
        if (self.defaultCfg).limit_type == (ShopEnum.eLimitType).Month then
          time.day = 1
          time.hour = 0
          time.min = 0
          time.sec = 0
          if time.month == 12 then
            time.month = 1
            time.year = time.year + 1
          else
            time.month = time.month + 1
          end
          self.nextRefreshTime = (os.time)(time) + 3600 * self.refreshHour
        end
      end
    end
  end
end

PayGiftInfo.TryGetGiftSubscriptionCfg = function(self)
  -- function num : 0_13 , upvalues : _ENV, ShopEnum
  for _,giftCfg in ipairs(self.giftCfgList) do
    if giftCfg.limit_type == (ShopEnum.eLimitType).Subscription then
      return true, giftCfg, giftCfg.param
    end
  end
  return false, nil, 0
end

return PayGiftInfo

