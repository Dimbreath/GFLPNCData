-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.CommonUI.LogicPreviewNode.UILogicPreviewNodeBase")
local UINMonsterLevelPreview = class("UINMonsterLevelPreview", base)
local UINMonsterLevelPreviewItem = require("Game.Exploration.UI.MonsterLevel.UINMonsterLevelPreviewItem")
UINMonsterLevelPreview.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, UINMonsterLevelPreviewItem
  (base.OnInit)(self)
  ;
  (base.InitWithClass)(self, nil, UINMonsterLevelPreviewItem)
end

UINMonsterLevelPreview.OnShow = function(self)
  -- function num : 0_1 , upvalues : _ENV, base
  local dungeonStateInfo = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateInfo ~= nil then
    dungeonStateInfo:SetHeroListActive(false)
  end
  ;
  (base.OnShow)(self)
end

UINMonsterLevelPreview.OnHide = function(self)
  -- function num : 0_2 , upvalues : _ENV, base
  local dungeonStateInfo = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateInfo ~= nil then
    dungeonStateInfo:SetHeroListActive(true)
  end
  ;
  (base.OnHide)(self)
end

UINMonsterLevelPreview.InitMonsterLevelPreview = function(self, curLevel, onCloseCallback)
  -- function num : 0_3 , upvalues : _ENV
  self._onCloseCallback = onCloseCallback
  ;
  ((self.ui).tex_SkillName):SetIndex(3)
  ;
  (((self.ui).obj_Current).gameObject):SetActive(true)
  ;
  (self.headAttrPool):HideAll()
  ;
  (self.rowItemPool):HideAll()
  local attrItem = (self.headAttrPool):GetOne()
  attrItem:InitAttrItem(ConfigData:GetTipContent(1105))
  attrItem = (self.headAttrPool):GetOne()
  attrItem:InitAttrItem(ConfigData:GetTipContent(1106))
  attrItem = (self.headAttrPool):GetOne()
  attrItem:InitAttrItem(ConfigData:GetTipContent(1107))
  attrItem = (self.headAttrPool):GetOne()
  attrItem:InitAttrItem(ConfigData:GetTipContent(1108))
  local cellingAdd = 0
  local maxLevel = (table.length)(ConfigData.monster_level)
  for level = 1, maxLevel do
    local monsterStrengthCfg = (ConfigData.monster_level)[level]
    local logicList = {}
    ;
    (table.insert)(logicList, tostring(level))
    ;
    (table.insert)(logicList, tostring(monsterStrengthCfg.hp_amplify / 10) .. "%")
    ;
    (table.insert)(logicList, tostring(monsterStrengthCfg.pow_amplify / 10) .. "%")
    ;
    (table.insert)(logicList, tostring(monsterStrengthCfg.skill_intensity_amplify / 10) .. "%")
    local isCurLevel = curLevel == level
    local rowItem = (self.rowItemPool):GetOne()
    rowItem:InitWithClass()
    rowItem:InitMonsterLevelPreviewRowItem(level, isCurLevel, logicList)
    if isCurLevel then
      ((self.ui).obj_Current):SetParent(rowItem.transform)
      -- DECOMPILER ERROR at PC133: Confused about usage of register: R14 in 'UnsetPending'

      ;
      ((self.ui).obj_Current).anchoredPosition = Vector2.zero
      ;
      ((self.ui).obj_Current):SetAsFirstSibling()
    end
  end
  -- DECOMPILER ERROR at PC145: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).verticalNormalizedPosition = 1 - (curLevel - 1) / (maxLevel - 1)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINMonsterLevelPreview._OnClickClose = function(self)
  -- function num : 0_4
  if self._onCloseCallback ~= nil then
    (self._onCloseCallback)()
  end
  self:Hide()
end

UINMonsterLevelPreview.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINMonsterLevelPreview

