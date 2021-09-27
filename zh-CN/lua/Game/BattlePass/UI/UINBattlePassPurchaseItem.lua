local UINBattlePassPurchaseItem = class("UINBattlePassPurchaseItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINBattlePassPurchaseItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnBtnPassBuyClicked)
  ;
  ((self.ui).baseItem):SetActive(false)
  ;
  ((self.ui).spItem):SetActive(false)
  self.baseRewardPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).baseItem)
  self.spRewardPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).spItem)
end

UINBattlePassPurchaseItem.InitPassPurchaseItem = function(self, purchaseType, isUltimate, passInfo, buyEvent)
  -- function num : 0_1
  self.purchaseType = purchaseType
  self.isUltimate = isUltimate
  self.passInfo = passInfo
  self.buyEvent = buyEvent
  self:InitPassReward()
end

UINBattlePassPurchaseItem.InitPassReward = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local passCfg = (self.passInfo).passCfg
  local tag_items = ((ConfigData.battlepass).tag_items)[passCfg.id]
  if tag_items == nil then
    error("battle pass cfg is null,id:" .. tostring(passCfg.id))
    return 
  end
  for index,itemId in pairs(tag_items.item_ids) do
    local itemCount = (tag_items.item_nums)[index]
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(itemId))
    end
    local baseItem = (self.baseRewardPool):GetOne()
    baseItem:InitItemWithCount(itemCfg, itemCount)
  end
  ;
  ((self.ui).spGetlNode):SetActive(self.isUltimate)
  if self.isUltimate then
    local item_ids, item_nums = (self.passInfo):GetPassUltmateReward()
    for index,itemId in pairs(item_ids) do
      local itemCount = item_nums[index]
      local itemCfg = (ConfigData.item)[itemId]
      if itemCfg == nil then
        error("item cfg is null,id:" .. tostring(itemId))
      end
      local baseItem = (self.spRewardPool):GetOne()
      baseItem:InitItemWithCount(itemCfg, itemCount)
    end
    local payCtr = ControllerManager:GetController(ControllerTypeId.Pay, true)
    -- DECOMPILER ERROR at PC92: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Price).text = payCtr:GetPayPriceShow(passCfg.ultimate_price)
  else
    do
      local payCtr = ControllerManager:GetController(ControllerTypeId.Pay, true)
      -- DECOMPILER ERROR at PC105: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Price).text = payCtr:GetPayPriceShow(passCfg.senior_price)
    end
  end
end

UINBattlePassPurchaseItem.OnBtnPassBuyClicked = function(self)
  -- function num : 0_3
  if self.buyEvent ~= nil then
    (self.buyEvent)((self.passInfo).id, self.purchaseType)
  end
end

UINBattlePassPurchaseItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINBattlePassPurchaseItem

