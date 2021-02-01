-- params : ...
-- function num : 0 , upvalues : _ENV
local UINStOUnlockConditionItem = class("UINStOUnlockConditionItem", UIBaseNode)
local base = UIBaseNode
UINStOUnlockConditionItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINStOUnlockConditionItem.InitStOUnlockConditionItem = function(self, ok, conditionStr)
  -- function num : 0_1
  ;
  ((self.ui).img_Root):SetIndex(ok and 1 or 0)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Condition).text = conditionStr
end

UINStOUnlockConditionItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINStOUnlockConditionItem

