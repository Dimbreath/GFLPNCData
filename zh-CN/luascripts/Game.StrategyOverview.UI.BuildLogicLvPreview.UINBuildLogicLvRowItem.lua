-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBuildLogicLvRowItem = class("UINBuildLogicLvRowItem", UIBaseNode)
local base = UIBaseNode
local UINBuildLogicLvAttrItem = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvAttrItem")
UINBuildLogicLvRowItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBuildLogicLvAttrItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).tex_Attri):SetActive(false)
  self.attrPool = (UIItemPool.New)(UINBuildLogicLvAttrItem, (self.ui).tex_Attri)
end

UINBuildLogicLvRowItem.InitBuildLogicLvRowItem = function(self, level, logicList, customLogicList, isCurLevel)
  -- function num : 0_1 , upvalues : _ENV
  (self.attrPool):HideAll()
  local attrItem = (self.attrPool):GetOne()
  attrItem:InitBdLogicLvAttrItem(tostring(level), isCurLevel)
  for k,v in ipairs(logicList) do
    local attrItem = (self.attrPool):GetOne()
    local curValue = v.curValue
    if v.logicId == eLogicType.BuildingCustomInfo then
      curValue = v.currentInfo
    end
    attrItem:InitBdLogicLvAttrItem(curValue, isCurLevel)
  end
  for k,v in ipairs(customLogicList) do
    local attrItem = (self.attrPool):GetOne()
    attrItem:InitBdLogicLvAttrItem(v, isCurLevel)
  end
end

UINBuildLogicLvRowItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (self.attrPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINBuildLogicLvRowItem

