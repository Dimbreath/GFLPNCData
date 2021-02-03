-- params : ...
-- function num : 0 , upvalues : _ENV
local UIExploration = class("UIExploration", UIBaseWindow)
local base = UIBaseWindow
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIExploration.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
  end
  self.resloader = ((CS.ResLoader).Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Deploy, self, self.OnBtnDeployClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Retreat, self, self.OnBtnRetreatClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Store, self, self.OnBtnStoreClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Guide, self, self.OnBtnGuideClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AutoModule, self, self.OnTogAutoModuleChanged)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_StartAuto, self, self.OnBtnStartAutoClicked)
  local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
  if not isUnlockBattleExit then
    (((self.ui).btn_Retreat).gameObject):SetActive(false)
  end
  local isUnlockBattleDeploy = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleDeploy)
  if not isUnlockBattleDeploy then
    (((self.ui).btn_Deploy).gameObject):SetActive(false)
  end
  local isUnlockAutoExploration = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_AutoExploration)
  if not isUnlockAutoExploration then
    ((self.ui).autoModuleNode):SetActive(false)
  end
  local defaultAuto = ((ExplorationManager.epCtrl).autoCtrl):IsDefaultAutoEp()
  if defaultAuto then
    self:RefreshAutoModeState(true, true)
  end
  -- DECOMPILER ERROR at PC106: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.ui).color_DefaultAuto = ((self.ui).img_StartAuto).color
  self.__onRefreshFightingPower = BindCallback(self, self.__RefreshFightingPower)
  MsgCenter:AddListener(eMsgEventId.OnEpPlayerFightPowerChang, self.__onRefreshFightingPower)
end

UIExploration.ShowExplorationFirst = function(self, playerData)
  -- function num : 0_1
  (((self.ui).btn_Store).gameObject):SetActive(false)
  self:RefreshPlayerData(playerData)
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
  if (ExplorationManager.epCtrl):IsCompleteExploration() then
    (ExplorationManager.epCtrl):StartCompleteExploration()
    return 
  end
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
  ((CS.MessageCommon).ShowMessageBox)(msg, function()
    -- function num : 0_5_0 , upvalues : _ENV
    ExplorationManager:SendSettle(function()
      -- function num : 0_5_0_0 , upvalues : _ENV
      ExplorationManager:ExitExploration()
    end
)
  end
, nil)
end

UIExploration.OnBtnStoreClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (ExplorationManager.epCtrl):OpenResidentStore()
end

UIExploration.OnBtnGuideClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.GuidePicture, function(window)
    -- function num : 0_7_0
    if window == nil then
      return 
    end
    window:InitGuidePicture("Res/Images/Guide/Dungeon/", 5, nil)
  end
)
end

UIExploration.OnTogAutoModuleChanged = function(self)
  -- function num : 0_8 , upvalues : _ENV
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
  -- function num : 0_9
  ((self.ui).tex_AutoON):SetActive(value)
  ;
  ((self.ui).tex_AutoOFF):SetActive(not value)
  ;
  ((self.ui).img_AudoSelect):SetIndex(value and 1 or 0)
  ;
  ((self.ui).obj_AutoTile):SetActive(value)
  ;
  (((self.ui).btn_StartAuto).gameObject):SetActive(value)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

  if isRunning then
    ((self.ui).img_StartAuto).color = (self.ui).color_CloseAuto
    ;
    ((self.ui).tex_StartAuto):SetIndex(1)
  else
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_StartAuto).color = (self.ui).color_DefaultAuto
    ;
    ((self.ui).tex_StartAuto):SetIndex(0)
  end
end

UIExploration.OnBtnStartAutoClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local modelOpen, isRunning = ((ExplorationManager.epCtrl).autoCtrl):StartOrStopEpAutoMode()
  self:RefreshAutoModeState(modelOpen, isRunning)
end

UIExploration.Show = function(self, withTween)
  -- function num : 0_11 , upvalues : base, _ENV
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
  -- function num : 0_12 , upvalues : base, _ENV
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
  -- function num : 0_13
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
end

UIExploration.OnDelete = function(self)
  -- function num : 0_14 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerFightPowerChang, self.__onRefreshFightingPower)
  ;
  (self.resloader):Put2Pool()
  ;
  (base.OnDelete)(self)
end

return UIExploration

