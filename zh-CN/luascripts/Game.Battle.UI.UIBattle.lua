-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattle = class("UIBattle", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local CS_PlayerPrefs = (CS.UnityEngine).PlayerPrefs
UIBattle.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Pause, self, self.__OnClickPause)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SpeedUP, self, self.__OnClickSpeedUP)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_BattleStart, self, self.__OnClickBattleStart)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Back, self, self.__OnClickBreakDeploy)
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  self.isSpeedUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_PlaySpeed)
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

UIBattle.InitUIBattleRunning = function(self, pauseFunc, speedUpFunc)
  -- function num : 0_3 , upvalues : CS_PlayerPrefs
  self.pauseFunc = pauseFunc
  self.speedUpFunc = speedUpFunc
  local speed = (CS_PlayerPrefs.GetInt)("battleSpeed")
  if self.isSpeedUnlock and speed ~= nil and speed >= 1 then
    self.curSpeed = speed
  else
    self.curSpeed = 1
  end
  self:RefreshSpeedUp()
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
  -- function num : 0_8
  if self.pauseFunc ~= nil then
    (self.pauseFunc)(true)
  end
end

UIBattle.__OnClickSpeedUP = function(self)
  -- function num : 0_9 , upvalues : CS_PlayerPrefs
  if self.isSpeedUnlock then
    self.curSpeed = self.curSpeed + 1
    if (self.ui).speedMax < self.curSpeed then
      self.curSpeed = 1
    end
    ;
    (CS_PlayerPrefs.SetInt)("battleSpeed", self.curSpeed)
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

UIBattle.__OnClickBattleStart = function(self)
  -- function num : 0_11 , upvalues : cs_MessageCommon, _ENV
  if self.getDeployAliveRoleCount ~= nil then
    local roleNum = (self.getDeployAliveRoleCount)()
    if roleNum <= 0 then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Battle_noBattleRole))
    else
      if self.startBattleFunc ~= nil then
        (self.startBattleFunc)()
        AudioManager:PlayAudioById(1000)
      end
    end
  end
end

UIBattle.__OnClickBreakDeploy = function(self)
  -- function num : 0_12
  if self.savaDeployFunc ~= nil then
    (self.savaDeployFunc)(true)
    self:__BreakBattle()
  end
end

UIBattle.__BreakBattle = function(self)
  -- function num : 0_13
  if self.breakBattleFunc ~= nil then
    (self.breakBattleFunc)()
  end
end

UIBattle.Show = function(self, withTween)
  -- function num : 0_14 , upvalues : base, _ENV
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
  -- function num : 0_15 , upvalues : base, _ENV
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

UIBattle.__ClearFadeTween = function(self)
  -- function num : 0_16
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
end

UIBattle.OnDelete = function(self)
  -- function num : 0_17 , upvalues : base
  self:__ClearFadeTween()
  ;
  (base.OnDelete)(self)
end

return UIBattle

