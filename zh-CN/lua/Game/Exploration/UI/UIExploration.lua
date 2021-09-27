local UIExploration = class("UIExploration", UIBaseWindow)
local base = UIBaseWindow
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local UINMonsterLevel = require("Game.Exploration.UI.MonsterLevel.UINMonsterLevel")
local UINEpTaskItemDetail = require("Game.Exploration.UI.EpTask.UINEpTaskItemDetail")
local cs_MessageCommon = CS.MessageCommon
UIExploration.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINMonsterLevel
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
  end
  self.resloader = ((CS.ResLoader).Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Deploy, self, self.OnBtnDeployClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Retreat, self, self.OnBtnRetreatClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_EpStore, self, self.OnBtnStoreClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AutoModule, self, self.OnTogAutoModuleChanged)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_StartAuto, self, self.OnBtnStartAutoClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RewardBag, self, self._OnClickRewardBag)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ChipBag, self, self.OnClickChipPreview)
  self.monsterLevelNode = (UINMonsterLevel.New)()
  ;
  (self.monsterLevelNode):Init((self.ui).monsterLevel)
  ;
  (self.monsterLevelNode):Hide()
  local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
  if not isUnlockBattleExit then
    (((self.ui).btn_Retreat).gameObject):SetActive(false)
  end
  local isUnlockBattleDeploy = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleDeploy)
  if not isUnlockBattleDeploy then
    (((self.ui).btn_Deploy).gameObject):SetActive(false)
  end
  local isUnlockAutoExploration = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_AutoExploration)
  local showAutoEpBtn = isUnlockAutoExploration
  if showAutoEpBtn and (ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge or ExplorationManager:IsSectorNewbee()) then
    showAutoEpBtn = false
  end
  do
    if showAutoEpBtn and ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
      local stageCfg = ExplorationManager:GetSectorStageCfg()
      if stageCfg ~= nil and stageCfg.difficulty == 1 and showAutoEpBtn then
        showAutoEpBtn = (PlayerDataCenter.sectorStage):IsStageComplete(stageCfg.id)
      end
    end
    self.__showAutoEpBtn = showAutoEpBtn
    ;
    ((self.ui).autoModuleNode):SetActive(showAutoEpBtn)
    local defaultAuto = ((ExplorationManager.epCtrl).autoCtrl):IsDefaultAutoEp()
    if defaultAuto then
      self:RefreshAutoModeState(true, true)
    end
    if ((ExplorationManager.epCtrl).overclockCtrl):IsLevelHasOverclock() then
      (((self.ui).btn_Overclock).gameObject):SetActive(true)
      ;
      (UIUtil.AddButtonListener)((self.ui).btn_Overclock, self, self.OnBtnOverclockClicked)
    end
    self.hasEpRewardBag = ExplorationManager:HasEpRewardBag()
    ;
    (((self.ui).btn_RewardBag).gameObject):SetActive(self.hasEpRewardBag)
    -- DECOMPILER ERROR at PC194: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.ui).color_DefaultAuto = ((self.ui).img_StartAuto).color
    self.__onRefreshFightingPower = BindCallback(self, self.__RefreshFightingPower)
    MsgCenter:AddListener(eMsgEventId.OnEpPlayerFightPowerChang, self.__onRefreshFightingPower)
    ;
    (((self.ui).btn_EpStore).gameObject):SetActive(((ExplorationManager.epCtrl).residentStoreCtrl):HasEpResidentStore())
    ;
    ((self.ui).obj_epTaskItem):SetActive(false)
    ;
    ((self.ui).obj_epTaskDetail):SetActive(false)
    ;
    (UIUtil.AddButtonListener)((self.ui).btn_CloseEpTaskDetail, self, self.OnCloseEpTaskDetailClick)
    ;
    (((self.ui).btn_CloseEpTaskDetail).gameObject):SetActive(false)
    self.__OnEpTaskGetListener = BindCallback(self, self.OnEpTaskGetListener)
    MsgCenter:AddListener(eMsgEventId.OnEpOpStore, self.__OnEpTaskGetListener)
    self.__OnEpTaskUpdateListener = BindCallback(self, self.OnEpTaskUpdateListener)
    MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__OnEpTaskUpdateListener)
  end
end

UIExploration.ShowExplorationFirst = function(self, dynPlayer)
  -- function num : 0_1
  self:RefreshPlayerData(dynPlayer)
  ;
  (self.monsterLevelNode):InitMonsterLevelUI(dynPlayer)
  self:OnEpTaskGetListener()
end

UIExploration.RefreshPlayerData = function(self, playerData)
  -- function num : 0_2 , upvalues : _ENV
  if not playerData then
    self.dnyPlayer = ExplorationManager:GetDynPlayer()
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
    self:__RefreshFightingPower()
    ;
    ((self.ui).tex_Level):SetIndex(0, tostring(ExplorationManager:GetCurLevelIndex() + 1), tostring(ExplorationManager:GetLevelCount()))
  end
end

UIExploration.__RefreshFightingPower = function(self, fightPower)
  -- function num : 0_3 , upvalues : _ENV
  local power = nil
  power = fightPower == nil and (self.dnyPlayer):GetCacheFightPower() or fightPower
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Power).text = tostring(power)
end

UIExploration.OnBtnDeployClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local opDetail = (ExplorationManager:GetDynPlayer()):GetOperatorDetail()
  if opDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    return 
  end
  if ((ExplorationManager.epCtrl).autoCtrl):IsAutoModeRunning() then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(283))
    return 
  end
  self:Hide()
  ;
  (ExplorationManager.epCtrl):EnterDeployRoom()
end

UIExploration.OnBtnRetreatClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((ExplorationManager.epCtrl).autoCtrl):DisableEpAutoMode()
  UIManager:ShowWindowAsync(UIWindowTypeID.BattlePause, function(win)
    -- function num : 0_5_0 , upvalues : self, _ENV
    if win == nil then
      return 
    end
    win:InitBattlePause(function()
      -- function num : 0_5_0_0 , upvalues : self, _ENV
      self:_RetreatDungeon()
      AudioManager:PlayAudioById(1082)
    end
)
    win:SetAboutBattleUIActive(false)
  end
)
end

UIExploration._RetreatDungeon = function(self)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon
  if (ExplorationManager.epCtrl):IsCompleteExploration() then
    (ExplorationManager.epCtrl):StartCompleteExploration()
    return 
  end
  if self.hasEpRewardBag then
    (((ExplorationManager:GetDynPlayer()).dynRewardBag):HasEpRewardBagData())
    local hasReward = nil
    local msg = nil
    if hasReward then
      msg = ConfigData:GetTipContent(753)
    else
      msg = ConfigData:GetTipContent(752)
    end
    ;
    (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_6_0 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.BattlePause)
    ;
    (ExplorationManager.epCtrl):ExplorationFailSettle()
  end
, nil)
  else
    do
      if ExplorationManager:GetIsInWeeklyChallenge() then
        local msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
        ;
        (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_6_1 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.BattlePause)
    ;
    (ExplorationManager.epCtrl):ExplorationFailSettle()
  end
, nil)
      else
        do
          ;
          (ExplorationManager:GetReturnStamina())
          local returnStamina = nil
          local msg = nil
          if returnStamina <= 0 then
            msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
          else
            msg = (string.format)(ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpoWithStaminaBack), returnStamina)
          end
          ;
          (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_6_2 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.BattlePause)
    ;
    (ExplorationManager.resultCtrl):EnterResultProcess(false, true)
  end
, nil)
        end
      end
    end
  end
end

UIExploration.OnBtnStoreClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (ExplorationManager.epCtrl):OpenResidentStore()
end

UIExploration.IsShowAutoEpBtn = function(self)
  -- function num : 0_8
  return self.__showAutoEpBtn
end

UIExploration.OnTogAutoModuleChanged = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local enable = ((ExplorationManager.epCtrl).autoCtrl):IsEnableAutoMode()
  local value = not enable
  if enable then
    ((ExplorationManager.epCtrl).autoCtrl):DisableEpAutoMode()
  else
    ;
    ((ExplorationManager.epCtrl).autoCtrl):EnableEpAutoMode()
  end
end

UIExploration.RefreshAutoModeState = function(self, value, isRunning)
  -- function num : 0_10
  ((self.ui).tex_AutoON):SetActive(value)
  ;
  ((self.ui).tex_AutoOFF):SetActive(not value)
  ;
  ((self.ui).img_AudoSelect):SetIndex(value and 1 or 0)
  ;
  (((self.ui).btn_StartAuto).gameObject):SetActive(value)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

  if isRunning then
    ((self.ui).img_StartAuto).color = (self.ui).color_CloseAuto
    ;
    ((self.ui).tex_StartAuto):SetIndex(1)
  else
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_StartAuto).color = (self.ui).color_DefaultAuto
    ;
    ((self.ui).tex_StartAuto):SetIndex(0)
  end
end

UIExploration.OnBtnStartAutoClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local modelOpen, isRunning = ((ExplorationManager.epCtrl).autoCtrl):StartOrStopEpAutoMode()
  self:RefreshAutoModeState(modelOpen, isRunning)
end

UIExploration._OnClickRewardBag = function(self)
  -- function num : 0_12 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.EpRewardPreview, function(window)
    -- function num : 0_12_0 , upvalues : _ENV
    if window == nil then
      return 
    end
    local rewardList = ((ExplorationManager:GetDynPlayer()).dynRewardBag):GetEpRewardBagDataList()
    local stageCfg = ExplorationManager:GetSectorStageCfg()
    window:InitEpRewardPreview(stageCfg, rewardList)
  end
)
end

UIExploration.OnClickChipPreview = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local chipDataList = ExplorationManager:GetChipDataPreview()
  if chipDataList ~= nil and #chipDataList > 0 then
    UIManager:ShowWindowAsync(UIWindowTypeID.CurrentChip, function(window)
    -- function num : 0_13_0 , upvalues : chipDataList, _ENV
    window:InitCurrentChip(chipDataList)
    window:SetCurrentChipCloseFunc(function()
      -- function num : 0_13_0_0 , upvalues : _ENV
      local topStatusWindow = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if topStatusWindow ~= nil then
        (topStatusWindow.topGroup):ShowTopBtnGroupGoHomeBtn(false)
        ;
        (topStatusWindow.topGroup):RefreshouldShowNaviBtn(false)
      end
    end
)
  end
)
  end
end

UIExploration.OnBtnOverclockClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  ((ExplorationManager.epCtrl).overclockCtrl):ShowEpOverclockUI()
end

UIExploration.StartFlyRewardBag = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if not ExplorationManager:IsInExplorationAndScene() then
    return 
  end
  local posItem = ((ExplorationManager.epCtrl).mapCtrl):GetPlayerPosItem()
  if posItem == nil then
    return 
  end
  local pos = (posItem.transform).position
  pos = UIManager:World2UIPosition(pos)
  local dpos = (self.transform):InverseTransformPoint((((self.ui).fx_RewardBag).transform).position)
  local startPos = (Vector3.New)(pos.x, pos.y)
  local destPos = (Vector3.New)(dpos.x, dpos.y)
  local width = destPos.x - startPos.x
  local height = startPos.y - destPos.y
  local numPos = #(ConfigData.buildinConfig).RewardBagFlyOffset + 2
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).fx_lineBg).positionCount = numPos
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).fx_line).positionCount = numPos
  ;
  ((self.ui).fx_lineBg):SetPosition(0, startPos)
  ;
  ((self.ui).fx_line):SetPosition(0, startPos)
  for index,v in pairs((ConfigData.buildinConfig).RewardBagFlyOffset) do
    local x = startPos.x + v[1] * width
    local y = destPos.y + v[2] * height
    local newPos = (Vector3.New)(x, y, 0)
    ;
    ((self.ui).fx_lineBg):SetPosition(index, newPos)
    ;
    ((self.ui).fx_line):SetPosition(index, newPos)
  end
  ;
  ((self.ui).fx_lineBg):SetPosition(numPos - 1, destPos)
  ;
  ((self.ui).fx_line):SetPosition(numPos - 1, destPos)
  ;
  (((self.ui).fx_RewardFly).gameObject):SetActive(true)
  ;
  ((self.ui).fx_RewardBag):SetActive(false)
  local matBg = ((self.ui).fx_lineBg):GetMaterial()
  local mat = ((self.ui).fx_line):GetMaterial()
  matBg:SetFloat("_BFAlpha", 0)
  mat:SetFloat("_BFAlpha", 0)
  mat:SetFloat("_BFPanner01", 0)
  if self.__rewardFlyTween == nil then
    local CS_DOTween = ((CS.DG).Tweening).DOTween
    local sequence = (CS_DOTween.Sequence)()
    sequence:SetAutoKill(false)
    sequence:Append(matBg:DOFloat(1, "_BFAlpha", (ConfigData.buildinConfig).RewardBagFlyAppear))
    sequence:Join(mat:DOFloat(1, "_BFAlpha", (ConfigData.buildinConfig).RewardBagFlyAppear))
    sequence:AppendCallback(function()
    -- function num : 0_15_0 , upvalues : self
    ((self.ui).fx_RewardBag):SetActive(true)
  end
)
    sequence:Append(mat:DOFloat(1, "_BFPanner01", (ConfigData.buildinConfig).RewardBagFlyTime))
    sequence:Join((matBg:DOFloat(0, "_BFAlpha", (ConfigData.buildinConfig).RewardBagFlyDisappear)):SetDelay((ConfigData.buildinConfig).RewardBagFlyTime * (ConfigData.buildinConfig).RewardBagDisappearRatio))
    sequence:AppendCallback(function()
    -- function num : 0_15_1 , upvalues : self
    (((self.ui).fx_RewardFly).gameObject):SetActive(false)
  end
)
    self.__rewardFlyTween = sequence
  else
    do
      ;
      (self.__rewardFlyTween):Restart()
    end
  end
end

UIExploration.Show = function(self, withTween)
  -- function num : 0_16 , upvalues : base, _ENV
  if self.active then
    return 
  end
  ;
  (base.Show)(self)
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 0, 1, 0.5)
  end
end

UIExploration.Hide = function(self, withTween)
  -- function num : 0_17 , upvalues : base, _ENV
  if not self.active then
    return 
  end
  ;
  (base.Hide)(self)
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 1, 0, 0.5)
  end
end

UIExploration.__ClearFadeTween = function(self)
  -- function num : 0_18
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
end

UIExploration.OnEpTaskGetListener = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local taskId = ((ExplorationManager.epCtrl).dynPlayer):GetQuestId()
  do
    local isComplete = ((self.epTaskItem).taskData ~= nil and ((self.epTaskItem).taskData):CheckComplete())
    ;
    (self.epTaskItem):ClearTask(isComplete)
    if self.epTaskDetail ~= nil and (self.epTaskDetail).active then
      self:OnCloseEpTaskDetailClick()
    end
    do return  end
    if self.epTaskItem == nil then
      self.epTaskItem = self:_InitEpTaskItem()
    end
    ;
    (self.epTaskItem):Show()
    do
      if taskId ~= (self.epTaskItem):GetTaskId() then
        local taskData = ((PlayerDataCenter.allTaskData).taskDatas)[taskId]
        if taskData == nil then
          (self.epTaskItem):ClearTask()
          error("epTask error ：data is NIL")
          return 
        end
        ;
        (self.epTaskItem):RefreshItemUI(taskData)
      end
      -- DECOMPILER ERROR: 8 unprocessed JMP targets
    end
  end
end

UIExploration.OnEpTaskUpdateListener = function(self, taskData)
  -- function num : 0_20 , upvalues : _ENV
  if self.epTaskItem ~= nil and (self.epTaskItem).taskData == taskData then
    if self.epTaskDetail ~= nil and (self.epTaskDetail).active then
      (self.epTaskDetail):Hide()
    end
    UIManager:ShowWindowOnly(UIWindowTypeID.EpChipSuit)
    ;
    (self.epTaskItem):RefreshProcessUI()
    if taskData:CheckComplete() then
      (self.epTaskItem):ShowComplete()
    end
  end
end

UIExploration._InitEpTaskItem = function(self)
  -- function num : 0_21 , upvalues : _ENV
  self._onEpTaskClick = BindCallback(self, self._OnEpTaskClick)
  local UINEpTaskItem = require("Game.Exploration.UI.EpTask.UINEpTaskItem")
  local epTaskItem = (UINEpTaskItem.New)()
  epTaskItem:Init((self.ui).obj_epTaskItem)
  epTaskItem:SetTaskClickCallback(self._onEpTaskClick)
  return epTaskItem
end

UIExploration._OnEpTaskClick = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if (self.epTaskItem).taskData ~= nil and ((self.epTaskItem).taskData):CheckComplete() then
    local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
    taskCtrl:SendCommitQuestReward((self.epTaskItem).taskData)
    local rewardId = ((((self.epTaskItem).taskData).stcData).rewardIds)[1]
    local rewardCount = ((((self.epTaskItem).taskData).stcData).rewardNums)[1]
    do
      do
        if rewardId ~= nil then
          local itemCfg = (ConfigData.item)[rewardId]
          if itemCfg ~= nil then
            ((CS.MessageCommon).ShowMessageTips)((string.format)(ConfigData:GetTipContent(119), (LanguageUtil.GetLocaleText)(itemCfg.name), tostring(rewardCount)))
          end
        end
        do return  end
        if self.epTaskDetail == nil then
          self._onEpTaskDteailClick = BindCallback(self, self._OnEpTaskDteailClick)
          self.epTaskDetail = self:_InitEpTaskDetail()
          ;
          (((self.ui).btn_CloseEpTaskDetail).gameObject):SetActive(true)
        end
        ;
        (self.epTaskDetail):Show()
        ;
        (((self.ui).btn_CloseEpTaskDetail).gameObject):SetActive(true)
        UIManager:HideWindow(UIWindowTypeID.EpChipSuit)
        ;
        (self.epTaskItem):Hide()
        local taskData = (self.epTaskItem).taskData
        ;
        (self.epTaskDetail):InitTaskItem(taskData, self._onEpTaskDteailClick, 1)
      end
    end
  end
end

UIExploration._InitEpTaskDetail = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local UINEpTaskDetail = require("Game.Exploration.UI.EpTask.UINEpTaskItemDetail")
  local epTaskDetail = (UINEpTaskDetail.New)()
  epTaskDetail:Init((self.ui).obj_epTaskDetail)
  return epTaskDetail
end

UIExploration._OnEpTaskDteailClick = function(self, taskID)
  -- function num : 0_24 , upvalues : _ENV
  local taskData = (self.epTaskItem).taskData
  local isComplete = (taskData ~= nil and taskData:CheckComplete())
  local epNet = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  epNet:CS_EXPLORATION_QuestDrop()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIExploration.OnCloseEpTaskDetailClick = function(self)
  -- function num : 0_25 , upvalues : _ENV
  if self.epTaskItem == nil or self.epTaskDetail == nil then
    return 
  end
  if (self.epTaskItem):GetTaskId() > 0 then
    (self.epTaskItem):Show()
  end
  UIManager:ShowWindowOnly(UIWindowTypeID.EpChipSuit)
  ;
  (self.epTaskDetail):Hide()
  ;
  (((self.ui).btn_CloseEpTaskDetail).gameObject):SetActive(false)
end

UIExploration.OnDelete = function(self)
  -- function num : 0_26 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerFightPowerChang, self.__onRefreshFightingPower)
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStore, self.__OnEpTaskGetListener)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__OnEpTaskUpdateListener)
  if self.__rewardFlyTween ~= nil then
    (self.__rewardFlyTween):Kill()
    self.__rewardFlyTween = nil
  end
  ;
  (self.monsterLevelNode):Delete()
  if self.epTaskItem ~= nil then
    (self.epTaskItem):Delete()
  end
  if self.epTaskDetail ~= nil then
    (self.epTaskDetail):Delete()
  end
  ;
  (self.resloader):Put2Pool()
  ;
  (base.OnDelete)(self)
end

return UIExploration

