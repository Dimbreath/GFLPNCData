-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelNormalNode = class("UINLevelNormalNode", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDetailType = SectorLevelDetailEnum.eDetailType
local UINLNNInfinityLayerItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLNNInfinityLayerItem")
local UINLevelNormalBuffItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelNormalBuffItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UINLevelNormalNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__ShowRewardDetail = BindCallback(self, self.ShowRewardDetail)
  self.rewardItemPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).itemWithCount)
  self.wcRankRewardItemPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).itemWithCount)
  self.emptyItemPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).obj_EmptyItem)
  ;
  ((self.ui).itemWithCount):SetActive(false)
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Loop_InfinityLayerReardRect).onInstantiateItem = BindCallback(self, self.m_NewInfinityItem)
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Loop_InfinityLayerReardRect).onChangeItem = BindCallback(self, self.m_ChangeInfinityItem)
  self.linfinityLayerDataList = {}
  self.infinityLayerItemDic = {}
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).obj_LayerParent = ((((self.ui).tex_Layer).transform).parent).gameObject
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_periodic_ShowRank, self, self.ShowWeeklyChallengeRank)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_periodic_Preview, self, self.ShowWeeklyChallengeScorePreview)
end

UINLevelNormalNode.InitInfoNode = function(self, LevelDtail)
  -- function num : 0_1 , upvalues : eDetailType, _ENV
  self.LevelDtail = LevelDtail
  ;
  ((self.ui).obj_EmptyItem):SetActive(false)
  ;
  ((self.ui).obj_infinity):SetActive(false)
  ;
  ((self.ui).obj_normal):SetActive(false)
  ;
  ((self.ui).obj_reward):SetActive(false)
  if LevelDtail.detailType == eDetailType.Stage then
    local stageCfg = LevelDtail.stageCfg
    ;
    ((self.ui).obj_normal):SetActive(true)
    ;
    ((self.ui).obj_reward):SetActive(true)
    ;
    ((self.ui).tex_LevelName):SetIndex(0, (LanguageUtil.GetLocaleText)(stageCfg.name))
    ;
    (((self.ui).tex_LevelInfo).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_LevelInfo).text = (LanguageUtil.GetLocaleText)(stageCfg.introduce)
    ;
    ((self.ui).tex_IdName):SetIndex(0, tostring(stageCfg.sector), tostring(stageCfg.num))
    local layerCount = #stageCfg.exploration_list or 1
    ;
    ((self.ui).obj_LayerParent):SetActive(true)
    ;
    (((self.ui).tex_Layer).gameObject):SetActive(true)
    ;
    ((self.ui).tex_Layer):SetIndex(0, tostring(layerCount))
    ;
    ((self.ui).obj_periodic):SetActive(false)
    self:RefreshLevelReward(stageCfg)
  else
    do
      if LevelDtail.detailType == eDetailType.Avg then
        ((self.ui).obj_normal):SetActive(true)
        ;
        ((self.ui).obj_reward):SetActive(true)
        local avgCfg = LevelDtail.avgCfg
        ;
        ((self.ui).tex_LevelName):SetIndex(0, (LanguageUtil.GetLocaleText)(avgCfg.name))
        ;
        (((self.ui).tex_LevelInfo).gameObject):SetActive(true)
        -- DECOMPILER ERROR at PC138: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).tex_LevelInfo).text = (LanguageUtil.GetLocaleText)(avgCfg.describe)
        ;
        ((self.ui).tex_IdName):SetIndex(1, tostring(avgCfg.number))
        ;
        ((self.ui).obj_LayerParent):SetActive(false)
        ;
        (((self.ui).tex_Layer).gameObject):SetActive(false)
        ;
        ((self.ui).obj_periodic):SetActive(false)
        self:RefreshAvgReward(avgCfg)
      else
        do
          if LevelDtail.detailType == eDetailType.Infinity then
            local infinityCfg = (LevelDtail.levelData).cfg
            local levelData = LevelDtail.levelData
            ;
            ((self.ui).obj_infinity):SetActive(true)
            ;
            ((self.ui).obj_reward):SetActive(true)
            ;
            ((self.ui).tex_LevelName):SetIndex(1, tostring(infinityCfg.index * 10))
            ;
            (((self.ui).tex_LevelInfo).gameObject):SetActive(false)
            ;
            ((self.ui).tex_IdName):SetIndex(2, "?", tostring(#infinityCfg.layer))
            ;
            ((self.ui).obj_periodic):SetActive(false)
            self:RefreshInfinityReward(levelData)
            self:RefreshInfinityLevelReward(levelData)
          else
            do
              if LevelDtail.detailType == eDetailType.PeriodicChallenge then
                local eChallengeType = LevelDtail.eChallengeType
                local challengeId = LevelDtail.challengeId
                local challengeCfg = (ConfigData.daily_challenge)[challengeId]
                if challengeCfg == nil then
                  error("can\'t read challengeCfg with id:" .. tostring(challengeId))
                end
                ;
                ((self.ui).obj_normal):SetActive(true)
                ;
                ((self.ui).obj_reward):SetActive(true)
                ;
                ((self.ui).tex_LevelName):SetIndex(0, (LanguageUtil.GetLocaleText)(challengeCfg.name))
                ;
                (((self.ui).tex_LevelInfo).gameObject):SetActive(true)
                -- DECOMPILER ERROR at PC270: Confused about usage of register: R5 in 'UnsetPending'

                ;
                ((self.ui).tex_LevelInfo).text = (LanguageUtil.GetLocaleText)(challengeCfg.introduce)
                ;
                (((self.ui).tex_IdName).gameObject):SetActive(false)
                local layerCount = "3"
                ;
                ((self.ui).obj_LayerParent):SetActive(true)
                ;
                (((self.ui).tex_Layer).gameObject):SetActive(true)
                ;
                ((self.ui).tex_Layer):SetIndex(0, tostring(layerCount))
                ;
                ((self.ui).obj_periodic):SetActive(false)
                self:RefreshPeriodicChallengeReward(challengeCfg, eChallengeType)
              else
                do
                  if LevelDtail.detailType == eDetailType.WeeklyChallenge then
                    local challengeId = LevelDtail.challengeId
                    local challengeCfg = (ConfigData.weekly_challenge)[challengeId]
                    ;
                    ((self.ui).obj_normal):SetActive(true)
                    ;
                    ((self.ui).obj_reward):SetActive(false)
                    ;
                    ((self.ui).tex_LevelName):SetIndex(0, (LanguageUtil.GetLocaleText)(challengeCfg.name))
                    ;
                    (((self.ui).tex_LevelInfo).gameObject):SetActive(true)
                    -- DECOMPILER ERROR at PC346: Confused about usage of register: R4 in 'UnsetPending'

                    ;
                    ((self.ui).tex_LevelInfo).text = (LanguageUtil.GetLocaleText)(challengeCfg.introduce)
                    ;
                    (((self.ui).tex_IdName).gameObject):SetActive(false)
                    local layerCount = "3"
                    ;
                    ((self.ui).obj_LayerParent):SetActive(true)
                    ;
                    (((self.ui).tex_Layer).gameObject):SetActive(true)
                    ;
                    ((self.ui).tex_Layer):SetIndex(0, tostring(layerCount))
                    ;
                    ((self.ui).obj_rankNode):SetActive(challengeCfg.have_rank)
                    ;
                    ((self.ui).obj_periodic):SetActive(true)
                    self:RefreshWeeklyChallengeInfo(challengeCfg)
                  end
                  do
                    self:ForceRefresh()
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

UINLevelNormalNode.ForceRefresh = function(self)
  -- function num : 0_2 , upvalues : _ENV
  ((((CS.UnityEngine).UI).LayoutRebuilder).ForceRebuildLayoutImmediate)((self.ui).normalList)
  ;
  ((((CS.UnityEngine).UI).LayoutRebuilder).ForceRebuildLayoutImmediate)((self.ui).maybeList)
  ;
  ((((CS.UnityEngine).UI).LayoutRebuilder).ForceRebuildLayoutImmediate)((self.ui).rect)
end

UINLevelNormalNode.RefreshLevelReward = function(self, stageCfg)
  -- function num : 0_3 , upvalues : _ENV
  (((self.ui).normalList).gameObject):SetActive(true)
  ;
  (((self.ui).maybeList).gameObject):SetActive(true)
  ;
  ((self.ui).txtInfo_firsRewardList):SetIndex(0)
  ;
  (self.rewardItemPool):HideAll()
  local isPicked = false
  local stageState = (PlayerDataCenter.sectorStage):GetStageState(stageCfg.id)
  if stageState ~= proto_object_DungeonStageState.DungeonStageStateNone or stageState == proto_object_DungeonStageState.DungeonStageStateCompleted then
    (self.sectorNetworkCtrl):Send_SECTOR_BattleFirstRewardPick(stageCfg.id)
    isPicked = true
  else
    if stageState == proto_object_DungeonStageState.DungeonStageStatePicked then
      isPicked = true
    end
  end
  local firstDropItemLimt = (self.ui).firstDropItemLimt or 4
  for index,rewardId in ipairs(stageCfg.first_reward_ids) do
    if firstDropItemLimt >= index then
      local rewardNum = (stageCfg.first_reward_nums)[index]
      local itemCfg = (ConfigData.item)[rewardId]
      do
        local rewardItem = (self.rewardItemPool):GetOne()
        ;
        (rewardItem.transform):SetParent((self.ui).normalList)
        rewardItem:InitItemWithCount(itemCfg, rewardNum, self.__ShowRewardDetail, isPicked)
        -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  ;
  (self.emptyItemPool):HideAll()
  local rewardCount = #stageCfg.first_reward_ids
  if rewardCount < firstDropItemLimt then
    for i = 1, firstDropItemLimt - rewardCount do
      local emptyGo = (self.emptyItemPool):GetOne(true)
      ;
      (emptyGo.transform):SetParent((self.ui).normalList)
    end
  end
  do
    local normalCount = #stageCfg.normal_drop
    ;
    (((self.ui).maybeList).gameObject):SetActive(normalCount > 0)
    for k,itemId in ipairs(stageCfg.normal_drop) do
      if (self.ui).mayDropItemLimt or 3 >= k then
        local itemCfg = (ConfigData.item)[itemId]
        do
          local rewardItem = (self.rewardItemPool):GetOne()
          ;
          (rewardItem.transform):SetParent((self.ui).maybeList)
          rewardItem:InitItemWithCount(itemCfg, nil, self.__ShowRewardDetail)
          -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    if isPicked then
      ((self.ui).normalList):SetAsLastSibling()
    else
      ((self.ui).maybeList):SetAsLastSibling()
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

UINLevelNormalNode.RefreshAvgReward = function(self, avgCfg)
  -- function num : 0_4 , upvalues : _ENV
  (self.emptyItemPool):HideAll()
  ;
  ((self.ui).txtInfo_firsRewardList):SetIndex(1)
  ;
  (((self.ui).maybeList).gameObject):SetActive(false)
  ;
  (self.rewardItemPool):HideAll()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local played = avgPlayCtrl:IsAvgPlayed(avgCfg.id)
  for k,itemId in ipairs(avgCfg.rewardIds) do
    if (self.ui).AvgDropItemLimt or 5 >= k then
      local count = (avgCfg.rewardNums)[k]
      local itemCfg = (ConfigData.item)[itemId]
      do
        local rewardItem = (self.rewardItemPool):GetOne()
        ;
        (rewardItem.transform):SetParent((self.ui).normalList)
        rewardItem:InitItemWithCount(itemCfg, count, self.__ShowRewardDetail, played)
        -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
end

UINLevelNormalNode.RefreshInfinityReward = function(self, levelData)
  -- function num : 0_5 , upvalues : _ENV
  local infinityCfg = levelData.cfg
  ;
  (self.emptyItemPool):HideAll()
  ;
  (self.rewardItemPool):HideAll()
  ;
  ((self.ui).txtInfo_firsRewardList):SetIndex(2)
  ;
  (((self.ui).normalList).gameObject):SetActive(#infinityCfg.clear_reward_itemIds > 0)
  for index,rewardId in ipairs(infinityCfg.clear_reward_itemIds) do
    local rewardNum = (infinityCfg.clear_reward_itemNums)[index]
    local itemCfg = (ConfigData.item)[rewardId]
    local rewardItem = (self.rewardItemPool):GetOne()
    ;
    (rewardItem.transform):SetParent((self.ui).normalList)
    rewardItem:InitItemWithCount(itemCfg, rewardNum, self.__ShowRewardDetail, levelData.isComplete)
  end
  if #infinityCfg.normal_drop <= 0 then
    (((self.ui).maybeList).gameObject):SetActive(not levelData.isComplete)
    for k,itemId in ipairs(infinityCfg.normal_drop) do
      local itemCfg = (ConfigData.item)[itemId]
      if itemCfg == nil then
        error("can\'t get itemCfg withId:" .. tostring(itemId))
      end
      local rewardItem = (self.rewardItemPool):GetOne()
      ;
      (rewardItem.transform):SetParent((self.ui).maybeList)
      rewardItem:InitItemWithCount(itemCfg, nil, self.__ShowRewardDetail)
    end
    ;
    ((self.ui).maybeList):SetAsFirstSibling()
    ;
    (((self.ui).maybeList).gameObject):SetActive(false)
    -- DECOMPILER ERROR: 7 unprocessed JMP targets
  end
end

UINLevelNormalNode.RefreshInfinityLevelReward = function(self, levelData)
  -- function num : 0_6 , upvalues : _ENV
  local infinityCfg = levelData.cfg
  self.linfinityLayerDataList = {}
  for index,layerId in ipairs(infinityCfg.layer) do
    local isPass = false
    if levelData.isComplete or index <= levelData.passNum then
      isPass = true
    end
    ;
    (table.insert)(self.linfinityLayerDataList, {id = layerId, index = index, isPass = isPass})
  end
  local num = #self.linfinityLayerDataList
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).Loop_InfinityLayerReardRect).totalCount = num
  ;
  ((self.ui).Loop_InfinityLayerReardRect):RefillCells()
end

UINLevelNormalNode.RefreshPeriodicChallengeReward = function(self, challengeCfg, eChallengeType)
  -- function num : 0_7 , upvalues : PeridicChallengeEnum, _ENV
  (((self.ui).maybeList).gameObject):SetActive(false)
  ;
  (self.emptyItemPool):HideAll()
  ;
  (self.rewardItemPool):HideAll()
  if #challengeCfg.daily_dropIds <= 0 then
    (((self.ui).normalList).gameObject):SetActive(eChallengeType ~= (PeridicChallengeEnum.eChallengeType).daliy)
    for index,rewardId in ipairs(challengeCfg.daily_dropIds) do
      local rewardNum = (challengeCfg.daily_dropNums)[index]
      local itemCfg = (ConfigData.item)[rewardId]
      local rewardItem = (self.rewardItemPool):GetOne()
      ;
      (rewardItem.transform):SetParent((self.ui).normalList)
      rewardItem:InitItemWithCount(itemCfg, rewardNum, self.__ShowRewardDetail, (PlayerDataCenter.periodicChallengeData):GetIsDailyChallengeFished())
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

UINLevelNormalNode.m_NewInfinityItem = function(self, go)
  -- function num : 0_8 , upvalues : UINLNNInfinityLayerItem
  local layerItem = (UINLNNInfinityLayerItem.New)()
  layerItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.infinityLayerItemDic)[go] = layerItem
end

UINLevelNormalNode.m_ChangeInfinityItem = function(self, go, index)
  -- function num : 0_9 , upvalues : _ENV
  local layerItem = (self.infinityLayerItemDic)[go]
  if layerItem == nil then
    error("Can\'t find layerItem by gameObject")
    return 
  end
  local LayerData = (self.linfinityLayerDataList)[index + 1]
  if LayerData == nil then
    error("Can\'t find LayerData by index, index = " .. tonumber(index))
  end
  layerItem:InitNodeInfinityLevel(LayerData)
end

UINLevelNormalNode.ShowRewardDetail = function(self, itemCfg)
  -- function num : 0_10 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    -- function num : 0_10_0 , upvalues : itemCfg
    if win ~= nil then
      win:InitCommonItemDetail(itemCfg)
    end
  end
)
end

UINLevelNormalNode.RefreshWeeklyChallengeInfo = function(self, challengeCfg)
  -- function num : 0_11 , upvalues : _ENV
  (self.rewardItemPool):HideAll()
  ;
  ((self.ui).obj_periodic_NorRewardAnc):SetActive(false)
  ;
  ((self.ui).obj_periodic_ExtRewardAnc):SetActive(false)
  local itemCfg = (ConfigData.item)[(ConfigData.game_config).weeklyRewardItemId]
  for k,v in pairs(challengeCfg.base_reward) do
    local item = (self.rewardItemPool):GetOne(true)
    item:InitItemWithCount(itemCfg, nil)
    if v == 1 then
      ((self.ui).obj_periodic_NorRewardAnc):SetActive(true)
      ;
      (item.transform):SetParent(((self.ui).obj_periodic_NorRewardAnc).transform)
    else
      ;
      ((self.ui).obj_periodic_ExtRewardAnc):SetActive(true)
      ;
      (item.transform):SetParent(((self.ui).obj_periodic_ExtRewardAnc).transform)
    end
  end
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_periodic_Scoure).text = tostring((PlayerDataCenter.allWeeklyChallengeData).currentScore)
end

UINLevelNormalNode.ShowWeeklyChallengeRank = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (UIUtil.OnClickBack)()
  UIManager:ShowWindowAsync(UIWindowTypeID.WeeklyChallengeRank, function(win)
    -- function num : 0_12_0
    if win ~= nil then
      win:GenWCRPageTogs()
    end
  end
)
end

UINLevelNormalNode.ShowWeeklyChallengeScorePreview = function(self)
  -- function num : 0_13
  (self.LevelDtail):ShowWeeklyScoreIntro()
end

UINLevelNormalNode.OnDelete = function(self)
  -- function num : 0_14 , upvalues : base
  (base.OnDelete)(self)
end

return UINLevelNormalNode

