-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonChapterList = class("UIDungeonChapterList", UIBaseNode)
local base = UIBaseNode
local ChapterState = (require("Game.CommonUI.DungeonPanelWidgets.UIDungeonData.UIDungeonConfig")).ChapterState
local cs_MessageCommon = CS.MessageCommon
UIDungeonChapterList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Battle, self, self.__onBattleStart)
  self.isShowDetailRect = false
end

UIDungeonChapterList.CreatePool = function(self, chapterItemClass, fstRewardItemClass, mbDropItemClass)
  -- function num : 0_1 , upvalues : _ENV
  local itemPool, fstRewardPool, mbDropPool = nil, nil, nil
  if chapterItemClass ~= nil then
    itemPool = (UIItemPool.New)(chapterItemClass, (self.ui).chapterItem)
  end
  if fstRewardItemClass ~= nil then
    fstRewardPool = (UIItemPool.New)(fstRewardItemClass, (self.ui).firstReward)
  end
  if mbDropItemClass ~= nil then
    mbDropPool = (UIItemPool.New)(mbDropItemClass, (self.ui).maybeReward)
  end
  return itemPool, fstRewardPool, mbDropPool
end

UIDungeonChapterList.UpdateWithChapterList = function(self, chapterItemList, completeCount, totalCount, onStartBattleEvent)
  -- function num : 0_2 , upvalues : _ENV, ChapterState
  self.chapterItemList = chapterItemList
  self.chapterCount = totalCount
  self.onStartBattleEvent = onStartBattleEvent
  local itemClickEvent = BindCallback(self, self.OnShowDetailRectAndSetSelectChapter)
  local updateLimitDisplayEvent = (BindCallback(self, self.UpdateChapterLimitDisplay))
  local lastUnlockedItem = nil
  for k,v in ipairs(chapterItemList) do
    if v ~= nil then
      v.onClickAction = itemClickEvent
      v.updateLimitDisplayEvent = updateLimitDisplayEvent
      if v.state ~= ChapterState.lock then
        lastUnlockedItem = v
      end
    end
  end
  if lastUnlockedItem == nil and #chapterItemList > 0 then
    lastUnlockedItem = chapterItemList[0]
  end
  if lastUnlockedItem ~= nil then
    lastUnlockedItem:__onClick()
  end
  self:UpdateChapterProgress(completeCount, totalCount)
end

UIDungeonChapterList.UpdateChapterLimitDisplay = function(self, matDungeonItem)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).tex_LimitCount):SetIndex(0, tostring(matDungeonItem.usedLimit), tostring(matDungeonItem.dailyLimit))
end

UIDungeonChapterList.UpdateChapterProgress = function(self, completeCount, totalCount)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).img_Bar).fillAmount = (completeCount - 1) / (totalCount - 1)
end

UIDungeonChapterList.OnShowDetailRectAndSetSelectChapter = function(self, show, chapterItem)
  -- function num : 0_5 , upvalues : _ENV, ChapterState, cs_MessageCommon
  if chapterItem ~= nil then
    self.selectChapterItem = chapterItem
    ;
    ((self.ui).tex_Point):SetIndex(0, tostring(chapterItem.costStrengthNum))
    if chapterItem.state == ChapterState.lock then
      (((self.ui).btn_Battle).gameObject):SetActive(false)
      ;
      (cs_MessageCommon.ShowMessageTips)(chapterItem.lockReason)
    else
      ;
      (((self.ui).btn_Battle).gameObject):SetActive(true)
    end
    ;
    (((self.ui).img_chapterSelect).transform):SetParent(chapterItem.transform, false)
    ;
    ((self.ui).img_chapterSelect):SetActive(true)
  end
  if chapterItem == nil then
    do return self.isShowDetailRect ~= show end
    if show then
      self.isShowDetailRect = true
      ;
      ((self.ui).levelDetailTween):DOPlayForward()
    end
    do return show end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

UIDungeonChapterList.__onBattleStart = function(self)
  -- function num : 0_6
  if self.onStartBattleEvent ~= nil then
    (self.onStartBattleEvent)()
  end
end

UIDungeonChapterList.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UIDungeonChapterList

