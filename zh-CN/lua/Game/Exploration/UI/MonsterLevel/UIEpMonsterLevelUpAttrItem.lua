local base = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UIEpMonsterLevelUpAttrItem = class("UIEpMonsterLevelUpAttrItem", base)
UIEpMonsterLevelUpAttrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIEpMonsterLevelUpAttrItem.InitMonsterLevelPreviewRowItem = function(self, index, curValue, nextValue)
  -- function num : 0_1 , upvalues : _ENV
  local sign = "+"
  ;
  ((self.ui).tex_Name):SetIndex(index)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_LastNum).text = sign .. GetPreciseDecimalStr(curValue / 10, 1) .. "%"
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_CurNum).text = sign .. GetPreciseDecimalStr(nextValue / 10, 1) .. "%"
end

return UIEpMonsterLevelUpAttrItem

