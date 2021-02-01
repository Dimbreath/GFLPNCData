-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBuildLogicLvAttrItem = class("UINBuildLogicLvAttrItem", UIBaseNode)
local base = UIBaseNode
UINBuildLogicLvAttrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINBuildLogicLvAttrItem.InitBdLogicLvAttrItem = function(self, str, white)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_Attri).text = str
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if not white or not Color.white then
    ((self.ui).tex_Attri).color = (self.ui).normalColor
  end
end

UINBuildLogicLvAttrItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINBuildLogicLvAttrItem

