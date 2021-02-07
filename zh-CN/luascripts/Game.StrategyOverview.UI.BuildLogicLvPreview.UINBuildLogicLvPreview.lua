-- params : ...
-- function num : 0 , upvalues : _ENV
local UILogicPreviewNodeBase = require("Game.CommonUI.LogicPreviewNode.UILogicPreviewNodeBase")
local UINBuildLogicLvPreview = class("UINBuildLogicLvPreview", UILogicPreviewNodeBase)
local base = UILogicPreviewNodeBase
local UINBuildLogicLvRowItem = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvRowItem")
UINBuildLogicLvPreview.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, UINBuildLogicLvRowItem
  (base.OnInit)(self)
  ;
  (base.InitWithClass)(self, nil, UINBuildLogicLvRowItem)
end

UINBuildLogicLvPreview.InitBuildLogicLvPreview = function(self, buildingData, withoutCurLevel)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self._Close)
  ;
  ((self.ui).tex_SkillName):SetIndex(0, buildingData.name)
  if buildingData.isBuild then
    local showCurLevel = not withoutCurLevel
  end
  ;
  (((self.ui).obj_Current).gameObject):SetActive(showCurLevel)
  local curLevel = buildingData.level
  ;
  (self.headAttrPool):HideAll()
  ;
  (self.rowItemPool):HideAll()
  for i = 1, buildingData.maxLevel do
    local logicList = (buildingData.dynData):GetBuffItems(i, false, true)
    local customLogicList = buildingData:GetBuildCustomLogicInfo(i)
    if i == 1 then
      local attrItem = (self.headAttrPool):GetOne()
      attrItem:InitAttrItem(ConfigData:GetTipContent(900))
      for k,v in ipairs(logicList) do
        local attrItem = (self.headAttrPool):GetOne()
        attrItem:InitAttrItem(v.currentInfo)
      end
      for k,v in ipairs(customLogicList) do
        local attrItem = (self.headAttrPool):GetOne()
        local info = ConfigData:GetTipContent(5003)
        attrItem:InitAttrItem(info)
      end
    end
    do
      local isCurLevel = (curLevel == i and showCurLevel)
      do
        local rowItem = (self.rowItemPool):GetOne()
        rowItem:InitWithClass()
        rowItem:InitBuildLogicLvRowItem(i, logicList, customLogicList, isCurLevel)
        if isCurLevel then
          ((self.ui).obj_Current):SetParent(rowItem.transform)
          -- DECOMPILER ERROR at PC108: Confused about usage of register: R13 in 'UnsetPending'

          ;
          ((self.ui).obj_Current).anchoredPosition = Vector2.zero
          ;
          ((self.ui).obj_Current):SetAsFirstSibling()
        end
        -- DECOMPILER ERROR at PC113: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  -- DECOMPILER ERROR at PC123: Confused about usage of register: R5 in 'UnsetPending'

  if showCurLevel then
    ((self.ui).scrollRect).verticalNormalizedPosition = 1 - (curLevel - 1) / (buildingData.maxLevel - 1)
  else
    -- DECOMPILER ERROR at PC127: Confused about usage of register: R5 in 'UnsetPending'

    ((self.ui).scrollRect).verticalNormalizedPosition = 1
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UINBuildLogicLvPreview.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINBuildLogicLvPreview

