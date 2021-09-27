local UIWeeklyChallengeRank = class("UIWeeklyChallengeRank", UIBaseWindow)
local base = UIBaseWindow
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local UINWCRankPanel = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankPanel")
local UINWCRankTogItem = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankTogItem")
UIWeeklyChallengeRank.ePanelType = {curRank = 1, oldRank = 2}
UIWeeklyChallengeRank.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINWCRankPanel, _ENV, UINWCRankTogItem
  self.listPanel = (UINWCRankPanel.New)()
  ;
  (self.listPanel):Init((self.ui).rankNode)
  self.showingType = nil
  self.pageTogPool = (UIItemPool.New)(UINWCRankTogItem, (self.ui).obj_Page)
  ;
  ((self.ui).obj_Page):SetActive(false)
  self.__ShowCurTermRanklist = BindCallback(self, self.ShowCurTermRanklist)
  self.__ShowPreviousTermRanklist = BindCallback(self, self.ShowPreviousTermRanklist)
  ;
  (UIUtil.SetTopStatus)(self, self.Delete, nil, nil, nil, nil)
  self.selfRangeData = nil
end

UIWeeklyChallengeRank.GenWCRPageTogs = function(self)
  -- function num : 0_1 , upvalues : UINWCRankTogItem
  (self.pageTogPool):HideAll()
  local curTermRanklistTog = (self.pageTogPool):GetOne()
  curTermRanklistTog:InitWCRankTogItem((UINWCRankTogItem.eTogType).curTermRankList, self.__ShowCurTermRanklist)
  local previousTermRanklistTog = (self.pageTogPool):GetOne()
  previousTermRanklistTog:InitWCRankTogItem((UINWCRankTogItem.eTogType).previousTermRankList, self.__ShowPreviousTermRanklist)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((curTermRanklistTog.ui).tog_Page).isOn = true
end

UIWeeklyChallengeRank.ShowCurTermRanklist = function(self)
  -- function num : 0_2 , upvalues : UIWeeklyChallengeRank, UINWCRankPanel
  self.showingType = (UIWeeklyChallengeRank.ePanelType).curRank
  ;
  (self.listPanel):Show()
  ;
  (self.listPanel):ShowRankPlayers((UINWCRankPanel.eRankListType).cur)
end

UIWeeklyChallengeRank.ShowPreviousTermRanklist = function(self)
  -- function num : 0_3 , upvalues : UIWeeklyChallengeRank, UINWCRankPanel
  self.showingType = (UIWeeklyChallengeRank.ePanelType).oldRank
  ;
  (self.listPanel):Show()
  ;
  (self.listPanel):ShowRankPlayers((UINWCRankPanel.eRankListType).old)
end

UIWeeklyChallengeRank.OnReceiveRankMsg = function(self, msg)
  -- function num : 0_4
  local isOld = msg.history
  if self.listPanel ~= nil then
    (self.listPanel):GetRankPageMsg(msg)
  end
  if not isOld then
    self.selfRangeData = msg.selfRange
  end
end

UIWeeklyChallengeRank.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIWeeklyChallengeRank

