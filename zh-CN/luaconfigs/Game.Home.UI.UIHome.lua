-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHome = class("UIHome", UIBaseWindow)
local base = UIBaseWindow
local CS_OasisCameraController = CS.OasisCameraController
local CS_SystemInfo = (CS.UnityEngine).SystemInfo
local CS_BatteryStatus = (CS.UnityEngine).BatteryStatus
local cs_ResLoader = CS.ResLoader
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local CS_ClientConsts = CS.ClientConsts
local HomeBannerManager = require("Game.Home.Banner.HomeBannerManager")
local UINHomeBanner = require("Game.Home.Banner.UINHomeBanner")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINHomeAdjutant = require("Game.Home.UI.UINHomeAdjutant")
local UINHomeResourceItem = require("Game.Home.UI.UINHomeResourceItem")
local UINHomeRightList = require("Game.Home.UI.UINHomeRightList")
local UINHomeNoticeItem = require("Game.Home.UI.UINHomeNoticeItem")
local HomeEnum = require("Game.Home.HomeEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
UIHome.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader, UINResourceGroup, UINHomeResourceItem, CS_OasisCameraController, UINHomeAdjutant, UINHomeRightList, ActivityFrameEnum, CS_LeanTouch
  self.homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  self.resloader = (cs_ResLoader.Create)()
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).obj_resourceGroup)
  ;
  (self.resourceGroup):ChangeResourceItemClass(UINHomeResourceItem)
  self.fakeCameraHome = ((((CS.UnityEngine).GameObject).Find)("FakeCameraHome")):GetComponent("Camera")
  self:AlignToFakeCamera(self.fakeCameraHome)
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)((CS_OasisCameraController.Instance).transform, self.bind)
  self.homeAdjutant = (UINHomeAdjutant.New)()
  ;
  (self.homeAdjutant):Init((self.ui).obj_heroHolder)
  ;
  (self.homeAdjutant):InitHomeAdjutant(self.bind)
  self.rightList = (UINHomeRightList.New)()
  ;
  (self.rightList):Init((self.ui).obj_right)
  ;
  (self.rightList):InitHomeRightList(self)
  self.sideWin = nil
  if isEditorMode and ((CS.GMController).Instance).battleShortcut and ExplorationManager:HasUncompletedEp() then
    ExplorationManager:ContinueLastExploration()
  end
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_HideUI, self, self.SetShowMainUI, false)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_ShowMain, self, self.SetShowMainUI, true)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SelectBoardHero, self, self.OnClickChangeAdjutantBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Task, self, self.OnClickTaskBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_QuickTaskGet, self, self.OnQuickTaskGetBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_userInfo, self, self.OnClickPlayerInfoBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HomeSide, self, self.OnClickSideBtn)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_Novice, self, self.OnClickActivityBtn, (ActivityFrameEnum.eActivityEnterType).Novice)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_Limited, self, self.OnClickActivityBtn, (ActivityFrameEnum.eActivityEnterType).LimitTime)
  self:RegistTaskRedDot()
  self:RegistSideRedDot()
  self.__onTaskCommitComplete = BindCallback(self, self.OnTaskCommitComplete)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommitComplete)
  self.__onTaskPeroidCommit = BindCallback(self, self.OnTaskPeroidCommit)
  MsgCenter:AddListener(eMsgEventId.PeroidCommitComplete, self.__onTaskPeroidCommit)
  GuideManager:TryTriggerGuide(eGuideCondition.FInHome)
  self.onHookVoiceTimer = (TimerManager:GetTimer((ConfigData.buildinConfig).HomeOnHookVoiceTime, function()
    -- function num : 0_0_0 , upvalues : self
    (self.homeController):PlayVoHomeOnHook()
  end
, nil, false)):Start()
  self.__onGesture = BindCallback(self, self.OnGesture)
  ;
  (CS_LeanTouch.OnGesture)("+", self.__onGesture)
  self.__RefreshActivityShow = BindCallback(self, self.RefreshActivityShow)
  MsgCenter:AddListener(eMsgEventId.ActivityShowChange, self.__RefreshActivityShow)
  ;
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_0_1 , upvalues : self
    ((self.ui).redDot_activity_novice):SetActive(num > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameNovice)
  ;
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_0_2 , upvalues : self
    ((self.ui).redDot_activity_limitTime):SetActive(num > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameLimitTime)
  ;
  (((self.ui).tex_Voice).gameObject):SetActive(false)
  ;
  ((self.ui).ani_VoiceIcon):SetActive(false)
  self:RefreshBannerWidget()
  self.__RefreshBatteryAndTime = BindCallback(self, self.RefreshBatteryAndTime)
end

UIHome.OnShow = function(self, isFromOasis)
  -- function num : 0_1 , upvalues : base, _ENV
  (self.homeController):OnShowHomeUI(isFromOasis)
  self:RefreshName()
  self:RefreshUserLevel()
  self:RefreshTaskBtn()
  self:ShowTween()
  self:RefreshActivityShow()
  ;
  (self.rightList):RebuildRightList()
  ;
  (base.OnShow)(self)
  if self.BatteryTimer ~= nil then
    (self.BatteryTimer):Stop()
    self.BatteryTimer = nil
  end
  self.BatteryTimer = (TimerManager:GetTimer(1, self.__RefreshBatteryAndTime, nil, false, false, true)):Start()
end

UIHome.ShowTween = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).canvasGroup).alpha = 0
  ;
  (((self.ui).canvasGroup):DOFade(1, 0.5)):SetLink(((self.ui).canvasGroup).gameObject)
end

UIHome.m_SetMainCameraEnabled = function(self, enabled)
  -- function num : 0_3 , upvalues : CS_OasisCameraController
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((CS_OasisCameraController.Instance).MainCamera).enabled = enabled
end

UIHome.SetFrom2Home = function(self, from, playReturnHomeCv)
  -- function num : 0_4 , upvalues : _ENV
  if (from == AreaConst.Sector or from == AreaConst.FactoryDorm) and ((self.bind).homeToSectorGo).activeInHierarchy then
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
    ;
    ((self.bind).homeToSectorGo):SetActive(true)
    ;
    ((self.bind).homeToOasisGo):SetActive(false)
    ;
    ((self.bind).homeToMenuGo):SetActive(false)
    ;
    (self.rightList):WaitEpTimeLine(true)
    local timeline = nil
    if from == AreaConst.Sector then
      timeline = (self.bind).sectorPlayableDirector
    else
      timeline = (self.bind).factorydormPlayableDirector
    end
    self.__tlSectorCo = (TimelineUtil.Rewind)(timeline, function()
    -- function num : 0_4_0 , upvalues : _ENV, self
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    ;
    (self.rightList):WaitEpTimeLine(false)
  end
)
  end
  do
    if from == AreaConst.Oasis then
      ((self.bind).homeToSectorGo):SetActive(false)
      ;
      ((self.bind).homeToOasisGo):SetActive(true)
      ;
      ((self.bind).homeToMenuGo):SetActive(false)
    end
    if playReturnHomeCv then
      (self.homeController):PlayVoReturnHome()
    end
  end
end

UIHome.SetTo = function(self, to)
  -- function num : 0_5 , upvalues : _ENV
  if to == AreaConst.Sector or to == AreaConst.FactoryDorm then
    ((self.bind).homeToSectorGo):SetActive(true)
    ;
    ((self.bind).homeToOasisGo):SetActive(false)
    ;
    ((self.bind).homeToMenuGo):SetActive(false)
  else
    if to == AreaConst.Oasis then
      ((self.bind).homeToSectorGo):SetActive(false)
      ;
      ((self.bind).homeToOasisGo):SetActive(true)
      ;
      ((self.bind).homeToMenuGo):SetActive(false)
    end
  end
end

UIHome.OnGesture = function(self, fingerList)
  -- function num : 0_6
  if self.onHookVoiceTimer == nil then
    return 
  end
  ;
  (self.onHookVoiceTimer):Reset()
end

UIHome.PauseHomeOnHookTimer = function(self, pause)
  -- function num : 0_7
  if self.onHookVoiceTimer == nil then
    return 
  end
  if pause then
    (self.onHookVoiceTimer):Pause()
  else
    ;
    (self.onHookVoiceTimer):Reset()
    ;
    (self.onHookVoiceTimer):Resume()
  end
end

UIHome.StopHomeOnHookTimer = function(self)
  -- function num : 0_8 , upvalues : CS_LeanTouch
  if self.onHookVoiceTimer ~= nil then
    (self.onHookVoiceTimer):Stop()
    self.onHookVoiceTimer = nil
    ;
    (CS_LeanTouch.OnGesture)("-", self.__onGesture)
  end
end

UIHome.OpenOtherWin = function(self)
  -- function num : 0_9
  self:m_SetMainCameraEnabled(false)
  self:Hide()
end

UIHome.OpenOtherCoverWin = function(self)
  -- function num : 0_10
  (self.homeController):OnCoverHomeUI()
end

UIHome.BackFromOtherWin = function(self)
  -- function num : 0_11
  self:m_SetMainCameraEnabled(true)
  self:Show()
end

UIHome.BackFromOtherCoverWin = function(self)
  -- function num : 0_12
  (self.homeController):OnShowHomeUI()
end

UIHome.SetShowMainUI = function(self, bool)
  -- function num : 0_13
  ((self.ui).obj_main):SetActive(bool)
  ;
  ((self.ui).obj_rightBackground):SetActive(bool)
  ;
  (((self.ui).btn_ShowMain).gameObject):SetActive(not bool)
end

UIHome.ShowHeroVoiceText = function(self, show, text)
  -- function num : 0_14
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  if show then
    ((self.ui).tex_Voice).text = text
  end
  ;
  ((self.ui).ani_VoiceIcon):SetActive(show)
  ;
  (((self.ui).tex_Voice).gameObject):SetActive(show)
  ;
  (((self.ui).tex_Dialog).gameObject):SetActive(not show)
end

UIHome.OnClickChangeAdjutantBtn = function(self)
  -- function num : 0_15 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectBoardHero, function(win)
    -- function num : 0_15_0 , upvalues : self
    if win ~= nil then
      win:InitSelectBoardHero((self.homeController).homeCurrAdjutantHeroData, true)
      win.changeBoardHeroCallback = (self.homeAdjutant)._LoadBoardHero
      self:OpenOtherWin()
    end
  end
)
end

UIHome.OnClickPlayerInfoBtn = function(self)
  -- function num : 0_16 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfo, function(win)
    -- function num : 0_16_0 , upvalues : self
    if win ~= nil then
      win:InitUserInfo()
      self:OpenOtherWin()
    end
  end
)
end

UIHome.OnClickTaskBtn = function(self, taskTypeID)
  -- function num : 0_17 , upvalues : _ENV
  local taskController = ControllerManager:GetController(ControllerTypeId.Task, false)
  if taskController == nil then
    error("get taskController error")
    return 
  end
  taskController:ShowTaskUI(taskTypeID, function()
    -- function num : 0_17_0 , upvalues : self
    self:OpenOtherWin()
  end
)
end

UIHome.OnQuickTaskGetBtn = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self.__quickTaskData == nil then
    return 
  end
  if self.__quickIsPeroid then
    (ControllerManager:GetController(ControllerTypeId.Task, true)):SendCommitTaskPeriod(((self.__quickTaskData).stcData).id, ((self.__quickTaskData).stcData).type)
  else
    local isTaskCompelete = (self.__quickTaskData):CheckComplete()
    if not isTaskCompelete then
      return 
    end
    ;
    (ControllerManager:GetController(ControllerTypeId.Task, true)):SendCommitQuestReward(self.__quickTaskData)
  end
end

UIHome.OnClickSideBtn = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if self.sideWin == nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.HomeSide, function(win)
    -- function num : 0_19_0 , upvalues : self
    if win ~= nil then
      self.sideWin = win
      ;
      (self.sideWin):InitSide(self)
      ;
      (self.sideWin):OpenSide()
    end
  end
)
  else
    ;
    (self.sideWin):OpenSide()
  end
end

UIHome.RegistSideRedDot = function(self)
  -- function num : 0_20 , upvalues : _ENV
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_20_0 , upvalues : self, _ENV
    (((self.ui).side_obj_RedDot).gameObject):SetActive(num > 0)
    if num < 10 then
      (((self.ui).tex_sideRedDotNum).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).tex_sideRedDotNum).text = tostring(num)
      ;
      ((self.ui).side_obj_RedDot):SetIndex(0)
    else
      (((self.ui).tex_sideRedDotNum).gameObject):SetActive(false)
      ;
      ((self.ui).side_obj_RedDot):SetIndex(1)
    end
    if num > 0 then
      ((self.ui).tex_Dialog):SetIndex(2)
    else
      ((self.ui).tex_Dialog):SetIndex(1)
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
, RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide)
end

UIHome.RegistTaskRedDot = function(self)
  -- function num : 0_21 , upvalues : _ENV
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_21_0 , upvalues : self
    ((self.ui).task_obj_RedDot):SetActive(num > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
end

UIHome.OnClickActivityBtn = function(self, enterType, activityId)
  -- function num : 0_22 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityFrameMain, function(window)
    -- function num : 0_22_0 , upvalues : self, enterType, activityId
    if window ~= nil then
      self:OpenOtherWin()
      window:InitFrameMain(enterType, activityId)
    end
  end
)
end

UIHome.RefreshActivityShow = function(self)
  -- function num : 0_23 , upvalues : _ENV, ActivityFrameEnum
  local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  ;
  (((self.ui).btn_Novice).gameObject):SetActive(activityCtrl:IsHaveShowByEnterType((ActivityFrameEnum.eActivityEnterType).Novice))
  ;
  (((self.ui).btn_Limited).gameObject):SetActive(activityCtrl:IsHaveShowByEnterType((ActivityFrameEnum.eActivityEnterType).LimitTime))
end

UIHome.RefreshName = function(self)
  -- function num : 0_24 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CommanderInformation)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if isUnlock then
    ((self.ui).tex_UserName).text = PlayerDataCenter.playerName
  end
  ;
  ((self.ui).userNameNode):SetActive(isUnlock)
  ;
  ((self.ui).tex_UserID):SetIndex(0, PlayerDataCenter.strPlayerId)
end

UIHome.RefreshUserLevel = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local curLevel = (PlayerDataCenter.playerLevel).level or 1
  local empty = ""
  if curLevel <= 99 then
    empty = "0"
  else
    empty = ""
  end
  ;
  ((self.ui).tex_Level):SetIndex(0, empty, tostring(curLevel))
end

UIHome.RefreshTaskBtn = function(self)
  -- function num : 0_26 , upvalues : _ENV
  local isUnlock = (self.homeController):IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi)
  ;
  (((self.ui).btn_Task).gameObject):SetActive(isUnlock)
  if not isUnlock then
    return 
  end
  local taskData, isTaskCompelete, isPeroid = (PlayerDataCenter.allTaskData):GetTaskData4Home()
  self.__quickTaskData = taskData
  self.__quickIsPeroid = isPeroid
  if taskData == nil then
    ((self.ui).tex_TaskInfo):SetIndex(1)
    ;
    ((self.ui).tex_Progress):SetIndex(1)
    ;
    (((self.ui).btn_QuickTaskGet).gameObject):SetActive(false)
    return 
  end
  ;
  (((self.ui).btn_QuickTaskGet).gameObject):SetActive(isTaskCompelete)
  if self.__quickIsPeroid then
    local infoContent = (string.format)((LanguageUtil.GetLocaleText)(((ConfigData.game_config).taskPeroidInfo)[((self.__quickTaskData).stcData).type]), ((self.__quickTaskData).stcData).id)
    ;
    ((self.ui).tex_TaskInfo):SetIndex(0, infoContent)
    ;
    ((self.ui).tex_Progress):SetIndex(1)
  else
    do
      if taskData.schedule <= taskData.aim then
        local stepCfg = taskData:GetStepCfg()
        ;
        ((self.ui).tex_TaskInfo):SetIndex(0, (LanguageUtil.GetLocaleText)(stepCfg.intro))
        ;
        ((self.ui).tex_Progress):SetIndex(0, tostring(taskData.schedule), tostring(taskData.aim))
        return 
      end
    end
  end
end

UIHome.OnTaskCommitComplete = function(self, taskStcData)
  -- function num : 0_27
  if self.__quickIsPeroid then
    return 
  end
  if self.__quickTaskData == nil or taskStcData == nil then
    return 
  end
  if (self.__quickTaskData).id == taskStcData.id then
    self:RefreshTaskBtn()
  end
end

UIHome.OnTaskPeroidCommit = function(self, peroidData)
  -- function num : 0_28
  if not self.__quickIsPeroid then
    return 
  end
  if self.__quickTaskData == peroidData then
    self:RefreshTaskBtn()
  end
end

UIHome.RefreshBatteryAndTime = function(self)
  -- function num : 0_29 , upvalues : CS_SystemInfo, CS_BatteryStatus, _ENV
  local batteryLevel = CS_SystemInfo.batteryLevel
  local batteryStatus = CS_SystemInfo.batteryStatus
  if batteryLevel == nil or batteryLevel < 0 then
    batteryLevel = 1
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_CurBattery).fillAmount = batteryLevel
  if batteryStatus == CS_BatteryStatus.Charging then
    ((self.ui).obj_recharge):SetActive(true)
  else
    ;
    ((self.ui).obj_recharge):SetActive(false)
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Clock).text = (GR.GetLocalSystemTimeStr)()
end

UIHome.RefreshBannerWidget = function(self)
  -- function num : 0_30 , upvalues : HomeBannerManager, UINHomeBanner
  ((self.ui).advTv):SetActive(false)
  HomeBannerManager:RefreshBannerDataList(function(bannerDataList)
    -- function num : 0_30_0 , upvalues : self, UINHomeBanner
    if bannerDataList ~= nil and #bannerDataList > 0 then
      if self.bannerUI == nil then
        self.bannerUI = (UINHomeBanner.New)()
        ;
        (self.bannerUI):Init((self.ui).advTv)
      end
      ;
      (self.bannerUI):Show()
      ;
      (self.bannerUI):InitialHomeBanner(bannerDataList)
    else
      ;
      ((self.ui).advTv):SetActive(false)
    end
  end
)
end

UIHome.OnUserNamelock = function(self, unlock)
  -- function num : 0_31
  (((self.ui).tex_UserName).gameObject):SetActive(unlock)
end

UIHome.OnHide = function(self)
  -- function num : 0_32 , upvalues : base
  if self.BatteryTimer ~= nil then
    (self.BatteryTimer):Stop()
    self.BatteryTimer = nil
  end
  ;
  (self.homeController):OnHideHomeUI()
  ;
  (base.OnHide)(self)
end

UIHome.OnDelete = function(self)
  -- function num : 0_33 , upvalues : _ENV, CS_LeanTouch, base
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommitComplete)
  MsgCenter:RemoveListener(eMsgEventId.PeroidCommitComplete, self.__onTaskPeroidCommit)
  ;
  (CS_LeanTouch.OnGesture)("-", self.__onGesture)
  MsgCenter:RemoveListener(eMsgEventId.ActivityShowChange, self.__RefreshActivityShow)
  if self.onHookVoiceTimer ~= nil then
    (self.onHookVoiceTimer):Stop()
    self.onHookVoiceTimer = nil
  end
  ;
  (self.rightList):Delete()
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (self.resourceGroup):Delete()
  ;
  (self.homeController):OnDeleteHomeUI()
  if self.__tlSectorCo ~= nil then
    (TimelineUtil.StopTlCo)(self.__tlSectorCo)
  end
  if self.sideWin ~= nil then
    (self.sideWin):Delete()
    self.sideWin = nil
  end
  if self.homeAdjutant ~= nil then
    (self.homeAdjutant):Delete()
    self.homeAdjutant = nil
  end
  if self.bannerUI ~= nil then
    (self.bannerUI):Delete()
    self.bannerUI = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIHome

