-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthInfoAttrItem = class("UIAthInfoAttrItem", UIBaseNode)
local base = UIBaseNode
UIAthInfoAttrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIAthInfoAttrItem.InitAthInfoAttrItem = function(self, attrId, count1, count2)
  -- function num : 0_1 , upvalues : _ENV
  local attrCfg = (ConfigData.attribute)[attrId]
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  if not IsNull(attrCfg.icon) then
    ((self.ui).img_Icon).sprite = CRH:GetSprite(attrCfg.icon)
  end
  local name = ConfigData:GetAttribute(attrId)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_AttriName).text = name
  local _, value1 = ConfigData:GetAttribute(attrId, count1)
  if count2 == nil then
    ((self.ui).tex_AttriCount):SetIndex(0, value1)
  else
    local _, value2 = ConfigData:GetAttribute(attrId, count2)
    ;
    ((self.ui).tex_AttriCount):SetIndex(1, value1, value2)
  end
end

UIAthInfoAttrItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UIAthInfoAttrItem

