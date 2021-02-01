-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthAttrTogItem = class("UINAthAttrTogItem", UIBaseNode)
local base = UIBaseNode
UINAthAttrTogItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthAttrTogItem.ChangeAthAttrTogItem = function(self, isOn)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not isOn or not Color.black then
    ((self.ui).img_Icon).color = Color.white
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    if not isOn or not Color.black then
      ((self.ui).tex).color = Color.white
    end
  end
end

UINAthAttrTogItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthAttrTogItem

