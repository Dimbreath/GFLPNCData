-- params : ...
-- function num : 0 , upvalues : _ENV
local UIPeriodicChallenge = class("UIPeriodicChallenge", UIBaseWindow)
local base = UIBaseWindow
local UINChallengeInfoItem = require("Game.PeriodicChallenge.UI.UINChallengeInfoItem")
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
UIPeriodicChallenge.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChallengeInfoItem, PeridicChallengeEnum
  self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  ;
  (UIUtil.SetTopStatus)(self, self.__OnClickBack, {ConstGlobalItem.SKey})
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_dailyNode, self, self.__OnClickDailyBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.__CloseLevelDetailWindow)
  self.infoItemNode = (UINChallengeInfoItem.New)()
  ;
  (self.infoItemNode):Init((self.ui).obj_infoItem)
  ;
  (self.infoItemNode):InitChallengeInfoItem((PeridicChallengeEnum.eChallengeType).daliy, ((self.ui).obj_infoHolder_daily).transform)
  self.__Refresh = BindCallback(self, self.OnTimeRefresh)
  MsgCenter:AddListener(eMsgEventId.ChallengeOutOfData, self.__Refresh)
  self.__onHasUncompletedEp = BindCallback(self, self.RefreshPeriodicInEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
end

UIPeriodicChallenge.InitPeriodicChallenge = function(self, closeCallback)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (PlayerDataCenter.sectorStage).lastSelectSector = nil
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (PlayerDataCenter.sectorStage).lastPeriodicChallenge = true
  self.closeCallback = closeCallback
  self:RefreshPeriodicInEp()
end

UIPeriodicChallenge.OnTimeRefresh = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local detailWin = UIManager:GetWindow(UIWindowTypeID.SectorLevelDetail)
  if detailWin ~= nil and self.selectedeChallengeType ~= nil then
    detailWin:InitPeriodicChallengeDetailNode((PlayerDataCenter.periodicChallengeData):GetChallengeId(self.selectedeChallengeType), self.selectedeChallengeType)
  end
  self:RefreshPeriodicInEp()
end

UIPeriodicChallenge.RefreshPeriodicInEp = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local _, _, moduleId = ExplorationManager:HasUncompletedEp()
  local isInEp = moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge
  ;
  (self.infoItemNode):SetInEp(isInEp)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIPeriodicChallenge.__ShowLevelDetailWindow = function(self, eChallengeType)
  -- function num : 0_4 , upvalues : _ENV
  self.selectedeChallengeType = eChallengeType
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevelDetail, function(window)
    -- function num : 0_4_0 , upvalues : self, _ENV, eChallengeType
    self.levelDetailWindow = window
    window:SetLevelDetaiHideStartEvent(function()
      -- function num : 0_4_0_0 , upvalues : self
      self:__PlayMoveLeftTween(false)
      ;
      ((self.ui).obj_img_SelectDaily):SetActive(false)
      ;
      ((self.ui).tween_Wave_Daily):DOPlayBackwards()
    end
)
    window:SetLevelDetaiHideEndEvent(function()
      -- function num : 0_4_0_1
    end
)
    local width, duration = window:GetLevelDetailWidthAndDuration()
    self:__PlayMoveLeftTween(true, width, duration)
    ;
    ((self.ui).obj_img_SelectDaily):SetActive(true)
    ;
    ((self.ui).tween_Wave_Daily):DOPlayForward()
    window:InitPeriodicChallengeDetailNode((PlayerDataCenter.periodicChallengeData):GetChallengeId(eChallengeType), eChallengeType)
  end
)
end

UIPeriodicChallenge.__PlayMoveLeftTween = function(self, isLeft, offset, duration)
  -- function num : 0_5 , upvalues : _ENV
  local var = ((self.ui).obj_levelNode).transform
  do
    if self.__moveLeftTween == nil then
      local endValue = (Vector2.unity_vector2)(1 - offset / ((var.rect).width + (self.ui).moveLeftTwenOffset), 1)
      self.__moveLeftTween = (var:DOAnchorMax(endValue, duration)):SetAutoKill(false)
      self.__moveLeftTweenDuration = duration
    end
    if isLeft then
      (self.__moveLeftTween):PlayForward()
    else
      ;
      (self.__moveLeftTween):PlayBackwards()
    end
  end
end

UIPeriodicChallenge.__OnClickDailyBtn = function(self)
  -- function num : 0_6 , upvalues : PeridicChallengeEnum
  self:__ShowLevelDetailWindow((PeridicChallengeEnum.eChallengeType).daliy)
end

UIPeriodicChallenge.__CloseLevelDetailWindow = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.levelDetailWindow ~= nil and (self.levelDetailWindow).active then
    (self.levelDetailWindow):OnClickSectorLevelDetailBackBtn()
    ;
    (UIUtil.OnClickBack)()
  end
end

UIPeriodicChallenge.__OnClickBack = function(self, toHome)
  -- function num : 0_8
  if self.closeCallback ~= nil then
    (self.closeCallback)(toHome)
  end
  self:Delete()
end

UIPeriodicChallenge.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  (self.infoItemNode):Delete()
  MsgCenter:RemoveListener(eMsgEventId.ChallengeOutOfData, self.__Refresh)
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  ;
  (base.OnDelete)(self)
end

return UIPeriodicChallenge

