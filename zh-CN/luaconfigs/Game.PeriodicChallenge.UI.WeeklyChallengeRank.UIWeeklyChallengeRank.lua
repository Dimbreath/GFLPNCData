-- params : ...
-- function num : 0 , upvalues : _ENV
local UIWeeklyChallengeRank = class("UIWeeklyChallengeRank", UIBaseWindow)
local base = UIBaseWindow
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local UINWCRankRewardPanel = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankRewardPanel")
local UINWCRankPanel = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankPanel")
local UINWCRankTogItem = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankTogItem")
UIWeeklyChallengeRank.ePanelType = {curRank = 1, oldRank = 2, reward = 3}
UIWeeklyChallengeRank.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINWCRankRewardPanel, UINWCRankPanel, _ENV, UINWCRankTogItem
  self.rewardPanel = (UINWCRankRewardPanel.New)()
  ;
  (self.rewardPanel):Init((self.ui).awardNode)
  self.listPanel = (UINWCRankPanel.New)()
  ;
  (self.listPanel):Init((self.ui).rankNode)
  self.showingType = nil
  self.pageTogPool = (UIItemPool.New)(UINWCRankTogItem, (self.ui).obj_Page)
  ;
  ((self.ui).obj_Page):SetActive(false)
  self.__ShowCurTermRanklist = BindCallback(self, self.ShowCurTermRanklist)
  self.__ShowPreviousTermRanklist = BindCallback(self, self.ShowPreviousTermRanklist)
  self.__ShowRanklistReward = BindCallback(self, self.ShowRanklistReward)
  ;
  (UIUtil.SetTopStatus)(self, self.Delete, nil, nil, nil, nil)
  self.selfRangeData = nil
end

UIWeeklyChallengeRank.GenWCRPageTogs = function(self)
  -- function num : 0_1 , upvalues : UINWCRankTogItem, _ENV
  (self.pageTogPool):HideAll()
  local curTermRanklistTog = (self.pageTogPool):GetOne()
  curTermRanklistTog:InitWCRankTogItem((UINWCRankTogItem.eTogType).curTermRankList, self.__ShowCurTermRanklist)
  local previousTermRanklistTog = (self.pageTogPool):GetOne()
  previousTermRanklistTog:InitWCRankTogItem((UINWCRankTogItem.eTogType).previousTermRankList, self.__ShowPreviousTermRanklist)
  local RanklistRewardTog = (self.pageTogPool):GetOne()
  RanklistRewardTog:InitWCRankTogItem((UINWCRankTogItem.eTogType).rankRewardList, self.__ShowRanklistReward)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((curTermRanklistTog.ui).tog_Page).isOn = true
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  self:RefreshRemaindTime()
  self.timer = (TimerManager:GetTimer(1, self.RefreshRemaindTime, self, false, false, false)):Start()
end

UIWeeklyChallengeRank.ShowCurTermRanklist = function(self)
  -- function num : 0_2 , upvalues : UIWeeklyChallengeRank, UINWCRankPanel
  self.showingType = (UIWeeklyChallengeRank.ePanelType).curRank
  ;
  (self.rewardPanel):Hide()
  ;
  (self.listPanel):Show()
  ;
  (self.listPanel):ShowRankPlayers((UINWCRankPanel.eRankListType).cur)
end

UIWeeklyChallengeRank.ShowPreviousTermRanklist = function(self)
  -- function num : 0_3 , upvalues : UIWeeklyChallengeRank, UINWCRankPanel
  self.showingType = (UIWeeklyChallengeRank.ePanelType).oldRank
  ;
  (self.rewardPanel):Hide()
  ;
  (self.listPanel):Show()
  ;
  (self.listPanel):ShowRankPlayers((UINWCRankPanel.eRankListType).old)
end

UIWeeklyChallengeRank.ShowRanklistReward = function(self)
  -- function num : 0_4 , upvalues : UIWeeklyChallengeRank, _ENV
  self.showingType = (UIWeeklyChallengeRank.ePanelType).reward
  ;
  (self.rewardPanel):Show()
  ;
  (self.listPanel):Hide()
  if self.selfRangeData == nil then
    (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_WEEKLYCHALLENGE_RankPage(false, 0, function()
    -- function num : 0_4_0 , upvalues : self
    self:CalAndShowRanklistReward()
  end
)
  else
    self:CalAndShowRanklistReward()
  end
end

UIWeeklyChallengeRank.CalAndShowRanklistReward = function(self)
  -- function num : 0_5
  (self.rewardPanel):InitRankRewardPanel(self.selfRangeData)
end

UIWeeklyChallengeRank.OnReceiveRankMsg = function(self, msg)
  -- function num : 0_6
  local isOld = msg.history
  if self.listPanel ~= nil then
    (self.listPanel):GetRankPageMsg(msg)
  end
  if not isOld then
    self.selfRangeData = msg.selfRange
  end
end

UIWeeklyChallengeRank.RefreshRemaindTime = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local isRankOutof = (PlayerDataCenter.allWeeklyChallengeData).rankTm < PlayerDataCenter.timestamp
  ;
  ((self.ui).title_Timer):SetIndex(isRankOutof and 1 or 0)
  local nextTime = nil
  if isRankOutof then
    local counterElem = (PlayerDataCenter.allWeeklyChallengeData):GetCounterElem()
    nextTime = counterElem ~= nil and counterElem.nextExpiredTm or 0
  else
    nextTime = (PlayerDataCenter.allWeeklyChallengeData).rankTm
  end
  local remaindTime = (math.max)((math.floor)(nextTime - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimestampToTimeInter(remaindTime, false, true)
  if h < 10 or not tostring(h) then
    local hStr = "0" .. tostring(h)
  end
  if m < 10 or not tostring(m) then
    local mStr = "0" .. tostring(m)
  end
  if s < 10 or not tostring(s) then
    local sStr = "0" .. tostring(s)
  end
  if d > 0 then
    ((self.ui).tex_Timer):SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    ((self.ui).tex_Timer):SetIndex(1, hStr, mStr, sStr)
  end
  if remaindTime <= 0 and isRankOutof and self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  -- DECOMPILER ERROR: 16 unprocessed JMP targets
end

UIWeeklyChallengeRank.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (self.rewardPanel):Delete()
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIWeeklyChallengeRank

