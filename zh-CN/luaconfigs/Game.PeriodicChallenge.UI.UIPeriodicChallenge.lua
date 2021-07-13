-- params : ...
-- function num : 0 , upvalues : _ENV
local UIPeriodicChallenge = class("UIPeriodicChallenge", UIBaseWindow)
local base = UIBaseWindow
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local UINStcChallengeInfo = require("Game.PeriodicChallenge.UI.UINStcChallengeInfo")
local UINPeriodicChallenge = require("Game.PeriodicChallenge.UI.UINPeriodicChallenge")
local UINPeriodicInfoItem = require("Game.PeriodicChallenge.UI.UINPeriodicInfoItem")
local cs_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")
UIPeriodicChallenge.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINPeriodicInfoItem, UINPeriodicChallenge, UINStcChallengeInfo
  (UIUtil.SetTopStatus)(self, self.__OnClickBack, {ConstGlobalItem.SKey})
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.__CloseLevelDetailWindow)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_WeeklyShop, self, self.__OnClickWeeklyShop)
  self.infoItemPool = (UIItemPool.New)(UINPeriodicInfoItem, (self.ui).obj_infoItem)
  ;
  ((self.ui).obj_infoItem):SetActive(false)
  self.nodeList = {}
  for i,v in ipairs((self.ui).nodeObjList) do
    local item = (UINPeriodicChallenge.New)()
    item:Init(v)
    ;
    (item.gameObject):SetActive(false)
    ;
    (table.insert)(self.nodeList, item)
  end
  self.stcItem = (UINStcChallengeInfo.New)()
  ;
  (self.stcItem):Init((self.ui).uI_STChallengeInfo)
  self.__onHasUncompletedEp = BindCallback(self, self.RefreshUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.ChallengeOutOfData, self.__onHasUncompletedEp)
end

UIPeriodicChallenge.InitPeriodicChallenge = function(self, closeCallback)
  -- function num : 0_1 , upvalues : SectorLevelDetailEnum, PeridicChallengeEnum, _ENV
  self.detailType = (SectorLevelDetailEnum.eDetailType).PeriodicChallenge
  self.echallengeType = (PeridicChallengeEnum.eChallengeType).daliy
  ;
  (PlayerDataCenter.sectorStage):SetSelectSectorId(nil)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (PlayerDataCenter.sectorStage).lastChallengeType = proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge
  self.closeCallback = closeCallback
  ;
  (self.infoItemPool):HideAll()
  ;
  (((self.nodeList)[1]).gameObject):SetActive(true)
  local dungeonId = (PlayerDataCenter.periodicChallengeData):GetChallengeId(self.echallengeType)
  ;
  ((self.nodeList)[1]):InitPeriodicItem(dungeonId, self.echallengeType, self)
  local infoItem = (self.infoItemPool):GetOne(true)
  infoItem:InitPeriodicInfoItem(dungeonId, self.echallengeType, 0)
  ;
  (infoItem.transform):SetParent(((((self.nodeList)[1]).ui).infoHolder).transform)
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (infoItem.transform).localPosition = Vector3(0, 0, 0)
  ;
  (self.stcItem):InitPeriodicChallenge(self.echallengeType)
end

UIPeriodicChallenge.OnClickDailyBtn = function(self)
  -- function num : 0_2
  ((self.nodeList)[1]):OnClickDetail()
end

UIPeriodicChallenge.InitWeeklyChallenge = function(self, closeCallback)
  -- function num : 0_3 , upvalues : SectorLevelDetailEnum, _ENV
  self.detailType = (SectorLevelDetailEnum.eDetailType).WeeklyChallenge
  ;
  (PlayerDataCenter.sectorStage):SetSelectSectorId(nil)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (PlayerDataCenter.sectorStage).lastChallengeType = proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  self.closeCallback = closeCallback
  ;
  (self.infoItemPool):HideAll()
  local list = {}
  for k,v in pairs((PlayerDataCenter.allWeeklyChallengeData).dataDic) do
    (table.insert)(list, v)
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_3_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.infoItemPool):HideAll()
  for i,v in ipairs(list) do
    if i <= #self.nodeList then
      local item = (self.nodeList)[i]
      ;
      (item.gameObject):SetActive(true)
      item:InitWeeklyItem(v.id, self)
      local infoItem = (self.infoItemPool):GetOne(true)
      infoItem:InitWeeklyInfoItem(v.id, i - 1)
      ;
      (infoItem.transform):SetParent(((item.ui).infoHolder).transform)
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (infoItem.transform).localPosition = Vector3(0, 0, 0)
    end
  end
  ;
  (self.stcItem):InitWeeklyChallenge()
end

UIPeriodicChallenge.OnClickWeeklyBtn = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local _, dungoenId, moduleId = ExplorationManager:HasUncompletedEp()
  for i,v in ipairs(self.nodeList) do
    if v.dungeonId == dungoenId then
      v:OnClickDetail()
      break
    end
  end
end

UIPeriodicChallenge.RefreshUncompletedEp = function(self)
  -- function num : 0_5 , upvalues : SectorLevelDetailEnum, _ENV
  self:__CloseLevelDetailWindow()
  if self.detailType == (SectorLevelDetailEnum.eDetailType).WeeklyChallenge then
    if not (PlayerDataCenter.allWeeklyChallengeData):IsExistChallenge() then
      local JumpManager = require("Game.Jump.JumpManager")
      JumpManager:Jump((JumpManager.eJumpTarget).Sector, function(func)
    -- function num : 0_5_0 , upvalues : _ENV
    UIManager:DeleteWindow(UIWindowTypeID.DailyChallenge)
    func()
  end
)
    else
      do
        self:InitWeeklyChallenge(self.closeCallback)
        if self.detailType == (SectorLevelDetailEnum.eDetailType).PeriodicChallenge then
          self:InitPeriodicChallenge(self.closeCallback)
        end
      end
    end
  end
end

UIPeriodicChallenge.OnClickItemCallback = function(self, item, flag)
  -- function num : 0_6
  if flag then
    if self.selectedItem ~= nil then
      (self.selectedItem):SetSelectState(false)
    end
    self.selectedItem = item
    self:OnSelectSectorLevel(item)
  else
    self.selectedItem = nil
  end
end

UIPeriodicChallenge.__CloseLevelDetailWindow = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.selectedItem ~= nil then
    (UIUtil.OnClickBack)()
  end
end

UIPeriodicChallenge.OnSelectSectorLevel = function(self, item)
  -- function num : 0_8 , upvalues : _ENV, SectorLevelDetailEnum, cs_MessageCommon
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevelDetail, function(window)
    -- function num : 0_8_0 , upvalues : self, item, SectorLevelDetailEnum, _ENV, cs_MessageCommon
    window:SetLevelDetaiHideStartEvent(function()
      -- function num : 0_8_0_0 , upvalues : self, item
      self:__PlayMoveLeftTween(false)
      item:SetSelectState(false)
      self:OnClickItemCallback(item, false)
    end
)
    window:SetLevelDetaiHideEndEvent(function()
      -- function num : 0_8_0_1
    end
)
    local width, duration = window:GetLevelDetailWidthAndDuration()
    self:__PlayMoveLeftTween(true, width, duration)
    item:SetSelectState(true)
    if item.detailType == (SectorLevelDetailEnum.eDetailType).PeriodicChallenge then
      window:InitPeriodicChallengeDetailNode(item.dungeonId, item.eChallenge)
    else
      if item.detailType == (SectorLevelDetailEnum.eDetailType).WeeklyChallenge then
        local data = ((PlayerDataCenter.allWeeklyChallengeData).dataDic)[item.dungeonId]
        local isLocked = not data:IsUnlockWeeklyChallenge()
        window:InitWeeklyChallengeDetailNode(item.dungeonId, isLocked)
        if isLocked then
          (cs_MessageCommon.ShowMessageTipsWithErrorSound)((CheckCondition.GetUnlockInfoLua)((data.cfg).pre_condition, (data.cfg).pre_para1, (data.cfg).pre_para2))
        end
      end
    end
  end
)
end

UIPeriodicChallenge.__PlayMoveLeftTween = function(self, isLeft, offset, duration)
  -- function num : 0_9 , upvalues : _ENV
  local var = ((self.ui).obj_levelNode).transform
  do
    if self.__moveLeftTween == nil then
      local endValue = (Vector2.unity_vector2)(1 - offset / ((var.rect).width + (self.ui).moveLeftTwenOffset), 1)
      self.__moveLeftTween = (var:DOAnchorMax(endValue, duration)):SetAutoKill(false)
      self.__moveLeftTweenDuration = duration
    end
    if self.currentMoveLeft ~= nil and self.currentMoveLeft == isLeft then
      return 
    end
    self.currentMoveLeft = isLeft
    if isLeft then
      (self.__moveLeftTween):PlayForward()
    else
      ;
      (self.__moveLeftTween):PlayBackwards()
    end
  end
end

UIPeriodicChallenge.__OnClickWeeklyShop = function(self)
  -- function num : 0_10 , upvalues : JumpManager, ShopEnum
  JumpManager:DirectShowShop(nil, nil, (ShopEnum.ShopId).weekly)
end

UIPeriodicChallenge.__OnClickBack = function(self, toHome)
  -- function num : 0_11
  if self.closeCallback ~= nil then
    (self.closeCallback)(toHome)
  end
  self:Delete()
end

UIPeriodicChallenge.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  (self.stcItem):Delete()
  for i,v in ipairs(self.nodeList) do
    v:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.ChallengeOutOfData, self.__onHasUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  if self.__moveLeftTween ~= nil then
    (self.__moveLeftTween):Kill()
    self.__moveLeftTween = nil
  end
  local sectorLevelDetail = UIManager:GetWindow(UIWindowTypeID.SectorLevelDetail)
  if sectorLevelDetail ~= nil then
    sectorLevelDetail:SetLevelDetaiHideStartEvent(nil)
  end
  ;
  (base.OnDelete)(self)
end

return UIPeriodicChallenge

