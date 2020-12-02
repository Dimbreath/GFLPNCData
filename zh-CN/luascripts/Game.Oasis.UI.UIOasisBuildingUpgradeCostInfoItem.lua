-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisBuildingUpgradeCostInfoItem = class("UIOasisBuildingUpgradeCostInfoItem", UIBaseNode)
local base = UIBaseNode
UIOasisBuildingUpgradeCostInfoItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIOasisBuildingUpgradeCostInfoItem.UpdateUI = function(self, name, context1, context2, isDefect, isUnbuilt)
  -- function num : 0_1
  if isDefect then
    ((self.ui).tex_Describe):SetIndex(1, name, context2, context1)
  else
    if isUnbuilt then
      ((self.ui).tex_Describe):SetIndex(2, context1)
    else
      ;
      ((self.ui).tex_Describe):SetIndex(0, context1, context2)
    end
  end
end

return UIOasisBuildingUpgradeCostInfoItem

