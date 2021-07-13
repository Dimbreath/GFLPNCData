-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroAttrItem = class("UINHeroAttrItem", UIBaseNode)
local base = UIBaseNode
UINHeroAttrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.color_ori = ((self.ui).tex_Num).color
end

UINHeroAttrItem.InitHeroAttrItem = function(self, attrId, attrValue, overriodColor)
  -- function num : 0_1 , upvalues : _ENV
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(icon)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_attrName).text = name
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

  if not overriodColor then
    ((self.ui).tex_Num).color = self.color_ori
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_Num).text = valueStr
  end
end

UINHeroAttrItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroAttrItem

