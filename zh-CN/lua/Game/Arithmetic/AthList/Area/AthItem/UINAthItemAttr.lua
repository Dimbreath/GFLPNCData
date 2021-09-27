local UINAthItemAttr = class("UINAthItemAttr", UIBaseNode)
local base = UIBaseNode
local AthEnum = require("Game.Arithmetic.ArthmeticEnum")
UINAthItemAttr.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.defaultBgColor = ((self.ui).img_Bg).color
end

UINAthItemAttr.InitAthItemAttr = function(self, attrId, attrValue, isMain, quality)
  -- function num : 0_1 , upvalues : _ENV, AthEnum
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(icon)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_AddNum).text = valueStr
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

  if isMain then
    ((self.ui).img_Bg).color = (AthEnum.AthColor)[quality]
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).color = Color.white
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).tex_AddNum).color = Color.white
    return 
  end
  local subAttrColor = (AthEnum.AthQualityColor)[quality]
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).img_Bg).color = self.defaultBgColor
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).color = subAttrColor
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_AddNum).color = subAttrColor
end

UINAthItemAttr.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthItemAttr

