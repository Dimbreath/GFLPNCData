-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthMainAtrrItem = class("UINAthMainAtrrItem", UIBaseNode)
local base = UIBaseNode
UINAthMainAtrrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthMainAtrrItem.InitAthMainAtrrItem = function(self, attrId, attrValue, attrValueExtra)
  -- function num : 0_1 , upvalues : _ENV
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_attrName).text = name
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(icon)
  if attrValueExtra == 0 then
    ((self.ui).tex_Num):SetIndex(0, valueStr)
  else
    local _, valueExtraStr = ConfigData:GetAttribute(attrId, attrValueExtra)
    ;
    ((self.ui).tex_Num):SetIndex(1, valueStr, valueExtraStr)
  end
  do
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).canvasGroup).alpha = attrValue == 0 and 0.5 or 1
  end
end

UINAthMainAtrrItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthMainAtrrItem

