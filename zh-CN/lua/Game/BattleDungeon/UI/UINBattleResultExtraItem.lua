local UINBattleResultExtraItem = class("UINBattleResultExtraItem", UIBaseNode)
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINBattleResultExtraItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItemWithCount.New)()
  ;
  (self.baseItem):Init((self.ui).uINBaseItem)
end

UINBattleResultExtraItem.InitBattleExtraReward = function(self, itemCfg, num)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  ;
  (self.baseItem):InitItemWithCount(itemCfg, num)
end

UINBattleResultExtraItem.OnDelete = function(self)
  -- function num : 0_2
end

return UINBattleResultExtraItem

