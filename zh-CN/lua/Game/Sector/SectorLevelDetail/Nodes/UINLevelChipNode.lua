local UINLevelChipNode = class("UINLevelChipNode", UIBaseNode)
local base = UIBaseNode
local UINLevelChipQualityItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelChipQualityItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINBaseChipDetail")
local UINLevelNormalBuffItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelNormalBuffItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local ChipData = require("Game.PlayerData.Item.ChipData")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDetailType = SectorLevelDetailEnum.eDetailType
local SectorEnum = require("Game.Sector.SectorEnum")
UINLevelChipNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel, UINLevelChipQualityItem, UINLevelNormalBuffItem
  self.chipDataQualityDic = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.chipDetailPanel = (UINChipDetailPanel.New)()
  ;
  (self.chipDetailPanel):Init((self.ui).uINChipItemDetail)
  self.qualityItemPool = (UIItemPool.New)(UINLevelChipQualityItem, (self.ui).chipQualityItem)
  ;
  ((self.ui).chipQualityItem):SetActive(false)
  self._OnChipClick = BindCallback(self, self.OnChipClick)
  self.buffItemPool = (UIItemPool.New)(UINLevelNormalBuffItem, (self.ui).obj_img_Buff)
  ;
  ((self.ui).obj_img_Buff):SetActive(false)
  self.__ShowBuffDescription = BindCallback(self, self.ShowBuffDescription)
  self.__HideBuffDetail = BindCallback(self, self.HideBuffDetail)
end

UINLevelChipNode.InitInfoNode = function(self, LevelDtail, chipDataQualityDic, resloader)
  -- function num : 0_1 , upvalues : eDetailType, SectorEnum, _ENV
  self.__resloader = resloader
  if LevelDtail.detailType ~= eDetailType.Avg and LevelDtail.detailType ~= eDetailType.None then
    self.chipDataQualityDic = chipDataQualityDic
  else
    return 
  end
  if LevelDtail.detailType == eDetailType.Stage then
    local stageCfg = LevelDtail.stageCfg
    self:RefreshBuffs(stageCfg.buff_id, stageCfg.sector == SectorEnum.NewbeeSectorId)
    self:GenInitialChipList(stageCfg.function_id, stageCfg.function_level)
    ;
    ((self.ui).obj_originRes):SetActive(false)
  elseif LevelDtail.detailType == eDetailType.Infinity then
    local num = 0
    local bestCompleteLevelData = (LevelDtail.levelData).bestCompleteLevelData
    if bestCompleteLevelData ~= nil then
      num = ((bestCompleteLevelData.cfg).resource_itemNums)[1]
    end
    ;
    ((self.ui).tex_OriginRes):SetIndex(0, tostring(num))
    ;
    ((self.ui).obj_originRes):SetActive(true)
    local infinityCfg = (LevelDtail.levelData).cfg
    self:RefreshBuffs(infinityCfg.buff_id)
    self:GenInitialChipList(infinityCfg.function_id, infinityCfg.function_level)
  elseif LevelDtail.detailType == eDetailType.PeriodicChallenge then
    local eChallengeType = LevelDtail.eChallengeType
    self:RefreshBuffs((PlayerDataCenter.periodicChallengeData):GetChallengeBuffList(eChallengeType))
    self:GenInitialChipList(nil)
    ;
    ((self.ui).obj_originRes):SetActive(false)
  elseif LevelDtail.detailType == eDetailType.WeeklyChallenge then
    self:RefreshBuffs((((PlayerDataCenter.allWeeklyChallengeData).dataDic)[LevelDtail.challengeId]).buffList)
    self:GenInitialChipList(nil)
    ;
    ((self.ui).obj_originRes):SetActive(false)
  else
    error("error level type:" .. tostring(LevelDtail.detailType))
  end
  self:Sort()
  self:RefreshChipQualityItems()
  ;
  ((self.ui).img_ChipSelect):SetActive(false)
  ;
  (self.chipDetailPanel):Hide()
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

UINLevelChipNode.GenInitialChipList = function(self, chip_ids, function_level)
  -- function num : 0_2 , upvalues : _ENV, ChipData
  if chip_ids == nil or #chip_ids == 0 then
    self.initialChipList = nil
    return 
  end
  self.initialChipList = {}
  for index,chipId in pairs(chip_ids) do
    local chipData = (ChipData.New)(chipId, function_level[index] or 1)
    ;
    (table.insert)(self.initialChipList, chipData)
  end
end

UINLevelChipNode.Sort = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for key,list in pairs(self.chipDataQualityDic) do
    (table.sort)(list, function(chip1, chip2)
    -- function num : 0_3_0
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

UINLevelChipNode.RefreshChipQualityItems = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self.qualityItemPool):HideAll()
  local keys = (table.keys)(self.chipDataQualityDic)
  ;
  (table.sort)(keys, function(a, b)
    -- function num : 0_4_0
    do return b < a end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  do
    if self.initialChipList ~= nil then
      local qualityItem = (self.qualityItemPool):GetOne()
      qualityItem:InitChipQualityItem(eItemQualityType.Orange, self.initialChipList, self._OnChipClick, true)
    end
    for _,qId in ipairs(keys) do
      local chipDataList = (self.chipDataQualityDic)[qId]
      local qualityItem = (self.qualityItemPool):GetOne()
      qualityItem:InitChipQualityItem(qId, chipDataList, self._OnChipClick)
    end
  end
end

UINLevelChipNode.OnChipClick = function(self, chipData, chipItem)
  -- function num : 0_5
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
    (self.chipDetailPanel):InitBaseChipDetail(nil, chipData, nil, self.__resloader, nil, true, false)
  end
end

UINLevelChipNode.RefreshBuffs = function(self, buffList, isNewbee)
  -- function num : 0_6 , upvalues : _ENV
  ((self.ui).obj_buffNode):SetActive((buffList ~= nil and #buffList > 0 and not isNewbee))
  if buffList == nil or #buffList == 0 then
    return 
  end
  self:SetBuffNodeTitle(ConfigData:GetTipContent(TipContent.SctLevelBuffNodeTitle))
  ;
  (self.buffItemPool):HideAll()
  local count = 0
  for _,buffId in ipairs(buffList) do
    local buffCfg = (ConfigData.exploration_buff)[buffId]
    if buffCfg ~= nil and buffCfg.is_listshow then
      count = count + 1
      local buffItem = (self.buffItemPool):GetOne()
      buffItem:InitBuffByCfg(buffCfg, self.__ShowBuffDescription, self.__HideBuffDetail)
    end
  end
  if count == 0 then
    ((self.ui).obj_buffNode):SetActive(false)
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINLevelChipNode.SetBuffNodeTitle = function(self, des)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_buffNodeTitle).text = des
end

UINLevelChipNode.ShowBuffDescription = function(self, item, buffCfg)
  -- function num : 0_8 , upvalues : _ENV, HAType, VAType
  local window = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  window:SetTitleAndContext((LanguageUtil.GetLocaleText)(buffCfg.name), (LanguageUtil.GetLocaleText)(buffCfg.describe))
  window:FloatTo(item.transform, HAType.autoCenter, VAType.up, 0, 0.62)
end

UINLevelChipNode.HideBuffDetail = function(self, skillData)
  -- function num : 0_9 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
  end
end

UINLevelChipNode.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (self.chipDetailPanel):Delete()
  if self.buffItemPool ~= nil then
    (self.buffItemPool):DeleteAll()
  end
  self:HideBuffDetail()
  ;
  (base.OnDelete)(self)
end

return UINLevelChipNode

