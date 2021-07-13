-- params : ...
-- function num : 0 , upvalues : _ENV
local PayGiftController = class("PayGiftController", ControllerBase)
local base = ControllerBase
local PayGiftInfo = require("Game.PayGift.PayGiftInfo")
local ShopEnum = require("Game.Shop.ShopEnum")
PayGiftController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, PayGiftInfo
  self.dataDic = {}
  for k,v in pairs(ConfigData.pay_gift_type) do
    local data = (PayGiftInfo.CreatePayGiftInfo)(v)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.dataDic)[k] = data
  end
  self.__ListenPreCondtion = BindCallback(self, self.ListenPreCondtion)
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__ListenPreCondtion)
end

PayGiftController.InitPayGift = function(self, msg)
  -- function num : 0_1 , upvalues : _ENV, ShopEnum
  for k,v in pairs(self.dataDic) do
    v:UpdatePayGiftInfo()
  end
  self.shopId = 0
  for k,v in pairs(ConfigData.shop) do
    if v.shop_type == (ShopEnum.eShopType).PayGift then
      self.shopId = k
      break
    end
  end
  do
    self.pageIdDic = {}
    self.soldOutFreeDic = {}
    self.unSoldOutFreeDic = {}
    self.lockedFreeDic = {}
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    for k,v in pairs(self.dataDic) do
      if not v:IsUseItemPay() then
        local payId = (v.defaultCfg).payId
        local _, isFree = payCtrl:GetPayPriceInter(payId)
        -- DECOMPILER ERROR at PC55: Confused about usage of register: R11 in 'UnsetPending'

        if isFree then
          (self.pageIdDic)[(v.groupCfg).inPage] = 0
          -- DECOMPILER ERROR at PC61: Confused about usage of register: R11 in 'UnsetPending'

          if not v:IsUnlock() then
            (self.lockedFreeDic)[k] = v
          else
            -- DECOMPILER ERROR at PC68: Confused about usage of register: R11 in 'UnsetPending'

            if v:IsSoldOut() then
              (self.soldOutFreeDic)[k] = v
            else
              -- DECOMPILER ERROR at PC71: Confused about usage of register: R11 in 'UnsetPending'

              ;
              (self.unSoldOutFreeDic)[k] = v
            end
          end
        end
      end
    end
    self:UpdateReddot()
    self:CalcluteNextRefTime()
  end
end

PayGiftController.UpdatePayGift = function(self, giftId)
  -- function num : 0_2 , upvalues : _ENV
  local giftInfo = nil
  for k,v in pairs(self.dataDic) do
    if ((v.groupCfg).giftDic)[giftId] ~= nil then
      giftInfo = v
      break
    end
  end
  do
    if giftInfo ~= nil then
      giftInfo:UpdatePayGiftInfo()
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

      if giftInfo:IsSoldOut() and (self.unSoldOutFreeDic)[(giftInfo.groupCfg).id] ~= nil then
        (self.unSoldOutFreeDic)[(giftInfo.groupCfg).id] = nil
        -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (self.soldOutFreeDic)[(giftInfo.groupCfg).id] = giftInfo
        self:UpdateReddot()
        self:CalcluteNextRefTime()
      end
    end
  end
end

PayGiftController.TimerCallbackFreeGift = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.nextCoutDownTime == -1 then
    return 
  end
  if PlayerDataCenter.timestamp < self.nextCoutDownTime then
    return 
  end
  local list = {}
  for k,v in pairs(self.soldOutFreeDic) do
    if not v:IsSoldOut() then
      (table.insert)(list, k)
    end
  end
  if #list > 0 then
    for i,v in ipairs(list) do
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'

      (self.unSoldOutFreeDic)[v] = (self.soldOutFreeDic)[v]
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.soldOutFreeDic)[v] = nil
    end
    self:UpdateReddot()
  end
  self:CalcluteNextRefTime()
end

PayGiftController.ListenPreCondtion = function(self, conditionId)
  -- function num : 0_4 , upvalues : _ENV
  local list = {}
  for k,v in pairs(self.lockedFreeDic) do
    if v:IsUnlock() then
      (table.insert)(list, k)
    end
  end
  if #list > 0 then
    for i,v in ipairs(list) do
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

      (self.unSoldOutFreeDic)[v] = (self.lockedFreeDic)[v]
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.lockedFreeDic)[v] = nil
    end
    self:UpdateReddot()
  end
end

PayGiftController.CalcluteNextRefTime = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (table.count)(self.soldOutFreeDic) == 0 then
    if self.timer ~= nil then
      (self.timer):Stop()
      self.timer = nil
    end
    return 
  end
  self.nextCoutDownTime = -1
  for k,v in pairs(self.soldOutFreeDic) do
    if self.nextCoutDownTime == -1 or v.refreshTime < self.nextCoutDownTime then
      self.nextCoutDownTime = v.refreshTime
    end
  end
  if self.nextCoutDownTime > -1 and self.timer == nil then
    self.timer = TimerManager:GetTimer(1, self.TimerCallbackFreeGift, self, false, false, false)
    ;
    (self.timer):Start()
  end
end

PayGiftController.UpdateReddot = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, self.shopId)
  if not ok then
    shopNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, self.shopId)
  end
  local updateReddotSingleFunc = function(dic, flag)
    -- function num : 0_6_0 , upvalues : _ENV, shopNode
    if flag then
      for k,v in pairs(dic) do
        local singleNode = (shopNode:AddChild((v.groupCfg).inPage)):AddChild((v.groupCfg).id)
        if singleNode:GetRedDotCount() <= 0 then
          singleNode:SetRedDotCount(1)
        end
      end
    else
      do
        for k,v in pairs(dic) do
          local singleNode = (shopNode:AddChild((v.groupCfg).inPage)):GetChild((v.groupCfg).id)
          if singleNode ~= nil and singleNode:GetRedDotCount() > 0 then
            singleNode:SetRedDotCount(0)
          end
        end
      end
    end
  end

  updateReddotSingleFunc(self.lockedFreeDic, false)
  updateReddotSingleFunc(self.soldOutFreeDic, false)
  updateReddotSingleFunc(self.unSoldOutFreeDic, true)
end

PayGiftController.GetShowPayGiftByPageId = function(self, pageId)
  -- function num : 0_7 , upvalues : _ENV
  local oriGroupDatas = {}
  for k,v in pairs(self.dataDic) do
    if ((v.groupCfg).pre_group == nil or #(v.groupCfg).pre_group == 0) and v:IsUnlock() and (pageId == nil or (v.groupCfg).inPage == pageId) then
      (table.insert)(oriGroupDatas, v)
    end
  end
  local dataList = {}
  for i,v in ipairs(oriGroupDatas) do
    if v:IsLinearGift() then
      local list = self:SeekNextLinearSellGift(v)
      if list ~= nil and #list > 0 then
        (table.insertto)(dataList, list)
      end
    else
      do
        do
          if not v:IsEternalAndSoldOut() and (v.needRefresh or not v:IsSoldOut()) then
            (table.insert)(dataList, v)
          end
          -- DECOMPILER ERROR at PC70: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC70: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC70: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return dataList
end

PayGiftController.SeekNextLinearSellGift = function(self, giftGroup)
  -- function num : 0_8 , upvalues : _ENV
  local list = {}
  if giftGroup == nil or not giftGroup:IsLinearGift() then
    return list
  end
  local __SeekNextLinerSellGift = function(item)
    -- function num : 0_8_0 , upvalues : _ENV, list, self, __SeekNextLinerSellGift
    if not item:IsSoldOut() then
      (table.insert)(list, item)
      return 
    end
    for k,v in pairs((item.groupCfg).afterGroup) do
      local nextItem = (self.dataDic)[k]
      if nextItem:IsUnlock() then
        __SeekNextLinerSellGift(nextItem)
      end
    end
  end

  __SeekNextLinerSellGift(giftGroup)
  return list
end

PayGiftController.SendBuyGifit = function(self, giftCfg, isUsingItem2Bug, successFunc)
  -- function num : 0_9 , upvalues : _ENV
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay)
  local giftId = giftCfg.id
  if isUsingItem2Bug and PlayerDataCenter:GetItemCount(giftCfg.costId) < giftCfg.costCount then
    if payCtrl:IsPayItem(giftCfg.costId) then
      payCtrl:TryConvertPayItem(giftCfg.costId, giftCfg.costCount - giftCfg.costId, nil, nil, nil, false)
    else
      ;
      ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Shop_MoneyInsufficient))
    end
    return 
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.PayGift)
  local _heroIdSnapShoot = self._heroIdSnapShoot
  network:CS_Gift_Buy(giftId, function()
    -- function num : 0_9_0 , upvalues : isUsingItem2Bug, self, giftId, _ENV, giftCfg, _heroIdSnapShoot, successFunc, payCtrl
    if isUsingItem2Bug then
      self:UpdatePayGift(giftId)
      MsgCenter:Broadcast(eMsgEventId.PayGiftChange, giftId)
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_9_0_0 , upvalues : giftCfg, _heroIdSnapShoot, _ENV
      if window == nil then
        return 
      end
      window:InitRewardsItem(giftCfg.awardIds, giftCfg.awardCounts, _heroIdSnapShoot)
      local msg = ConfigData:GetTipContent(297)
      window:InitRewardTitle(msg)
    end
)
      if successFunc ~= nil then
        successFunc()
      end
    else
      local payId = giftCfg.payId
      if payId ~= nil then
        payCtrl:ReqPay(payId, 1, function()
      -- function num : 0_9_0_1 , upvalues : self, giftId, _ENV, successFunc
      self:UpdatePayGift(giftId)
      MsgCenter:Broadcast(eMsgEventId.PayGiftChange, giftId)
      if successFunc ~= nil then
        successFunc()
      end
    end
, ConfigData:GetTipContent(297))
      end
    end
  end
)
end

PayGiftController.GetIsGiftSouldOut = function(self, giftGroupId)
  -- function num : 0_10
  local giftInfo = (self.dataDic)[giftGroupId]
  if giftInfo ~= nil then
    return giftInfo:IsSoldOut()
  end
  return false
end

PayGiftController.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__ListenPreCondtion)
  ;
  (base.OnDelete)(self)
end

return PayGiftController

