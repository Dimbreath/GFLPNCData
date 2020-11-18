-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthSlotUpgradeSuccessAttr = class("UIAthSlotUpgradeSuccess", UIBaseNode)
local base = UIBaseNode
UIAthSlotUpgradeSuccessAttr.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIAthSlotUpgradeSuccessAttr.InitInfo = function(self, attrName, attrOldValue, attrNewValue, image)
  -- function num : 0_1 , upvalues : _ENV
  if image ~= nil then
    print("属性的变化图片还没做")
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_AttriName).text = attrName
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_OldNum).text = attrOldValue
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_NewNum).text = attrNewValue
end

return UIAthSlotUpgradeSuccessAttr

