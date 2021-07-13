-- params : ...
-- function num : 0 , upvalues : _ENV
local UINWCRankPanel = class("UINWCRankPanel", UIBaseNode)
local base = UIBaseNode
local UINWCRankPanelItem = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankPanelItem")
local eType = (require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankRewardPanelItem")).eType
UINWCRankPanel.eRankListType = {cur = 1, old = 2}
UINWCRankPanel.eDragWay = {down = 1, up = 2}
UINWCRankPanel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINWCRankPanel
  self.rankListType = nil
  self.logicPageRankNum = (ConfigData.game_config).WeeklyChallengeRankPageNum
  self.totalRankNum = (ConfigData.game_config).WeeklyChallengeRankTotalNum
  self.maxPageNum = self:GetIndexPageNum(self.totalRankNum)
  self.curPageNum = 0
  self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  self.rankPlayerDataDic = {
[(UINWCRankPanel.eRankListType).cur] = {}
, 
[(UINWCRankPanel.eRankListType).old] = {}
}
  self.itemDic = {}
  self.isHistoryInited = false
  self.cannotDragDown = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_scroll).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_scroll).onChangeItem = BindCallback(self, self.__OnChangeItem)
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_scroll).onReturnItem = BindCallback(self, self.__OnReturnItem)
  ;
  (((self.ui).loop_scroll).onValueChanged):AddListener(BindCallback(self, self.__OnValueChange))
end

UINWCRankPanel.ShowRankPlayers = function(self, rankListType)
  -- function num : 0_1 , upvalues : UINWCRankPanel
  if not rankListType then
    self.rankListType = (UINWCRankPanel.eRankListType).cur
    if self.rankListType == (UINWCRankPanel.eRankListType).cur then
      self.curPageNum = 0
      self:TrySendGetPageData(0)
      self.dragWay = (UINWCRankPanel.eDragWay).down
    else
      if self.rankListType == (UINWCRankPanel.eRankListType).old then
        if not self.isHistoryInited then
          self:TrySendGetPageData(0)
          self.isHistoryInited = true
        else
          local num = #(self.rankPlayerDataDic)[(UINWCRankPanel.eRankListType).old]
          -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

          ;
          ((self.ui).loop_scroll).totalCount = num
          ;
          ((self.ui).obj_emptyState):SetActive(num <= 0)
          ;
          ((self.ui).loop_scroll):RefreshCells()
          self:RefreshSelfRank(self.oldSelfRange)
        end
      end
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UINWCRankPanel.__OnNewItem = function(self, go)
  -- function num : 0_2 , upvalues : UINWCRankPanelItem
  local rankItem = (UINWCRankPanelItem.New)()
  rankItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = rankItem
end

UINWCRankPanel.__OnChangeItem = function(self, go, index)
  -- function num : 0_3 , upvalues : _ENV, UINWCRankPanel
  local rankItem = (self.itemDic)[go]
  if rankItem == nil then
    error("Can\'t find goodItem by gameObject")
    return 
  end
  local rankData = nil
  if self.rankListType == (UINWCRankPanel.eRankListType).cur then
    rankData = ((self.rankPlayerDataDic)[self.rankListType])[index + 1 + self.curPageNum * self.logicPageRankNum]
  else
    rankData = ((self.rankPlayerDataDic)[self.rankListType])[index + 1]
  end
  if rankData == nil then
    rankItem:SetWCRItemWait4Data(index + 1)
  else
    rankItem:RefreshWCRItemInfo(rankData)
  end
end

UINWCRankPanel.__OnReturnItem = function(self, go)
  -- function num : 0_4 , upvalues : _ENV
  local rankItem = (self.itemDic)[go]
  if rankItem == nil then
    error("Can\'t find levelItem by gameObject")
    return 
  end
end

UINWCRankPanel.__OnValueChange = function(self, pos)
  -- function num : 0_5 , upvalues : _ENV
  local dropRate = self.logicPageRankNum / ((self.ui).loop_scroll).totalCount
  if pos.y < 0 and (self.ui).float_overRate * dropRate < (math.abs)(pos.y) then
    self:__OnDragOverTop()
  else
    if pos.y > 1 and (self.ui).float_overRate * dropRate < (math.abs)(pos.y - 1) then
      self:__OnDragOverBottle()
    end
  end
end

UINWCRankPanel.__OnDragOverTop = function(self)
  -- function num : 0_6 , upvalues : UINWCRankPanel
  if self.curPageNum == 0 then
    return 
  end
  if self.isDragOverFreshing then
    return 
  end
  if self.rankListType == (UINWCRankPanel.eRankListType).cur then
    self:TrySendGetPageData(self.curPageNum - 1)
    self.curPageNum = self.curPageNum - 1
    self.isDragOverFreshing = true
    self.dragWay = (UINWCRankPanel.eDragWay).up
  end
end

UINWCRankPanel.__OnDragOverBottle = function(self)
  -- function num : 0_7 , upvalues : UINWCRankPanel
  if self.curPageNum == self.maxPageNum then
    return 
  end
  if self.isDragOverFreshing then
    return 
  end
  if self.rankListType == (UINWCRankPanel.eRankListType).cur then
    if (self.cannotDragDown)[(UINWCRankPanel.eRankListType).cur] then
      return 
    end
    self:TrySendGetPageData(self.curPageNum + 1)
    self.curPageNum = self.curPageNum + 1
    self.isDragOverFreshing = true
    self.dragWay = (UINWCRankPanel.eDragWay).down
  else
    if self.rankListType == (UINWCRankPanel.eRankListType).old then
      if (self.cannotDragDown)[(UINWCRankPanel.eRankListType).old] then
        return 
      end
      self:TrySendGetPageData(self.curPageNum + 1)
      self.curPageNum = self.curPageNum + 1
      self.isDragOverFreshing = true
      self.dragWay = (UINWCRankPanel.eDragWay).down
    end
  end
end

UINWCRankPanel.GetIndexPageNum = function(self, index)
  -- function num : 0_8 , upvalues : _ENV
  return (math.ceil)(index / self.logicPageRankNum) - 1
end

UINWCRankPanel.TrySendGetPageData = function(self, pageNum)
  -- function num : 0_9 , upvalues : UINWCRankPanel
  (self.sectorNetworkCtrl):CS_WEEKLYCHALLENGE_RankPage(self.rankListType == (UINWCRankPanel.eRankListType).old, pageNum)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINWCRankPanel.GetRankPageMsg = function(self, msg)
  -- function num : 0_10 , upvalues : _ENV
  local isOld = msg.history
  local rankKeyDic = {}
  for index,rankElem in ipairs(msg.rank) do
    rankKeyDic[rankElem.rank] = rankElem
  end
  self:Refresh2NewPage(isOld, rankKeyDic)
  self:RefreshSelfRank(msg.selfRange)
  if isOld then
    self.oldSelfRange = msg.selfRange
  end
end

UINWCRankPanel.Refresh2NewPage = function(self, isOld, rankKeyDic)
  -- function num : 0_11 , upvalues : _ENV, UINWCRankPanel
  ((self.ui).obj_emptyState):SetActive((table.count)(rankKeyDic) <= 0)
  if isOld then
    (table.merge)((self.rankPlayerDataDic)[(UINWCRankPanel.eRankListType).old], rankKeyDic)
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

    if self.rankListType == (UINWCRankPanel.eRankListType).old then
      ((self.ui).loop_scroll).totalCount = #(self.rankPlayerDataDic)[(UINWCRankPanel.eRankListType).old]
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.cannotDragDown)[(UINWCRankPanel.eRankListType).old] = (table.count)(rankKeyDic) < self.logicPageRankNum
      ;
      ((self.ui).loop_scroll):RefreshCells()
    end
  else
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R3 in 'UnsetPending'

    if not isOld and self.rankListType == (UINWCRankPanel.eRankListType).cur then
      (self.rankPlayerDataDic)[(UINWCRankPanel.eRankListType).cur] = rankKeyDic
      local num = (table.count)(rankKeyDic)
      ;
      ((self.ui).loop_scroll):ClearCells()
      -- DECOMPILER ERROR at PC74: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).loop_scroll).totalCount = num
      -- DECOMPILER ERROR at PC83: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self.cannotDragDown)[(UINWCRankPanel.eRankListType).cur] = num < self.logicPageRankNum
      if self.dragWay == (UINWCRankPanel.eDragWay).down then
        ((self.ui).loop_scroll):RefillCells()
      elseif self.dragWay == (UINWCRankPanel.eDragWay).up then
        ((self.ui).loop_scroll):RefillCellsFromEnd()
      else
        ((self.ui).loop_scroll):RefillCells()
      end
      ;
      ((self.ui).loop_scroll):StopMovement()
    end
  end
  self.isDragOverFreshing = false
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UINWCRankPanel.RefreshSelfRank = function(self, selfRankData)
  -- function num : 0_12 , upvalues : _ENV, eType
  local lastRegion = nil
  local lastRankCfg = (ConfigData.weekly_challenge_rank_reward)[#ConfigData.weekly_challenge_rank_reward - 1]
  if lastRankCfg ~= nil and lastRankCfg.type == eType.percentRank then
    lastRegion = lastRankCfg.score / 1000
  end
  if selfRankData.inRank then
    ((self.ui).tex_MyRank):SetIndex(0, tostring(selfRankData.curRank))
  else
    if selfRankData.score <= 0 or selfRankData.total == 0 then
      ((self.ui).tex_MyRank):SetIndex(2)
    else
      if lastRegion ~= nil and lastRegion < selfRankData.curRank / selfRankData.total then
        ((self.ui).tex_MyRank):SetIndex(3)
      else
        ;
        ((self.ui).tex_MyRank):SetIndex(1, tostring(GetPreciseDecimalStr(selfRankData.curRank / selfRankData.total * 100, 1)))
      end
    end
  end
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_MyName).text = PlayerDataCenter.playerName
  -- DECOMPILER ERROR at PC77: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_MyScore).text = tostring(selfRankData.score)
end

UINWCRankPanel.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  (base.OnDelete)(self)
end

return UINWCRankPanel

