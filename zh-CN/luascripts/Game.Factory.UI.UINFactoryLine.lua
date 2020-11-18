-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryLine = class("UINFactoryLine", UIBaseNode)
local UINFactoryLineItem = require("Game.Factory.UI.UINFactoryLineItem")
local UICommonItem = require("Game.CommonUI.Item.UICommonItem")
UINFactoryLine.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnAdd, self, self.OnBtnAddLineClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnSubtract, self, self.OnBtnSubLineClicked)
  ;
  ((self.ui).resItemGO):SetActive(false)
  self.produceItem = nil
  self.consumeItems = {}
end

UINFactoryLine.InitLineFormula = function(self, factoryCfg, isUnlock, uiParent)
  -- function num : 0_1 , upvalues : _ENV
  self.isUnlock = isUnlock
  self.factoryCfg = factoryCfg
  self.uiParent = uiParent
  if not self.isUnlock then
    ((self.ui).lineCountNode):SetActive(false)
    ;
    (((self.ui).failNode).gameObject):SetActive(true)
    ;
    ((self.ui).tex_Fail):SetIndex(0, (CheckCondition.GetUnlockInfoLua)(factoryCfg.pre_condition, factoryCfg.pre_para1, factoryCfg.pre_para2))
  end
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(factoryCfg.name)
  self:InitProduce()
  self:InitConsume()
end

UINFactoryLine.InitProduce = function(self)
  -- function num : 0_2 , upvalues : _ENV, UICommonItem
  local productId = (self.factoryCfg).productId
  local productNum = (self.factoryCfg).productNum
  local itemCfg = (ConfigData.item)[productId]
  if itemCfg == nil then
    error("factory line Item Cfg is null,ItemId:" .. tostring(productId))
    return 
  end
  self.produceItem = (UICommonItem.New)()
  ;
  (self.produceItem):Init((self.ui).finalItem)
  ;
  (self.produceItem):InitItem(itemCfg, productNum, nil)
end

UINFactoryLine.InitConsume = function(self)
  -- function num : 0_3 , upvalues : _ENV, UINFactoryLineItem
  local lastItem = nil
  for k,consumeId in ipairs((self.factoryCfg).consumeIds) do
    local consumeNum = ((self.factoryCfg).consumeNums)[k] * (self.factoryCfg).cycle
    local itemCfg = (ConfigData.item)[consumeId]
    if itemCfg == nil then
      error("factory line Item Cfg is null,ItemId:" .. tostring(consumeId))
    else
      local go = ((self.ui).resItemGO):Instantiate()
      go:SetActive(true)
      local consumeItem = (UINFactoryLineItem.New)()
      consumeItem:Init(go)
      consumeItem:InitLineItem(itemCfg, consumeNum, false)
      lastItem = consumeItem
      ;
      (table.insert)(self.consumeItems, consumeItem)
    end
  end
  if lastItem ~= nil then
    lastItem:SetSignActive(false)
  end
end

UINFactoryLine.SetHighlightItem = function(self, itemId)
  -- function num : 0_4 , upvalues : _ENV
  for k,consumeItem in ipairs(self.consumeItems) do
    consumeItem:SetHightlightActive(itemId ~= nil and itemId == consumeItem.itemId)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINFactoryLine.SetOpenNumber = function(self, number)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_LineCount).text = tostring(number)
end

UINFactoryLine.OnBtnAddLineClicked = function(self)
  -- function num : 0_6
  if self.uiParent ~= nil then
    (self.uiParent):SetFactoryLineMaxCycle(self)
  end
end

UINFactoryLine.OnBtnSubLineClicked = function(self)
  -- function num : 0_7
  if self.uiParent ~= nil then
    (self.uiParent):RequestSubOneFactoryLine(self)
  end
end

return UINFactoryLine

