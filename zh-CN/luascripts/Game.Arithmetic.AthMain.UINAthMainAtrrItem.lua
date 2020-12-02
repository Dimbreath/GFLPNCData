-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthMainAtrrItem = class("UINAthMainAtrrItem", UIBaseNode)
local base = UIBaseNode
UINAthMainAtrrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthMainAtrrItem.InitAthMainAtrrItem = function(self, attrId, attrValue)
  -- function num : 0_1 , upvalues : _ENV
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_attrName).text = name
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Num).text = valueStr
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(icon)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).alpha = attrValue == 0 and 0.5 or 1
end

UINAthMainAtrrItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthMainAtrrItem

