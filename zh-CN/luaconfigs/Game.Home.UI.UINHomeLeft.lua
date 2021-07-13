-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHomeLeft = class("UINHomeLeft", UIBaseNode)
local base = UIBaseNode
local UINHomeBanner = require("Game.Home.Banner.UINHomeBanner")
local HomeBannerManager = require("Game.Home.Banner.HomeBannerManager")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
UINHomeLeft.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, ActivityFrameEnum
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_HideUI, self, self.SetShowMainUI, false)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_ShowMain, self, self.SetShowMainUI, true)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SelectBoardHero, self, self.OnClickChangeAdjutantBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Task, self, self.OnClickTask)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_QuickTaskGet, self, self.OnQuickTaskGetBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HomeSide, self, self.OnClickHomeSide)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_Novice, self, self.OnClickActivity, (ActivityFrameEnum.eActivityEnterType).Novice)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_Limited, self, self.OnClickActivity, (ActivityFrameEnum.eActivityEnterType).LimitTime)
  self.__onTaskCommitComplete = BindCallback(self, self.OnTaskCommitComplete)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommitComplete)
  self.__onTaskPeroidCommit = BindCallback(self, self.OnTaskPeroidCommit)
  MsgCenter:AddListener(eMsgEventId.PeroidCommitComplete, self.__onTaskPeroidCommit)
  ;
  (((self.ui).tex_Voice).gameObject):SetActive(false)
  ;
  ((self.ui).ani_VoiceIcon):SetActive(false)
  self:RefreshBannerWidget()
end

UINHomeLeft.InitHomeLeftNode = function(self, homeUI)
  -- function num : 0_1
  self.homeUI = homeUI
  self.homeController = homeUI.homeController
  self:RegistTaskRedDot()
  self:RegistSideRedDot()
  self:RegistActivityRedDot()
end

UINHomeLeft.OnHomeShow = function(self)
  -- function num : 0_2
  self:RefreshTaskBtn()
  self:RefreshActivityShow()
end

UINHomeLeft.SetShowMainUI = function(self, bool)
  -- function num : 0_3
  (self.homeUI):SetHomeShowMainUI(bool)
  ;
  (((self.ui).btn_ShowMain).gameObject):SetActive(not bool)
end

UINHomeLeft.ShowHeroVoiceText = function(self, show, text)
  -- function num : 0_4
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

UINHomeLeft.RefreshActivityShow = function(self)
  -- function num : 0_5 , upvalues : _ENV, ActivityFrameEnum
  local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  ;
  (((self.ui).btn_Novice).gameObject):SetActive(activityCtrl:IsHaveShowByEnterType((ActivityFrameEnum.eActivityEnterType).Novice))
  ;
  (((self.ui).btn_Limited).gameObject):SetActive(activityCtrl:IsHaveShowByEnterType((ActivityFrameEnum.eActivityEnterType).LimitTime))
end

UINHomeLeft.OnClickActivity = function(self, enterType, activityId)
  -- function num : 0_6 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityFrameMain, function(window)
    -- function num : 0_6_0 , upvalues : self, _ENV, enterType, activityId
    if window ~= nil then
      (self.homeUI):OpenOtherWin()
      window:SetFromWhichUI(eBaseWinFromWhere.home)
      window:InitFrameMain(enterType, activityId)
    end
  end
)
end

UINHomeLeft.OnClickHomeSide = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.sideWin == nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.HomeSide, function(win)
    -- function num : 0_7_0 , upvalues : self
    if win ~= nil then
      self.sideWin = win
      ;
      (self.sideWin):InitSide(self.homeUI)
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

UINHomeLeft.OnClickTask = function(self, taskTypeID)
  -- function num : 0_8 , upvalues : _ENV
  local taskController = ControllerManager:GetController(ControllerTypeId.Task, false)
  if taskController == nil then
    error("get taskController error")
    return 
  end
  taskController:ShowTaskUI(taskTypeID, eBaseWinFromWhere.home, function(win)
    -- function num : 0_8_0 , upvalues : _ENV, self
    win:SetFromWhichUI(eBaseWinFromWhere.home)
    ;
    (self.homeUI):OpenOtherWin()
  end
)
end

UINHomeLeft.OnClickTaskQuickFinish = function(self)
  -- function num : 0_9
end

UINHomeLeft.OnClickChangeAdjutantBtn = function(self)
  -- function num : 0_10 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectBoardHero, function(win)
    -- function num : 0_10_0 , upvalues : self, _ENV
    if win ~= nil then
      (self.homeUI):OpenOtherWin()
      win:SetFromWhichUI(eBaseWinFromWhere.home)
      win:InitSelectBoardHero((self.homeController).homeCurrAdjutantHeroData)
      win.changeBoardHeroCallback = ((self.homeUI).homeAdjutant)._LoadBoardHero
    end
  end
)
end

UINHomeLeft.RefreshBannerWidget = function(self)
  -- function num : 0_11 , upvalues : HomeBannerManager, _ENV, UINHomeBanner
  ((self.ui).obj_advTv):SetActive(false)
  self:AdjutantBtn2Banner(false)
  HomeBannerManager:RefreshBannerDataList(function(bannerDataList)
    -- function num : 0_11_0 , upvalues : _ENV, self, UINHomeBanner
    if IsNull(self.gameObject) then
      return 
    end
    if bannerDataList ~= nil and #bannerDataList > 0 then
      if self.bannerUI == nil then
        self.bannerUI = (UINHomeBanner.New)()
        ;
        (self.bannerUI):Init((self.ui).obj_advTv)
      end
      ;
      (self.bannerUI):Show()
      ;
      (self.bannerUI):InitialHomeBanner(bannerDataList)
      self:AdjutantBtn2Banner(true)
    else
      ;
      ((self.ui).obj_advTv):SetActive(false)
      self:AdjutantBtn2Banner(false)
    end
  end
)
end

UINHomeLeft.AdjutantBtn2Banner = function(self, hasBanner)
  -- function num : 0_12 , upvalues : _ENV
  if self.hasBanner == hasBanner then
    return 
  end
  self.hasBanner = hasBanner
  local MoveX = Vector3.zero
  if hasBanner then
    MoveX = (Vector3.New)(514.475, 0, 0)
  else
    MoveX = (Vector3.New)(-514.475, 0, 0)
  end
  local hidePos = (((self.ui).btn_HideUI).transform).localPosition
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).btn_HideUI).transform).localPosition = MoveX + hidePos
  local boardHeroPos = (((self.ui).btn_SelectBoardHero).transform).localPosition
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).btn_SelectBoardHero).transform).localPosition = MoveX + boardHeroPos
end

UINHomeLeft.RegistTaskRedDot = function(self)
  -- function num : 0_13 , upvalues : _ENV
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_13_0 , upvalues : self
    ((self.ui).task_obj_RedDot):SetActive(num > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
end

UINHomeLeft.RegistSideRedDot = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_14_0 , upvalues : self, _ENV
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

UINHomeLeft.RegistActivityRedDot = function(self)
  -- function num : 0_15 , upvalues : _ENV
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_15_0 , upvalues : self
    ((self.ui).redDot_activity_novice):SetActive(num > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameNovice)
  ;
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_15_1 , upvalues : self
    ((self.ui).redDot_activity_limitTime):SetActive(num > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameLimitTime)
end

UINHomeLeft.OnQuickTaskGetBtn = function(self)
  -- function num : 0_16 , upvalues : _ENV
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

UINHomeLeft.RefreshTaskBtn = function(self)
  -- function num : 0_17 , upvalues : _ENV
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
    (((self.ui).btn_QuickTaskGet).gameObject):SetActive(false)
    return 
  end
  ;
  (((self.ui).btn_QuickTaskGet).gameObject):SetActive(isTaskCompelete)
  if self.__quickIsPeroid then
    local infoContent = (string.format)((LanguageUtil.GetLocaleText)(((ConfigData.game_config).taskPeroidInfo)[((self.__quickTaskData).stcData).type]), ((self.__quickTaskData).stcData).id)
    ;
    ((self.ui).tex_TaskInfo):SetIndex(0, infoContent)
  else
    do
      if taskData.schedule <= taskData.aim then
        local stepCfg = taskData:GetStepCfg()
        ;
        ((self.ui).tex_TaskInfo):SetIndex(0, (LanguageUtil.GetLocaleText)(stepCfg.intro))
        return 
      end
    end
  end
end

UINHomeLeft.OnTaskCommitComplete = function(self, taskStcData)
  -- function num : 0_18
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

UINHomeLeft.OnTaskPeroidCommit = function(self, peroidData)
  -- function num : 0_19
  if not self.__quickIsPeroid then
    return 
  end
  if self.__quickTaskData == peroidData then
    self:RefreshTaskBtn()
  end
end

UINHomeLeft.OnDelete = function(self)
  -- function num : 0_20 , upvalues : _ENV, base
  if self.sideWin ~= nil then
    (self.sideWin):Delete()
    self.sideWin = nil
  end
  if self.bannerUI ~= nil then
    (self.bannerUI):Delete()
    self.bannerUI = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommitComplete)
  MsgCenter:RemoveListener(eMsgEventId.PeroidCommitComplete, self.__onTaskPeroidCommit)
  ;
  (base.OnDelete)(self)
end

return UINHomeLeft

