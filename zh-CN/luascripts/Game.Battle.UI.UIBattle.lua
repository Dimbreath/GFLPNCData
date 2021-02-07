-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattle = class("UIBattle", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local CS_PlayerPrefs = (CS.UnityEngine).PlayerPrefs
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_WaitForSecondsRealtime = (CS.UnityEngine).WaitForSecondsRealtime
local util = require("XLua.Common.xlua_util")
UIBattle.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV
  self.resLoader = (cs_ResLoader.Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Pause, self, self.__OnClickPause)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SpeedUP, self, self.__OnClickSpeedUP)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_BattleStart, self, self.__OnClickBattleStart)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Back, self, self.__OnClickBreakDeploy)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Auto, self, self.__OnAutoBattleClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CampBondSkill, self, self.__OnClickCampFetter)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Retreat, self, self.__OnClickRetreat)
  self.isSpeedUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_PlaySpeed)
  self.isAutoBattleUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_AutoBattle)
  local isInExploration = ExplorationManager:IsInExploration()
  ;
  (((self.ui).obj_currLevel).gameObject):SetActive(isInExploration)
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R2 in 'UnsetPending'

  if isInExploration then
    ((self.ui).tex_Level).text = tostring(ExplorationManager:GetCurLevelIndex() + 1) .. "/" .. tostring(ExplorationManager:GetLevelCount())
  end
end

UIBattle.InitUIBattle = function(self, breakBattleFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.breakBattleFunc = breakBattleFunc
  local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
  if not isUnlockBattleExit then
    (((self.ui).btn_Retreat).gameObject):SetActive(false)
  end
end

UIBattle.InitUIBattleDeploy = function(self, onlyDeploy, startBattleFunc, savaDeployFunc, getDeployAliveRoleCount)
  -- function num : 0_2 , upvalues : _ENV
  self.startBattleFunc = startBattleFunc
  self.savaDeployFunc = savaDeployFunc
  self.getDeployAliveRoleCount = getDeployAliveRoleCount
  ;
  (((self.ui).btn_Back).gameObject):SetActive(onlyDeploy)
  self:__SwitchUIState(false)
  if onlyDeploy then
    (((self.ui).btn_BattleStart).gameObject):SetActive(false)
  end
  ;
  (((self.ui).btn_SpeedUP).gameObject):SetActive(self.isSpeedUnlock)
  local speed = (PlayerDataCenter.cacheSaveData).battleSpeed
  if self.isSpeedUnlock and speed >= 1 then
    self.curSpeed = speed
  else
    self.curSpeed = 1
  end
  ;
  ((self.ui).img_Speed):SetIndex(self.curSpeed - 1)
  ;
  ((self.ui).tex_Speed):SetIndex(0, tostring(self.curSpeed))
  ;
  (((self.ui).tog_Auto).gameObject):SetActive(self.isAutoBattleUnlock)
  local autoBattle = (PlayerDataCenter.cacheSaveData).autoBattle
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R7 in 'UnsetPending'

  if self.isAutoBattleUnlock and autoBattle then
    ((self.ui).tog_Auto).isOn = true
  else
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tog_Auto).isOn = false
  end
end

UIBattle.InitUIBattleRunning = function(self, pauseFunc, speedUpFunc, autoBattleFunc)
  -- function num : 0_3
  self.pauseFunc = pauseFunc
  self.speedUpFunc = speedUpFunc
  self.autoBattleFunc = autoBattleFunc
  self:OnSpeedUpChange(self.curSpeed)
  self:OnAutoBattleChange(((self.ui).tog_Auto).isOn)
  self:__SwitchUIState(true)
end

UIBattle.ChangeStartBattleBtnText = function(self, index)
  -- function num : 0_4
  ((self.ui).tex_BattleStart):SetIndex(index)
end

UIBattle.__SwitchUIState = function(self, isBattleStart)
  -- function num : 0_5
  (((self.ui).btn_Pause).gameObject):SetActive(isBattleStart)
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
    ;
    ((self.ui).img_Speed):SetIndex(self.curSpeed - 1)
    ;
    ((self.ui).tex_Speed):SetIndex(0, tostring(self.curSpeed))
    self:OnSpeedUpChange(self.curSpeed)
  end
end

UIBattle.OnSpeedUpChange = function(self, curSpeed)
  -- function num : 0_10
  if self.speedUpFunc ~= nil then
    (self.speedUpFunc)(curSpeed)
  end
end

UIBattle.__OnAutoBattleClick = function(self, value)
  -- function num : 0_11 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (PlayerDataCenter.cacheSaveData).autoBattle = value
  ;
  ((self.ui).img_Auto):SetIndex(value and 1 or 0)
  self:OnAutoBattleChange(value)
end

UIBattle.OnAutoBattleChange = function(self, value)
  -- function num : 0_12
  if self.autoBattleFunc ~= nil then
    (self.autoBattleFunc)(value)
  end
end

UIBattle.SetHasBattleActiveCampFetter = function(self, hasEpActive)
  -- function num : 0_13
  (((self.ui).btn_CampBondSkill).gameObject):SetActive(hasEpActive)
end

UIBattle.SetCampFetter = function(self, campId, heroNum, couldUse, cdStr)
  -- function num : 0_14 , upvalues : _ENV
  if couldUse then
    ((self.ui).img_btn_CampBondSkill):SetIndex(0)
    local campFetterCfg = ((ConfigData.camp_connection)[campId])[heroNum]
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_CampFetterIcon).sprite = (AtlasUtil.GetSpriteFromAtlas)(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, self.resLoader)
    ;
    ((self.ui).tex_campFetterName):SetIndex(0, (LanguageUtil.GetLocaleText)(campFetterCfg.name))
    ;
    ((self.ui).tex_subText):SetIndex(0, (LanguageUtil.GetLocaleText)(((ConfigData.camp)[campId]).name))
  else
    do
      ;
      ((self.ui).img_btn_CampBondSkill):SetIndex(1)
      local campFetterCfg = ((ConfigData.camp_connection)[campId])[heroNum]
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).img_CampFetterIcon).sprite = (AtlasUtil.GetSpriteFromAtlas)(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, self.resLoader)
      ;
      ((self.ui).tex_campFetterName):SetIndex(1)
      ;
      ((self.ui).tex_subText):SetIndex(1, cdStr)
    end
  end
end

UIBattle.SetClickCampFetter = function(self, useCampFetterCallback)
  -- function num : 0_15
  self.useCampFetterCallback = useCampFetterCallback
end

UIBattle.__OnClickCampFetter = function(self)
  -- function num : 0_16
  if self.useCampFetterCallback ~= nil then
    (self.useCampFetterCallback)()
  end
end

UIBattle.__OnClickBattleStart = function(self)
  -- function num : 0_17 , upvalues : cs_MessageCommon, _ENV
  if self.getDeployAliveRoleCount ~= nil then
    local roleNum = (self.getDeployAliveRoleCount)()
    if roleNum <= 0 then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Battle_noBattleRole))
    else
      self:RealStartBattle()
    end
  end
end

UIBattle.RealStartBattle = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self.startBattleFunc ~= nil then
    (self.startBattleFunc)()
    ;
    ((self.ui).obj_btn_CampBondSkill):SetActive(false)
    ;
    (((self.ui).btn_Retreat).gameObject):SetActive(false)
    AudioManager:PlayAudioById(1000)
  end
end

UIBattle.__OnClickBreakDeploy = function(self)
  -- function num : 0_19
  if self.savaDeployFunc ~= nil then
    (self.savaDeployFunc)(true)
    self:__BreakBattle()
  end
end

UIBattle.__BreakBattle = function(self)
  -- function num : 0_20
  if self.breakBattleFunc ~= nil then
    (self.breakBattleFunc)()
  end
end

UIBattle.__OnClickRetreat = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local battleController = ((CS.BattleManager).Instance).CurBattleController
  if battleController ~= nil then
    (battleController.LuaBattleCtrl):ReqGiveUpBattle(battleController)
  end
end

UIBattle.Show = function(self, withTween)
  -- function num : 0_22 , upvalues : base, _ENV
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
  -- function num : 0_23 , upvalues : base, _ENV
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
  -- function num : 0_24
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
end

UIBattle.OnDelete = function(self)
  -- function num : 0_25 , upvalues : _ENV, base
  UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
  self:__ClearFadeTween()
  ;
  (base.OnDelete)(self)
end

return UIBattle

