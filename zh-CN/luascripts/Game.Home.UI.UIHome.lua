-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHome = class("UIHome", UIBaseWindow)
local base = UIBaseWindow
local CS_OasisCameraController = CS.OasisCameraController
local CS_SystemInfo = (CS.UnityEngine).SystemInfo
local CS_BatteryStatus = (CS.UnityEngine).BatteryStatus
local cs_ResLoader = CS.ResLoader
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local UICarouselBanner = require("Game.CommonUI.Container.UI.UICarouselBanner")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINHomeAdjutant = require("Game.Home.UI.UINHomeAdjutant")
local UINHomeResourceItem = require("Game.Home.UI.UINHomeResourceItem")
local UINHomeRightList = require("Game.Home.UI.UINHomeRightList")
local UINHomeNoticeItem = require("Game.Home.UI.UINHomeNoticeItem")
local HomeEnum = require("Game.Home.HomeEnum")
local ActivityEnum = require("Game.Activity.ActivityEnum")
UIHome.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader, UINResourceGroup, UINHomeResourceItem, CS_OasisCameraController, UINHomeAdjutant, UINHomeNoticeItem, UINHomeRightList, CS_LeanTouch, ActivityEnum
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
  self.noticeItemPool = (UIItemPool.New)(UINHomeNoticeItem, (self.ui).noticePlaceHolder)
  ;
  ((self.ui).noticePlaceHolder):SetActive(false)
  self.rightList = (UINHomeRightList.New)()
  ;
  (self.rightList):Init((self.ui).obj_right)
  ;
  (self.rightList):InitHomeRightList(self)
  self.sideWin = nil
  if isEditorMode and ((CS.GMController).Instance).battleShortcut then
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
  (UIUtil.AddButtonListener)((self.ui).btn_ActivityStarUp, self, self.OnClickActivityStarUp)
  self:RegistTaskRedDot()
  self:RegistSideRedDot()
  self.__onTaskCommitComplete = BindCallback(self, self.OnTaskCommitComplete)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommitComplete)
  GuideManager:TryTriggerGuide(eGuideCondition.FInHome)
  self.onHookVoiceTimer = (TimerManager:GetTimer((ConfigData.buildinConfig).HomeOnHookVoiceTime, function()
    -- function num : 0_0_0 , upvalues : self
    (self.homeController):PlayVoHomeOnHook()
  end
, nil, false)):Start()
  self.__onGesture = BindCallback(self, self.OnGesture)
  ;
  (CS_LeanTouch.OnGesture)("+", self.__onGesture)
  self.__OnActivityStageChange = BindCallback(self, self.OnActivityStageChange)
  MsgCenter:AddListener(eMsgEventId.ActivityState, self.__OnActivityStageChange)
  local activityCtr = ControllerManager:GetController(ControllerTypeId.Activity, true)
  if activityCtr:GetActivityState((ActivityEnum.eActivityFixedId).StarUp) == (ActivityEnum.eActivityState).Open then
    self:RegisterActivityStarUpRedDot()
  end
  ;
  (((self.ui).tex_Voice).gameObject):SetActive(false)
  ;
  ((self.ui).ani_VoiceIcon):SetActive(false)
end

UIHome.OnShow = function(self)
  -- function num : 0_1 , upvalues : base
  (self.homeController):OnShowHomeUI()
  self:RefreshName()
  self:RefreshUserLevel()
  self:RefreshTaskBtn()
  self:RefreshBannerWidget()
  self:RefreshActivityBtn()
  ;
  (base.OnShow)(self)
end

UIHome.m_SetMainCameraEnabled = function(self, enabled)
  -- function num : 0_2 , upvalues : CS_OasisCameraController
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((CS_OasisCameraController.Instance).MainCamera).enabled = enabled
end

UIHome.SetFrom2Home = function(self, from, playReturnHomeCv)
  -- function num : 0_3 , upvalues : _ENV
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
    -- function num : 0_3_0 , upvalues : _ENV, self
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
  -- function num : 0_4 , upvalues : _ENV
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
  -- function num : 0_5
  (self.onHookVoiceTimer):Reset()
end

UIHome.PauseHomeOnHookTimer = function(self, pause)
  -- function num : 0_6
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

UIHome.OpenOtherWin = function(self)
  -- function num : 0_7
  self:m_SetMainCameraEnabled(false)
  self:Hide()
end

UIHome.OpenOtherCoverWin = function(self)
  -- function num : 0_8
  (self.homeController):OnCoverHomeUI()
end

UIHome.BackFromOtherWin = function(self)
  -- function num : 0_9
  self:m_SetMainCameraEnabled(true)
  self:Show()
end

UIHome.BackFromOtherCoverWin = function(self)
  -- function num : 0_10
  (self.homeController):OnShowHomeUI()
end

UIHome.SetShowMainUI = function(self, bool)
  -- function num : 0_11
  ((self.ui).obj_main):SetActive(bool)
  ;
  ((self.ui).obj_rightBackground):SetActive(bool)
  ;
  (((self.ui).btn_ShowMain).gameObject):SetActive(not bool)
end

UIHome.ShowHeroVoiceText = function(self, show, text)
  -- function num : 0_12
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
  -- function num : 0_13 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectBoardHero, function(win)
    -- function num : 0_13_0 , upvalues : self
    if win ~= nil then
      win:InitSelectBoardHero((self.homeController).homeCurrAdjutantHeroData, true)
      win.changeBoardHeroCallback = (self.homeAdjutant)._LoadBoardHero
      self:OpenOtherWin()
    end
  end
)
end

UIHome.OnClickPlayerInfoBtn = function(self)
  -- function num : 0_14 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfo, function(win)
    -- function num : 0_14_0 , upvalues : self
    if win ~= nil then
      win:InitUserInfo()
      self:OpenOtherWin()
    end
  end
)
end

UIHome.OnClickTaskBtn = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local taskController = ControllerManager:GetController(ControllerTypeId.Task, false)
  if taskController == nil then
    error("get taskController error")
    return 
  end
  taskController:ShowTaskUI(nil, function()
    -- function num : 0_15_0 , upvalues : self
    self:OpenOtherWin()
  end
)
end

UIHome.OnQuickTaskGetBtn = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if self.__quickTaskData == nil then
    return 
  end
  local isTaskCompelete = (self.__quickTaskData):CheckComplete()
  if not isTaskCompelete then
    return 
  end
  ;
  (ControllerManager:GetController(ControllerTypeId.Task, true)):SendCommitQuestReward(self.__quickTaskData)
end

UIHome.OnClickSideBtn = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self.sideWin == nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.HomeSide, function(win)
    -- function num : 0_17_0 , upvalues : self
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
  -- function num : 0_18 , upvalues : _ENV
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_18_0 , upvalues : self, _ENV
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
  -- function num : 0_19 , upvalues : _ENV
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_19_0 , upvalues : self
    ((self.ui).task_obj_RedDot):SetActive(num > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
end

UIHome.RegisterActivityStarUpRedDot = function(self)
  -- function num : 0_20 , upvalues : _ENV, ActivityEnum
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_20_0 , upvalues : self
    ((self.ui).redDot_ActivityStarUp):SetActive(num > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, RedDotStaticTypeId.Main, RedDotStaticTypeId.Activity, (ActivityEnum.eActivityFixedId).StarUp)
end

UIHome.OnClickActivityStarUp = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local activityCtr = ControllerManager:GetController(ControllerTypeId.Activity, true)
  activityCtr:OpenStarUpPanel()
end

UIHome.OnActivityStageChange = function(self, id, state)
  -- function num : 0_22 , upvalues : ActivityEnum
  if id == (ActivityEnum.eActivityFixedId).StarUp then
    self:RefreshActivityBtn()
    self:RegisterActivityStarUpRedDot()
  end
end

UIHome.RefreshActivityBtn = function(self)
  -- function num : 0_23 , upvalues : _ENV, ActivityEnum
  local activityCtr = ControllerManager:GetController(ControllerTypeId.Activity, true)
  if activityCtr:GetActivityState((ActivityEnum.eActivityFixedId).StarUp) == (ActivityEnum.eActivityState).Open then
    local isFinish = (activityCtr:GetInfo((ActivityEnum.eActivityFixedId).StarUp)):IsFinish()
    ;
    (((self.ui).btn_ActivityStarUp).gameObject):SetActive(not isFinish)
  else
    do
      ;
      (((self.ui).btn_ActivityStarUp).gameObject):SetActive(false)
    end
  end
end

UIHome.RefreshName = function(self)
  -- function num : 0_24 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_UserName).text = PlayerDataCenter.playerName
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
  local taskData, isTaskCompelete = (PlayerDataCenter.allTaskData):GetTaskData4Home()
  self.__quickTaskData = taskData
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
  for stepIndex,stepData in ipairs(taskData.steps) do
    if stepData.schedule <= stepData.aim then
      local stepCfg = (taskData.taskStepCfg)[stepIndex]
      ;
      ((self.ui).tex_TaskInfo):SetIndex(0, (LanguageUtil.GetLocaleText)(stepCfg.intro))
      ;
      ((self.ui).tex_Progress):SetIndex(0, tostring(stepData.schedule), tostring(stepData.aim))
      return 
    end
  end
end

UIHome.OnTaskCommitComplete = function(self, taskStcData)
  -- function num : 0_27
  if self.__quickTaskData == nil or taskStcData == nil then
    return 
  end
  if (self.__quickTaskData).id == taskStcData.id then
    self:RefreshTaskBtn()
  end
end

UIHome.RefreshBatteryAndTime = function(self)
  -- function num : 0_28 , upvalues : CS_SystemInfo, _ENV, CS_BatteryStatus
  local batteryLevel = CS_SystemInfo.batteryLevel
  local batteryStatus = CS_SystemInfo.batteryStatus
  local time = (((CS.System).DateTime).Now):ToShortTimeString()
  if batteryLevel == nil or batteryLevel < 0 then
    batteryLevel = 1
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_CurBattery).fillAmount = batteryLevel
  if batteryStatus == CS_BatteryStatus.Charging then
    ((self.ui).obj_recharge):SetActive(true)
  else
    ;
    ((self.ui).obj_recharge):SetActive(false)
  end
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Clock).text = time
end

UIHome.RefreshBannerWidget = function(self)
  -- function num : 0_29 , upvalues : UICarouselBanner
  local bannerDatas = (self.homeController):GetBannerDatas()
  if #bannerDatas > 0 then
    if self.lowerBannerUI == nil then
      self.lowerBannerUI = (UICarouselBanner.New)()
      ;
      (self.lowerBannerUI):Init()
    end
    ;
    (self.lowerBannerUI):InjectSelectObj((self.ui).selectCountTrans, (self.ui).selectTrans, (self.ui).bannerSelectWidth)
    ;
    (self.lowerBannerUI):InitialWithData(bannerDatas, (self.ui).advList, (self.ui).advItem, self.resloader, (self.ui).bannerSelectWidth)
    ;
    ((self.ui).advTv):SetActive(true)
  else
    ;
    ((self.ui).advTv):SetActive(false)
  end
end

UIHome.OnUserNamelock = function(self, unlock)
  -- function num : 0_30
  (((self.ui).tex_UserName).gameObject):SetActive(unlock)
end

UIHome.AddNewNotice = function(self, noticeData)
  -- function num : 0_31 , upvalues : _ENV
  local item = (self.noticeItemPool):GetOne()
  ;
  (item.transform):SetAsFirstSibling()
  item:InitNoticeItem(noticeData, BindCallback(self, self.OnNoticeTweenPlayOver, item), self.resloader)
end

UIHome.OnNoticeTweenPlayOver = function(self, item)
  -- function num : 0_32
  (self.noticeItemPool):HideOne(item)
end

UIHome.OnHide = function(self)
  -- function num : 0_33 , upvalues : base
  (self.homeController):OnHideHomeUI()
  ;
  (base.OnHide)(self)
end

UIHome.OnDelete = function(self)
  -- function num : 0_34 , upvalues : _ENV, CS_LeanTouch, base
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommitComplete)
  ;
  (CS_LeanTouch.OnGesture)("-", self.__onGesture)
  MsgCenter:RemoveListener(eMsgEventId.ActivityState, self.__OnActivityStageChange)
  if self.onHookVoiceTimer ~= nil then
    (self.onHookVoiceTimer):Stop()
    self.onHookVoiceTimer = nil
  end
  ;
  (self.noticeItemPool):DeleteAll()
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
  ;
  (base.OnDelete)(self)
end

return UIHome

