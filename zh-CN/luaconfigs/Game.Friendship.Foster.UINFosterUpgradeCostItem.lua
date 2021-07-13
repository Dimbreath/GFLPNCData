-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFosterUpgradeCostItem = class("UINFosterUpgradeCostItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINFosterUpgradeCostItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFosterUpgradeCostItem.InitCostItem = function(self, itemId, num)
  -- function num : 0_1 , upvalues : _ENV, UINBaseItem
  self.requireNum = num
  self.itemId = itemId
  self.itemNum = PlayerDataCenter:GetItemCount(self.itemId)
  local itemCfg = (ConfigData.item)[itemId]
  if self:IsHaveEnoughItem() then
    ((self.ui).tex_TotalCount):SetIndex(1, tostring(num), tostring(self.itemNum))
  else
    ;
    ((self.ui).tex_TotalCount):SetIndex(2, tostring(num), tostring(self.itemNum))
  end
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  local item = (UINBaseItem.New)()
  item:Init((self.ui).obj_BaseItem)
  item:InitBaseItem(itemCfg)
end

UINFosterUpgradeCostItem.IsHaveEnoughItem = function(self)
  -- function num : 0_2
  if self.requireNum <= self.itemNum then
    return true
  end
  return false
end

UINFosterUpgradeCostItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINFosterUpgradeCostItem

