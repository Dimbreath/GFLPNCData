-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEpAutoOperator = class("UINEpAutoOperator", UIBaseNode)
UINEpAutoOperator.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  (self.ui).tex_Operator = (self.transform):FindComponent("Tex_Operator", eUnityComponentID.TextItemInfo)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).img_Operator = (self.transform):FindComponent("Img_Operator", eUnityComponentID.Image)
end

UINEpAutoOperator.BindAutoParent = function(self, parent)
  -- function num : 0_1 , upvalues : _ENV
  (self.transform):SetLayer((parent.gameObject).layer)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Operator).material = nil
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).tex_Operator).text).material = nil
  UIManager:CopyUI3DModifier(parent, ((self.ui).img_Operator).transform)
  UIManager:CopyUI3DModifier(parent, ((self.ui).tex_Operator).transform)
end

UINEpAutoOperator.UpdateAutoOperatorText = function(self, second)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).tex_Operator):SetIndex(0, tostring(second))
end

return UINEpAutoOperator

