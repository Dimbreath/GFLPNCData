-- params : ...
-- function num : 0 , upvalues : _ENV
local UIPieItem = class("UIPieItem", UIBaseNode)
local base = UIBaseNode
UIPieItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIPieItem.InitPieItem = function(self, fillAmount, clockwise, color)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  ((self.ui).img_Pie).fillAmount = fillAmount
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Pie).color = color
  local pieRoteValue, barRoteValue = nil, nil
  if clockwise then
    pieRoteValue = 360 - 360 * fillAmount
    barRoteValue = -fillAmount * 180
  else
    pieRoteValue = 360 * fillAmount
    barRoteValue = fillAmount * 180
  end
  self.pieRot = (Vector3.New)(0, 0, pieRoteValue)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_bar).localEulerAngles = (Vector3.New)(0, 0, barRoteValue)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.transform).localScale = Vector3.one
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_bar).localScale = Vector3.one
end

UIPieItem.GetTextNodePos = function(self)
  -- function num : 0_2
  return ((self.ui).tex_Node).position
end

UIPieItem.GetPieRot = function(self)
  -- function num : 0_3
  return self.pieRot
end

UIPieItem.SetItemRot = function(self, rotVector3)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).localEulerAngles = rotVector3
end

UIPieItem.SetScaleToBig = function(self)
  -- function num : 0_5
  local scale = (self.transform).localScale
  scale.x = scale.x * 1.1
  scale.y = scale.y * 1.1
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.transform).localScale = scale
  scale = ((self.ui).img_bar).localScale
  scale.x = scale.x * 0.909
  scale.y = scale.y * 0.909
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_bar).localScale = scale
end

UIPieItem.SetShortBar = function(self, isShort)
  -- function num : 0_6
  if isShort then
    local scale = ((self.ui).img_bar).localScale
    scale.y = scale.y * 0.8
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_bar).localScale = scale
  end
end

UIPieItem.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UIPieItem

