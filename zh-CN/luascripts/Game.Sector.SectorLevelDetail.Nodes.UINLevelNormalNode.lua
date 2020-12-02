-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelNormalNode = class("UINLevelNormalNode", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDetailType = SectorLevelDetailEnum.eDetailType
local UINLNNInfinityLayerItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLNNInfinityLayerItem")
UINLevelNormalNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__ShowRewardDetail = BindCallback(self, self.ShowRewardDetail)
  self.rewardItemPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).itemWithCount)
  self.emptyItemPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).obj_EmptyItem)
  ;
  ((self.ui).itemWithCount):SetActive(false)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Loop_InfinityLayerReardRect).onInstantiateItem = BindCallback(self, self.m_NewInfinityItem)
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Loop_InfinityLayerReardRect).onChangeItem = BindCallback(self, self.m_ChangeInfinityItem)
  self.linfinityLayerDataList = {}
  self.infinityLayerItemDic = {}
end

UINLevelNormalNode.InitInfoNode = function(self, LevelDtail)
  -- function num : 0_1 , upvalues : eDetailType, _ENV
  ((self.ui).obj_EmptyItem):SetActive(false)
  if LevelDtail.detailType == eDetailType.Stage then
    local stageCfg = LevelDtail.stageCfg
    ;
    ((self.ui).obj_infinity):SetActive(false)
    ;
    ((self.ui).tex_LevelName):SetIndex(0, (LanguageUtil.GetLocaleText)(stageCfg.name))
    ;
    (((self.ui).tex_LevelInfo).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_LevelInfo).text = (LanguageUtil.GetLocaleText)(stageCfg.introduce)
    ;
    ((self.ui).tex_IdName):SetIndex(0, tostring(stageCfg.sector), tostring(stageCfg.num))
    self:RefreshLevelReward(stageCfg)
  else
    do
      if LevelDtail.detailType == eDetailType.Avg then
        local avgCfg = LevelDtail.avgCfg
        ;
        ((self.ui).obj_infinity):SetActive(false)
        ;
        ((self.ui).tex_LevelName):SetIndex(0, (LanguageUtil.GetLocaleText)(avgCfg.name))
        ;
        (((self.ui).tex_LevelInfo).gameObject):SetActive(true)
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).tex_LevelInfo).text = (LanguageUtil.GetLocaleText)(avgCfg.describe)
        ;
        ((self.ui).tex_IdName):SetIndex(1, tostring(avgCfg.number))
        self:RefreshAvgReward(avgCfg)
      else
        do
          if LevelDtail.detailType == eDetailType.Infinity then
            local infinityCfg = (LevelDtail.levelData).cfg
            local levelData = LevelDtail.levelData
            ;
            ((self.ui).obj_infinity):SetActive(true)
            ;
            ((self.ui).tex_LevelName):SetIndex(1, tostring(infinityCfg.index * 10))
            ;
            (((self.ui).tex_LevelInfo).gameObject):SetActive(false)
            ;
            ((self.ui).tex_IdName):SetIndex(2, "?", tostring(#infinityCfg.layer))
            self:RefreshInfinityReward(levelData)
            self:RefreshInfinityLevelReward(levelData)
          end
          do
            self:ForceRefresh()
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
  local firstDropItemLimt = (self.ui).firstDropItemLimt or 3
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
      local rewardItem = (self.rewardItemPool):GetOne()
      ;
      (rewardItem.transform):SetParent((self.ui).maybeList)
      rewardItem:InitItemWithCount(itemCfg, nil, self.__ShowRewardDetail)
    end
    ;
    ((self.ui).maybeList):SetAsFirstSibling()
    ;
    (((self.ui).maybeList).gameObject):SetActive(false)
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
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

UINLevelNormalNode.m_NewInfinityItem = function(self, go)
  -- function num : 0_7 , upvalues : UINLNNInfinityLayerItem
  local layerItem = (UINLNNInfinityLayerItem.New)()
  layerItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.infinityLayerItemDic)[go] = layerItem
end

UINLevelNormalNode.m_ChangeInfinityItem = function(self, go, index)
  -- function num : 0_8 , upvalues : _ENV
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
  -- function num : 0_9 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    -- function num : 0_9_0 , upvalues : itemCfg
    if win ~= nil then
      win:InitCommonItemDetail(itemCfg)
    end
  end
)
end

UINLevelNormalNode.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnDelete)(self)
end

return UINLevelNormalNode

