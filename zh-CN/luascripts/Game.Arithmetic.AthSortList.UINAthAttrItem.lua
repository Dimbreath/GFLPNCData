-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthAttrItem = class("UINAthAttrItem", UIBaseNode)
local base = UIBaseNode
UINAthAttrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthAttrItem.InitAthAttrItem = function(self, attrId, attrValue, color)
  -- function num : 0_1 , upvalues : _ENV
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(icon)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Num).text = valueStr
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).color = color
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Num).color = color
end

UINAthAttrItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthAttrItem

