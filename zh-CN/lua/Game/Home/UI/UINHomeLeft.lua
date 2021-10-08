local UINHomeLeft = class("UINHomeLeft", UIBaseNode)
local base = UIBaseNode
local UINHomeBanner = require("Game.Home.Banner.UINHomeBanner")
local HomeBannerManager = require("Game.Home.Banner.HomeBannerManager")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local UINHomeGeneralBtn = require("Game.Home.UI.UINHomeGeneralBtn")
local TaskEnum = require("Game.Task.TaskEnum")
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
  (UIUtil.AddButtonListener)((self.ui).btn_Chat, self, self.OnClickHomeChat)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Friend, self, self.OnClickFriend)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_Novice, self, self.OnClickActivity, (ActivityFrameEnum.eActivityEnterType).Novice)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_Limited, self, self.OnClickActivity, (ActivityFrameEnum.eActivityEnterType).LimitTime)
  self.__onTaskCommitComplete = BindCallback(self, self.OnTaskCommitComplete)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommitComplete)
  self.__onTaskPeroidCommit = BindCallback(self, self.OnTaskPeroidCommit)
  MsgCenter:AddListener(eMsgEventId.PeroidCommitComplete, self.__onTaskPeroidCommit)
  self.__RefreshWorldChatNewMessage = BindCallback(self, self.RefreshWorldChatNewMessage)
  MsgCenter:AddListener(eMsgEventId.OnNewWordChatDataCome, self.__RefreshWorldChatNewMessage)
  self.__RefreshActivityShow = BindCallback(self, self.RefreshActivityShow)
  MsgCenter:AddListener(eMsgEventId.ActivityShowChange, self.__RefreshActivityShow)
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
  self:RefreshWorldChatShow()
  self:RefreshFriendBtn()
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

UINHomeLeft.OnClickChangeAdjutantBtn = function(self)
  -- function num : 0_9 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectBoardHero, function(win)
    -- function num : 0_9_0 , upvalues : self, _ENV
    if win ~= nil then
      (self.homeUI):OpenOtherWin()
      win:SetFromWhichUI(eBaseWinFromWhere.home)
      win:InitSelectBoardHero((self.homeController).homeCurrAdjutantHeroData)
      win.changeBoardHeroCallback = ((self.homeUI).homeAdjutant)._LoadBoardHero
    end
  end
)
end

UINHomeLeft.RefreshWorldChatShow = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local isUnlock, unlockDes = (self.homeController):IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Chat)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).btn_Chat).interactable = isUnlock
  if isUnlock then
    self:RefreshWorldChatNewMessage()
    ;
    ((self.ui).img_chat):SetIndex(1)
  else
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Message).color = (self.ui).color_chatgray
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Message).fontStyle = 0
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Message).text = unlockDes
    ;
    ((self.ui).img_chat):SetIndex(0)
  end
end

UINHomeLeft.RefreshWorldChatNewMessage = function(self, removeNum, isChatRefresh)
  -- function num : 0_11 , upvalues : _ENV
  if not ((self.ui).btn_Chat).interactable then
    return 
  end
  local chatWin = UIManager:GetWindow(UIWindowTypeID.ChatSystem)
  if not isChatRefresh and chatWin ~= nil then
    return 
  end
  if (PlayerDataCenter.homeChatDataCenter):GetNewChatNum() > 0 then
    local chatData = (PlayerDataCenter.homeChatDataCenter):GetLatestChatData()
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

    if chatData == nil then
      ((self.ui).tex_Message).color = (self.ui).color_chatgray
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_Message).fontStyle = 2
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_Message).text = ConfigData:GetTipContent(TipContent.ChatNoNewMessage)
    else
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_Message).color = Color.white
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_Message).fontStyle = 0
      local str = chatData:GetContent4Home()
      local index = ((self.ui).tex_Message):GetFirstLineMaxLengthStrIndex(str)
      if index ~= -1 and index < (string.len)(str) then
        str = (string.sub)(str, 1, index) .. "…"
      end
      -- DECOMPILER ERROR at PC78: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).tex_Message).text = str
    end
  else
    do
      -- DECOMPILER ERROR at PC84: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Message).color = (self.ui).color_chatgray
      -- DECOMPILER ERROR at PC87: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Message).fontStyle = 2
      -- DECOMPILER ERROR at PC95: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Message).text = ConfigData:GetTipContent(TipContent.ChatNoNewMessage)
    end
  end
end

UINHomeLeft.OnClickHomeChat = function(self)
  -- function num : 0_12 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.ChatSystem, function(win)
    -- function num : 0_12_0 , upvalues : self
    if win ~= nil then
      win:InitChatSystem()
      self:RefreshWorldChatNewMessage(0, true)
    end
  end
)
end

UINHomeLeft.RefreshFriendBtn = function(self)
  -- function num : 0_13 , upvalues : UINHomeGeneralBtn, _ENV
  if self.friendBtn == nil then
    self.friendBtn = (UINHomeGeneralBtn.New)()
    ;
    (self.friendBtn):Init(((self.ui).btn_Friend).gameObject)
    ;
    (self.homeController):AddRedDotEvent((self.friendBtn):GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.UserFriend)
  end
  local isUnlock, unlockDes = (self.homeController):IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Friend)
  ;
  (self.friendBtn):RefeshUnlockInfo(isUnlock, unlockDes)
end

UINHomeLeft.OnClickFriend = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if not (self.friendBtn).isUnlock then
    (self.friendBtn):ShowUnlockDes()
    return 
  end
  if not (PlayerDataCenter.friendDataCenter):IsFriendDataCenterInited() then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UserFreined, function(win)
    -- function num : 0_14_0 , upvalues : self, _ENV
    if win ~= nil then
      (self.homeUI):OpenOtherWin()
      win:SetFromWhichUI(eBaseWinFromWhere.home)
      win:InitUserFriend()
    end
  end
)
end

UINHomeLeft.RefreshBannerWidget = function(self)
  -- function num : 0_15 , upvalues : HomeBannerManager, _ENV, UINHomeBanner
  ((self.ui).obj_advTv):SetActive(false)
  self:AdjutantBtn2Banner(false)
  HomeBannerManager:RefreshBannerDataList(function(bannerDataList)
    -- function num : 0_15_0 , upvalues : _ENV, self, UINHomeBanner
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
  -- function num : 0_16 , upvalues : _ENV
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
  -- function num : 0_17 , upvalues : _ENV
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_17_0 , upvalues : self
    ((self.ui).task_obj_RedDot):SetActive(num > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
end

UINHomeLeft.RegistSideRedDot = function(self)
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

UINHomeLeft.RegistActivityRedDot = function(self)
  -- function num : 0_19 , upvalues : _ENV
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_19_0 , upvalues : self
    ((self.ui).redDot_activity_novice):SetActive(num > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameNovice)
  ;
  (self.homeController):AddRedDotEvent(function(num)
    -- function num : 0_19_1 , upvalues : self
    ((self.ui).redDot_activity_limitTime):SetActive(num > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameLimitTime)
end

UINHomeLeft.OnQuickTaskGetBtn = function(self)
  -- function num : 0_20 , upvalues : _ENV, TaskEnum
  if self.__quickTaskData == nil then
    return 
  end
  local taskController = ControllerManager:GetController(ControllerTypeId.Task)
  if taskController ~= nil then
    local taskIds = {(TaskEnum.eTaskType).MainTask, (TaskEnum.eTaskType).DailyTask, (TaskEnum.eTaskType).WeeklyTask}
    local ids = taskController:GetAllRewards(taskIds)
    if (table.count)(ids) >= 1 then
      taskController:SendOneKeyPick(ids)
      return 
    end
  end
  do
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
end

UINHomeLeft.RefreshTaskBtn = function(self)
  -- function num : 0_21 , upvalues : _ENV
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
    local infoContent = ""
    local strbase = (LanguageUtil.GetLocaleText)(((ConfigData.game_config).taskPeroidInfo)[((self.__quickTaskData).stcData).type])
    if not (string.IsNullOrEmpty)(strbase) then
      infoContent = (string.format)(strbase, ((self.__quickTaskData).stcData).id)
    else
      warn("task type is not a period,type:" .. tostring(((self.__quickTaskData).stcData).type) .. " local_text_id:" .. tostring(((ConfigData.game_config).taskPeroidInfo)[((self.__quickTaskData).stcData).type]))
    end
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
  -- function num : 0_22
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
  -- function num : 0_23
  if not self.__quickIsPeroid then
    return 
  end
  if self.__quickTaskData == peroidData then
    self:RefreshTaskBtn()
  end
end

UINHomeLeft.OnDelete = function(self)
  -- function num : 0_24 , upvalues : _ENV, base
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
  MsgCenter:RemoveListener(eMsgEventId.OnNewWordChatDataCome, self.__RefreshWorldChatNewMessage)
  MsgCenter:RemoveListener(eMsgEventId.ActivityShowChange, self.__RefreshActivityShow)
  ;
  (base.OnDelete)(self)
end

return UINHomeLeft

