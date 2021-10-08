local UINFactoryOrderNode = class("UINFactoryOrderNode", UIBaseNode)
local base = UIBaseNode
local FactoryEnum = require("Game.Factory.FactoryEnum")
local UINFactoryOrderNodeProductItem = require("Game.Factory.UI.UINFactoryOrderNodeProductItem")
local FactoryHelper = require("Game.Factory.FactoryHelper")
local cs_MessageCommon = CS.MessageCommon
UINFactoryOrderNode.ctor = function(self, isQuickProduce)
  -- function num : 0_0
  self.isQuickProduce = isQuickProduce
end

UINFactoryOrderNode.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, FactoryEnum
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.orderType = (FactoryEnum.eOrderType).dig
  self.costTime = 0
  self._costEnergy = 0
  self._couldQuickProduct = false
  self._pressCount = 0
  self.fileInputVal = 0
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).btn_Add).onPress):AddListener(BindCallback(self, self.OnClickAddOnPress))
  ;
  (((self.ui).btn_Add).onPressUp):AddListener(BindCallback(self, self.OnPressUp))
  ;
  (((self.ui).btn_Min).onPress):AddListener(BindCallback(self, self.OnClickMinOnPress))
  ;
  (((self.ui).btn_Min).onPressUp):AddListener(BindCallback(self, self.OnPressUp))
  ;
  (((self.ui).inputField).onEndEdit):AddListener(BindCallback(self, self.OnInputFieldEndEdit))
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.OnClickAdd)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Max, self, self.OnClickAdd2Max)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Min, self, self.OnClickMin)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Least, self, self.OnClickMin2Least)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickStartroduct)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Quick, self, self.OnClickQuickProduct)
  self.m_OnProduceOver = BindCallback(self, self.OnProduceOver)
  self.m_OnTimeProduceSendOver = BindCallback(self, self.OnTimeProduceSendOver)
  self.__OnItemRefresh = BindCallback(self, self.OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
end

UINFactoryOrderNode.InitOrderNode = function(self, roomIndex, isTryNotClearOrder)
  -- function num : 0_2
  self.roomIndex = roomIndex
  if isTryNotClearOrder and (self.factoryController).Order4SendData ~= nil then
    if (self.factoryController):GetRoomEnegeyByIndex(self.roomIndex) < ((self.factoryController).Order4SendData).usedTime then
      (self.factoryController):ClearOrder()
    else
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.factoryController).Order4SendData).lineIndex = roomIndex
    end
  else
    ;
    (self.factoryController):ClearOrder()
  end
  self:RefreshOrderInfo()
end

UINFactoryOrderNode.ShowOrder = function(self, orderData)
  -- function num : 0_3 , upvalues : FactoryEnum
  if self.orderData ~= orderData then
    (self.factoryController):ClearOrder()
    self.orderData = orderData
    self.orderCfg = orderData:GetOrderCfg()
    self.orderType = orderData:GetOrderType()
    ;
    ((self.ui).tex_StartType):SetIndex(self.orderType - 1)
    ;
    ((self.ui).tex_QuickType):SetIndex(self.orderType - 1)
    ;
    ((self.ui).tex_From):SetIndex(self.orderType - 1)
    if self.orderType == (FactoryEnum.eOrderType).dig then
      self:ShowDigOrder()
    else
      if self.orderType == (FactoryEnum.eOrderType).product then
        self:ShowProduceOrder()
      end
    end
    self:RefreshOrderInfo()
  end
end

UINFactoryOrderNode.OnItemRefresh = function(self, itemUpdate)
  -- function num : 0_4
  if self.active then
    self:RefreshOrderInfo()
  end
end

UINFactoryOrderNode.RefreshEnergey = function(self, isUpdate)
  -- function num : 0_5 , upvalues : _ENV
  local value, ceiling = (self.factoryController):GetRoomEnegeyByIndex(self.roomIndex)
  if isUpdate and value == self.cacheEnergy then
    return 
  end
  self.cacheEnergy = value
  self._couldQuickProduc = self._costEnergy <= value
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  if self._couldQuickProduc then
    ((self.ui).img_btn_Qucik).color = Color.white
  else
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

    ((self.ui).img_btn_Qucik).color = (self.ui).color_gray
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINFactoryOrderNode.UpdateEnergy = function(self)
  -- function num : 0_6
  self:RefreshEnergey(true)
end

UINFactoryOrderNode.ShowDigOrder = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((self.ui).itemNode):SetActive(true)
  ;
  ((self.ui).formulaNode):SetActive(false)
  local itemCfg = (ConfigData.item)[(self.orderCfg).outPutItemId]
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_ItemIcon).sprite = CRH:GetSpriteByItemConfig(itemCfg)
end

UINFactoryOrderNode.ShowProduceOrder = function(self)
  -- function num : 0_8 , upvalues : UINFactoryOrderNodeProductItem, _ENV
  ((self.ui).itemNode):SetActive(false)
  ;
  ((self.ui).formulaNode):SetActive(true)
  if self.finalProductItem == nil then
    self.finalProductItem = (UINFactoryOrderNodeProductItem.New)()
    ;
    (self.finalProductItem):Init((self.ui).finalFormulaItem)
  end
  if self.productItemPool == nil then
    self.productItemPool = (UIItemPool.New)(UINFactoryOrderNodeProductItem, (self.ui).formulaItem)
    ;
    ((self.ui).formulaItem):SetActive(false)
  end
  ;
  (self.finalProductItem):InitProductItem(self.orderCfg, true)
end

UINFactoryOrderNode.OnClickAdd = function(self)
  -- function num : 0_9 , upvalues : FactoryEnum, cs_MessageCommon, _ENV
  local couldAdd, reason = (self.factoryController):TryAddOneOrder(self.roomIndex, self.orderData)
  if couldAdd then
    self:RefreshOrderInfo()
  else
    if reason == (FactoryEnum.eCannotAddReason).timeBeyountLimit then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Factory_BeyoundOrderTime))
    else
      if reason == (FactoryEnum.eCannotAddReason).matInsufficeient then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Factory_MatInsufficient))
      else
        if reason == (FactoryEnum.eCannotAddReason).warehouseFull then
          (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Factory_WarehousFull))
        end
      end
    end
  end
end

UINFactoryOrderNode.OnClickAdd2Max = function(self)
  -- function num : 0_10
  local couldAdd = (self.factoryController):TryAddMaxOrder(self.roomIndex, self.orderData)
  if couldAdd then
    self:RefreshOrderInfo()
  end
end

UINFactoryOrderNode.OnClickMin = function(self)
  -- function num : 0_11
  local couldMin = (self.factoryController):TryMinOneOrder(self.roomIndex, self.orderData)
  if couldMin then
    self:RefreshOrderInfo()
  end
end

UINFactoryOrderNode.OnClickMin2Least = function(self)
  -- function num : 0_12
  (self.factoryController):ClearOrder()
  self:RefreshOrderInfo()
end

UINFactoryOrderNode.OnClickAddOnPress = function(self)
  -- function num : 0_13
  local count = self:GetLongPressCount()
  self:_TryAddMult(count)
end

UINFactoryOrderNode._TryAddMult = function(self, count)
  -- function num : 0_14
  do
    while count ~= 0 do
      local couldAdd, reason = (self.factoryController):TryAddOneOrder(self.roomIndex, self.orderData)
      if couldAdd then
        count = count - 1
      else
        count = 0
        self:ShowTipsByReason(reason)
      end
      self:RefreshOrderInfo()
    end
    if count > 0 then
    end
  end
end

UINFactoryOrderNode.OnClickMinOnPress = function(self)
  -- function num : 0_15
  local count = self:GetLongPressCount()
  self:_TrySubMult(count)
end

UINFactoryOrderNode._TrySubMult = function(self, count)
  -- function num : 0_16
  do
    while count ~= 0 do
      local couldAdd, reason = (self.factoryController):TryMinOneOrder(self.roomIndex, self.orderData)
      if couldAdd then
        self:RefreshOrderInfo()
        count = count - 1
      else
        count = 0
        self:ShowTipsByReason(reason)
      end
    end
    if count > 0 then
    end
  end
end

UINFactoryOrderNode.OnPressUp = function(self)
  -- function num : 0_17
  self._pressCount = 0
end

UINFactoryOrderNode.OnInputFieldEndEdit = function(self, value)
  -- function num : 0_18 , upvalues : _ENV
  local val = 0
  if not (string.IsNullOrEmpty)(value) then
    val = tonumber(value)
  end
  if val <= 0 then
    self.fileInputVal = 0
    self:OnClickMin2Least()
    return 
  end
  local diff = 0
  if self.fileInputVal ~= val then
    diff = val - self.fileInputVal
    self.fileInputVal = val
  end
  if diff == 0 then
    return 
  end
  if diff > 0 then
    self:_TryAddMult(diff)
  else
    diff = (math.abs)(diff)
    self:_TrySubMult(diff)
  end
end

UINFactoryOrderNode.GetLongPressCount = function(self)
  -- function num : 0_19 , upvalues : _ENV
  self._pressCount = self._pressCount + 1
  local count = 1
  count = count + self._pressCount // 2
  count = (math.min)(10, count)
  return count
end

UINFactoryOrderNode.ShowTipsByReason = function(self, reason)
  -- function num : 0_20 , upvalues : FactoryEnum, cs_MessageCommon, _ENV
  if reason == (FactoryEnum.eCannotAddReason).timeBeyountLimit then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Factory_BeyoundOrderTime))
  else
    if reason == (FactoryEnum.eCannotAddReason).matInsufficeient then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Factory_MatInsufficient))
    else
      if reason == (FactoryEnum.eCannotAddReason).warehouseFull then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Factory_WarehousFull))
      end
    end
  end
end

UINFactoryOrderNode.ChangeConfirmLook = function(self, couldClick)
  -- function num : 0_21 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if couldClick then
    ((self.ui).img_btn_Qucik).color = Color.white
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_Type).color = Color.white
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).tex_QuickType).text).color = Color.white
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).tex_StartType).text).color = Color.white
  else
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_btn_Qucik).color = (self.ui).color_gray
    local white = (Color.New)(1, 1, 1, 0.4)
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Type).color = white
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.ui).tex_QuickType).text).color = white
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.ui).tex_StartType).text).color = white
  end
end

UINFactoryOrderNode.RefreshOrderInfo = function(self)
  -- function num : 0_22 , upvalues : _ENV, FactoryEnum
  local Order4SendData = (self.factoryController):GetOrder4Send()
  if Order4SendData == nil or Order4SendData.curOrderNum < 1 then
    self.fileInputVal = 0
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).inputField).text = tostring(0)
    self:ChangeConfirmLook(false)
    self.costTime = 0
    if self.orderType == (FactoryEnum.eOrderType).product then
      (self.finalProductItem):SetOutPut(1, true)
      ;
      (self.productItemPool):HideAll()
      for i,emptyItem in ipairs((self.ui).emptyItemList) do
        emptyItem:SetActive(true)
      end
    else
      do
        -- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'

        if self.orderType == (FactoryEnum.eOrderType).dig then
          ((self.ui).tex_ItemCount).text = tostring(0)
        end
        self.fileInputVal = Order4SendData.curOrderNum
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((self.ui).inputField).text = tostring(Order4SendData.curOrderNum)
        self:ChangeConfirmLook(true)
        self.costTime = Order4SendData.usedTime
        if Order4SendData.orderType == (FactoryEnum.eOrderType).product then
          if self.finalProductItem ~= nil then
            (self.finalProductItem):SetOutPut(Order4SendData.curOrderNum)
          end
          if self.productItemPool ~= nil and Order4SendData.assistOrderDic ~= nil then
            local count = (table.count)(Order4SendData.assistOrderDic)
            ;
            (self.productItemPool):HideAll()
            for orderId,num in pairs(Order4SendData.assistOrderDic) do
              local subOrderItem = (self.productItemPool):GetOne()
              subOrderItem:InitProductItem((ConfigData.factory_order)[orderId], false)
              subOrderItem:SetOutPut(num)
            end
            for i,emptyItem in ipairs((self.ui).emptyItemList) do
              emptyItem:SetActive(count < i)
              ;
              (emptyItem.transform):SetAsLastSibling()
            end
          end
        else
          -- DECOMPILER ERROR at PC146: Confused about usage of register: R2 in 'UnsetPending'

          if self.orderType == (FactoryEnum.eOrderType).dig and self.orderData ~= nil then
            ((self.ui).tex_ItemCount).text = tostring(Order4SendData.curOrderNum * ((self.orderData):GetOrderCfg()).outPutItemNum)
          end
        end
        self:RefreshProductCost()
        self:RefreshEnergey()
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
end

UINFactoryOrderNode.RefreshProductCost = function(self)
  -- function num : 0_23 , upvalues : FactoryHelper, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_ConFirmCost).text = (FactoryHelper.ConvertTime2DisplayMode)(self.costTime)
  self._costEnergy = (FactoryHelper.GetFactoryTime2EnergyCost)(self.costTime)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_QuickCost).text = tostring(self._costEnergy)
end

UINFactoryOrderNode.OnClickQuickProduct = function(self)
  -- function num : 0_24 , upvalues : cs_MessageCommon, _ENV
  if not self._couldQuickProduc then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Factory_EnergyInsufficient))
    local ShopEnum = require("Game.Shop.ShopEnum")
    do
      local quickBuyData = (ShopEnum.eQuickBuy).factoryEnergy
      local shopId = quickBuyData.shopId
      local shelfId = quickBuyData.shelfId
      local goodData = nil
      local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
      ctrl:GetShopData(shopId, function(shopData)
    -- function num : 0_24_0 , upvalues : goodData, shelfId, _ENV, quickBuyData, self
    goodData = (shopData.shopGoodsDic)[shelfId]
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
      -- function num : 0_24_0_0 , upvalues : _ENV, goodData, quickBuyData, self
      if win == nil then
        error("can\'t open QuickBuy win")
        return 
      end
      win:SlideIn()
      win:InitBuyTarget(goodData, nil, true, quickBuyData.resourceIds, function()
        -- function num : 0_24_0_0_0 , upvalues : self
        if self.closeCommonRewardCallback ~= nil then
          (self.closeCommonRewardCallback)()
          self.closeCommonRewardCallback = nil
        end
      end
)
      win:OnClickAdd(true)
      if not IsNull((self.ui).quickPurchaseRoot) then
        win:SetRoot((self.ui).quickPurchaseRoot)
      end
    end
)
  end
)
      return 
    end
  end
  do
    local Order4SendData = (self.factoryController):GetOrder4Send()
    if Order4SendData == nil or Order4SendData.curOrderNum < 1 then
      return 
    end
    local orderCfg = (ConfigData.factory_order)[Order4SendData.curOrderId]
    self.rewardTable = {
rewardIds = {orderCfg.outPutItemId}
, 
rewardNums = {orderCfg.outPutItemNum * Order4SendData.curOrderNum}
}
    ;
    (self.factoryController):SendOrder(self.m_OnProduceOver)
  end
end

UINFactoryOrderNode.OnClickStartroduct = function(self)
  -- function num : 0_25 , upvalues : _ENV, cs_MessageCommon
  if ((self.factoryController).ProcessingOrders)[self.roomIndex] ~= nil and (table.count)(((self.factoryController).ProcessingOrders)[self.roomIndex]) > 0 then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Factory_AlreadyHaveOrder))
    return 
  end
  local Order4SendData = (self.factoryController):GetOrder4Send()
  if Order4SendData == nil or Order4SendData.curOrderNum < 1 then
    return 
  end
  local orderCfg = (ConfigData.factory_order)[Order4SendData.curOrderId]
  self.rewardTable = {
rewardIds = {orderCfg.outPutItemId}
, 
rewardNums = {orderCfg.outPutItemNum * Order4SendData.curOrderNum}
}
  ;
  (self.factoryController):SendOrder(self.m_OnTimeProduceSendOver, true)
  -- DECOMPILER ERROR at PC60: Unhandled construct in 'MakeBoolean' P1

  if self.isQuickProduce and self.closeQuickProduceNode ~= nil then
    self:closeQuickProduceNode()
  end
  ;
  (UIUtil.OnClickBack)()
  ;
  (UIUtil.OnClickBack)()
end

UINFactoryOrderNode.SetCloseCommonRewardCallback = function(self, closeCommonRewardCallback)
  -- function num : 0_26
  self.closeCommonRewardCallback = closeCommonRewardCallback
end

UINFactoryOrderNode.OnProduceOver = function(self)
  -- function num : 0_27 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_27_0 , upvalues : self
    if window == nil then
      return 
    end
    window:BindCommonRewardExit(self.closeCommonRewardCallback)
    window:AddNext2ShowReward((self.rewardTable).rewardIds, (self.rewardTable).rewardNums)
    self.rewardTable = nil
  end
)
  ;
  (self.factoryController):ClearOrder()
  self:RefreshOrderInfo()
end

UINFactoryOrderNode.OnTimeProduceSendOver = function(self)
  -- function num : 0_28
end

UINFactoryOrderNode.OnDelete = function(self)
  -- function num : 0_29 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
  ;
  (base.OnDelete)(self)
end

return UINFactoryOrderNode

