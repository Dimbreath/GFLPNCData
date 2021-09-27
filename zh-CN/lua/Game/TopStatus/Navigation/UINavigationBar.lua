local UINavigationBar = class("UINavigationBar", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local NavigationEnum = require("Game.TopStatus.Navigation.NavigationEnum")
local UINNavSpecialUIBase = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpecialUIBase")
local UINNavigationBranchItem = require("Game.TopStatus.Navigation.UINNavigationBranchItem")
local JumpManager = require("Game.Jump.JumpManager")
local TaskEnum = require("Game.Task.TaskEnum")
UINavigationBar.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV
  self.resloader = (cs_ResLoader.Create)()
  self:__TryFindLeanTouchGo()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GoHome, self, self.OnClickReturnCommandRoom)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_backgroubd, self, self.CloseNavigationBar)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GetTaskReward, self, self.OnCliclNaviCollectTaskReward)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_JumpToTask, self, self.OnClickNaviJump2Task)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Mail, self, self.OnClickMail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Setting, self, self.OnCklickSetting)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Achievement, self, self.OnCklickAchievement)
  self.__UpdateNaviTaskQucikPreview = BindCallback(self, self.UpdateNaviTaskQucikPreview)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__UpdateNaviTaskQucikPreview)
  ;
  (((self.ui).dotween_frame).onRewind):AddListener(BindCallback(self, self.OnNavigationCloseTweenOver))
  self.branchItemDic = {}
  self:GenAllBranches()
  ;
  (((self.ui).navBranchItem).gameObject):SetActive(false)
  self.redDotFuncDic = {}
  self:InitAchievemenRedDots()
  self:InitMailRedDots()
end

UINavigationBar.__TryFindLeanTouchGo = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if IsNull(self.leanTouchGo) then
    self.leanTouchGo = ((((CS.Lean).Touch).LeanTouch).Instance).gameObject
    if IsNull(self.leanTouchGo) then
      self.leanTouchGo = nil
    end
  end
end

UINavigationBar.OnShow = function(self)
  -- function num : 0_2 , upvalues : _ENV, UINNavSpecialUIBase
  AudioManager:PlayAudioById(1105)
  ;
  ((self.ui).dotween_frame):DORestart()
  self:__TryFindLeanTouchGo()
  if self.leanTouchGo ~= nil then
    (self.leanTouchGo):SetActive(false)
  end
  self:UpdateNaviTaskQucikPreview()
  ;
  (UINNavSpecialUIBase.ResumeSpecialUIBaseTimer)()
  self:RefreshCurOpeningUI()
  self:RefreshMailBtnIsUnlock()
  self:RefreshAchievementBtnIsUnlock()
  ;
  ((UIManager:GetWindow(UIWindowTypeID.TopStatus)).topGroup):RefreshHomeRedDotFx()
end

UINavigationBar.OnClickReturnCommandRoom = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self:CloseNavigationBar(function()
    -- function num : 0_3_0 , upvalues : _ENV
    (UIUtil.ReturnHome)()
  end
)
end

UINavigationBar.UpdateNaviTaskQucikPreview = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi)
  ;
  ((self.ui).obj_Task):SetActive(isUnlock)
  if not isUnlock then
    return 
  end
  local taskData, isTaskCompelete, isPeroid = (PlayerDataCenter.allTaskData):GetTaskData4Home()
  self.__quickTaskData = taskData
  self.__quickIsPeroid = isPeroid
  if taskData == nil then
    ((self.ui).tex_TaskInfo):SetIndex(1)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_Progress).text = ""
    ;
    ((self.ui).obj_CanGet):SetActive(false)
    return 
  end
  ;
  (((self.ui).obj_CanGet).gameObject):SetActive(isTaskCompelete)
  if self.__quickIsPeroid then
    local infoContent = (string.format)((LanguageUtil.GetLocaleText)(((ConfigData.game_config).taskPeroidInfo)[((self.__quickTaskData).stcData).type]), ((self.__quickTaskData).stcData).id)
    ;
    ((self.ui).tex_TaskInfo):SetIndex(0, infoContent)
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Progress).text = ""
  else
    do
      if taskData.schedule <= taskData.aim then
        local stepCfg = taskData:GetStepCfg()
        ;
        ((self.ui).tex_TaskInfo):SetIndex(0, (LanguageUtil.GetLocaleText)(stepCfg.intro))
        -- DECOMPILER ERROR at PC95: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self.ui).tex_Progress).text = tostring(taskData.schedule) .. "/" .. tostring(taskData.aim)
        return 
      end
    end
  end
end

UINavigationBar.OnCliclNaviCollectTaskReward = function(self)
  -- function num : 0_5 , upvalues : _ENV, TaskEnum
  if self.__quickTaskData == nil then
    return 
  end
  local taskController = ControllerManager:GetController(ControllerTypeId.Task)
  if taskController ~= nil then
    local taskIds = {(TaskEnum.eTaskType).MainTask, (TaskEnum.eTaskType).DailyTask, (TaskEnum.eTaskType).WeeklyTask}
    local ids = taskController:GetAllRewards(taskIds)
    if (table.count)(ids) >= 1 then
      taskController:SendOneKeyPick(ids, function()
    -- function num : 0_5_0 , upvalues : self
    self:UpdateNaviTaskQucikPreview()
  end
)
      return 
    end
  end
end

UINavigationBar.OnClickNaviJump2Task = function(self)
  -- function num : 0_6 , upvalues : JumpManager, _ENV
  JumpManager:Jump((JumpManager.eJumpTarget).DynTask, function(jumpCallback)
    -- function num : 0_6_0 , upvalues : _ENV
    if (UIUtil.CheckIsHaveSpecialMarker)(UIWindowTypeID.Task) then
      (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.Task)
      local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if win ~= nil then
        win:HideNavigation()
      end
      return 
    end
    do
      if jumpCallback ~= nil then
        local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
        if win ~= nil then
          win:HideNavigation()
        end
        jumpCallback()
      end
    end
  end
, nil, nil, true)
end

UINavigationBar.GenAllBranches = function(self)
  -- function num : 0_7 , upvalues : _ENV, UINNavigationBranchItem
  local isFirst = true
  for id,navigation_mainCfg in ipairs(ConfigData.navigation_main) do
    if (self.branchItemDic)[id] == nil then
      local item = (UINNavigationBranchItem.New)()
      local go = ((self.ui).navBranchItem):Instantiate()
      item:Init(go)
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.branchItemDic)[id] = item
    end
    do
      ;
      ((self.branchItemDic)[id]):InitNavigationBranchItem(navigation_mainCfg, self.resloader)
      for _,branchBtnItem in pairs(((self.branchItemDic)[id]).branchBtnItemDic) do
        self:InstallSpecialUI4Button(branchBtnItem)
      end
      do
        -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  ;
  (((CS.UnityEngine).Canvas).ForceUpdateCanvases)()
  local rectSize = ((self.ui).tran_Rect).sizeDelta
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tran_SubRect).sizeDelta = rectSize
  for k,v in pairs(self.branchItemDic) do
    v:SetIconParent((self.ui).tran_SubRect)
  end
end

UINavigationBar.RefreshAllBranchItem = function(self)
  -- function num : 0_8 , upvalues : _ENV
  for _,branchItem in pairs(self.branchItemDic) do
    branchItem:RefreshAllNBB()
  end
end

local SpecialUI4ButtonFuns = {[(NavigationEnum.eSpecialUILogic).OasisRewardCollect] = function(self, branchBtnItem)
  -- function num : 0_9 , upvalues : _ENV
  local UINNavSpeciaOasisCollectReward = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpeciaOasisCollectReward")
  ;
  (UINNavSpeciaOasisCollectReward.GetSpecialUI)(branchBtnItem, (self.ui).obj_special_resCollect, self.resloader)
end
, [(NavigationEnum.eSpecialUILogic).LotteryMarker] = function(self, branchBtnItem)
  -- function num : 0_10 , upvalues : _ENV
  local UINNavSpeciaLotteryMarker = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpeciaLotteryMarker")
  ;
  (UINNavSpeciaLotteryMarker.GetSpecialUI)(branchBtnItem, (self.ui).obj_special_tips, self.resloader)
end
}
UINavigationBar.InstallSpecialUI4Button = function(self, branchBtnItem)
  -- function num : 0_11 , upvalues : _ENV, SpecialUI4ButtonFuns
  for index,specialId in ipairs(branchBtnItem:GetAllSpecialIds()) do
    local SpecialUI4ButtonFun = SpecialUI4ButtonFuns[specialId]
    if SpecialUI4ButtonFun ~= nil then
      SpecialUI4ButtonFun(self, branchBtnItem)
    end
  end
end

UINavigationBar.RefreshCurOpeningUI = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local topBranchItem = nil
  local topIndex = -1
  for _,branchItem in pairs(self.branchItemDic) do
    for _,branchBtnItems in pairs(branchItem.branchBtnItemDic) do
      branchBtnItems:RefreshIsInThisUI(false)
      local flag, index = (UIUtil.CheckIsHaveSpecialMarker)((branchBtnItems.navigation_subCfg).marker)
      if flag and topIndex < index then
        topIndex = index
        topBranchItem = branchBtnItems
      end
    end
  end
  if topBranchItem ~= nil then
    topBranchItem:RefreshIsInThisUI(true)
  end
end

UINavigationBar.InitAchievemenRedDots = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel)
  local redDotFunc = function(node)
    -- function num : 0_13_0 , upvalues : self
    ((self.ui).redDot_achievement):SetActive(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  redDotFunc(node)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.redDotFuncDic)[redDotFunc] = node
  RedDotController:AddListener(node.nodePath, redDotFunc)
end

UINavigationBar.RefreshAchievementBtnIsUnlock = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  ;
  (((self.ui).btn_Achievement).gameObject):SetActive(isUnlock)
end

UINavigationBar.OnCklickAchievement = function(self)
  -- function num : 0_15 , upvalues : JumpManager, _ENV
  JumpManager:Jump((JumpManager.eJumpTarget).Achieve4System, function(jumpCallback)
    -- function num : 0_15_0 , upvalues : _ENV
    if (UIUtil.CheckIsHaveSpecialMarker)(UIWindowTypeID.AchievementSystem) then
      (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.AchievementSystem)
      local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if win ~= nil then
        win:HideNavigation()
      end
      return 
    end
    do
      if jumpCallback ~= nil then
        local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
        if win ~= nil then
          win:HideNavigation()
        end
        jumpCallback()
      end
    end
  end
, nil, nil, true)
end

UINavigationBar.InitMailRedDots = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Mail)
  local redDotFunc = function(node)
    -- function num : 0_16_0 , upvalues : self
    ((self.ui).redDot_mail):SetActive(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  redDotFunc(node)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.redDotFuncDic)[redDotFunc] = node
  RedDotController:AddListener(node.nodePath, redDotFunc)
end

UINavigationBar.RefreshMailBtnIsUnlock = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  ;
  (((self.ui).btn_Mail).gameObject):SetActive(isUnlock)
end

UINavigationBar.OnClickMail = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local oringLayoutLevel = (UIWindowGlobalConfig[UIWindowTypeID.Mail]).LayoutLevel
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (UIWindowGlobalConfig[UIWindowTypeID.Mail]).LayoutLevel = self.__layerID
  UIManager:ShowWindowAsync(UIWindowTypeID.Mail, function(win)
    -- function num : 0_18_0 , upvalues : self, _ENV, oringLayoutLevel
    if win ~= nil then
      self:CloseNavigationBar()
      -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((win.ui).background).enabled = false
      win:SetFromWhichUI(nil)
      win:SetUIMailHideCallback(function()
      -- function num : 0_18_0_0 , upvalues : _ENV
      (UIUtil.ReShowTopStatus)()
    end
)
      ;
      (UIUtil.HideTopStatus)()
    end
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (UIWindowGlobalConfig[UIWindowTypeID.Mail]).LayoutLevel = oringLayoutLevel
  end
)
end

UINavigationBar.OnCklickSetting = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local oringLayoutLevel = (UIWindowGlobalConfig[UIWindowTypeID.Setting]).LayoutLevel
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (UIWindowGlobalConfig[UIWindowTypeID.Setting]).LayoutLevel = self.__layerID
  UIManager:ShowWindowAsync(UIWindowTypeID.Setting, function(win)
    -- function num : 0_19_0 , upvalues : self, _ENV, oringLayoutLevel
    if win ~= nil then
      self:CloseNavigationBar()
      -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((win.ui).background).enabled = false
      win:SetFromWhichUI(nil)
      win:SetUIMailHideCallback(function()
      -- function num : 0_19_0_0 , upvalues : _ENV
      (UIUtil.ReShowTopStatus)()
    end
)
      win:InitSettingByFrom()
      ;
      (UIUtil.HideTopStatus)()
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (UIWindowGlobalConfig[UIWindowTypeID.Setting]).LayoutLevel = oringLayoutLevel
    end
  end
)
end

UINavigationBar.CloseNavigationBar = function(self, callback)
  -- function num : 0_20 , upvalues : _ENV
  AudioManager:PlayAudioById(1106)
  ;
  ((self.ui).dotween_frame):DOPlayBackwards()
  self.isColsingWin = true
  self.closeCallback = callback
end

UINavigationBar.OnNavigationCloseTweenOver = function(self)
  -- function num : 0_21
  self:Hide()
  if self.closeCallback ~= nil then
    (self.closeCallback)()
    self.closeCallback = nil
  end
end

UINavigationBar.OnHide = function(self)
  -- function num : 0_22 , upvalues : UINNavSpecialUIBase, _ENV
  self:__TryFindLeanTouchGo()
  if self.leanTouchGo ~= nil then
    (self.leanTouchGo):SetActive(true)
  end
  ;
  (UINNavSpecialUIBase.PauseSpecialUIBaseTimer)()
  local topStatusWin = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if topStatusWin ~= nil then
    (topStatusWin.topGroup):RefreshHomeRedDotFx()
  end
end

UINavigationBar.OnDelete = function(self)
  -- function num : 0_23 , upvalues : _ENV, UINNavSpecialUIBase, base
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__UpdateNaviTaskQucikPreview)
  UINNavSpecialUIBase:CleanSpecialUIBaseTimer()
  for _,branchIte in pairs(self.branchItemDic) do
    branchIte:Delete()
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  for redDotFunc,node in pairs(self.redDotFuncDic) do
    RedDotController:RemoveListener(node.nodePath, redDotFunc)
  end
  self.redDotFuncDic = {}
  ;
  (base.OnDelete)(self)
end

return UINavigationBar

