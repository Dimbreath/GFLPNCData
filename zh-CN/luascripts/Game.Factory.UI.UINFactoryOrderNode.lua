-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryOrderNode = class("UINFactoryOrderNode", UIBaseNode)
local base = UIBaseNode
local FactoryEnum = require("Game.Factory.FactoryEnum")
local UINFactoryOrderNodeProductItem = require("Game.Factory.UI.UINFactoryOrderNodeProductItem")
local cs_MessageCommon = CS.MessageCommon
UINFactoryOrderNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, FactoryEnum
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.orderType = (FactoryEnum.eOrderType).dig
  self.costEnergy = 0
  self.cacheEnergy = 0
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.OnClickAdd)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Max, self, self.OnClickAdd2Max)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Min, self, self.OnClickMin)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Least, self, self.OnClickMin2Least)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickStartProduce)
  self.m_OnProduceOver = BindCallback(self, self.OnProduceOver)
end

UINFactoryOrderNode.InitOrderNode = function(self, roomIndex)
  -- function num : 0_1
  self.roomIndex = roomIndex
  ;
  (self.factoryController):ClearOrder()
  self:RefreshOrderInfo()
end

UINFactoryOrderNode.ShowOrder = function(self, orderData)
  -- function num : 0_2 , upvalues : FactoryEnum
  if self.orderData ~= orderData then
    (self.factoryController):ClearOrder()
    self.orderData = orderData
    self.orderCfg = orderData.cfg
    self.orderType = (self.orderCfg).type
    ;
    ((self.ui).tex_Type):SetIndex((self.orderCfg).type - 1)
    ;
    ((self.ui).tex_From):SetIndex((self.orderCfg).type - 1)
    if self.orderType == (FactoryEnum.eOrderType).dig then
      self:ShowDigOrder()
    else
      if self.orderType == (FactoryEnum.eOrderType).produce then
        self:ShowProduceOrder()
      end
    end
    self:RefreshOrderInfo()
  end
end

UINFactoryOrderNode.RefreshEnergeyBar = function(self, isUpdate)
  -- function num : 0_3 , upvalues : _ENV
  local value, ceiling = (self.factoryController):GetRoomEnegeyByIndex(self.roomIndex)
  if isUpdate and value == self.cacheEnergy then
    return 
  end
  self.cacheEnergy = value
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Consume).fillAmount = value / ceiling
  local remainEnergy = value - self.costEnergy
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Energy).fillAmount = remainEnergy / ceiling
  ;
  ((self.ui).tex_Energy):SetIndex(0, tostring(remainEnergy), tostring(ceiling))
end

UINFactoryOrderNode.UpdateEnergy = function(self)
  -- function num : 0_4
  self:RefreshEnergeyBar(true)
end

UINFactoryOrderNode.ShowDigOrder = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((self.ui).itemNode):SetActive(true)
  ;
  ((self.ui).formulaNode):SetActive(false)
  local itemCfg = (ConfigData.item)[(self.orderCfg).outPutItemId]
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_ItemIcon).sprite = CRH:GetSprite(itemCfg.icon)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
end

UINFactoryOrderNode.ShowProduceOrder = function(self)
  -- function num : 0_6 , upvalues : UINFactoryOrderNodeProductItem, _ENV
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
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)((self.orderCfg).name)
end

UINFactoryOrderNode.OnClickAdd = function(self)
  -- function num : 0_7 , upvalues : FactoryEnum, cs_MessageCommon, _ENV
  local couldAdd, reason = (self.factoryController):TryAddOneOrder(self.roomIndex, self.orderData)
  if couldAdd then
    self:RefreshOrderInfo()
  else
    if reason == (FactoryEnum.eCannotAddReason).energyInsufficeient then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Factory_EnergyInsufficient))
    else
      if reason == (FactoryEnum.eCannotAddReason).matInsufficeient then
        (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Factory_MatInsufficient))
      else
        if reason == (FactoryEnum.eCannotAddReason).warehouseFull then
          (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Factory_WarehousFull))
        end
      end
    end
  end
end

UINFactoryOrderNode.OnClickAdd2Max = function(self)
  -- function num : 0_8
  local couldAdd = (self.factoryController):TryAddMaxOrder(self.roomIndex, self.orderData)
  if couldAdd then
    self:RefreshOrderInfo()
  end
end

UINFactoryOrderNode.OnClickMin = function(self)
  -- function num : 0_9
  local couldMin = (self.factoryController):TryMinOneOrder(self.roomIndex, self.orderData)
  if couldMin then
    self:RefreshOrderInfo()
  end
end

UINFactoryOrderNode.OnClickMin2Least = function(self)
  -- function num : 0_10
  (self.factoryController):ClearOrder()
  self:RefreshOrderInfo()
end

UINFactoryOrderNode.ChangeConfirmLook = function(self, couldClick)
  -- function num : 0_11 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if couldClick then
    ((self.ui).img_btn_Confirm).color = (self.ui).color_orange
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_Type).color = Color.white
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).tex_Type).text).color = Color.white
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_btn_Confirm).color = (self.ui).color_gray
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_Type).color = (Color.New)(1, 1, 1, 0.4)
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).tex_Type).text).color = (Color.New)(1, 1, 1, 0.4)
  end
end

UINFactoryOrderNode.RefreshOrderInfo = function(self)
  -- function num : 0_12 , upvalues : _ENV, FactoryEnum
  local orderData = (self.factoryController):GetOrder()
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  if orderData == nil or orderData.curOrderNum < 1 then
    ((self.ui).tex_Count).text = tostring(0)
    self:ChangeConfirmLook(false)
    self.costEnergy = 0
    if self.orderType == (FactoryEnum.eOrderType).produce then
      (self.finalProductItem):SetOutPut(1, true)
      ;
      (self.productItemPool):HideAll()
      for i,emptyItem in ipairs((self.ui).emptyItemList) do
        emptyItem:SetActive(true)
      end
    else
      do
        -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

        if self.orderType == (FactoryEnum.eOrderType).dig then
          ((self.ui).tex_ItemCount).text = tostring(0)
        end
        -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((self.ui).tex_Count).text = tostring(orderData.curOrderNum)
        self:ChangeConfirmLook(true)
        self.costEnergy = orderData.usedEnergy
        if orderData.orderType == (FactoryEnum.eOrderType).produce then
          (self.finalProductItem):SetOutPut(orderData.curOrderNum)
          if orderData.assistOrderDic ~= nil then
            local count = (table.count)(orderData.assistOrderDic)
            ;
            (self.productItemPool):HideAll()
            for orderId,num in pairs(orderData.assistOrderDic) do
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
          -- DECOMPILER ERROR at PC133: Confused about usage of register: R2 in 'UnsetPending'

          if self.orderType == (FactoryEnum.eOrderType).dig then
            ((self.ui).tex_ItemCount).text = tostring(orderData.curOrderNum * ((self.orderData).cfg).outPutItemNum)
          end
        end
        self:RefreshEnergeyBar()
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
end

UINFactoryOrderNode.OnClickStartProduce = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local orderData = (self.factoryController):GetOrder()
  if orderData == nil or orderData.curOrderNum < 1 then
    return 
  end
  local orderCfg = (ConfigData.factory_order)[orderData.curOrderId]
  self.rewardTable = {
rewardIds = {orderCfg.outPutItemId}
, 
rewardNums = {orderCfg.outPutItemNum * orderData.curOrderNum}
}
  ;
  (self.factoryController):SendOrder(self.m_OnProduceOver)
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
end

UINFactoryOrderNode.OnProduceOver = function(self)
  -- function num : 0_14 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_14_0 , upvalues : _ENV, self
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    if window == nil then
      return 
    end
    window:InitRewardsItem((self.rewardTable).rewardIds, (self.rewardTable).rewardNums)
    self.rewardTable = nil
  end
)
  ;
  (self.factoryController):ClearOrder()
  self:RefreshOrderInfo()
end

UINFactoryOrderNode.OnDelete = function(self)
  -- function num : 0_15 , upvalues : base
  (base.OnDelete)(self)
end

return UINFactoryOrderNode

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryOrderNode = class("UINFactoryOrderNode", UIBaseNode)
local base = UIBaseNode
local FactoryEnum = require("Game.Factory.FactoryEnum")
local UINFactoryOrderNodeProductItem = require(
                                           "Game.Factory.UI.UINFactoryOrderNodeProductItem")
local cs_MessageCommon = CS.MessageCommon
UINFactoryOrderNode.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, FactoryEnum
    self.factoryController = ControllerManager:GetController(
                                 ControllerTypeId.Factory, false)
    self.orderType = (FactoryEnum.eOrderType).dig
    self.costEnergy = 0
    self.cacheEnergy = 0;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.OnClickAdd);
    (UIUtil.AddButtonListener)((self.ui).btn_Max, self, self.OnClickAdd2Max);
    (UIUtil.AddButtonListener)((self.ui).btn_Min, self, self.OnClickMin);
    (UIUtil.AddButtonListener)((self.ui).btn_Least, self, self.OnClickMin2Least);
    (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self,
                               self.OnClickStartProduce)
    self.m_OnProduceOver = BindCallback(self, self.OnProduceOver)
end

UINFactoryOrderNode.InitOrderNode = function(self, roomIndex)
    -- function num : 0_1
    self.roomIndex = roomIndex;
    (self.factoryController):ClearOrder()
    self:RefreshOrderInfo()
end

UINFactoryOrderNode.ShowOrder = function(self, orderData)
    -- function num : 0_2 , upvalues : FactoryEnum
    if self.orderData ~= orderData then
        (self.factoryController):ClearOrder()
        self.orderData = orderData
        self.orderCfg = orderData.cfg
        self.orderType = (self.orderCfg).type;
        ((self.ui).tex_Type):SetIndex((self.orderCfg).type - 1);
        ((self.ui).tex_From):SetIndex((self.orderCfg).type - 1)
        if self.orderType == (FactoryEnum.eOrderType).dig then
            self:ShowDigOrder()
        else
            if self.orderType == (FactoryEnum.eOrderType).produce then
                self:ShowProduceOrder()
            end
        end
        self:RefreshOrderInfo()
    end
end

UINFactoryOrderNode.RefreshEnergeyBar = function(self, isUpdate)
    -- function num : 0_3 , upvalues : _ENV
    local value, ceiling = (self.factoryController):GetRoomEnegeyByIndex(
                               self.roomIndex)
    if isUpdate and value == self.cacheEnergy then return end
    self.cacheEnergy = value -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).img_Consume).fillAmount = value / ceiling
    local remainEnergy = value - self.costEnergy -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_Energy).fillAmount = remainEnergy / ceiling;
    ((self.ui).tex_Energy):SetIndex(0, tostring(remainEnergy), tostring(ceiling))
end

UINFactoryOrderNode.UpdateEnergy = function(self)
    -- function num : 0_4
    self:RefreshEnergeyBar(true)
end

UINFactoryOrderNode.ShowDigOrder = function(self)
    -- function num : 0_5 , upvalues : _ENV
    ((self.ui).itemNode):SetActive(true);
    ((self.ui).formulaNode):SetActive(false)
    local itemCfg = (ConfigData.item)[(self.orderCfg).outPutItemId] -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).img_ItemIcon).sprite = CRH:GetSprite(itemCfg.icon) -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
end

UINFactoryOrderNode.ShowProduceOrder = function(self)
    -- function num : 0_6 , upvalues : UINFactoryOrderNodeProductItem, _ENV
    ((self.ui).itemNode):SetActive(false);
    ((self.ui).formulaNode):SetActive(true)
    if self.finalProductItem == nil then
        self.finalProductItem = (UINFactoryOrderNodeProductItem.New)();
        (self.finalProductItem):Init((self.ui).finalFormulaItem)
    end
    if self.productItemPool == nil then
        self.productItemPool = (UIItemPool.New)(UINFactoryOrderNodeProductItem,
                                                (self.ui).formulaItem);
        ((self.ui).formulaItem):SetActive(false)
    end
    (self.finalProductItem):InitProductItem(self.orderCfg, true) -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)(
                                        (self.orderCfg).name)
end

UINFactoryOrderNode.OnClickAdd = function(self)
    -- function num : 0_7 , upvalues : FactoryEnum, cs_MessageCommon, _ENV
    local couldAdd, reason = (self.factoryController):TryAddOneOrder(
                                 self.roomIndex, self.orderData)
    if couldAdd then
        self:RefreshOrderInfo()
    else
        if reason == (FactoryEnum.eCannotAddReason).energyInsufficeient then
            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.Factory_EnergyInsufficient))
        else
            if reason == (FactoryEnum.eCannotAddReason).matInsufficeient then
                (cs_MessageCommon.ShowMessageTips)(
                    ConfigData:GetTipContent(TipContent.Factory_MatInsufficient))
            else
                if reason == (FactoryEnum.eCannotAddReason).warehouseFull then
                    (cs_MessageCommon.ShowMessageTips)(
                        ConfigData:GetTipContent(TipContent.Factory_WarehousFull))
                end
            end
        end
    end
end

UINFactoryOrderNode.OnClickAdd2Max = function(self)
    -- function num : 0_8
    local couldAdd = (self.factoryController):TryAddMaxOrder(self.roomIndex,
                                                             self.orderData)
    if couldAdd then self:RefreshOrderInfo() end
end

UINFactoryOrderNode.OnClickMin = function(self)
    -- function num : 0_9
    local couldMin = (self.factoryController):TryMinOneOrder(self.roomIndex,
                                                             self.orderData)
    if couldMin then self:RefreshOrderInfo() end
end

UINFactoryOrderNode.OnClickMin2Least = function(self)
    -- function num : 0_10
    (self.factoryController):ClearOrder()
    self:RefreshOrderInfo()
end

UINFactoryOrderNode.ChangeConfirmLook = function(self, couldClick)
    -- function num : 0_11 , upvalues : _ENV
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

    if couldClick then
        ((self.ui).img_btn_Confirm).color = (self.ui).color_orange -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).img_Type).color = Color.white -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'
        ;
        (((self.ui).tex_Type).text).color = Color.white
    else
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'


        ((self.ui).img_btn_Confirm).color = (self.ui).color_gray -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).img_Type).color = (Color.New)(1, 1, 1, 0.4) -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'
        ;
        (((self.ui).tex_Type).text).color = (Color.New)(1, 1, 1, 0.4)
    end
end

UINFactoryOrderNode.RefreshOrderInfo = function(self)
    -- function num : 0_12 , upvalues : _ENV, FactoryEnum
    local orderData = (self.factoryController):GetOrder()
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    if orderData == nil or orderData.curOrderNum < 1 then
        ((self.ui).tex_Count).text = tostring(0)
        self:ChangeConfirmLook(false)
        self.costEnergy = 0
        if self.orderType == (FactoryEnum.eOrderType).produce then
            (self.finalProductItem):SetOutPut(1, true);
            (self.productItemPool):HideAll()
            for i, emptyItem in ipairs((self.ui).emptyItemList) do
                emptyItem:SetActive(true)
            end
        else
            do
                -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

                if self.orderType == (FactoryEnum.eOrderType).dig then
                    ((self.ui).tex_ItemCount).text = tostring(0)
                end -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'
                
                ((self.ui).tex_Count).text = tostring(orderData.curOrderNum)
                self:ChangeConfirmLook(true)
                self.costEnergy = orderData.usedEnergy
                if orderData.orderType == (FactoryEnum.eOrderType).produce then
                    (self.finalProductItem):SetOutPut(orderData.curOrderNum)
                    if orderData.assistOrderDic ~= nil then
                        local count = (table.count)(orderData.assistOrderDic);
                        (self.productItemPool):HideAll()
                        for orderId, num in pairs(orderData.assistOrderDic) do
                            local subOrderItem = (self.productItemPool):GetOne()
                            subOrderItem:InitProductItem(
                                (ConfigData.factory_order)[orderId], false)
                            subOrderItem:SetOutPut(num)
                        end
                        for i, emptyItem in ipairs((self.ui).emptyItemList) do
                            emptyItem:SetActive(count < i);
                            (emptyItem.transform):SetAsLastSibling()
                        end
                    end
                else
                    -- DECOMPILER ERROR at PC133: Confused about usage of register: R2 in 'UnsetPending'

                    if self.orderType == (FactoryEnum.eOrderType).dig then
                        ((self.ui).tex_ItemCount).text =
                            tostring(orderData.curOrderNum *
                                         ((self.orderData).cfg).outPutItemNum)
                    end
                end
                self:RefreshEnergeyBar()
                -- DECOMPILER ERROR: 4 unprocessed JMP targets
            end
        end
    end
end

UINFactoryOrderNode.OnClickStartProduce =
    function(self)
        -- function num : 0_13 , upvalues : _ENV
        local orderData = (self.factoryController):GetOrder()
        if orderData == nil or orderData.curOrderNum < 1 then return end
        local orderCfg = (ConfigData.factory_order)[orderData.curOrderId]
        self.rewardTable = {
            rewardIds = {orderCfg.outPutItemId},
            rewardNums = {orderCfg.outPutItemNum * orderData.curOrderNum}
        };
        (self.factoryController):SendOrder(self.m_OnProduceOver);
        (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil,
                                                                          nil,
                                                                          nil,
                                                                          Color.clear,
                                                                          false)
    end

UINFactoryOrderNode.OnProduceOver = function(self)
    -- function num : 0_14 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        -- function num : 0_14_0 , upvalues : _ENV, self
        UIManager:HideWindow(UIWindowTypeID.ClickContinue)
        if window == nil then return end
        window:InitRewardsItem((self.rewardTable).rewardIds,
                               (self.rewardTable).rewardNums)
        self.rewardTable = nil
    end);
    (self.factoryController):ClearOrder()
    self:RefreshOrderInfo()
end

UINFactoryOrderNode.OnDelete = function(self)
    -- function num : 0_15 , upvalues : base
    (base.OnDelete)(self)
end

return UINFactoryOrderNode

