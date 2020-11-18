-- params : ...
-- function num : 0 , upvalues : _ENV
local UIExploration = class("UIExploration", UIBaseWindow)
local base = UIBaseWindow
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIExploration.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Deploy, self, self.OnBtnDeployClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Retreat, self, self.OnBtnRetreatClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Store, self, self.OnBtnStoreClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Guide, self, self.OnBtnGuideClicked)
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
  local isUnlockBattleExit = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
  if not isUnlockBattleExit then
    (((self.ui).btn_Retreat).gameObject):SetActive(false)
  end
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
  self:Hide()
  ;
  (ExplorationManager.epCtrl):EnterDeployRoom()
end

UIExploration.OnBtnRetreatClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (ExplorationManager:GetReturnStamina())
  local returnStamina = nil
  local msg = nil
  if returnStamina == 0 then
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

UIExploration.Show = function(self, withTween)
  -- function num : 0_8 , upvalues : base, _ENV
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
  -- function num : 0_9 , upvalues : base, _ENV
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
  -- function num : 0_10
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
end

UIExploration.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerFightPowerChang, self.__onRefreshFightingPower)
  ;
  (base.OnDelete)(self)
end

return UIExploration

