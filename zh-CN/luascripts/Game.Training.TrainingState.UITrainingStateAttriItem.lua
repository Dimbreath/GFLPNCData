-- params : ...
-- function num : 0 , upvalues : _ENV
local UITrainingStateAttriItem = class("UITrainingStateAttriItem", UIBaseNode)
local base = UIBaseNode
UITrainingStateAttriItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UITrainingStateAttriItem.SetAttriIndex = function(self, index, ...)
  -- function num : 0_1
  ((self.ui).tex_AttriName):SetIndex(index, ...)
end

UITrainingStateAttriItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UITrainingStateAttriItem

