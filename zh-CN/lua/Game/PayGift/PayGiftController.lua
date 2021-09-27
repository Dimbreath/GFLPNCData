local PayGiftController = class("PayGiftController", ControllerBase)
local base = ControllerBase
local PayGiftInfo = require("Game.PayGift.PayGiftInfo")
local ShopEnum = require("Game.Shop.ShopEnum")
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
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
    self.lockTimeConditionDic = {}
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    for k,payGiftInfo in pairs(self.dataDic) do
      if not payGiftInfo:IsUseItemPay() then
        local payId = (payGiftInfo.defaultCfg).payId
        local _, isFree = payCtrl:GetPayPriceInter(payId)
        -- DECOMPILER ERROR at PC57: Confused about usage of register: R11 in 'UnsetPending'

        if isFree then
          (self.pageIdDic)[(payGiftInfo.groupCfg).inPage] = 0
          -- DECOMPILER ERROR at PC63: Confused about usage of register: R11 in 'UnsetPending'

          if not payGiftInfo:IsUnlock() then
            (self.lockedFreeDic)[k] = payGiftInfo
            ;
            (PlayerDataCenter.checkerConditionRegister):AddCheckerNode(payGiftInfo:GetUnlockParam())
          else
            -- DECOMPILER ERROR at PC76: Confused about usage of register: R11 in 'UnsetPending'

            if payGiftInfo:IsSoldOut() then
              (self.soldOutFreeDic)[k] = payGiftInfo
            else
              -- DECOMPILER ERROR at PC79: Confused about usage of register: R11 in 'UnsetPending'

              ;
              (self.unSoldOutFreeDic)[k] = payGiftInfo
            end
          end
        end
      end
      do
        do
          local flag = payGiftInfo:IsUnlockTimeCondition()
          -- DECOMPILER ERROR at PC87: Confused about usage of register: R9 in 'UnsetPending'

          if flag then
            (self.lockTimeConditionDic)[k] = payGiftInfo:IsUnlock()
            ;
            (PlayerDataCenter.checkerConditionRegister):AddCheckerNode(payGiftInfo:GetUnlockParam())
          end
          -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out DO_STMT

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
  -- function num : 0_4 , upvalues : _ENV, CheckerTypeId
  local list = {}
  for id,payGiftInfo in pairs(self.lockedFreeDic) do
    if payGiftInfo:IsUnlock() then
      (table.insert)(list, id)
    end
  end
  if #list > 0 then
    for _,id in ipairs(list) do
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

      (self.unSoldOutFreeDic)[id] = (self.lockedFreeDic)[id]
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.lockedFreeDic)[id] = nil
    end
    self:UpdateReddot()
  end
  local dic = {}
  if conditionId == CheckerTypeId.TimeRange then
    local startIndex = #list + 1
    for id,isUnlock in pairs(self.lockTimeConditionDic) do
      local payGiftInfo = (self.dataDic)[id]
      local newState = payGiftInfo:IsUnlock()
      if isUnlock ~= newState then
        (table.insert)(list, id)
        dic[id] = newState
      end
    end
    for id,flag in pairs(dic) do
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R10 in 'UnsetPending'

      (self.lockTimeConditionDic)[id] = flag
    end
  end
  do
    if #list > 0 or (table.count)(dic) > 0 then
      MsgCenter:Broadcast(eMsgEventId.PayGiftItemPreConfition)
    end
  end
end

PayGiftController.CalcluteNextRefTime = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (table.count)(self.soldOutFreeDic) == 0 then
    if self.timerId ~= nil then
      TimerManager:StopTimer(self.timerId)
      self.timerId = nil
    end
    return 
  end
  self.nextCoutDownTime = -1
  for k,v in pairs(self.soldOutFreeDic) do
    if self.nextCoutDownTime == -1 or v.refreshTime < self.nextCoutDownTime then
      self.nextCoutDownTime = v.refreshTime
    end
  end
  if self.nextCoutDownTime > -1 and self.timerId == nil then
    self.timerId = TimerManager:StartTimer(1, self.TimerCallbackFreeGift, self, false, false, false)
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
  local buyLogicFunc = function()
    -- function num : 0_9_0 , upvalues : _ENV, self, giftId, isUsingItem2Bug, giftCfg, successFunc, payCtrl
    local network = NetworkManager:GetNetwork(NetworkTypeID.PayGift)
    local _heroIdSnapShoot = self._heroIdSnapShoot
    network:CS_Gift_Buy(giftId, function()
      -- function num : 0_9_0_0 , upvalues : isUsingItem2Bug, self, giftId, _ENV, giftCfg, _heroIdSnapShoot, successFunc, payCtrl
      if isUsingItem2Bug then
        self:UpdatePayGift(giftId)
        MsgCenter:Broadcast(eMsgEventId.PayGiftChange, giftId)
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        -- function num : 0_9_0_0_0 , upvalues : _ENV, giftCfg, _heroIdSnapShoot
        if window == nil then
          return 
        end
        local msg = ConfigData:GetTipContent(297)
        window:InitRewardTitle(msg)
        window:InitRewardsItem(giftCfg.awardIds, giftCfg.awardCounts, _heroIdSnapShoot)
      end
)
        if successFunc ~= nil then
          successFunc()
        end
      else
        local payId = giftCfg.payId
        if payId ~= nil then
          payCtrl:ReqPay(payId, 1, function()
        -- function num : 0_9_0_0_1 , upvalues : self, giftId, _ENV, successFunc
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

  do
    if isUsingItem2Bug then
      local haveCost = PlayerDataCenter:GetItemCount(giftCfg.costId)
      if haveCost < giftCfg.costCount then
        if payCtrl:IsPayItem(giftCfg.costId) then
          payCtrl:TryConvertPayItem(giftCfg.costId, giftCfg.costCount - haveCost, nil, nil, function()
    -- function num : 0_9_1 , upvalues : buyLogicFunc
    buyLogicFunc()
  end
, false)
        else
          ;
          ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Shop_MoneyInsufficient))
        end
        return 
      end
    end
    buyLogicFunc()
  end
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
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__ListenPreCondtion)
  ;
  (base.OnDelete)(self)
end

return PayGiftController

