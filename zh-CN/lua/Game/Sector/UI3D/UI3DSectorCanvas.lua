local UI3DSectorCanvas = class("UI3DSectorCanvas", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local UINSctItemInfo = require("Game.Sector.UI3D.UINSctItemInfo")
local UINSctItemProgress = require("Game.Sector.UI3D.UINSctItemProgress")
local UINSctNewbeeInfo = require("Game.Sector.UI3D.UINSctNewbeeInfo")
local SectorEnum = require("Game.Sector.SectorEnum")
local util = require("XLua.Common.xlua_util")
local UINStcChallengeInfo = require("Game.PeriodicChallenge.UI.UINStcChallengeInfo")
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
UI3DSectorCanvas.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINSctItemInfo, UINSctItemProgress, cs_ResLoader, eDungeonEnum
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).uI_STInfo):SetActive(false)
  ;
  ((self.ui).uI_STProgress):SetActive(false)
  self.sctInfoPool = (UIItemPool.New)(UINSctItemInfo, (self.ui).uI_STInfo)
  self.sctInfoDic = {}
  self.sctProgressPool = (UIItemPool.New)(UINSctItemProgress, (self.ui).uI_STProgress)
  self.sctProgressStageDic = {}
  self.sctProgressBuildDic = {}
  ;
  (UIUtil.AddButtonListener)((self.ui).btnFriendshipDungeon, self, self.EnterFriendshipDungeon)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnItemDungeon, self, self.EnterMatDungeon)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnATHDungeon, self, self.EnterATHDungeon)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_dailyChallengeButton, self, self.OnClickDailyDungeon)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_WeeklyChallengeButton, self, self.OnClickWeeklyChallenge)
  self.__onDailyLimitUpdate = BindCallback(self, self.__dailyLimitUpdate)
  MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  self.__onHasUncompletedEp = BindCallback(self, self.RefreshUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.ChallengeOutOfData, self.__onHasUncompletedEp)
  self._UpdateDailyDungeonFunc = BindCallback(self, self._UpdateDailyDungeon)
  MsgCenter:AddListener(eMsgEventId.DailyDungeonOutOfData, self._UpdateDailyDungeonFunc)
  self.localModelData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
  self.resloader = (cs_ResLoader.Create)()
  self.dungeonUIElementDic = {
[(eDungeonEnum.eDungeonType).fragDungeon] = {go = ((self.ui).btnFriendshipDungeon).gameObject, lockUI = (self.ui).obj_FriendshipLock, limitText = (self.ui).friendLimitedText, doubleObj = (self.ui).obj_double_frage, multRewardTex = (self.ui).tex_multReward_frage}
, 
[(eDungeonEnum.eDungeonType).matDungeon] = {go = ((self.ui).btnItemDungeon).gameObject, lockUI = (self.ui).obj_ItemLock, limitText = (self.ui).matLimitedText, doubleObj = (self.ui).obj_double_mat, multRewardTex = (self.ui).tex_multReward_mat}
, 
[(eDungeonEnum.eDungeonType).ATHDungeon] = {go = ((self.ui).btnATHDungeon).gameObject, lockUI = (self.ui).obj_ATHLock, limitText = (self.ui).athLimitedText, doubleObj = (self.ui).obj_double_ath, multRewardTex = (self.ui).tex_multReward_ath}
}
  self.sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  self.__periodicChangeRedDot = function(rednote)
    -- function num : 0_0_0 , upvalues : self
    self:RefreshPeriodicRedDot()
  end

  RedDotController:AddListener(RedDotDynPath.PeriodicChallenge, self.__periodicChangeRedDot)
end

UI3DSectorCanvas.SetDungeonUnlock = function(self, dungeonTypeData)
  -- function num : 0_1 , upvalues : eDungeonEnum
  if dungeonTypeData:GetDungeonType() == (eDungeonEnum.eDungeonType).DailyDungeon then
    return 
  end
  local UIElement = (self.dungeonUIElementDic)[dungeonTypeData:GetDungeonType()]
  local isUnlock = dungeonTypeData:GetDungeonTypeIsUnlock()
  ;
  (UIElement.lockUI):SetActive(not isUnlock)
  self:SetDungeonDailyLimit(dungeonTypeData)
end

UI3DSectorCanvas.SetDungeonDailyLimit = function(self, dungeonTypeData)
  -- function num : 0_2 , upvalues : _ENV
  local UIElement = (self.dungeonUIElementDic)[dungeonTypeData:GetDungeonType()]
  if UIElement == nil then
    return 
  end
  local completeIntro = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CompleteIntro)
  if UIElement.go ~= nil and not IsNull(UIElement.go) then
    (UIElement.go):SetActive(completeIntro)
  end
  local isUnlock = dungeonTypeData:GetDungeonTypeIsUnlock()
  ;
  ((((UIElement.limitText).transform).parent).gameObject):SetActive(isUnlock)
  do
    if isUnlock then
      local leftNum, totaleLimit, playedNums = dungeonTypeData:GetDungeonTypePlayLeftLimitNum()
      if leftNum == -1 then
        ((((UIElement.limitText).transform).parent).gameObject):SetActive(false)
      else
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (UIElement.limitText).text = tostring(leftNum) .. "/" .. tostring(totaleLimit)
      end
    end
    if isUnlock then
      local isHaveMultReward = dungeonTypeData:GetIsDungeonTypeHaveMultReward()
    end
    ;
    (UIElement.doubleObj):SetActive(isHaveMultReward)
    if isHaveMultReward then
      if dungeonTypeData:GetDungeonTypeMultRewardIsOnlyDouble() then
        (UIElement.multRewardTex):SetIndex(0)
      else
        ;
        (UIElement.multRewardTex):SetIndex(1)
      end
    end
  end
end

UI3DSectorCanvas.__dailyLimitUpdate = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  for dungeonType,dungeonTypeData in pairs(sectorCtrl.dungeonTypeDataDic) do
    self:SetDungeonDailyLimit(dungeonTypeData)
  end
end

UI3DSectorCanvas.EnterFriendshipDungeon = function(self, jumpTargetHeroId, isForce)
  -- function num : 0_4 , upvalues : eDungeonEnum, cs_MessageCommon, _ENV, SectorEnum, util
  if not isForce and self.sectorCtrl ~= nil and (self.sectorCtrl):IsDisableClick() then
    return 
  end
  local fragDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(eDungeonEnum.eDungeonType).fragDungeon]
  if fragDungeonTypeData == nil then
    (self.sectorCtrl):CheckAndSetDungeonUnlock()
    fragDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(eDungeonEnum.eDungeonType).fragDungeon]
  end
  if not fragDungeonTypeData:GetDungeonTypeIsUnlock() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(fragDungeonTypeData:GetDungeonTypeUnlockDes())
    return 
  end
  ;
  (UIUtil.AddOneCover)("EnterFriendshipDungeon")
  local loadFunc = function()
    -- function num : 0_4_0 , upvalues : self, _ENV, fragDungeonTypeData, jumpTargetHeroId, SectorEnum
    self.StartLoadFriendShipDungeon = true
    while 1 do
      if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    self.StartLoadFriendShipDungeon = false
    UIManager:ShowWindowAsync(UIWindowTypeID.FriendShipPlotDungeon, function(window)
      -- function num : 0_4_0_0 , upvalues : _ENV, self, fragDungeonTypeData, jumpTargetHeroId, SectorEnum
      if window == nil then
        (UIUtil.CloseOneCover)("EnterFriendshipDungeon")
        return 
      end
      ;
      (self.sectorCtrl):OnEnterPlotOrMateralDungeon()
      window:InitPlotDungeon(fragDungeonTypeData, jumpTargetHeroId, function(tohome)
        -- function num : 0_4_0_0_0 , upvalues : self
        (self.sectorCtrl):ResetToNormalState(tohome)
      end
)
      if self.localModelData ~= nil then
        (self.localModelData):RecordLastSectorSelected((SectorEnum.eSectorMentionId).FriendshipDungeonId)
      end
      UIManager:HideWindow(UIWindowTypeID.Sector)
      NoticeManager:DeleteNoticeByType((NoticeManager.eNoticeType).FragDungeonRefresh)
      ;
      (UIUtil.CloseOneCover)("EnterFriendshipDungeon")
    end
)
  end

  if not self.StartLoadFriendShipDungeon then
    self.__loadFriendShipDungeon = (GR.StartCoroutine)((util.cs_generator)(loadFunc))
  end
end

UI3DSectorCanvas.EnterMatDungeon = function(self, jumpTargetTypeId, isForce)
  -- function num : 0_5 , upvalues : eDungeonEnum, cs_MessageCommon, _ENV, SectorEnum, util
  if not isForce and self.sectorCtrl ~= nil and (self.sectorCtrl):IsDisableClick() then
    return 
  end
  local matDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(eDungeonEnum.eDungeonType).matDungeon]
  if matDungeonTypeData == nil then
    (self.sectorCtrl):CheckAndSetDungeonUnlock()
    matDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(eDungeonEnum.eDungeonType).matDungeon]
  end
  if not matDungeonTypeData:GetDungeonTypeIsUnlock() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(matDungeonTypeData:GetDungeonTypeUnlockDes())
    return 
  end
  ;
  (UIUtil.AddOneCover)("EnterMatDungeon")
  local loadFunc = function()
    -- function num : 0_5_0 , upvalues : self, _ENV, matDungeonTypeData, jumpTargetTypeId, SectorEnum
    self.StartLoadMatDungeon = true
    while 1 do
      if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    self.StartLoadMatDungeon = false
    UIManager:ShowWindowAsync(UIWindowTypeID.MaterialDungeon, function(window)
      -- function num : 0_5_0_0 , upvalues : _ENV, self, matDungeonTypeData, jumpTargetTypeId, SectorEnum
      if window == nil then
        (UIUtil.CloseOneCover)("EnterMatDungeon")
        return 
      end
      ;
      (self.sectorCtrl):OnEnterPlotOrMateralDungeon()
      window:InitDungeonType(matDungeonTypeData, jumpTargetTypeId, function(tohome)
        -- function num : 0_5_0_0_0 , upvalues : self
        (self.sectorCtrl):ResetToNormalState(tohome)
      end
)
      if self.localModelData ~= nil then
        (self.localModelData):RecordLastSectorSelected((SectorEnum.eSectorMentionId).MaterialDungeonId)
      end
      UIManager:HideWindow(UIWindowTypeID.Sector)
      NoticeManager:DeleteNoticeByType((NoticeManager.eNoticeType).ResDungeonRefresh)
      ;
      (UIUtil.CloseOneCover)("EnterMatDungeon")
    end
)
  end

  if not self.StartLoadMatDungeon then
    self.__loadMatDungeon = (GR.StartCoroutine)((util.cs_generator)(loadFunc))
  end
end

UI3DSectorCanvas.EnterATHDungeon = function(self, jumpTargetTypeId, isForce)
  -- function num : 0_6 , upvalues : eDungeonEnum, cs_MessageCommon, _ENV, SectorEnum, util
  if not isForce and self.sectorCtrl ~= nil and (self.sectorCtrl):IsDisableClick() then
    return 
  end
  local ATHDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(eDungeonEnum.eDungeonType).ATHDungeon]
  if ATHDungeonTypeData == nil then
    (self.sectorCtrl):CheckAndSetDungeonUnlock()
    ATHDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(eDungeonEnum.eDungeonType).ATHDungeon]
  end
  if not ATHDungeonTypeData:GetDungeonTypeIsUnlock() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ATHDungeonTypeData:GetDungeonTypeUnlockDes())
    return 
  end
  ;
  (UIUtil.AddOneCover)("EnterATHDungeon")
  local loadFunc = function()
    -- function num : 0_6_0 , upvalues : self, _ENV, ATHDungeonTypeData, jumpTargetTypeId, SectorEnum
    self.StartLoadAthDungeon = true
    while 1 do
      if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    self.StartLoadAthDungeon = false
    UIManager:ShowWindowAsync(UIWindowTypeID.ATHDungeon, function(window)
      -- function num : 0_6_0_0 , upvalues : _ENV, self, ATHDungeonTypeData, jumpTargetTypeId, SectorEnum
      if window == nil then
        (UIUtil.CloseOneCover)("EnterATHDungeon")
        return 
      end
      ;
      (self.sectorCtrl):OnEnterPlotOrMateralDungeon()
      window:InitDungeonType(ATHDungeonTypeData, jumpTargetTypeId, function(tohome)
        -- function num : 0_6_0_0_0 , upvalues : self
        (self.sectorCtrl):ResetToNormalState(tohome)
      end
)
      if self.localModelData ~= nil then
        (self.localModelData):RecordLastSectorSelected((SectorEnum.eSectorMentionId).ATHDungeonId)
      end
      UIManager:HideWindow(UIWindowTypeID.Sector)
      NoticeManager:DeleteNoticeByType((NoticeManager.eNoticeType).ATHDungeonRefresh)
      ;
      (UIUtil.CloseOneCover)("EnterATHDungeon")
    end
)
  end

  if not self.StartLoadAthDungeon then
    self.__loadAthDungeon = (GR.StartCoroutine)((util.cs_generator)(loadFunc))
  end
end

UI3DSectorCanvas.SetDailyDungeonInfo = function(self, coouldShow)
  -- function num : 0_7 , upvalues : UINStcChallengeInfo
  if coouldShow then
    self.dailyChallengeBtn = (UINStcChallengeInfo.New)()
    ;
    (self.dailyChallengeBtn):Init(((self.ui).obj_DailyChallengeButton).gameObject)
    ;
    (self.dailyChallengeBtn):InitDailyDgEnterBtn()
    self:RefreshPeriodicRedDot()
  else
    ;
    (((self.ui).obj_DailyChallengeButton).gameObject):SetActive(false)
  end
end

UI3DSectorCanvas.SetWeeklyChallengeInfo = function(self, coouldShow)
  -- function num : 0_8 , upvalues : UINStcChallengeInfo
  if coouldShow then
    if self.weeklyChallengeBtn == nil then
      self.weeklyChallengeBtn = (UINStcChallengeInfo.New)()
      ;
      (self.weeklyChallengeBtn):Init(((self.ui).obj_WeeklyChallengeButton).gameObject)
    end
    ;
    (((self.ui).obj_WeeklyChallengeButton).gameObject):SetActive(true)
    ;
    (self.weeklyChallengeBtn):InitWeeklyChallenge(true)
    self:RefreshWeeklyRedDot()
  else
    ;
    (((self.ui).obj_WeeklyChallengeButton).gameObject):SetActive(false)
  end
end

UI3DSectorCanvas.OnClickDailyDungeon = function(self)
  -- function num : 0_9 , upvalues : eDungeonEnum, _ENV, SectorEnum, util
  if self.sectorCtrl ~= nil and (self.sectorCtrl):IsDisableClick() then
    return 
  end
  local dailyDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(eDungeonEnum.eDungeonType).DailyDungeon]
  if dailyDungeonTypeData == nil then
    (self.sectorCtrl):CheckAndSetDungeonUnlock()
    dailyDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(eDungeonEnum.eDungeonType).DailyDungeon]
  end
  local loadFunc = function()
    -- function num : 0_9_0 , upvalues : self, _ENV, SectorEnum
    self.StartLoadDailyChallenge = true
    while 1 do
      if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    self.StartLoadDailyChallenge = false
    local dailyDgCtrl = ControllerManager:GetController(ControllerTypeId.DailyDungeonLevelCtrl, true)
    dailyDgCtrl:ShowDailyDungeonMain(function()
      -- function num : 0_9_0_0 , upvalues : self, SectorEnum
      if self.localModelData ~= nil then
        (self.localModelData):RecordLastSectorSelected((SectorEnum.eSectorMentionId).DailyChallenge)
      end
      ;
      (self.sectorCtrl):OnEnterWeeklyChallenge()
    end
, function(tohome)
      -- function num : 0_9_0_1 , upvalues : self
      (self.sectorCtrl):ResetToNormalState(tohome)
    end
)
  end

  if not self.StartLoadDailyChallenge then
    self.__loadDailyChallenge = (GR.StartCoroutine)((util.cs_generator)(loadFunc))
  end
end

UI3DSectorCanvas.OnClickWeeklyChallenge = function(self)
  -- function num : 0_10 , upvalues : _ENV, SectorEnum, util
  if self.sectorCtrl ~= nil and (self.sectorCtrl):IsDisableClick() then
    return 
  end
  if (ControllerManager:GetController(ControllerTypeId.SectorController)):HasUnfinishEp() then
    ExplorationManager:TryToShowCurrentLevelTips()
    return 
  end
  local _, _, moduleId = ExplorationManager:HasUncompletedEp()
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
    ExplorationManager:TryToShowCurrentLevelTips()
    return 
  end
  local loadFunc = function()
    -- function num : 0_10_0 , upvalues : self, _ENV, SectorEnum
    self.StartLoadWeeklyChallenge = true
    while 1 do
      if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    self.StartLoadWeeklyChallenge = false
    UIManager:ShowWindowAsync(UIWindowTypeID.DailyChallenge, function(window)
      -- function num : 0_10_0_0 , upvalues : self, SectorEnum, _ENV
      if self.localModelData ~= nil then
        (self.localModelData):RecordLastSectorSelected((SectorEnum.eSectorMentionId).WeeklyChallenge)
      end
      ;
      (self.sectorCtrl):OnEnterWeeklyChallenge()
      window:InitWeeklyChallenge(function(tohome)
        -- function num : 0_10_0_0_0 , upvalues : self
        (self.sectorCtrl):ResetToNormalState(tohome)
      end
)
      NoticeManager:DeleteNoticeByType((NoticeManager.eNoticeType).weeklyChallenge)
    end
)
  end

  if not self.StartLoadWeeklyChallenge then
    self.__loadWeeklyChallenge = (GR.StartCoroutine)((util.cs_generator)(loadFunc))
  end
end

UI3DSectorCanvas.InitSctUI3DCanvas = function(self)
  -- function num : 0_11
end

UI3DSectorCanvas.AddSctInfoItem = function(self, sectorId, clickFunc)
  -- function num : 0_12 , upvalues : _ENV
  local infoItem = (self.sctInfoPool):GetOne()
  infoItem:InitSctItemInfo(sectorId, clickFunc, self.resloader)
  infoItem:SetText2TextNode((self.ui).tran_infoTextParent)
  infoItem:SetTextEn2TextEnNode((self.ui).tran_infoTextEnParent)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (infoItem.gameObject).name = tostring(sectorId)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sctInfoDic)[sectorId] = infoItem
  return infoItem
end

UI3DSectorCanvas.CreateNewBeeSectorItem = function(self, sectorId, clickFunc)
  -- function num : 0_13 , upvalues : UINSctNewbeeInfo
  if self.__sctNewbeeItem == nil then
    self.__sctNewbeeItem = (UINSctNewbeeInfo.New)()
    ;
    (self.__sctNewbeeItem):Init((self.ui).btn_STNewbee)
  end
  ;
  (self.__sctNewbeeItem):InitSctNewbeeInfo(sectorId, clickFunc)
  return self.__sctNewbeeItem
end

UI3DSectorCanvas.AddSctProgressStage = function(self, sectorId, clickFunc)
  -- function num : 0_14
  local item = (self.sctProgressPool):GetOne()
  item:InitSctProgress(sectorId, true, clickFunc)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sctProgressStageDic)[sectorId] = item
  return item
end

UI3DSectorCanvas.AddSctProgressBuild = function(self, sectorId, clickFunc)
  -- function num : 0_15
  local item = (self.sctProgressPool):GetOne()
  item:InitSctProgress(sectorId, false, clickFunc)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sctProgressBuildDic)[sectorId] = item
  return item
end

UI3DSectorCanvas.SetUISctSelect = function(self, position, size)
  -- function num : 0_16
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if self.ui ~= nil then
    ((self.ui).uI_STSelect).position = position
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).uI_STSelect).sizeDelta = size
  end
end

UI3DSectorCanvas.RefreshPeriodicRedDot = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local isFinish, num, max = (PlayerDataCenter.periodicChallengeData):GetDailyChallengeStage()
  if isFinish then
    ((self.ui).redDot_dailyChallenge):SetActive(false)
    ;
    ((self.ui).blueDot_dailyChallenge):SetActive(false)
  else
    if num < max then
      ((self.ui).redDot_dailyChallenge):SetActive(true)
      ;
      ((self.ui).blueDot_dailyChallenge):SetActive(false)
    else
      ;
      ((self.ui).redDot_dailyChallenge):SetActive(false)
      ;
      ((self.ui).blueDot_dailyChallenge):SetActive(true)
    end
  end
end

UI3DSectorCanvas.RefreshWeeklyRedDot = function(self)
  -- function num : 0_18
  ((self.ui).redDot_weeklyChallenge):SetActive(false)
  ;
  ((self.ui).blueDot_weeklyChallenge):SetActive(false)
end

UI3DSectorCanvas.RefreshUncompletedEp = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if not (PlayerDataCenter.allWeeklyChallengeData):IsOutOfData() then
    self:SetWeeklyChallengeInfo((PlayerDataCenter.allWeeklyChallengeData):IsExistChallenge())
  end
end

UI3DSectorCanvas._UpdateDailyDungeon = function(self)
  -- function num : 0_20
  if self.dailyChallengeBtn ~= nil then
    (self.dailyChallengeBtn):RefreshStcChallengeInfo()
  end
end

UI3DSectorCanvas.OnDelete = function(self)
  -- function num : 0_21 , upvalues : _ENV, base
  RedDotController:RemoveListener(RedDotDynPath.PeriodicChallenge, self.__periodicChangeRedDot)
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.ChallengeOutOfData, self.__onHasUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.DailyDungeonOutOfData, self._UpdateDailyDungeonFunc)
  ;
  (self.sctInfoPool):DeleteAll()
  ;
  (self.sctProgressPool):DeleteAll()
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.__loadFriendShipDungeon ~= nil and self.StartLoadFriendShipDungeon then
    (GR.StopCoroutine)(self.__loadFriendShipDungeon)
    self.StartLoadFriendShipDungeon = false
    self.__loadFriendShipDungeon = nil
  end
  if self.__loadMatDungeon ~= nil and self.StartLoadMatDungeon then
    (GR.StopCoroutine)(self.__loadMatDungeon)
    self.StartLoadMatDungeon = false
    self.__loadMatDungeon = nil
  end
  if self.__loadAthDungeon ~= nil and self.StartLoadAthDungeon then
    (GR.StopCoroutine)(self.__loadAthDungeon)
    self.StartLoadAthDungeon = false
    self.__loadAthDungeon = nil
  end
  if self.__loadDailyChallenge ~= nil and self.StartLoadDailyChallenge then
    (GR.StopCoroutine)(self.__loadDailyChallenge)
    self.StartLoadDailyChallenge = false
    self.__loadDailyChallenge = nil
  end
  if self.__loadWeeklyChallenge ~= nil and self.StartLoadWeeklyChallenge then
    (GR.StopCoroutine)(self.__loadWeeklyChallenge)
    self.StartLoadWeeklyChallenge = false
    self.__loadWeeklyChallenge = nil
  end
  if self.dailyChallengeBtn ~= nil then
    (self.dailyChallengeBtn):Delete()
  end
  if self.dailyChallengeBtn ~= nil then
    (self.dailyChallengeBtn):Delete()
  end
  if self.weeklyChallengeBtn ~= nil then
    (self.weeklyChallengeBtn):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UI3DSectorCanvas

