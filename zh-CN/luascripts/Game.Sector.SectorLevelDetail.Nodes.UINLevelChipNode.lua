-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelChipNode = class("UINLevelChipNode", UIBaseNode)
local base = UIBaseNode
local UINLevelChipQualityItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelChipQualityItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDetailType = SectorLevelDetailEnum.eDetailType
UINLevelChipNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel, UINLevelChipQualityItem
  self.chipDataQualityDic = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.chipDetailPanel = (UINChipDetailPanel.New)()
  ;
  (self.chipDetailPanel):Init((self.ui).uINChipItemDetail)
  ;
  (self.chipDetailPanel):ShowHeroHeadOrTacticActive(false)
  self.qualityItemPool = (UIItemPool.New)(UINLevelChipQualityItem, (self.ui).chipQualityItem)
  ;
  ((self.ui).chipQualityItem):SetActive(false)
  self._OnChipClick = BindCallback(self, self.OnChipClick)
end

UINLevelChipNode.InitInfoNode = function(self, LevelDtail, chipDataQualityDic, resloader)
  -- function num : 0_1 , upvalues : eDetailType, _ENV
  self.__resloader = resloader
  if LevelDtail.detailType == eDetailType.Stage or LevelDtail.detailType == eDetailType.Infinity then
    self.chipDataQualityDic = chipDataQualityDic
  else
    return 
  end
  self:Sort()
  self:RefreshQualityItems()
  ;
  ((self.ui).img_ChipSelect):SetActive(false)
  ;
  (self.chipDetailPanel):Hide()
  if LevelDtail.detailType == eDetailType.Infinity then
    local num = 0
    local bestCompleteLevelData = (LevelDtail.levelData).bestCompleteLevelData
    if bestCompleteLevelData ~= nil then
      num = ((bestCompleteLevelData.cfg).resource_itemNums)[1]
    end
    ;
    ((self.ui).tex_OriginRes):SetIndex(0, tostring(num))
    ;
    ((self.ui).obj_originRes):SetActive(true)
  else
    do
      ;
      ((self.ui).obj_originRes):SetActive(false)
    end
  end
end

UINLevelChipNode.Sort = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for key,list in pairs(self.chipDataQualityDic) do
    (table.sort)(list, function(chip1, chip2)
    -- function num : 0_2_0
    if chip1.dataId >= chip2.dataId then
      do return chip1.isLock ~= chip2.isLock end
      if chip1.isLock then
        return false
      else
        return true
      end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  end
end

UINLevelChipNode.RefreshQualityItems = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self.qualityItemPool):HideAll()
  local keys = (table.keys)(self.chipDataQualityDic)
  ;
  (table.sort)(keys, function(a, b)
    -- function num : 0_3_0
    do return b < a end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for _,qId in ipairs(keys) do
    local chipDataList = (self.chipDataQualityDic)[qId]
    local qualityItem = (self.qualityItemPool):GetOne()
    qualityItem:InitChipQualityItem(qId, chipDataList, self._OnChipClick)
  end
end

UINLevelChipNode.OnChipClick = function(self, chipData, chipItem)
  -- function num : 0_4 , upvalues : _ENV
  if self.selectedChipData == chipData or not chipData then
    ((self.ui).img_ChipSelect):SetActive(false)
    ;
    (self.chipDetailPanel):Hide()
    self.selectedChipData = nil
  else
    self.selectedChipData = chipData
    ;
    ((self.ui).img_ChipSelect):SetActive(true)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.ui).img_ChipSelect).transform).position = (chipItem.transform).position
    ;
    (((self.ui).img_ChipSelect).transform):SetParent(chipItem.transform)
    ;
    (self.chipDetailPanel):Show()
    ;
    (self.chipDetailPanel):InitChipDetailPanel(nil, chipData, nil, self.__resloader, nil, true, eChipDetailPowerType.None, false)
  end
end

UINLevelChipNode.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINLevelChipNode

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelChipNode = class("UINLevelChipNode", UIBaseNode)
local base = UIBaseNode
local UINLevelChipQualityItem = require(
                                    "Game.Sector.SectorLevelDetail.Nodes.UINLevelChipQualityItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDetailType = SectorLevelDetailEnum.eDetailType
UINLevelChipNode.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel, UINLevelChipQualityItem
    self.chipDataQualityDic = nil;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.chipDetailPanel = (UINChipDetailPanel.New)();
    (self.chipDetailPanel):Init((self.ui).uINChipItemDetail);
    (self.chipDetailPanel):ShowHeroHeadOrTacticActive(false)
    self.qualityItemPool = (UIItemPool.New)(UINLevelChipQualityItem,
                                            (self.ui).chipQualityItem);
    ((self.ui).chipQualityItem):SetActive(false)
    self._OnChipClick = BindCallback(self, self.OnChipClick)
end

UINLevelChipNode.InitInfoNode = function(self, LevelDtail, chipDataQualityDic,
                                         resloader)
    -- function num : 0_1 , upvalues : eDetailType, _ENV
    self.__resloader = resloader
    if LevelDtail.detailType == eDetailType.Stage or LevelDtail.detailType ==
        eDetailType.Infinity then
        self.chipDataQualityDic = chipDataQualityDic
    else
        return
    end
    self:Sort()
    self:RefreshQualityItems();
    ((self.ui).img_ChipSelect):SetActive(false);
    (self.chipDetailPanel):Hide()
    if LevelDtail.detailType == eDetailType.Infinity then
        local num = 0
        local bestCompleteLevelData =
            (LevelDtail.levelData).bestCompleteLevelData
        if bestCompleteLevelData ~= nil then
            num = ((bestCompleteLevelData.cfg).resource_itemNums)[1]
        end
        ((self.ui).tex_OriginRes):SetIndex(0, tostring(num));
        ((self.ui).obj_originRes):SetActive(true)
    else
        do

            ((self.ui).obj_originRes):SetActive(false)
        end
    end
end

UINLevelChipNode.Sort = function(self)
    -- function num : 0_2 , upvalues : _ENV
    for key, list in pairs(self.chipDataQualityDic) do
        (table.sort)(list, function(chip1, chip2)
            -- function num : 0_2_0
            if chip1.dataId >= chip2.dataId then
                do return chip1.isLock ~= chip2.isLock end
                if chip1.isLock then
                    return false
                else
                    return true
                end
                -- DECOMPILER ERROR: 4 unprocessed JMP targets
            end
        end)
    end
end

UINLevelChipNode.RefreshQualityItems = function(self)
    -- function num : 0_3 , upvalues : _ENV
    (self.qualityItemPool):HideAll()
    local keys = (table.keys)(self.chipDataQualityDic);
    (table.sort)(keys, function(a, b)
        -- function num : 0_3_0
        do return b < a end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    for _, qId in ipairs(keys) do
        local chipDataList = (self.chipDataQualityDic)[qId]
        local qualityItem = (self.qualityItemPool):GetOne()
        qualityItem:InitChipQualityItem(qId, chipDataList, self._OnChipClick)
    end
end

UINLevelChipNode.OnChipClick = function(self, chipData, chipItem)
    -- function num : 0_4 , upvalues : _ENV
    if self.selectedChipData == chipData or not chipData then
        ((self.ui).img_ChipSelect):SetActive(false);
        (self.chipDetailPanel):Hide()
        self.selectedChipData = nil
    else
        self.selectedChipData = chipData;
        ((self.ui).img_ChipSelect):SetActive(true) -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (((self.ui).img_ChipSelect).transform).position =
            (chipItem.transform).position;
        (((self.ui).img_ChipSelect).transform):SetParent(chipItem.transform);
        (self.chipDetailPanel):Show();
        (self.chipDetailPanel):InitChipDetailPanel(nil, chipData, nil,
                                                   self.__resloader, nil, true,
                                                   eChipDetailPowerType.None,
                                                   false)
    end
end

UINLevelChipNode.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UINLevelChipNode

