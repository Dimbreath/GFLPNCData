-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFosterUnlockRewardItem = class("UINFosterUnlockRewardItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINFosterUnlockRewardItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFosterUnlockRewardItem.InitItem = function(self, itemId, num)
  -- function num : 0_1 , upvalues : _ENV, UINBaseItem
  local itemCfg = (ConfigData.item)[itemId]
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_TotalCount).text = tostring(num)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  local baseItem = (UINBaseItem.New)()
  baseItem:Init((self.ui).obj_BaseItem)
  baseItem:InitBaseItem(itemCfg, nil)
end

UINFosterUnlockRewardItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINFosterUnlockRewardItem

