-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.CommonUI.Item.UINChipItem")
local UINChipItemWithName = class("UINChipItemWithName", base)
UINChipItemWithName.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, base
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.LuaUIBindingTable)((self.ui).baseTransform, self.ui)
  ;
  (base.OnInit)(self)
end

UINChipItemWithName.UpdateChipItem = function(self)
  -- function num : 0_1 , upvalues : base
  (base.UpdateChipItem)(self)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).name).text = (self:GetChipData()):GetName()
end

UINChipItemWithName.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINChipItemWithName

