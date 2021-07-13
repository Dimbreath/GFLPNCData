-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattlePause = class("UIBattlePause", UIBaseWindow)
local base = UIBaseWindow
UIBattlePause.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_GiveUp, self, self.__OnClickGiveUp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reload, self, self.__OnClickRestart)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GoOn, self, self.__OnClickContinue)
  local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
  if not isUnlockBattleExit then
    (((self.ui).btn_GiveUp).gameObject):SetActive(false)
  end
end

UIBattlePause.InitBattlePause = function(self, giveUpBattleFunc, restartFunc, pauseFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.giveUpBattleFunc = giveUpBattleFunc
  self.restartFunc = restartFunc
  self.pauseFunc = pauseFunc
  local isInExploration = ExplorationManager:IsInExploration()
  self.__hasRestartLimit = not isInExploration or ExplorationManager:GetEpModuleId() ~= proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  ;
  ((self.ui).obj_levelInfo):SetActive(isInExploration)
  local sectorStageCfg = ExplorationManager:GetSectorStageCfg()
  if sectorStageCfg ~= nil then
    if sectorStageCfg.endlessCfg ~= nil then
      ((self.ui).tex_LevelCount):SetIndex(1, tostring((sectorStageCfg.endlessCfg).index * 10))
    elseif sectorStageCfg.challengeCfg ~= nil then
      ((self.ui).tex_LevelCount):SetIndex(2)
    else
      ((self.ui).tex_LevelCount):SetIndex(0, tostring(sectorStageCfg.sector) .. "-" .. tostring(sectorStageCfg.num))
    end
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_LevelName).text = (LanguageUtil.GetLocaleText)(sectorStageCfg.name)
    ;
    (((self.ui).tex_RestartCount).gameObject):SetActive(self.__hasRestartLimit)
    if self.__hasRestartLimit then
      self.__battleCountLimit = ((ExplorationManager.epCtrl).battleCtrl):GetEpBattleLastCount()
      ;
      ((self.ui).tex_RestartCount):SetIndex(0, tostring(self.__battleCountLimit))
      -- DECOMPILER ERROR at PC99: Confused about usage of register: R6 in 'UnsetPending'

      if self.__battleCountLimit <= 0 then
        ((self.ui).cs_Restart).alpha = 0.4
      else
        -- DECOMPILER ERROR at PC103: Confused about usage of register: R6 in 'UnsetPending'

        ((self.ui).cs_Restart).alpha = 1
      end
    end
    if (ExplorationManager.epCtrl):IsCompleteExploration() then
      ((self.ui).tex_GiveupDes):SetIndex(1)
    else
      ((self.ui).tex_GiveupDes):SetIndex(0)
    end
  else
    (((self.ui).tex_RestartCount).gameObject):SetActive(false)
  end
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

UIBattlePause.__OnClickGiveUp = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.giveUpBattleFunc ~= nil then
    (self.giveUpBattleFunc)()
  end
  AudioManager:PlayAudioById(1082)
end

UIBattlePause.__OnClickRestart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.__hasRestartLimit and self.__battleCountLimit <= 0 then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(171))
    return 
  end
  AudioManager:StopSource(eAudioSourceType.VoiceSource)
  AudioManager:PlayAudioById(1084)
  if self.restartFunc ~= nil then
    (self.restartFunc)()
    self:Hide()
  end
  UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
  UIManager:DeleteWindow(UIWindowTypeID.RichIntro)
  local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if win ~= nil then
    win:StopUseChipEffect()
  end
end

UIBattlePause.__OnClickContinue = function(self)
  -- function num : 0_4 , upvalues : _ENV
  AudioManager:PlayAudioById(1083)
  if self.pauseFunc ~= nil then
    (self.pauseFunc)(false)
    self:Hide()
  end
  local win = UIManager:GetWindow(UIWindowTypeID.BattleCrazyMode)
  if win ~= nil then
    win:OnBattleContinue()
  end
end

UIBattlePause.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIBattlePause

