-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLogicPreviewRowBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UINBuildLogicLvRowItem = class("UINBuildLogicLvRowItem", UINLogicPreviewRowBase)
local base = UINLogicPreviewRowBase
UINBuildLogicLvRowItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnInit)(self)
end

UINBuildLogicLvRowItem.InitBuildLogicLvRowItem = function(self, level, logicList, customLogicList, isCurLevel)
  -- function num : 0_1 , upvalues : _ENV
  (self.attrPool):HideAll()
  local attrItem = (self.attrPool):GetOne()
  attrItem:InitAttrItem(tostring(level), isCurLevel)
  for k,v in ipairs(logicList) do
    local attrItem = (self.attrPool):GetOne()
    local curValue = v.curValue
    if v.logicId == eLogicType.BuildingCustomInfo then
      curValue = v.currentInfo
    end
    attrItem:InitAttrItem(curValue, isCurLevel)
  end
  for k,v in ipairs(customLogicList) do
    local attrItem = (self.attrPool):GetOne()
    attrItem:InitAttrItem(v, isCurLevel)
  end
end

UINBuildLogicLvRowItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINBuildLogicLvRowItem

