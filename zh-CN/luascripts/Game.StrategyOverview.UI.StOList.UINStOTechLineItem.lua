-- params : ...
-- function num : 0 , upvalues : _ENV
local UINStOTechLineItem = class("UINStOTechLineItem", UIBaseNode)
local base = UIBaseNode
UINStOTechLineItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINStOTechLineItem.InitStOTechLineItem = function(self, startPos, endPos)
  -- function num : 0_1 , upvalues : _ENV
  local sizeDelta = (self.transform).sizeDelta
  sizeDelta.y = (math.abs)(startPos.y - endPos.y)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.transform).sizeDelta = sizeDelta
end

UINStOTechLineItem.RefreshStOTechLineItem = function(self, valid)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not valid or not Color.white then
    ((self.ui).img).color = Color.gray
  end
end

UINStOTechLineItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINStOTechLineItem

