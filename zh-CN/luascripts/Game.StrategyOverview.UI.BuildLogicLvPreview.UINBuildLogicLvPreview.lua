-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBuildLogicLvPreview = class("UINBuildLogicLvPreview", UIBaseNode)
local base = UIBaseNode
local UINBuildLogicLvAttrItem = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvAttrItem")
local UINBuildLogicLvRowItem = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvRowItem")
UINBuildLogicLvPreview.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBuildLogicLvAttrItem, UINBuildLogicLvRowItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self._OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Bg, self, self._OnClickClose)
  ;
  ((self.ui).tex_HeadAttri):SetActive(false)
  self.headAttrPool = (UIItemPool.New)(UINBuildLogicLvAttrItem, (self.ui).tex_HeadAttri)
  ;
  ((self.ui).rowItem):SetActive(false)
  self.rowItemPool = (UIItemPool.New)(UINBuildLogicLvRowItem, (self.ui).rowItem)
end

UINBuildLogicLvPreview.InitBuildLogicLvPreview = function(self, buildingData, withoutCurLevel)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self._Close)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillName).text = buildingData.name
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
      attrItem:InitBdLogicLvAttrItem(ConfigData:GetTipContent(900))
      for k,v in ipairs(logicList) do
        local attrItem = (self.headAttrPool):GetOne()
        attrItem:InitBdLogicLvAttrItem(v.currentInfo)
      end
      for k,v in ipairs(customLogicList) do
        local attrItem = (self.headAttrPool):GetOne()
        local info = ConfigData:GetTipContent(5003)
        attrItem:InitBdLogicLvAttrItem(info)
      end
    end
    do
      local isCurLevel = (curLevel == i and showCurLevel)
      do
        local rowItem = (self.rowItemPool):GetOne()
        rowItem:InitBuildLogicLvRowItem(i, logicList, customLogicList, isCurLevel)
        if isCurLevel then
          ((self.ui).obj_Current):SetParent(rowItem.transform)
          -- DECOMPILER ERROR at PC104: Confused about usage of register: R13 in 'UnsetPending'

          ;
          ((self.ui).obj_Current).anchoredPosition = Vector2.zero
          ;
          ((self.ui).obj_Current):SetAsFirstSibling()
        end
        -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  -- DECOMPILER ERROR at PC119: Confused about usage of register: R5 in 'UnsetPending'

  if showCurLevel then
    ((self.ui).scrollRect).verticalNormalizedPosition = 1 - (curLevel - 1) / (buildingData.maxLevel - 1)
  else
    -- DECOMPILER ERROR at PC123: Confused about usage of register: R5 in 'UnsetPending'

    ((self.ui).scrollRect).verticalNormalizedPosition = 1
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UINBuildLogicLvPreview._Close = function(self)
  -- function num : 0_2
  self:Hide()
end

UINBuildLogicLvPreview._OnClickClose = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UINBuildLogicLvPreview.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (self.headAttrPool):DeleteAll()
  ;
  (self.rowItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINBuildLogicLvPreview

