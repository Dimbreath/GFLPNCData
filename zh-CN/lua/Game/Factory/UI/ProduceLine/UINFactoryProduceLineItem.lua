local UINFactoryProduceLineItem = class("UINFactoryProduceLineItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local FactoryHelper = require("Game.Factory.FactoryHelper")
local cs_MessageCommon = CS.MessageCommon
UINFactoryProduceLineItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItemWithCount = (UINBaseItemWithCount.New)()
  ;
  (self.baseItemWithCount):Init((self.ui).obj_uINBaseItemWithCount)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Stop, self, self.OnClickStop)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Immed, self, self.OnClickQuickFinish)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Pick, self, self.OnClickPickReward)
end

UINFactoryProduceLineItem.InitProduceLineItem = function(self, processingData)
  -- function num : 0_1 , upvalues : _ENV
  self.processingData = processingData
  ;
  (self.baseItemWithCount):InitItemWithCount(processingData:GetOutputItemCfg(), processingData:GetOutputItemProduceNum())
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)((processingData:GetOutputItemCfg()).name)
  self:OnTimeUpdate()
  self:RefreshEnergey()
end

UINFactoryProduceLineItem.OnTimeUpdate = function(self)
  -- function num : 0_2 , upvalues : FactoryHelper, _ENV
  local isFinish = (self.processingData):GetIsFinish()
  ;
  (((self.ui).btn_Stop).gameObject):SetActive(not isFinish)
  ;
  (((self.ui).btn_Immed).gameObject):SetActive(not isFinish)
  ;
  (((self.ui).btn_Pick).gameObject):SetActive(isFinish)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  if not isFinish then
    ((self.ui).tex_Time).text = (FactoryHelper.ConvertTime2DisplayMode)((self.processingData):GetLeftProcessTime())
    local emerguCost = (self.processingData):GetLeftProcessEnergy()
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_CostEnergy).text = tostring(emerguCost)
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).slider_processRate).value = (self.processingData):GetProcessRate()
    ;
    ((self.ui).tex_State):SetIndex(0)
  else
    do
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).tex_Time).text = (FactoryHelper.ConvertTime2DisplayMode)(0)
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).slider_processRate).value = 1
      ;
      ((self.ui).tex_State):SetIndex(1)
    end
  end
end

UINFactoryProduceLineItem.RefreshEnergey = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local value, ceiling = (self.factoryController):GetRoomEnegeyByIndex(self.roomIndex)
  if value == self.cacheEnergy then
    return 
  end
  self.cacheEnergy = value
  self._couldQuickProduc = (self.processingData):GetLeftProcessEnergy() <= value
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  if self._couldQuickProduc then
    ((self.ui).img_btn_Immed).color = Color.white
  else
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

    ((self.ui).img_btn_Immed).color = (self.ui).color_gray
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINFactoryProduceLineItem.OnClickStop = function(self)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV
  (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(TipContent.Factory_ConfirmDeleteOrder), function()
    -- function num : 0_4_0 , upvalues : self
    (self.factoryController):CancleOrder(self.processingData)
  end
, nil)
end

UINFactoryProduceLineItem.OnClickQuickFinish = function(self)
  -- function num : 0_5 , upvalues : cs_MessageCommon, _ENV
  if (self.factoryController):GetRoomEnegeyByIndex() < (self.processingData):GetLeftProcessEnergy() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Factory_EnergyInsufficient))
    local ShopEnum = require("Game.Shop.ShopEnum")
    do
      local quickBuyData = (ShopEnum.eQuickBuy).factoryEnergy
      local shopId = quickBuyData.shopId
      local shelfId = quickBuyData.shelfId
      local goodData = nil
      local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
      ctrl:GetShopData(shopId, function(shopData)
    -- function num : 0_5_0 , upvalues : goodData, shelfId, _ENV, quickBuyData, self
    goodData = (shopData.shopGoodsDic)[shelfId]
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
      -- function num : 0_5_0_0 , upvalues : _ENV, goodData, quickBuyData, self
      if win == nil then
        error("can\'t open QuickBuy win")
        return 
      end
      win:SlideIn()
      win:InitBuyTarget(goodData, nil, true, quickBuyData.resourceIds, function()
        -- function num : 0_5_0_0_0 , upvalues : self
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
    ;
    (self.factoryController):QuickFinishOrder(self.processingData)
  end
end

UINFactoryProduceLineItem.OnClickPickReward = function(self)
  -- function num : 0_6
  (self.factoryController):PickOrderReward(self.processingData)
end

UINFactoryProduceLineItem.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINFactoryProduceLineItem

