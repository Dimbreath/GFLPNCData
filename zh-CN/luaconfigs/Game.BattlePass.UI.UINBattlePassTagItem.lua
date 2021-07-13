-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBattlePassItem = require("Game.BattlePass.UI.UINBattlePassItem")
local UINBattlePassTagItem = class("UINBattlePassTagItem", UINBattlePassItem)
local UINBaseItemWithLock = require("Game.CommonUI.Item.UINBaseItemWithLock")
UINBattlePassTagItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINBattlePassItem, _ENV, UINBaseItemWithLock
  (UINBattlePassItem.OnInit)(self)
  self.baseItemPool = (UIItemPool.New)(UINBaseItemWithLock, (self.ui).baseItem)
end

UINBattlePassTagItem.__InitPassItemUI = function(self, baseItemPrefab, passLevelCfg, passInfo)
  -- function num : 0_1 , upvalues : _ENV
  self.baseItemList = {}
  self.seniorItemList = {}
  ;
  (self.baseItemPool):HideAll()
  local basepacked, baselocked, seniorpacked, seniorlocked = self:__GetRewardPackLockState(passInfo)
  self:__UpdatePickState(basepacked, baselocked, seniorpacked, seniorlocked)
  for index,itemId in pairs(passLevelCfg.base_item_ids) do
    local itemCount = (passLevelCfg.base_item_nums)[index]
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(itemId))
    else
      local baseItem = (self.baseItemPool):GetOne()
      ;
      (baseItem.transform):SetParent(((self.ui).btn_Base).transform)
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R16 in 'UnsetPending'

      ;
      (baseItem.transform).localPosition = Vector3.zero
      baseItem:InitItemWithLock(itemCfg, itemCount, nil, basepacked, baselocked)
      ;
      (table.insert)(self.baseItemList, baseItem)
    end
  end
  for index,itemId in pairs(passLevelCfg.senior_item_ids) do
    local itemCount = (passLevelCfg.senior_item_nums)[index]
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(itemId))
    else
      local baseItem = (self.baseItemPool):GetOne()
      ;
      (baseItem.transform):SetParent(((self.ui).btn_Advance).transform)
      baseItem:InitItemWithLock(itemCfg, itemCount, nil, seniorpacked, seniorlocked)
      ;
      (table.insert)(self.seniorItemList, baseItem)
    end
  end
end

UINBattlePassTagItem.__UpdatePickState = function(self, basepacked, baselocked, seniorpacked, seniorlocked)
  -- function num : 0_2
end

return UINBattlePassTagItem

