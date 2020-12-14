-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattle = class("UIBattle", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local CS_PlayerPrefs = (CS.UnityEngine).PlayerPrefs
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_WaitForSecondsRealtime = (CS.UnityEngine).WaitForSecondsRealtime
local util = require("XLua.Common.xlua_util")
;
(xlua.private_accessible)(CS.BattleInitState)
UIBattle.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Pause, self, self.__OnClickPause)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SpeedUP, self, self.__OnClickSpeedUP)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_BattleStart, self, self.__OnClickBattleStart)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Back, self, self.__OnClickBreakDeploy)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Auto, self, self.__AutoBattleChanged)
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  self.isSpeedUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_PlaySpeed)
  self.isAutoBattleUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_AutoBattle)
  self.battleCtrl = ((CS.BattleManager).Instance).CurBattleController
  local isInExploration = ExplorationManager:IsInExploration()
  ;
  (((self.ui).obj_currLevel).gameObject):SetActive(isInExploration)
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R3 in 'UnsetPending'

  if isInExploration then
    ((self.ui).tex_Level).text = tostring(ExplorationManager:GetCurLevelIndex() + 1) .. "/" .. tostring(ExplorationManager:GetLevelCount())
  end
end

UIBattle.InitUIBattle = function(self, breakBattleFunc)
  -- function num : 0_1
  self.breakBattleFunc = breakBattleFunc
end

UIBattle.InitUIBattleDeploy = function(self, onlyDeploy, startBattleFunc, savaDeployFunc, getDeployAliveRoleCount)
  -- function num : 0_2
  self.startBattleFunc = startBattleFunc
  self.savaDeployFunc = savaDeployFunc
  self.getDeployAliveRoleCount = getDeployAliveRoleCount
  ;
  (((self.ui).btn_Back).gameObject):SetActive(onlyDeploy)
  self:__SwitchUIState(false)
  if onlyDeploy then
    (((self.ui).btn_BattleStart).gameObject):SetActive(false)
  end
end

UIBattle.InitUIBattleRunning = function(self, pauseFunc, speedUpFunc, autoBattleFunc)
  -- function num : 0_3 , upvalues : _ENV
  self.pauseFunc = pauseFunc
  self.speedUpFunc = speedUpFunc
  self.autoBattleFunc = autoBattleFunc
  local speed = (PlayerDataCenter.cacheSaveData).battleSpeed
  if self.isSpeedUnlock and speed >= 1 then
    self.curSpeed = speed
  else
    self.curSpeed = 1
  end
  self:RefreshSpeedUp()
  local autoBattle = (PlayerDataCenter.cacheSaveData).autoBattle
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

  if self.isAutoBattleUnlock and autoBattle then
    ((self.ui).tog_Auto).isOn = true
  else
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tog_Auto).isOn = false
  end
  self:__SwitchUIState(true)
end

UIBattle.ChangeStartBattleBtnText = function(self, index)
  -- function num : 0_4
  ((self.ui).tex_BattleStart):SetIndex(index)
end

UIBattle.__SwitchUIState = function(self, isBattleStart)
  -- function num : 0_5
  (((self.ui).btn_Pause).gameObject):SetActive(isBattleStart)
  if self.isSpeedUnlock and isBattleStart then
    (((self.ui).btn_SpeedUP).gameObject):SetActive(true)
  else
    ;
    (((self.ui).btn_SpeedUP).gameObject):SetActive(false)
  end
  if self.isAutoBattleUnlock and isBattleStart then
    (((self.ui).tog_Auto).gameObject):SetActive(true)
  else
    ;
    (((self.ui).tog_Auto).gameObject):SetActive(false)
  end
  ;
  (((self.ui).btn_BattleStart).gameObject):SetActive(not isBattleStart)
end

UIBattle.HidePauseButton = function(self)
  -- function num : 0_6
  (((self.ui).btn_Pause).gameObject):SetActive(false)
end

UIBattle.SetBattleStartActive = function(self, active)
  -- function num : 0_7
  (((self.ui).btn_BattleStart).gameObject):SetActive(active)
end

UIBattle.__OnClickPause = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.pauseFunc ~= nil then
    (self.pauseFunc)(true)
  end
  local win = UIManager:GetWindow(UIWindowTypeID.BattleCrazyMode)
  if win ~= nil then
    win:OnBattlePause()
  end
end

UIBattle.__OnClickSpeedUP = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.isSpeedUnlock then
    self.curSpeed = self.curSpeed + 1
    if (self.ui).speedMax < self.curSpeed then
      self.curSpeed = 1
    end
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (PlayerDataCenter.cacheSaveData).battleSpeed = self.curSpeed
    self:RefreshSpeedUp()
  end
end

UIBattle.RefreshSpeedUp = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if self.speedUpFunc ~= nil then
    (self.speedUpFunc)(self.curSpeed)
  end
  ;
  ((self.ui).img_Speed):SetIndex(self.curSpeed - 1)
  ;
  ((self.ui).tex_Speed):SetIndex(0, tostring(self.curSpeed))
end

UIBattle.__AutoBattleChanged = function(self, value)
  -- function num : 0_11 , upvalues : _ENV
  if self.autoBattleFunc ~= nil then
    (self.autoBattleFunc)(value)
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (PlayerDataCenter.cacheSaveData).autoBattle = value
  ;
  ((self.ui).img_Auto):SetIndex(value and 1 or 0)
end

UIBattle.__OnClickBattleStart = function(self)
  -- function num : 0_12 , upvalues : cs_MessageCommon, _ENV
  if self.getDeployAliveRoleCount ~= nil then
    local roleNum = (self.getDeployAliveRoleCount)()
    if roleNum <= 0 then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Battle_noBattleRole))
    else
      if self.startBattleFunc ~= nil and self.battleCtrl ~= nil then
        local initState = ((self.battleCtrl).fsm):GetStateFromID((CS.eBattleState).Init)
        if initState.m_isHerosShowed then
          (self.startBattleFunc)()
          AudioManager:PlayAudioById(1000)
        end
      end
    end
  end
end

UIBattle.__OnClickBreakDeploy = function(self)
  -- function num : 0_13
  if self.savaDeployFunc ~= nil then
    (self.savaDeployFunc)(true)
    self:__BreakBattle()
  end
end

UIBattle.__BreakBattle = function(self)
  -- function num : 0_14
  if self.breakBattleFunc ~= nil then
    (self.breakBattleFunc)()
  end
end

UIBattle.Show = function(self, withTween)
  -- function num : 0_15 , upvalues : base, _ENV
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

UIBattle.Hide = function(self, withTween)
  -- function num : 0_16 , upvalues : base, _ENV
  if not self.active then
    return 
  end
  ;
  (base.Hide)(self)
  local win = UIManager:GetWindow(UIWindowTypeID.BattleCrazyMode)
  if win ~= nil then
    win:Hide()
  end
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 1, 0, 0.5)
  end
end

UIBattle.__ClearFadeTween = function(self)
  -- function num : 0_17
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
end

UIBattle.OnDelete = function(self)
  -- function num : 0_18 , upvalues : _ENV, base
  UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
  self:__ClearFadeTween()
  ;
  (base.OnDelete)(self)
end

return UIBattle

